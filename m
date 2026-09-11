Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3158443C0E
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169769; cv=none; b=o82lqF0x8rXIHGNSOit2Kkop/knwILHhjsdRfDwwe05sUayN0BmJlohavHNdetdBnKQNFr3VkbDEoVrSSqNN2025/M/j0W4i6fdLpUy7rHGW7DiAr1fspozpm64hzBORykFxRi8vY6UCD1urbjU/JOXpcFT180ijyyjVeIZt84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169769; c=relaxed/simple;
	bh=Ob42Zosz9IH+YimKe9mUfcjrJUS96ejLsgBuTTyQBA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXGMtIYJKmJks9mzSLC4Z0mymEX7ggTM82DjNhmnbR4NWll4ENW1Jpw+uzU/xfoj4GN6R08f/cV4sUZhntQeI/KE72JeYrEMxcctiXm4wxXvuWDnUixCHDAmjAzAf6orVE2TjK4a7cA9mqg5559z18eR619tkzsZACvMEsKBWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U/SnE5mN; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U/SnE5mN"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so463199a91.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169767; x=1789774567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RexkG3EFmXpE/deY9AEDz2v/2Wt3PCylK3Bm+blW8Y0=;
        b=hNyouNRDkS1IJIOXbcyuPb1J5rfd3SakYiMOKXUvPZKJrlhgGUTwxWjklTuFWjE4ez
         heaAErI2Kk6p1SWEm+A8+B6na6h0E4W5aQDCIHS1QwL3tfh1R4of9q9sCg7Z8EyyWPEa
         9P1CyCOPWIbA6dXw7vzRz2aBzmIxpDJ5nUiUV4Lcc8bEI15k19a9obq8nTl9+MdFR+wO
         051OUm3VHSKMLx0cnT4zMIWcnE0pvLqzV1W4INxdeqgOujPFNiOAQbODiAnBmbyXKsD4
         r5m4nGpiaaSW0zR5eYigcxIiDpmakG4VVWmJMj5t2pVB6IDcJbDTA5AjLxTNe+OkIBv2
         72dw==
X-Gm-Message-State: AFuF++n8Hcesh8WDcQJGDE2/D4pc9B6Cg+EdbJ1YelrTgOMHqJyrG9G1
	nFGBzuYRJ3qIXIvaSfr4WOMfiB2WHi05zJZxChkgXWzkXDEMjxtRQv2M4wOyoKN3zYR27+ow9RK
	aImuv1zyDI5OxtbcWSeSiLVY8eciVnhtlWKotfMIGBO/zbm3xkO9Txog8NPlIfa91BoNWZN92UO
	VEJAH7Pyi3yLSe2mL3A7il7cGcv+ETfcRDvdnPAeEuPD+C2OVtu8c0EEHLc63H9LmxyeLfty1b4
	cYxhQnxHe5lDQYj
X-Gm-Gg: AYBFou1C70x4Z7mhGgsqlI+ekR/LPd8jyEZ5tl3948Ns65R0vxHD8WOcdyb788wPRuu
	GYxGzzejWBE/uOjp5J4GR6EF1uRZL4EuA75XlbJful5xM/6z9vWbPtWkOcDL6ME1krw7B3ev8dZ
	+/w+IncNSB+kA5fOCZyq6vG8/LVlEMLHHcPbCBYRmMb3H7fjK35xegTMFl2jXgWpQ4ewHEtUbm3
	H7LMWWTQGgPEf6GyhNY64xt9b1+4iZkGEqdxq/KzeNo3z0UocAJ6ZTYl99HTAJf9ayOaB0wnPcd
	NFUDz+eLDSUD1TPKVuhLvPr+X+AgYhdBVBtFl4hkli65XXOyLZwkdwL8cgB7NgDrVpfNtCSaexF
	haK2Cngydd/jRmwY534i6KFleeH7DUrx0U/Gk0Ku52OvrszKDxA9DYG2eNn0T
X-Received: by 2002:a17:90b:3906:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39d9c3727b3mr10227475a91.17.1789169767163;
        Fri, 11 Sep 2026 16:36:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-33ba4eb5b13sm88669eec.12.2026.09.11.16.36.06
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:36:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e7de22fddso27962146d6.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169766; x=1789774566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RexkG3EFmXpE/deY9AEDz2v/2Wt3PCylK3Bm+blW8Y0=;
        b=U/SnE5mNNmGlCq34dse5xRdz0sFqX2fISLiwfFU32QS5Xps5Pwo4w6xvzS+EeaOby5
         OcsJdYj8TUH7496qoL/KTStkqVUHlnhA3g2MsL/Yq6ZQLQ0M6btYQUWBlGyv8n39M0In
         fcyr219nITU+NydLVL9lXPbUb4oIyO3yZq/8I=
X-Received: by 2002:a05:6214:3218:b0:910:63c3:5c70 with SMTP id 6a1803df08f44-912120f1bdcmr91745376d6.19.1789169765714;
        Fri, 11 Sep 2026 16:36:05 -0700 (PDT)
X-Received: by 2002:a05:6214:3218:b0:910:63c3:5c70 with SMTP id 6a1803df08f44-912120f1bdcmr91744836d6.19.1789169765178;
        Fri, 11 Sep 2026 16:36:05 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:36:04 -0700 (PDT)
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
Subject: [PATCH 10/13] PCI: brcmstb: Declare and assign quirk PERST_PCIE_REV_CUTOFF
Date: Fri, 11 Sep 2026 19:35:35 -0400
Message-Id: <20260911233541.1650895-11-james.quinlan@broadcom.com>
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

The SW behavior for asserting PERST# for some SoCs only works up to a
specific PCIe HW version.  Declare this as a quirk and assign it
accordingly.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index dfd703571091..047783e33ae4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -298,6 +298,8 @@ struct inbound_win {
 #define CFG_QUIRK_NO_RGR1_TIMER			BIT(4)
 /* PCIe PERST# must be asserted before internal bridge turned on */
 #define CFG_QUIRK_EARLY_PERST_ASSERT		BIT(5)
+/* PCIe SW PERST behavior only works up to a specific HW version */
+#define CFG_QUIRK_PERST_PCIE_REV_CUTOFF		BIT(6)
 
 /* FLAGS */
 #define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)
@@ -1987,6 +1989,7 @@ static const struct pcie_cfg_data bcm4908_cfg = {
 	.perst_set	= brcm_pcie_perst_set_4908,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
+	.quirks		= CFG_QUIRK_PERST_PCIE_REV_CUTOFF,
 };
 
 static const struct pcie_cfg_data bcm7278_cfg = {
@@ -2168,7 +2171,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->cfg->soc_base == BCM4908 &&
+	if (BQUIRK(pcie, PERST_PCIE_REV_CUTOFF) &&
 	    pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
-- 
2.34.1

