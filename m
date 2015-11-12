Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jisheng Zhang <jszhang@marvell.com>, wangzhou1@hisilicon.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hisi: fix deferred probing
Date: Thu, 12 Nov 2015 13:21:37 +0100
Message-ID: <4417267.EzK5DAjM5p@wuerfel>
In-Reply-To: <1447329728-1589-1-git-send-email-jszhang@marvell.com>
References: <1447329728-1589-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The hisi_pcie_probe function is incorrectly marked as __init, as Kconfig
tells us:

WARNING: drivers/pci/host/built-in.o(.data+0x7780): Section mismatch in reference from the variable hisi_pcie_driver to the function .init.text:hisi_pcie_probe()

If the probe for this device gets deferred past the point where __init
functions are removed, or the device is unbound and then reattached to
the driver, we branch into uninitialized memory, which is bad.

This removes the __init annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 35457ecd8e70..163671a4f798 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -111,7 +111,7 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
 	.link_up = hisi_pcie_link_up,
 };
 
-static int __init hisi_add_pcie_port(struct pcie_port *pp,
+static int hisi_add_pcie_port(struct pcie_port *pp,
 				     struct platform_device *pdev)
 {
 	int ret;
@@ -139,7 +139,7 @@ static int __init hisi_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
-static int __init hisi_pcie_probe(struct platform_device *pdev)
+static int hisi_pcie_probe(struct platform_device *pdev)
 {
 	struct hisi_pcie *hisi_pcie;
 	struct pcie_port *pp;

