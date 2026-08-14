Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4293C343F;
	Fri, 14 Aug 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716837; cv=none; b=phFVHon85tWb0qICpoHkTAsdabQpbb5UOZLqH9c2eI97swB/OJpEwtVquMd9efkd1YWMFRYOZF1hEW35sgChMeDvSVZq8Oe2bcbvfumtLkbACr1suDmtSvjvdggJFK/Vg4pitYmVWUWgThT5Ej0fQoShg4YMPp3DqfQB1t6xq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716837; c=relaxed/simple;
	bh=cdaaO0MILmavqVHrTibl9ggosXP3A3b0dhjPdWpBX+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swl6w9+Qe+3th81nPRXKoxwhe2aUuyqSz0n7U2LHng2QzQp405bFYg2IuCZe/LGMxPDOTCMZoWCrQ/sxM+n8PGEz8JlXKYIIWMP7pqTbi8Kqum1kbBF1rbiHPiBnEp/xlGPDVLek8Ulz7RFybg3UowjigW479r1Xdihr18Ifh2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04D21F00ACA;
	Fri, 14 Aug 2026 14:13:40 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 6/7] PCI: rzg3s-host: Move IRQ domain setup code
Date: Fri, 14 Aug 2026 17:13:11 +0300
Message-ID: <20260814141312.2947972-7-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Subsequent patches add support for the event IRQ to handle link
up/down events. The event IRQ handler will use
rzg3s_pcie_set_max_link_speed(). In preparation for adding event IRQ
support, move the IRQ domain initialization code after
rzg3s_pcie_set_max_link_speed().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 147 +++++++++++------------
 1 file changed, 73 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 834b03d56713..4765ac1befba 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1006,80 +1006,6 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host,
-				     int count)
-{
-	while (--count >= 0) {
-		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
-						 NULL);
-	}
-
-	if (host->intx_domain)
-		irq_domain_remove(host->intx_domain);
-}
-
-static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
-{
-	struct device *dev = host->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	int i, ret;
-
-	for (i = 0; i < PCI_NUM_INTX; i++) {
-		char irq_name[5] = {0};
-		int irq;
-
-		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
-
-		irq = platform_get_irq_byname(pdev, irq_name);
-		if (irq < 0) {
-			ret = irq;
-			dev_err_probe(dev, ret,
-				      "Failed to parse and map INT%c IRQ\n",
-				      'A' + i);
-			goto teardown_intx;
-		}
-
-		host->intx_irqs[i] = irq;
-		irq_set_chained_handler_and_data(irq,
-						 rzg3s_pcie_intx_irq_handler,
-						 host);
-	}
-
-	host->intx_domain = irq_domain_create_linear(dev_fwnode(dev),
-						     PCI_NUM_INTX,
-						     &rzg3s_pcie_intx_domain_ops,
-						     host);
-	if (!host->intx_domain) {
-		ret = -EINVAL;
-		dev_err_probe(dev, ret,
-			      "Failed to add irq domain for INTx IRQs\n");
-		goto teardown_intx;
-	}
-	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		ret = rzg3s_pcie_init_msi(host);
-
-		if (ret)
-			goto teardown_intx;
-	}
-
-	return 0;
-
-teardown_intx:
-	rzg3s_pcie_teardown_intx(host, i);
-
-	return ret;
-}
-
-static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rzg3s_pcie_teardown_msi(host);
-
-	rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
-}
-
 static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 {
 	u32 remote_supported_link_speeds, max_supported_link_speeds;
@@ -1169,6 +1095,79 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
+{
+	if (host->intx_domain)
+		irq_domain_remove(host->intx_domain);
+
+	while (--count >= 0) {
+		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
+						 NULL);
+	}
+}
+
+static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
+{
+	struct device *dev = host->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int i, ret;
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		char irq_name[5] = {0};
+		int irq;
+
+		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
+
+		irq = platform_get_irq_byname(pdev, irq_name);
+		if (irq < 0) {
+			ret = irq;
+			dev_err_probe(dev, ret,
+				      "Failed to parse and map INT%c IRQ\n",
+				      'A' + i);
+			goto teardown_intx;
+		}
+
+		host->intx_irqs[i] = irq;
+		irq_set_chained_handler_and_data(irq,
+						 rzg3s_pcie_intx_irq_handler,
+						 host);
+	}
+
+	host->intx_domain = irq_domain_create_linear(dev_fwnode(dev),
+						     PCI_NUM_INTX,
+						     &rzg3s_pcie_intx_domain_ops,
+						     host);
+	if (!host->intx_domain) {
+		ret = -EINVAL;
+		dev_err_probe(dev, ret,
+			      "Failed to add irq domain for INTx IRQs\n");
+		goto teardown_intx;
+	}
+	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		ret = rzg3s_pcie_init_msi(host);
+
+		if (ret)
+			goto teardown_intx;
+	}
+
+	return 0;
+
+teardown_intx:
+	rzg3s_pcie_teardown_intx(host, i);
+
+	return ret;
+}
+
+static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
+{
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rzg3s_pcie_teardown_msi(host);
+
+	rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
+}
+
 static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
-- 
2.43.0

