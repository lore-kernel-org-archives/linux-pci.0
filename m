Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36715 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbIBWoj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2015 18:44:39 -0400
Received: by ioii196 with SMTP id i196so37945456ioi.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 15:44:38 -0700 (PDT)
Date: Wed, 2 Sep 2015 17:44:34 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH v4 0/5] Designware host multivector MSI and 64bit MSI
 fixes
Message-ID: <20150902224434.GE829@google.com>
References: <1439809578-13654-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439809578-13654-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 01:06:13PM +0200, Lucas Stach wrote:
> This is a reworked version of the multivector MSI support for the designware
> PCIe host controller driver.
> 
> v3 added patch 2 to share more code between the single and multivector MSI
> code paths.
> 
> While not really related to this topic patches 4+5 fix the MSI message setup
> to work on 64bit and 32bit PAE systems. I included them in this series as
> they depend on patch 2.
> 
> v4 fixes the last patch to also set up the high part of the MSI target
> address, when calling the common DW MSI init function.
> 
> Regards,
> Lucas
> 
> Lucas Stach (5):
>   PCI: allow MSI chip providers to implement their own multivector MSI
>     setup
>   PCI: designware: factor out MSI msg setup
>   PCI: designware: implement multivector MSI irq setup
>   PCI: designware: change prototype of get_msi_addr
>   PCI: designware: set up high part of MSI target address

I applied these to pci-4.4/host-designware with Pratyush's ack and minor
changelog tweaks (and changing -ENOSYS to -EINVAL to shut up checkpatch).
This will be rebased after v4.3-rc1.  Thanks!


commit 59f6d039d7ea
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Mon Aug 17 13:06:18 2015 +0200

    PCI: designware: Set up high part of MSI target address
    
    Set up the high part of the MSI target address to allow the MSI target to
    be above 4GB on 64bit and PAE systems.
    
    [bhelgaas: changelog]
    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

commit ec8d33e0c5ad
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Mon Aug 17 13:06:17 2015 +0200

    PCI: designware: Make get_msi_addr() return phys_addr_t, not u32
    
    Make get_msi_addr() return phys_addr_t, not u32.  This allows the MSI
    target address to be above 4GB for 64bit or PAE systems.
    
    No functional change for the current 32bit platform users as phys_addr_t
    maps to u32 for them.
    
    [bhelgaas: changelog]
    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

commit 52495e4e5444
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Mon Aug 17 13:06:16 2015 +0200

    PCI: designware: Implement multivector MSI IRQ setup
    
    Implement multivector MSI IRQ setup.  This us to set up and use multiple
    MSI IRQs per device.
    
    [bhelgaas: changelog, use -EINVAL instead of -ENOSYS]
    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

commit 4e660090c3ad
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Mon Aug 17 13:06:15 2015 +0200

    PCI: designware: Factor out MSI msg setup
    
    Factor out the PCI MSI message setup from the single MSI setup function.
    This will be reused by the multivector MSI setup.
    
    No functional change yet.
    
    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

commit 20c12de4f24b
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Mon Aug 17 13:06:14 2015 +0200

    PCI: Add msi_controller setup_irqs() method for special multivector setup
    
    Add a msi_controller setup_irqs() method so MSI chip providers can
    implement their own multivector MSI setup.
    
    [bhelgaas: changelog]
    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Pratyush Anand <pratyush.anand@gmail.com>
