Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:46712 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752337AbbKYPav (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2015 10:30:51 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [Resend: PATCH v2 0/3] Fix rcar-pcie for arm64
Date: Wed, 25 Nov 2015 15:30:36 +0000
Message-Id: <1448465439-2132-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first patches fixes the build problem, and the second patch reverts the
patch that removed the driver from arm64 builds. The final patch add a compat
string for the r8a7795 (arm64) device.

Tested on arm Koelsch board, all ok.

Tested on arm64 Salvator-X board using renesas-drivers-2015-10-27-v4.3-rc7 from
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git with PCI
next merged. 
Apart from patches to add the PCIe clock and DT nodes, it also needs this fix:
("PCI: MSI: Only use the generic MSI layer when domain is hierarchical")

Resent with whole series marked as v2 and acks, etc added.

Harunobu Kurokawa (1):
  PCI: pcie-rcar: Add support for R-Car H3.

Phil Edworthy (2):
  PCI: rcar: Convert to DT resource parsing API
  Revert "PCI: rcar: Build pcie-rcar.c only on ARM"

 Documentation/devicetree/bindings/pci/rcar-pci.txt |   3 +-
 drivers/pci/host/Kconfig                           |   3 +-
 drivers/pci/host/pcie-rcar.c                       | 117 +++++++++++++--------
 3 files changed, 77 insertions(+), 46 deletions(-)

-- 
2.5.0

