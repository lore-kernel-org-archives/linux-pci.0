Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:51422 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933548Ab3BTSFs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2013 13:05:48 -0500
Received: by mail-da0-f53.google.com with SMTP id g27so540146dan.40
        for <linux-pci@vger.kernel.org>; Wed, 20 Feb 2013 10:05:48 -0800 (PST)
Date: Wed, 20 Feb 2013 10:05:05 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Vijay Chauhan <kernel.vijay@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [OT] Newbie
Message-ID: <20130220180505.GA6679@kroah.com>
References: <CAJ61zBBOMqNsbxgYjWsDVG_J5J=qK+jADGE6+YDoT20vbTjFRg@mail.gmail.com>
 <20130220141739.GA5705@kroah.com>
 <CAJ61zBDE7X1V1vgkzTEBFan8rEdpqB7uuzg4Rb=6K9q1=D60Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ61zBDE7X1V1vgkzTEBFan8rEdpqB7uuzg4Rb=6K9q1=D60Eg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 20, 2013 at 08:44:27PM +0530, Vijay Chauhan wrote:
> Hello Greg,
> 
> Thanks for your reply.
> 
> On Wed, Feb 20, 2013 at 7:47 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Feb 20, 2013 at 07:32:03PM +0530, Vijay Chauhan wrote:
> >> Hi,
> >>
> >> I am newbie for PCI. I wanted to learn PCI driver programming in Linux.
> >> Please suggest me how to start. Any example (sample code) or tutorial
> >> link or book helpful for me.
> >
> > Doesn't the huge number of example drivers in the kernel sources provide
> > a wonderful place to start with?
> >
> > What specifically are you trying to do here that you need help with?
> 
> Nothing specific as such, I wanted to learn starting  from basic and
> easy code. drivers/pci/ directory has lots of code but I dont know the
> order. Is there any documentation? Some basic and small piece of code
> for foundation purpose. If you can suggest me one.

Don't pay attention to the drivers/pci/ directory, that is the code that
implements the PCI core, no driver needs to mess with that.  For an
introduction to writing a PCI driver, please see the (outdated, but
free) Linux Device Drivers, third edition book.

Good luck,

greg k-h
