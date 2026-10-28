Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184769;
	b=IxZzIFACgLraDzsLoGiYb83R0QYj5/PHS/Af4A10yZCzvrZXZbLMR3gM1bvMZvw9x+E4
	 mPkAtCsy5ZulYtvlUtE2G23EryR6s5iQPYi9R4NbUUWWMpxgFuoWa+5A51bKadjbT7gKW
	 YACbFD8KxRgoiExonl3Edza8NJtAu95gdoNh08hzCMhCwyH6ZxxvWgzOYTO7SD4gjE97z
	 bBe5rHPDD+cdFaYIAmsUj7YU9hC745HCz0Jzr0MFGkckAq06+4RQCW8jqjmLWzmm4UsEP
	 4j0iGy5Qr6xHOKP886lRssgExBseieXMkZF4e/8oTZ8ecnG1pV4UJ/lbjHxTVhtE+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JVEW9pJr+HD2a1AZwH9+kAj2JVI8SOiPv9NNvo5WXjY=;
	b=oBPScbEkzPC1+3MBZPE585+u7rxFql4j+kodm0QvDFPli/nXxVkipQJdScHszm69eCU0
	 Da05pRfhURM4TeifEguuEERhiAZJMpeN3xYRntSoPeDwPGW4KS2csjl2zhsPXhcugooq9
	 iQ/k6rF2eAf1PXmSlUKJ/1zXiCSsQjoiuxwPFULYCnpME8EfNiqHQdaHnudny5QfTXlvZ
	 k6Uclg0jrsUJtzSTgvaIlTdYTHaQ+C0OdLhq+1S4MI1Dr9DInL87Hp+De9K3zBfw6M2aT
	 NYHkfQp2iLlRC6tan3KcZQMxzh72yQuqERHpOSel6dIioNXwZb7+Rk2hcMEa3Y7WZ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kcz+XpfF;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420C606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7420C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kcz+XpfF
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-14fc585291cso657506c88.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793184767; x=1793789567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVEW9pJr+HD2a1AZwH9+kAj2JVI8SOiPv9NNvo5WXjY=;
        b=kcz+XpfFSFt/rGYZlD4tmCPxIMossepLPh9HtCqJXQKvNLXdD6SlyGlYQtKPtdGcyf
         Q3CqV3mCCNjnrrXjWglhSCtoVquWCu//lNGpFMswxy+901feI0LWRH3UiYIfqzwEuBqS
         ABhROWRYeJMwyV459dqntIcWB0NK08CY/+M/nsewl2e59nLzlkROpGF8VNVFlrg5UegA
         xQSrsWkpsMnyStStkjKGccwaXJu9SweDjnYG0vY/vu3ocCZgY4gk6rTnqxarWJ4IRQfl
         dp248GbFqb6P4Ir7WGLdaFfTj/1Ef0uyPM8TB5m+KmfDVg+c4O11Un2GDiO/4v6Qr8XZ
         i9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793184767; x=1793789567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVEW9pJr+HD2a1AZwH9+kAj2JVI8SOiPv9NNvo5WXjY=;
        b=MfonaudCDWO//dCNnZH6wgtTba6U6bqFdtULdJjyJ/xvCEYpvLxq5VfD1yj9hAyhDS
         44c8Y4hmdcbc5/0VDKa4dDR6Q7EW8dbgQkmAWDF+CXJB3wvXMvvO7bzjpmlLuMXqoruO
         Z/x818XXu1YY4kA8O4tn7LWXeBCH9Oqhm2cULFUio1FUCuXGRBKcYw54up1hmEMD6wnx
         YuyCtq7eKBEUUUY+wsgO5Nb5M0AiGo5uyUBhLhL/yu/2o70NP3jucs1/YeY1/zXu+FNV
         kmL9DbbUNeGrFYP1mQ5eLFBUDxhO3uZ9RYeOQ7s4Mj07kPVEWEnPXEtuhQKW50ct/t1V
         kTLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW39v9opAyZxdjbdIxV0Mr8Xxm+yhEfL5lughx5DY75/o3B/10qtQRamIaVK1CgGj47j1m2EOAd50=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuDq2X/1pGeg6U9jmpIzkKLeCibnY5+Wt4fTgiVTGQbGLwjlOq
	yBSKdlMuWOmnG1bnRFYaceV+uwY6RSfF7HCIASLyxPBlJ4thyEj/St0SCd1kNA==
X-Gm-Gg: AYBFou0pOBdQb+3m5oZOUd6h1bO+tVFU3rqUVxv0a6VDiVxsPPIhpF+hM0bZfertyfV
	nJNVboQ4WuunQ6US0H/pESuHtQY7kQ9EzIjtCmuX5DPod4xb3WuIHVHNnio0bXfqfCL6eE8W7//
	rfDgWFzthELkkMePTBHgajMTinbE8BbZWEVHSAbGaozOnWMtnr9btCoCnBSanrzVMbTo78OhK9a
	A6Ozc7Falc3gY/SvxFlUrjIFjnDQ1dmRypYHBDZMStu5h6yTnYUDS5kfLpSwfLevmdt0M+33MR0
	G9xlsAp1b3hVWnU8ye3pu9/5ZnAVWoAQV8rhUAJH9li3e01aRYmPJ7JxOZPh75GDA3fhS2CzTmY
	kVuqZb6VpI5t9cGp/NvQZF4/Dwuy2unqCihUgcTkbnODO+qvo01VEepiqbhKEddiJriE+tzyI7l
	uTCM6XP02JuKdhb6jSPugQAC0j5/HGcAfaZgiPmuHeGlg2lwJ6FsXCy8hAAjHmoihm4neB+DSAT
	b6/2ptUmyMdejkiz0n1qSxWOyM65ZiWMjM+EB5FusATwqr7A07/xBX2Yy81JB/Rj0LYgDdxDixa
	n9RTwiSo31+VcSZIYyfJCErG3GYm5BKqY6shSuouZENoJEmwdl4=
X-Received: by 2002:a05:7022:1003:b0:19c:c396:37aa with SMTP id a92af1059eb24-1a6ce1136b3mr3280960c88.22.1793184767262;
        Wed, 28 Oct 2026 03:52:47 -0700 (PDT)
Received: from localhost.localdomain ([103.177.252.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a76037e2b5sm7083152c88.21.2026.10.28.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:52:46 -0700 (PDT)
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
Subject: [PATCH v5] PCI: mediatek: Fix integer truncation and handle oversized resources
Date: Wed, 28 Oct 2026 10:52:11 +0000
Message-ID: <20261028105211.2773-1-sreekuttan2156239@gmail.com>
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
index 3a3e91cd0c21..6821452a82b6 100644
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
@@ -753,8 +756,15 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	size_order = fls64(size);
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
@@ -775,6 +785,8 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 	struct resource_entry *entry;
 	u32 val, link_mask;
 	int err;
+	resource_size_t size;
+	int size_order;
 
 	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
 	if (entry)
@@ -829,8 +841,15 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	size_order = fls64(size);
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

