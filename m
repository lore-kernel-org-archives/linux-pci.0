Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83C3F9278;
	Wed,  7 Oct 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351449; cv=none; b=DoaqZTA6w+Df3Hh+yERp+K2/CiuEGF8z9GEM81jNJw2tQBiwVK2J3VZXSjV5qXa24JSC3fgf/yfly633xKm8BRZp4dZQ2ChfKuoTX87Eosq1AxKNe3lcfRyT5dCCYD7MOtt3eWK85tSRk2b6IubydFb7a123PGwbImQ3zf7xyuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351449; c=relaxed/simple;
	bh=JnkG2hHcbsFlNbsQj4mcn8ueysGUBWLbYta+VvYNwh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJUp7hSD2k6jDuYUFeejljc3UR8O8pI4k6J4OIYiHH5b9bTvp/6WVl81zxrlSN7zMbQyOehi/nsKy2Nr2PrBsMxFrcqMQPFwD9jW+cx2CM1bkBx8FDC9DtI+VInaeFlmtv4k0nxwv4vxXgZwuOg+SF+Ji5x88mMBkPse8NYIXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0mxYGU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0mxYGU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA7A1F0089B;
	Wed,  7 Oct 2026 05:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351448;
	bh=vIUKsTJcYKXRdg65st6LOkP4X0fBfPt/SfUeOsJQ7gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0mxYGU0nl/CsRYrm+xX2hgJJV5ECY38eyB/twGQy8+tbIwDd3ZmTvNqbGpegLV/h
	 bgCbEO5tPs/LI47HvKDxPqAibPQXQ32QSHwLYyJI/TmMdU8ulvROnf5gvveeKz4Frs
	 +0YpoR4U8FHHEnRYi3A21W40ewrKH5xFQWYfvmJ4XiHL4+WKOLmW90JOmoeiIJkpza
	 y4ESzCkFyybGpl9c32R/ucfOGtVM3Kn2ZPdcF8uhYd7ROUKSm6KVAhz3BAX11e8uH5
	 Xt41ixfoZyXDE3zRKNWZxMwmJo4nnVm6YAWU3zvywqYEN/JDdFcYvRdfdweLXGFw4z
	 Gnv61423b0tMQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 6/9] PCI: rzg3s-host: Move IRQ domain setup code
Date: Wed,  7 Oct 2026 08:36:42 +0300
Message-ID: <20261007053645.1391545-7-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
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

Changes in v6:
- none

Changes in v5:
- collected tags
- restored the previous order in rzg3s_pcie_teardown_intx()

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 147 +++++++++++------------
 1 file changed, 73 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 40d5ef3e347e..3b62b1be5b2a 100644
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

