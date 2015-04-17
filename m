Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:51639 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753883AbbDQJvA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 05:51:00 -0400
Received: by paboj16 with SMTP id oj16so120394686pab.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2015 02:50:59 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v4 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination driver
Date: Fri, 17 Apr 2015 02:50:06 -0700
Message-Id: <cover.1429263201.git.dhdang@apm.com>
In-Reply-To: <20150415091655.02361cdc@arm.com>
References: <20150415091655.02361cdc@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2048 MSI termination ports coalesced into 16 physical HW IRQ lines
and shared across all 5 PCIe ports.

v4 changes:
	1. Remove affinity setting for each MSI
	2. Add description about register layout, MSI termination address and data
	3. Correct total number of MSI vectors to 2048
	4. Clean up error messages
	5. Remove unused module code

v3 changes:
        1. Implement MSI support using PCI MSI IRQ domain
        2. Only use msi_controller to store IRQ domain
v2 changes:
        1. Use msi_controller structure
        2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs
 


 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  63 ++++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 ++
 drivers/pci/host/Kconfig                           |   6 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-xgene-msi.c                   | 410 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       |  21 ++
 7 files changed, 536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1

