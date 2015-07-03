Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43005 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755145AbbGCLDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Jul 2015 07:03:54 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kishon@ti.com>
CC: <nsekhar@ti.com>
Subject: [PATCH 0/3] J6/J6Eco: Add PM support to PCIe
Date: Fri, 3 Jul 2015 16:33:42 +0530
Message-ID: <1435921425-15121-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds PM support to pci-dra7xx so that PCI clocks can be disabled
during suspend and enabled back during resume without affecting
PCI functionality.

This series is dependent on [1] for proper PM functionality.

[1] -> http://newscentral.exsees.com/item/595269de5c35c59c386b91ce8efd9872-eedf6742bb6159c3b1a90625c4d43407

Kishon Vijay Abraham I (3):
  PCI: host: pci-dra7xx: Disable pm_runtime if get_sync failure
  PCI: host: pcie-designware: add support for suspend and resume
  PCI: host: pci-dra7xx: add pm support to pci dra7xx

 drivers/pci/host/pci-dra7xx.c      |   78 +++++++++++++++++++++++++++++++++++-
 drivers/pci/host/pcie-designware.c |   20 +++++++++
 drivers/pci/host/pcie-designware.h |    2 +
 3 files changed, 99 insertions(+), 1 deletion(-)

-- 
1.7.9.5

