Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35648 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933337AbcECB0U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2016 21:26:20 -0400
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] pci: host: Broadcom STB PCIE RC controller support
Date: Mon,  2 May 2016 18:25:47 -0700
Message-Id: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

This patch series adds support for Broadcom STB SoC's PCIe root complex driver.

This was primarily tested on BCM7445 (ARM) and BCM7435 (MIPS).

Jim is the original author, and I picked up our downstream 4.1 driver and
updated it to utilize the non-ARM hw_pci functions as well as made some
stylistic changes.

Thanks!

Jim Quinlan (2):
  Documentation: DT: bindings: Add Broadcom STB PCIe bindings
  pci: host: Add Broadcom STB PCIE RC controller

 .../devicetree/bindings/pci/brcm,brcmstb-pcie.txt  |   81 ++
 MAINTAINERS                                        |    1 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-brcmstb.c                    | 1243 ++++++++++++++++++++
 5 files changed, 1335 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
 create mode 100644 drivers/pci/host/pcie-brcmstb.c

-- 
2.1.0

