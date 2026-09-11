Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F93457E49
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169772; cv=none; b=ZL3HqotB7CQuTG50WNuE5fARb9AZ4P9r1drhMw5h+no7AbK/zIU09J0/vh2kj4MscN08CsWxmNHQvG7NH4H71pF3yFQTj+WelXTb4H+hOBaTw5CtNQR01gBdhJUWHWIm+i71ERtGUmjpdquZbg20rJyyUxqiWB6bCj+ScVHYdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169772; c=relaxed/simple;
	bh=/C4vMYtbzaj6mPGipL5NL0m0Xfkke1JQhHrl2SUMM+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqWghrRm0/1pd3UtizfRGkcNA9zpyGd5EwD5rOAutLVSz46IcPjJDTEqAeRDQ2JGDrSmLTpN3r1eGuwFDnmzsYbtCE8p8lBQAYbABvL7NVO9yNL4IOMqBoTFjVidf6HbMUDTLxXC9mAkE153oHO1WAPHK5EnMoStzYaLnEZNENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bfPgcSf/; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bfPgcSf/"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2d9201076b3so6720145ad.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169771; x=1789774571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsR21IG9GkhkXFxkByd8Q5sMNxfEXtOVC73TP3sSjXM=;
        b=REWYtc8CHKYgJRB25wwVe6dBBMGcpy0tH8odrqJ+vRd53jnPxi9gEmX4PkFo7JGPDP
         /6SBPCe7DKqsGh4GuayboG1yNfTC9VbeRka9AsbgxkQh+tnHT5DmhuVQDG1y0I08LfPE
         sNiCgwvF6FqoUpkWKMIz4A6wxHPcbB+l1tZdl8/Ey5rRrq40bkB5SiS7veRf0I5Rax3K
         cdMLuQSyUoRel/MUdGW3HpAH5/P2QIWIPTilZ3hAjxkPXjqyFfPzWDmhCN4ElFb+iRJ3
         unhSF9klFjf69v+zcto+CQ1E+CqwkwI+zjSgkOXgTNtiVZXWyRuRPTsnRqdDqE08+ubL
         DWlQ==
X-Gm-Message-State: AFuF++n4jaFLQ8TWAZGdKMDFNPzJT0MIUU9GChsElVmVr1aMuZJNH2w1
	7BnJPja7jpuBAOIeeCj/foAnpunZV2f59vTZn/E+5QMryipoY3C3NLo6r6Urm53s2d2d8y58+FY
	UK50YibRrCEq4utgRFHiytqUC8xSnPStXfKadd7wakD2IYCPH45lWUs810XlO6PePuYdCat6zg7
	7/A4Ocn+n2Ozk0bQGXZombOlftSTih0EHugFz2p2A8DZAkfYuqNUTWrxdJ107EAUWVfryotP9rF
	C28JSwJHhYnlr0r
X-Gm-Gg: AYBFou3hSz+t4pnl1QmFU0nI1DHniahd5xTP3a22sNiJHWjsPnBfduAqR2stjo1Px8T
	npAeiUt4BI+DizwRyYS5Irf3VlTlBIpexBh70Tri2/9PI+3O91OEwjZLcLLvP/ntVWRKTBx6+5g
	qJygyBW8c3Krf8+5ziSyPX2aWik2vyl3/47yhghLEhxy4CsXsdeMiyd39df/3cdzpFf2Bgodntb
	fR1t2xYSJkXd5z6LCJ/Zd65m52FzjRZOAWadxE1NlU0NUjKHxyFaPJKTyBeYpvNQKG0vM1PsJTP
	Q5Hcv+fs3qIzvDw69S6nhy1s4XbnKiznRP4VjvNRnUaUDRaOEtsvpHLUM3MWb0OU8FIgxZWI+Oj
	wOiFlBsqJN3vtstzbP7eUH9WQIiqh0F2DNJbkfcP6Ifx4MANQ+Y1VIHi/80y0BSl82OjIRHAMnE
	J5SvPRiwv6qaLqCpdacE2ABtsEqtXNjoHd6OK+iQE=
X-Received: by 2002:a17:90b:274b:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39d9bc6767cmr10369553a91.4.1789169770610;
        Fri, 11 Sep 2026 16:36:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d94b3e7e0sm2296070a91.0.2026.09.11.16.36.10
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:36:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e869793d3so26616066d6.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169769; x=1789774569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsR21IG9GkhkXFxkByd8Q5sMNxfEXtOVC73TP3sSjXM=;
        b=bfPgcSf/HyB41Fqy+8s7nc3roKN1NuxWVdktuLfM2An9WY04LZ7Rp6vqlL1EZLs+BQ
         P1mzgKuVCa8Np6GfTRmdvkwpcVziwxiy336zCqv2YzcD3aqcBAPH7P8Qhj+M4lGT82EB
         ZOLicq08KclBFmRDYzeBQZllKa3O43+KynJN8=
X-Received: by 2002:a05:6214:daa:b0:910:321e:2ebb with SMTP id 6a1803df08f44-91212086571mr95943266d6.8.1789169769124;
        Fri, 11 Sep 2026 16:36:09 -0700 (PDT)
X-Received: by 2002:a05:6214:daa:b0:910:321e:2ebb with SMTP id 6a1803df08f44-91212086571mr95942566d6.8.1789169768577;
        Fri, 11 Sep 2026 16:36:08 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:36:08 -0700 (PDT)
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
Subject: [PATCH 12/13] PCI: brcmstb: Use order-0 indexing for inbound BAR window array
Date: Fri, 11 Sep 2026 19:35:37 -0400
Message-Id: <20260911233541.1650895-13-james.quinlan@broadcom.com>
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

The register names for the inbound BAR registers use order-1 indexing,
e.g. the first is BAR1.  The code followed this nomenclature by not using
the 0th element of the inbound array.

Undo this approach and use order-0 indexing.  Also use a struct pointer
variable in two functions instead of array indexing.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 49 ++++++++++++---------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8bca98e6f5fa..53984cfa2c96 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -954,8 +954,8 @@ static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
 	(*count)++;
 }
 
-static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
-				      struct inbound_win inbound_wins[])
+static int brcm_pcie_get_ib_wins(struct brcm_pcie *pcie,
+				 struct inbound_win *ib_win)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 pci_offset, cpu_addr, size = 0, tot_size = 0;
@@ -965,13 +965,6 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	int ret, i = 0;
 	u8 n = 0;
 
-	/*
-	 * The HW registers (and PCIe) use order-1 numbering for BARs.  As such,
-	 * we have inbound_wins[0] unused and BAR1 starts at inbound_wins[1].
-	 */
-	struct inbound_win *b_begin = &inbound_wins[1];
-	struct inbound_win *b = b_begin;
-
 	/*
 	 * STB chips beside 7712 disable the first inbound window default.
 	 * Rather being mapped to system memory it is mapped to the
@@ -980,7 +973,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * SoCs.
 	 */
 	if (pcie->cfg->soc_base != BCM7712)
-		add_inbound_win(b++, &n, 0, 0, 0);
+		add_inbound_win(ib_win++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
 		u64 pcie_start = entry->res->start - entry->offset;
@@ -997,7 +990,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		 * two.
 		 */
 		if (pcie->cfg->soc_base == BCM7712)
-			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
+			add_inbound_win(ib_win++, &n, size, cpu_start, pcie_start);
 
 		if (n > pcie->cfg->num_inbound_wins)
 			break;
@@ -1081,44 +1074,44 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	}
 
 	/* Enable inbound window 2, the main inbound window for STB chips */
-	add_inbound_win(b++, &n, size, cpu_addr, pci_offset);
+	add_inbound_win(ib_win++, &n, size, cpu_addr, pci_offset);
 
 	/*
 	 * Disable inbound window 3.  On some chips presents the same
 	 * window as #2 but the data appears in a settable endianness.
 	 */
-	add_inbound_win(b++, &n, 0, 0, 0);
+	add_inbound_win(ib_win++, &n, 0, 0, 0);
 
 	return n;
 }
 
 static u32 brcm_bar_reg_offset(int bar)
 {
-	if (bar <= 3)
-		return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
+	if (bar <= 2)
+		return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * bar;
 	else
-		return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
+		return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 3);
 }
 
 static u32 brcm_ubus_reg_offset(int bar)
 {
-	if (bar <= 3)
-		return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
+	if (bar <= 2)
+		return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * bar;
 	else
-		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP + 8 * (bar - 4);
+		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP + 8 * (bar - 3);
 }
 
-static void set_inbound_win_registers(struct brcm_pcie *pcie,
-				      const struct inbound_win *inbound_wins,
-				      u8 num_inbound_wins)
+static void brcm_pcie_set_ib_win_registers(struct brcm_pcie *pcie,
+					   const struct inbound_win *ib_win,
+					   u8 num_inbound_wins)
 {
 	void __iomem *base = pcie->base;
 	int i;
 
-	for (i = 1; i <= num_inbound_wins; i++) {
-		u64 pci_offset = inbound_wins[i].pci_offset;
-		u64 cpu_addr = inbound_wins[i].cpu_addr;
-		u64 size = inbound_wins[i].size;
+	for (i = 0; i < num_inbound_wins; i++, ib_win++) {
+		u64 pci_offset = ib_win->pci_offset;
+		u64 cpu_addr = ib_win->cpu_addr;
+		u64 size = ib_win->size;
 		u32 reg_offset = brcm_bar_reg_offset(i);
 		u32 tmp = lower_32_bits(pci_offset);
 
@@ -1202,11 +1195,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
-	num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
+	num_inbound_wins = brcm_pcie_get_ib_wins(pcie, inbound_wins);
 	if (num_inbound_wins < 0)
 		return num_inbound_wins;
 
-	set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
+	brcm_pcie_set_ib_win_registers(pcie, inbound_wins, num_inbound_wins);
 
 	if (!brcm_pcie_rc_mode(pcie)) {
 		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
-- 
2.34.1

