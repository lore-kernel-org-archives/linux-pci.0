Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og122.obsmtp.com ([64.18.0.192]:42994 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933004AbbDIRFi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 13:05:38 -0400
Received: by pabtp1 with SMTP id tp1so49938821pab.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 10:05:37 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v3 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination driver
Date: Thu,  9 Apr 2015 10:05:02 -0700
Message-Id: <cover.1428564115.git.dhdang@apm.com>
In-Reply-To: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2688 MSI termination ports coalesced into 16 physical HW IRQ lines
and shared across all 5 PCIe ports.

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
 drivers/pci/host/pci-xgene-msi.c                   | 407 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       |  21 ++
 7 files changed, 533 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1

