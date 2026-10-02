Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697748C3E8;
	Fri,  2 Oct 2026 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939419; cv=none; b=d4lVU0vN0nGf0cSk8SaP2FaG7DavscvoCKg9FT7swQGOPAGpKCspl44hzqp0prTAMhWaI6+5xstVnH3dWR56MpiJv/HVY7+tOYJNF4CuczPKN0bJUwfRBoSlO94AsJ8DRKjIPINeF+84vS7uKCqdbP+ueHik/sRDeUdxvFNVWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939419; c=relaxed/simple;
	bh=TBK/+iFUPXks5GadPMQvfN5VuBCiW1IykJOXNk8aEvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZQvz/caIaMlhmvX+jKpE17As42K8PysUdmYPwTWWYSh+5EIMilMmIznOvsMaPJtR84J46i4SA6MF1rYXm6Bxyr5Ci11GaHB4M7CnaSG4AuVarGZbBHkI93zslzUKb8pAhAuBnFg3SLaFPOGYeCimA7APYhjsT8R6zi3ilrDnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDSEcfdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDSEcfdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EFD1F00898;
	Fri,  2 Oct 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939408;
	bh=hkwwD8u2m9pGkXtR9LvGrMkhDkil03fKxHfYvYZQzDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PDSEcfddkPnYq6T7Uv1mITt2N25ZMJNCA1TZOfVySdK58iYS6NjucADXpgkViRuPh
	 4U+svxsrI4YXKe/KBJXiZeejfciMvBNQDzIhIIXovyHWB0w16E7frj4ryd9bX7bXff
	 fhmWQ07cHW8EO6fuy/K5IJpBb14GpJe43I7OL55VKJjMMqexrIkzOpvkbCW+r4JTS8
	 K2zXTG58KgjX8uUAb9KyBykwnjJ5E6quJtDTcIamUIU0/Gs0jgaHFgA9Y1yi20d5jI
	 d478mb9ic5KNNIwsjzCq8wAv9PNBa6Y8n0QfHB/WNnJovxIwzPfkbvBkNKA/OuipNg
	 8omM0tDF6I3GA==
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
Subject: [PATCH v5 6/9] PCI: rzg3s-host: Move suspend/resume code into dedicated functions
Date: Fri,  2 Oct 2026 14:09:32 +0300
Message-ID: <20261002110935.2004349-7-claudiu.beznea@kernel.org>
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

In preparation for implementing hotplug using
pci_host_bridge::reset_root_port(), move the suspend/resume code into
rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
will later be reused by the hotplug implementation through
pci_host_bridge::reset_root_port().

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- collected tags

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 181 ++++++++++++-----------
 1 file changed, 96 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 3ecada238402..40d5ef3e347e 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1742,6 +1742,100 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	return ret;
 }
 
+static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
+{
+	const struct rzg3s_pcie_soc_data *data = host->data;
+	struct rzg3s_pcie_port *port = &host->port;
+	struct rzg3s_sysc *sysc = host->sysc;
+	int ret;
+
+	clk_disable_unprepare(port->refclk);
+
+	/* SoC-specific de-initialization */
+	ret = data->config_deinit(host);
+	if (ret)
+		goto refclk_restore;
+
+	ret = reset_control_bulk_assert(data->num_power_resets,
+					host->power_resets);
+	if (ret)
+		goto config_reinit;
+
+	/*
+	 * Since the power domain's genpd_suspend_noirq() will disable clocks,
+	 * there is no need to manually invoke runtime PM API here.
+	 */
+
+	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
+	if (ret)
+		goto power_resets_restore;
+
+	return 0;
+
+	/* Restore the previous state if any error happens */
+power_resets_restore:
+	reset_control_bulk_deassert(data->num_power_resets,
+				    host->power_resets);
+config_reinit:
+	if (data->config_pre_init)
+		data->config_pre_init(host);
+	data->config_post_init(host);
+refclk_restore:
+	clk_prepare_enable(port->refclk);
+	return ret;
+}
+
+static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
+{
+	const struct rzg3s_pcie_soc_data *data = host->data;
+	struct rzg3s_sysc *sysc = host->sysc;
+	int ret;
+
+	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
+	if (ret)
+		return ret;
+
+	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
+	if (ret)
+		return ret;
+
+	if (host->num_lanes) {
+		ret = rzg3s_sysc_config_func(host->sysc,
+					     RZG3S_SYSC_FUNC_ID_LINK_MASTER,
+					     host->num_lanes == 2  ?
+					     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
+					     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
+		if (ret)
+			goto assert_rst_rsm_b;
+	}
+
+	/*
+	 * Since the power domain's genpd_resume_noirq() will enable clocks,
+	 * there is no need to manually invoke runtime PM API here.
+	 */
+
+	ret = rzg3s_pcie_power_resets_deassert(host);
+	if (ret)
+		goto assert_rst_rsm_b;
+
+	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
+				    rzg3s_pcie_msi_hw_teardown);
+	if (ret)
+		goto assert_power_resets;
+
+	return 0;
+
+	/*
+	 * If any error happens there is no way to recover the IP. Put it in the
+	 * lowest possible power state.
+	 */
+assert_power_resets:
+	reset_control_bulk_assert(data->num_power_resets, host->power_resets);
+assert_rst_rsm_b:
+	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
+	return ret;
+}
+
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
 {
 	struct device_node *np = host->dev->of_node;
@@ -1939,98 +2033,15 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 static int rzg3s_pcie_suspend_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
-	const struct rzg3s_pcie_soc_data *data = host->data;
-	struct rzg3s_pcie_port *port = &host->port;
-	struct rzg3s_sysc *sysc = host->sysc;
-	int ret;
-
-	clk_disable_unprepare(port->refclk);
-
-	/* SoC-specific de-initialization */
-	ret = data->config_deinit(host);
-	if (ret)
-		goto refclk_restore;
-
-	ret = reset_control_bulk_assert(data->num_power_resets,
-					host->power_resets);
-	if (ret)
-		goto config_reinit;
-
-	/*
-	 * Since the power domain's genpd_suspend_noirq() will disable clocks,
-	 * there is no need to manually invoke runtime PM API here.
-	 */
-
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
-	if (ret)
-		goto power_resets_restore;
 
-	return 0;
-
-	/* Restore the previous state if any error happens */
-power_resets_restore:
-	reset_control_bulk_deassert(data->num_power_resets,
-				    host->power_resets);
-config_reinit:
-	if (data->config_pre_init)
-		data->config_pre_init(host);
-	data->config_post_init(host);
-refclk_restore:
-	clk_prepare_enable(port->refclk);
-	return ret;
+	return rzg3s_pcie_host_stop(host);
 }
 
 static int rzg3s_pcie_resume_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
-	const struct rzg3s_pcie_soc_data *data = host->data;
-	struct rzg3s_sysc *sysc = host->sysc;
-	int ret;
 
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
-	if (ret)
-		return ret;
-
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
-	if (ret)
-		return ret;
-
-	if (host->num_lanes) {
-		ret = rzg3s_sysc_config_func(host->sysc,
-					     RZG3S_SYSC_FUNC_ID_LINK_MASTER,
-					     host->num_lanes == 2  ?
-					     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
-					     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
-		if (ret)
-			goto assert_rst_rsm_b;
-	}
-
-	/*
-	 * Since the power domain's genpd_resume_noirq() will enable clocks,
-	 * there is no need to manually invoke runtime PM API here.
-	 */
-
-	ret = rzg3s_pcie_power_resets_deassert(host);
-	if (ret)
-		goto assert_rst_rsm_b;
-
-	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
-				    rzg3s_pcie_msi_hw_teardown);
-	if (ret)
-		goto assert_power_resets;
-
-	return 0;
-
-	/*
-	 * If any error happens there is no way to recover the IP. Put it in the
-	 * lowest possible power state.
-	 */
-assert_power_resets:
-	reset_control_bulk_assert(data->num_power_resets,
-				  host->power_resets);
-assert_rst_rsm_b:
-	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
-	return ret;
+	return rzg3s_pcie_host_start(host);
 }
 
 static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
-- 
2.43.0

