Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Mar 2013 12:13:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Jiri Kosina <jkosina@suse.cz>
cc: Peter Hurley <peter@hurleysoftware.com>,
	Thomas Meyer <thomas@m3y3r.de>,
	Shawn Starr <shawn.starr@rogers.com>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [3.9-rc1] irq 16: nobody cared  (was [3.9-rc1] very poor interrupt
 responses)
In-Reply-To: <alpine.LNX.2.00.1303141634440.30118@pobox.suse.cz>
Message-ID: <Pine.LNX.4.44L0.1303141212170.1983-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Mar 2013, Jiri Kosina wrote:

> > There have been only three significant changes to uhci-hcd since last 
> > summer, and two of them appear to be completely unrelated to this 
> > issue.  The three commits are
> > 
> > 	3171fcabb169  USB: uhci: beautify source code
> > 	13996ca7afd5  USB: uhci: check buffer length to avoid memory 
> > 			overflow
> > 	0f815a0a700b  USB: UHCI: fix IRQ race during initialization
> > 
> > Reverting the first two almost certainly will not have any effect, but
> > you may as well try it anyway.  The third commit may be relevant.
> 
> I have reverted all three commits, and the "nobody cared" is still there. 

There's one other commit I failed to find at first: 840008bb5162 (USB: 
UHCI: notify usbcore about port resumes).  Probably not relevant, but 
you should check to make sure.

Alan Stern

