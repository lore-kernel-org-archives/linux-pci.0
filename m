Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49178 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751948AbaGIQ07 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 12:26:59 -0400
Date: Wed, 9 Jul 2014 12:26:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Igor Bezukh <Igor@galilsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: A question about PCI suspend-resume functionallity
In-Reply-To: <CAErSpo7_sWKCT6gdv-U=2miyT4+XGtGa-TBP8ueunS_fgvJr9Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1407091218170.873-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 9 Jul 2014, Bjorn Helgaas wrote:

> > In the USB stack, the subsystem core resume code checks to see if a
> > device has been unplugged before the driver's ->resume callback is
> > invoked.  If a device is gone, the driver callback is skipped.  Thus
> > drivers don't have to worry about trying to resume a device that has
> > been unplugged.
> 
> I assume that you do want to call the driver's ->remove method to free
> any per-device state.  Do USB drivers just have to be smart enough to
> do that without touching the device?

Not quite how I'd describe it.  They have to be smart enough for the
remove routine to run correctly even if the device is already gone --
_any_ driver for a hot-unpluggable device has to be like this.

Obviously no driver can touch a device that is gone.  But it can
try.  If a USB driver tries to touch a device that has been unplugged,
the corresponding function call just returns an error.  It doesn't
crash.

Alan Stern

