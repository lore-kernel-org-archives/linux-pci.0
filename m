Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16611957E8
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078115; cv=none; b=iUISgxNcioxiQfN3Qqndy3gxIgGMi9oHNUmRpjRfZUZzTs0fA7iJSps8mOlhNclALwZUxcu46aWHaXUtHClgmNqa7oXb1L1S0PijaASYIv+wGHG7zAh/AxBPgOKomtTQanFlhbYprSd90Wn8aZ2tuRv35rP3nWzpRHbyAqRRPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078115; c=relaxed/simple;
	bh=5ZAeQfyJvvABXzYNXetE/mNDvGAHH5ZukN+JA2fOmvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dd/8sTCoVdzsKiPzP1mcTrLDfRZojy0j2REA2ko2cvvXykqEZSIOFBr4qz41YtMfVTHi2vH0/EEvZeGYfh+uy3tvy331Eo3QnmaW/JRlGIaC1E/5ph2lqUvwRcwA4hbt7G4myVj2YOM/BGBGUtAlk4Y0gaPbu2DIgNIMnfFGCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G4Sb+I8k; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G4Sb+I8k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770078112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSzBHZdVygKXukk+iQ1E1BqwM0RrqN94x3Zvnkp6Hc8=;
	b=G4Sb+I8kM9gfwkpIfWB6Q9chGzCZDLL4XA7UXqu6mEzNp2obCYBdVFniqPfgV61J8gxLFl
	SwS8Tjh3iOEbVZuhJKic+JCuTd04pT7Et+ubEPZnnzeKiO0V2ywYm3UtmmG/dXUKPZKVSg
	Cn6NV7aXAr8CqQiyitJ5f1DUAqxAO/g=
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
Subject: [PATCH 3/8] phy: zynqmp: Refactor common phy initialization into a helper
Date: Mon,  2 Feb 2026 19:21:23 -0500
Message-Id: <20260203002128.935842-4-sean.anderson@linux.dev>
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

All lanes undergoing ILL calibration must be initialized. Split off
common phy initialization into a helper so that we can ensure all lanes
are initialized before performing calibration.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/xilinx/phy-zynqmp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 0d3c578d0f3f..152af1702bbd 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -520,6 +520,21 @@ static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
 	xpsgtr_write_phy(gtr_phy, L0_TX_DIG_61, L0_TM_DISABLE_SCRAMBLE_ENCODER);
 }
 
+static int xpsgtr_common_init(struct xpsgtr_phy *gtr_phy)
+{
+	int ret;
+
+	/* Enable coarse code saturation limiting logic. */
+	xpsgtr_write_phy(gtr_phy, L0_TM_PLL_DIG_37, L0_TM_COARSE_CODE_LIMIT);
+
+	ret = xpsgtr_configure_pll(gtr_phy);
+	if (ret)
+		return ret;
+
+	xpsgtr_lane_set_protocol(gtr_phy);
+	return 0;
+}
+
 /* DP-specific initialization. */
 static void xpsgtr_phy_init_dp(struct xpsgtr_phy *gtr_phy)
 {
@@ -682,19 +697,14 @@ static int xpsgtr_phy_init(struct phy *phy)
 		gtr_dev->tx_term_fix = false;
 	}
 
-	/* Enable coarse code saturation limiting logic. */
-	xpsgtr_write_phy(gtr_phy, L0_TM_PLL_DIG_37, L0_TM_COARSE_CODE_LIMIT);
-
 	/*
 	 * Configure the PLL, the lane protocol, and perform protocol-specific
 	 * initialization.
 	 */
-	ret = xpsgtr_configure_pll(gtr_phy);
+	ret = xpsgtr_common_init(gtr_phy);
 	if (ret)
 		goto out;
 
-	xpsgtr_lane_set_protocol(gtr_phy);
-
 	switch (gtr_phy->protocol) {
 	case ICM_PROTOCOL_DP:
 		xpsgtr_phy_init_dp(gtr_phy);
-- 
2.35.1.1320.gc452695387.dirty

