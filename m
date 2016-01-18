Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54500 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbcARFKE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2016 00:10:04 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 0/4] PCI: rcar, rcar-gen2: More Gen2 compatibility strings
Date: Mon, 18 Jan 2016 14:09:41 +0900
Message-Id: <1453093785-21067-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

this short series adds fallback gen2 and SoC-specific r8a7793 compatibility
strings to the rcar PCI and rcar-gen2 PCIE drivers. The intention is to
provide a complete set of compatibility strings for known Gen2 SoCs.

Bjorn, the intention of the revised changelogs for the r8a7793 is to
address your concerns regarding providing an explanation of why there are
no driver changes. Please consider taking this series through your tree.

Key Changes between v2 and v3:
* Enhance changelog to describe why documenting the r8a7793 is necessary
  and sufficient
* Added acks.

Key Changes between v1 and v2:
* Include "rcar-" in generic bindings

Simon Horman (4):
  PCI: rcar-gen2: add gen2 fallback compatibility string
  PCI: rcar-gen2: add device tree support for r8a7793
  PCI: rcar: add gen2 fallback compatibility string
  PCI: rcar: add device tree support for r8a7793

 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 12 ++++++++++--
 Documentation/devicetree/bindings/pci/rcar-pci.txt      | 14 +++++++++++---
 drivers/pci/host/pci-rcar-gen2.c                        |  1 +
 drivers/pci/host/pcie-rcar.c                            |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.1.4

