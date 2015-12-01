Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42969 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbbLAHZD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 02:25:03 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 0/4] PCI: rcar, rcar-gen2: More Gen2 compat strings
Date: Tue,  1 Dec 2015 16:24:28 +0900
Message-Id: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

this short series adds generic gen2 and soc-specific r8a7793 compat strings
to the rcar PCI and rcar-gen2 PCIE drivers. The intention is to provide
a complete set of compat strings for known Gen2 SoCs.

Simon Horman (4):
  PCI: rcar-gen2: Add generic compatibility string
  PCI: rcar-gen2: Add device tree support for r8a7793
  PCI: rcar: Add Gen2 fallback compatibility string
  PCI: rcar: Add device tree support for r8a7793

 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 12 ++++++++++--
 Documentation/devicetree/bindings/pci/rcar-pci.txt      | 14 +++++++++++---
 drivers/pci/host/pci-rcar-gen2.c                        |  1 +
 drivers/pci/host/pcie-rcar.c                            |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.1.4

