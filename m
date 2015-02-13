Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35343 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbbBMHzy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Feb 2015 02:55:54 -0500
Received: by pdbfl12 with SMTP id fl12so17807387pdb.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2015 23:55:54 -0800 (PST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: bhelgaas@google.com
Cc: valentine.barshak@cogentembedded.com, horms+renesas@verge.net.au,
	linux-pci@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] PCI: rcar: Add address check of mem_res
Date: Fri, 13 Feb 2015 16:55:38 +0900
Message-Id: <1423814138-18748-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

lower 16 bits of the address, which is managed by mem_res need to be 0.
This adds address check of lower 16 bits.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/pci/host/pci-rcar-gen2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index d9c042f..13b2793 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -351,6 +351,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	if (mem_res->start & 0xFFFF)
+		return -EINVAL;
+
 	priv->mem_res = *mem_res;
 	/*
 	 * The controller does not support/use port I/O,
-- 
2.1.3

