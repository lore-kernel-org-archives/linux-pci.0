Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AE33A708;
	Mon, 16 Mar 2026 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688262; cv=none; b=E85w3D+F0qKwD1wvYRUqryXm9+bVMGrZwQmL2rSGb6mxoMREFTtrRkbwdb4XykAcU3TWFNEfefX1UCnHCZbyzW8SzQxRq15YBqBqrg+TzpOgTNgcI4CiS2ySG7Ij86yh/GKtNX1CMd5tTWdxrm/We9oA83yEUkxov6thv1feez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688262; c=relaxed/simple;
	bh=NC7xlteOUv6KH+mLyFaHYcW+bG6xZtt6k8hvnBPDSWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1YOdIBH1Mb2IlpTcCEN5515bJKsUlfJCpllq8KNpWZtjcD1CRlXd12cBGtpym3+mzeSAGhhY2BGgFf7eNwbTgAzu8+Ka6dOYGBAqEolkFr3I4BeM+rwhACqwmWq3AXEWcPkngeaewglF+Le4oSV/71Ckw8LyvwIA2klUyujjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mCfjRe0u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mCfjRe0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773688259;
	bh=NC7xlteOUv6KH+mLyFaHYcW+bG6xZtt6k8hvnBPDSWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mCfjRe0uzUW/SNrCO6OJDJHAftKY5/Hhm3zJvOce8LBvDCjtr1ieUy1jpl4khXodv
	 mdSWycFvP6ZoG0+8qLeqj80bhDNCGG0b+SIRCTeaKodoAKqFvHA5rtF+qUYCBod8AK
	 lSNWsJWt/BK09PR7kd7vQb0+cqmCZLvn6JDNMUbcUUJYJsoGitOaZ1mLSGCdeuyCTZ
	 pFNbGokRg/9I+eTjfxp3y7Txn1vlksWsIbIjawmuXSxj9XmntJxGKbHOVEj0/03UO3
	 VZaIaLlnD6VWjba9WnvHe+LzvtrKdkCpiy85c6eoqKgUgqYN8grpbFPwoYTEGeuM3C
	 QHieD7+ByE6Ew==
Received: from jupiter.universe (dyndsl-091-248-189-119.ewe-ip-backbone.de [91.248.189.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E8B8217E13C1;
	Mon, 16 Mar 2026 20:10:58 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9D02648002E; Mon, 16 Mar 2026 20:10:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 16 Mar 2026 20:10:48 +0100
Subject: [PATCH v5 4/8] PCI: dw-rockchip: Add helper function for
 controller mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-rockchip-pcie-system-suspend-v5-4-5bb5ad37d643@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=NC7xlteOUv6KH+mLyFaHYcW+bG6xZtt6k8hvnBPDSWI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGm4VcKPJ/0Mo7yxEA/uvM0xk5DuD43NEHlDw
 eLNIRYNKWQbp4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpuFXCAAoJENju1/PI
 O/qa7e0P/RKo8syGxJEnHK1k7cp8WJiitmAgHbE1A6Xb5rGLbCePMeihfgT0z1F16z3Sfnp4nuF
 tREBBPH/01uRU3qhvsp3+Sd+VtP7wEcGUlJ2+GGW8pop62DowREGZbV+HxbrPjE92sSZkgzTBik
 GbjpoN0ONlTJH0lssxP2NOzas3apJqUa3i2c2+shaxRLSQvBt+YU4XAC2PGYC4wcSL860UrvYo+
 1rTT2/jkvZntMHPh09VeCUdSfrUBvjeQ+KUSN9LFMhqB/XUjjSSQAp5jibTQ5bZ8nY0x5Jlfz/n
 8/VwXfMLFLDsNdcWHI0mp3qVe14Cdpemcn/zzaZiEoIVUN5nGL81tjvXVZxnRJfiCNwR53JOKQ4
 w7C0yLCe8mM78KcwhueJOeD0U2aR9bwkDLeT9eEV470r6Q4MD8DYp1YQ2qGlGkeZnxhpbREPg/0
 XU1K8QdOY5DHiS8BEhv0IruwRWNs04ocVTYKy4Gglg8PqHGRDh6YVgEJ5PLtjPmYsbVOv1duXoe
 aYi9xe1bhAFYP0nL8aOf7MLLDjlmypBq5fCweanE3/9SHG4y65kGUb8P0twuecWfypMXTT+4QVM
 sac13h8jvC8U8Era2b6zUEXK5cDsK9INxx7Ach4TpwVoBEat+FdQUwtnSBvtFxVWou4JTbat9Vz
 fGLwoc7MuaDnlSf570Jgwcw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the controller mode.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 508d069ffd75..373ab897228b 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -555,6 +555,11 @@ static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pci
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 }
 
+static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u32 mode)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
+}
+
 static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 {
 	struct dw_pcie_rp *pp;
@@ -563,10 +568,7 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 		return -ENODEV;
 
 	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
-
-	rockchip_pcie_writel_apb(rockchip,
-				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
-				 PCIE_CLIENT_GENERAL_CON);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
@@ -597,10 +599,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	}
 
 	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, PCIE_LTSSM_APP_DLY2_EN);
-
-	rockchip_pcie_writel_apb(rockchip,
-				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
-				 PCIE_CLIENT_GENERAL_CON);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_EP);
 
 	rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
 	rockchip->pci.ep.page_size = SZ_64K;

-- 
2.51.0

