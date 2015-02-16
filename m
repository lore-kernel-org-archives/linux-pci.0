Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36743 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbbBPByU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Feb 2015 20:54:20 -0500
Received: by mail-pa0-f42.google.com with SMTP id rd3so31774209pab.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Feb 2015 17:54:20 -0800 (PST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: bhelgaas@google.com
Cc: valentine.barshak@cogentembedded.com, horms+renesas@verge.net.au,
	linux-pci@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH v2] PCI: rcar: Add address check of mem_res
Date: Mon, 16 Feb 2015 10:54:08 +0900
Message-Id: <1424051648-7430-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

lower 16 bits of the address, which is managed by mem_res need to be 0.
This adds address check of lower 16 bits.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 v2: Remove to before devm_kzalloc().

 drivers/pci/host/pci-rcar-gen2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index d9c042f..e9617d3 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -346,6 +346,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	if (!mem_res || !mem_res->start)
 		return -ENODEV;
 
+	if (mem_res->start & 0xFFFF)
+		return -EINVAL;
+
 	priv = devm_kzalloc(&pdev->dev,
 			    sizeof(struct rcar_pci_priv), GFP_KERNEL);
 	if (!priv)
-- 
2.1.3

