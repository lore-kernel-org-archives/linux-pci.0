Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5D3D9DA2
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169775; cv=none; b=WeP/ofpISYMdCYE8fv3nRaX2hsNTnyXhQ9QYBEbwU2dypVBwFSXXAeM88uTixd7p7Q+wXXxAbzGc5gb8nKHsNtasBIeAflkoKiqfaSL2mBfMM7+pmTAWhb9ZrwqzTpYcAvqw+IxkHcXiuoQp6VRB6ngV34CoZEavE9Oz2VpGtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169775; c=relaxed/simple;
	bh=POFZSV6vnv/AClRlphLecSZpmWEsaRDm0Vg66aP4l5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKDUWkVEFjgq1JLjpz3sBqncj0RiICOg9F6vTrfySWI30v9P6PQdNpkrMCgV1LgVVhxEHMkce4Md5JEpo9xtcZvl39NHt2Wk81PepvBVVUbHrNbrOWvexn4zvwS5jS3n5I4rOGKiVPrQdF7RmQwOHTvpjRXfRj/IUFWbSFsOJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NRIiSIjU; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NRIiSIjU"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2d6efd73032so25476785ad.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169773; x=1789774573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3SnnjQ2kzL235/6CJf8lAWttCVovoEfu585meMFTts=;
        b=h4PTSBJDGSNQjFTK3VhNokb79ahBHVRmtdcQcx5c9JBimF8pIWQCgnF/bgyue2olnk
         P29oJ4qzspxW2gLwofJi/ykh/SIclBqvwqa5qf4DBEyBV2/tSCHbRRqFNcWB5oKjrtQo
         uF0GMSxx4orVeCn+UHZOg+MaoOVVTnG9wd209EfV0XrpTuucmbd+HaugLH2WQngYm8dn
         BAtUp8VzGcmaeiSy2Zu4zNQ/6tkS2VfqDyxBaC8abZTukJPrrELLzG3fbShLMtjqetmh
         1W0XlfED5ntf9nngswm+wD9xj//NRYh25i0i6t33eZIWCtb7/lFa3GQyYqrAC1pqpCZD
         NSIA==
X-Gm-Message-State: AFuF++n9T8HcGLeUtW/fQZmVUsVdtgnrhW5QUbjNvfAmUfdxYWWH1ofB
	0sqYTBXBjKUkjUl+o5bNLnul8NrZm7JQVTOYkkJy4n9jzs80rRlCAXyVHTeWY/4zllzPZj/SIIJ
	+ts39kxVtC2LezHJ9WGrXL4r4rlnaDqEBzqeuc2hG1GxA6lAjOIDLtY9jKlF7V5BsOUSt7LDPJy
	CU4lbnjx4FBk5v+MCtibpVuDaRq+DAByT5iID/c/ujwAe1203ylOUDjbdrjusX91YNe2nitonbU
	jvG1F3E5MCIVJy4
X-Gm-Gg: AYBFou0sxoejNo+ONR4km7Nmz++GIQo/7a3ybUtkKumELr4dZajQiBkMrvgDnCapK4B
	diql9Q6yNJpe9qR/BoygTS+xxfQbrHZ8ngQ2qLGfxA8kDcm/yIR956RL5MT8kbyfUE/K7Gi0YV1
	DiYASkSdkz8bRdNkiQ9BpSdXvkIT18pzuXEBR1tpc5rQSi563N0Xo2KJWQu+9DN8pMxMIYydoxk
	N37594MCF4dUEhOiHeXyMNHd7rBv9iAoggQI07SZUSglEKn9qk5gJ9mxr8DGYgP2k28xqWbME3+
	q846jpz1YaSrj/LQTwhiXGaAGKPHebr7oc4eOr6SKGR2KCtF0lX2P19YSloEJPv8HVI4tR7r84p
	f8LGctQFYxrgauHrMDZmuWVNUF8dI76gTE4PIYzehxpFTNzCHm6Nes8WmtCV1xys0iDQoujHLp3
	wuVhcB6DBcr+/dIQd1gcCPMfhogoB4N+52EhQA
X-Received: by 2002:a17:90b:4f:b0:398:ba46:1d9f with SMTP id 98e67ed59e1d1-39d980ad389mr5903696a91.13.1789169772724;
        Fri, 11 Sep 2026 16:36:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d98e273dcsm2125926a91.3.2026.09.11.16.36.12
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:36:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ff59f2c47so35574511cf.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169771; x=1789774571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3SnnjQ2kzL235/6CJf8lAWttCVovoEfu585meMFTts=;
        b=NRIiSIjUCwVlezVHHaxLRJl3QzfkpUeyl9opvJ9Xq4dZxFR2hWODqQseWtNh03cWFh
         Arjj4FgYFCNVZmsdXjox+2W43xvimKAS6ONXS2RsN8V7wZjcxO7LQT6wTyguogA6aAQ1
         IKpxnp550F7LkMIWCOJLRxaEXQRmHTqJnQ0aE=
X-Received: by 2002:ac8:598a:0:b0:530:4773:1140 with SMTP id d75a77b69052e-530b3639755mr143682551cf.30.1789169770921;
        Fri, 11 Sep 2026 16:36:10 -0700 (PDT)
X-Received: by 2002:ac8:598a:0:b0:530:4773:1140 with SMTP id d75a77b69052e-530b3639755mr143682141cf.30.1789169770357;
        Fri, 11 Sep 2026 16:36:10 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:36:09 -0700 (PDT)
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
Subject: [PATCH 13/13] PCI: brcmstb: Split up complicated function into two variants
Date: Fri, 11 Sep 2026 19:35:38 -0400
Message-Id: <20260911233541.1650895-14-james.quinlan@broadcom.com>
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

The function brcm_pcie_get_inbound_wins() is abstruse.  Most of
its code is used exclusively by older chips, where the PCIe HW employed a
baroque internal inbound window mapping scheme which was an artifact for
when the PCIe would be configured as an endpoint.

Create two variants of this function, one for the newer chips and one for
the older chips, and assign them using the config_data structures.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 105 +++++++++++++++++---------
 1 file changed, 68 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 53984cfa2c96..45e8a9e030d4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -321,6 +321,9 @@ struct pcie_cfg_data {
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	int (*post_setup)(struct brcm_pcie *pcie);
+	int (*get_ib_wins)(struct brcm_pcie *pcie, struct inbound_win
+			   *inbound_wins);
+
 };
 
 struct subdev_regulators {
@@ -954,8 +957,58 @@ static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
 	(*count)++;
 }
 
+/*
+ * This is used by newer SoCs. It configures the inbound mapping windows
+ * in accordance to the values of the dma-ranges properties.
+ */
 static int brcm_pcie_get_ib_wins(struct brcm_pcie *pcie,
 				 struct inbound_win *ib_win)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct resource_entry *entry;
+	u64 size;
+	u8 n = 0;
+
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		u64 pcie_start = entry->res->start - entry->offset;
+		u64 cpu_start = entry->res->start;
+
+		size = resource_size(entry->res);
+		add_inbound_win(ib_win++, &n, size, cpu_start, pcie_start);
+		if (n > pcie->cfg->num_inbound_wins)
+			break;
+	}
+
+	if (!n) {
+		dev_err(pcie->dev, "DT node has no dma-ranges\n");
+		return -EINVAL;
+	}
+
+	return n;
+}
+
+/*
+ * Originally, the Broadcom STB PCIe HW played the endpoint (EP) role.  As
+ * an EP, one of its goals was to present system memory as a single
+ * contigous PCIe BAR.  So if there was two regions of system memory, say
+ * 1GB@0GB and 2GB@2GB, these two regions would be presented as a
+ * contiguous BAR that was 3GB in size and started at a PCIe offset that
+ * was configured by SW.
+ *
+ * Then the same PCIe HW was modified to also play the Root Complex (RC)
+ * role and the same internal mapping strategy was employed.  For any SoC
+ * that uses this scheme, each "BAR" is an inbound window and the PCIe HW
+ * is internally mapped and hard-wired to system memory regions.  Even
+ * though the code of the function below uses the dma-ranges properties, it
+ * is unable to configure the CPU region that is covered, but it can set
+ * the size and offset of the PCIe side of the window.
+ *
+ * Newer SoCs use the brcm_pcie_get_ib_wins() function have the freedom to
+ * configure mapping windows from any CPU region to any PCIe region,
+ * provided they follow the rules on offset alignment and size.
+ */
+static int brcm_pcie_get_ib_wins_internal_map(struct brcm_pcie *pcie,
+					      struct inbound_win *ib_win)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 pci_offset, cpu_addr, size = 0, tot_size = 0;
@@ -965,33 +1018,15 @@ static int brcm_pcie_get_ib_wins(struct brcm_pcie *pcie,
 	int ret, i = 0;
 	u8 n = 0;
 
-	/*
-	 * STB chips beside 7712 disable the first inbound window default.
-	 * Rather being mapped to system memory it is mapped to the
-	 * internal registers of the SoC.  This feature is deprecated, has
-	 * security considerations, and is not implemented in our modern
-	 * SoCs.
-	 */
-	if (pcie->cfg->soc_base != BCM7712)
-		add_inbound_win(ib_win++, &n, 0, 0, 0);
+	/* By default, disable the first inbound window */
+	add_inbound_win(ib_win++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
 		u64 pcie_start = entry->res->start - entry->offset;
-		u64 cpu_start = entry->res->start;
 
-		size = resource_size(entry->res);
-		tot_size += size;
+		tot_size += resource_size(entry->res);
 		if (pcie_start < lowest_pcie_addr)
 			lowest_pcie_addr = pcie_start;
-		/*
-		 * 7712 and newer chips may have many BARs, with each
-		 * offering a non-overlapping viewport to system memory.
-		 * That being said, each BARs size must still be a power of
-		 * two.
-		 */
-		if (pcie->cfg->soc_base == BCM7712)
-			add_inbound_win(ib_win++, &n, size, cpu_start, pcie_start);
-
 		if (n > pcie->cfg->num_inbound_wins)
 			break;
 	}
@@ -1001,14 +1036,6 @@ static int brcm_pcie_get_ib_wins(struct brcm_pcie *pcie,
 		return -EINVAL;
 	}
 
-	/*
-	 * 7712 and newer chips do not have an internal memory mapping system
-	 * that enables multiple memory controllers.  As such, it can return
-	 * now w/o doing special configuration.
-	 */
-	if (pcie->cfg->soc_base == BCM7712)
-		return n;
-
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
 						  PCIE_BRCM_MAX_MEMC);
 	if (ret <= 0) {
@@ -1123,13 +1150,8 @@ static void brcm_pcie_set_ib_win_registers(struct brcm_pcie *pcie,
 		/* Write high */
 		writel_relaxed(upper_32_bits(pci_offset), base + reg_offset + 4);
 
-		/*
-		 * Most STB chips:
-		 *     Do nothing.
-		 * 7712:
-		 *     All of their BARs need to be set.
-		 */
-		if (pcie->cfg->soc_base == BCM7712) {
+		/* SoCs w/o fixed internal mapping can remap the cpu_addr */
+		if (pcie->cfg->get_ib_wins == brcm_pcie_get_ib_wins) {
 			/* BUS remap register settings */
 			reg_offset = brcm_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1195,7 +1217,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
-	num_inbound_wins = brcm_pcie_get_ib_wins(pcie, inbound_wins);
+	num_inbound_wins = pcie->cfg->get_ib_wins(pcie, inbound_wins);
 	if (num_inbound_wins < 0)
 		return num_inbound_wins;
 
@@ -1943,6 +1965,7 @@ static const struct pcie_cfg_data generic_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
 	.burst_setting	= 0x2, /* 0=128B, 1=256B, 2=512B, 3=Rsvd */
+	.get_ib_wins	= brcm_pcie_get_ib_wins_internal_map,
 };
 
 static const struct pcie_cfg_data bcm2711_cfg = {
@@ -1953,6 +1976,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.num_inbound_wins = 3,
 	.quirks		= CFG_QUIRK_EARLY_PERST_ASSERT,
 	.burst_setting	= 0x0, /* 0=128B, 1=256B, 2=512B, 3=Rsvd */
+	.get_ib_wins	= brcm_pcie_get_ib_wins_internal_map,
 };
 
 static const struct pcie_cfg_data bcm2712_cfg = {
@@ -1965,6 +1989,7 @@ static const struct pcie_cfg_data bcm2712_cfg = {
 		CFG_QUIRK_NO_RGR1_TIMER,
 	.num_inbound_wins = 10,
 	.burst_setting	= 0x2, /* 0=64B, 1=128B, 2=256B, 3=Rsvd */
+	.get_ib_wins	= brcm_pcie_get_ib_wins,
 };
 
 static const struct pcie_cfg_data bcm4908_cfg = {
@@ -1975,6 +2000,7 @@ static const struct pcie_cfg_data bcm4908_cfg = {
 	.num_inbound_wins = 3,
 	.quirks		= CFG_QUIRK_PERST_PCIE_REV_CUTOFF,
 	.burst_setting	= 0x0, /* 0=64B, 1=128B, 2=Rsvd, 3=Rsvd */
+	.get_ib_wins	= brcm_pcie_get_ib_wins_internal_map,
 };
 
 static const struct pcie_cfg_data bcm7278_cfg = {
@@ -1984,6 +2010,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.num_inbound_wins = 3,
 	.burst_setting	= 0x3, /* 0=Resv, 1=128B, 2=256B, 3=512B */
+	.get_ib_wins	= brcm_pcie_get_ib_wins_internal_map,
 };
 
 static const struct pcie_cfg_data bcm7425_cfg = {
@@ -1996,6 +2023,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 		| CFG_QUIRK_OB_WIN_MAXSZ_128MB | CFG_QUIRK_32BIT_PCI_OPS,
 	.flags		= CFG_FLG_IS_BMIPS,
 	.burst_setting = 1, /* 0=128B, 1=256B, 2=Rsvd, 3=Rsvd */
+	.get_ib_wins	= brcm_pcie_get_ib_wins_internal_map,
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
@@ -2008,6 +2036,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 		| CFG_QUIRK_OB_WIN_MAXSZ_128MB,
 	.flags		= CFG_FLG_IS_BMIPS,
 	.burst_setting = 1, /* 0=128B, 1=256B, 2=Rsvd, 3=Rsvd */
+	.get_ib_wins	= brcm_pcie_get_ib_wins_internal_map,
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
@@ -2018,6 +2047,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.flags		= CFG_FLG_HAS_PHY | CFG_FLG_HAS_ERR_REPORT,
 	.num_inbound_wins = 3,
 	.burst_setting	= 0x3, /* 0=Resv, 1=128B, 2=256B, 3=512B */
+	.get_ib_wins	= brcm_pcie_get_ib_wins_internal_map,
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
@@ -2028,6 +2058,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 	.num_inbound_wins = 10,
 	.quirks		= CFG_QUIRK_NO_RGR1_TIMER,
 	.burst_setting	= 0x2, /* 0=64B, 1=128B, 2=256B, 3=Resv */
+	.get_ib_wins	= brcm_pcie_get_ib_wins,
 };
 
 static const struct of_device_id brcm_pcie_match[] = {
-- 
2.34.1

