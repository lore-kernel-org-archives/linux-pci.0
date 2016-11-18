Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751359AbcKRCkP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Nov 2016 21:40:15 -0500
Date: Thu, 17 Nov 2016 20:40:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
Message-ID: <20161118024010.GC25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
 <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
 <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
 <20161117144402.GB11693@wunner.de>
 <20161117234855.GA25762@bhelgaas-glaptop.roam.corp.google.com>
 <b011e277-7e96-d2ea-216b-f65a6129bc50@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <b011e277-7e96-d2ea-216b-f65a6129bc50@daenzer.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2016 at 10:42:20AM +0900, Michel Dänzer wrote:
> On 18/11/16 08:48 AM, Bjorn Helgaas wrote:
> > 
> > Popping the stack all the way back to Emil's Nov 8 message:
> > 
> >   When using the Mesa drivers alongside firefox [1] (since Mesa 13.0),
> >   glxinfo (Mesa 10.0) and others, all the GPUs* will be awaken,
> >   causing unwanted delays and increased power usage.
> > 
> >   [1] https://bugs.freedesktop.org/show_bug.cgi?id=98502
> > 
> > The bug is about a delay in starting firefox, thunderbird, or
> > chromium.  I assume the browser starts on the current, powered-up,
> > GPU.  I don't understand why we care about the revision of other,
> > powered-off, GPUs.
> 
> We don't. The problem is that the current libdrm API unconditionally
> provides the revision. The plan is to address this in two ways:
> 
> * Add new libdrm API which allows the caller to say "I don't need the
> revision", and make Mesa use that. Users having those changes will not
> run into the problem even on older kernels.
> 
> * Add the separate revision file in sysfs and make libdrm use that for
> its current API. This means that even callers of the current libdrm API
> will not run into the problem with newer kernels.

Why do we care about *anything* for the other, powered-off, GPUs?
Even users of the new libdrm API who say "I don't need the revision"
are still getting the vendor/device/etc for those other GPUs.
