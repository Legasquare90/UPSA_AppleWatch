//
//  ComplicationController.swift
//  Exercise6 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 26/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import ClockKit

struct Show {
    var name: String
    var shortName: String?
    var genre: String
    
    var startDate: NSDate
    var length: NSTimeInterval
}

let hour: NSTimeInterval = 60 * 60
let shows = [
    Show(name: "Into the Wild", shortName: "Into Wild", genre: "Documentary", startDate: NSDate(), length: hour * 1.5),
    Show(name: "24/7", shortName: nil, genre: "Drama", startDate: NSDate(timeIntervalSinceNow: hour * 1.5), length: hour),
    Show(name: "How to become rich", shortName: "Become Rich", genre: "Documentary", startDate: NSDate(timeIntervalSinceNow: hour * 2.5), length: hour * 3),
    Show(name: "NET Daily", shortName: nil, genre: "News", startDate: NSDate(timeIntervalSinceNow: hour * 5.5), length: hour)
]

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler(.Forward)
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate())
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate(timeIntervalSinceNow: (hour*24)))
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        let show = shows[0]
        let template = CLKComplicationTemplateModularLargeStandardBody()
        
        template.headerTextProvider = CLKTimeIntervalTextProvider(startDate: show.startDate, endDate: NSDate(timeInterval: show.length, sinceDate: show.startDate))
        template.body1TextProvider = CLKSimpleTextProvider(text: show.name, shortText: show.shortName)
        template.body2TextProvider = CLKSimpleTextProvider(text: show.genre, shortText: nil)
        
        let entry = CLKComplicationTimelineEntry(date: NSDate(timeInterval: hour * -0.25, sinceDate: show.startDate), complicationTemplate: template)
        handler(entry)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries: [CLKComplicationTimelineEntry] = []
        
        for show in shows
        {
            if entries.count < limit && show.startDate.timeIntervalSinceDate(date) > 0
            {
                let template = CLKComplicationTemplateModularLargeStandardBody()
                
                template.headerTextProvider = CLKTimeIntervalTextProvider(startDate: show.startDate, endDate: NSDate(timeInterval: show.length, sinceDate: show.startDate))
                template.body1TextProvider = CLKSimpleTextProvider(text: show.name, shortText: show.shortName)
                template.body2TextProvider = CLKSimpleTextProvider(text: show.genre, shortText: nil)
                
                let entry = CLKComplicationTimelineEntry(date: NSDate(timeInterval: hour * -0.25, sinceDate: show.startDate), complicationTemplate: template)
                entries.append(entry)
            }
        }
        
        handler(entries)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        handler(NSDate(timeIntervalSinceNow: hour*24))
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        template.headerTextProvider = CLKTimeIntervalTextProvider(startDate: NSDate(), endDate: NSDate(timeIntervalSinceNow: hour*1.5))
        template.body1TextProvider = CLKSimpleTextProvider(text: "Show Name", shortText: "Name")
        template.body2TextProvider = CLKSimpleTextProvider(text: "Show Genre", shortText: nil)
        handler(template)
    }
    
}
