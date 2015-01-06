Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:33019 "HELO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751831AbbAFQVs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 11:21:48 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so31223236pad.15
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2015 08:21:48 -0800 (PST)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>, Duc Dang <dhdang@apm.com>
Subject: [PATCH 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination driver
Date: Tue,  6 Jan 2015 08:15:40 -0800
Message-Id: <cover.1420499393.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
to GIC V2M specification for MSI Termination.

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
block supports 2688 MSI termination ports coalesced into 16 physical HW IRQ lines 
and shared across all 5 PCIe ports.

 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  34 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  21 ++
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-xgene-msi.c                   | 370 +++++++++++++++++++++
 6 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

-- 
1.9.1

