Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A55191F84;
	Tue,  3 Feb 2026 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078113; cv=none; b=cFZVAVk22fgLyRRB5gZ5EdTnhNFnlBNqblam00Nw+zuF+4sLg+ZIFD+gRfalthcGmXI6Gp5ONukknxZaRD7VYNvxfxo6+eb7QGNvxrcldN1lGfTBENTjJVnNw8yoRVw72Ctfs92MYsmHK4v2yIryIiaUN+czwsA5JN7TfmyScl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078113; c=relaxed/simple;
	bh=Vo467vveR/1rzNqRuyhiz3rkXqxzgUsbDQa4s1ebYGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6kfaimAUfOj4zD43pLZRHcx4I4969JxKFLsQr8mmQ7S7gJIhFap2OwnAjMtm1UnLCWfU0Hs+Yf1XLx49b6uxxHLpSiQ/0o4WG4ZB8dEyS2nBBQUvLvKHJprbotZ3v9gGolvbinmW3Fp/O30VG3QOPnaejLHgqmxkEr41Uva5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F56dhBSk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F56dhBSk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770078109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thJ1sEYwFgH0EvKxYK16kbar1XTDnkSFrt//2tTCrRU=;
	b=F56dhBSkAWENXfvqexDxxPOibf1MniHSlSg6KfR3MGZFA9/oZaLVyAlV1239KOjLP073rC
	dz2ohdPnqZpgUZakeqtU1ySICG7LLFePZbVos+3ZQvWxNIEPXwDBBFMzWqbo8KEuRgaL/F
	p9FMmbWygvHrJYq0b36bpoIQuRwu9m0=
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
Subject: [PATCH 2/8] phy: zynqmp: Refactor bus width configuration into helper
Date: Mon,  2 Feb 2026 19:21:22 -0500
Message-Id: <20260203002128.935842-3-sean.anderson@linux.dev>
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

Split off the bus width configuration into a helper function for reuse.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/xilinx/phy-zynqmp.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index fe6b4925d166..0d3c578d0f3f 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -502,6 +502,17 @@ static void xpsgtr_lane_set_protocol(struct xpsgtr_phy *gtr_phy)
 	}
 }
 
+/* Set the bus width */
+static void xpsgtr_phy_init_bus_width(struct xpsgtr_phy *gtr_phy, u32 width)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
+	u32 mask = PROT_BUS_WIDTH_MASK(gtr_phy->lane);
+	u32 val = width << PROT_BUS_WIDTH_SHIFT(gtr_phy->lane);
+
+	xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, mask, val);
+	xpsgtr_clr_set(gtr_dev, RX_PROT_BUS_WIDTH, mask, val);
+}
+
 /* Bypass (de)scrambler and 8b/10b decoder and encoder. */
 static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
 {
@@ -535,14 +546,7 @@ static void xpsgtr_phy_init_sata(struct xpsgtr_phy *gtr_phy)
 /* SGMII-specific initialization. */
 static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
 {
-	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
-	u32 mask = PROT_BUS_WIDTH_MASK(gtr_phy->lane);
-	u32 val = PROT_BUS_WIDTH_10 << PROT_BUS_WIDTH_SHIFT(gtr_phy->lane);
-
-	/* Set SGMII protocol TX and RX bus width to 10 bits. */
-	xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, mask, val);
-	xpsgtr_clr_set(gtr_dev, RX_PROT_BUS_WIDTH, mask, val);
-
+	xpsgtr_phy_init_bus_width(gtr_phy, PROT_BUS_WIDTH_10);
 	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
 }
 
-- 
2.35.1.1320.gc452695387.dirty

