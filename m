Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30234429014
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240226; cv=none; b=gGKyhHIcABgR9PphQCyQSkBwoX5gA7k95rqt8FHL89yoiQtv+MQPUj25EKzH55m1QCc7FTAIDv63FwJLNMjnT4L0PtgUftHOlc7QZbiO8G3fR3K8eyg9Hn2ZePxq13Y81ww4omAsSVfeDvcRgGH4Q0Vi+vSK7cFD45qs4T76Afw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240226; c=relaxed/simple;
	bh=/0MJeRgWN3MNkxcm9QqUe1piZB5E0YIkJhHqqlgHTVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PceQXb/pR6aS8mebWwyfDdq0ZP9DkIjLJ/f9wDDPrB2Oi1EOT4dPOqEXVxkFsV18LHfjJKWpuPMnBv7b+BvP1gpczaWsKdTjRkPRh5w9DK3f80yrPfJQgg0bcPnJVP8UB54ldmk6FdHcYetDaovdKGhg1XZf7A6Sr3uoa5siGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpXvN3u5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpXvN3u5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3998199a91.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785240224; x=1785845024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQlE679JObsFJHTkpZQZUZIILuIjOEy10+IeTfWR3d4=;
        b=OpXvN3u5gov1FfogSZ3PZmRoYM1sDsJeHv4cX5t5XzrjHAivvnOzT+UJRexpNikFo0
         3xygFq28+s8JK7klE9IytCpzHPSThUX8OxkIHj7Rj0MHVAwE+Jrndy45AHZV0IOlfoKy
         QlPNWWmlTcQTUNYpGjCzvPIhsRuONOw2Xjzng1D000Bd+eMUzC/t9fPq+dv5m2niqEQ0
         PHDtugoYFaDljUMiR7DpSF+ernBxE9IA5BZfdrzk4DYdRMHYwSi0Vk6WMC7AzS1UpgTr
         W9wz5DFkMEE3uVvowEcGRchpN1/4uSPb6BLse4YVADhvk1g45c456FgheCPp5Mrp+vLc
         7AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240224; x=1785845024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQlE679JObsFJHTkpZQZUZIILuIjOEy10+IeTfWR3d4=;
        b=WZFok+ZChc3nMWN7yzSSqYdYSFWc5Pt6hBUedUjmhinz9n+kisZ4+FbrOHcCO/6HTt
         bUzR4Uh7RT/ntfEJDwWSG5zLOEufHfwcaB+S9I7pA/HRjRckfgoKaXPqJIXvNDH0D2q/
         bipa8O7+vVvUz+1FnSP8hfvcAiEBNV2hxiu/zu7pAjhsN4H4/zMmVogydXgx5KsYyU+A
         Pq+zQGdtsi7dHMrrIEUtiocEgwbS8HNULmm4j9NAZcUzuus14UxndWRP22fAO/z9Q0SR
         3tzd8FaxbmhPQJwvHmLExUamIoD7whFItKgqvNO6rLk7CA0hBNMwMntAP/XWZKfQP8R+
         4MIw==
X-Forwarded-Encrypted: i=1; AHgh+Roc6d0umbzL02d2ldF3OnKY6yJVb+c8fx+Utfmnb08uDS6FIqmIH1xZCOjlMKZ4GutpOk207c8GkoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4TtY/+EseOFmdYDwQHpqpiXlAIaRD2PQ57P9/JLGuLDQEMsE
	7HWCjQ0v1pQhJFLsBD2rx4ejXkezBXW+M/+EbIUd55vcVsDprDoeAl+C
X-Gm-Gg: AR+sD111T00qly9OUD5rFj8k/0Wey5JZX6hSpP29hza3TRBOBvob9OtFfoRlnNwwNfg
	c6yM/+KfYUyAaQk/kz8E6rh4tAd8+OfFC8NXDopEJjrF3/mEkZfnw/I6U2FoHWnncgVJMDH+Ahv
	e+dAegn5VW7YU/0mnbnLHEUn3Ax9Mzgt3PmCyYy1lv9yLdg7BzV+hEimEJBtUyrJzNA584smqQ2
	dIP2T7+lKPt9aj366tF9+CJGVtJLR98uEjwzHODO1DeKjZ5q2o/Z0F67WSD0byZxoQ6rvE5081U
	RXL/XRNQeCT659lgAe1p1pb0uE7sF5zQJ/d2DHihyi2pt0D5g+QRAlXE1CdI3L5Y6G7HUnWpxRz
	8a9i76x5d9hzD8TUtBEuPUTE6YxokB/rCGTxiWlqKa63li+kPxlmXXi7JPSb55wB9tkd7GyQ28G
	Xp6i4m7xffC0oSUvvimCvHWpDfxA==
X-Received: by 2002:a17:90b:39ac:b0:38d:56aa:6f32 with SMTP id 98e67ed59e1d1-38f6a4c6bbbmr2080804a91.38.1785240224085;
        Tue, 28 Jul 2026 05:03:44 -0700 (PDT)
Received: from localhost.localdomain ([103.179.230.124])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm42878472eec.10.2026.07.28.05.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:03:43 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: ryder.lee@mediatek.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2] PCI: mediatek-gen3: Fix 64-bit type truncation in mtk_pcie_set_trans_table()
Date: Tue, 28 Jul 2026 12:03:01 +0000
Message-ID: <20260728120301.3188-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variables cpu_addr, pci_addr, and remaining in
mtk_pcie_set_trans_table() are of type resource_size_t, which is 64-bit
on 64-bit architectures.

Using 32-bit helpers fls(), ffs(), and BIT() causes 64-bit integer
truncation when computing window sizes and address alignments above 4GB.

Fix this by switching to fls64(), __ffs64(), and BIT_ULL(). Note that
__ffs64() uses 0-based indexing, so the '- 1' offset is removed. Additionally,
return -ENOMEM when translation tables are exhausted to prevent silent failure.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v2:
 - Replaced non-existent ffs64() with __ffs64().
 - Corrected 0-based indexing logic for __ffs64().
 - Returned -ENOMEM on translation table resource exhaustion.
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index bcbd08c82a5c..67635af0ed2a 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -7,6 +7,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
@@ -334,10 +336,10 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 
 	while (remaining && (*num < PCIE_MAX_TRANS_TABLES)) {
 		/* Table size needs to be a power of 2 */
-		table_size = BIT(fls(remaining) - 1);
+		table_size = BIT_ULL(fls64(remaining) - 1);
 
 		if (cpu_addr > 0) {
-			addr_align = BIT(ffs(cpu_addr) - 1);
+			addr_align = BIT_ULL(__ffs64(cpu_addr));
 			table_size = min(table_size, addr_align);
 		}
 
@@ -349,7 +351,8 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 		}
 
 		table = pcie->base + PCIE_TRANS_TABLE_BASE_REG + *num * PCIE_ATR_TLB_SET_OFFSET;
-		writel_relaxed(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(table_size) - 1), table);
+		writel_relaxed(lower_32_bits(cpu_addr) | 
+				PCIE_ATR_SIZE(fls64(table_size) - 1), table);
 		writel_relaxed(upper_32_bits(cpu_addr), table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
 		writel_relaxed(lower_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
 		writel_relaxed(upper_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
@@ -375,9 +378,11 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 		(*num)++;
 	}
 
-	if (remaining)
-		dev_warn(pcie->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
+	if (remaining) {
+		dev_err(pcie->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
 			 (unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.54.0

