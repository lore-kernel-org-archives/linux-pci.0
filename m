Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34688 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcA2ORX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2016 09:17:23 -0500
Received: by mail-wm0-f51.google.com with SMTP id 128so54759122wmz.1
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2016 06:17:22 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
	linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, mark.brown@linaro.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] PCI: generic: map config window in one go
Date: Fri, 29 Jan 2016 15:17:15 +0100
Message-Id: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of iterating over the PCI config window and performing individual
ioremap() calls on all the adjacent slices, perform a single ioremap() to
map the entire region, and divvy it up later. This not only prevents
leaving some of it mapped if we fail half way through, it also ensures that
archs that support huge-vmap can use section mappings to perform the
mapping.

On my Seattle A0 box, this transforms 128 separate 1 MB mappings that are
mapped down to 4 KB pages into a single 128 MB mapping using 2 MB sections,
saving 512 KB worth of page tables.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

huge-vmap for arm64 proposed here:
http://article.gmane.org/gmane.linux.kernel.hardened.devel/1661
 
 drivers/pci/host/pci-host-generic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 1652bc70b145..3251cd779278 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -161,6 +161,7 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 	struct device *dev = pci->host.dev.parent;
 	struct device_node *np = dev->of_node;
 	u32 sz = 1 << pci->cfg.ops->bus_shift;
+	void *window;
 
 	err = of_address_to_resource(np, 0, &pci->cfg.res);
 	if (err) {
@@ -186,14 +187,15 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 		return -ENOMEM;
 
 	bus_range = pci->cfg.bus_range;
+	window = devm_ioremap(dev, pci->cfg.res.start,
+			      (bus_range->end - bus_range->start + 1) * sz);
+	if (!window)
+		return -ENOMEM;
+
 	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
 		u32 idx = busn - bus_range->start;
 
-		pci->cfg.win[idx] = devm_ioremap(dev,
-						 pci->cfg.res.start + idx * sz,
-						 sz);
-		if (!pci->cfg.win[idx])
-			return -ENOMEM;
+		pci->cfg.win[idx] = window + idx * sz;
 	}
 
 	return 0;
-- 
2.5.0

