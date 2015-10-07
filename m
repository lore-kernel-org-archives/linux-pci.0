Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:9903 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbJGKt5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 06:49:57 -0400
From: Pavel Fedin <p.fedin@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] PCI: of: Ignore resources with failed translation
Date: Wed, 07 Oct 2015 13:49:21 +0300
Message-id: <4d98be5a58845f8ee0ffdbefb519486986f36bf5.1444214119.git.p.fedin@samsung.com>
In-reply-to: <cover.1444214119.git.p.fedin@samsung.com>
References: <cover.1444214119.git.p.fedin@samsung.com>
In-reply-to: <cover.1444214119.git.p.fedin@samsung.com>
References: <cover.1444214119.git.p.fedin@samsung.com>
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

