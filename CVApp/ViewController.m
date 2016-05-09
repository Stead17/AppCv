//
//  ViewController.m
//  CVApp
//
//  Created by Ivan on 5/7/16.
//  Copyright © 2016 Ivan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UITableView *tableViewMain;
    UITableView *tableViewID;
    
    UIImageView *profileImage;
    UILabel *hintLabel;
}

@end

@implementation ViewController {
    NSArray *idText;
    NSArray *info;
    NSMutableArray *cellDescriptor;
    
    NSArray *educationRowsData;
    NSArray *experienceRowsData;
    NSArray *langTechRowsData;
    NSArray *contactsRowsData;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self arraysInit];
    [self imagePlacement];
    [self mainTableViewMaker];
    [self IDTableViewMaker];
    [self prefersStatusBarHidden];
    [self hintLabelInit];
    
    
    // Shows only rows with data
    tableViewID.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self loadCellDescriptor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCellDescriptor {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CellDescriptor" ofType:@"plist"];
    if (path != nil) {
        cellDescriptor = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
}

- (void)arraysInit {
    idText = [NSArray arrayWithObjects:@"Ivan", @"Tkachenko", @"27.03.1997", nil];
    info = [NSArray arrayWithObjects:@"Education", @"Additional Experience", @"Language and Technologies", @"Contacts", nil];
    educationRowsData = [NSArray arrayWithObjects:@"NTUU 'KPI'", nil];
    experienceRowsData = [NSArray arrayWithObjects:@"Urban Programming Competion: 14th place", @"Cambridge certificate (2015): Level B2. Grade C.", @"Kyiv Hackathon 2015 – Free Topic", @"Programming Camp – IOS direction", nil];
    langTechRowsData = [NSArray arrayWithObjects:@"C/C++; Objective C; Free Pascal", @"C#; Assembly; Ruby",
                        @"Sublime Text2; XCode;  Xamarin Studio; VIM", @"Git, GitHub", @"UNIX", nil];
    contactsRowsData = [NSArray arrayWithObjects:@"Skype: vanya0327", @"https://github.com/Stead17",
                        @"+380(50)701-7896", @"iv.tkachenko17@gmail.com", @"https://ua.linkedin.com/in/ivan-tkachenko-a3b701102", nil];
}

- (void)imagePlacement {
    profileImage = [[UIImageView alloc] init];
    CGRect image_rect = CGRectMake(self.view.frame.size.width * 0.05, self.view.frame.size.height * 0.05, self.view.frame.size.width * 0.45,
                                   self.view.frame.size.height * 0.35);
    [profileImage setFrame:image_rect];
    [profileImage setImage:[UIImage imageNamed:@"profilePhoto"]];
    [profileImage setClipsToBounds:YES];
    [profileImage setContentMode:UIViewContentModeScaleAspectFill];
    profileImage.autoresizingMask =
    ( UIViewAutoresizingFlexibleBottomMargin
     | UIViewAutoresizingFlexibleHeight
     | UIViewAutoresizingFlexibleLeftMargin
     | UIViewAutoresizingFlexibleRightMargin
     | UIViewAutoresizingFlexibleTopMargin
     | UIViewAutoresizingFlexibleWidth );
    [self.view addSubview:profileImage];
}

- (void)mainTableViewMaker {
    float y_coordinate = profileImage.frame.origin.y + profileImage.frame.size.height + 15;
    float tableViewHeight = self.view.frame.size.height - y_coordinate;
    
    tableViewMain = [[UITableView alloc] initWithFrame:CGRectMake(0, y_coordinate, self.view.frame.size.width,
                                                                  tableViewHeight) style:UITableViewStyleGrouped];
    
    [tableViewMain setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    tableViewMain.delegate = self;
    tableViewMain.dataSource = self;
    tableViewMain.estimatedRowHeight = 55.0;
    
    [tableViewMain registerNib:[UINib nibWithNibName:@"NormalCell" bundle:nil] forCellReuseIdentifier:@"idCellNormal"];
    [tableViewMain registerNib:[UINib nibWithNibName:@"TextFieldCell" bundle:nil] forCellReuseIdentifier:@"idCellTextField"];
    
    [self.view addSubview:tableViewMain];
}

- (void)IDTableViewMaker {
    float x_coordinate = profileImage.frame.origin.x + profileImage.frame.size.width + 15;
    
    tableViewID = [[UITableView alloc] initWithFrame:CGRectMake(x_coordinate, profileImage.frame.origin.y, self.view.frame.size.width,
                                                                profileImage.frame.size.height) style:UITableViewStylePlain];
    [tableViewID setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    tableViewID.delegate = self;
    tableViewID.dataSource = self;
    
    [tableViewID setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:tableViewID];
}

- (void)hintLabelInit {
    hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.55, tableViewMain.frame.origin.y - 50, 0.5 * tableViewID.frame.size.width * 0.85, 50)];
    [hintLabel setBackgroundColor:[UIColor clearColor]];
    [hintLabel setText:@"Tap on some text in cells below to enter websites"];
    [hintLabel setNumberOfLines:2];
    [hintLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [hintLabel setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:hintLabel];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tableViewMain) {
        switch (section) {
            case 0:
                return educationRowsData.count;
                break;
            case 1:
                return experienceRowsData.count;
                break;
            case 2:
                return langTechRowsData.count;
                break;
            case 3:
                return contactsRowsData.count;
                break;
            default:
                break;
        }
    } else if (tableView == tableViewID) {
        return 1;
    }
    
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == tableViewMain) {
        return info.count;
    } else if(tableView == tableViewID) {
        return idText.count;
    }
    
    return idText.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *cell_id = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    if (tableView == tableViewMain) {
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
        }
        [tableView setAllowsSelection:NO];
        
        UIFont *custFont = [UIFont fontWithName:@"Helvetica" size:14];
        if (indexPath.section == 0) {
            CGFloat currentStrSize = [self widthOfString:[educationRowsData objectAtIndex:indexPath.row] withFont:custFont];
            if (currentStrSize > 195)
                cell.textLabel.numberOfLines += 1;
            cell.textLabel.text = [educationRowsData objectAtIndex:indexPath.row];
            
            cell.textLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrlForFirstRow:)];
            gestureRec.numberOfTouchesRequired = 1;
            gestureRec.numberOfTapsRequired = 1;
            [cell.textLabel addGestureRecognizer:gestureRec];
        } else if(indexPath.section == 1) {
            CGFloat currentStrSize = [self widthOfString:[experienceRowsData objectAtIndex:indexPath.row] withFont:custFont];
            if (currentStrSize > 195)
                cell.textLabel.numberOfLines += 1;
            if (indexPath.row == 3) {
                cell.textLabel.userInteractionEnabled = YES;
                UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrlForCamp:)];
                gestureRec.numberOfTouchesRequired = 1;
                gestureRec.numberOfTapsRequired = 1;
                [cell.textLabel addGestureRecognizer:gestureRec];
            }
            cell.textLabel.text = [experienceRowsData objectAtIndex:indexPath.row];
        } else if(indexPath.section == 2) {
            CGFloat currentStrSize = [self widthOfString:[langTechRowsData objectAtIndex:indexPath.row] withFont:custFont];
            if (currentStrSize > 195)
                cell.textLabel.numberOfLines += 1;
            cell.textLabel.text = [langTechRowsData objectAtIndex:indexPath.row];
        } else if(indexPath.section == 3) {
            CGFloat currentStrSize = [self widthOfString:[contactsRowsData objectAtIndex:indexPath.row] withFont:custFont];
            if (currentStrSize > 195)
                cell.textLabel.numberOfLines += 1;
            
            if (indexPath.row == 1) {
                cell.textLabel.text = [contactsRowsData objectAtIndex:indexPath.row];
                cell.textLabel.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
                gestureRec.numberOfTouchesRequired = 1;
                gestureRec.numberOfTapsRequired = 1;
                [cell.textLabel addGestureRecognizer:gestureRec];
            } else if(indexPath.row == 4) {
                cell.textLabel.text = [contactsRowsData objectAtIndex:indexPath.row];
                cell.textLabel.userInteractionEnabled = YES;
                UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
                gestureRec.numberOfTouchesRequired = 1;
                gestureRec.numberOfTapsRequired = 1;
                [cell.textLabel addGestureRecognizer:gestureRec];
            }
            else {
                cell.textLabel.text = [contactsRowsData objectAtIndex:indexPath.row];
            }
            
        }
        
    } else if(tableView == tableViewID){
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width * 0.0, cell.frame.size.height * 0.05,
                                                                   cell.frame.size.width * 0.25, cell.frame.size.height * 0.35)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor blueColor]];
        [label setFont:[UIFont fontWithName:@"Arial" size:12.0]];
        [label setHighlighted:YES];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.textLabel.text = [idText objectAtIndex:0];
            [label setText:@"Name:"];
            [label setHighlighted:YES];
            
            [cell addSubview:label];
        } else if(indexPath.section == 1 && indexPath.row == 0) {
            cell.textLabel.text = [idText objectAtIndex:1];
            
            [label setText:@"Surname:"];
            [cell addSubview:label];
        } else if(indexPath.section == 2) {
            cell.textLabel.text = [idText objectAtIndex:2];
            
            [label setText:@"Date of bitrh:"];
            [cell addSubview:label];
        }
        
        
        [tableView setAllowsSelection:NO];
        [tableView setScrollEnabled:NO];
    }
    
    return cell;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, UIFontDescriptorNameAttribute, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (void)openUrl:(id)sender {
    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
    
    id hitLabel = [self.view hitTest:[rec locationInView:self.view] withEvent:UIEventTypeTouches];
    
    if ([hitLabel isKindOfClass:[UILabel class]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((UILabel *)hitLabel).text]];
    }
}

- (void)openUrlForFirstRow:(id)sender {
    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
    
    id hitLabel = [self.view hitTest:[rec locationInView:self.view] withEvent:UIEventTypeTouches];
    
    if ([hitLabel isKindOfClass:[UILabel class]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://kpi.ua/"]];
    }
}

- (void)openUrlForCamp:(id)sender {
    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
    
    id hitLabel = [self.view hitTest:[rec locationInView:self.view] withEvent:UIEventTypeTouches];
    
    if ([hitLabel isKindOfClass:[UILabel class]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://jamm.com.ua/"]];
    }
}

- (void)cellWithDescription:(UITableViewCell*)cell cellWithIndexRow:(NSUInteger)indexPathRow {
    switch (indexPathRow) {
        case 0:
            cell.detailTextLabel.text = @"Skype";
            break;
        case 1:
            cell.detailTextLabel.text = @"GitHub";
            break;
        case 2:
            cell.detailTextLabel.text = @"Phone Number";
            break;
        case 3:
            cell.detailTextLabel.text = @"E-mail";
            break;
        case 4:
            cell.detailTextLabel.text = @"LinkedIn";
            break;
        default:
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == tableViewMain) {
        if (section == 0) {
            return @"Education";
        } else if(section == 1) {
            return @"Additional Experience";
        } else if(section == 2) {
            return @"Language and Technologies";
        } else if(section == 3) {
            return @"Contacts";
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == tableViewID) {
        return 0.0;
    } else if(tableView == tableViewMain) {
        return 10.0;
    }
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tableViewID) {
        return 55.0;
    } else if(tableView == tableViewMain) {
        if (indexPath.row == 4 && indexPath.section == 3) {
            return 70.0;
        }
        return 50.0;
    }
    return 50.0;
}


@end
