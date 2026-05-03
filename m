Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23512D061C;
	Sun,  3 May 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825197; cv=none; b=PD2KX4TyW0v+lCBFqsQUFQUJZA4ynZx0nb9fdqmIOdQG0VRA+qTjupwSTC3h5j2pUblybK3p66SLRw4XZ5yLMxdUoXFs//iHSPksZNCvnn5r68c6mcl3HmewmmUIOq3nU64EK3QCT6Fw+ZSM04+qrc2CZ/IBFItLLYdQi2qjOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825197; c=relaxed/simple;
	bh=yAvWr3Kprz6m9sHl1Wb0mk7IQ8OXqE+bT9c893UKmeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lOMb1vV1EwbeV/H9mXL+vnAyiRESCo45IDOwGJINQ2InVukQmEVYXCNzkA4ndVdYAWZlDjhS3SUzpndeyXeBdqlWL1ED3Be72+lx7d3AJPU1VtCWIbGfUpc0onG5W5LVv3jl80RtdoB8bCE1twZOMb0uvH182I3W5RfzUJab4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d74FHb1q; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d74FHb1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=b4
	1JjN3SH5XxvevjFooIwDYxxQeYW3QDlKT3BlDY/5I=; b=d74FHb1qiNQSooxygD
	hXeiY8r70ELfArPMNtHvmFZZqa/+FcsxgUZaGW3TYjr1vCULRsC8m5Mg2gBOA6yT
	yjKBloKqIZX798YOhyF7SWtlvFoOT3rSkOePKcvTXGP+Fw4fRlhfEQ2lqfyLmLLR
	Y9J3xWX5cg8CMctEVONvVM9rs=
Received: from zhb.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBH_x2Cdfdp3fqmCw--.44160S2;
	Mon, 04 May 2026 00:19:15 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: cadence: Use cdns_pcie_find_capability() to get PCIe Cap offset in host driver
Date: Mon,  4 May 2026 00:19:13 +0800
Message-Id: <20260503161913.77878-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBH_x2Cdfdp3fqmCw--.44160S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtrW5tFW8CryfJFy5Zw4kCrg_yoW7Aw1fpF
	ZxW3WSkF1Iqr4Y9a1kC3Z8XF13JF9Iya47Jan2kw13XF17CFyUGFy2kFy3KFW7GrZrXry7
	X3yDtrZxJa1avFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE6pBsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwTWemn3dYTVjQAA3c

The PCI Express capability structure may not always reside at offset 0xC0
in the configuration space of the Cadence PCIe controller. Different SoC
integrations can place the capability at a different offset, making the
hardcoded CDNS_PCIE_RP_CAP_OFFSET unreliable.

Replace the fixed offset with a dynamic lookup using
cdns_pcie_find_capability() in all host-related functions that need
to access the PCIe Capability registers. This ensures correct operation
across various SoC designs.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
When I was dealing with Siddharth Vadapalli's review comments on my patch,
I also discovered that there was hardware coding for the capability. So, 
continued to handle it according to the previous submission.
https://lore.kernel.org/all/20250813144529.303548-1-18255117159@163.com/

This patch is based on the submissions of the following series:
https://patchwork.kernel.org/project/linux-pci/cover/20260501153553.66382-1-18255117159@163.com/
---
 .../cadence/pcie-cadence-host-common.c          | 17 ++++++++---------
 .../pci/controller/cadence/pcie-cadence-host.c  |  5 +++--
 .../controller/cadence/pcie-cadence-lga-regs.h  |  1 -
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index d4ae762f423f..b217e3717851 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -27,14 +27,14 @@ EXPORT_SYMBOL_GPL(bar_max_size);
 
 int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
 {
-	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
 	unsigned long end_jiffies;
 	u16 lnk_stat;
+	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
 
 	/* Wait for link training to complete. Exit after timeout. */
 	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
 	do {
-		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+		lnk_stat = cdns_pcie_rp_readw(pcie, cap + PCI_EXP_LNKSTA);
 		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
 			break;
 		usleep_range(0, 1000);
@@ -77,27 +77,26 @@ EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
 int cdns_pcie_retrain(struct cdns_pcie *pcie,
 		      cdns_pcie_linkup_func pcie_link_up)
 {
-	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u32 lnk_cap_sls;
 	u16 lnk_stat, lnk_ctl;
 	int ret = 0;
+	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
 
 	/*
 	 * Set retrain bit if current speed is 2.5 GB/s,
 	 * but the PCIe root port support is > 2.5 GB/s.
 	 */
 
-	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
+	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + cap +
 					     PCI_EXP_LNKCAP));
 	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
 		return ret;
 
-	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+	lnk_stat = cdns_pcie_rp_readw(pcie, cap + PCI_EXP_LNKSTA);
 	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
-		lnk_ctl = cdns_pcie_rp_readw(pcie,
-					     pcie_cap_off + PCI_EXP_LNKCTL);
+		lnk_ctl = cdns_pcie_rp_readw(pcie, cap + PCI_EXP_LNKCTL);
 		lnk_ctl |= PCI_EXP_LNKCTL_RL;
-		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
-				    lnk_ctl);
+		cdns_pcie_rp_writew(pcie, cap + PCI_EXP_LNKCTL, lnk_ctl);
 
 		ret = cdns_pcie_host_training_complete(pcie);
 		if (ret)
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 0bc9e6e90e0e..2a3fd41c1cf4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -115,6 +115,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 value, ctrl;
 	u32 id;
+	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
 
 	/*
 	 * Set the root complex BAR configuration register:
@@ -147,12 +148,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
-	value = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP);
+	value = cdns_pcie_rp_readl(pcie, cap + PCI_EXP_LNKCAP);
 	if (rc->quirk_broken_aspm_l0s)
 		value &= ~PCI_EXP_LNKCAP_ASPM_L0S;
 	if (rc->quirk_broken_aspm_l1)
 		value &= ~PCI_EXP_LNKCAP_ASPM_L1;
-	cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP, value);
+	cdns_pcie_rp_writel(pcie, cap + PCI_EXP_LNKCAP, value);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
index 857b2140c5d2..7b92812ed120 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
+++ b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
@@ -133,7 +133,6 @@
 
 /* Root Port Registers (PCI configuration space for the root port function) */
 #define CDNS_PCIE_RP_BASE	0x00200000
-#define CDNS_PCIE_RP_CAP_OFFSET 0xC0
 
 /* Address Translation Registers */
 #define CDNS_PCIE_AT_BASE	0x00400000
-- 
2.34.1

