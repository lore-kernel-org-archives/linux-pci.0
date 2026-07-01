Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ABD3ACF0F
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938397; cv=none; b=qm2f+QnuvnR5zlhuMxhRsvzwtv/HxuLUVvPj35Ul4wh+Uvujm7GZu0fNN2eVgZnCo69zB9831/Ck+F6pWGkX85PXqIyTdHvqsVRAmA8GAzYx+1vaZFcYWsu4w6n9cShsJh16xPw8EodzexW/X0rtvKD6B2/GJMJOg5DtJGL0bHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938397; c=relaxed/simple;
	bh=BDMVOYfSzmYK88antaJcLEDDZ8VIByua0/knZjjcOMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfVLL/dLxrLyplvEI4d6blXHMGPW5+TYV4hUdp3Xo4QwM2pXvMm2T2jdYPVnnas8b8oBUzQAczar5Z3qyA5sDqDq3lUAKk1VqGVCkFYRj0F0F8Tj6NOyEV1U1KJR8t1mJkdXwwYZCXwtWh3JHWcwiwHKPneh3G9rK+g7z9mFlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KHfnHQq0; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FdE50ibJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KHfnHQq0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FdE50ibJ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4grBhp0ft8z8v1k;
	Wed, 01 Jul 2026 22:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782938394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmHYd1sFTH43Lmml7PRtzcMJew2retjIZi7cXCoFSw8=;
	b=KHfnHQq0drXE9bV3r4ULc4BO+MWZoHwwwMpUQ3l6WK2lgLN1EDl8V218/zAD0XLnaKXc+e
	86xRxvUnCSkQgfa0NPo0JyiIHz4XWTocWuNKaqJMbFeYaQAnOoq3kbtuVcM9FysG9OYwT5
	kH0OBIbsZmjyOWrb8i7qaRdBGJ1s9jXWBBWFWSoVh3oIuCxjEQa7WF91T9BQZiY/il8esu
	On5Pm1y+ZTDCYN2XMlGyKmTiiBx09raSKWTDX3NmVqB16sL2t8VJdmWufa/nG+l/QjQojn
	EdOLfarOHFqKORlMdDz5C6CEI4vw09HjaiKFUikDKa3o0ozumd8CJaDeMb1bEg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782938393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmHYd1sFTH43Lmml7PRtzcMJew2retjIZi7cXCoFSw8=;
	b=FdE50ibJIgqdvW3WWBhdNIZu3rpJFYGXDg6otbO3Kw8hVX1rQL4xtMbQ14H6B1Hf4BgjcZ
	58bbTTuaWoDsm2JhXsRYgJEkKVyQGJYOwzsoOaj/0OpeWM8IqBCA6ZABjUrwUlK3rUsk01
	dHrFgHEDl/Jbc/BYLjzEZ2B4oorxsH2WdvVWPFE5/HFuZ0KztHEqBSu7XVREu5wWfdoYj7
	04R8m0FQK2lXPIm+U/PA8CwKBaLpHELu+5jOo0HB5V8E/OKnImJPUmaVR1nXjGWLVIWagB
	1On+LBZunI0x1o+synWmAsll0OOHJJ1rsfy6nxmmVnzbOkeUIhwUlKdzuib95g==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 3/5] irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
Date: Wed,  1 Jul 2026 22:37:46 +0200
Message-ID: <20260701203918.63189-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260701203918.63189-1-marek.vasut+renesas@mailbox.org>
References: <20260701203918.63189-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z9dif8f188mgzraryo11fuf9xrr1o4up
X-MBO-RS-ID: 665339410f40b0306ce

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

