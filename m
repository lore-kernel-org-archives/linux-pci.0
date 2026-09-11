Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272741441F
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169761; cv=none; b=A7ByAepY1bE6CT9wj6it2BSzIk0CWC9MSsksKeny9b3YcqkGyLpwjI6BArjIt1KfukGGgr0G8Vr+YBOaNzgdWF1Z6pbMaixWmaqDoKbweNgMCDn39kcTwgg+eaCqP8lGBZPGiwiO/5L8mNGikzIehwxR46EX9Sk4Xq6ScpMqX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169761; c=relaxed/simple;
	bh=fCquuyOPRRvbPPN7j4s4PTEgnAMO3NXPFcnuc+77eGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6SV7Q39NVCx60SuSFFnaDdc+sTi8pzTtHSjRYfcJ6SC5aLqsqA47dn6xTsPTIU2kyfIH92JFSFgXnG7+H8/u9By+C3/j36yICfG6X969ixM7dVgdmUvKWldHcaue+FPnpWzMZ3oWEuy6l0DmHSJJPRCyIhmss05H8IGSWahDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LY2FQLET; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LY2FQLET"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so1141664b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169759; x=1789774559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZPUdMQ+HBavjfYhKEMnyLWMnsWpuuaQ9A5Q74lcIlU=;
        b=Ph0EM+kbLoxeinCyRqr47dsWV5hhHrF0Ch0eYql1kVMvkDLTHlrqe0aplJ7EAet/RB
         ayaiRDi1Y5b2w5XeHYdQNE/wCxZTvhWWFO6ib9JxwZsEdkqlyq5AfywYt2M3Aen4aQpQ
         ReSAKgknYH5jqyFfEjInycW/QrylP8bG+LUeGgH2mqDPXxtXnsjH9Gz9ElFiYYLGQS2X
         t7t0E5uu/OcuVxJGoLGvonZadq+TUbLUX1Wcj/P+vWJKHAypa7evXFZteRw89WBbWT8D
         mwTEuPDQXU29jsBqb2cZVrqTLoA5aXHohNobIgyjnlFRojTf3gIgjDLnBFLk70ddMqIk
         4PdQ==
X-Gm-Message-State: AFuF++nM+w9Zb5PjlRJK4+AdxyEhrxi+qY3ro+4a/7dm+CgftA42DGqQ
	KPlAiRDiqqdHfVU8AjvRNWnCwJ9Yrz9PTT1Y8+jA5eKJziwRubO6qNbp/mGEjumm8+GxHjXLyN9
	CdoCLq88Nc6QgcxrvpFynlxeXO98porFk+GRRu235Y+bwnol5HkPTZAqfjHBzS7/r7uX7pQNA2L
	JCPCdPtgnqPEu0EIM1eZpfh2W/rVGBRW5DeGFXndz8qB/8pInae8Dt+0pjCxBIM+Cjz6RbYL05l
	vvNYMPuilREVACm
X-Gm-Gg: AYBFou2eG8fK7cNMJieH2fUHWLIPOKB701RkzuR4Fxrg5/KA6A5l9gq+TC+Sg/oC/Iq
	XQrlBsKy34yifWdhr8qnZsP6ppMzqtKqDn92ZJFhBHk7XpU+R/F+bZMxLAXkZO4OUG2WnE9uhUU
	T1UtaSEreM1W+xfA4TkK4vvM+TDg/g/sn4fZ/+E64RTctrpyTf1YxWrFgYS0IOq6YEW6pPjPYeC
	CX+LVRPVrArFxdWkFLs04PY+fFAlJHH/KF0/wZrlykyPoiz3UXw+tzVTEehbBGWtVCrVeR0KfIw
	WwtgrMe94Um+djkwbdsgkzhalUfyZZAz4QxbZfV006/HKvtkeMI34Lf0Hod4n1JZS0v7qGP4Gr7
	UUILiV5ovq/HS/g34FCgOVa2OJRcAcHNSqlwEv+o39bI9ERONuNMQ20j4nUbP3ykpda/4msa/WQ
	MUDtqXGb34B0Hcb0Jr4qENzvu8XmkbnOfXNQAI
X-Received: by 2002:a05:6a21:3293:b0:3d0:c5c0:d9b3 with SMTP id adf61e73a8af0-3daed3438b8mr11290979637.18.1789169759486;
        Fri, 11 Sep 2026 16:35:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc4c657494asm1331320a12.4.2026.09.11.16.35.58
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:35:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90cddf4f59eso24871996d6.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169758; x=1789774558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZPUdMQ+HBavjfYhKEMnyLWMnsWpuuaQ9A5Q74lcIlU=;
        b=LY2FQLETPE5YZVVWUKgWtnbmOtbslSyU4AhPXvYp3ezyweRnv57uaVixdbLNgOkTgS
         /bK7Z8mAtF7v8ermAjjhuAGg97JLcHPHJLONgHuJthnaG1IqqZrEqDdM54eNgqHI4F2F
         fAOn3qavX921OYEWfcBnriI3jmBAh3oQPQJQU=
X-Received: by 2002:a05:6214:d4f:b0:910:3453:66e with SMTP id 6a1803df08f44-9121210d369mr86980206d6.32.1789169758000;
        Fri, 11 Sep 2026 16:35:58 -0700 (PDT)
X-Received: by 2002:a05:6214:d4f:b0:910:3453:66e with SMTP id 6a1803df08f44-9121210d369mr86979786d6.32.1789169757456;
        Fri, 11 Sep 2026 16:35:57 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:57 -0700 (PDT)
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
Subject: [PATCH 06/13] PCI: brcmstb: Declare and assign flag IS_BMIPS
Date: Fri, 11 Sep 2026 19:35:31 -0400
Message-Id: <20260911233541.1650895-7-james.quinlan@broadcom.com>
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

Eliminate a function that evaluates SoC chip IDs and instead declare and
use a flag that indicates the SoC employs a CPU with a variant of the
MIPS-1 ISA.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 401898d04d52..8927d1d97f4a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -300,7 +300,8 @@ struct inbound_win {
 #define CFG_FLG_HAS_PHY				BIT(0)
 /* The SoC PCIe HW can dump to the console PCIe error info */
 #define CFG_FLG_HAS_ERR_REPORT			BIT(1)
-
+/* SoC uses a Broadcom variant of the MIPS-1 ISA */
+#define CFG_FLG_IS_BMIPS			BIT(2)
 
 struct pcie_cfg_data {
 	const int *offsets;
@@ -361,11 +362,6 @@ struct brcm_pcie {
 	spinlock_t		bridge_lock;
 };
 
-static inline bool is_bmips(const struct brcm_pcie *pcie)
-{
-	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
-}
-
 static int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
 {
 	unsigned long flags;
@@ -1176,7 +1172,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		return ret;
 
 	tmp = readl(base + HARD_DEBUG(pcie));
-	if (is_bmips(pcie))
+	if (BFLAG(pcie, IS_BMIPS))
 		tmp &= ~PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
 	else
 		tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
@@ -1189,7 +1185,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
 	 * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
 	 */
-	if (is_bmips(pcie))
+	if (BFLAG(pcie, IS_BMIPS))
 		burst = 0x1; /* 256 bytes */
 	else if (pcie->cfg->soc_base == BCM2711)
 		burst = 0x0; /* 128 bytes */
@@ -2001,6 +1997,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 	.num_inbound_wins = 3,
 	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR
 		| CFG_QUIRK_OB_WIN_MAXSZ_128MB,
+	.flags		= CFG_FLG_IS_BMIPS,
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
@@ -2011,6 +2008,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 	.num_inbound_wins = 3,
 	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR
 		| CFG_QUIRK_OB_WIN_MAXSZ_128MB,
+	.flags		= CFG_FLG_IS_BMIPS,
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
-- 
2.34.1

