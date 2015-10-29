Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5631BE37.2090306@huawei.com>
Date: Thu, 29 Oct 2015 14:35:35 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	<bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <hanjun.guo@linaro.org>,
	<davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V5 0/9] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/29 6:50, Suravee Suthikulpanit wrote:
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
> This patch series is now rebased from:
>     https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>
> This patch series has been tested on AMD Seattle RevB platform.
> The git tree containing tested code and pre-req patches is available here:
>     http://github.com/ssuthiku/linux.git pci-cca-v5
>
> Changes from V4: (https://lkml.org/lkml/2015/10/21/535)
>     * Clean up from Hanjun, Bjorn, and Thomas review comments
>     * Rebased on top of Rafael's latest linux-next branch
>     * Added patch 7/9 to fix the  pci_get_host_bridge_device leak
>     * Added Acked-by from Bjorn
>     * Added Reviewed-by from Hanjun
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
>   ACPI: Honor ACPI _CCA attribute setting
>
> Suravee Suthikulpanit (8):
>   device property: Introducing enum dev_dma_attr
>   ACPI: Adding DMA Attribute APIs for ACPI Device
>   device property: Adding DMA Attribute APIs for Generic Devices
>   device property: ACPI: Make use of the new DMA Attribute APIs
>   device property: ACPI: Remove unused DMA APIs
>   of/pci: Fix pci_get_host_bridge_device leak
>   PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
>   PCI: ACPI: Add support for PCI device DMA coherency
>
>  drivers/acpi/acpi_platform.c              |  7 +++++-
>  drivers/acpi/glue.c                       |  8 +++---
>  drivers/acpi/scan.c                       | 42 +++++++++++++++++++++++++++++++
>  drivers/base/property.c                   | 32 +++++++++++++++++------
>  drivers/crypto/ccp/ccp-platform.c         | 15 ++++++++---
>  drivers/net/ethernet/amd/xgbe/xgbe-main.c |  8 +++++-
>  drivers/of/of_pci.c                       | 20 ---------------
>  drivers/pci/probe.c                       | 33 ++++++++++++++++++++++--
>  include/acpi/acpi_bus.h                   | 36 +++-----------------------
>  include/linux/acpi.h                      |  7 +++++-
>  include/linux/of_pci.h                    |  3 ---
>  include/linux/property.h                  | 10 +++++++-
>  12 files changed, 144 insertions(+), 77 deletions(-)

I think I already add my reviewed-by, but again, for this patch set:

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun


