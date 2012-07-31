Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42875 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab2GaAYO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Jul 2012 20:24:14 -0400
Message-ID: <1343694251.2591.5.camel@yhuang-dev>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: Huang Ying <ying.huang@intel.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
Date: Tue, 31 Jul 2012 08:24:11 +0800
In-Reply-To: <Pine.LNX.4.44L0.1207301017190.1386-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1207301017190.1386-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2012-07-30 at 10:19 -0400, Alan Stern wrote:
> On Mon, 30 Jul 2012, Huang Ying wrote:
> 
> > > Yup, that worked in the quick test I just did.
> > > 
> > >  lspci reading the device config will still not wake the bridge, but I
> > > assume that is intentional?  But loading the device driver now wakes
> > > both the bridge and the device, so that works.
> > 
> > Do you have time to test the following patch to fix the lspci issue?
> > 
> > Subject: [BUGFIX] PCI/PM: Keep parent bridge active when read/write config reg
> > 
> > This patch fixes the following bug:
> > 
> > http://marc.info/?l=linux-pci&m=134338059022620&w=2
> > 
> > Where lspci does not work properly if a device and the corresponding
> > parent bridge (such as PCIe port) is suspended.  This is because the
> > device configuration space registers will be not accessible if the
> > corresponding parent bridge is suspended.
> > 
> > To solve the issue, the bridge/PCIe port connected to the device is
> > put into active state before read/write configuration space registers.
> 
> What happens when you run lspci and the device is in D3cold?  Then even 
> if the parent bridge is active, lspci will still fail.
> 
> It seems that in this case you need to resume the device itself, not 
> just its parent.

Yes.  Will do that.

Best Regards,
Huang Ying


