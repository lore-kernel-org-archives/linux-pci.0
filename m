Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669A433E73
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241722; cv=none; b=jXqVDebfqib7lLjzvC4lh9IMS74v6nCGT7a2sQFNv281hnNoynxLWoxep3U2Irwkj5s/hkodj5ULJMbXqi1t/hZjZPWu8llRx0niwC3xlMCXxwAaGXjSJOvABWQ7ULo07W8Aw1YoOtl+dRePkUIXHNwjMJweNYBnHi5VjNO5c7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241722; c=relaxed/simple;
	bh=yQ0Sy0XgvOcQHjSLyM4Yoo9qa6O6ZhUfEyyoy5NFbpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI+SEr05A/X94RgpTU3tBX1dckRa+HYC4w1N+Qu5VnV/X3gmPWkJ1kc8PSBO3ohOGEImgsLuwgg76LOKB7kl8xP5ZL/3ZNuoydM2DgdvxsKpIF2JfFCYjpbYy97JMTOYR8HNa8i1gw59AiVqfgZU+VxDUa8IKoQ290drr5x5ILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auGqX5zX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auGqX5zX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb662575d3so2170475a12.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785241720; x=1785846520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXD9NT1yZlFkaXVxjdMwL7vBIK75Ivf+FWUGyrR0g4o=;
        b=auGqX5zXZxEpJE7mS8w5vlLtK89TPDN0fToHtjz9rBcETNFHg9oHsc7ghl4sUo/2hy
         +i/IG+X6rStRczkuR6ezAkuYj8cv2LE28ANPiIfoyGrevy6C32DawiqRa+gfJJurmgPO
         W1EkyaHVsTqrEbIGXGmRWrZuMkRs96+vlRquD/uCT6/zjoU8IGqP+HkXmg1cUbkxKqWw
         MwCjlDJL8K1RAHrt67PJERQFRknbKCBlvO3heFsUCStopx9IrSEy9+4qEKerdCweoUSB
         7obGBQ6GYrOB/YwBP0TRbeoGtK0d/E0fhGrpk3hku5nxyPsoAh0udPWiMAWEw/qdV+tl
         Xodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785241720; x=1785846520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BXD9NT1yZlFkaXVxjdMwL7vBIK75Ivf+FWUGyrR0g4o=;
        b=f0/w7M7rcmSSjPiluNU08JvOFXO+qI83VkYDJ4bxWmhZmSHs2TSIkRabD8hKTnO5GP
         z+Aud6h2CmytJ7xPhkOHGBYbXRZdpk4AXayXkMCEfiDFicAxlfFxdDuHL54x+8Rex7Fx
         eKFqDHnF3w684l0tjHXGtXbdL5GCdiBA4ESKmUzH3RDUPsPlIHa+SGo76grLurJvmgwr
         0umURnWCKPIiPnSe7cXXk+XKBYRFU4comkTfhIHQc9bB/aMDf6vYHfiq22P5k/nEM6W/
         L+9j0aXiRpgQ6myZHhDjp5y/FwwIv7gMetJWE3wp4tMmMxEPhhHCfp0MkCaxTtS4j573
         hh6g==
X-Forwarded-Encrypted: i=1; AHgh+Rooz9jSLQi5tkqX0tUS6ImCrNBTmabWdC+DJdqiIpoDgn5CxYgs7jsW7qrjPXO+fa5n7LqPF+MJpqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsUSlt/+cW9kVn0SPtslMTtjZvY5kHSnpgcXN/gWdxpWTn+aO
	UvBp0J01+UagavxQlCOEs/aXXB5+0gBUVELQ+FxDJEqnArduYMD+AAjNZlfmACmkM9Q=
X-Gm-Gg: AR+sD11DowsSJPHKwLRJZjbuTIXwgYqwAhBYLDZPl89w1QBEz+mPcEWJFAStyHi3gCc
	VBK/uaVv/k7I/MImG1PfJr1lUdqSVEbvr+CIfbY5ZQu1iAAAHUY3Tad3xxXrpPbkUpxPl+P0LyP
	SfnwsIK3795BbsGa1gOfNzaDzCHUaMrGHoMBgw1dpv+oWk0Gpd/swzrtrRXokBVB93ZIAgW8jDi
	QWkAjJgOvISWPBYmEg4c1PYoR3GShMvP9KoiEWzU62ZB+17bWIV0z7Tr3FekKuBxQOM3MGJFIuJ
	Q6O4hMDPeKFcMeSB3AKSutl8Z0qQGnuGWvkKOiqX1H5JkP6xUIH261iXButeoFS55D7lfk+/8Fe
	f4R4Hwj/J6JGQOAUHfh1SSAUdtUc6rjDgEO7Kvf7TPIi1zEOfiw3LzcSfsRMFs28w3JRvQshIt8
	0sdmt7wHUBbmCklZDUnzK9nCZAphQIWn/OLY7w
X-Received: by 2002:a05:6a21:748a:b0:3c3:a41f:ce83 with SMTP id adf61e73a8af0-3c8ba62e7e4mr2893948637.61.1785241720223;
        Tue, 28 Jul 2026 05:28:40 -0700 (PDT)
Received: from localhost.localdomain ([103.179.230.124])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1290sm43423129eec.1.2026.07.28.05.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:28:39 -0700 (PDT)
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
Subject: [PATCH v3] PCI: mediatek-gen3: Fix 64-bit type truncation in mtk_pcie_set_trans_table()
Date: Tue, 28 Jul 2026 12:28:10 +0000
Message-ID: <20260728122810.3475-1-sreekuttan2156239@gmail.com>
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
__ffs64() uses 0-based indexing, so the '- 1' offset is removed.
Additionally, return -ENOMEM when translation tables are exhausted to
prevent silent failure.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v3:
 - Reformatted commit message lines to under 75 charactere.
 - Aligned multi-line function call arguments according to checkpatch rules
v2:
 - Replaced non-existent ffs64() with __ffs64().
 - Corrected 0-based indexing logic for __ffs64().
 - Returned -ENOMEM on translation table resource exhaustion.
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index bcbd08c82a5c..e2fb6e372ede 100644
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
+		PCIE_ATR_SIZE(fls64(table_size) - 1), table);
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

