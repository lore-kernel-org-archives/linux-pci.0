Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86E5519B0;
	Tue, 22 Sep 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088421; cv=none; b=c2lUhmPB5S8wYkhRSNaeZ+rpycxVjfns9QAUAPD0SRgdL0DX51WWn5cxYofKm53hnE0XdXlI4aIINXTSl5WVdSt+jBTcvchL1g8gh6C94rMNY0ThdHKVUybbKnjK6zZf5PieBxrzzEtybpP+pO0wsZt9AESC9CVTJ5elHMZ2KCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088421; c=relaxed/simple;
	bh=8lPDNNzBmKuMlsZoIjBNbIi5cSRJ8hcKLBvBSFzXhqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBLsi+53U7zzcBKsqLXnatabVJ91Nbl0pK79va1ICxxQi/rohKdhdZAu6OMMjpgt88FQbdDOjJC6c7vcSH7EU89tC/6XnjWY7jBetCL8jkUETsiPaLXlF58rdUrXg8OA/bGlO7cOFRsNrtWyCBPBtisbtCTpufa6VVsFS9LLTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfsl+7vJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfsl+7vJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE701F00898;
	Tue, 22 Sep 2026 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088419;
	bh=7VgnifC5bLSn4l21Fhvw+lIrmHDxv1AceVCvE7hJVOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sfsl+7vJ6LyuUZxzMtKYQiKjj+FuS+ema70Sq/EeF7PlL8HXootOJxqXqaCeTuB0E
	 hvzAGwuJNpXYoOJ1K491PXQS+l3coTXpQTq1U2Z3vhg0wy3EAXkOXmTWxRkg80BTiM
	 yico0+9mu0Ba1+kcq6bvzipA/YemVvKspiumdP7unuBLIUwBIgHL8nwsWy+eb5xd01
	 bzX4hK8EgB6jb/lJVUMTL91KUJaerBTKQHixvlCouQNMae0U3f/k7CeqchlMb3nn0L
	 bAArf0hLkz9g6K/YspzSQaIgK9gRIm/BmeiXhke4GpA88s6laFlMi7AWQAr2wkThO+
	 wxacykPLjj4Xw==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
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
Subject: [PATCH v4 6/8] PCI: rzg3s-host: Move IRQ domain setup code
Date: Tue, 22 Sep 2026 17:46:26 +0300
Message-ID: <20260922144629.586997-7-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922144629.586997-1-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
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

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 147 +++++++++++------------
 1 file changed, 73 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 40d5ef3e347e..f4b27a77a89d 100644
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

