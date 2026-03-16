Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665603EDAC2;
	Mon, 16 Mar 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688264; cv=none; b=rO/YxBM0RCzVnh8BUMc3xBB0WAZk/+bONHeDDiWheb07V4CFJnD9jC+ETDuwXJADlVrdVEWKzozE/+bs/0NV8pWUBqMlCYj2pDyyPnxTlmxpr12FiOKPQCE723t3xDCax172pnzurSCp4z9DXs7aDKcSAXN3nV6BKjfXKRNfoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688264; c=relaxed/simple;
	bh=h/pUGb1NJA2hdQCJIo2Ohbfiv3iqxyyq1igul0v2MZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlmlrvLTxQkXNKkQZVQniaCpdUEKdKMe2hVVcbE4WsHMUmYwqLs6u2Q3gryDgujAdrtIw1N5cZCGldgMIOu9z2BVRWPFweU5eE34AqnyTtUFYnPP5O3jFoHrA/0ItCI6m3FN2Dq6yfET8FBX/JwFkeMXpm4DhZGjICfyYqbmdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iml8xhbn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iml8xhbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773688259;
	bh=h/pUGb1NJA2hdQCJIo2Ohbfiv3iqxyyq1igul0v2MZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iml8xhbnYQ6QslbxQzLxqLT7imLTCjHhTTgAgygZowdzFJLUWm9ETpB/q1iN7h5Bv
	 fHWsUS9WHqKkHPb1D+aU34U6M/quyngO1I+7pGLRGTdwC7otyTXb+IVAJpYKWyhxcl
	 0uxy/6sOt5Ux/Q/4TjZh+Oje92aB8SSmnWT7bAEYALXEiTE9TX7E3Gg2mq2qm8FpFp
	 P27+kgbC6B4gIFC8wJdodhKnBzQikPFOs/+T250dwtnTdFnzNTTowDxiUZ5/fUs+L9
	 OYHm5otKZsEj2GPVjYJpLdenWYnekpXuBJGfszsaZLb+oMyIQ9Rb6sHxtUpODIpnyr
	 zkIqDAbruuB2g==
Received: from jupiter.universe (dyndsl-091-248-189-119.ewe-ip-backbone.de [91.248.189.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4653F17E1517;
	Mon, 16 Mar 2026 20:10:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A3F9C480035; Mon, 16 Mar 2026 20:10:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 16 Mar 2026 20:10:52 +0100
Subject: [PATCH RFC v5 8/8] PCI: dw-rockchip: port some suspend code from
 vendor kernel
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-rockchip-pcie-system-suspend-v5-8-5bb5ad37d643@collabora.com>
References: <20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com>
In-Reply-To: <20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=h/pUGb1NJA2hdQCJIo2Ohbfiv3iqxyyq1igul0v2MZY=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGm4VcKnyMXniE/kxpBn2U0KJ2ysIXFX3GGAX
 hD71U180UdWzYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpuFXCAAoJENju1/PI
 O/qaCAoP/Au5Np9j1a570yelFWNsV+fSh3WT5dtJxPBe/7B06PA1aMb079pHpr0O377tS8h6/Wt
 wj0vCoEoPx+eZjYBl6hhbgANOHBVkGgjKLW0K5kC0ipJSrwmrwnPSXbF0VzqJ9/3SaBLosTA0xq
 7tgdvWPgWX/5n/1eZR6WoXA9UgP2l239q0fyffhettDWwyZu1sX93+MYaLpTzsoDCTotsRabekN
 BUt3iLVKHn7R0Bu8SQdRULjL4hTGfKSZbOoJ4ekNWHu5ay6ecyF1rvcbOni4IDv8I0QXSAsshak
 a8ZUxdKmmjLVyKcmtqrQlxr6gFvEw7ThMN42S7jYd8ZVii/cG+dIHxv0aMnGb9N7QtBLX1NAvjP
 tvyVnZ1Fc3RUO1un7fO7NS1uweLTGZb4RJ+JTgzuCxhW8JsFvo3LIIt+1Fcr1au9b6AAx98o4SB
 X2EAIWGYzYD1joy2n8Iq3ppLLVd3mUIy51PqaFeapEXO/zwh55HxcQqisyO4gMBFcIN6IFdyUA7
 B8YEEM8hnzaRZSoWeE+vFgT6IOoNbzxbYlTOgwNnPSnaFNGAu82/rBN4lOxUQTvpmRb2mgbu0g9
 6d4hYPT2+nYpBQctmsRDOOF65AGeerK7/xOLQPaW2X7LZPWTBvvfqj14Qs7HiFvhhnGbvdd6jvX
 RikDaR7s8T+t8SiHPE/A5Nw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Rockchip's vendor kernel does these calls before starting the actual
process of going into L2 state. I'm not sure about the rationale,
hopefully Shawn can help out with that.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3be83feccecb..fbdde82c95b6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -74,6 +74,9 @@
 #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
 #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
 
+/* General Debug Register */
+#define PCIE_CLIENT_GENERAL_DEBUG	0x104
+
 /* RASDES TBA information */
 #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
 #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
@@ -776,6 +779,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static inline void rockchip_pcie_link_status_clear(struct rockchip_pcie *rockchip)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_DEBUG, 0x0);
+}
+
 static int rockchip_pcie_suspend(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
@@ -789,6 +797,11 @@ static int rockchip_pcie_suspend(struct device *dev)
 
 	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
 
+	/* All sub-devices are in D3hot by PCIe stack */
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	rockchip_pcie_link_status_clear(rockchip);
+
 	ret = dw_pcie_suspend_noirq(pci);
 	if (ret)
 		return ret;

-- 
2.51.0

