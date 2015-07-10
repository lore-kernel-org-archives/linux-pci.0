Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45160 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbbGJLS0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jul 2015 07:18:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZDWJy-0000sO-OU
	for linux-pci@vger.kernel.org; Fri, 10 Jul 2015 13:18:23 +0200
Received: from nsg-static-030.145.72.182.airtel.in ([nsg-static-030.145.72.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2015 13:18:22 +0200
Received: from rgummal by nsg-static-030.145.72.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2015 13:18:22 +0200
To: linux-pci@vger.kernel.org
From: ravikiran gummaluri <rgummal@xilinx.com>
Subject: Re: PCIe support for ARM64
Date: Fri, 10 Jul 2015 11:18:10 +0000 (UTC)
Message-ID: <loom.20150710T130734-815@post.gmane.org>
References: <loom.20150619T074145-299@post.gmane.org> <CAErSpo52WYqB9hfNKo-ADrJF1LASUz5y9vWzsmp2FaCNc9WZfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas <at> google.com> writes:

> 
> On Fri, Jun 19, 2015 at 12:43 AM, ravikiran gummaluri
> <rgummal <at> xilinx.com> wrote:
> > HI
> >
> > I am developing PCIe root port driver for Xilinx device. We have used
> > following patch for ARM64 bit support
> > "https://lkml.org/lkml/2014/7/3/764". The link explains it as temporary
> > patch and main line will be updated soon with those changes. We have not
> > seen the changes till now. Can you let us know when we can expect the
> > changes in mainline? We are planning to push our drivers to mainline.
> 
> There is PCI support for ARM64 in mainline:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?
id=d1e6dc91b532
> 
> There is also a Xilinx driver already:
> 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/
pci/host/pcie-xilinx.c
> 
> I don't know if your device is similar to the AXI device, but it would
> be good if you can share or modify that driver instead of adding a new
> one.
> 
> As with several other drivers, the current pcie-xilinx.c uses
> pci_common_init_dev(), so it only works on ARM (not ARM64).  This is a
> known issue, and people are working on making these drivers less
> arch-specific.
> 
> Bjorn
> 

Thanks Bjorn. pcie-xilinx.c is AXI device. Now we are developing for 
different device using pcie-xilinx.c as reference. When we trying to 
compile our new driver with latest kernel we are getting compilation 
problems for struct hw_pci and struct pci_sys_data for ARM64. These 
structures are not defined in ARM64. The following patch has the structure 
definitions "https://lkml.org/lkml/2014/7/3/764". We have used this patch 
and able complete our development. Now for up streaming it we need this 
patch in main line. From your discursion we understood that some work is 
going on ARCH independent API and structure. When can we expect them in 
mainline? 


