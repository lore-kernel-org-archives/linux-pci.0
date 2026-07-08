Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1C40680C
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501544; cv=none; b=r1idmRdxRDTwSi/QjVleF2C8NzJrqwFJfwiR6vl7k+U41cj3fNQFzdu0VqeWJDhmjpkcHS7gvQ2ewhhIsyDrqQmIKHbA7r+sN+QUOAhOnzEPW096siWo89M0VwCGrWFqp39d7MtsDNssuXL2xQ86jKK8BO3ud1wXFO1DACkcoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501544; c=relaxed/simple;
	bh=UhYLkoXdYToLt11QxRM3I3a9Ezx+7AJ+xJHA7M6++Wk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAwxsNi5h2lhIc0V1iw9mMZiTHXOVCKjVJFqhckVowOXsHbsha8X69N59bprcCFnUS2JKLduasgWpgOeZ2+0V2JJqYGPN+8degnS5xaASH2uUTO+TBQfyiJpIpAI+326zZal7lTAO6xnvhXVZX1zQl3z/tv/hMTyVYviNFWOSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgi71Dzj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgi71Dzj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-476a130c138so486735f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783501540; x=1784106340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2euWSsPEF/v1H3boU+OtaRrXIWKLVevLYYthNauJxnw=;
        b=Hgi71DzjsvoB0ChK9uZGpBz40cJoCSBvJxE1v/8gOS6gShyBbHmQ7lKqeFWrNpdP7D
         W+c0oWnQ92KTF9G3V7tfJS15UWSn9j6/Mcrd3ZT/bTrcusWKOmZ5GAdygBlsv9sZHfoC
         UA8YN+O6RNf/EfaJqCYfzcScbbDyeEuerO4MasEkRXuKQZzMpXiiAwl7i0eWMQ/D59ec
         nsqoIHA8x3VnrYBA2ZtYbiompdpR/WWb6QhgRC3dyx8EZvLZbnLMXhIjeQA8k3+1d6ia
         Dv0klNFjdxCQjZGzC1E2z2BczxRhZ7creU2xPGVkMO7nECKC77t3GIk6bVfiOg9x+/rA
         YFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501540; x=1784106340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2euWSsPEF/v1H3boU+OtaRrXIWKLVevLYYthNauJxnw=;
        b=gixKXRa2+GexSpZErGDvebbFc7/qR05WSMHOtDzapHOsc/I59qfI+l052ufreHA5vW
         ZTfQVF0M03VXm4gP2yaRvsCIdL+ih5wDWMuK5fQ0JB3hMq2rTJJ0eS0Leb1tqZI3mfhi
         r4TjHFjayHBR6iZJmfpsAU3WyWME5EITbZfBEYt2ceg/vY5xT4HQUhWCnCYSt3+eYrSk
         nl5XdHMIUFf8fSMrISO7XFwmcPxUapaVWstJ+RbZo/Eoo8eL7V/d/cVetz0G0lRIvfui
         Wj1mxWgMf4klqVqeyGOfN/mY9fzzmwzvlWbtvadIxwXUBU0L1mmxb39KzYypkmPxCMzE
         X43w==
X-Forwarded-Encrypted: i=1; AHgh+Rrdjs41m+yMDarPiNi7yW0rs3FrSryX2zZL6IffRMVLJ8X12mAX4pcMEv/KfuLYv3VFGKnNpIRWQ3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/Vz09Bq/zHi70mvYooBOdVfMOC89tFIoiSyXsNCACuiayxPu
	aUJrUTd/Us4rytUmf/IRO1Hw5r3BoPf70bNUU9mqnSQt8F/fT+FDkPMh
X-Gm-Gg: AfdE7ckf4rgurYjiV9uwS8lebsgDZ9oVHnbKppgfbKgI/VBxWXx+ZgoA+R3LA/anzD3
	DsVXPeA+VfpuWXJ0/ulbWrBwyYF30IgtToaB980FfXtaVZIK+nb5/qlzpNKZB8P6PQfpUXoAHSr
	Npm8/9pkeazu88r6beCWoI0ZZ3+eDtVWtSVSJZxwoy3p1QMFbftQcV9DsKbkXBUSzXXhZ9rPFTs
	H4S03+/a6Xf+yi8hYrql78jyAI7uIfcvNWg6Fxbz1FomerqKizTR5Pp2BI+2aVrJN775iIdbK0Z
	qSQbY95gIkImm601Q0A56X6V98y25jUeAukrqVccD/I7ukrpJD9yWQJYSgvkTx+7F6thH+MecVF
	aKrWXEZrh1i53y4l5PmhlnDBuCPPBgrSF9j0V3AG0j3SU7RyJ2wmkrDxx8+WKfevI5/paQrJH1Y
	upCEV2E7OdHM56NGHdQLBkNpkC/7tlW1oyTtsL7psjAgAaHJwQrQWP8CYi0ampWs7YRyx1UyTSj
	WvnGn+E
X-Received: by 2002:a05:6000:382:b0:478:65a8:262d with SMTP id ffacd0b85a97d-47df07157f1mr1587607f8f.9.1783501540094;
        Wed, 08 Jul 2026 02:05:40 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1e785sm40674208f8f.8.2026.07.08.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:05:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] PCI: mediatek: handle optional reset for perstout for AN7583
Date: Wed,  8 Jul 2026 11:05:29 +0200
Message-ID: <20260708090533.19734-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708090533.19734-1-ansuelsmth@gmail.com>
References: <20260708090533.19734-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7583 provide the perstout via a dedicated reset line as using
the PCIe register is not possible as it will cause glitch.

Add support for it via the additional reset name pcie-perstout[slot] and
assert/deassert on an7583 specific startup.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 8b57c3d75b94..3d4de9d69407 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -175,6 +175,7 @@ struct mtk_pcie_soc {
  * @phys_base: Physical address of the I/O register base region
  * @list: port list
  * @pcie: pointer to PCIe host info
+ * @perstout_reset: pointer to port perstout reset control
  * @reset: pointer to port reset control
  * @sys_ck: pointer to transaction/data link layer clock
  * @ahb_ck: pointer to AHB slave interface operating clock for CSR access
@@ -198,6 +199,7 @@ struct mtk_pcie_port {
 	struct list_head list;
 	struct mtk_pcie *pcie;
 	struct reset_control *reset;
+	struct reset_control *perstout_reset;
 	struct clk *sys_ck;
 	struct clk *ahb_ck;
 	struct clk *axi_ck;
@@ -865,6 +867,9 @@ static int mtk_pcie_startup_port_an7583(struct mtk_pcie_port *port)
 	size = lower_32_bits(resource_size(entry->res));
 	regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
 
+	reset_control_assert(port->perstout_reset);
+	reset_control_deassert(port->perstout_reset);
+
 	return mtk_pcie_startup_port_v2(port);
 }
 
@@ -1020,6 +1025,11 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
 		return PTR_ERR(port->reset);
 
+	snprintf(name, sizeof(name), "pcie-perstout%d", slot);
+	port->perstout_reset = devm_reset_control_get_optional_exclusive(dev, name);
+	if (PTR_ERR(port->perstout_reset) == -EPROBE_DEFER)
+		return PTR_ERR(port->perstout_reset);
+
 	/* some platforms may use default PHY setting */
 	snprintf(name, sizeof(name), "pcie-phy%d", slot);
 	port->phy = devm_phy_optional_get(dev, name);
-- 
2.53.0

