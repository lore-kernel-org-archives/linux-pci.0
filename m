Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91419005E
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078121; cv=none; b=lsxBjdgkv71cGtdvUM+vLsdNGdWPOyjjn5vaNg10GePJDaYZLPbSrWRwlm8x3kI+C9D5DTE9jddVDlj6n48/bqnOZPOWcJpheeGrMy5c0OzhURH7mMMKYc2GMosPzah6LETYuWmUzOrgUeOlJ7TmpoBTxuen0T6S53Xo1eucag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078121; c=relaxed/simple;
	bh=IDh3rgzulIlQYxLxKdRaDE5kIgH6fUR26eEAf0iXhqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcO7GJWu1tlQRsWZGyOLZQuU5Wc2XC3g2rg/8m7LH5+lYKQMGjUxvFrCAowB6nBXpLB1xkwEkJDGwofPF+Y8KO+2uztcRKpN7TZDGhPCz7xZUaX39/xIGwpbrVyOFYEwZgXxfjlc+wt7o64EDtSVaf/0PUCHgXbQhjn5PVrHzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJ2hR9uG; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJ2hR9uG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770078116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5LFXkBNsaVFgE+X7iTo/Y29wKqqTLybqX/8AfnQSGE=;
	b=cJ2hR9uGAGRArhS64fAzjFL3KYNeF222SksA8JH1aVxmvkavp+hI+5LmZxckuAV17UuUqX
	XyAKRZ1my27xviwXsb5wMwfM3B/3hzdzTtAN34AFDhYNRjVFI35BBUzwjG1ttooSReRjMp
	xOdbJjQLtcb1qlt8U/VFuTS9YhHZsyY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 5/8] phy: zynqmp: Initialize chicken bits
Date: Mon,  2 Feb 2026 19:21:25 -0500
Message-Id: <20260203002128.935842-6-sean.anderson@linux.dev>
In-Reply-To: <20260203002128.935842-1-sean.anderson@linux.dev>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These bits are all set by serdes_init(). Move them to the phy driver so
we can skip serdes_init().

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/xilinx/phy-zynqmp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 854b0ea04648..1bdf29ba284c 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -54,7 +54,13 @@
 /* PCS control parameters */
 #define L0_TM_ANA_BYP_4			0x1010
 #define L0_TM_ANA_BYP_7			0x1018
+#define L0_TM_ANA_BYP_12		0x102c
+#define L0_TM_ANA_BYP_12_FORCE_UPHY_PSO_HSRXDIG		BIT(6)
+#define L0_TM_ANA_BYP_15		0x1038
+#define L0_TM_ANA_BYP_15_FORCE_UPHY_ENABLE_LOW_LEAKAGE	BIT(6)
 #define L0_TM_DIG_6			0x106c
+#define L0_TM_DIG_8			0x1074
+#define L0_TM_DIG_8_EYESURF		BIT(4)
 #define L0_TM_DIG_22			0x10ac
 #define L0_TM_DIS_DESCRAMBLE_DECODER	0x0f
 #define L0_TX_DIG_61			0x00f4
@@ -82,7 +88,13 @@
 #define L0_TM_EQ1_EQ_STG2_PREAMP_MODE_VAL	BIT(2)
 #define L0_TM_E_ILL8			0x1940
 #define L0_TM_E_ILL9			0x1944
+#define L0_TM_EQ11			0x1978
+#define L0_TM_EQ11_FORCE_EQ_OFFS_OFF	BIT(4)
 #define L0_TM_ILL13			0x1994
+#define L0_TM_RST_DLY			0x19a4
+#define L0_TM_MISC3			0x19ac
+#define L0_TM_MISC3_CDR_EN_FPL		BIT(1)
+#define L0_TM_MISC3_CDR_EN_FFL		BIT(0)
 #define L0_TM_CDR5			0x1c14
 #define L0_TM_CDR5_FPHL_FSM_ACC_CYCLES	GENMASK(7, 5)
 #define L0_TM_CDR5_FFL_PH0_INT_GAIN	GENMASK(4, 0)
@@ -849,6 +861,18 @@ static int xpsgtr_common_init(struct xpsgtr_phy *gtr_phy)
 	/* Enable coarse code saturation limiting logic. */
 	xpsgtr_write_phy(gtr_phy, L0_TM_PLL_DIG_37, L0_TM_COARSE_CODE_LIMIT);
 
+	/* Miscellaneous chicken bits */
+	xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_8, 0, L0_TM_DIG_8_EYESURF);
+	xpsgtr_write_phy(gtr_phy, L0_TM_ILL13, 7);
+	xpsgtr_write_phy(gtr_phy, L0_TM_RST_DLY, 255);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TM_ANA_BYP_15, 0,
+			   L0_TM_ANA_BYP_15_FORCE_UPHY_ENABLE_LOW_LEAKAGE);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TM_ANA_BYP_12, 0,
+			   L0_TM_ANA_BYP_12_FORCE_UPHY_PSO_HSRXDIG);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TM_MISC3, L0_TM_MISC3_CDR_EN_FPL |
+						 L0_TM_MISC3_CDR_EN_FFL, 0);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TM_EQ11, 0, L0_TM_EQ11_FORCE_EQ_OFFS_OFF);
+
 	ret = xpsgtr_configure_pll(gtr_phy);
 	if (ret)
 		return ret;
-- 
2.35.1.1320.gc452695387.dirty

