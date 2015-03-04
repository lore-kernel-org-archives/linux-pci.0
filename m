Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og122.obsmtp.com ([64.18.0.192]:46388 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759303AbbCDTmP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 14:42:15 -0500
Received: by pdbfl12 with SMTP id fl12so28676805pdb.9
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2015 11:42:14 -0800 (PST)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>, Duc Dang <dhdang@apm.com>
Subject: [PATCH v2 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination driver
Date: Wed,  4 Mar 2015 11:39:56 -0800
Message-Id: <cover.1425497218.git.dhdang@apm.com>
In-Reply-To: <1678162.2PJ2o1jRen@wuerfel>
References: <1678162.2PJ2o1jRen@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2688 MSI termination ports coalesced into 16 physical HW IRQ lines
and shared across all 5 PCIe ports.

v2 changes:
        1. Use msi_controller structure
        2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs

 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  61 ++++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 ++
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-xgene-msi.c                   | 393 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       |  25 ++
 7 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1

