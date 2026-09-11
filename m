Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0C310645
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169753; cv=none; b=KUcSRRxx+/H/G9M20hGMdNBQ22a4z+VxV+5ehC9mpFx37fzVOSQIjL2ETjcJyN9F3orfNPafRJ9TnN8D3rWulWvzQM0a/8dvqRUqm4CrcA/heZiv0ZZqJ5Y/ugvFZELeUiRNNIR/4Esmn8Qh2V5xkGUdd+lzgtXgLDgS83isDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169753; c=relaxed/simple;
	bh=//3ALQS3wymbFPv6KJPwmFP6Ogw6mcd5PsWWglFfL6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGCAoC8jGsg1MHAVA9+TIe0a5ybaJHJbc4mmenGU7/DAFTdc00L2dw5uX+sqMcyWt1azOpdlzwUD8QJ3EGKNek8z+YfGMEujcWBcxxxcCGEC0InVeyE4DNSKdutOnNtjbPs0o/N3UeuI3SmhGd1ZR6i0YDW3VIwsvuChUTX/qKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WPMO/+ms; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WPMO/+ms"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2db710396ffso23218135ad.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169752; x=1789774552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY9ozb5KV1VBJo3Z3p+RlJyXkFICluMij+wCeI97mXA=;
        b=ZjACmJLPltkMNfebia4oOPXWxfUQjtVyxtdjkOQHu97x3hT2pJ/lVl2bJekI0zF2TU
         KSMyjZiawiRHO0cknkRrXD0Qp20a5LSc6/AlgXQJu5dxbBnsO2dUxoY+pMmx3fM+PnFT
         uK1cr07cv0h41Deol5PleMjossszSCfkMGX4IUAK0vDuTL/L+eMTRDHCWiagck3G7Bn+
         nnwpVH7UVWcEZjEljxdXliEChE6+/q5ojb9RaYSfsWtVesKO5XNH43LVoLnC7nkUz5nn
         x2/y/ohRBsY4omTf7SP+2NUDiJ3xTlHUztMe7LpDJ/lXnkZNBlWmMi60TqbTUwj5DDHr
         n6gg==
X-Gm-Message-State: AFuF++lkoW8HrQeT8XL0vD+1GNIZSZuBfWdIZ0UfqbY/GHxFSc1AfgpO
	EYLjgxQYQxLHN02nTiJEMMEG4dQrWIDrvEB9mrIgO7Hk+EI/38awfFQRpeI0kSKXA7eWDnMxfb+
	CmgkLJ1tTuY94XpA2uR+u6YFf2HsEoyQ4fjNwaBokZkYkwAixQzNYpqeGCdjQ4BFqZEyUF2QVLh
	qvWi5bqOQ1DrMnDMKZ33gSDnVNx7mKBvDjEKMQp9W8SsFce5XNf6n1XWX5YNonpwWbwDTELyPC7
	hmWPoS9u57q04Vu
X-Gm-Gg: AYBFou1mn9IHEbveliOZadh9sFV9otrhlPx3DXMSASKhcY0JW2bNpRUzMMJXLIUJfgt
	o0SJif3h1to4sOGfuswyt+dDsqrfUfvEnlQEefukCejtPZduoI6JqN+C5c9ISWMHlP/J7udYPjw
	P/JUZir5yEiWvkAgBi6p2CK3jjl2S2lmtK6i+kIP47vPyzlLnWWrPNosixpR2Xu3ETe/HPv092i
	yewkJvHk0E4muPf5L3Wpoz4qmSTTtEnDQ7Mk6of2+jchKPV9Eo8YrDZ13ewSHJOt61fSuRs0QEy
	/ZYxcL8WnWw92APK5GRLnK3iNTU4TFxhv4dB9InqBGoIDFnt0pjZ7MKGdeu0iAp9y0g12SxcIEr
	pXJMzFTe5vkE4+qGVZ1guj4fw+H9hfwzwApAEoA+rhAw5hBuxHYwcHsweK+ho3CncMyxWydrqed
	NFW8n0dvBTEWR02C6dINbGblWlqXKJV2F+hTWs
X-Received: by 2002:a17:90b:4d0d:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-39d97ea0248mr5615347a91.3.1789169751481;
        Fri, 11 Sep 2026 16:35:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d9606f4afsm2258676a91.7.2026.09.11.16.35.50
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:35:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9105be46009so31512646d6.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169750; x=1789774550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dY9ozb5KV1VBJo3Z3p+RlJyXkFICluMij+wCeI97mXA=;
        b=WPMO/+ms+I+7rbiJZOfRQ8IyMJPpdiGcJccvrfGEqXa5ERsKR9tNTr34MmSY50gm0d
         61PgVL/BitWRlY9Pu2HGtMTN7sI+4dbN+8A0J5jUyN7+PaIVJFm7HAAPYFx0m9/qNLUi
         /bJvbSOOf35K5lNV9thX0LVeaYFaClixglyXc=
X-Received: by 2002:ad4:5965:0:b0:910:42f3:958e with SMTP id 6a1803df08f44-912029a2a01mr144987466d6.27.1789169750050;
        Fri, 11 Sep 2026 16:35:50 -0700 (PDT)
X-Received: by 2002:ad4:5965:0:b0:910:42f3:958e with SMTP id 6a1803df08f44-912029a2a01mr144987016d6.27.1789169749543;
        Fri, 11 Sep 2026 16:35:49 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:49 -0700 (PDT)
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
Subject: [PATCH 02/13] PCI: brcmstb: Use flags u32 instead of bools
Date: Fri, 11 Sep 2026 19:35:27 -0400
Message-Id: <20260911233541.1650895-3-james.quinlan@broadcom.com>
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

Instead of having separate 'bool' fields for each SoC configuration, use a
small bitvector (u32).  Doing this uses less memory and provides a uniform
method to assign flags for a specific SoC.  The expectation is that more
flags will be added as we replace conditions like "if (chipA || chipB)"
with "if (behavior_X)".

A helper macro "BFLAG()" is used to shorten the determination of the flag
value.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 89aaa19d508a..47862569937e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -286,16 +286,24 @@ struct inbound_win {
  */
 #define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN		BIT(0)
 
+/* FLAGS */
+#define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)
+
+/* The PCIe HW registers have phy control of a "RESCAL" reset block */
+#define CFG_FLG_HAS_PHY				BIT(0)
+/* The SoC PCIe HW can dump to the console PCIe error info */
+#define CFG_FLG_HAS_ERR_REPORT			BIT(1)
+
+
 struct pcie_cfg_data {
 	const int *offsets;
 	enum pcie_soc_base soc_base;
-	bool has_phy;
+	u32 flags;
 	u32 quirks;
 	u8 num_inbound_wins;
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	int (*post_setup)(struct brcm_pcie *pcie);
-	bool has_err_report;
 };
 
 struct subdev_regulators {
@@ -356,14 +364,14 @@ static int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
 	unsigned long flags;
 	int ret;
 
-	if (pcie->cfg->has_err_report)
+	if (BFLAG(pcie, HAS_ERR_REPORT))
 		spin_lock_irqsave(&pcie->bridge_lock, flags);
 
 	ret = pcie->cfg->bridge_sw_init_set(pcie, val);
 	/* If we fail, assume the bridge is in reset (off) */
 	pcie->bridge_in_reset = ret ? true : val;
 
-	if (pcie->cfg->has_err_report)
+	if (BFLAG(pcie, HAS_ERR_REPORT))
 		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
 
 	return ret;
@@ -1589,12 +1597,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 static inline int brcm_phy_start(struct brcm_pcie *pcie)
 {
-	return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
+	return BFLAG(pcie, HAS_PHY) ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
 static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
+	return BFLAG(pcie, HAS_PHY) ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
 static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1898,7 +1906,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	pci_unlock_rescan_remove();
-	if (pcie->cfg->has_err_report)
+	if (BFLAG(pcie, HAS_ERR_REPORT))
 		brcm_unregister_die_notifiers(pcie);
 
 	__brcm_pcie_remove(pcie);
@@ -1999,9 +2007,8 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.soc_base	= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
-	.has_phy	= true,
+	.flags		= CFG_FLG_HAS_PHY | CFG_FLG_HAS_ERR_REPORT,
 	.num_inbound_wins = 3,
-	.has_err_report = true,
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
@@ -2179,7 +2186,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (pcie->cfg->has_err_report) {
+	if (BFLAG(pcie, HAS_ERR_REPORT)) {
 		spin_lock_init(&pcie->bridge_lock);
 		brcm_register_die_notifiers(pcie);
 	}
-- 
2.34.1

