Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jisheng Zhang <jszhang@marvell.com>
To: <thomas.petazzoni@free-electrons.com>, <jason@lakedaemon.net>,
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/2] PCI: mvebu: trivial cleanup
Date: Wed, 16 Mar 2016 17:59:39 +0800
Message-ID: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

trivial clean ups to pci-mvebu.c

Jisheng Zhang (2):
  PCI: mvebu: constify mvebu_pcie_pm_ops structure
  PCI: mvebu: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for mvebu_pcie_pm_ops

 drivers/pci/host/pci-mvebu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.7.0
