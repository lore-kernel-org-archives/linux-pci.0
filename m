Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:39229 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbbJHHYf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 03:24:35 -0400
From: Pavel Fedin <p.fedin@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>
Subject: [PATCH v2 2/2] PCI: of: Ignore resources with failed translation
Date: Thu, 08 Oct 2015 10:24:26 +0300
Message-id: <3604931244806840dd12ff9663671b52d2acd951.1444288748.git.p.fedin@samsung.com>
In-reply-to: <cover.1444288748.git.p.fedin@samsung.com>
References: <cover.1444288748.git.p.fedin@samsung.com>
In-reply-to: <cover.1444288748.git.p.fedin@samsung.com>
References: <cover.1444288748.git.p.fedin@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch allows PCI host controller to function even if part of resources
is unusable for some reason. An example is non-LPAE kernel on a machine
which has some 64-bit resources. Unusable resources will be just skipped
instead of a complete failure.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 drivers/of/of_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 5751dc5..ea7c2b6 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -223,8 +223,10 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 		}
 
 		err = of_pci_range_to_resource(&range, dev, res);
-		if (err)
-			goto conversion_failed;
+		if (err) {
+			kfree(res);
+			continue;
+		}
 
 		if (resource_type(res) == IORESOURCE_IO) {
 			if (!io_base) {
-- 
2.4.4

