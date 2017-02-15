Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Feb 2017 10:56:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christopher Covington <cov@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: always build pci-host-common on ARM64
Message-ID: <20170215165616.GG19040@bhelgaas-glaptop.roam.corp.google.com>
References: <20170214214355.3101378-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170214214355.3101378-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 14, 2017 at 10:42:56PM +0100, Arnd Bergmann wrote:
> The Thunder PCI host driver is always built, but it relies on pci_host_common_probe,
> so we get a link error here:
> 
> drivers/pci/host/pci-thunder-pem.c: In function 'thunder_pem_probe':
> drivers/pci/host/pci-thunder-pem.c:412:9: error: implicit declaration of function 'pci_host_common_probe';did you mean 'pci_host_bridge_priv'? [-Werror=implicit-function-declaration]
> 
> This adds the common file to the existing hack.
> 
> Fixes: ca5ab37b19df ("PCI: Explain ARM64 ACPI/MCFG quirk Kconfig and build strategy")

I'm puzzled.  ca5ab37b19df doesn't *look* like it changes anything.

thunder_pem_probe() is compiled when CONFIG_PCI_HOST_THUNDER_PEM=y,
and it calls pci_host_common_probe().

pci_host_common_probe() is in pci-host-common.c, which is compiled
when CONFIG_PCI_HOST_COMMON=y.  But the declaration below is under
#ifdef CONFIG_PCI_HOST_GENERIC.  Shouldn't it be under #ifdef
CONFIG_PCI_HOST_COMMON instead?

It'd be nice to know what actually broke this (if it's not
ca5ab37b19df) so we can figure out where the fix should be backported.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/Makefile | 2 +-
>  include/linux/pci-ecam.h  | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index bfe3179ae74c..e97d084f10ea 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -39,7 +39,7 @@ obj-$(CONFIG_VMD) += vmd.o
>  # config options to be enabled, so we always build these drivers on
>  # ARM64 and use internal ifdefs to only build the pieces we need
>  # depending on whether ACPI, the DT driver, or both are enabled.
> -
> +obj-$(CONFIG_ARM64) += pci-host-common.o
>  obj-$(CONFIG_ARM64) += pcie-hisi.o
>  obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>  obj-$(CONFIG_ARM64) += pci-thunder-pem.o
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index f0d2b9451270..ab52692388d1 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -68,9 +68,8 @@ extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
>  extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>  #endif
>  
> -#ifdef CONFIG_PCI_HOST_GENERIC
>  /* for DT-based PCI controllers that support ECAM */
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops);
> -#endif
> +
>  #endif
> -- 
> 2.9.0
> 
