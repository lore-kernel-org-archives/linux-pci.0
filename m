Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0254A7C5;
	Tue, 22 Sep 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088414; cv=none; b=mpLihmzrvXMnn3nfGFkFuqRvDZ/FgVZzYdSak5gQJxYdZvYDz0R2qGKmYjTYvqKSy7uYOAU0taVYhKnNJItYeiPv1WTBGC8hECG78zQAtfQdY29Xdxc494zBYAo9QhYll4fgO1M9NPW2vzgrzuJ2kUaE2UUOLH3QeSVa3OwbN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088414; c=relaxed/simple;
	bh=io0K/CqdBrXCogNTcvf+KXzDl+H2UCqVqvIVohiFSPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggWZGOTvJcmbwhp1+erwKdDh6VdgnQKVWQ/SloEj/7CongdZk5RTuaaHtm6Qi04l+5lWguJBRGrIF5LskVvE2tm3yYK6K7J7B1V5+DFw8X5HyZzQWQRsHLnFlB3d/Fa+aHsm7Chyhbsn7k11GbIHGkazkewL9VTfszY8OPx+LtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4tcwqwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4tcwqwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301161F000FF;
	Tue, 22 Sep 2026 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088412;
	bh=PNktF+6n/Gs/V1cbxFgmCuRJFNKJvqmwqFpO6sc2PY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4tcwqwjVwn7iAqEH0LAOJLYaxeyP9MRYtBMmXOKceJwhuvCQ9KERVup4BwwEgzv0
	 6y5M0+qaH4J/0F2pJZe5vRrH0S+IDQhOXN67D66ef1e0v6O610P2Xt4l3HBoTCIutx
	 0OHy2dIR9wc09+uBSVOe6itVD4/77uYbjWDSoS2XDnpni579+Uj624AMwFqKgPYogQ
	 uOAV92aNe2Xl/ERtSDQYPTS7kjX4X2uv5ZYzQfQHRcH4NLu+6E663exVbGsaGptqFs
	 SoOtplKsnO9DpcbtV2LlrzhQJ/+eL4LNf6NMBYYjKj9WwAcvnVy1EKbsMx8LtNcP86
	 uOooTAx0FqLGA==
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
Subject: [PATCH v4 4/8] PCI: rzg3s-host: Move host configuration code together
Date: Tue, 22 Sep 2026 17:46:24 +0300
Message-ID: <20260922144629.586997-5-claudiu.beznea@kernel.org>
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

Move host configuration code together to have it grouped. This prepares for
the addition of hotplug support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 230 +++++++++++------------
 1 file changed, 115 insertions(+), 115 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 362aa923978f..3ecada238402 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1356,121 +1356,6 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 							      host->cfg_resets);
 }
 
-static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
-{
-	struct device_node *of_port __free(device_node) =
-		of_get_next_child(host->dev->of_node, NULL);
-	struct rzg3s_pcie_port *port = &host->port;
-	int ret;
-
-	ret = of_property_read_u32(of_port, "vendor-id", &port->vendor_id);
-	if (ret)
-		return ret;
-
-	ret = of_property_read_u32(of_port, "device-id", &port->device_id);
-	if (ret)
-		return ret;
-
-	port->refclk = of_clk_get_by_name(of_port, "ref");
-	if (IS_ERR(port->refclk))
-		return PTR_ERR(port->refclk);
-
-	return 0;
-}
-
-static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
-{
-	struct rzg3s_pcie_port *port = &host->port;
-	struct device *dev = host->dev;
-	int ret;
-
-	/* Enable access control to the CFGU */
-	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
-		       host->axi + RZG3S_PCI_PERM);
-
-	/* Update vendor ID and device ID */
-	writew_relaxed(port->vendor_id, host->pcie + PCI_VENDOR_ID);
-	writew_relaxed(port->device_id, host->pcie + PCI_DEVICE_ID);
-
-	/* Disable access control to the CFGU */
-	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
-	ret = clk_prepare_enable(port->refclk);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to enable refclk!\n");
-
-	/* Set the PHY, if any */
-	if (host->data->init_phy) {
-		ret = host->data->init_phy(host);
-		if (ret) {
-			dev_err_probe(dev, ret, "Failed to set the PHY!\n");
-			goto refclk_disable;
-		}
-	}
-
-	return 0;
-
-refclk_disable:
-	clk_disable_unprepare(port->refclk);
-	return ret;
-}
-
-static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
-{
-	u32 val;
-	int ret;
-
-	/* SoC-specific pre-configuration */
-	if (host->data->config_pre_init)
-		host->data->config_pre_init(host);
-
-	/* Initialize the PCIe related registers */
-	ret = rzg3s_pcie_config_init(host);
-	if (ret)
-		goto config_deinit;
-
-	ret = rzg3s_pcie_host_init_port(host);
-	if (ret)
-		goto config_deinit;
-
-	/* Enable ASPM L1 transition for SoCs that use it */
-	ret = rzg3s_sysc_config_func(host->sysc,
-				     RZG3S_SYSC_FUNC_ID_L1_ALLOW, 1);
-	if (ret)
-		goto config_deinit_and_refclk;
-
-	/* Initialize the interrupts */
-	rzg3s_pcie_irq_init(host);
-
-	/* SoC-specific post-configuration */
-	ret = host->data->config_post_init(host);
-	if (ret)
-		goto config_deinit_and_refclk;
-
-	/* Wait for link up */
-	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
-				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
-				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
-				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
-				 PCIE_LINK_WAIT_MAX_RETRIES);
-	if (ret)
-		goto config_deinit_post;
-
-	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
-	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
-
-	return 0;
-
-config_deinit_post:
-	host->data->config_deinit(host);
-config_deinit_and_refclk:
-	clk_disable_unprepare(host->port.refclk);
-config_deinit:
-	if (host->data->config_pre_init)
-		host->data->config_deinit(host);
-	return ret;
-}
-
 static void rzg3s_pcie_set_inbound_window(struct rzg3s_pcie_host *host,
 					  u64 cpu_addr, u64 pci_addr, u64 size,
 					  int id)
@@ -1698,6 +1583,121 @@ static int rzg3s_soc_pcie_init_phy(struct rzg3s_pcie_host *host)
 	return 0;
 }
 
+static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
+{
+	struct device_node *of_port __free(device_node) =
+		of_get_next_child(host->dev->of_node, NULL);
+	struct rzg3s_pcie_port *port = &host->port;
+	int ret;
+
+	ret = of_property_read_u32(of_port, "vendor-id", &port->vendor_id);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(of_port, "device-id", &port->device_id);
+	if (ret)
+		return ret;
+
+	port->refclk = of_clk_get_by_name(of_port, "ref");
+	if (IS_ERR(port->refclk))
+		return PTR_ERR(port->refclk);
+
+	return 0;
+}
+
+static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
+{
+	struct rzg3s_pcie_port *port = &host->port;
+	struct device *dev = host->dev;
+	int ret;
+
+	/* Enable access control to the CFGU */
+	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
+		       host->axi + RZG3S_PCI_PERM);
+
+	/* Update vendor ID and device ID */
+	writew_relaxed(port->vendor_id, host->pcie + PCI_VENDOR_ID);
+	writew_relaxed(port->device_id, host->pcie + PCI_DEVICE_ID);
+
+	/* Disable access control to the CFGU */
+	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
+
+	ret = clk_prepare_enable(port->refclk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable refclk!\n");
+
+	/* Set the PHY, if any */
+	if (host->data->init_phy) {
+		ret = host->data->init_phy(host);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to set the PHY!\n");
+			goto refclk_disable;
+		}
+	}
+
+	return 0;
+
+refclk_disable:
+	clk_disable_unprepare(port->refclk);
+	return ret;
+}
+
+static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
+{
+	u32 val;
+	int ret;
+
+	/* SoC-specific pre-configuration */
+	if (host->data->config_pre_init)
+		host->data->config_pre_init(host);
+
+	/* Initialize the PCIe related registers */
+	ret = rzg3s_pcie_config_init(host);
+	if (ret)
+		goto config_deinit;
+
+	ret = rzg3s_pcie_host_init_port(host);
+	if (ret)
+		goto config_deinit;
+
+	/* Enable ASPM L1 transition for SoCs that use it */
+	ret = rzg3s_sysc_config_func(host->sysc,
+				     RZG3S_SYSC_FUNC_ID_L1_ALLOW, 1);
+	if (ret)
+		goto config_deinit_and_refclk;
+
+	/* Initialize the interrupts */
+	rzg3s_pcie_irq_init(host);
+
+	/* SoC-specific post-configuration */
+	ret = host->data->config_post_init(host);
+	if (ret)
+		goto config_deinit_and_refclk;
+
+	/* Wait for link up */
+	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
+				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
+				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
+				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
+				 PCIE_LINK_WAIT_MAX_RETRIES);
+	if (ret)
+		goto config_deinit_post;
+
+	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
+	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
+
+	return 0;
+
+config_deinit_post:
+	host->data->config_deinit(host);
+config_deinit_and_refclk:
+	clk_disable_unprepare(host->port.refclk);
+config_deinit:
+	if (host->data->config_pre_init)
+		host->data->config_deinit(host);
+	return ret;
+}
+
 static int
 rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 		      int (*init_irqdomain)(struct rzg3s_pcie_host *host),
-- 
2.43.0

