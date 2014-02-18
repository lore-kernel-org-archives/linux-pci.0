Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Magnus Damm <magnus.damm@gmail.com>
To: linux-pci@vger.kernel.org
Cc: horms@verge.net.au, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, valentine.barshak@cogentembedded.com,
	ben.dooks@codethink.co.uk, geert@linux-m68k.org,
	bhelgaas@google.com, Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Feb 2014 11:10:51 +0900
Message-Id: <20140218021051.14164.6194.sendpatchset@w520>
In-Reply-To: <20140218021041.14164.56411.sendpatchset@w520>
References: <20140218021041.14164.56411.sendpatchset@w520>
Subject: [PATCH 01/08] PCI: rcar: check platform_get_irq() return code
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ben Dooks <ben.dooks@codethink.co.uk>

The current code does not check the return from platform_get_irq()
so add an error check and return if this call does fail.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/pci/host/pci-rcar-gen2.c |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/drivers/pci/host/pci-rcar-gen2.c
+++ work/drivers/pci/host/pci-rcar-gen2.c	2014-02-13 09:41:55.000000000 +0900
@@ -308,6 +308,11 @@ static int __init rcar_pci_probe(struct
 	priv->reg = reg;
 	priv->dev = &pdev->dev;
 
+	if (priv->irq < 0) {
+		dev_err(&pdev->dev, "no valid irq found\n");
+		return priv->irq;
+	}
+
 	return rcar_pci_add_controller(priv);
 }
 
