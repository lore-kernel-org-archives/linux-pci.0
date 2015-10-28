Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0065.outbound.protection.outlook.com ([65.55.169.65]:15232
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751693AbbJ1WvQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Oct 2015 18:51:16 -0400
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V5 0/9] PCI: ACPI: Setting up DMA coherency for PCI device from _CCA attribute
Date: Wed, 28 Oct 2015 15:50:45 -0700
Message-ID: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds support to setup DMA coherency for PCI device using
the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
support for ARM64 which is currently in development.  Also, this should
not affect other architectures that does not define 
CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.

In the process, this series also introduces enum dev_dma_attr and a set
of APIs to query device DMA attribute. These APIs replace the obsolete
device_dma_is_coherent(), and acpi_check_dma().

I have also included a patch from Jeremy posted here:
    http://www.spinics.net/lists/linux-usb/msg128582.html

This patch series is now rebased from:
    https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

This patch series has been tested on AMD Seattle RevB platform.
The git tree containing tested code and pre-req patches is available here:
    http://github.com/ssuthiku/linux.git pci-cca-v5

Changes from V4: (https://lkml.org/lkml/2015/10/21/535)
    * Clean up from Hanjun, Bjorn, and Thomas review comments
    * Rebased on top of Rafael's latest linux-next branch
    * Added patch 7/9 to fix the  pci_get_host_bridge_device leak
    * Added Acked-by from Bjorn
    * Added Reviewed-by from Hanjun

Changes from V3: (https://lkml.org/lkml/2015/8/26/389)
    * Clean up suggested by Bjorn
    * Introduce enum dev_dma_attr
    * Replace device_dma_is_coherent() and acpi_check_dma() with
      new APIs.

Changes from V2: (https://lkml.org/lkml/2015/8/25/549)
    * Return -ENOSUPP instead of -1 (per Rafael's suggestion)
    * Add WARN() when fail to setup DMA for PCI device when booting
      ACPI (per Arnd's suggestion)
    * Added Acked-by from Rob.
    * Minor clean up

Changes from V1: (https://lkml.org/lkml/2015/8/13/182)
    * Include patch 1 from Jeremy to enable support for _CCA=0
    * Clean up acpi_check_dma() per Bjorn suggestions
    * Split the original V1 patch into two patches (patch 3 and 4)

Jeremy Linton (1):
  ACPI: Honor ACPI _CCA attribute setting

Suravee Suthikulpanit (8):
  device property: Introducing enum dev_dma_attr
  ACPI: Adding DMA Attribute APIs for ACPI Device
  device property: Adding DMA Attribute APIs for Generic Devices
  device property: ACPI: Make use of the new DMA Attribute APIs
  device property: ACPI: Remove unused DMA APIs
  of/pci: Fix pci_get_host_bridge_device leak
  PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
  PCI: ACPI: Add support for PCI device DMA coherency

 drivers/acpi/acpi_platform.c              |  7 +++++-
 drivers/acpi/glue.c                       |  8 +++---
 drivers/acpi/scan.c                       | 42 +++++++++++++++++++++++++++++++
 drivers/base/property.c                   | 32 +++++++++++++++++------
 drivers/crypto/ccp/ccp-platform.c         | 15 ++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-main.c |  8 +++++-
 drivers/of/of_pci.c                       | 20 ---------------
 drivers/pci/probe.c                       | 33 ++++++++++++++++++++++--
 include/acpi/acpi_bus.h                   | 36 +++-----------------------
 include/linux/acpi.h                      |  7 +++++-
 include/linux/of_pci.h                    |  3 ---
 include/linux/property.h                  | 10 +++++++-
 12 files changed, 144 insertions(+), 77 deletions(-)

-- 
2.1.0

