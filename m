Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C52D0602
	for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775881871; cv=none; b=lUnP0DDnQtKnEfQCHzHvm2H1rbGiM3OSh3wD5L3oyO/E9yYKxgIMMCadNjt7W52uPsKcwE8ZKQAmmpCf8xx+i38sbxuPkDMdGYewDvIeDRL3mryl28ZVF7xXzvqHb0TgZN/kbj4GK8ShnUOEJ1YEyuW2RFqLoxfUP+Uib8J/CUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775881871; c=relaxed/simple;
	bh=rbUVWUb0Jq6cPmVmgVEV+mE+Ap478DVsTL2CSDpobZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4EiczuGR1NoT8ZOsUEMgnA2aNWEWmuJYXm6Mh6k0DwT+rgTDVhf2bCYUmqHDJ39TmoFddh2D9QgSTMLM+dc+9aL5G9dgG7n/j2hc33rhxab88XH++hXIic+Tx0fDwXIEgLXfQupExF6R8Jm72fpZEZgbhi2R3RsSZeGVwcro3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDKfRRC7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDKfRRC7"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso2137262a91.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 21:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775881869; x=1776486669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BD+xwKu/bN5/gMMBjSUYvF/EGDAVlZJDs5yWBOqQPgU=;
        b=EDKfRRC7959g4/kNN7nuhw4PvVZNGdBq8gQ4S+m6N6Wkr6132V8SOOQeuV2U1bBQt0
         h4gb6pr2P+9iBf4H4GgxlT9KKY9IQLRjJrDbK4JL1GU4GXgO3anLY2iBdeqQX5TASdoH
         rZWYwX01GGTUHUsDASBzgw0o+R4/R3oOTNjUoDfvIvwuhLzq4bdzO6IFPUQsdQwbnzcZ
         RAtlw+5AG/QoHDfj/HyxQ8/4ucGIvRjsCIBuLuQWMiz6CCRAbsrjZp6uLbny/xLOYyia
         tMJHL2A/r0zcjGdknVTIF+081F0Dd6xlv/Xf5IoR6LsyZlbaRqOaHyZswCuEoYEhJ6Y3
         Nnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775881869; x=1776486669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD+xwKu/bN5/gMMBjSUYvF/EGDAVlZJDs5yWBOqQPgU=;
        b=eDHfy7DU6dNVkL8VDViSgWCs0UXZftUMI6jXAGLowJxOCla4yYKQ2xn7MP/cS4pyNl
         ufKfY3j34HkoIevUEgmk5Sug2Z16exEZLkX4KqXH9rjOGwUjLlTJbSbnTdC5aw/moAlV
         dBECvWfQXFBrvcHKLIPvKqv5xSRmOSr80aAFtrSgWIAiDTHFp4brIy77C5eFeUUE8brL
         9iG7Fm7j7w3OD609amXOZ/yhm6vGuvK66IeWrJeYfyTNjkuvRq4vk/cnC++9EqGX1fDd
         9G1boYJqAm/NYMo+jSM7bhppHAhAe4pC57OaON08zRSywFhlDBeR4oZXb7zDvQRn2Kdk
         WFZw==
X-Gm-Message-State: AOJu0Yz0UsSVrXv19GJmWWFwug63wdgV0qaPtTtva5x8E4XldZDHUMwR
	/6jGQY/Iy+Rh0UibUSNp1pHe5J2pC24QHzdIpqu0zeGB+NyVdqFfRpG0blUr3cJ4
X-Gm-Gg: AeBDieueqrw5xCnVvnJt8IFjwCWu93RdxR2UV0nVRkeY8A82r+7p+OenNnGqgyThdw3
	2z9FaDxY3RKkWLu2ewb04Vo52iw/x7Rcat76XzbjRfJddTf00Ph2wUqTo2Cg5XW5/4t/7ZDvOIO
	29Veh4BfgBVV+ANTJnyRbby0hppN4fKZrHScL09+q2tlsb3DrmvRmpMZqYuS1gCSybXRRBMhN2j
	3Ob1h5hsjAEt3we2vsl/TOoytgynaJByPdtGuWv3GrPHnxMRtuYBQzKHHm4tp764AP6SB7O/2LC
	n63mWrCWhPA8gXk1l1T6CXF375hEvENx9zJPmTLIhG4qAHYebxFDrxHUuxP0mVlZTC+HPUWEkOO
	VySoP47ps41pCGeRRDxUir80ij4uOmQSA9XafUqv5E1UprAMmbItEJmJuhgY38QL1fceX53YXmI
	MRV3Y9+C19W4UZVscgFl37mtPSRVaMNWv9K/hGEHW78Qqi+J4IoFdP7N4=
X-Received: by 2002:a17:90a:dfc7:b0:35b:e52a:6fe5 with SMTP id 98e67ed59e1d1-35e4274e358mr5585311a91.5.1775881869282;
        Fri, 10 Apr 2026 21:31:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f27asm8038120a91.10.2026.04.10.21.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 21:31:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR MVEBU (Marvell Armada 370 and Ar...),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] PCI: mvebu: allocate ports with pcie struct
Date: Fri, 10 Apr 2026 21:30:51 -0700
Message-ID: <20260411043051.174309-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations and simplify
slightly.

Add __counted_by for extra runtime analysis.

Needed to move mvebu_pcie struct below others as flexible array members
require full definitions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pci/controller/pci-mvebu.c | 33 ++++++++++++------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a72aa57591c0..dea50f6e88be 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -78,18 +78,6 @@
 #define PCIE_DEBUG_CTRL         0x1a60
 #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
 
-struct mvebu_pcie_port;
-
-/* Structure representing all PCIe interfaces */
-struct mvebu_pcie {
-	struct platform_device *pdev;
-	struct mvebu_pcie_port *ports;
-	struct resource io;
-	struct resource realio;
-	struct resource mem;
-	int nports;
-};
-
 struct mvebu_pcie_window {
 	phys_addr_t base;
 	phys_addr_t remap;
@@ -125,6 +113,16 @@ struct mvebu_pcie_port {
 	int intx_irq;
 };
 
+/* Structure representing all PCIe interfaces */
+struct mvebu_pcie {
+	struct platform_device *pdev;
+	struct resource io;
+	struct resource realio;
+	struct resource mem;
+	int nports;
+	struct mvebu_pcie_port ports[] __counted_by(nports);
+};
+
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
 {
 	writel(val, port->base + reg);
@@ -1455,11 +1453,13 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	struct device_node *child;
 	int num, i, ret;
 
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
+	num = of_get_available_child_count(np);
+	bridge = devm_pci_alloc_host_bridge(dev, struct_size(pcie, ports, num));
 	if (!bridge)
 		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(bridge);
+	pcie->nports = num;
 	pcie->pdev = pdev;
 	platform_set_drvdata(pdev, pcie);
 
@@ -1467,12 +1467,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	num = of_get_available_child_count(np);
-
-	pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
-	if (!pcie->ports)
-		return -ENOMEM;
-
 	i = 0;
 	for_each_available_child_of_node(np, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
@@ -1488,7 +1482,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		port->dn = child;
 		i++;
 	}
-	pcie->nports = i;
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
-- 
2.53.0

