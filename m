Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267D38AC9E;
	Sat,  9 May 2026 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332081; cv=none; b=fwfMIcpgTF027xC7j7Lkq4sbSJp9BcykHXno+dfjixJLAhegibuu2VoLF6FWfUW5Soko4v9ZVXD9VngEuyvL5ArX6vPgXsoQ98M5zgjyqUToh9icme0RQSqY9JbIE7B/EcVDK7m+c9Ab0yct9QBG9ssqUXXGfIaqVdWHiMYUORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332081; c=relaxed/simple;
	bh=UXrQ3tikmHrAskmo748w8JQB3MhNi6dOmZluslyEjlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piB72aayhAzeQGrVNWXt+wS3pJV4S9tYSM4+6nnxUIkQj259qKHqg6vEpTwAVC/cDUWKjsnoBIS8qvF7lbgFJWMuoolAJUILsBZaANPPzLNONDEZ381c0pnhG4I1xIBURM6ohMTkOyiqkBTDw1yBxiMRVAvySoAJRWS9MP8IbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MJuorTb6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MJuorTb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+h
	u6sR6qdLLOp02Nlw7V+LCLdEzkp8flEMxu7HQ10vI=; b=MJuorTb6jGZs5skNVq
	Rqv29k0Qi1Z5DY+qhAo9uw+0D2tEvFiy2KgG79DLcnl6XIYRmTcBzjkhX26+a14S
	7M5QXp9Wu8/Okn+WKNnFJc2oeWEZLGy+h0L+X5VEw4cIK7tYP/UrHxJXJ6FP1OQz
	cRKA0NMqUYziAWzhH0iCL4VJs=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHYi+GMf9pRitfDA--.13014S5;
	Sat, 09 May 2026 21:07:23 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s-vadapalli@ti.com,
	a-garg7@ti.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 3/3] PCI: cadence: Use dynamic PCIe capability offset in host driver
Date: Sat,  9 May 2026 21:07:16 +0800
Message-Id: <20260509130716.2104103-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509130716.2104103-1-18255117159@163.com>
References: <20260509130716.2104103-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHYi+GMf9pRitfDA--.13014S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArWDJrWDZr43KryrKFy5twb_yoW7AFWrpF
	WDWFyIk3WIqrWY9an5A3WDZF13t3ZIy3srJws29w17ZF17CFyUGFW2gFn8tFZxGrZrXry7
	X3WDtF9rGF4SvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR04ibUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wvIbGn-MYtRRAAA39

The Cadence PCIe controller may place the PCI Express Capability
structure at different offsets depending on SoC integration. The
hardcoded CDNS_PCIE_RP_CAP_OFFSET (0xC0) is not universally valid.

Replace all uses of the fixed offset with the dynamically cached
pcie->pcie_cap obtained via cdns_pcie_get_pcie_cap(). This affects:
- Root Port training completion check
- Link retraining
- Root Port initialization (ASPM quirks)

Also remove the now-unused CDNS_PCIE_RP_CAP_OFFSET definition from
pcie-cadence-lga-regs.h.

This change ensures correct operation across different Cadence IP
generations (LGA and HPA) and SoC designs.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c          | 5 +++--
 drivers/pci/controller/cadence/pcie-cadence-host-common.c | 4 ++--
 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c    | 2 ++
 drivers/pci/controller/cadence/pcie-cadence-host.c        | 6 ++++--
 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h    | 1 -
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 38a0157b60dc..eeee954f7dc7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -571,9 +571,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	int max_epfs = sizeof(epc->function_num_map) * 8;
 	int ret, epf, last_fn;
 	u32 reg, value;
-	u8 cap;
+	u8 cap = pcie->pcie_cap;
 
-	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
@@ -690,6 +689,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	}
 	pcie->mem_res = res;
 
+	cdns_pcie_get_pcie_cap(pcie);
+
 	ep->max_regions = CDNS_PCIE_MAX_OB;
 	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index 2b0211870f02..26b248231558 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -26,7 +26,7 @@ EXPORT_SYMBOL_GPL(bar_max_size);
 
 int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
 {
-	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u32 pcie_cap_off = pcie->pcie_cap;
 	unsigned long end_jiffies;
 	u16 lnk_stat;
 
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
 int cdns_pcie_retrain(struct cdns_pcie *pcie,
 		      cdns_pcie_linkup_func pcie_link_up)
 {
-	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u32 lnk_cap_sls, pcie_cap_off = pcie->pcie_cap;
 	u16 lnk_stat, lnk_ctl;
 	int ret = 0;
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 8bf7cc106413..512e243df737 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -355,6 +355,8 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
 		rc->cfg_res = res;
 	}
 
+	cdns_pcie_get_pcie_cap(pcie);
+
 	/* Put EROM Bar aperture to 0 */
 	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_EROM, 0x0);
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 873d496c440f..6f6d80840114 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -147,12 +147,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
-	value = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP);
+	value = cdns_pcie_rp_readl(pcie, pcie->pcie_cap + PCI_EXP_LNKCAP);
 	if (rc->quirk_broken_aspm_l0s)
 		value &= ~PCI_EXP_LNKCAP_ASPM_L0S;
 	if (rc->quirk_broken_aspm_l1)
 		value &= ~PCI_EXP_LNKCAP_ASPM_L1;
-	cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP, value);
+	cdns_pcie_rp_writel(pcie, pcie->pcie_cap + PCI_EXP_LNKCAP, value);
 
 	return 0;
 }
@@ -410,6 +410,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return PTR_ERR(rc->cfg_base);
 	rc->cfg_res = res;
 
+	cdns_pcie_get_pcie_cap(pcie);
+
 	ret = cdns_pcie_host_link_setup(rc);
 	if (ret)
 		return ret;
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

