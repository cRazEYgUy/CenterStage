#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <MessageUI/MFMailComposeViewController.h>
#define EMAIL_SUBJECT @"CenterStage Beta Support"

int width = [[UIScreen mainScreen] bounds].size.width;

@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(id)arg1;

@optional
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1;
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 inTableView:(id)arg2;
@end

@interface centerstageprefsListController: PSListController <MFMailComposeViewControllerDelegate> 
- (void)supportEmail;
@end

@implementation centerstageprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"centerstageprefs" target:self] retain];
	}
	return _specifiers;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)donate{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=9ZXVHGA5AW5CG&lc=AU&item_name=GreenyDev&currency_code=AUD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"]];
}

- (void)supportEmail{
    MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
    [email setSubject:@"CenterStage Beta Support"];
    [email setToRecipients:[NSArray arrayWithObjects:@"greenydev@greenmail.net.au", nil]];
    [self.navigationController presentViewController:email animated:YES completion:nil];
    email.mailComposeDelegate = self;
    [email release];
}
@end

@interface DataManagerCustomCell : PSTableCell <PreferencesTableCustomView> {
	UILabel *_label;
}
@end

@interface PSTableCell (CenterStage)
- (id)initWithStyle:(int)style reuseIdentifier:(id)arg2;
@end

@implementation DataManagerCustomCell
- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = CGRectMake(0, -15, self.frame.size.width, 60);
}

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	if (self) {
		CGRect frame = CGRectMake(0, -15, width, 60);
        self.backgroundColor = [UIColor clearColor];
 
		_label = [[UILabel alloc] initWithFrame:frame];
		[_label setNumberOfLines:1];
		_label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:48];
		[_label setText:@"CenterStage"];
		[_label setBackgroundColor:[UIColor clearColor]];
		_label.textColor = [UIColor blackColor];
		_label.textAlignment = NSTextAlignmentCenter;
 
		[self addSubview:_label];
	}
	return self;
}
 
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
	CGFloat prefHeight =45.0;
	return prefHeight;
}
@end