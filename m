Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D729428498
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241267; cv=none; b=b5IWnLjmXJXasIYEx8DfIpxgRfkZu/q5P/BRaP22zEtGEneLDDRM0988SX3/hsDIf/H90le6EIJRfh9aORcaihbJJMNWW8QCRO7mrV3jSPN4gCn7NO5frc3gZQxRSEIN+r488RtuWP59Mo6gBRcv2qmQ2SSuZW0Egz+Ci69vDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241267; c=relaxed/simple;
	bh=/0MJeRgWN3MNkxcm9QqUe1piZB5E0YIkJhHqqlgHTVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwZefeUcL64wmIkZkaYqCwehRId0EaFeydeJyVq5Krmm23s5rsxr+S8HUoNcLMWB6ZHKqK5IdCHwpFdtQaXWCJBeev0pAJZY4ATEpXH1N8RltTQyHUuvx6iccGT/eG+1Z5y/z7F/Kom1Z9MEE0Bs2RSHb0gtAS65CAa5Q63wvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0eiqzIh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0eiqzIh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cedda2ce6fso31618845ad.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785241265; x=1785846065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQlE679JObsFJHTkpZQZUZIILuIjOEy10+IeTfWR3d4=;
        b=i0eiqzIhYO13VWaWBUdYvrniKP7TdvGp6lTAiHOj3lyGIuzYe5920jTUaToI20rrLZ
         3vCQLF3p79DCmAk2QiwHs8L9tVGXmZgy0/eDECyZVzck6dv1GQmMCvoFUVUC+Rj+nToO
         DkOqcKMprzl1fzOv9n2yuZ/DTTaMXxulF/vx2diHSRqYLJ9UoL4QhCPZUeVfDJNTC3yy
         +NmF9RxlR5Stc1fMji9KuDtn1V5KxK8lPJbQG9Qor7mOc3rdbHAQUTFxvocM0Lo+Nd6n
         f2oYwMHeVpkGO5ADexsjEystdCwQ5Xb55YOt1Gh4asTlw8nZpNuiyHpEsZKDtZwwE0d/
         YB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785241265; x=1785846065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQlE679JObsFJHTkpZQZUZIILuIjOEy10+IeTfWR3d4=;
        b=pb+EGHeAnROYypMUIHrkkEji62owCR/Nq/JTpyhDsQ1D/MFq3Rz+ZbfGveo877PP3r
         cKfatp3REjA+wjNg/YHOvrrWVtGMEy++4x/hKH/lI9CQZLmhI2r03tOqtf2D9FSHLXLx
         SNcXpGfjesmPriIql6G3Hn1qQjYZ0PEDpYJWqXpIVEr3pqYC5Mbf6vl7ToEVBowFGQq0
         sVGK2RgGaWCF8jxfrYpkrYIBF2VrO2LQMwHNUcUCOhZITHdFijhE7qS/nDL+IzlQb/Lx
         kqjzO+5B1bcnB10JcOTGrLoEF8a47bKr1Lq4uQboRRPnmOLJQvontYuupz8Jj6h3YIXV
         lkkg==
X-Forwarded-Encrypted: i=1; AHgh+RpogVTs17iqGjiTNCpu1S8FSW/8n8jJ13Ctqn5h4ohm386bKhSkDn0XnynRZvg+3DqYgxw9M+mTlbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinO3bRLLuuu1mTudbF4kGQeD2WotG9TAKHMlvJ2c5rLzGiUAZ
	DswHQn9UIH+CaK0ezQRDUZFmL0wK0OhRsTSOWKbIVc7x7BSFHvQlLw2u
X-Gm-Gg: AR+sD12u7HNsDpVFpfEGkTBGhjbL5duoc2SnaOoXhnAM9dcNKRc114nnhqjxfjkoxK0
	IgI6+W/AxFmK4vYxgo9ErUXzA0dT35JMh1VDSI+wSlUdb3U2dZb61MeDnleU7esYDR3YAlEfAPR
	OcuzhGKYtEwRd7Vw8gxUX2xyBZHGlBK74cgkQzPO+299jer+uHJVBCbFKnWTkyMYxssBgJ6I52A
	QOdQGsk5M8TJMT2VtAP4zKiRe3xjWRPrnrZJJL0dq7ezbiD2pk5fynfWnW2fXwqC5zsWUTm07G1
	VvEYH+lz9SECakxnJ0Bz2ZeEzomV7idv7anoKv9CCD6aqv98u8FIn9aZ0IYrbnEdzHca6yYYmI5
	jc059KW4ljk7Xgt1dTir5lDCaJ8aXQ85/hTOtvqPMRj5fsOgzAkZTTaTeBwHoYRU034lLukI/BT
	k+ckKNnTOQmre6HGIQrm8BP8q8oA==
X-Received: by 2002:a05:6a20:7f8b:b0:3c3:84a5:f2be with SMTP id adf61e73a8af0-3c8aaf8d6a4mr2824475637.11.1785241265469;
        Tue, 28 Jul 2026 05:21:05 -0700 (PDT)
Received: from localhost.localdomain ([103.179.230.124])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm40391876c88.0.2026.07.28.05.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:21:04 -0700 (PDT)
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
Date: Tue, 28 Jul 2026 12:20:23 +0000
Message-ID: <20260728122023.3338-1-sreekuttan2156239@gmail.com>
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

