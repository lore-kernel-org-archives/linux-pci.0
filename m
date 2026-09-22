Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AD381AF4
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044960; cv=none; b=ifYdSkmS892O2Ndagl8NIUEIe5Z2Z+jxveHRsVmZdE0jBQt99DyidwMklRLZ60HjXYDambFhFzwMOmJWTcRa5NZ82i5JVI/zAAkmPHsmom/axJvJ/qnKilOmC0NRvZ/IX6sQZlR8VhwGMl7G3dEFmJCPoTLpy/hmvpwivPW3B08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044960; c=relaxed/simple;
	bh=CofPhoKwKfLMmcVipx/3SLFrnaWe52neWyqVn+/UZKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k7lb10uN94BEwnP5PcA2Y2NipjijhFVMYK3sXbxh9VrudtE44VFAjY/BLklW3ogz53zk896GJZKet3K6gZKKBpZ625mwWQZTZzME6dvlCHslmUlBSZyfDHMpoMwpnqhOVjc7xXkOBhrUOnEYMoODwZB+FA+r2DLZyfjzelRoQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IgbVsmwx; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IgbVsmwx"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ea70febf;
	Tue, 22 Sep 2026 10:37:19 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/3] PCI: dw-rockchip: Make the INTx irq setup devm-managed
Date: Tue, 22 Sep 2026 10:37:01 +0800
Message-Id: <1790044622-164744-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c6f991d403a4kunm27853d20398d64
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUNDHlYeGB5KSElOTE
	9CHhpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IgbVsmwxm695FO79qw/I6WhIhbgzrFDmZc3HoPMoFLDc6ImiQIGto+yqJXp1TreML/zUmqi7laFmLMjHEyLv1kux58OiqNmgZmdZu7pAoxdQ5012ieGk9MA4R0MzK2Id4JlEBucJ9rpq2UVNcvbgVI8MMLjOjG15yq9+N/JSuB0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=pO8jM+rAflXu5d0KB14tn/7WI+8LjbC27+2iwgGQUes=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The irq domain and the chained handler set up by the previous commit
are resources owned by the device, but nothing releases them if probing
ever fails after they are set up, and they are not tied to the device
lifetime in any other way either.

Tie their lifetime to the device with devres: create the irq domain
with devm_irq_domain_instantiate() and uninstall the chained handler
through the rockchip_pcie_intx_chained_release() devres action. The
driver is builtin and cannot be unbound (suppress_bind_attrs), so probe
failure is the only path that ever needs this cleanup, and devres takes
care of it without sprinkling it over every error path.

Since the irq setup is the last step of rockchip_pcie_configure_rc(),
the only failure point left after the chained handler is installed is
devm_add_action_or_reset() itself, whose failure mode runs the action,
so the handler can never run against the devm-freed rockchip structure.
devres also unwinds in reverse registration order, so the handler is
always uninstalled before the domain is removed. There is no devm API
for chained handlers, hence the small devres action wrapper.

While at it, drop the now unused rockchip variable from
rockchip_pcie_host_init().

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
This patch didn't find a suitable fix tag as it fixes an issue along with
patch 1/3, then patch 3/3 depends on it. So it might go with the whole series
into a fix branch.

Changes in v3: None
Changes in v2: None

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 46 ++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 8788a10..f395a66 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -114,6 +114,7 @@ struct rockchip_pcie {
 	struct reset_control *rst;
 	struct gpio_desc *rst_gpio;
 	struct irq_domain *irq_domain;
+	int intx_irq;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
 	struct delayed_work trace_work;
@@ -188,9 +189,16 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.map = rockchip_pcie_intx_map,
 };
 
-static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
+static void rockchip_pcie_intx_chained_release(void *data)
+{
+	struct rockchip_pcie *rockchip = data;
+
+	irq_set_chained_handler_and_data(rockchip->intx_irq, NULL, NULL);
+}
+
+static int rockchip_pcie_init_irq_domain(struct device *dev,
+					 struct rockchip_pcie *rockchip)
 {
-	struct device *dev = rockchip->pci.dev;
 	struct device_node *intc;
 
 	intc = of_get_child_by_name(dev->of_node, "legacy-interrupt-controller");
@@ -199,12 +207,17 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 		return -EINVAL;
 	}
 
-	rockchip->irq_domain = irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
-							&intx_domain_ops, rockchip);
+	rockchip->irq_domain = devm_irq_domain_instantiate(dev,
+			&(struct irq_domain_info){
+				.fwnode = of_fwnode_handle(intc),
+				.size = PCI_NUM_INTX,
+				.ops = &intx_domain_ops,
+				.host_data = rockchip,
+			});
 	of_node_put(intc);
-	if (!rockchip->irq_domain) {
+	if (IS_ERR(rockchip->irq_domain)) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
-		return -EINVAL;
+		return PTR_ERR(rockchip->irq_domain);
 	}
 
 	return 0;
@@ -731,18 +744,27 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	 * which is also re-run by .reset_root_port(), so that the INTx irq
 	 * domain is only created once, at probe time.
 	 */
-	irq = of_irq_get_byname(dev->of_node, "legacy");
-	if (irq < 0)
-		return irq;
+	rockchip->intx_irq = of_irq_get_byname(dev->of_node, "legacy");
+	if (rockchip->intx_irq < 0)
+		return rockchip->intx_irq;
 
-	ret = rockchip_pcie_init_irq_domain(rockchip);
+	ret = rockchip_pcie_init_irq_domain(dev, rockchip);
 	if (ret < 0) {
 		dev_err(dev, "failed to init irq domain\n");
 		return ret;
 	}
 
-	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
-					 rockchip);
+	irq_set_chained_handler_and_data(rockchip->intx_irq,
+					 rockchip_pcie_intx_handler, rockchip);
+
+	/*
+	 * Uninstall the chained handler on probe failure, so that it can
+	 * never run against the devm-freed rockchip structure.
+	 */
+	ret = devm_add_action_or_reset(dev, rockchip_pcie_intx_chained_release,
+				       rockchip);
+	if (ret)
+		return ret;
 
 	/* unmask hot reset/link-down reset */
 	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
-- 
2.7.4

