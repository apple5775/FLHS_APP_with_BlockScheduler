//
//  SchedInfoViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 8/13/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import "SchedInfoViewController.h"
#import "SWRevealViewController.h"

@interface SchedInfoViewController () {
    BOOL cG1;
    BOOL cG2;
    BOOL cG3;
    BOOL cG4;
    BOOL cG5;
    BOOL cG6;
    BOOL cG7;
    BOOL cG8;
    
    BOOL oChange1;
    BOOL oChange2;
    BOOL oChange3;
    BOOL oChange4;
    BOOL oChange5;
    BOOL oChange6;
    BOOL oChange7;
    BOOL oChange8;
    
    BOOL specialB;
    
    BOOL lunchEvery;
    
    BOOL isQ;
    
    NSArray *pickerDays;
    
}

@property (weak, nonatomic) IBOutlet UITextField *ocText8;
@property (weak, nonatomic) IBOutlet UITextField *ocText7;
@property (weak, nonatomic) IBOutlet UITextField *ocText6;
@property (weak, nonatomic) IBOutlet UITextField *ocText5;
@property (weak, nonatomic) IBOutlet UITextField *ocText4;
@property (weak, nonatomic) IBOutlet UITextField *ocText3;
@property (weak, nonatomic) IBOutlet UITextField *ocText2;
@property (weak, nonatomic) IBOutlet UITextField *ocText1;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch8;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch7;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch6;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch5;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch4;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch3;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch2;
@property (weak, nonatomic) IBOutlet UISwitch *oSwitch1;
@property (weak, nonatomic) IBOutlet UITextField *oText8;
@property (weak, nonatomic) IBOutlet UITextField *oText7;
@property (weak, nonatomic) IBOutlet UITextField *oText6;
@property (weak, nonatomic) IBOutlet UITextField *oText5;
@property (weak, nonatomic) IBOutlet UITextField *oText4;
@property (weak, nonatomic) IBOutlet UITextField *oText3;
@property (weak, nonatomic) IBOutlet UITextField *oText2;
@property (weak, nonatomic) IBOutlet UITextField *oText1;
@property (weak, nonatomic) IBOutlet UISwitch *lunchDaySwitch;
@property (weak, nonatomic) IBOutlet UITextField *l3Text;
@property (weak, nonatomic) IBOutlet UITextField *l2Text;
@property (weak, nonatomic) IBOutlet UITextField *l1Text;
@property (weak, nonatomic) IBOutlet UILabel *lunch3Label;
@property (weak, nonatomic) IBOutlet UILabel *lunch2Label;
@property (weak, nonatomic) IBOutlet UILabel *lunch1Label;
@property (weak, nonatomic) IBOutlet UITextField *f8Text;
@property (weak, nonatomic) IBOutlet UITextField *f7Text;
@property (weak, nonatomic) IBOutlet UITextField *f6Text;
@property (weak, nonatomic) IBOutlet UITextField *f5Text;
@property (weak, nonatomic) IBOutlet UITextField *f4Text;
@property (weak, nonatomic) IBOutlet UITextField *f3Text;
@property (weak, nonatomic) IBOutlet UITextField *f2Text;
@property (weak, nonatomic) IBOutlet UITextField *f1Text;
//@property (weak, nonatomic) IBOutlet UITextField *DateText;
@property (weak, nonatomic) IBOutlet UITextField *gText8;
@property (weak, nonatomic) IBOutlet UITextField *gText7;
@property (weak, nonatomic) IBOutlet UITextField *gText6;
@property (weak, nonatomic) IBOutlet UITextField *gText5;
@property (weak, nonatomic) IBOutlet UITextField *gText4;
@property (weak, nonatomic) IBOutlet UITextField *gText3;
@property (weak, nonatomic) IBOutlet UITextField *gText2;
@property (weak, nonatomic) IBOutlet UITextField *gText1;
@property (weak, nonatomic) IBOutlet UISwitch *c8Switch;
@property (weak, nonatomic) IBOutlet UISwitch *c7Switch;
@property (weak, nonatomic) IBOutlet UISwitch *c6Switch;
@property (weak, nonatomic) IBOutlet UISwitch *c5Switch;
@property (weak, nonatomic) IBOutlet UISwitch *c4Switch;
@property (weak, nonatomic) IBOutlet UISwitch *c3Switch;
@property (weak, nonatomic) IBOutlet UISwitch *c2Switch;
@property (weak, nonatomic) IBOutlet UISwitch *c1Switch;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UITextField *course8;
@property (weak, nonatomic) IBOutlet UITextField *course7;
@property (weak, nonatomic) IBOutlet UITextField *course6;
@property (weak, nonatomic) IBOutlet UITextField *course5;
@property (weak, nonatomic) IBOutlet UITextField *course4;
@property (weak, nonatomic) IBOutlet UITextField *course3;
@property (weak, nonatomic) IBOutlet UITextField *course2;
@property (weak, nonatomic) IBOutlet UITextField *course1;
@property (weak, nonatomic) IBOutlet UISwitch *special;
- (IBAction)indexChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *q1;
@property (weak, nonatomic) IBOutlet UILabel *q2;
@property (weak, nonatomic) IBOutlet UILabel *q3;
@property (weak, nonatomic) IBOutlet UILabel *q4;
@property (weak, nonatomic) IBOutlet UILabel *q5;
@property (weak, nonatomic) IBOutlet UILabel *q6;
@property (weak, nonatomic) IBOutlet UIPickerView *pick;
@end

@implementation SchedInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)question
{
    if (isQ) {
        _q1.alpha = 1;
        _q2.alpha = 1;
        _q3.alpha = 1;
        _q4.alpha = 1;
        _q5.alpha = 1;
        _q6.alpha = 1;
        isQ = false;
    }else{
        _q1.alpha = 0;
        _q2.alpha = 0;
        _q3.alpha = 0;
        _q4.alpha = 0;
        _q5.alpha = 0;
        _q6.alpha = 0;
        isQ = true;
    }

}

-(IBAction)doneSelect:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"doneB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            [defaults setInteger:1 forKey:@"lunchNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case 1:
            [defaults setInteger:2 forKey:@"lunchNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case 2:
            [defaults setInteger:3 forKey:@"lunchNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        default:
            break; 
    }
}

-(void)adjustViewWithSwitch1:(UISwitch *)sw textField:(UITextField *)text fTextField:(UITextField *)fText gTextField:(UITextField *)gText hasGym:(BOOL)g oTextField:(UITextField *)oText oSwitch:(UISwitch *)oSw isRotate:(BOOL)r changeText:(UITextField *)ocText{
    
    if (g == true) {
        gText.userInteractionEnabled = true;
        fText.userInteractionEnabled = true;
    }else {
        gText.userInteractionEnabled = false;
        gText.text = @"";
        fText.userInteractionEnabled = false;
        fText.text = @"";
    }
}

-(void)adjustViewWithSwitch2:(UISwitch *)sw textField:(UITextField *)text fTextField:(UITextField *)fText gTextField:(UITextField *)gText hasGym:(BOOL)g oTextField:(UITextField *)oText oSwitch:(UISwitch *)oSw isRotate:(BOOL)r changeText:(UITextField *)ocText{
    
    if (r == true) {
        ocText.userInteractionEnabled = true;
        oText.userInteractionEnabled = true;
    }else{
        oText.userInteractionEnabled = false;
        oText.text = @"Alternate?";
        ocText.userInteractionEnabled = false;
        ocText.text = @"";
    }
}


-(void) makeAdjustments {
    if(cG1){
        [self adjustViewWithSwitch1:_c1Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:true oTextField:_oText1 oSwitch:_oSwitch1 isRotate:_oSwitch1.isOn changeText:_ocText1];
        _c1Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c1Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:false oTextField:_oText1 oSwitch:_oSwitch1 isRotate:_oSwitch1.isOn changeText:_ocText1];
        _c1Switch.on = false;
    }
    if(cG2){
        [self adjustViewWithSwitch1:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:true oTextField:_oText2 oSwitch:_oSwitch2 isRotate:_oSwitch2.isOn changeText:_ocText2];
        _c2Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:false oTextField:_oText2 oSwitch:_oSwitch2 isRotate:_oSwitch2.isOn changeText:_ocText2];
        _c2Switch.on = false;
    }
    if(cG3){
        [self adjustViewWithSwitch1:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:true oTextField:_oText3 oSwitch:_oSwitch3 isRotate:_oSwitch3.isOn changeText:_ocText3];
        _c3Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:false oTextField:_oText3 oSwitch:_oSwitch3 isRotate:_oSwitch3.isOn changeText:_ocText3];
        _c3Switch.on = false;
    }
    if(cG4){
        [self adjustViewWithSwitch1:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:true oTextField:_oText4 oSwitch:_oSwitch4 isRotate:_oSwitch4.isOn changeText:_ocText4];
        _c4Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:false oTextField:_oText4 oSwitch:_oSwitch4 isRotate:_oSwitch4.isOn changeText:_ocText4];
        _c4Switch.on = false;
    }
    if(cG5){
        [self adjustViewWithSwitch1:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:true oTextField:_oText5 oSwitch:_oSwitch5 isRotate:_oSwitch5.isOn changeText:_ocText5];
        _c5Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:false oTextField:_oText5 oSwitch:_oSwitch5 isRotate:_oSwitch5.isOn changeText:_ocText5];
        _c5Switch.on = false;
    }
    if(cG6){
        [self adjustViewWithSwitch1:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:true oTextField:_oText6 oSwitch:_oSwitch6 isRotate:_oSwitch6.isOn changeText:_ocText6];
        _c6Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:false oTextField:_oText6 oSwitch:_oSwitch6 isRotate:_oSwitch6.isOn changeText:_ocText6];
        _c6Switch.on = false;
    }
    if(cG7){
        [self adjustViewWithSwitch1:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:true oTextField:_oText7 oSwitch:_oSwitch7 isRotate:_oSwitch7.isOn changeText:_ocText7];
        _c7Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:false oTextField:_oText7 oSwitch:_oSwitch7 isRotate:_oSwitch7.isOn changeText:_ocText7];
        _c7Switch.on = false;
    }
    if(cG8){
        [self adjustViewWithSwitch1:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:true oTextField:_oText8 oSwitch:_oSwitch8 isRotate:_oSwitch8.isOn changeText:_ocText8];
        _c8Switch.on = true;
    } else{
        [self adjustViewWithSwitch1:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:false oTextField:_oText8 oSwitch:_oSwitch8 isRotate:_oSwitch8.isOn changeText:_ocText8];
        _c8Switch.on = false;
    }
    
    
    if(oChange1){
        [self adjustViewWithSwitch2:_c1Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:_c1Switch.isOn oTextField:_oText1 oSwitch:_oSwitch1 isRotate:true changeText:_ocText1];
        _oSwitch1.on = true;
    } else{
        [self adjustViewWithSwitch2:_c1Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:_c1Switch.isOn oTextField:_oText1 oSwitch:_oSwitch1 isRotate:false changeText:_ocText1];
        _oSwitch1.on = false;
    }
    if(oChange2){
        [self adjustViewWithSwitch2:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:_c2Switch.isOn oTextField:_oText2 oSwitch:_oSwitch2 isRotate:true changeText:_ocText2];
        _oSwitch2.on = true;
    } else{
        [self adjustViewWithSwitch2:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:_c2Switch.isOn oTextField:_oText2 oSwitch:_oSwitch2 isRotate:false changeText:_ocText2];
        _oSwitch2.on = false;
    }
    if(oChange3){
        [self adjustViewWithSwitch2:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:_c3Switch.isOn oTextField:_oText3 oSwitch:_oSwitch3 isRotate:true changeText:_ocText3];
        _oSwitch3.on = true;
    } else{
        [self adjustViewWithSwitch2:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:_c3Switch.isOn oTextField:_oText3 oSwitch:_oSwitch3 isRotate:false changeText:_ocText3];
        _oSwitch3.on = false;
    }
    if(oChange4){
        [self adjustViewWithSwitch2:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:_c4Switch.isOn oTextField:_oText4 oSwitch:_oSwitch4 isRotate:true changeText:_ocText4];
        _oSwitch4.on = true;
    } else{
        [self adjustViewWithSwitch2:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:_c4Switch.isOn oTextField:_oText4 oSwitch:_oSwitch4 isRotate:false changeText:_ocText4];
        _oSwitch4.on = false;
    }
    if(oChange5){
        [self adjustViewWithSwitch2:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:_c5Switch.isOn oTextField:_oText5 oSwitch:_oSwitch5 isRotate:true changeText:_ocText5];
        _oSwitch5.on = true;
    } else{
        [self adjustViewWithSwitch2:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:_c5Switch.isOn oTextField:_oText5 oSwitch:_oSwitch5 isRotate:false changeText:_ocText5];
        _oSwitch5.on = false;
    }
    if(oChange6){
        [self adjustViewWithSwitch2:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:_c6Switch.isOn oTextField:_oText6 oSwitch:_oSwitch6 isRotate:true changeText:_ocText6];
        _oSwitch6.on = true;
    } else{
        [self adjustViewWithSwitch2:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:_c6Switch.isOn oTextField:_oText6 oSwitch:_oSwitch6 isRotate:false changeText:_ocText6];
        _oSwitch6.on = false;
    }
    if(oChange7){
        [self adjustViewWithSwitch2:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:_c7Switch.isOn oTextField:_oText7 oSwitch:_oSwitch7 isRotate:true changeText:_ocText7];
        _oSwitch7.on = true;
    } else{
        [self adjustViewWithSwitch2:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:_c7Switch.isOn oTextField:_oText7 oSwitch:_oSwitch7 isRotate:false changeText:_ocText7];
        _oSwitch7.on = false;
    }
    if(oChange8){
        [self adjustViewWithSwitch2:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:_c8Switch.isOn oTextField:_oText8 oSwitch:_oSwitch8 isRotate:true changeText:_ocText8];
        _oSwitch8.on = true;
    } else{
        [self adjustViewWithSwitch2:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:_c8Switch.isOn oTextField:_oText8 oSwitch:_oSwitch8 isRotate:false changeText:_ocText8];
        _oSwitch8.on = false;
    }
}


-(void)viewWillDisappear:(BOOL)animated{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *dateTextS = [self pickerView:self.pick titleForRow:[self.pick selectedRowInComponent:0] forComponent:0];
    [defaults setValue:dateTextS forKey:@"mainDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setValue:self.oText1.text forKey:@"oText 1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.oText2.text forKey:@"oText 2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.oText3.text forKey:@"oText 3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.oText4.text forKey:@"oText 4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.oText5.text forKey:@"oText 5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.oText6.text forKey:@"oText 6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.oText7.text forKey:@"oText 7"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.oText8.text forKey:@"oText 8"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setValue:self.course1.text forKey:@"Course 1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.course2.text forKey:@"Course 2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.course3.text forKey:@"Course 3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.course4.text forKey:@"Course 4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.course5.text forKey:@"Course 5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.course6.text forKey:@"Course 6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.course7.text forKey:@"Course 7"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.course8.text forKey:@"Course 8"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setValue:self.gText1.text forKey:@"gText 1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.gText2.text forKey:@"gText 2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.gText3.text forKey:@"gText 3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.gText4.text forKey:@"gText 4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.gText5.text forKey:@"gText 5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.gText6.text forKey:@"gText 6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.gText7.text forKey:@"gText 7"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.gText8.text forKey:@"gText 8"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setValue:self.l1Text.text forKey:@"lunchE 1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.l2Text.text forKey:@"lunchE 2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.l3Text.text forKey:@"lunchE 3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setValue:self.f1Text.text forKey:@"fText 1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.f2Text.text forKey:@"fText 2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.f3Text.text forKey:@"fText 3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.f4Text.text forKey:@"fText 4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.f5Text.text forKey:@"fText 5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.f6Text.text forKey:@"fText 6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.f7Text.text forKey:@"fText 7"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.f8Text.text forKey:@"fText 8"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setValue:self.ocText1.text forKey:@"ocText 1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.ocText2.text forKey:@"ocText 2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.ocText3.text forKey:@"ocText 3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.ocText4.text forKey:@"ocText 4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.ocText5.text forKey:@"ocText 5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.ocText6.text forKey:@"ocText 6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.ocText7.text forKey:@"ocText 7"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setValue:self.ocText8.text forKey:@"ocText 8"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setBool:cG1 forKey:@"CG1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:cG2 forKey:@"CG2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:cG3 forKey:@"CG3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:cG4 forKey:@"CG4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:cG5 forKey:@"CG5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:cG6 forKey:@"CG6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:cG7 forKey:@"CG7"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:cG8 forKey:@"CG8"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setBool:specialB forKey:@"specialB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setBool:oChange1 forKey:@"OC1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:oChange2 forKey:@"OC2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:oChange3 forKey:@"OC3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:oChange4 forKey:@"OC4"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:oChange5 forKey:@"OC5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:oChange6 forKey:@"OC6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:oChange7 forKey:@"OC7"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setBool:oChange8 forKey:@"OC8"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [defaults setBool:lunchEvery forKey:@"lEvery"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    isQ = false;
    [self question];
    
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"?" style:UIBarButtonItemStylePlain target:self action:@selector(question)];
    
    if (myIndex == 0) {
        _doneButton.alpha = 0;
        _doneButton.userInteractionEnabled = false;
        
        self.navigationItem.leftBarButtonItem = _sidebarButton;
        // Set the side bar button action. When it's tapped, it'll show up the sidebar.
        _sidebarButton.target = self.revealViewController;
        _sidebarButton.action = @selector(revealToggle:);
        
        // Set the gesture
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    NSString *ds = [[NSUserDefaults standardUserDefaults]valueForKey:@"mainDate"];
    if ([pickerDays containsObject:ds]){
         [self.pick selectRow:[pickerDays indexOfObject:ds] inComponent:0 animated:NO];
    }
   
    self.oText1.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 1"];
    self.oText2.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 2"];
    self.oText3.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 3"];
    self.oText4.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 4"];
    self.oText5.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 5"];
    self.oText6.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 6"];
    self.oText7.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 7"];
    self.oText8.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 8"];
    
    self.course1.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 1"];
    self.course2.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 2"];
    self.course3.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 3"];
    self.course4.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 4"];
    self.course5.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 5"];
    self.course6.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 6"];
    self.course7.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 7"];
    self.course8.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"Course 8"];
    
    self.gText1.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 1"];
    self.gText2.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 2"];
    self.gText3.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 3"];
    self.gText4.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 4"];
    self.gText5.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 5"];
    self.gText6.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 6"];
    self.gText7.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 7"];
    self.gText8.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 8"];
    
    self.l1Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"lunchE 1"];
    self.l2Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"lunchE 2"];
    self.l3Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"lunchE 3"];
    
    self.f1Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 1"];
    self.f2Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 2"];
    self.f3Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 3"];
    self.f4Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 4"];
    self.f5Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 5"];
    self.f6Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 6"];
    self.f7Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 7"];
    self.f8Text.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 8"];
    
    self.ocText1.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 1"];
    self.ocText2.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 2"];
    self.ocText3.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 3"];
    self.ocText4.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 4"];
    self.ocText5.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 5"];
    self.ocText6.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 6"];
    self.ocText7.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 7"];
    self.ocText8.text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 8"];
    
    cG1 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG1"];
    cG2 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG2"];
    cG3 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG3"];
    cG4 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG4"];
    cG5 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG5"];
    cG6 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG6"];
    cG7 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG7"];
    cG8 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG8"];
    
    specialB = [[NSUserDefaults standardUserDefaults] boolForKey: @"specialB"];
    
    oChange1 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC1"];
    oChange2 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC2"];
    oChange3 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC3"];
    oChange4 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC4"];
    oChange5 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC5"];
    oChange6 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC6"];
    oChange7 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC7"];
    oChange8 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC8"];
    
    lunchEvery = [[NSUserDefaults standardUserDefaults] boolForKey: @"lEvery"];
    
    if(lunchEvery){
        _lunchDaySwitch.on = true;
        _segmentedControl.alpha = 1;
        _segmentedControl.userInteractionEnabled = true;
        _l1Text.alpha = 0;
        _l2Text.alpha = 0;
        _l3Text.alpha = 0;
        _l1Text.text = @"";
        _l2Text.text = @"";
        _l3Text.text = @"";
        _l1Text.userInteractionEnabled = false;
        _l2Text.userInteractionEnabled = false;
        _l3Text.userInteractionEnabled = false;
        _lunch1Label.alpha = 0;
        _lunch2Label.alpha = 0;
        _lunch3Label.alpha = 0;
    } else{
        _lunchDaySwitch.on = false;
        _segmentedControl.alpha = 0;
        _segmentedControl.userInteractionEnabled = false;
        _l1Text.alpha = 1;
        _l2Text.alpha = 1;
        _l3Text.alpha = 1;
        _l1Text.userInteractionEnabled = true;
        _l2Text.userInteractionEnabled = true;
        _l3Text.userInteractionEnabled = true;
        _lunch1Label.alpha = 1;
        _lunch2Label.alpha = 1;
        _lunch3Label.alpha = 1;
    }
    
    if (specialB) {
        _special.on = true;
    }else{
        _special.on = false;
    }
    
    [self makeAdjustments];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pickerDays = @[@"Normal",@"A",@"B",@"C",@"D",@"E",@"1",@"2",@"3",@"4",@"5",@"Weekend",@"Adv",@"Col",@"1HD",@"2HD"];
    self.pick.dataSource = self;
    self.pick.delegate = self;
    
    self.title = @"Schedule Settings";
    [self.segmentedControl setSelectedSegmentIndex:((int)[[NSUserDefaults standardUserDefaults] integerForKey: @"lunchNum"])-1];
    
    [_scroll setScrollEnabled:YES];
    
    [_scroll setContentSize:CGSizeMake(self.view.frame.size.width, 1500)];
    
    [self makeAdjustments];
    
    [self.c1Switch addTarget:self
                      action:@selector(changeSwitch1:) forControlEvents:UIControlEventValueChanged];
    [self.c2Switch addTarget:self
                      action:@selector(changeSwitch2:) forControlEvents:UIControlEventValueChanged];
    [self.c3Switch addTarget:self
                      action:@selector(changeSwitch3:) forControlEvents:UIControlEventValueChanged];
    [self.c4Switch addTarget:self
                      action:@selector(changeSwitch4:) forControlEvents:UIControlEventValueChanged];
    [self.c5Switch addTarget:self
                      action:@selector(changeSwitch5:) forControlEvents:UIControlEventValueChanged];
    [self.c6Switch addTarget:self
                      action:@selector(changeSwitch6:) forControlEvents:UIControlEventValueChanged];
    [self.c7Switch addTarget:self
                      action:@selector(changeSwitch7:) forControlEvents:UIControlEventValueChanged];
    [self.c8Switch addTarget:self
                      action:@selector(changeSwitch8:) forControlEvents:UIControlEventValueChanged];
    
    [self.oSwitch1 addTarget:self
                      action:@selector(changeOSwitch1:) forControlEvents:UIControlEventValueChanged];
    [self.oSwitch2 addTarget:self
                      action:@selector(changeOSwitch2:) forControlEvents:UIControlEventValueChanged];
    [self.oSwitch3 addTarget:self
                      action:@selector(changeOSwitch3:) forControlEvents:UIControlEventValueChanged];
    [self.oSwitch4 addTarget:self
                      action:@selector(changeOSwitch4:) forControlEvents:UIControlEventValueChanged];
    [self.oSwitch5 addTarget:self
                      action:@selector(changeOSwitch5:) forControlEvents:UIControlEventValueChanged];
    [self.oSwitch6 addTarget:self
                      action:@selector(changeOSwitch6:) forControlEvents:UIControlEventValueChanged];
    [self.oSwitch7 addTarget:self
                      action:@selector(changeOSwitch7:) forControlEvents:UIControlEventValueChanged];
    [self.oSwitch8 addTarget:self
                      action:@selector(changeOSwitch8:) forControlEvents:UIControlEventValueChanged];
    
    [self.lunchDaySwitch addTarget:self
                            action:@selector(changeSwitchL:) forControlEvents:UIControlEventValueChanged];
    
    [self.special addTarget:self action:@selector(changeSpecial:) forControlEvents:UIControlEventValueChanged];
    
}

// The number of columns of data
- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (long)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerDays.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerDays[row];
}
    

-(void)changeSpecial:(id)sender{
    if([sender isOn]){
        specialB = true;
    } else{
        specialB = false;
    }
}

- (void)changeSwitchL:(id)sender{
    if([sender isOn]){
        lunchEvery = true;
        _segmentedControl.alpha = 1;
        _segmentedControl.userInteractionEnabled = true;
        _l1Text.alpha = 0;
        _l2Text.alpha = 0;
        _l3Text.alpha = 0;
        _l1Text.text = @"";
        _l2Text.text = @"";
        _l3Text.text = @"";
        _l1Text.userInteractionEnabled = false;
        _l2Text.userInteractionEnabled = false;
        _l3Text.userInteractionEnabled = false;
        _lunch1Label.alpha = 0;
        _lunch2Label.alpha = 0;
        _lunch3Label.alpha = 0;
    } else{
        lunchEvery = false;
        _segmentedControl.alpha = 0;
        _segmentedControl.userInteractionEnabled = false;
        _l1Text.alpha = 1;
        _l2Text.alpha = 1;
        _l3Text.alpha = 1;
        _l1Text.userInteractionEnabled = true;
        _l2Text.userInteractionEnabled = true;
        _l3Text.userInteractionEnabled = true;
        _lunch1Label.alpha = 1;
        _lunch2Label.alpha = 1;
        _lunch3Label.alpha = 1;
    }
}


- (void)changeSwitch1:(id)sender{
    if([sender isOn]){
        cG1 = true;
        [self adjustViewWithSwitch1:_c1Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:true oTextField:_oText1 oSwitch:_oSwitch1 isRotate:_oSwitch1.isOn changeText:_ocText1];
    } else{
        cG1 = false;
        [self adjustViewWithSwitch1:_c1Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:false oTextField:_oText1 oSwitch:_oSwitch1 isRotate:_oSwitch1.isOn changeText:_ocText1];
    }
}

- (void)changeSwitch2:(id)sender{
    if([sender isOn]){
        cG2 = true;
        [self adjustViewWithSwitch1:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:true oTextField:_oText2 oSwitch:_oSwitch2 isRotate:_oSwitch2.isOn changeText:_ocText2];
    } else{
        cG2 = false;
        [self adjustViewWithSwitch1:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:false oTextField:_oText2 oSwitch:_oSwitch2 isRotate:_oSwitch2.isOn changeText:_ocText2];
    }
}
- (void)changeSwitch3:(id)sender{
    if([sender isOn]){
        cG3 = true;
        [self adjustViewWithSwitch1:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:true oTextField:_oText3 oSwitch:_oSwitch3 isRotate:_oSwitch3.isOn changeText:_ocText3];
    } else{
        cG3 = false;
        [self adjustViewWithSwitch1:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:false oTextField:_oText3 oSwitch:_oSwitch3 isRotate:_oSwitch3.isOn changeText:_ocText3];
    }
}
- (void)changeSwitch4:(id)sender{
    if([sender isOn]){
        cG4 = true;
        [self adjustViewWithSwitch1:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:true oTextField:_oText4 oSwitch:_oSwitch4 isRotate:_oSwitch4.isOn changeText:_ocText4];
    } else{
        cG4 = false;
        [self adjustViewWithSwitch1:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:false oTextField:_oText4 oSwitch:_oSwitch4 isRotate:_oSwitch4.isOn changeText:_ocText4];
    }
}
- (void)changeSwitch5:(id)sender{
    if([sender isOn]){
        cG5 = true;
        [self adjustViewWithSwitch1:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:true oTextField:_oText5 oSwitch:_oSwitch5 isRotate:_oSwitch5.isOn changeText:_ocText5];
    } else{
        cG5 = false;
        [self adjustViewWithSwitch1:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:false oTextField:_oText5 oSwitch:_oSwitch5 isRotate:_oSwitch5.isOn changeText:_ocText5];
    }
}
- (void)changeSwitch6:(id)sender{
    if([sender isOn]){
        cG6 = true;
        [self adjustViewWithSwitch1:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:true oTextField:_oText6 oSwitch:_oSwitch6 isRotate:_oSwitch6.isOn changeText:_ocText6];
    } else{
        cG6 = false;
        [self adjustViewWithSwitch1:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:false oTextField:_oText6 oSwitch:_oSwitch6 isRotate:_oSwitch6.isOn changeText:_ocText6];
    }
}
- (void)changeSwitch7:(id)sender{
    if([sender isOn]){
        cG7 = true;
        [self adjustViewWithSwitch1:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:true oTextField:_oText7 oSwitch:_oSwitch7 isRotate:_oSwitch7.isOn changeText:_ocText7];
    } else{
        cG7 = false;
        [self adjustViewWithSwitch1:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:false oTextField:_oText7 oSwitch:_oSwitch7 isRotate:_oSwitch7.isOn changeText:_ocText7];
    }
}
- (void)changeSwitch8:(id)sender{
    if([sender isOn]){
        cG8 = true;
        [self adjustViewWithSwitch1:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:true oTextField:_oText8 oSwitch:_oSwitch8 isRotate:_oSwitch8.isOn changeText:_ocText8];
    } else{
        cG8 = false;
        [self adjustViewWithSwitch1:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:false oTextField:_oText8 oSwitch:_oSwitch8 isRotate:_oSwitch8.isOn changeText:_ocText8];
    }
}

- (void)changeOSwitch1:(id)sender{
    if([sender isOn]){
        oChange1 = true;
        [self adjustViewWithSwitch2:_c2Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:_c1Switch.isOn oTextField:_oText1 oSwitch:_oSwitch1 isRotate:true changeText:_ocText1];
    } else{
        oChange1 = false;
        [self adjustViewWithSwitch2:_c2Switch textField:_course1 fTextField:_f1Text gTextField:_gText1 hasGym:_c1Switch.isOn oTextField:_oText1 oSwitch:_oSwitch1 isRotate:false changeText:_ocText1];
    }
}
- (void)changeOSwitch2:(id)sender{
    if([sender isOn]){
        oChange2 = true;
        [self adjustViewWithSwitch2:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:_c2Switch.isOn oTextField:_oText2 oSwitch:_oSwitch2 isRotate:true changeText:_ocText2];
    } else{
        oChange2 = false;
        [self adjustViewWithSwitch2:_c2Switch textField:_course2 fTextField:_f2Text gTextField:_gText2 hasGym:_c2Switch.isOn oTextField:_oText2 oSwitch:_oSwitch2 isRotate:false changeText:_ocText2];
    }
}
- (void)changeOSwitch3:(id)sender{
    if([sender isOn]){
        oChange3 = true;
        [self adjustViewWithSwitch2:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:_c3Switch.isOn oTextField:_oText3 oSwitch:_oSwitch3 isRotate:true changeText:_ocText3];
    } else{
        oChange3 = false;
        [self adjustViewWithSwitch2:_c3Switch textField:_course3 fTextField:_f3Text gTextField:_gText3 hasGym:_c3Switch.isOn oTextField:_oText3 oSwitch:_oSwitch3 isRotate:false changeText:_ocText3];
    }
}
- (void)changeOSwitch4:(id)sender{
    if([sender isOn]){
        oChange4 = true;
        [self adjustViewWithSwitch2:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:_c4Switch.isOn oTextField:_oText4 oSwitch:_oSwitch4 isRotate:true changeText:_ocText4];
    } else{
        oChange4 = false;
        [self adjustViewWithSwitch2:_c4Switch textField:_course4 fTextField:_f4Text gTextField:_gText4 hasGym:_c4Switch.isOn oTextField:_oText4 oSwitch:_oSwitch4 isRotate:false changeText:_ocText4];
    }
}
- (void)changeOSwitch5:(id)sender{
    if([sender isOn]){
        oChange5 = true;
        [self adjustViewWithSwitch2:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:_c5Switch.isOn oTextField:_oText5 oSwitch:_oSwitch5 isRotate:true changeText:_ocText5];
    } else{
        oChange5 = false;
        [self adjustViewWithSwitch2:_c5Switch textField:_course5 fTextField:_f5Text gTextField:_gText5 hasGym:_c5Switch.isOn oTextField:_oText5 oSwitch:_oSwitch5 isRotate:false changeText:_ocText5];
    }
}
- (void)changeOSwitch6:(id)sender{
    if([sender isOn]){
        oChange6 = true;
        [self adjustViewWithSwitch2:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:_c6Switch.isOn oTextField:_oText6 oSwitch:_oSwitch6 isRotate:true changeText:_ocText6];
    } else{
        oChange6 = false;
        [self adjustViewWithSwitch2:_c6Switch textField:_course6 fTextField:_f6Text gTextField:_gText6 hasGym:_c6Switch.isOn oTextField:_oText6 oSwitch:_oSwitch6 isRotate:false changeText:_ocText6];
    }
}
- (void)changeOSwitch7:(id)sender{
    if([sender isOn]){
        oChange7 = true;
        [self adjustViewWithSwitch2:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:_c7Switch.isOn oTextField:_oText7 oSwitch:_oSwitch7 isRotate:true changeText:_ocText7];
    } else{
        oChange7 = false;
        [self adjustViewWithSwitch2:_c7Switch textField:_course7 fTextField:_f7Text gTextField:_gText7 hasGym:_c7Switch.isOn oTextField:_oText7 oSwitch:_oSwitch7 isRotate:false changeText:_ocText7];
    }
}
- (void)changeOSwitch8:(id)sender{
    if([sender isOn]){
        oChange8 = true;
        [self adjustViewWithSwitch2:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:_c8Switch.isOn oTextField:_oText8 oSwitch:_oSwitch8 isRotate:true changeText:_ocText8];
    } else{
        oChange8 = false;
        [self adjustViewWithSwitch2:_c8Switch textField:_course8 fTextField:_f8Text gTextField:_gText8 hasGym:_c8Switch.isOn oTextField:_oText8 oSwitch:_oSwitch8 isRotate:false changeText:_ocText8];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
 
@end
