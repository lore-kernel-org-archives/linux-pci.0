Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2E3A963E
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233705; cv=none; b=gG2kirvggvP24zcB5OiurOUu1jHoqvvd1ISdRqMXY+txYyuz03yTsY7Lj5OCnf7p2IeStjBUzfHpuk1sKUJY/Db0g6Tap/MrOG2HHBevYnchaT6igPim3zwII0A3/tqPAg+WoNi4vvEFN/nUKMofVsTC5dFHt5c4FqKaSjEdv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233705; c=relaxed/simple;
	bh=WAh+6Vu+8tDjvTcIAwshasL+CSXaPWIxhlVxyvErzt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m21nN1Wauq0WvJVNwSUEHUWP9rMSeFImi7SutzGa4soJAJc5IY0zbZt2zGm5o2JG6Pqk2/uv8FSe4pEqd7cFQizN87yfk7D6SjoO6sCmmDdr9pHw677FluwJjcZuij7iY6qLVjyUf98jz/+JRoDV1giDLNVEDYtEa+spFuFVWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyqJ3gJR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyqJ3gJR"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca913a601fbso2673185a12.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785233703; x=1785838503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Pnt0soTO1gFV2PGWJ/CfWR6YVxz0SNsCn9Ue8Tlcz8=;
        b=lyqJ3gJRbhdsSQXy8se+AYzVq7oiWUvdwF1fhc0e7B14AH1tBPTGiWmHSzLAFXzIlM
         zcro2dY5wga5wE5gAkSTxPLLyDpnY3XExwV9AiklNJkxftVUk3/SMMeZBsgtaC4S7anQ
         64S8PA21p2Rkb11A5AiZ5aXdBKVKSKSZNeWjOISNTEdyE8/UlXdhkD7W522HdLkQ8S4Y
         2d4AnXLQMO3RepOrQEP0zfATytSwcKQdCyjlM6Kpxviilkz5h7JQAyu4io0Ffb0kPpuF
         0DoZs6pA91mN/ReROlOjcFG2W8l01x98C0/fsT3j0kfR+HrrK4GDvCY3KI8CJ2eTUzRy
         fzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785233703; x=1785838503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Pnt0soTO1gFV2PGWJ/CfWR6YVxz0SNsCn9Ue8Tlcz8=;
        b=hRd0qyrgNiYy1NkpyxbRz5/upRsKPkP5LpKIfqTj0OeyqvjGkDvPponhcyQsUyoCuG
         pw0eNQDYPe5z1VjsJkDrEjMRgx5ys42SfmDn5rBu15otNEdd3cLn54rbx6WnKB3dFLCR
         fhQBdsh06yvLs2ATXT2niLqyn8j4TFipYxhjqzmpIVwrJDfHYgcNX7m6auIjF7ATVPmT
         W1BlT8PvjSn315K2Iq6gWSzQ0PCOc4y+oCKEYNhLwUQHK9yMNXqv5uKnGJmjsrwYAtHE
         M3Gzo1XGXssAVVH0l0zP4YjOK1LnznWy1IL70a68+YQ3GLR/aCznsj87cI9bF1Sfb3ld
         6i2Q==
X-Forwarded-Encrypted: i=1; AHgh+RqyAhiy5pxL833YApWttIRxRONHNfyeliGjQmiwEGLtB0TyknaGbnVofzt1UUWnEmK+jM5n38MliS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgoEuQqtmEoNGLnbsMx0q5ruBUehW6aPP9HL54hOO0PAYuX/D
	zXxOepZs2Ig1m4Y4qvBvWG9ZssAfqdk0QS9e0DfqeahKjjEikbbtf2GR
X-Gm-Gg: AR+sD12XyifoDHwsrYAGWdKirskTFXsMT4BdM8Rd67gB3mx788JGNyWoCeykg1c2ZVi
	pwpqGb7U8PFJG3S8ozLEf5q2cNhxTiLKG60pfXfF2SQVpZR+Fj5DvrVF2KoGzWRn3ykHMAbu8f+
	MFoFgVSCry9Vmv4OKRCAlbqcgW4ujvPc2dbQbPhLe+2PhVTQQ9RYCCYnjSLKBlTWkX9byk6FS6w
	jRxmyjtXrgje89QZXp9IkXZuuJVTWYME4zCtOBd8KRpoHtokAtSmKid4I1SkdcZWHp8tomyDGaU
	/pbRMfn/6dsbXGq7UiAUkW+IfcS2xHMunoaz/h/Nfxyt2b7PtjSmn0Vvk03L/DrXRVdnOwA1abn
	Ko3wiYc00CJUT57Pq2MJMv2HkGwkJ9ySIGSuoc3hVrrmyEGH5t7O//WcrJG8b1KBzynIHvKXQvO
	0ypJdk5y3y9UJS2qLQAddnarSk+WTxN/m6U9Px
X-Received: by 2002:a05:6a21:6b17:b0:3b4:61f:1fec with SMTP id adf61e73a8af0-3c8aaf293b7mr2497871637.2.1785233703464;
        Tue, 28 Jul 2026 03:15:03 -0700 (PDT)
Received: from localhost.localdomain ([103.149.158.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5c53f3sm38682831eec.30.2026.07.28.03.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:15:03 -0700 (PDT)
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
Subject: [PATCH] PCI: mediatek-gen3: Fix 64-bit type truncation in mtk_pcie_set_trans_table()
Date: Tue, 28 Jul 2026 10:14:13 +0000
Message-ID: <20260728101413.4575-1-sreekuttan2156239@gmail.com>
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
truncation when computing window sizes and address alignments above
4GB.

Replace them with fls64(), ffs64(), and BIT_ULL() to ensure correct
64-bit types are used across the address space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index bcbd08c82a5c..b1dc18f851d2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -334,10 +334,10 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 
 	while (remaining && (*num < PCIE_MAX_TRANS_TABLES)) {
 		/* Table size needs to be a power of 2 */
-		table_size = BIT(fls(remaining) - 1);
+		table_size = BIT_ULL(fls64(remaining) - 1);
 
 		if (cpu_addr > 0) {
-			addr_align = BIT(ffs(cpu_addr) - 1);
+			addr_align = BIT_ULL(ffs64(cpu_addr) - 1);
 			table_size = min(table_size, addr_align);
 		}
 
@@ -349,7 +349,8 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 		}
 
 		table = pcie->base + PCIE_TRANS_TABLE_BASE_REG + *num * PCIE_ATR_TLB_SET_OFFSET;
-		writel_relaxed(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(table_size) - 1), table);
+		writel_relaxed(lower_32_bits(cpu_addr) |
+				PCIE_ATR_SIZE(fls64(table_size) - 1), table);
 		writel_relaxed(upper_32_bits(cpu_addr), table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
 		writel_relaxed(lower_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
 		writel_relaxed(upper_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
-- 
2.54.0

