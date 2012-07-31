Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47697 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753444Ab2GaRH5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2012 13:07:57 -0400
Date: Tue, 31 Jul 2012 13:07:56 -0400 (EDT)
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
In-Reply-To: <1343704722.2591.11.camel@yhuang-dev>
Message-ID: <Pine.LNX.4.44L0.1207311305120.1532-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 31 Jul 2012, Huang Ying wrote:

> > What happens when you run lspci and the device is in D3cold?  Then even 
> > if the parent bridge is active, lspci will still fail.
> > 
> > It seems that in this case you need to resume the device itself, not 
> > just its parent.
> 
> How about the following patch?
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
> corresponding parent bridge is suspended or the device is put into
> D3cold state.
> 
> To solve the issue, the bridge/PCIe port connected to the device is
> put into active state before read/write configuration space registers.
> If the device is in D3cold state, it will be put into active state
> too.
> 
> To avoid resume/suspend PCIe port for each configuration register
> read/write, a small delay is added before the PCIe port to go
> suspended.

The patch looks reasonable to me, but I haven't tested it.

Alan Stern

