Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:54306 "EHLO smtp1.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbbINHkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Sep 2015 03:40:09 -0400
Date: Mon, 14 Sep 2015 10:41:03 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Helge Deller <deller@gmx.de>
cc: linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI,parisc: Enable 64-bit bus addresses on PA-RISC
In-Reply-To: <20150902161729.GA2444@ls3530.box>
Message-ID: <alpine.LRH.2.20.1509141040190.31198@math.ut.ee>
References: <20150902161729.GA2444@ls3530.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Commit 3a9ad0b ("PCI: Add pci_bus_addr_t") unconditionally introduced usage of
> 64-bit PCI bus addresses on all 64-bit platforms which broke PA-RISC.
> 
> It turned out that due to enabling the 64-bit addresses, the PCI logic decided
> to use the GMMIO instead of the LMMIO region. This commit simply disables
> registering the GMMIO and thus we fall back to use the LMMIO region as before.
> 
> Reverts commit 45ea2a5fed6dacb9bb0558d8b21eacc1c45d5bb4
> ("PCI: Don't use 64-bit bus addresses on PA-RISC")

Seems to work fine on my A500, RP3410 and RP3440, with 4.3.0-rc1.

> To: linux-parisc@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Meelis Roos <mroos@linux.ee>
> Cc: stable@vger.kernel.org  # v3.19+
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> 
> diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
> index dceb9dd..a32c1f6 100644
> --- a/drivers/parisc/lba_pci.c
> +++ b/drivers/parisc/lba_pci.c
> @@ -1556,8 +1556,11 @@ lba_driver_probe(struct parisc_device *dev)
>  	if (lba_dev->hba.lmmio_space.flags)
>  		pci_add_resource_offset(&resources, &lba_dev->hba.lmmio_space,
>  					lba_dev->hba.lmmio_space_offset);
> -	if (lba_dev->hba.gmmio_space.flags)
> -		pci_add_resource(&resources, &lba_dev->hba.gmmio_space);
> +	if (lba_dev->hba.gmmio_space.flags) {
> +		/* pci_add_resource(&resources, &lba_dev->hba.gmmio_space); */
> +		pr_warn("LBA: Not registering GMMIO space %pR\n",
> +			&lba_dev->hba.gmmio_space);
> +	}
>  
>  	pci_add_resource(&resources, &lba_dev->hba.bus_num);
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 944f500..73de4ef 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -2,7 +2,7 @@
>  # PCI configuration
>  #
>  config PCI_BUS_ADDR_T_64BIT
> -	def_bool y if (ARCH_DMA_ADDR_T_64BIT || (64BIT && !PARISC))
> +	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
>  	depends on PCI
>  
>  config PCI_MSI
> 

-- 
Meelis Roos (mroos@linux.ee)
