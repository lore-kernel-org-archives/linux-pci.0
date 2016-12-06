Return-Path: <SRS0=JaKB=XV=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=JaKB=XV=semihalf.com=tn@kernel.org>
Subject: Re: [PATCH v11 13/15] PCI: Add MCFG quirks for Cavium ThunderX
 pass2.x host controller
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161205232657.3957.97517.stgit@bhelgaas-glaptop.roam.corp.google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
 Sinan Kaya <okaya@codeaurora.org>, Christopher Covington
 <cov@codeaurora.org>, Dongdong Liu <liudongdong3@huawei.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <02243cf0-a24a-f6c3-2467-d484263eab3e@semihalf.com>
Date: Tue, 6 Dec 2016 14:07:45 +0100
MIME-Version: 1.0
In-Reply-To: <20161205232657.3957.97517.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 06.12.2016 00:26, Bjorn Helgaas wrote:
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d7e7c0a..1239a8e 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -240,7 +240,8 @@ config PCIE_QCOM
>
>  config PCI_HOST_THUNDER_PEM
>  	bool "Cavium Thunder PCIe controller to off-chip devices"
> -	depends on OF && ARM64
> +	depends on ARM64
> +	depends on OF || (ACPI && PCI_QUIRKS)
>  	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 64845f0..97e6bfc 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -28,7 +28,7 @@ obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>  obj-$(CONFIG_ARM64) += pcie-hisi.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
> -obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
> +obj-$(CONFIG_ARM64) += pci-thunder-pem.o

Since we build pci-thunder-pem.o for ARM64 and ...

>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index c3276ee..af722eb 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -18,8 +18,12 @@
>  #include <linux/init.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/pci-acpi.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
> +#include "../pci.h"
> +
> +#if defined(CONFIG_PCI_HOST_THUNDER_PEM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))

have this ^^^ ifdef IMO we can drop Kconfig changes in 
drivers/pci/host/Kconfig. The same for PCI_HOST_THUNDER_ECAM in 
patch[14/15].

Thanks,
Tomasz
