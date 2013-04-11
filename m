Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54665 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab3DKRPT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Apr 2013 13:15:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1UQL5h-0001vW-GF
	for linux-pci@vger.kernel.org; Thu, 11 Apr 2013 19:15:17 +0200
Received: from 183.12.184.59 ([183.12.184.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2013 19:15:17 +0200
Received: from zhef2000 by 183.12.184.59 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2013 19:15:17 +0200
To: linux-pci@vger.kernel.org
From: zhengfei <zhef2000@gmail.com>
Subject: Re: [Question] Failed to access the BAR MMIO space of PCI device
Date: Thu, 11 Apr 2013 17:15:06 +0000 (UTC)
Message-ID: <loom.20130411T190021-709@post.gmane.org>
References: <loom.20130407T204756-980@post.gmane.org> <1365431000.16420.11.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson <alex.williamson <at> redhat.com> writes:

> 
> On Sun, 2013-04-07 at 19:19 +0000, zhengfei wrote:
> > Hi,
> > 
> > I'm writing a driver for a SR-IOV device on the PCI bus. My architecture 
is 
> > a 64-bit X86 of intel Sandy bridge.
> > 
> > In my device driver, I want to configure the device to transfer data 
to/from 
> > X86.I get the the device BAR MMIO base address with the command "lspci -
s 
> > 04:00.03 -xxx" in the guest os(kvm).
> > But after I ioremap() that MMIO base address,I failed to access the BAR 
MMIO 
> > space in the guest os(kvm).
> > 
> > Is there a function which show mapping between the real PCI address 
stored in 
> > the BAR and the emulated address stored in the BAR?
> 
> Is this a userspace driver or a kernel driver?  I can't figure out why
> you would use lspci to get a static BAR address, then use ioremap() to
> map it.  If it's a kernel driver, the sequence you want is something
> like:
> 
> pci_enable_device
> pci_request_selected_regions
> pci_iomap
> 
> Thanks,
> Alex
> 
> 

It is a userspace driver on guest os.To be simply,I got the BAR0 
address(gpa) on guest os,but I failed to access real BAR0 MMIO address space 
of the device with the gpa.So what can I do next? and in which source code 
file,could I find the procedure of mapping the real BAR address space（hpa) 
to gpa?

Thanks

