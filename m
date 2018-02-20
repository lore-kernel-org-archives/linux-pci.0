Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36290 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeBTI6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Feb 2018 03:58:16 -0500
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: stop crashing in pci_release_resource
Date: Tue, 20 Feb 2018 09:58:13 +0100
Message-Id: <20180220085813.1897-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Is it entirely possible that the BIOS wasn't able to assign resources to
a device. In this case don't crash in pci_release_resource() when we try
to resize the resource.

Signed-off-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
---
 drivers/pci/setup-res.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e815111f3f81..fd72c87a9b72 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -401,6 +401,9 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = dev->resource + resno;
 
+	if (!res->parent)
+		return;
+
 	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
 	release_resource(res);
 	res->end = resource_size(res) - 1;
-- 
2.14.1
