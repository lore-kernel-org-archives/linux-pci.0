Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31C3382F7;
	Sat, 30 May 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155108; cv=none; b=bVEU3Qy481vWuSwyYkKn0TTj5LRt/4WotEFgE9KG9qJ08TCuw6uHIJ4/833SegyIFM4ZlZ+aMZiiReDwzpeWXgMqD70vcODQCBFdGGl7cnYI2+MRcRgCeX7f7EZvn4t92P9TLcNe6/kXZh5yoFUS6Y7tN1Nk/4J/QdhO78pT7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155108; c=relaxed/simple;
	bh=32M/PdsAFc/9DPQK2sFcE+ASvTTCe66eK5B3WyZp7/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Riv0QKfEMJ2GrzAEnlNaebYmLbXfTLoC+FLKtA2YyOyjPjqdpNaXN1oRQOKYVUiesnMrZl52HRCFjlvwclzeU+Y0pgC6NPv2Fmu749XrqS5xxbGxyHUvHimD5XPbYiqoKTO7uvccKFUxiqsBu12gMSfWJ2DBHDVAtsC4/8tdalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xs2/nOCb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xs2/nOCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tu
	ra2KdjQW2HVx3hWRZaEz0M07jdxiudkOkLoIpL7hg=; b=Xs2/nOCbi7kYCh5SeX
	0FlHHHNZ+Vv43rivL3380Bwm6EuO4t2622wWPeozIGAVvkHO7s4l9gRf6SKxjO28
	ubRS+cYKZWnhuVFWE/wQcOvpeIwUIvaLIxTFMF2a7O4oPrqZDIFTDrMCNGvlZHRW
	yo924VGLZniLfgLz4YYlulwVA=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S5;
	Sat, 30 May 2026 23:31:18 +0800 (CST)
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
Subject: [PATCH v2 11/16] PCI: dwc: qcom: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:56 +0800
Message-Id: <20260530153101.695580-12-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260530153101.695580-1-18255117159@163.com>
References: <20260530153101.695580-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4xJFWUKFWfWFyfXr47Jwb_yoWrCw4Dpa
	s0vrn0yF45Jr48WFnFyFZ3Xr1agrnxArW7Aa97Kr1SqF9xtryUGa1jyrySyFn3GFZrtFy7
	Gry8tryUX3Wrtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ptYLm3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAYTtmobAsZ6-QAA3V

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
index 11fc60489892..80783353d539 100644
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
@@ -1663,15 +1661,14 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 
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

