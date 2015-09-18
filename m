Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32781 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbbIRS7f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 14:59:35 -0400
Received: by igbkq10 with SMTP id kq10so42412887igb.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2015 11:59:35 -0700 (PDT)
Date: Fri, 18 Sep 2015 13:59:25 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: Re: [PATCH v5 0/5] Designware host multivector MSI and 64bit MSI
 fixes
Message-ID: <20150918185925.GJ25767@google.com>
References: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 18, 2015 at 05:12:34PM +0200, Lucas Stach wrote:
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
> v5 fixes up clashes with the PCI and MSI changes in v4.3-rc1 and fixes
> one build failure introduced in the last version.
> 
> Regards,
> Lucas
> 
> Lucas Stach (5):
>   PCI: Add msi_controller setup_irqs() method for special multivector
>     setup
>   PCI: designware: Factor out MSI msg setup
>   PCI: designware: Implement multivector MSI IRQ setup
>   PCI: designware: Make get_msi_addr() return phys_addr_t, not u32
>   PCI: designware: Set up high part of MSI target address
> 
>  drivers/pci/host/pci-keystone-dw.c |  2 +-
>  drivers/pci/host/pci-keystone.h    |  2 +-
>  drivers/pci/host/pcie-designware.c | 70 +++++++++++++++++++++++++++++++-------
>  drivers/pci/host/pcie-designware.h |  2 +-
>  drivers/pci/msi.c                  |  3 ++
>  include/linux/msi.h                |  2 ++
>  6 files changed, 65 insertions(+), 16 deletions(-)

Applied to pci/host-designware for v4.4, replacing the v4 patches, thanks!
