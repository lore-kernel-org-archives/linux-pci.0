Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <562B3867.6020802@huawei.com>
Date: Sat, 24 Oct 2015 15:51:03 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	<bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V4 0/8] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/21 23:52, Suravee Suthikulpanit wrote:
> This patch series adds support to setup DMA coherency for PCI device using
> the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
> is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
> support for ARM64 which is currently in development.  Also, this should
> not affect other architectures that does not define 
> CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
>
> In the process, this series also introduces enum dev_dma_attr and a set
> of APIs to query device DMA attribute. These APIs replace the obsolete
> device_dma_is_coherent(), and acpi_check_dma().
>
> I have also included a patch from Jeremy posted here:
>     http://www.spinics.net/lists/linux-usb/msg128582.html
>
> This patch series  has been tested on AMD Seattle RevB platform.
> The git tree containing tested code and pre-req patches are posted here:
>
>     http://github.com/ssuthiku/linux.git pci-cca-v4
>
> Changes from V3: (https://lkml.org/lkml/2015/8/26/389)
>     * Clean up suggested by Bjorn
>     * Introduce enum dev_dma_attr
>     * Replace device_dma_is_coherent() and acpi_check_dma() with
>       new APIs.
>
> Changes from V2: (https://lkml.org/lkml/2015/8/25/549)
>     * Return -ENOSUPP instead of -1 (per Rafael's suggestion)
>     * Add WARN() when fail to setup DMA for PCI device when booting
>       ACPI (per Arnd's suggestion)
>     * Added Acked-by from Rob.
>     * Minor clean up
>
> Changes from V1: (https://lkml.org/lkml/2015/8/13/182)
>     * Include patch 1 from Jeremy to enable support for _CCA=0
>     * Clean up acpi_check_dma() per Bjorn suggestions
>     * Split the original V1 patch into two patches (patch 3 and 4)
>
> Jeremy Linton (1):
>   Honor ACPI _CCA attribute setting
>
> Suravee Suthikulpanit (7):
>   device property: Introducing enum dev_dma_attr
>   acpi: Adding DMA Attribute APIs for ACPI Device
>   device property: Adding DMA Attribute APIs for Generic Devices
>   device property: acpi: Make use of the new DMA Attribute APIs
>   device property: acpi: Remove unused DMA APIs
>   PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
>   PCI: ACPI: Add support for PCI device DMA coherency

If the minor comments for patch 7,8 are addressed,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun


