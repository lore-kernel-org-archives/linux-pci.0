Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE24CDA12
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769978; cv=none; b=DnbLf5yWc5NxtCRrgOhM7uVsNOEGPdH/Yk7bhx9AZ5N4ThcjLHq25fD2QxVOKkTECQkSy2zjn8YulmWpzWPvyQKs/QsSsAf8OszzoXOxjXfhYhP7x/CB8f+aA4MjTiOz85yN5KolLISFTv0ysgFcyf5fz2oEC98izMTsusGI7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769978; c=relaxed/simple;
	bh=Vt4ia5x+usvyJk52AHWXJokI7cBaJIIJYnNQaHfu4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nS65EmoGmtP5roYCByfJGNsExVU/gW9/RRSzksWKuUjOWn4OwwCvwbq8cma1WEh+u6EYkHKUQopt2ELbQ/MktmHrD4oNTp9pPD1bm/Yh0ByvGFw5GemO9wUY9m1QNynOftYonmR7gAmuhRC0HdpIctFlgmZLqXq30fDS2yDFh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRsjowF5; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRsjowF5"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bcb929cceso1001065eec.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790769976; x=1791374776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jNaKwS3H0FTb6G3uXAp4oWpgGMYYjT9MmVEzrS7Q8MI=;
        b=PRsjowF5GgKjsizvDmBB8vAJgm1WMyZ7zpzlwUlIUI+oLmFIkSb8f6dSU5T5ZZEEba
         AnbfdISYmtoiab6tk0L2TttaRpQBLE1STNz6HTWytH0WLL1+jW5CwYOIf06Hv/iv61XG
         kN1aDlEG5633G7BdNStynXrgyhddqepW7KsB2J8CMWMegsenfyPPJ7SKPhPMxIYN+omu
         9DTAhgk5PAE1tCGcvf/evTh54bZYg7sbq5eejFR9BAoZvHhHgq0wmzfgectnSoDLu0qI
         sfFaLF2EXgEYFwWxFC4JEkdyQfhE9aA/ZbugXIGdjX+Hk3+y8OF+pkIulma+XV+vAExA
         zncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769976; x=1791374776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNaKwS3H0FTb6G3uXAp4oWpgGMYYjT9MmVEzrS7Q8MI=;
        b=V1mpijSKN9bMG6Kf+LZ+efZZF9ZJzrt/p3k+uCUxtg/pQ/grcu/HCQ7mRo9LmHBcST
         ONN0BOB/NjjGwIK4KrDAmXvN9hERmJ32jKb4pSi9p/H5XGsKRK4EH+YGO80I+E5R2Dfv
         s2csj/HweXiG0mlC0w1VEchHvLqCN3+v9AJu+CKHh+qCWR2xiDRwB7IlT5vpA5a7RwGm
         yq947h4bI2JZvO1rwX9kb635NXX0i8MpivsB/uhLMN0vURRRDi3SrpT7y/tb+jltYz1x
         kd3/MzMdBpZiOVqedQiIvMgrYL6hSnTlkRLwWay7P9QuyTddIGnXKXWN0BTSDapl1A3J
         IFow==
X-Gm-Message-State: AFq9FYIMDs2bQKhqIiXteE4s0+/4XL8emj6AT09WsHLD8JFLej5/zvmP
	MCxnx507slMA5IyzbjR+/mDtijYVzDThIPg/v6HYZcMhVXjtEp4JduuC
X-Gm-Gg: AYBFou1+trDzWb8ud8mKh1m6j8FESzozrXpOT4ARL8Q7pTnDKqmvqMjl4iKahtBInZf
	nx9yk+6kmQ8khVIubULS54fxQFjYztnjrEE0MgbfJpaV6RJmmcmDMBG2kjWHR7ohsI+4B3cZ0R9
	MU0NgFTqZQiK7qTvpvRkYiVHM2dBZ2sDuH81Sem0DvTSswdHdrQNrWWvYnY2hNqVZC0QaAqwowl
	Hzs7WRk9w4WFsSQ07LUqomOEj6zK5otiIhEvRlVNU/7DbrQM25D067MWMxPf8sKu8gThh9Q+lG8
	sAk+GPojCFTgw6uoPjeRPHXM9PfKCSexQKXOfkQCiaExr5C/H6uy8P4Gn6mFbr0wIQxqwDrK9qq
	JzsX8HIQS32eEJ+I8PloEtEOBfs7ElmsfsqlZhhy0IbwLODmXy632lZvZMhqLaxd27G9+4MjSqp
	2QtGETae1zASNMt2a4YP/Kbos84De1FxS/BWoupUOHmzL6MJWppdfPQPB9JHj5Dudr8LCSGGlNS
	skmI6mAlUQlJRlg49fh
X-Received: by 2002:a05:693c:20cc:20b0:34c:df85:8e3e with SMTP id 5a478bee46e88-34cdf859b93mr1452972eec.4.1790769975550;
        Wed, 30 Sep 2026 05:06:15 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cef75459csm4692705eec.0.2026.09.30.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:06:14 -0700 (PDT)
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
Subject: [PATCH v4] PCI: mediatek: Fix integer truncation and handle oversized resources
Date: Wed, 30 Sep 2026 12:05:39 +0000
Message-ID: <20260930120539.4967-1-sreekuttan2156239@gmail.com>
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
resource size exceeds 2 GiB (order > 31), the log2 size order
overflows the 5-bit mask. Clamping the value silently truncates the
hardware window while leaving the OS resource intact, causing bus
errors when accessing BARs in the unmapped upper region.

Fix this by using fls64(size - 1) to accurately calculate log2 size
orders without off-by-one errors and returning -EINVAL if the resource
size exceeds the maximum supported 31-bit window order.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 29 ++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index a60d1ae076f8..639884b22ad7 100644
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
@@ -753,8 +756,18 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	if (!size)
+		return -EINVAL;
+
+	size_order = fls64(size - 1);
+	if (size_order > 31) {
+		dev_err(pcie->dev, "Memory resource size too large: %pa\n", &size);
+		return -EINVAL;
+	}
+
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
@@ -775,6 +788,8 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 	struct resource_entry *entry;
 	u32 val, link_mask;
 	int err;
+	resource_size_t size;
+	int size_order;
 
 	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
 	if (entry)
@@ -829,8 +844,18 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	if (!size)
+		return -EINVAL;
+
+	size_order = fls64(size - 1);
+	if (size_order > 31) {
+		dev_err(pcie->dev, "Memory resource size too large: %pa\n", &size);
+		return -EINVAL;
+	}
+
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.55.0

