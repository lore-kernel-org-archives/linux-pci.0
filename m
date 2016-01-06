Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50302 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbcAFKuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 05:50:16 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 0/2] DRA72/DRA74: Add 2 lane support
Date: Wed, 6 Jan 2016 16:19:51 +0530
Message-ID: <1452077393-25880-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add driver modifications in pci-dra7xx to get x2 mode working in
DRA72 and DRA74. Certain modifications is needed in PHY driver also
which will be sent as a separate series.

Certain board modifications has to be done in order to test
x2 mode in dra72-evm.

These patches were created on pci next.

Changes from RFC:
*) .b1co_mode_sel_mask is now set with the correct value.
*) cleanup the patch

Kishon Vijay Abraham I (2):
  pci: host: pci-dra7xx: use "num-lanes" property to find phy count
  pci: host: pci-dra7xx: Enable x2 mode support

 Documentation/devicetree/bindings/pci/ti-pci.txt |    8 +-
 drivers/pci/host/pci-dra7xx.c                    |  104 +++++++++++++++++++---
 2 files changed, 97 insertions(+), 15 deletions(-)

-- 
1.7.9.5

