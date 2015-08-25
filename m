Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0106.outbound.protection.outlook.com ([157.56.111.106]:45671
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751400AbbHYRdo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 25 Aug 2015 13:33:44 -0400
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V2 0/4] PCI: ACPI: Setting up DMA coherency for PCI device from _CCA attribute
Date: Wed, 26 Aug 2015 00:33:25 +0700
Message-ID: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support to setup DMA coherency for PCI device using
the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
support for ARM64 which is currently in development.

Also, this should not affect other architectures that does not define 
CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.

In the V2 of this patch series, I have pulled in the following patch from Jeremy
before cleaning up the acpi_check_dma() function (in patch 2).

    http://www.spinics.net/lists/linux-usb/msg128582.html)

Changes from V1: (https://lkml.org/lkml/2015/8/13/182)
    * Include patch 1 from Jeremy to enable support for _CCA=0
    * Clean up acpi_check_dma() per Bjorn suggestions
    * Split the original V1 patch into two patches (patch 3 and 4)

Jeremy Linton (1):
  Honor ACPI _CCA attribute setting

Suravee Suthikulpanit (3):
  ACPI/scan: Clean up acpi_check_dma
  PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
  PCI: ACPI: Add support for PCI device DMA coherency

 drivers/acpi/acpi_platform.c |  7 ++++++-
 drivers/acpi/glue.c          |  5 +++--
 drivers/acpi/scan.c          | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/base/property.c      |  8 ++++++--
 drivers/of/of_pci.c          | 20 --------------------
 drivers/pci/probe.c          | 32 ++++++++++++++++++++++++++++++--
 include/acpi/acpi_bus.h      | 35 ++---------------------------------
 include/linux/acpi.h         |  4 ++--
 include/linux/of_pci.h       |  3 ---
 9 files changed, 88 insertions(+), 65 deletions(-)

-- 
2.1.0

