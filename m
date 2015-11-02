Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51997 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751149AbbKBAcG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 1 Nov 2015 19:32:06 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com,
	will.deacon@arm.com, hanjun.guo@linaro.org,
	thomas.lendacky@amd.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 0/9] PCI: ACPI: Setting up DMA coherency for PCI device from _CCA attribute
Date: Mon, 02 Nov 2015 02:01:11 +0100
Message-ID: <2082841.EuKXHJIeaT@vostro.rjw.lan>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 28, 2015 03:50:45 PM Suravee Suthikulpanit wrote:
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

Queued up for v4.4, but I'll include it into my second pull request in the
second half of the merge window.

Thanks,
Rafael

