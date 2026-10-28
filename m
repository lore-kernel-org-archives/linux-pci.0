Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187380;
	b=f95l+URDUhQqR5pJP8fnxg3wDD0ZH8KX2c6lPvJiHz2IG03JczE8QoTkUOFESrrx3ySY
	 YsKrkRTSakDWH0uLeYd2utxkznryU2CkWCI8AdZ0zPBodYPFxeo1TF+ekGdexIgh9gN3S
	 CRtF5YdnXuEwXDszV7dm78sQXKWOIJ+cbIOwktoIKBYpMJJs1GMv/FElsZQN8UtbSPBpn
	 WoCIHRo8S9jbdCwv6YoPMkW27u59QL/WG7jGUKB4aVjv11E9tdnDlgmFQ5lQ7W5ld8/sN
	 m3iGE++MAvbyqKUkSuhTDcspm1VwE0A6l6q6Dp+vLJHYY6MZzWGzRCo8+gmGytzXwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BqcLJCt/Zv6v/NHtTbSxJ0dXgZEQb3K5NLkXSY+SP5Q=;
	b=Ic7IEjvKs5UM16PCxw2SovAp4Yqyjot8SSv7+bUSyFiIHZLt4BqkUf+v6GDEbL8tF5C5
	 CsRgibkdCnH/phvl144LXbBih4C3ryR/OTawLPjmupegmaawZPKjBjpyk6djTPjZIf6gR
	 l8rQvdmVSbnUq+FNYEEfJ6SUqyKhsZbTEPfCCV6nhy9OGp/uJrCo9W4GzEW9Ta6CZ6/Kj
	 m8WqEl1FITBprH0/7o3Q/aQhjtNMVgocHWexe90Nef3MpWled0k2KTjGhFLGY7wVxvg/k
	 n806H44KwL8uwcc5VQ5SG1S8aN/ff4VOzr9zdeGboF7iW+tL902+e2eLEcq8Kmz1ekg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JF5UzmNd;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B1606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 11:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A92B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JF5UzmNd
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1821745eec.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793187379; x=1793792179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqcLJCt/Zv6v/NHtTbSxJ0dXgZEQb3K5NLkXSY+SP5Q=;
        b=JF5UzmNddHhtz2/oYUx2wKcB3EeIBY/JHtxjH5/Z5b8X1Y9wWsMOHPzWhSL1MrNX9b
         SNEHHLtuL/8uMApI+sQoUlmCZ+onKTHMg3Pypzvj+cVgdOYxvLhy7yIpw/k+Jwp8QIJx
         Tfl9uLSkTWLIS/kOyM2O0UMXicgTi/C1puRPBvFATpbCS3FohBEjmbRsYqTGBFIC/IU8
         pD156d8CkJyMCCX+OIBvCFOxTug9Y+pzpD2U2XF2Pbi5+2VrhRfUMaoL9D9faXSR6YSs
         0YTafJxXP/NOwqXtlMC37UQzeXHLUdkLgxX6uNV5RDd0mxKomGXSEldkhTpWs9xee5xU
         Eoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793187379; x=1793792179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqcLJCt/Zv6v/NHtTbSxJ0dXgZEQb3K5NLkXSY+SP5Q=;
        b=yUiXqk57iHnitLE8rM9bNGjt9v5r581FcPU9geaavlMsT7L6OJoypwPh6IwF6gvlyJ
         3Xci9qAmjWjW8nnkZyiN5+Qy4eA5WjbZ8URe0LYUE+baGen1ycjMJSEH0jG6xoFzeaE9
         vAbCo/XPMJiizs/HhyEoFrZWIRukx2VBw3M4nU4eraLms33VuFvRTABaA+rn9sW7gsA1
         btrMLLYpjWMsX9Hw2IzF/a/MUMXF6La1MuQn4V4qWcp6zP7HUI6wAhmZ/FzbHTAYQoMR
         gwVk4MkY979RiuJ+qi5UVOGML4BZshQbawABAolTnzn4iTZOD+VHL6ZNkZEk2c25kcj/
         Aubg==
X-Forwarded-Encrypted: i=1; AKwUvBwaefRWQ7q42LerY7afZ3VnJJ/fpFwKm+jgpjHeR/LFW5jJUhFQyZ4h184ogKZq9D9IRj8sPYlpEn8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfzfuBs9AUmzpnJIc3Z8gEC8g8pWqMQm5NndOeXBhENF8dsLOg
	qWXOnNeWfBcZY3rvIxeGkNFogEggAYfmzqRHFJ5OMcMLon9J1z645H00
X-Gm-Gg: AYBFou2gi1JqHnxroD4wM3aYP6yddqSmzRWj42t6PSsWW6gtl8URe7Tj8E8tun4vDcd
	LTSSX6q6IOIacRQw8cNep/N03W1mhpQ/VBDkvd9AApgYzSC2YQ9ctoP7iN4bNgLTDUXiba2xl0Y
	D8BzZ7E33uaKp/aOnmpbIkcnoN0tPmSC7slgzQljhZtxtCHmgqtcqUfmQWKGoseu17JNM0UCVJ1
	Zzeqh1xrcJkK20EdWBAIEbxCoEnafz7tC+/hZXrETAmeXzunlEvrSKA0P1IBh/c3b9WIYpWDiP1
	DtBDT1kaeRahvuig10z+1McxaNfMCaNyZricCRapy+hgG4ZVmc3OvH8ekK4DtCwQaZQodW+9xe5
	mksPzvm5NW6TEKaIpT1igMfu2IoDIgvKPihIqT83ibWidwPhOrsoHUrQX7d+8z/F1x76j8fiv30
	NSzRhjmZDCS2SKVPeJ9vBLj1g+e19lnN2g7vFk42cPowm2s7jTqd7aFUqJ1P1fhoCLFxMgs9qf2
	Nb3HXD7Wn6N9U/gCaGHWCvJ3R38rGs51ZXfQfR3JMHbWvHHIC1ya+4BarKi3Q2kB5D+5sNYclUO
	LEEfamRzqGRJhVKY8JOacT386Z/wIw347A4O/9OTFrU1TL2HTyo=
X-Received: by 2002:a05:693c:401a:b0:369:f05d:6c5c with SMTP id 5a478bee46e88-36a20477909mr3084505eec.28.1793187378627;
        Wed, 28 Oct 2026 04:36:18 -0700 (PDT)
Received: from localhost.localdomain ([103.177.252.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238d9a21sm6623522eec.4.2026.10.28.04.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:36:17 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: mani@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	ryder.lee@mediatek.com,
	sreekuttan2156239@gmail.com
Subject: [PATCH v6] PCI: mediatek: Fix integer truncation and handle oversized resources
Date: Wed, 28 Oct 2026 11:34:53 +0000
Message-ID: <20261028113453.2599-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <kfnxuro5xf4mhokabg773zcyp7otcjxwpzcn3dlo6y3kpv4uv4@bne4qf3vcif5>
References: <kfnxuro5xf4mhokabg773zcyp7otcjxwpzcn3dlo6y3kpv4uv4@bne4qf3vcif5>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resource_size() returns a resource_size_t, which can be 64-bit on
64-bit architectures or 32-bit systems with LPAE/PAE enabled.
Passing this directly to fls(), which accepts an unsigned int,
implicitly truncates the upper bits.

Furthermore, AHB2PCIE_SIZE() uses a 5-bit mask GENMASK(4, 0). If
the size order exceeds the range representable by this field,
higher bits are discarded by the mask. This can leave the hardware
translation window smaller than the OS resource, causing bus
errors when accessing BARs in the unmapped upper region.

Fix this by using fls64(size) to calculate the size order without
truncating the resource size, and return -EINVAL if the size order
exceeds the supported range.

Changelog:

- v6: Move oversized resource validation before hardware
  initialization to avoid leaving interrupts unmasked on
  the error path.
- v5: Use fls64(size) instead of fls64(size - 1) and remove the
  redundant zero-size check.
- v4: Fix struct device pointer access (pcie->dev) for dev_err().
  Verified build and passed Sashiko review checks.
  [Subject: PCI: mediatek: Fix integer truncation and handle
  oversized resources]
- v3: Replace clamping logic with strict size validation
  (size_order > 31 returns -EINVAL), add a zero-size check,
  and update size calculation to fls64(size - 1).
  [Subject: PCI: mediatek: Fix integer truncation and handle
  oversized resources]
- v2: Add size clamping for size_order > 31 to prevent overflowing
  the 5-bit AHB2PCIE_SIZE() macro mask.
  [Subject: PCI: mediatek: Fix integer truncation in fls()
  and clamp size]
- v1: Initial submission using fls64() to handle 64-bit resource
  sizes and prevent integer truncation.
  [Subject: PCI: mediatek: Fix integer truncation in fls()
  for resource size]

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 3a3e91cd0c21..cc04a7b862f0 100644
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
@@ -693,6 +696,13 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	if (!mem)
 		return -EINVAL;
 
+	size = resource_size(mem);
+	size_order = fls64(size);
+	if (size_order > 31) {
+		dev_err(pcie->dev, "Memory resource size too large: %pa\n", &size);
+		return -EINVAL;
+	}
+
 	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
 	if (pcie->base) {
 		val = readl(pcie->base + PCIE_SYS_CFG_V2);
@@ -754,7 +764,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 
 	/* Set AHB to PCIe translation windows */
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
@@ -775,6 +785,8 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 	struct resource_entry *entry;
 	u32 val, link_mask;
 	int err;
+	resource_size_t size;
+	int size_order;
 
 	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
 	if (entry)
@@ -782,6 +794,13 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 	if (!mem)
 		return -EINVAL;
 
+	size = resource_size(mem);
+	size_order = fls64(size);
+	if (size_order > 31) {
+		dev_err(pcie->dev, "Memory resource size too large: %pa\n", &size);
+		return -EINVAL;
+	}
+
 	if (!pcie->cfg) {
 		dev_err(pcie->dev, "EN7528: pciecfg syscon not available\n");
 		return -EINVAL;
@@ -830,7 +849,7 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 
 	/* Set AHB to PCIe translation windows */
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.55.0

