Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 30 May 2013 16:13:36 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Linux PM list <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Kevin Hilman <khilman@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH RFC] PM / Runtime: Rework the "runtime idle" helper
 routine
In-Reply-To: <5291416.b4M4MTrzPC@vostro.rjw.lan>
Message-ID: <Pine.LNX.4.44L0.1305301613120.887-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 30 May 2013, Rafael J. Wysocki wrote:

> > > > > Index: linux-pm/Documentation/power/runtime_pm.txt
> > > > > ===================================================================
> > > > > --- linux-pm.orig/Documentation/power/runtime_pm.txt
> > > > > +++ linux-pm/Documentation/power/runtime_pm.txt
> > > > > @@ -660,11 +660,6 @@ Subsystems may wish to conserve code spa
> > > > >  management callbacks provided by the PM core, defined in
> > > > >  driver/base/power/generic_ops.c:
> > > > >  
> > > > > -  int pm_generic_runtime_idle(struct device *dev);
> > > > > -    - invoke the ->runtime_idle() callback provided by the driver of this
> > > > > -      device, if defined, and call pm_runtime_suspend() for this device if the
> > > > > -      return value is 0 or the callback is not defined
> > > > > -
> > > > 
> > > > The documentation for the runtime-idle callback needs to be updated too.
> > > 
> > > Well, I actually couldn't find the part of it that would need to be updated. :-)
> > 
> > How about this?
> 
> Looks good! :-)
> 
> May I add your sign-off to it?

Go ahead.

Alan Stern

