Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3DB3E8337
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456692; cv=none; b=YF6dDYtMO6AfoQ/toXVdZhQbXDnlC0llmU7MQPHeH0SNfKD5sdiJVB9y+hDyBqEoWHLj6AVgmiea7VW62RJVydhtzpQTEpfavd1H3PoIG31LN8pSzTBz2Cdx6//HWfgtD+ncd2SW129ZsEfJdWg6OuoxMQH4j1LdgImwhhpHb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456692; c=relaxed/simple;
	bh=LBKmkkU2X3Cyk1RCP4GJkwumAhXEjqmvKgT7ZOvsMxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EONSO8T5n/RktyflR+yFtdaKFppQnmw1hC6alOJcuWA8B8rO/RyPaYw/JLzwEDOH0zfMJsYhlqLHGBjj7MHXY0NtlX9pY5XNuzwi73KNOkQNWIDCtuF/VeIK1enRJZDlwFDWLCAoZGqKOMUWHbkki2d4xKH+5e/HqwdRC5dn9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=w5pG8vNG; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xzXZUerQ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w5pG8vNG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xzXZUerQ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gvtN13y8TzMlG0;
	Tue, 07 Jul 2026 22:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783456689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5qJby9I59JeAbKGM3NVCZ8sOoi5TmyOCjfhkvICWZI=;
	b=w5pG8vNGqZGWtrgAOutKTwKfTvonJwmQlwaon9PrSMA6u8sILwWFlgB0vxGTGYYg1BUzb7
	uR6Z4b2U7fvbdU5dHDprFraC3mdBdCqsq3TKHh3zuIuNKWTGnzOIDDlTGcdhAwof4A6DhV
	1Rt/Fbui8Dh/V03k8wKAHJwKflC8X0LcZAIBsYpY/mkX8Hs4bWg1n24/9sbPLVorbzsTi0
	z7BnTmJ8f16E+4CE7JJrr3+jlJKOaR6/lh6YXtnUWvt4LDW2/+vYbmCmdAUoEhRY+Kn5ww
	v/rVCxMvcEdyICLZ9L7MwIxLIx6rz5b17/mOfuTOo9t9ZGyJy2RD8a2smqTAbg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783456687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5qJby9I59JeAbKGM3NVCZ8sOoi5TmyOCjfhkvICWZI=;
	b=xzXZUerQWNiuVvbudDWgMhrAnan3aE6PsVadJQAwBVcsaMf4LaLcxg836OK/xKwJt5PkEz
	IlAfbqi2gOxaD8gijvjFBWXgUQ6zNkHTBUSIS8Ww/4yidoXU0xXAXlLpd0biqSy9Gxxum9
	/TEItFThVJb1GE+e/KdQAr2BotPw0t7XAmQqQN7aAwZcs70caLiiuDol2mWu4X5wLZYljg
	NR+Tl3Z2/0o4eUk/bYoZ26Ft217muKQaQWGVY3ixsD3kaamhMVgVZCYdQxKyymtC8Vea1w
	pVVYCy6nkNXhql4q6BQR1be4YHkXPL924ps1aZHFjMGtn0o2MI5ZyhnscBN+8A==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 3/5] irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
Date: Tue,  7 Jul 2026 22:35:41 +0200
Message-ID: <20260707203743.88299-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260707203743.88299-1-marek.vasut+renesas@mailbox.org>
References: <20260707203743.88299-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f7264c2498d788ac65a
X-MBO-RS-META: 651fmi1tq9s1138atg6yz34xujae5e77

The GIC600 implementation is now known to be used on multiple 64-bit
SoCs, where it has address width for AXI or APB interface configured
to 32 bit, and it can access only the first 4GiB of physical address
space.

Rework the handling of the quirk to work around this limitation such
that new entries can be added purely as new compatible strings, with
no need to add additional functions or new its_quirk array entries.

Acked-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
V2: New patch
V3: - Add AB from Marc
    - Drop __maybe_unused from its_enable_dma32()
V4: No change
---
 drivers/irqchip/irq-gic-v3-its.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6f5811aae59c1..d7b46c10ef940 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4888,10 +4888,17 @@ static bool __maybe_unused its_enable_quirk_hip09_162100801(void *data)
 	return true;
 }
 
-static bool __maybe_unused its_enable_rk3568002(void *data)
+static const char * const dma_32bit_impaired_platforms[] = {
+#ifdef CONFIG_ROCKCHIP_ERRATUM_3568002
+	"rockchip,rk3566",
+	"rockchip,rk3568",
+#endif
+	NULL,
+};
+
+static bool its_enable_dma32(void *data)
 {
-	if (!of_machine_is_compatible("rockchip,rk3566") &&
-	    !of_machine_is_compatible("rockchip,rk3568"))
+	if (!of_machine_compatible_match(dma_32bit_impaired_platforms))
 		return false;
 
 	gfp_flags_quirk |= GFP_DMA32;
@@ -4966,14 +4973,12 @@ static const struct gic_quirk its_quirks[] = {
 		.property = "dma-noncoherent",
 		.init   = its_set_non_coherent,
 	},
-#ifdef CONFIG_ROCKCHIP_ERRATUM_3568002
 	{
-		.desc   = "ITS: Rockchip erratum RK3568002",
+		.desc   = "ITS: Broken GIC600 integration limited to 32bit PA",
 		.iidr   = 0x0201743b,
 		.mask   = 0xffffffff,
-		.init   = its_enable_rk3568002,
+		.init   = its_enable_dma32,
 	},
-#endif
 	{
 	}
 };
-- 
2.53.0

