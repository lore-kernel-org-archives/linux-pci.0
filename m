Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60658 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754185Ab2G3OTf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2012 10:19:35 -0400
Date: Mon, 30 Jul 2012 10:19:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Huang Ying <ying.huang@intel.com>
cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
In-Reply-To: <1343618131.3874.37.camel@yhuang-dev>
Message-ID: <Pine.LNX.4.44L0.1207301017190.1386-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 30 Jul 2012, Huang Ying wrote:

> > Yup, that worked in the quick test I just did.
> > 
> >  lspci reading the device config will still not wake the bridge, but I
> > assume that is intentional?  But loading the device driver now wakes
> > both the bridge and the device, so that works.
> 
> Do you have time to test the following patch to fix the lspci issue?
> 
> Subject: [BUGFIX] PCI/PM: Keep parent bridge active when read/write config reg
> 
> This patch fixes the following bug:
> 
> http://marc.info/?l=linux-pci&m=134338059022620&w=2
> 
> Where lspci does not work properly if a device and the corresponding
> parent bridge (such as PCIe port) is suspended.  This is because the
> device configuration space registers will be not accessible if the
> corresponding parent bridge is suspended.
> 
> To solve the issue, the bridge/PCIe port connected to the device is
> put into active state before read/write configuration space registers.

What happens when you run lspci and the device is in D3cold?  Then even 
if the parent bridge is active, lspci will still fail.

It seems that in this case you need to resume the device itself, not 
just its parent.

Alan Stern

