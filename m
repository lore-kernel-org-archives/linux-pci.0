Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981423E324;
	Thu, 18 Jun 2026 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820294; cv=none; b=kCkIrXWxAx4y26wM576+N3e5BcDOXv1Z1nammdcazM/o/EKe31Xg8urAssc0Xz2w3dcVrlA5S93b8lZf3zgSe3MrXYj/i5sA/FjGOzUqt3jGfpNoy8ZSKn6UEMM6BCwXJlHf59c6YSCnWK+p7mg/TDjALiGXPfJUNdL46nZS8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820294; c=relaxed/simple;
	bh=Lg6FS4mXE7kr8V6X08d5AiHmOkoZPHTf8Zl9M2D5vgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m52ujtmtMPRFmQw7UXy4FBGtlb/XwD32WvL6CVYvTQM1X4tGYylO3HeEM1M3xt4d1/SGyJSpx4ryAzWpzDTA9I5qYtN0Luv6kppIaXF9SfCMOmeYISia67VAg5lWGLXk/kFhrNFrWKFb2vADtSRSLiKbQVhFtLCHTwZN2iI8R4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NGdGFk+c; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=x+Uen+Nt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NGdGFk+c";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="x+Uen+Nt"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ghFBq09hGz9vCL;
	Fri, 19 Jun 2026 00:04:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781820291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmxnn1xGV2jaajdnAkd2F39mWtMrhqNNBNCjdjH9eY0=;
	b=NGdGFk+cyydHEeo2vGX30Gw4A1Qu91RmrnQEqdTipFBlJsyb+isgjMT6eq6/xo2YAytYxR
	CGDgRNZNK3uZ5xoGRky4sN5lUXtCvPqKgtswJ6UFZCCNJAVkx9NyKmWWL5rrFL2rIDGWzV
	NIiJpVXwVIRjCLugjgwk/fk8Xz2O1OBUl7iqH3G8wVre0/7Q1JwSRRAx6RL3JLmmsaJiqb
	tna+HvwEcawXgih6SmAlILz7rwX1i4L3/y+LSL72gbiUD4WYrYaUcxl80eF3XIi2ymp2Az
	FJ6c+8SsjyjpUKygm7PcJV/SklldmobYZGjdDBOrVTKoJj0/nJ1FWUVXc7lLaw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=x+Uen+Nt;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781820289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmxnn1xGV2jaajdnAkd2F39mWtMrhqNNBNCjdjH9eY0=;
	b=x+Uen+Nt1+OxcZfqH03ULWKV0ZCy18GV0zzXWj8kubsqFXhoFiEWFQKNqjD1jlVoBSM7+J
	94HnrgKSp5WS/3P8wcV67OyPVeuWeo6Sdsnw5APviHfubLjOMmp590WaTiLnxz6TTHuiEw
	91RtYhKCpN/doc5tUCNtpfOurW9hAR53bRfMySj3S5yynUl65mcDUEUMpI1pCPLY+qNuex
	hIeQ5SUvch9RYS+PW5BIOAWBLTn6thNKT0BXz/mSw74ckyqedc0rjQSfiY/roJFJyjJqol
	MPUBqQVodHLfw1J1G/DPAaBNE+uax3sYuvgMJnh7RcONttooNSgVKK5+PZadWg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/4] irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
Date: Fri, 19 Jun 2026 00:02:00 +0200
Message-ID: <20260618220427.14325-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260618220427.14325-1-marek.vasut+renesas@mailbox.org>
References: <20260618220427.14325-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7x7fbqfctmuyj5g17moafybc439uyhxs
X-MBO-RS-ID: 7e6c2e40ea8eb87b0b8
X-Rspamd-Queue-Id: 4ghFBq09hGz9vCL

The GIC600 implementation is now known to be used on multiple 64-bit
SoCs, where it has address width for AXI or APB interface configured
to 32 bit, and it can access only the first 4GiB of physical address
space.

Rework the handling of the quirk to work around this limitation such
that new entries can be added purely as new compatible strings, with
no need to add additional functions or new its_quirk array entries.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
V2: New patch
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b57d81ad33a0a..8ec2175b78288 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4890,10 +4890,17 @@ static bool __maybe_unused its_enable_quirk_hip09_162100801(void *data)
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
+static bool __maybe_unused its_enable_dma32(void *data)
 {
-	if (!of_machine_is_compatible("rockchip,rk3566") &&
-	    !of_machine_is_compatible("rockchip,rk3568"))
+	if (!of_machine_compatible_match(dma_32bit_impaired_platforms))
 		return false;
 
 	gfp_flags_quirk |= GFP_DMA32;
@@ -4968,14 +4975,12 @@ static const struct gic_quirk its_quirks[] = {
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

