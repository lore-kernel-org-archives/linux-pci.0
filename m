Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2573A9DA3
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195853; cv=none; b=h77hgB9dc2Aor9qOJI5d2joX+cyYXilRRV4RftJm7Vk2SyXnPxYP+RiSSlYSiCoH2FjEks0lntYRDwgvyFa+yN6We4+lD3fdxgvATWXXDxsCOswFYq+VNqYXq89b7/p8ke06/kASFjDFVwIaCIRoyk6GrkQieBhHMgYA5efyB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195853; c=relaxed/simple;
	bh=oQiO8LuB4o9YTwTiwf50U8fjZhOlqBBbq+6KnJ4AqQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kld9peVtETRqy9naHwQLNK6RZQB4mhvTO32virjyMmyuubXcBwiJUOl6JGHkaaC2A92Vr2KgC2drqVEawSKd1rzM4MnmSevpdL163FzUoNV9rw3J55eohHkrE5793CqWCkBFncl4Ly7eYqjJemtQTrb+R5lMpA935b+127gpv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDRK2NS3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDRK2NS3"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so21284096d6.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785195851; x=1785800651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bOyY/7st0w/fOk4vhmzD7NcnvHphtli0+U32ViasH6Q=;
        b=dDRK2NS3M6xliijGlNkiI6DkNovueKbYSEFvfBOSvuBCKwjypvf9ju95Xaz7wM+220
         EgGpQJzmfGsmSTpEqyqH5qUhGhvp9YE7ncOcF2wFboTKnOxIwS8zztkW55hsY7hcIhPC
         rdhNGOhhM6D9flVFgaUpmhxmkoCpALWxMrvSlasVUbJvIfsjtqXE8gDVBmH+6szOI/Xh
         31tuY3z3SsHG0zqPHoCLxS4SAYH780RbKydQ8pDPZwJqGvn4Tz162DOapxOoGQvmNiKH
         jpjWackvBSiIjPJVxLik8H6DAvMgGxQRty+W92NSFEpYCouGQ//W9T7JE7bh8rPHfv6l
         PMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195851; x=1785800651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bOyY/7st0w/fOk4vhmzD7NcnvHphtli0+U32ViasH6Q=;
        b=UT220Cf48QSqY7gqkzlpR/b5O1zXuxWgvbtWB9hCzYXuIIVffzebG7e0CB804lOmQm
         P3YP0sLn3ZIKTDXj4lywQplMmAWJ725qqvHf50KqIkveEh5VdH4W2YVGOpJxojXhoHpK
         CiICFiV0uLjn12hH7j+wN/u3LeW3K56Fscrtw9jA9H+C0lDFZETSfDS0SVa+FJm9EGgC
         yCYvRSW/ag6mBSfm5yvDjv0y9H1ymzqAde2Ht3GHK7n5/XbIJug/ckUUOWaDMTV+05EO
         1028VNmwW1GCGezyssNbf3+vdy1c/FoSsGECxo9qaG/RN0nvsjb13HA18CyGZoZ6nM62
         XaNA==
X-Gm-Message-State: AOJu0Yyi/wPcNNNtcSLZ28G72tAG1m7K5UAvUQW2fbY9Dvx0uJKzVBcQ
	nhJpUqb26Lj5ZMQjDRc27eit/ctFlpRQtenl5i7cYsSLNOAtC9q2AnFLYO1jl1lb
X-Gm-Gg: AR+sD10N5w+K5RDyFd38gOiMBv5kWRnPow4JrRrrrS4jlzdtr/ZQf59JTAm/+uvV391
	HDudYEZhN0bQDu7wRXaAnwkQpnAByacmG/ed6ii9PPFOZUaWQ2JsZaOg8qYblFj8+rQOoWEXf7G
	s/uOUEHRQF5sEx7fmOFRi+uaitwbS3ugoj+QKHfOmOg3Q0saswIZKnWCpMibSonRt9IoSsHVeFo
	dL//znAOvHiVBKgOQ8DabW1qRrLuv4TYqY3m/x7MmPJlfqqrCxuKVjbx4J1xSWZKsNluashQTW/
	v1RhoGCkex+JEjikfwNYNHbfj9m9lwBoVGjXZ8CPeGDtl/km6gBH1TGza9+gGXWspfQhCUsJ2Il
	ruWRzDD/bs9bFflQFJ5c60J+mVmrFAjL+iPIXHJxiFuONSiduq3AwPsSAfv8ha9p5UsKspBStz5
	d5dsSGoBUtvKsTc0eL1Gid8mMQ4m2+s2oxtaf605/nSimRxG29nj/Jmr7rEh7z0u0+IB/qZULcE
	E6BjO0D4GRcvgcvlIoUCG+1h/1Q99a5BjImiKv7hc6u7NJOk53A7oU=
X-Received: by 2002:a05:6214:5b0c:b0:8e9:f62b:8f91 with SMTP id 6a1803df08f44-907ec8ec1f3mr123698276d6.55.1785195851166;
        Mon, 27 Jul 2026 16:44:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e854e43csm75945226d6.16.2026.07.27.16.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:44:10 -0700 (PDT)
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
Subject: [PATCHv2] PCI: iproc: platform: use device functions instead of OF.
Date: Mon, 27 Jul 2026 16:44:08 -0700
Message-ID: <20260727234408.296186-1-rosenp@gmail.com>
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
 v2: fix platform_get_resource() parameters.
 drivers/pci/controller/pcie-iproc-platform.c | 31 ++++++++------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 4c9a0c4bb923..488ff737ec52 100644
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
 
+	reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
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

