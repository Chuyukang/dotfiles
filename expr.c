#include "nemu.h"

/* We use the POSIX regex functions to process regular expressions.
 * Type 'man regex' for more information about POSIX regex functions.
 */
#include <sys/types.h>
#include <regex.h>
#include <stdlib.h>

enum {
  TK_NOTYPE = 256, TK_EQ,

  /* TODO: Add more token types */
  TK_NUM,TK_REG
  /*使用单字符本身的值代表对应的符号类型
   *包括 '+', '-', '*', '/', '(', ')'，取值在0-127
   * 暂不考虑下述情况
   * '*'可能对应于乘法，也可能对应于解引用
   * '-' 可能对应于减法，也可能对应于符号
   */
};

static struct rule {
  char *regex;
  int token_type;
} rules[] = {

  /* TODO: Add more rules.
   * Pay attention to the precedence level of different rules.
   */
  {" +", TK_NOTYPE},    // spaces
  {"\\+", '+'},         // plus
  {"-", '-'},           // minus
  {"\\*", '*'},         // mul
  {"\\/", '/'},         // div
  {"\\(", '('},         //left bracket
  {"\\)", ')'},         //right bracket
  {"==", TK_EQ},        // equal
  {"[0-9]+", TK_NUM},   // digits
  //TODO: 实现表达式中可包含寄存器名称
  //{"\\$[a-z]+",TK_REG}, //reg_name
};

//NR_REGEX 为规则个数，（代表匹配不上的符号
#define NR_REGEX (sizeof(rules) / sizeof(rules[0]) )

static regex_t re[NR_REGEX] = {};

/* Rules are used for many times.
 * Therefore we compile them only once before any usage.
 */
void init_regex() {
  int i;
  char error_msg[128];
  int ret;

  for (i = 0; i < NR_REGEX; i ++) {
    ret = regcomp(&re[i], rules[i].regex, REG_EXTENDED);
    if (ret != 0) {
      regerror(ret, &re[i], error_msg, 128);
      panic("regex compilation failed: %s\n%s", error_msg, rules[i].regex);
    }
  }
}

typedef struct token {
  int type;
  char str[32];
} Token;

static Token tokens[32] __attribute__((used)) = {};
static int nr_token __attribute__((used))  = 0;

static bool make_token(char *e) {
  int position = 0;
  int i;
  regmatch_t pmatch;

  nr_token = 0;

  while (e[position] != '\0') {
    /* Try all rules one by one. */
    for (i = 0; i < NR_REGEX; i ++) {
      //匹配成功
      if (regexec(&re[i], e + position, 1, &pmatch, 0) == 0 && pmatch.rm_so == 0) {
        char *substr_start = e + position;
        int substr_len = pmatch.rm_eo;

        Log("match rules[%d] = \"%s\" at position %d with len %d: %.*s",
            i, rules[i].regex, position, substr_len, substr_len, substr_start);
        position += substr_len;

        /* TODO: Now a new token is recognized with rules[i]. Add codes
         * to record the token in the array `tokens'. For certain types
         * of tokens, some extra actions should be performed.
         */

        switch (rules[i].token_type) {
          case '+':
          case '-':
          case '*':
          case '/':
          case TK_EQ:
          case TK_NUM:
          case TK_REG:
          case TK_NOTYPE:
          default:
            //TODO();
            tokens[nr_token].type=rules[i].token_type;

            int j;
            for(j=0;j<substr_len&&j<31;j++)//设定防止越界
              tokens[nr_token].str[j]=substr_start[j];
            tokens[nr_token].str[j]='\0';
            nr_token++;
        }
        //匹配成功则不再尝试其他匹配规则
        break;
      }
    }

    //未被匹配
    if (i == NR_REGEX) {
      printf("no match at position %d\n%s\n%*.s^\n", position, e, position, "");
      return false;
    }
  }

  return true;
}

bool check_parentheses(int left, int right, bool *success){
  //测试是否整个被括号包围，用于去括号

  int stack[32];//假设表达式长度小于32
  int top=-1;//top为当前栈顶

  bool flag=true;
  if(tokens[left].type!='('||tokens[right].type!=')'){
    flag = false;
  }

  while(left<=right) {//[left, right]
    int tokenType=tokens[left].type;
    if(tokenType=='(') {
      stack[++top]=tokenType;
    } else if(tokenType==')') {
      if(top>-1) {
        int chTop=stack[top];
        if(chTop!='('){
          *success = false;
          return false;
        }
        top--;
      } else {
        *success = false;
        return false;
      }
    }
    left++;
  }

  if(top!=-1){
    *success = false;
    return false;
  }
  else{
    *success = true;
    return flag;//括号符合规则，返回是否头尾均为括号
  }
}
bool isLowerPriority(int a, int b) {
  //a, b 为两个运算符的字符对应int值
  //若a优先级小于b则返回true
  bool ans=true;//后出现的优先级低
  if((a=='*'&&b=='-')||(a=='/'&&b=='-'))
    ans = false;
  if((a=='*'&&b=='+')||(a=='/'&&b=='+'))
    ans = false;
  return ans;
}
inline bool isOp(int tokenType) {
  return tokenType=='+'||tokenType=='-'||tokenType=='*'||tokenType=='/';
}
//根据优先级确定[left,right]区间内token流构成的表达式的主运算符（优先级最低）
int getRootOpIndex(int left, int right) {
  int rootOpIndex=0;
  int i=left;
  //寻找到第一个运算符
  bool flag=false;
  while(i<nr_token) {
    int tokenType=tokens[i].type;
    if(tokenType=='(') {//跳过括号内部
      flag = true;
    }

    if(isOp(tokenType)&&flag==false) {
      rootOpIndex = i;
      break;
    }

    if(tokenType==')'){
      flag = false;
    }
    i++;
  }
  //遍历，根据运算符优先级确定主运算符
  //在遍历时，跳过括号组成的子表达式
  for(;i<=right;i++) {
    //TODO
    int tokenType=tokens[i].type;
    if(tokenType=='(') {//跳过括号内部
      flag = true;
    }

    if(!flag) {//在括号外部
      if(isOp(tokenType)) {
        if(isLowerPriority(tokenType,tokens[rootOpIndex].type)){
            rootOpIndex = i;
        }
      }
    }

    if(tokenType==')'){
      flag = false;
    }
  }
  return rootOpIndex;
}
//计算[left,right]区间内token流构成表达式的值
uint32_t eval(int left, int right, bool *success) {
  //TODO
  if(left==right)//递归基
    return atoi(tokens[left].str);
  //去括号，否则 "(9" 不会命中递归基
  bool flag=check_parentheses(left,right,success);
  if(flag==true&&*success==true)
    return eval(left+1,right-1,success);

  bool leftSuccess=true,rightSuccess=true;
  int rootOpIndex=getRootOpIndex(left, right);
  uint32_t leftValue=eval(left,rootOpIndex-1,&leftSuccess),
           rightValue=eval(rootOpIndex+1,right,&rightSuccess);

  if(leftSuccess==false||rightSuccess==false){
    *success = false;
    return 0;
  }

  uint32_t ans=0;
  switch (tokens[rootOpIndex].type){
    case '+':
      ans = leftValue + rightValue;
      break;
    case '-':
      ans = leftValue - rightValue;
      break;
    case '*':
      ans = leftValue * rightValue;
      break;
    case '/':
      ans = leftValue / rightValue;
      break;
    default:
      ans = 0;
  }
  *success = true;
  return ans;
}

uint32_t expr(char *e, bool *success) {
  if (!make_token(e)) {
    *success = false;
    return 0;
  }
  //解析为token流，在token流上进行解析

  /* TODO: Insert codes to evaluate the expression. */
  return eval(0, nr_token-1,success);
}
