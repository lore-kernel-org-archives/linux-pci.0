Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55790 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757050Ab2JYSTv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2012 14:19:51 -0400
Date: Thu, 25 Oct 2012 14:19:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ulrich Eckhardt <usb@uli-eckhardt.de>
cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Ming Lei <ming.lei@canonical.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
In-Reply-To: <50897A30.1040207@uli-eckhardt.de>
Message-ID: <Pine.LNX.4.44L0.1210251418210.1278-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 25 Oct 2012, Ulrich Eckhardt wrote:

> Am 25.10.2012 03:24, schrieb Ming Lei:
> >> Lei, do you have any doc describing how to use those tracepoints?
> >
> > Hi Bjorn Helgaas,
> >
> > Firstly, please enable these tracepoints via below
> >
> >            echo 1 > /sys/kernel/debug/tracing/events/rpm/enable
> >
> > then store the trace event result by below once you make sure your interested
> > events are completed:
> >
> >            echo 0 > /sys/kernel/debug/tracing/events/rpm/enable
> >            cp /sys/kernel/debug/tracing/trace /media/ram/rpm-trace
> >
> Hi,
> 
> I have created a trace according this description. Therefore I have 
> rebooted my system, enabled the trace and inserted and removed the 
> SD-card until the controller stops working. During this procedure I 
> observed that the controller seems to be more stable. I had to insert 
> and remove the SD-card several times until the controller stopped 
> working. Normally the controller will fail on the first attempt. Also I 
> had the impression (not sure about this since I have not measured it) 
> that the card reader reads the data faster.
> 
> I append the gzipped trace and the corresponding dmesg output.

There's a much more straightforward way of telling when a PCI-based USB 
host controller gets suspended or resumed.  Just enable 
CONFIG_USB_DEBUG; then there will appropriate lines in the dmesg log.

Alan Stern

