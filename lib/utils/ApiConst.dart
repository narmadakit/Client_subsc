class ApiConst{
static String MAIN_URL="http://13.232.251.205:8092/api/";
static String SEND_LOGINOTP_URL(String mobileNo){
  return "${MAIN_URL}SendloginOtp?Mobileno=$mobileNo";
}
static String VERIFY_OTP_URL(String mobileNo,String otp){
  return "${MAIN_URL}verifymobileotp?Mobileno=$mobileNo&otp=$otp";
}
static String GET_ALL_CHITS_URL(String mobileNo){
  return "${MAIN_URL}GetSubscriberChitDetails?Mobileno=$mobileNo";
}

static String GET_CHIT_DETAILS_URL(String ticketNo){
  return "${MAIN_URL}GetSubscriberChitDetailsbasedongroupcode?groupcodetickectno=$ticketNo";
}

static String GET_AUCTION_DETAILS(String mobileNo){
  return "${MAIN_URL}GetSubscriberauctionDetails?Mobileno=$mobileNo";
}
static String GET_MAXBID_OFFER(String groupCode, branchName, num auctionMonth,){
  return "${MAIN_URL}getmaxbidoffer?GroupCode=$groupCode&Branchname=$branchName&auctionmonth=$auctionMonth";
}
static String SAVE_BIDOFFER="${MAIN_URL}Savebidoffer";
}