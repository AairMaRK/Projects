//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Egor Gryadunov on 15.08.2021.
//

import MapKit

extension MKPointAnnotation: ObservableObject
{
    public var wrappedTitle: String {
        get { self.title ?? "Unknown value" }
        set { title = newValue }
    }
    
    public var wrappedSubtitle: String {
        get { self.subtitle ?? "Unknown value" }
        set { subtitle = newValue }
    }
}
