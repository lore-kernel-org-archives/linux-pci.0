Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936089Ab3DHOXW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Apr 2013 10:23:22 -0400
Message-ID: <1365431000.16420.11.camel@bling.home>
Subject: Re: [Question] Failed to access the BAR MMIO space of PCI device
From: Alex Williamson <alex.williamson@redhat.com>
To: zhengfei <zhef2000@gmail.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 08 Apr 2013 08:23:20 -0600
In-Reply-To: <loom.20130407T204756-980@post.gmane.org>
References: <loom.20130407T204756-980@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2013-04-07 at 19:19 +0000, zhengfei wrote:
> Hi,
> 
> I'm writing a driver for a SR-IOV device on the PCI bus. My architecture is 
> a 64-bit X86 of intel Sandy bridge.
> 
> In my device driver, I want to configure the device to transfer data to/from 
> X86.I get the the device BAR MMIO base address with the command "lspci -s 
> 04:00.03 -xxx" in the guest os(kvm).
> But after I ioremap() that MMIO base address,I failed to access the BAR MMIO 
> space in the guest os(kvm).
> 
> Is there a function which show mapping between the real PCI address stored in 
> the BAR and the emulated address stored in the BAR?

Is this a userspace driver or a kernel driver?  I can't figure out why
you would use lspci to get a static BAR address, then use ioremap() to
map it.  If it's a kernel driver, the sequence you want is something
like:

pci_enable_device
pci_request_selected_regions
pci_iomap

Thanks,
Alex


