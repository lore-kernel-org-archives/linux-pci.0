Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jisheng Zhang <jszhang@marvell.com>
To: <bhelgaas@google.com>, <thierry.reding@gmail.com>,
	<swarren@wwwdotorg.org>, <gnurou@gmail.com>, <tinamdar@apm.com>,
	<rjui@broadcom.com>, <sbranden@broadcom.com>,
	<linux@arm.linux.org.uk>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [RFC PATCH 1/3] PCI: iproc: generate proper configuration access cycles
Date: Mon, 26 Oct 2015 19:02:12 +0800
Message-ID: <1445857334-6936-2-git-send-email-jszhang@marvell.com>
In-Reply-To: <1445857334-6936-1-git-send-email-jszhang@marvell.com>
References: <1445857334-6936-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Inspired by Russell King's patch[1], I found current iproc also has the
same issue of "reading 32-bits from the command register, modifying the
command register, and then writing it back has the effect of clearing
any status bits that were indicating at that time" as pointed out by
Russell. This patch fix this issue by using the pci_generic_config_write.

[1]http://www.spinics.net/lists/linux-pci/msg44869.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index fe2efb1..0c423f2 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -111,7 +111,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 static struct pci_ops iproc_pcie_ops = {
 	.map_bus = iproc_pcie_map_cfg_bus,
 	.read = pci_generic_config_read32,
-	.write = pci_generic_config_write32,
+	.write = pci_generic_config_write,
 };
 
 static void iproc_pcie_reset(struct iproc_pcie *pcie)
-- 
2.6.2

