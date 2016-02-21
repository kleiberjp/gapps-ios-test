//
//  DetailsViewController.m
//  gapps
//
//  Created by Kleiber J Perez on 20/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "DetailsViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "NSString+StringExtension.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Generic Functions

-(void)setUpComponents{    
    [self.navigationItem setTitle:self.item.imName.label];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithAverageColorFromImage:self.item.imageApp];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackButton"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backToMain:)];
    backButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem: backButton];

    self.appImgPreview.image = self.item.imageApp;
    [self setupImage];
    
    self.appArtist.text = self.item.imArtist.label;
    self.appPrice.text = ([self.item.imPrice.attributes.amount doubleValue] == 0) ? [NSString getMessageText:@"free"] : self.item.imPrice.attributes.amount;
    self.appCathegory.text = self.item.category.attributes.label;
    self.appDescription.text = self.item.summary.label;
    self.appDescription.lineBreakMode = NSLineBreakByWordWrapping;
    self.appDescription.numberOfLines = 4;
    self.appRights.text = self.item.rights.label;
    
    self.btnOpenOnItunes = [[BFPaperButton alloc] initWithFrame:CGRectMake(self.appPrice.frame.size.width + self.appPrice.frame.origin.x + 40, self.appCathegory.frame.origin.y, 150, 36) raised:YES];
    [self.btnOpenOnItunes setTitle:[NSString getMessageText:@"btn-itunes"] forState:UIControlStateNormal];
    self.btnOpenOnItunes.backgroundColor = [UIColor colorWithAverageColorFromImage:self.item.imageApp];
    [self.btnOpenOnItunes setTitleColor:[UIColor flatWhiteColor] forState:UIControlStateNormal];
    [self.btnOpenOnItunes setTitleColor:[UIColor flatWhiteColorDark] forState:UIControlStateHighlighted];
    //[self.btnOpenOnItunes addTarget:self action:@selector(openAppInItunes:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnOpenOnItunes];
}

-(void) setupImage{
    self.appImgPreview.layer.cornerRadius = self.appImgPreview.frame.size.width/5;
    self.appImgPreview.clipsToBounds = YES;
    self.appImgPreview.contentMode = UIViewContentModeScaleAspectFit;
    self.appImgPreview.backgroundColor = [UIColor whiteColor];
}



#pragma mark - Navigation

-(void)backToMain:(id)sender{
    self.item = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
