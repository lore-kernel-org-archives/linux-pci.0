Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FD41F378
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169756; cv=none; b=dIlWuDQ7WlNauecYpMq2ipYEnEOhITfyAQ9OSJ2eo0n0/xbUDoU6SB1IsX7qKYhvIHdhzxseSHVE7gb05hiPtPFL+aRe9NQ1rrJBwNXcXb/i5f8ykFYjMM+ahwwK4lUOTJ8lfYoP648YZxlgTHr2TS7gm9tVnzS7FtdFoHzThPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169756; c=relaxed/simple;
	bh=nttleM8Tx0cIVF/OubkghUhIrwkhO7hXwcPPrF0zhrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jl6DGUDqK4ERcV0jrmRZnse6m6vb8VZtwVJXhG5A7C6um/Sg0lKoVckOH0rm2MDf5Bs/my+Dd/EKtJSH1fOoRJwQTkuTQeJ3iQeNlG96sEoloP5cgApagCxPfVQNBR4GTo0QFHNPdIFqEVfO3VWeOZkavD753NoTM335hX9HpoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gZIQPoqd; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gZIQPoqd"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-782e0fc1e55so492561137.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169754; x=1789774554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TL/+G3e3u5ILLrluIyCPB8J12Dl41Ws69Qu/dHBTdLE=;
        b=h6KoZtvd5ozxdqQs72+idn/s0hYc4l81gMoT8P90NS3XdMyWtFRcuWwLpinbC7OqGx
         xPun1I/tGu7zldeAge0xgpb4dhbZivWSqQ2g8kv1VPy1iJutJugfZ0NqdtSbj83nfPii
         mmg6mFzdMC3+pji6+2fElWRc7+7roCGCCCAYNyfwe6PRKYCPSmm0YkJSyKQ3uNbMEYR7
         /2qMCaj+0TGr0tGrfZbePlpP8wOmVeB6oXYX7B+o/HHEg+AJQGRSw6zrBcI5FfTUBgBh
         rry7rYglggxMKePo+L6vmppuyMVtoqoQOLylJX6SYtSh2JdV8XlriTpfVvN9pY0mpjMz
         ArvQ==
X-Gm-Message-State: AFuF++m8sZJPgL/Cb+QzSH/GmPpC6by0UHZtd8kx/dIbh7HV6DwPlevC
	EGyWP7dboy3FcVBKYgXxUprD2/M7jqZxMhtbZw1bB2A9kQ/GXiMVi5qXzthYDshuA6zPW8DRBYr
	DbkVwKhHpFch6g6jqqMbMpYaaD1+WFYLAT4GD10AExP3cBTSRknTKBk6StKJo+99WCXcq3fipBZ
	NVvEN5sx6aAalaOHfndVX8CoBkN9s3oEGfEKT03ta/F2y5zXonV0lvV/q8uOFyvFZTFFqihrJwh
	+45jdhe6dH2yyUE
X-Gm-Gg: AYBFou1GFa8T9WqgCgYLeg5F/GagfnS89NkPbUI/UPHai55xQe6ORKIaMZ9YkWQ6Kh0
	zXgc5SVIcqJVcD7ZESyAuX4Iq+OwtKNskSxmSIVoWAyiB2B6P2MzCE40FHau9ZnP1H4nzX37Opr
	TTCsLeAlKD3y7/JIOss/pLJAoQOxy4oWKBRRWO4DAhB6Bm9KXvvjDf4bvko70LZWhyymxNPuVaW
	EnEIS/faJdujkS3CbsPjd9bVn7M0SrcFNibuwOUckgxug4i+VGOJyoM4xHOiD5Y8leZAEVtllMG
	ZYnBIv+kKVy9wz5kAs5amd4kfWEek5tI8vUHcilTaITrFbfuR0vowUFq5th3f0CDc67wlWkfa/k
	YCxAnjaSKkZonPDaUGXVV+J9P+uOf/hibDM5X39JBf5vfC9+Bf202Jip3f/O0
X-Received: by 2002:a05:6102:390b:b0:779:5049:87b2 with SMTP id ada2fe7eead31-795a0ea85cdmr674427137.0.1789169754083;
        Fri, 11 Sep 2026 16:35:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-795a03d33f3sm8074137.8.2026.09.11.16.35.53
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:35:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53013dc2330so29725311cf.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169753; x=1789774553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TL/+G3e3u5ILLrluIyCPB8J12Dl41Ws69Qu/dHBTdLE=;
        b=gZIQPoqdAAqhb5huqkn97h2zkxhCXrW65TjzrfniLxZLzqQjNMQqSULXslpNfugxqt
         +QURE23PufRHEySGKH+0aej0yvL8kT1wZx8yZhdd4rd6E67PbP6+uIt/EcaBnG5aIKDa
         INA5KTzuadk9yIYiNZ1CKahdNygL7h9dAEYi4=
X-Received: by 2002:ac8:6903:0:b0:530:cbf7:6bb7 with SMTP id d75a77b69052e-530e81f5bdamr6175221cf.49.1789169753298;
        Fri, 11 Sep 2026 16:35:53 -0700 (PDT)
X-Received: by 2002:ac8:6903:0:b0:530:cbf7:6bb7 with SMTP id d75a77b69052e-530e81f5bdamr6174881cf.49.1789169752856;
        Fri, 11 Sep 2026 16:35:52 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:52 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/13] PCI: brcmstb: Declare and assign quirk OB_WIN_32BIT_ADDR
Date: Fri, 11 Sep 2026 19:35:29 -0400
Message-Id: <20260911233541.1650895-5-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911233541.1650895-1-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Even though only BMIPs chips have this quirk, it is more uniform and
readable to define this specific quirk in which the outbound region must
reside in the lower 4GB region.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bf002bcf6bd5..71ddd8a760af 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -288,6 +288,8 @@ struct inbound_win {
  * or a hang (AXI).
  */
 #define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN		BIT(0)
+/* The outbound windows must be within the 0-4GB region */
+#define CFG_QUIRK_OB_WIN_32BIT_ADDR		BIT(1)
 
 /* FLAGS */
 #define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)
@@ -519,7 +521,7 @@ static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
 			  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK);
 	writel(tmp, pcie->base + PCIE_MEM_WIN0_BASE_LIMIT(win));
 
-	if (is_bmips(pcie))
+	if (BQUIRK(pcie, OB_WIN_32BIT_ADDR))
 		return;
 
 	/* Write the cpu & limit addr upper bits */
@@ -1995,6 +1997,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
+	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR,
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
@@ -2003,6 +2006,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
+	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR,
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
-- 
2.34.1

