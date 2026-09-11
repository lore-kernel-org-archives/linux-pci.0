Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003C4483A0
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169772; cv=none; b=Z9exD0dMOzth0IQA2JNhcShfjSC8ifGx9gMmQ9MbKXaptD43T9W1Kau5PEeXxqS+PZVaiE+JGf3sO3RPwlzLqg5Qd8oLnZ3ZtMtv1HiOnFUTdoY6bmARX6TN/XEAM3Y1tTK6PqkxPqrehwjRQabvtvh9x4VkwlZ2MK6w9aI4gP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169772; c=relaxed/simple;
	bh=y3ZY0wBGgYCXfXkqzJYf85Uba7WDXKBwdPkshMcU+T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGy051bGndm0rviskoxUlwX0KZynRULatp/89Ykv36vsBrz0qfZAZeehCe7OypSyK0Hq7kLytukhTaVhM3xXI9dq9RV0VZiGQaKqHBjGB1vwHN1227nwFLtarHfjFirGRty0ay0YmzK/TV+dF0Gfj30r6DBOxAbO7cfNbUFSot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KJ+uh4Tl; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KJ+uh4Tl"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2d560775ca2so10827605ad.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169770; x=1789774570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvxeiUifxpfQFpLPlhrwkJPg9MEHvf8vpcauDPPob84=;
        b=eFuQ7n0OnmKIRn0QXT5usChwfyOWbkzfkFkPKoNapHkdm8Kov6RtKn5XeKKCTpCCdm
         2cYaBIKapRnMDp2Sd1LCs+Yismybsk3UfhXjzWs6+fYgMWHvGvzmRtpcZayJ1EaNOke7
         +yLss1rs6Tm1VvTRHxvYMlH877CYBEorYDE1WIzrY4hUsUPsvCKiz4YvIjyhCwnVVB/Q
         ym6zJuZNb7QkonU/y0Rj0kEa9JSib3g9wlG6fraG5qkW9baXmMUWePvwuw3BIYAhSO7a
         VTV2pSDLQmNRL1uzC7sr0wnD4Zcq7uKk+hpyWFUMuddFcU8qowyxtDRtCjXPkSKoUjNB
         H9yw==
X-Gm-Message-State: AFuF++lNG5jLM0pwvVAts5HAtXqvUslCv/sCabwJlB/8AUVDbdGi9PV1
	7HgZ0xz9+eQKKTPFVIKZR+psHWb9QKFjAgkC5FqXnbFBvIcUrNhEyZUn0vBO5r0trqv1aC7oLbb
	IuCgW/JWDANTaDfP/8BaYVJADyYyr9CnqQQ+LMuYMq/n0aOi8idc0rBS13HHyICSoEtf/STL6R4
	vJLEI0bEq4YjHVNB8577hxWklOwYB7OLj7j7yhqlQLgOnM8bJPAJX3Z8qRFJ8w3d5fyl5TpEJ+V
	9AJimnD38g+WFY2
X-Gm-Gg: AYBFou3BL6vOI8nGXxyv+7iBVHGFuQzLIbDOitfFqun+UWYL4zB237hf9gFormuthdl
	LDAcnUN9Q5qumNlWZ8ayvYNDlPwlatXcFyx1CsJKtevsNylJvHiKkoISX1A+asU9QZ4XNJX9MEg
	0gjXoWydfEYSc4TsoV/iN+/jy88hJnpsU8VHyK1meUjbhMrKOgtbOa81s3Wg6noGqDMGNJa7GM2
	XmwiWqvhAEo74q8x2SMekfvsJgKdKRtMpO0jGCczRELbyDA77ortXxUUfGr37aVgmaxWiWmI6FO
	Gk3AChNaU9I5svwiqzkCEW18/wcNnB6w8orXJHNGsDNS8TD1insW7RR9tcctBJ3UTl5AWznT3oh
	NaI8ZfZ65bymx4MSvJleb0t9Y9sBDsbP2rKhCy9vSndsVuU9z+m4L9pkebfPP4LKe/kBtjC7/pR
	q0c6LOS5dw3bpqjg9A1iDng0KuGqZ2a244iIwcyp0=
X-Received: by 2002:a17:903:283:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2dd4bc32e5bmr6870855ad.2.1789169769936;
        Fri, 11 Sep 2026 16:36:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2dd2cfcb276sm1864665ad.10.2026.09.11.16.36.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:36:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90ce21f2cc9so34371376d6.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169767; x=1789774567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvxeiUifxpfQFpLPlhrwkJPg9MEHvf8vpcauDPPob84=;
        b=KJ+uh4TleJqcxBCsI5bN1iATObbkBcLwaNNHwgKiiF8cca5x1+Q8+EVlrZqRaJ08kp
         XFYNpTZL3MGp4ejjcbXV1HcdIttvGEGKBZL5W7dVZRky74TX3oLR3/nmYzB05iVDVsLk
         opkOKXAjUd7Yfdkanckwqbs0fIAtjTMsiGqfI=
X-Received: by 2002:a05:6214:3d08:b0:910:3453:505e with SMTP id 6a1803df08f44-9121dae180fmr10666506d6.32.1789169767495;
        Fri, 11 Sep 2026 16:36:07 -0700 (PDT)
X-Received: by 2002:a05:6214:3d08:b0:910:3453:505e with SMTP id 6a1803df08f44-9121dae180fmr10665916d6.32.1789169767016;
        Fri, 11 Sep 2026 16:36:07 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:36:06 -0700 (PDT)
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
Subject: [PATCH 11/13] PCI: brcmstb: Put max_burst_size setting in cfg_data
Date: Fri, 11 Sep 2026 19:35:36 -0400
Message-Id: <20260911233541.1650895-12-james.quinlan@broadcom.com>
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

Rather than ascertaining the max_burst_size setting by comparing different
SoC IDs, specify the setting in the config_data structure for each SoC.
Also add a comment on each SoC's encoding of this field.

Note: Previously, the max burst setting used for the 4908 Soc was 2.
However, it appears that the setting of 2 is illegal for this chip.  Set it
to 0 as (a) this is the safest (smallest) choice and (b) the 2 was probably
interpreted by the HW as a 0 anyway.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 29 ++++++++++++---------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 047783e33ae4..8bca98e6f5fa 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -317,6 +317,7 @@ struct pcie_cfg_data {
 	u32 flags;
 	u32 quirks;
 	u8 num_inbound_wins;
+	u8 burst_setting;
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	int (*post_setup)(struct brcm_pcie *pcie);
@@ -1153,7 +1154,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, num_lanes, num_lanes_cap;
+	u32 tmp, num_lanes, num_lanes_cap;
 	u8 num_out_wins = 0;
 	int num_inbound_wins = 0;
 	int memc, ret;
@@ -1188,20 +1189,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	/* Wait for SerDes to be stable */
 	usleep_range(100, 200);
 
-	/*
-	 * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
-	 * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
-	 * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
-	 */
-	if (BFLAG(pcie, IS_BMIPS))
-		burst = 0x1; /* 256 bytes */
-	else if (pcie->cfg->soc_base == BCM2711)
-		burst = 0x0; /* 128 bytes */
-	else if (pcie->cfg->soc_base == BCM7278)
-		burst = 0x3; /* 512 bytes */
-	else
-		burst = 0x2; /* 512 bytes */
-
 	/*
 	 * Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN,
 	 * RCB_MPS_MODE, RCB_64B_MODE
@@ -1209,7 +1196,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
-	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
+	u32p_replace_bits(&tmp, pcie->cfg->burst_setting,
+			  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
@@ -1961,6 +1949,7 @@ static const struct pcie_cfg_data generic_cfg = {
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
+	.burst_setting	= 0x2, /* 0=128B, 1=256B, 2=512B, 3=Rsvd */
 };
 
 static const struct pcie_cfg_data bcm2711_cfg = {
@@ -1970,6 +1959,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
 	.quirks		= CFG_QUIRK_EARLY_PERST_ASSERT,
+	.burst_setting	= 0x0, /* 0=128B, 1=256B, 2=512B, 3=Rsvd */
 };
 
 static const struct pcie_cfg_data bcm2712_cfg = {
@@ -1981,6 +1971,7 @@ static const struct pcie_cfg_data bcm2712_cfg = {
 	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN |
 		CFG_QUIRK_NO_RGR1_TIMER,
 	.num_inbound_wins = 10,
+	.burst_setting	= 0x2, /* 0=64B, 1=128B, 2=256B, 3=Rsvd */
 };
 
 static const struct pcie_cfg_data bcm4908_cfg = {
@@ -1990,6 +1981,7 @@ static const struct pcie_cfg_data bcm4908_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
 	.quirks		= CFG_QUIRK_PERST_PCIE_REV_CUTOFF,
+	.burst_setting	= 0x0, /* 0=64B, 1=128B, 2=Rsvd, 3=Rsvd */
 };
 
 static const struct pcie_cfg_data bcm7278_cfg = {
@@ -1998,6 +1990,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.num_inbound_wins = 3,
+	.burst_setting	= 0x3, /* 0=Resv, 1=128B, 2=256B, 3=512B */
 };
 
 static const struct pcie_cfg_data bcm7425_cfg = {
@@ -2009,6 +2002,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR
 		| CFG_QUIRK_OB_WIN_MAXSZ_128MB | CFG_QUIRK_32BIT_PCI_OPS,
 	.flags		= CFG_FLG_IS_BMIPS,
+	.burst_setting = 1, /* 0=128B, 1=256B, 2=Rsvd, 3=Rsvd */
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
@@ -2020,6 +2014,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR
 		| CFG_QUIRK_OB_WIN_MAXSZ_128MB,
 	.flags		= CFG_FLG_IS_BMIPS,
+	.burst_setting = 1, /* 0=128B, 1=256B, 2=Rsvd, 3=Rsvd */
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
@@ -2029,6 +2024,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.flags		= CFG_FLG_HAS_PHY | CFG_FLG_HAS_ERR_REPORT,
 	.num_inbound_wins = 3,
+	.burst_setting	= 0x3, /* 0=Resv, 1=128B, 2=256B, 3=512B */
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
@@ -2038,6 +2034,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 	.soc_base	= BCM7712,
 	.num_inbound_wins = 10,
 	.quirks		= CFG_QUIRK_NO_RGR1_TIMER,
+	.burst_setting	= 0x2, /* 0=64B, 1=128B, 2=256B, 3=Resv */
 };
 
 static const struct of_device_id brcm_pcie_match[] = {
-- 
2.34.1

