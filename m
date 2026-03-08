Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CF246766;
	Sun,  8 Mar 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980031; cv=none; b=okG8p2YrsfgSfDregy5iwrAmdzqfdJPdUuGcW4ln+T84caBOzX0QYug3i/RP1fFoswtp0nxawlwwpgIT7OWZfQlYKdswy/2I3qE5hZvLWJ9cGWhGGk8O7EoW6pLlWpy+suYXh5dDRbENrN4dfkgpMPujPWsUeNRQ66OixcPzQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980031; c=relaxed/simple;
	bh=ggv8LR4D/yQxAWF7+RgB5GP8kBk2+UCqg/5P37oACro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnOGaGe5gO1GLqSKR+gkcsXxAktUB/mSpkQZus7AfpzVS367hj0GR2dnYPdxwAIOwEEBqTcWSrFJIEe+fM6UaqgN5yZ/ru7LSzqX5G7mpPCuFcdZ6cbhyabjps68a11vX0BEulBvaazwN6Bi33Zun31GAgcma4lT9UvWEJIz4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o4qdYj27; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o4qdYj27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3/
	Sr7eoKmewnFYNnKaOIn6qNFO6oVK9eKn1QEhGhTeE=; b=o4qdYj27WV5HYucj/z
	PcBRB4MTKAJ0j3CxigTycDdGqymO/uPnkqI4MuvXYSouUePWSFIu2lL1e65mXH8h
	k25c05gDVu50Z67aK8WbV7sG/YTFy0CIre6vtYOQfKrl0HFTi2X9Slr4J6umUDV3
	pmQFZNZLOicN3qNEqLUBdus2U=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBXlAEXh61pUWlUOw--.24999S4;
	Sun, 08 Mar 2026 22:26:33 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
Date: Sun,  8 Mar 2026 22:26:29 +0800
Message-Id: <20260308142629.75392-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260308142629.75392-1-18255117159@163.com>
References: <20260308142629.75392-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXlAEXh61pUWlUOw--.24999S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW7Zr15WFykGFy8GryDKFg_yoW8Kr15pa
	yUArWruFyUJFW3WF45Aay5Z3WY9Fn5GrZ8J39xW3Z29r9xJrnIqFy0qryfAryIkFsFvr17
	Gw17tF17Ca12y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRebyAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xmtUWmthxn6kwAA39

With the removal of hardcoded upper bound in of_pci_get_max_link_speed(),
the DWC driver must now validate the retrieved speed value before using
it as an index into the pcie_link_speed array. Invalid values (missing,
out of range, or mapping to PCI_SPEED_UNKNOWN) could lead to out-of-bounds
access or incorrect link configuration.

Introduce dw_pcie_get_link_speed() to handle the property retrieval and
validation. If the property is missing or invalid, fall back to Gen1 (1)
and issue a warning. This ensures safe operation while allowing future
PCIe generations to be supported without code changes in the validation
logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 29 +++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..e10cd7a0fee1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -110,6 +110,33 @@ static int dw_pcie_get_resets(struct dw_pcie *pci)
 	return 0;
 }
 
+static void dw_pcie_get_link_speed(struct dw_pcie *pci)
+{
+	struct device_node *np = dev_of_node(pci->dev);
+	int max_speed;
+
+	max_speed = of_pci_get_max_link_speed(np);
+	if (max_speed < 0) {
+		dev_warn(pci->dev,
+			 "Failed to get max-link-speed, using default (Gen1)\n");
+		pci->max_link_speed = 1;
+		return;
+	}
+
+	/* Validate against known speeds in pcie_link_speed */
+	if (max_speed == 0 ||
+	    max_speed >= ARRAY_SIZE(pcie_link_speed) ||
+	    pcie_link_speed[max_speed] == PCI_SPEED_UNKNOWN) {
+		dev_warn(pci->dev,
+			 "Invalid max-link-speed %d, using default (Gen1)\n",
+			 max_speed);
+		pci->max_link_speed = 1;
+		return;
+	}
+
+	pci->max_link_speed = max_speed;
+}
+
 int dw_pcie_get_resources(struct dw_pcie *pci)
 {
 	struct platform_device *pdev = to_platform_device(pci->dev);
@@ -189,7 +216,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 	}
 
 	if (pci->max_link_speed < 1)
-		pci->max_link_speed = of_pci_get_max_link_speed(np);
+		dw_pcie_get_link_speed(pci);
 
 	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
 
-- 
2.34.1

