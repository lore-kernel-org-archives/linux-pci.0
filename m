Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0081.outbound.protection.outlook.com ([157.56.111.81]:36692
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750758AbbJUPxA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 11:53:00 -0400
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V4 0/8] PCI: ACPI: Setting up DMA coherency for PCI device from _CCA attribute
Date: Wed, 21 Oct 2015 08:52:03 -0700
Message-ID: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
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

This patch series  has been tested on AMD Seattle RevB platform.
The git tree containing tested code and pre-req patches are posted here:

    http://github.com/ssuthiku/linux.git pci-cca-v4

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
  Honor ACPI _CCA attribute setting

Suravee Suthikulpanit (7):
  device property: Introducing enum dev_dma_attr
  acpi: Adding DMA Attribute APIs for ACPI Device
  device property: Adding DMA Attribute APIs for Generic Devices
  device property: acpi: Make use of the new DMA Attribute APIs
  device property: acpi: Remove unused DMA APIs
  PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
  PCI: ACPI: Add support for PCI device DMA coherency

 drivers/acpi/acpi_platform.c              |  7 +++++-
 drivers/acpi/glue.c                       |  8 +++---
 drivers/acpi/scan.c                       | 42 +++++++++++++++++++++++++++++++
 drivers/base/property.c                   | 32 +++++++++++++++++------
 drivers/crypto/ccp/ccp-platform.c         |  9 ++++++-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c |  9 ++++++-
 drivers/of/of_pci.c                       | 20 ---------------
 drivers/pci/probe.c                       | 36 ++++++++++++++++++++++++--
 include/acpi/acpi_bus.h                   | 36 +++-----------------------
 include/linux/acpi.h                      |  7 +++++-
 include/linux/of_pci.h                    |  3 ---
 include/linux/property.h                  | 10 +++++++-
 12 files changed, 145 insertions(+), 74 deletions(-)

-- 
2.1.0

