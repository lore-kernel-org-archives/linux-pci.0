Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242A310645
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169763; cv=none; b=Djeb5GTkWt1gPsHXCemqh2+zqVEmyJ8ZwgI6GwJZ/0j9zVv0hLMiUMZ5Q420GlFpeu+QQDVhCXWv1LuBJ5jq9aSU0G1pJKygmm5hNrJU1yNy/0VWyVj7jQqVr+F4ZO7EzksV28HSCpUawJn+7oHld66j0WUK3KEzPprCtqiWeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169763; c=relaxed/simple;
	bh=NwQuhCJMs+MGn9FpjpyCblI4ToMl/sX+03cL9s9/s/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXQck/o+Urd+vHLx2IBptSWjpYYdaWZX5E+56cFbaYU/9D/S35aneDqsp3THITqWXEjA5UOpRlXnp0iya2CpB1y4asqchOnkAwUkzomFGzI4wm7Co5mF2gIM6BRp+/tHs76Nay2Ph9JEWKnjiZBgczPy1cNk9lAoIsPoE/Kjoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VhkWK0a2; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VhkWK0a2"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2db80fcdf8bso5007445ad.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169761; x=1789774561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxRFCrZ4tEYGl9pgNTMvFraV93EKM855ZrrXiCcwOi4=;
        b=O+ix4xN85Owhj6nRPk++oa7IylTZNLw1E5AfLKnQr5/HkF8FU00Bo8aaQp6T9BzdsN
         DcDK0iWPQNOB7iSLIB8OssiVO3pLs7HUl0SVBbQ0ZaGaxnx+CtBUC18cIz34xUBU9w30
         rjQqyjyNXKcEj70x6fXV2r94PlBYyZJE90cYX529y6iCGiOPmj69B5gyAzCjH+A8Qo/I
         zF+ZkdHXo8O2yqU2Q9j9e9K9/rgM5oqaM/H1DlK6UZ9KEeFgDWpINhfhTsv8Dfev6LAn
         XDYFjs0183nM7r0PS88TglRlI3+OXbvHqNjtU/vmXSL4XIEPoXVl9sA6WGBHmUDxwZva
         BgyQ==
X-Gm-Message-State: AFuF++k6ry9tcvIGpXdqDuyMpW5F7r5G/qNxuwR0cGjOtSn3w4jPUKL3
	ZAYR6pGyMGcXzqrbxGlJifx+1wEkJTKC31xU/ZjpX5CeYE/57g/FSkuBu1/HLzUQeO/xUaeHngx
	d+lqPYufNpKCdBPefIB63lhceiM25zuD5120aQmGxflOIv2hMUuFAemhol4eqjCc/TgJURnkWvK
	OKgip+NcOrErVuhVSerkcSWBjrJQxpRE5QTnCVkvy6jctPfFdtoBTdOpWCrluk9QSsElO0SgDn4
	3JPfuoQ1t+Ac8oO
X-Gm-Gg: AYBFou0Ep/Wkslx++P0+c0HSONmbIDIry92HYkcrHMx6PrRQXlL+CcHeItn7qM/5lIk
	lzBUD2l3eqkNIJt6Qg/59MfeSAjKTlwVNrFdaam8i+Y4VBdahIWPmzjXSB6NSxvePwzvP/frixY
	ySJpqxrxmNlQimd6ycTXUU20geVA2fJb2daBfhIgQgiLdrqKxekqKwS3gctccevAIUjZlnafkQs
	f2kAUY6fOZ8SactdEdYWVF13bpj29tx4sHKFiH3zrEC27bU/5dFP9C/t9UOswEIr0PI+Xp39oqe
	YahZq7F0en/JOD/oDqs/DgKrDu+jGzWvoWjaTYVb8sWP+cWiRbIx7P91RxlK0mdkkvAhGYwnYwc
	4M6QJrYPSSs+SfDcLF+r2ddTPQRa3IUIcOwbWNZRnecRETVK7Z45chlM0S9RJd+IV78wJzM4IgB
	JWMUu8U4DR3r+yfFfQYOs/sBqIIxGGBKv6yBrymY4=
X-Received: by 2002:a17:903:298f:b0:2d9:43f5:b462 with SMTP id d9443c01a7336-2dd2a1ce8d4mr129137865ad.5.1789169761026;
        Fri, 11 Sep 2026 16:36:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2dd2cfcd747sm1880295ad.15.2026.09.11.16.36.00
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:36:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9104c2ce026so39935346d6.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169759; x=1789774559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxRFCrZ4tEYGl9pgNTMvFraV93EKM855ZrrXiCcwOi4=;
        b=VhkWK0a2D7E3JOUR+xUK0QWyobk3J6n08lpm+CKzCTAmu6AVcDPtvgyEIEzFvigDVI
         xfQqorHDI8zZdOGHtnR6XHiCCqeHAxovU0BCfCKtDf4tPszFB4/G+P/A842cKyVkv+Ro
         IgBPF5lUWl5XB+wwnrgxkTzXpJHmg0HEYgr2w=
X-Received: by 2002:a05:6214:3012:b0:910:a402:eaf with SMTP id 6a1803df08f44-9121211d5c3mr93244386d6.35.1789169759532;
        Fri, 11 Sep 2026 16:35:59 -0700 (PDT)
X-Received: by 2002:a05:6214:3012:b0:910:a402:eaf with SMTP id 6a1803df08f44-9121211d5c3mr93243826d6.35.1789169758991;
        Fri, 11 Sep 2026 16:35:58 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:58 -0700 (PDT)
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
Subject: [PATCH 07/13] PCI: brcmstb: Declare and assign quirk 32BIT_PCI_OPS
Date: Fri, 11 Sep 2026 19:35:32 -0400
Message-Id: <20260911233541.1650895-8-james.quinlan@broadcom.com>
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

Declare a new quirk that indicates SoCs where the config-space accesses are
restricted to 32bit R/W.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8927d1d97f4a..be414d346855 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -292,6 +292,8 @@ struct inbound_win {
 #define CFG_QUIRK_OB_WIN_32BIT_ADDR		BIT(1)
 /* Each of the outbound windows size must be <= SZ_128M */
 #define CFG_QUIRK_OB_WIN_MAXSZ_128MB		BIT(2)
+/* PCIe HW can only access config space with 32bit R/W */
+#define CFG_QUIRK_32BIT_PCI_OPS			BIT(3)
 
 /* FLAGS */
 #define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)
@@ -1996,7 +1998,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
 	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR
-		| CFG_QUIRK_OB_WIN_MAXSZ_128MB,
+		| CFG_QUIRK_OB_WIN_MAXSZ_128MB | CFG_QUIRK_32BIT_PCI_OPS,
 	.flags		= CFG_FLG_IS_BMIPS,
 };
 
@@ -2050,7 +2052,7 @@ static struct pci_ops brcm_pcie_ops = {
 	.remove_bus = brcm_pcie_remove_bus,
 };
 
-static struct pci_ops brcm7425_pcie_ops = {
+static struct pci_ops brcm_pcie_ops32 = {
 	.map_bus = brcm7425_pcie_map_bus,
 	.read = pci_generic_config_read32,
 	.write = pci_generic_config_write32,
@@ -2180,8 +2182,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = pcie->cfg->soc_base == BCM7425 ?
-				&brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = BQUIRK(pcie, 32BIT_PCI_OPS)
+		? &brcm_pcie_ops32 : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.34.1

