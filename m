Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nsekhar@ti.com>, <kishon@ti.com>
Subject: [RFC PATCH 0/2] DRA72/DRA74: Add 2 lane support
Date: Mon, 28 Sep 2015 18:27:36 +0530
Message-ID: <1443445058-643-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add driver modifications in pci-dra7xx to get x2 mode working in
DRA72 and DRA74. Certain modifications is needed in PHY driver also
which I'll send as a separate series.

Kishon Vijay Abraham I (2):
  pci: host: pci-dra7xx: use "num-lanes" property to find phy count
  pci: host: pci-dra7xx: Enable x2 mode support

 Documentation/devicetree/bindings/pci/ti-pci.txt |    7 +-
 drivers/pci/host/pci-dra7xx.c                    |  104 +++++++++++++++++++---
 2 files changed, 97 insertions(+), 14 deletions(-)

-- 
1.7.9.5

