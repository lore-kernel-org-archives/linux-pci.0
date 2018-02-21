Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34728 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeBUJHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Feb 2018 04:07:17 -0500
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: stop crashing in pci_release_resource v2
Date: Wed, 21 Feb 2018 10:07:15 +0100
Message-Id: <20180221090715.2853-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Is it entirely possible that the BIOS wasn't able to assign resources to
a device. In this case don't crash in pci_release_resource() when we try
to resize the resource.

v2: keep printing the info that we try to release the BAR

Signed-off-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
---
 drivers/pci/setup-res.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e815111f3f81..c0f091614805 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -402,6 +402,10 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 	struct resource *res = dev->resource + resno;
 
 	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
+
+	if (!res->parent)
+		return;
+
 	release_resource(res);
 	res->end = resource_size(res) - 1;
 	res->start = 0;
-- 
2.14.1
