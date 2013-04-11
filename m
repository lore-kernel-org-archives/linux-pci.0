Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18037 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161156Ab3DKR5a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Apr 2013 13:57:30 -0400
Message-ID: <1365703048.26525.8.camel@ul30vt.home>
Subject: Re: [Question] Failed to access the BAR MMIO space of PCI device
From: Alex Williamson <alex.williamson@redhat.com>
To: zhengfei <zhef2000@gmail.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 11 Apr 2013 11:57:28 -0600
In-Reply-To: <loom.20130411T190021-709@post.gmane.org>
References: <loom.20130407T204756-980@post.gmane.org>
	 <1365431000.16420.11.camel@bling.home>
	 <loom.20130411T190021-709@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-04-11 at 17:15 +0000, zhengfei wrote:
> Alex Williamson <alex.williamson <at> redhat.com> writes:
> 
> > 
> > On Sun, 2013-04-07 at 19:19 +0000, zhengfei wrote:
> > > Hi,
> > > 
> > > I'm writing a driver for a SR-IOV device on the PCI bus. My architecture 
> is 
> > > a 64-bit X86 of intel Sandy bridge.
> > > 
> > > In my device driver, I want to configure the device to transfer data 
> to/from 
> > > X86.I get the the device BAR MMIO base address with the command "lspci -
> s 
> > > 04:00.03 -xxx" in the guest os(kvm).
> > > But after I ioremap() that MMIO base address,I failed to access the BAR 
> MMIO 
> > > space in the guest os(kvm).
> > > 
> > > Is there a function which show mapping between the real PCI address 
> stored in 
> > > the BAR and the emulated address stored in the BAR?
> > 
> > Is this a userspace driver or a kernel driver?  I can't figure out why
> > you would use lspci to get a static BAR address, then use ioremap() to
> > map it.  If it's a kernel driver, the sequence you want is something
> > like:
> > 
> > pci_enable_device
> > pci_request_selected_regions
> > pci_iomap
> > 
> > Thanks,
> > Alex
> > 
> > 
> 
> It is a userspace driver on guest os.To be simply,I got the BAR0 
> address(gpa) on guest os,but I failed to access real BAR0 MMIO address space 
> of the device with the gpa.So what can I do next? and in which source code 
> file,could I find the procedure of mapping the real BAR address space（hpa) 
> to gpa?

The guest doesn't have access to the hpa, nor should it need it.  To map
BAR0 from guest userspace
mmap /sys/bus/pci/devices/xxxx:xx:xx.x/resource0.  Thanks,

Alex


