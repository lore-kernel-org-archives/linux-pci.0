Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BE48B383;
	Mon, 19 Oct 2026 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392725; cv=none; b=fmwm/knMN9kMWaVXWzMAkIEtXBDzG0nKs+XUuEK29TV1vREcu5rcsbNs9qT13A+BkObKxh2FlBUI8POaLjzarD7d74jKsv2YL64JKndyBF8FF4rlBjlnQrVgMqLt+pzv8B4fs7Fv62BiQCJyIoO1EIgTtE/utVNSVovLfYh73Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392725; c=relaxed/simple;
	bh=1VQvW9pJ2VshkagUc9Vtqc4Fz9ZS38orGzZZt73ggyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvoywiyBbToQ1uv4JGfWb35qfhDzLU0zD/y0oWsS9C8kpnxTiSBbjPiRiKWa6vZTNJa7SBT9Z3z4FScLO5Ms875lNXqa4A4tnqTsPWh6z1Z988irp331/e1hUNRmmmf+PWik7BPB3BUiiBgX6HhAO8a4gWFxGVC1IiYtBjk2MFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPCrKqEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPCrKqEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650611F000C6;
	Mon, 19 Oct 2026 06:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392723;
	bh=L7ePHBDg0MjOwGUctU/dOb6cBl5FDZoh2iTLqXI61ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPCrKqEUZtc39RHTgXp5RsvoK1KLjx7p2BS4f0co2e50DDmPv9tr3k9dddyVWlmVT
	 g7W3PwUMJQklZmRujXAUqO3JrEKghGEUXfHk5l++zxn2Samedr7Ff6SKfG3x97XyNm
	 k8mSMVBtdkiAlKIjXfXkBxzxrlb+PzvMvmYd2Akq2KrBSsUrQGVNR69x73jeCSimU8
	 50otlJAFOHqgmKZ2jxhvnUNy+PlX99+yPXSKBK8RHdciQChrMWjZyVz12FwvgDaio7
	 XCW0pum0OWKPb9G5Oll9oMl4VBzTr3t6E/o3ZPkZxGwlDhDXsc+RZ+PnylzyuxLqWO
	 0EveozdhkR3gQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 11/14] PCI: rzg3s-host: Move IRQ domain setup code
Date: Mon, 19 Oct 2026 09:50:22 +0300
Message-ID: <20261019065025.2146539-12-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
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

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- collected tags
- restored the previous order in rzg3s_pcie_teardown_intx()

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 143 +++++++++++------------
 1 file changed, 71 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 54d1fd200f35..e104c6b4ae4a 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -995,78 +995,6 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
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
-	host->intx_domain = irq_domain_create_linear(dev_fwnode(dev),
-						     PCI_NUM_INTX,
-						     &rzg3s_pcie_intx_domain_ops,
-						     host);
-	if (!host->intx_domain) {
-		return dev_err_probe(dev, -EINVAL,
-				     "Failed to add irq domain for INTx IRQs\n");
-	}
-	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
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
@@ -1156,6 +1084,77 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
+{
+	while (--count >= 0) {
+		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
+						 NULL);
+	}
+
+	if (host->intx_domain)
+		irq_domain_remove(host->intx_domain);
+}
+
+static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
+{
+	struct device *dev = host->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int i, ret;
+
+	host->intx_domain = irq_domain_create_linear(dev_fwnode(dev),
+						     PCI_NUM_INTX,
+						     &rzg3s_pcie_intx_domain_ops,
+						     host);
+	if (!host->intx_domain) {
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to add irq domain for INTx IRQs\n");
+	}
+	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
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

