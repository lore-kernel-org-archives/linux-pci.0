Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34A496D30
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765727; cv=none; b=vGmSsDTT0Qv/ojF2JPtCHNTxGkF9KnKLUrMRdykveoBcuBS5pcv4h9okef/Far3FdhTr3vdgXy4BOfl1wVpZLC2d9bKWtXWUgXemm8Qb3gQBm/5+GrYKqM0HfKnIRzUnNvfAEl1DvS3KtpunBWQlRInlQu0+5AL4BtPJqQgh+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765727; c=relaxed/simple;
	bh=dwiF272EhoUmBSNAzIjwZoL0KKbPDlprXZmwB2MqiIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKnBJZGixW+8mjVeWe7fxe7KS/7IrP5msZkU88dJhvRFe/lSupJgFLfLhCc3m5U3xD5BiVNdqTe4f/wFSfl8VOjYY7YQgEX7+fx4DA9vsauqIu6coKFkUK4ErCPC6YPhy+Kp2kRCLuU6bGd4iKfOXO9QzMlZuXNle5RP0QxnMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSTZQSH9; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSTZQSH9"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd046b87so3804927c88.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790765718; x=1791370518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tm4KhT1i9nkviFOM/DKWhqvTQ9rSQZ5LZ/7ePdMtknI=;
        b=MSTZQSH9JQNIVLH09/VgsLz2ApN+cUUS8ZAb41+ZuTZW9zR6Jv80nMkxjxPvDtsrwT
         SmPGlqUwftjfY57pUuRqfaKY8EIYr/6ylx2PVEmYgk5nygfYayJk4kzY9PqCp+tbzKJe
         ZchrD++lE9I3QJ71e3JsYMAWKekqVVcWYJaZxtSaUu6bQ4uloq7XhRcFaZhi/ni3s/Nx
         pcmIh8wdbKW2v2N/H0pntXf2DEU9zSvR591qQ9tgvAPU0+cXWfiNQL2LX7fahB7yQn8r
         RL9bnzhFqcL8wvLp79LRpfpLcF/aR6M/ziUMv1Nei9uhDe4JwPeUBEEn1x9GUgygyhGK
         rvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790765718; x=1791370518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tm4KhT1i9nkviFOM/DKWhqvTQ9rSQZ5LZ/7ePdMtknI=;
        b=sUtezr9+wr8mVdSVWMD8S+6t30XA314lYwX0WLXqWkl+4vxlZAuPZtpQO7HVNYHmNK
         an2HzSRlzf3omlHvCRaH8o+7X08fGHNkD+pQJDsMp+2g7u1eKMdyYzprto7Dn0NXpDDg
         Jqb6hAc8TXF8UcyNLbtvfEoJyV5TVotO7rPDsIYwbfcJFnUteFgFxCWOWLHPuwEtlc3Y
         wupCc0mTb6SO8nKCu+zhKw76IDrng4coUJPYpQL/C37mFWmFY1d7ZsX15Q1y4XfAuaoN
         DE1orlQ3Ab2XxhGOMAYJXrGD3w5BlmCrzHyuwVXA5H6bulE1wqAAAXe+s20QGaf6znhu
         h/EA==
X-Gm-Message-State: AFuF++kTfRQNNEPaulun5atQzF4tZVUjJMitlm5sFKNW79sdfj4a8Pql
	o5sM9p14tETMJfo7Rf0Jy0vc/DX53KXPKvRWpe2f7T6siOIP1+fMmaf+
X-Gm-Gg: AYBFou1PEcFFBtQYqrQ9dv3GvROgVDla52GD3cG7Kmq7VDurTwkbsuyBDIQdcLe72Di
	HT9To9yey+SAx4z6q6PI13E5Y2k7Vddcm4ChG9ljjEpQtcIgJJmwAzw2bm/9UdyrS5+0EndR1uq
	70JM4wcJOFTnx8WslbFOKyrVgEdonwG/8nIorY3RfoksAWw9OPUdv6rCd6sFFZxUySUh4BZr5pr
	uUFMcptbH4mZdvUpi72/1W2DhSl0GzpxpjXL7Q2RoTXtINSA9szms0bmn1JwqiVY+/xcij+8H16
	zlGY4udRUy+ZVZpJHI9o37ss6ga7qk2/wl7CqeOe38WDLzbdh8dxKiwuS00OdlK4hB/cHnatfu4
	b97oxz8cLdHN1J7vtqEDc8TZ8OgoWxe5+NKemfbiL6iZ46wfVmXXxp/iZ/1VDBxro/AR+FlqIFC
	oLQtvcMl0VY2Zxub3nk0yA4hym5LeUJcojkX6BDmVPCU8OVxGrxdGYIAunP3zqwaFW+q07kqJW9
	kls4NBFiIxu0CNUGH8Y
X-Received: by 2002:a05:7022:91f:b0:144:eaa7:2765 with SMTP id a92af1059eb24-14d3204e73amr1522897c88.18.1790765717951;
        Wed, 30 Sep 2026 03:55:17 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d083fea61sm4295477c88.3.2026.09.30.03.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:55:17 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C3=85=E2=80=9Eski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2] PCI: mediatek: Fix integer truncation in fls() and clamp size
Date: Wed, 30 Sep 2026 10:54:35 +0000
Message-ID: <20260930105435.3660-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resource_size() returns a resource_size_t, which is 64-bit on 64-bit
architectures or 32-bit systems with LPAE/PAE enabled. Passing this
directly to fls(), which accepts an unsigned int, implicitly
truncates the upper 32 bits.

Furthermore, AHB2PCIE_SIZE() uses a 5-bit mask GENMASK(4, 0). If a
resource size of 4 GiB or larger is passed, fls64() returns 33 or
greater, which overflows the 5-bit mask and wraps around (e.g. 33 & 31
= 1).

Fix this by using fls64() for 64-bit resource sizes and clamping the
result to a maximum of 31 to fit the 5-bit register field.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index a60d1ae076f8..9576fe532b92 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -686,6 +687,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
 	int err;
+	resource_size_t size;
+	int size_order;
 
 	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
 	if (entry)
@@ -753,8 +756,13 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	size_order = fls64(size);
+	if (size_order > 31)
+		size_order = 31;
+
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
@@ -775,6 +783,8 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 	struct resource_entry *entry;
 	u32 val, link_mask;
 	int err;
+	resource_size_t size;
+	int size_order;
 
 	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
 	if (entry)
@@ -829,8 +839,13 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	size_order = fls64(size);
+	if (size_order > 31)
+		size_order = 31;
+
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.55.0

