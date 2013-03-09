Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1362834476.7755.33.camel@thor.lan>
Subject: Re: [3.9-rc1] irq 16: nobody cared  (was [3.9-rc1] very poor
 interrupt responses)
From: Peter Hurley <peter@hurleysoftware.com>
To: Thomas Meyer <thomas@m3y3r.de>,
	Shawn Starr <shawn.starr@rogers.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Sat, 09 Mar 2013 08:07:56 -0500
In-Reply-To: <1362819234.1220.1.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.1303082116310.28403-100000@netrider.rowland.org>
	 <1362819234.1220.1.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ +linux-pci, +linux-acpi, +Rafael Wysocki, +Bjorn Helgaas ]

On Sat, 2013-03-09 at 09:53 +0100, Thomas Meyer wrote:
> Am Freitag, den 08.03.2013, 21:19 -0500 schrieb Alan Stern:
> > On Fri, 8 Mar 2013, Peter Hurley wrote:
> > 
> > > [ +linux-usb ]
> > > 
> > > On Fri, 2013-03-08 at 14:12 -0500, Shawn Starr wrote:
> > > > Hello folks,
> > > > 
> > > > I am noticing since rc0 and now rc1, very poor interrupt handling. Keyboard response, mouse movements, display refreshing etc. General input/display sluggishness. Did something break IRQ handling somewhere? I need to validate if this happens with X not running also if it is i915 related somehow. The behavor is noticed in a console login however.
> > > > 
> > > > Device: Lenovo W500 laptop
> > > 
> > > Hi Shawn,
> > > 
> > > Unhandled interrupts is the problem.
> > > 
> > > Is the device below being id'd properly?
> > > If you remove this device, does the problem go away?
> > 
> > Does either of the kernels in question have commit 0f815a0a700b (USB:
> > UHCI: fix IRQ race during initialization)?  That commit was added to
> > fix precisely this sort of thing.
> 
> I think so:
> 
> $ git describe
> v3.9-rc1-211-g47b3bc9
> 
> $ git branch --contains 0f815a0a700b
> * master

This might not be caused by USB. There were a lot of changes to PCI and
ACPI for 3.9.

Probably best to each file a bug at bugzilla.kernel.org with:

Last known good kernel version

-- For both good and bad kernels (preferably as attachments) --
/proc/interrupts
lsusb
lspci
dmesg

and reply back with the bugzilla #.

It may be necessary to bisect this problem.

Regards,
Peter Hurley

PS - I know it can be difficult to get those things on the bad kernel.
It's easier if you boot to console.


