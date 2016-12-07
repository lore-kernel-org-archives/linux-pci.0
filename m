Return-Path: <SRS0=Ann+=XW=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=Ann+=XW=semihalf.com=tn@kernel.org>
Subject: Re: [PATCH v11 13/15] PCI: Add MCFG quirks for Cavium ThunderX
 pass2.x host controller
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161205232657.3957.97517.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <02243cf0-a24a-f6c3-2467-d484263eab3e@semihalf.com>
 <20161206204556.GB19700@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
 Sinan Kaya <okaya@codeaurora.org>, Christopher Covington
 <cov@codeaurora.org>, Dongdong Liu <liudongdong3@huawei.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <fb1e4ee3-adce-97c3-c84b-2e67a4d8a2bc@semihalf.com>
Date: Wed, 7 Dec 2016 13:23:01 +0100
MIME-Version: 1.0
In-Reply-To: <20161206204556.GB19700@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 06.12.2016 21:45, Bjorn Helgaas wrote:
> On Tue, Dec 06, 2016 at 02:07:45PM +0100, Tomasz Nowicki wrote:
>> Hi Bjorn,
>>
>> On 06.12.2016 00:26, Bjorn Helgaas wrote:
>>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>>> index d7e7c0a..1239a8e 100644
>>> --- a/drivers/pci/host/Kconfig
>>> +++ b/drivers/pci/host/Kconfig
>>> @@ -240,7 +240,8 @@ config PCIE_QCOM
>>>
>>> config PCI_HOST_THUNDER_PEM
>>> 	bool "Cavium Thunder PCIe controller to off-chip devices"
>>> -	depends on OF && ARM64
>>> +	depends on ARM64
>>> +	depends on OF || (ACPI && PCI_QUIRKS)
>>> 	select PCI_HOST_COMMON
>>> 	help
>>> 	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
>>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>>> index 64845f0..97e6bfc 100644
>>> --- a/drivers/pci/host/Makefile
>>> +++ b/drivers/pci/host/Makefile
>>> @@ -28,7 +28,7 @@ obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>>> obj-$(CONFIG_ARM64) += pcie-hisi.o
>>> obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>> obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>>> -obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>>> +obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>>
>> Since we build pci-thunder-pem.o for ARM64 and ...
>>
>>> obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>> obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>>> obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>>> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
>>> index c3276ee..af722eb 100644
>>> --- a/drivers/pci/host/pci-thunder-pem.c
>>> +++ b/drivers/pci/host/pci-thunder-pem.c
>>> @@ -18,8 +18,12 @@
>>> #include <linux/init.h>
>>> #include <linux/of_address.h>
>>> #include <linux/of_pci.h>
>>> +#include <linux/pci-acpi.h>
>>> #include <linux/pci-ecam.h>
>>> #include <linux/platform_device.h>
>>> +#include "../pci.h"
>>> +
>>> +#if defined(CONFIG_PCI_HOST_THUNDER_PEM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
>>
>> have this ^^^ ifdef IMO we can drop Kconfig changes in
>> drivers/pci/host/Kconfig. The same for PCI_HOST_THUNDER_ECAM in
>> patch[14/15].
>
> I think you're right that we *could* drop the Kconfig changes.  I
> didn't actually drop them because I think it might be slightly
> confusing that with the previous Kconfig:
>
>   config PCI_HOST_THUNDER_PEM
>         bool "Cavium Thunder PCIe controller to off-chip devices"
>         depends on OF && ARM64
>
> we still build pci-thunder-pem.o, even when CONFIG_OF isn't defined.
>
> There's no question that this whole thing is confusing no matter what
> we do.  That reminds me that I meant to add some comments in the
> Makefile.  What do you think about the following:
>
>
> commit 5d06f9125ec00215fa59b789491fdd51186a4ee1
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Dec 6 14:27:59 2016 -0600
>
>     PCI: Explain ARM64 ACPI/MCFG quirk Kconfig and build strategy
>
>     Add Makefile comments to explain the Kconfig and build strategy for ARM64
>     drivers that work around not-quite-ECAM issues.  No functional change
>     intended.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 6cc84b4..bfe3179 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -15,7 +15,6 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
> -obj-$(CONFIG_ARM64) += pci-xgene.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
> @@ -25,11 +24,23 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
> -obj-$(CONFIG_ARM64) += pcie-hisi.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> -obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
> -obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_VMD) += vmd.o
> +
> +# The following drivers are for devices that use the generic ACPI
> +# pci_root.c driver but don't support standard ECAM config access.
> +# They contain MCFG quirks to replace the generic ECAM accessors with
> +# device-specific ones that are shared with the DT driver.
> +
> +# The ACPI driver is generic and should not require driver-specific
> +# config options to be enabled, so we always build these drivers on
> +# ARM64 and use internal ifdefs to only build the pieces we need
> +# depending on whether ACPI, the DT driver, or both are enabled.
> +
> +obj-$(CONFIG_ARM64) += pcie-hisi.o
> +obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
> +obj-$(CONFIG_ARM64) += pci-thunder-pem.o
> +obj-$(CONFIG_ARM64) += pci-xgene.o
>

Looks good to me.

Tomasz
