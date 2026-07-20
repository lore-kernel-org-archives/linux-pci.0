Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9F3AB496;
	Mon, 20 Jul 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560120; cv=none; b=TTCnLFnKfNLqnz9l9xvTgqT4tsEFc9pVYPEaUGxEXm3C/VnuTL1UoNz1BZ4vRaP5g56yne8giIgeR1W51KFRHMeoJ+QYjxVvTLkAoxCrDXYdLygPkVjnXKzutZ4l163AUy0rAAQHR5Lu6xwVjy08k1ZAZcANughZjIyGMWHOLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560120; c=relaxed/simple;
	bh=xvn+wBM6m6H4j2V5VrCDG7F+OqWRxP3XqIkHxq0xqNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNNKC/fUII/3pkTBhgRsiMh5xx3DPJkRI18UbFp1tB+AvEnARkJngF+dG2dLuYFeBMn5dM/cIx9FzNat34uX9pi08l+fiPhzJ5yqQxuSLLQQdSQylQJCjAxnswAPDZPKejNJ74byxWXZLELZQP/yhDd0/76wSIjczFIZqHQ753E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kZgUgkgH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kZgUgkgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bh
	DWjSEv175HZK5Lkhl53A0JTo49xTss24i6v5jm7E4=; b=kZgUgkgHJL7Sf1yplc
	EnVrsUr+kYw+MnNaSlluBx5Yi7X5Bp4RB+P69pUgltAro9iVZSKW7dLWF5mbf370
	LWNjY+SZWr9P+hZaEDuv9kpdl1fIU+SyfCYTwc0y5Jc3Sq+HbrVZs3IOtC3wGaC4
	yWHKyq4Tktzljvj7NEpmiisuA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S5;
	Mon, 20 Jul 2026 23:07:58 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 11/16] PCI: dwc: qcom: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:14 +0800
Message-Id: <20260720150619.24733-12-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4xJFWUKFWfWw13Jr45GFg_yoWrCw4Dpa
	s0vrn0yF45Jr48WFnFyFZ3Xr1agrnxArW7Aa97Kr1SqF9xtryUGa1jyrySyFn3GFZrtFy7
	Gry8tryUX3WrtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziHa09UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7A6zV2peOc52YQAA3S

dw_pcie_host_init() caches the offset after .init, so .post_init callbacks
and later functions (.link_up, icc_opp_update) can use pci->pcie_cap
directly. For .init itself, we must call dw_pcie_get_pcie_cap() inside
qcom_pcie_host_init() to obtain the offset (hardware is already enabled).

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-qcom, dw_pcie_find_capability() appears in multiple call chains:

  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
    .init = qcom_pcie_host_init,
  };
  qcom_pcie_host_init()
    -> qcom_pcie_clear_aspm_l0s()
      -> dw_pcie_find_capability()

  static const struct qcom_pcie_ops ops_* = {
    .post_init = qcom_pcie_post_init_*,
  };
  qcom_pcie_post_init_*()
    -> qcom_pcie_set_slot_nccs()  (for many versions)
      -> dw_pcie_find_capability()
    -> For 2_3_3 and 2_9_0: also calls dw_pcie_find_capability() directly

  static const struct dw_pcie_ops dw_pcie_ops = {
    .link_up = qcom_pcie_link_up,
  };
  qcom_pcie_link_up()
    -> dw_pcie_find_capability()

  qcom_pcie_probe()
    -> dw_pcie_host_init()
    -> qcom_pcie_icc_opp_update()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-qcom.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..bd383d7cb02b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -341,13 +341,13 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-	u16 offset;
+	u8 offset;
 	u32 val;
 
 	if (!pcie->cfg->no_l0s)
 		return;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -360,7 +360,6 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 
 static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
 	dw_pcie_dbi_ro_wr_en(pci);
@@ -370,9 +369,9 @@ static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
 	 * notifications for the Hot-Plug commands. So set the NCCS field to
 	 * avoid waiting for the completions.
 	 */
-	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	val = readl(pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);
 	val |= PCI_EXP_SLTCAP_NCCS;
-	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	writel(val, pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
@@ -935,7 +934,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	u32 val;
 
 	/* Force PHY out of lowest power state */
@@ -1257,7 +1256,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	u32 val;
 	int i;
 
@@ -1303,8 +1302,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 
 static bool qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	u16 val = readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
@@ -1664,15 +1662,14 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 
 static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
-	u32 offset, status, width, speed;
+	u32 status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
 	struct dev_pm_opp_key key = {};
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	status = readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	/* Only update constraints if link is up. */
 	if (!(status & PCI_EXP_LNKSTA_DLLLA))
-- 
2.34.1

