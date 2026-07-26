Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20A189F43
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785102963; cv=none; b=JlePoQMruMW+kla560vx7Zbi1SIjc5RbO1g/KzuZgaHQMzumK6uElrDz1MM54wHYYCSa7/DM/vmYhyDiCtbY+ZI7DweAT1DHZj8bSjhXCCKxvdcE3D25F0IKEU+mr9jopyG8vUrshWhBDkPJhCJ3GD4eLZMSg2+zB2WTgjDqsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785102963; c=relaxed/simple;
	bh=DyOiMg7T+EusRWfZOofWAwaAWMZzWoQ2JovRL9DbF2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urvl8Q5Y6z6Uss/zhYgzVG8BwrF2YDr8H6IgyavwfhHsCZ3UjMjrBJoohcjBkXSgbmrvqrGb5iKbDNDdo/G5AKpzJRVFiOPn7XTf9a+edAqZe7e0KJF8bsZM7UNjkVi7Jc+QZNjFh2SACF+PbqECmqNuXh7KUnZ5DQ4ZUZOzizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6Wcl6yF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Wcl6yF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1497486a91.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785102962; x=1785707762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tYa3vEt1DiiFt5roobZR/K438UfRZKbfVJpeTjMU8QI=;
        b=E6Wcl6yFwYLKTWlqytdWRPk4nhk55xojhO2Mo1xJGjs93S5UGXEBgBqMpa0PRRySzH
         YRzoU5YVMrykt8YyYrh5SfwMEV+zsRuH9bCiL4oUaraN1sF0QoBycwACvSpE3cTtfS6A
         TPDgPPBZuwNupmppmYkSSMS9A9yh+7I7KzBSqNFnoAh4Je8k+8iO+1nkFYKsroOFaCO+
         yHt8wJqD6R3FUqxLaHcc2tHHpoYTaR7CBvaeU8z/jf/lx47fJyFYTJimjFQTWvpsKeiy
         SYx8G99hS3Qc6CatSOiiDOc3cibpnTBQp0wANDetbGaVGjqglTNpE0mhh13ixbdDkOls
         oe9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785102962; x=1785707762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tYa3vEt1DiiFt5roobZR/K438UfRZKbfVJpeTjMU8QI=;
        b=Cal3Fq3LmjUy4tKh7C2AcAJjz8RIk5P4yxN43gjYz5fusi4ufNyGB8rbxet9y5b+Wg
         d5ugD2ODPxe6HicU3fSNVpc8Jtg+d0c9Zei7uwVJltMTHwHkzvNOhakM8Ewmy8dMA/+I
         VvTzM3ZChS5lFscmLI+Tt1fc9fgQhicOP1PaR5Jn2eshvaSU2Z2/QZLE/5FNKsxCpq/P
         uat1PJn3MSh2y+LI6WDMObux6zagVejIxtHSjjhpE4CHsg6jCosDUvBRzYY1jOJuZUkS
         QFG/dkgCQIdJZlpNm2jvLudQJwa+Fb5aUVZdEB9HQdDUnHFGd+rOq7bG+lw+K3CbKR3w
         aI8g==
X-Gm-Message-State: AOJu0Yy5KIml5R3CDYJzEPvHyI/Nib/XNkEoMG3k2AvQqDpJb2whb9T9
	FFqnhy+UUmX0TfoJswqZIkFUQRQcjC/njL5tH/eK3BqaPX8t5nEoYqbZ7W4HjQ==
X-Gm-Gg: AR+sD12xPpda+PoH8Dcmvz5/1i0+K+xKjjDLmOk6+nTV1DtCsuoPpdLjdeP5TgTatsO
	+w8Y0ECxLc0Bq/V1zq/ytQfOA8dcr7vfNXZadj1gWV/yJa7gYN0rB0iJ2QcwQzIxScOjeI8Sl12
	eFnX+rf02NogrDhrIGp1JCmgr1vsl++J/J29GMKoUFhYuualasfDa8b5OaPnKkFg6sn7c7sVK8i
	+otVDruWb/HaRN5HVsZ3VXJXu/tdq8OWdqbZGKoiYXfS8i3kbwUA6iZ1I5wZqB+P0Yoev3j8IBr
	06Dq2TpBcaNVSXlDo0zub4+3fk3bYAF4okhmcsi7HddpIQuwWvuVEeHu8JsPg7t+V+aJp5SYESz
	CLzl6rdcdbQ3jFMCUFQYBvgQtpw8qFv/hvazBVsjMFKzVwTHfyykJyZqL35ULrpIfayWEUIl8sO
	jIiSSjlyQHNxNP0wxTQgSuDDtda6cOpAjhRLW1kqJn0xH41yLshpT1Xiv9JZq4clhqN+qZqbas2
	uTReJmdfIomS1tzcUObfncQ/xLiTr4BKZbRqpMv+kyKqyDflZFyBtD2zqvdYMjd3kHCWdAkb0nz
	iSPix+xT3uclSOtOU1ARvWNpcA+xCc/cGXnHgA==
X-Received: by 2002:a17:90b:5106:b0:38e:59c2:cbc5 with SMTP id 98e67ed59e1d1-38f29522109mr5856966a91.18.1785102961837;
        Sun, 26 Jul 2026 14:56:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f041bec23sm4087480a91.15.2026.07.26.14.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 14:56:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: iproc: platform: use device functions instead of OF.
Date: Sun, 26 Jul 2026 14:55:58 -0700
Message-ID: <20260726215558.34091-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this is supposed to be the higher layer file, use higher layer
than OF to handle this. Remove OF headers as a result.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pci/controller/pcie-iproc-platform.c | 31 ++++++++------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 4c9a0c4bb923..abd04a05fbff 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -10,12 +10,8 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_pci.h>
-#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 
-#include "../pci.h"
 #include "pcie-iproc.h"
 
 static const struct of_device_id iproc_pcie_of_match_table[] = {
@@ -40,11 +36,14 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iproc_pcie *pcie;
-	struct device_node *np = dev->of_node;
-	struct resource reg;
+	struct resource *reg;
 	struct pci_host_bridge *bridge;
 	int ret;
 
+	reg = platform_get_resource(pdev, 0, IORESOURCE_MEM);
+	if (!reg)
+		return -ENODEV;
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
@@ -52,26 +51,20 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->type = (uintptr_t)of_device_get_match_data(dev);
-
-	ret = of_address_to_resource(np, 0, &reg);
-	if (ret < 0) {
-		dev_err(dev, "unable to obtain controller resources\n");
-		return ret;
-	}
+	pcie->type = (uintptr_t)device_get_match_data(dev);
 
-	pcie->base = devm_pci_remap_cfgspace(dev, reg.start,
-					     resource_size(&reg));
+	pcie->base = devm_pci_remap_cfgspace(dev, reg->start,
+					     resource_size(reg));
 	if (!pcie->base) {
 		dev_err(dev, "unable to map controller registers\n");
 		return -ENOMEM;
 	}
-	pcie->base_addr = reg.start;
+	pcie->base_addr = reg->start;
 
-	if (of_property_read_bool(np, "brcm,pcie-ob")) {
+	if (device_property_present(dev, "brcm,pcie-ob")) {
 		u32 val;
 
-		ret = of_property_read_u32(np, "brcm,pcie-ob-axi-offset",
+		ret = device_property_read_u32(dev, "brcm,pcie-ob-axi-offset",
 					   &val);
 		if (ret) {
 			dev_err(dev,
@@ -87,7 +80,7 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	 * core driver. For platforms that require explicit inbound mapping
 	 * configuration, "dma-ranges" would have been present in DT
 	 */
-	pcie->need_ib_cfg = of_property_read_bool(np, "dma-ranges");
+	pcie->need_ib_cfg = device_property_present(dev, "dma-ranges");
 
 	/* PHY use is optional */
 	pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
-- 
2.55.0

