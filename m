Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521E48BD4E;
	Fri,  2 Oct 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939421; cv=none; b=OiFaUhag5KkPtkg6D+6/Mk2n7l77JXUs7hW7VXmDpGuiPpSOwJi91rXi1Qa87RW7U5BSaRedtNCUYuMF88kX/kCILMm1pQCp/56Ba7V3vuIITZDVj700A9YHqqDX/1Sk9cOY7fO6E19ZhCPZGmDHhIR5wh6DfMsxgJl2x1vG7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939421; c=relaxed/simple;
	bh=wKYABxXe9cvlAjxmUv62U141CmMLV5OR8XEDKeas7wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL+7/4UYyt+1ElgzpSkIvPR0EEHmldwvSJAXCyse7kTeaCWEZAAKIEih6ezo3k7yLjuToF9c1xbzzYpD2IGL9dib/pQUv7aK9RBwg8eVWhnWN537JoBKSawUZuWEl7s6zfKXWAt9h/RIg0o2U2dIrVxbDh0bi1qykMGpgUALrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrFNq5gK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrFNq5gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B541F00893;
	Fri,  2 Oct 2026 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939412;
	bh=QiePM29KFo1bBpCvxuh/ebBixcd7nJVP5gMoZ7Q+Gjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YrFNq5gKZIBO6WXygalmqj1VByReWX2Z4zpM6k1bhldo0pVzuuKUirAsOhm+Q90nU
	 n3om6JEVPo4uG1+z5ofaQRf8L3hsGqToKbjdT+m4Lc2OPFp4hUdQxzYJCf6sYk5OJo
	 Hsd7FXSq5d5PiM3215axbivg6j4FlyLBjkId4MPqL0Dm9WpwVU7wynGr8GQIqTE6IC
	 N4gurSxfNetd4VRPxumex2/Vc+Q36ah63EKG4UDI8W3CijTm0/XZMJjk9fAVQ6cSef
	 bq2buiall6/sW36b+lktebbD/QzVldqClAbHQ4td/E6auQzn/5wZ674klbVEq4m2ms
	 TxR7CwDRchCWA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	18255117159@163.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 7/9] PCI: rzg3s-host: Move IRQ domain setup code
Date: Fri,  2 Oct 2026 14:09:33 +0300
Message-ID: <20261002110935.2004349-8-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
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

