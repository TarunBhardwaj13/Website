public class Loan{
      public double loanAmount;
      public int numberOfYears;
      public double annualInterestRate;
      public double monthlyInterestRate;
      public double monthlyPayment;
      public double totalPayment;

      public Loan(double annualInterestRate, int numberOfYears, double loanAmount){
       this.annualInterestRate  = annualInterestRate;
       this.numberOfYears = numberOfYears;
       this.loanAmount = loanAmount;
      }
      public void getMonthlyInterestRate(){
       monthlyInterestRate = annualInterestRate / 12;
      }
      public double getMonthlyPayment(){
        getMonthlyInterestRate();
        return monthlyPayment = loanAmount * monthlyInterestRate / (1 - 1 / Math.pow(1 + monthlyInterestRate, numberOfYears * 12));
      }
      public double getTotalPayment(){
        return monthlyPayment * numberOfYears * 12;
      }
   }
