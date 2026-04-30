Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5A947D92B;
	Thu, 30 Apr 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566309; cv=none; b=HqtfJ+vQB17nD9EfhUI6b/MCiK0vWjKASo3Ty0iqXv4J31FyWehAvBkATQ1v8JRUF5sd/w6Zklkkv9D5gVWZw/H3UUwBL3vVnKXu7YccHYPV/c4+1/0SW223uWCHAGmNmn7KnUJCEiGnvR4IO0Th89yUtNhh07h6pbt5vsceIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566309; c=relaxed/simple;
	bh=vZ4uOzaFRCb9PY8JtFYGG0Um0DEUay7WKzS4t7ZqMa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrq4iw3ATbZoMXr1ecTz+vovkH9mt++2a5tWIgGMzwbZD//eft2SyLfQIMwQXI9F+iOCyXuJZZjvTtwxuRoDnaGyYDWx51B7SV/OTgB6LZO0Q4cU9dVzX82ZkdxWn4opti7gOr/OmCxbr/qe+HisVZQfe8IHv5T85pc0i2xexfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IFG78m6c; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IFG78m6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cD
	l2ZCPmDUg/728GazbNRHsswC8Xpvy+YlB6anU9tzI=; b=IFG78m6c6ZXsOK5K31
	ZWx43DnN8XMZnab8e32qJ1aoEEloln6QLsZka3BvPQb/7dVJg5s4EwiR9k1MBtpU
	MXmEN03jG7+e3r50jXpztcbkvotEfpfWn028NDoxrKBbCHFSjPUGo31UufNl/E2I
	+G0xDWMasjtnzJuZyPa5FoIvg=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Df0_gvNpcypXCg--.51103S7;
	Fri, 01 May 2026 00:24:34 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	s32@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH 13/16] PCI: qcom: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:17 +0800
Message-Id: <20260430162420.42839-14-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430162420.42839-1-18255117159@163.com>
References: <20260430162420.42839-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Df0_gvNpcypXCg--.51103S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr45CFWrXFWDuFy3ury5CFg_yoW7Jw4Upa
	48t3Z7JF18tF4UurZIkanrur1F9FsxAw12kanxKanruasFyFZrWa90y3sxtrn7JF4UKFya
	k348AFW3GFySyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRP8nOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAMIq2nzgkNcVAAA33

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-qcom-common.c | 40 +++++++------------
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index 5aa73c628737..0da73caf2011 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -30,20 +30,15 @@ void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
 
 		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
-		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
-			  speed - PCIE_SPEED_8_0GT);
+		FIELD_MODIFY(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, &reg,
+			     speed - PCIE_SPEED_8_0GT);
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
 
 		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
-		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
-			GEN3_EQ_FMDC_N_EVALS |
-			GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA |
-			GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA);
-		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
-			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
-			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA, 0x5) |
-			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA, 0x5);
+		FIELD_MODIFY(GEN3_EQ_FMDC_T_MIN_PHASE23, &reg, 0x1);
+		FIELD_MODIFY(GEN3_EQ_FMDC_N_EVALS, &reg, 0xd);
+		FIELD_MODIFY(GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA, &reg, 0x5);
+		FIELD_MODIFY(GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA, &reg, 0x5);
 		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
 
 		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
@@ -61,14 +56,10 @@ void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
 	u32 reg;
 
 	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
-	reg &= ~(MARGINING_MAX_VOLTAGE_OFFSET |
-		MARGINING_NUM_VOLTAGE_STEPS |
-		MARGINING_MAX_TIMING_OFFSET |
-		MARGINING_NUM_TIMING_STEPS);
-	reg |= FIELD_PREP(MARGINING_MAX_VOLTAGE_OFFSET, 0x24) |
-		FIELD_PREP(MARGINING_NUM_VOLTAGE_STEPS, 0x78) |
-		FIELD_PREP(MARGINING_MAX_TIMING_OFFSET, 0x32) |
-		FIELD_PREP(MARGINING_NUM_TIMING_STEPS, 0x10);
+	FIELD_MODIFY(MARGINING_MAX_VOLTAGE_OFFSET, &reg, 0x24);
+	FIELD_MODIFY(MARGINING_NUM_VOLTAGE_STEPS, &reg, 0x78);
+	FIELD_MODIFY(MARGINING_MAX_TIMING_OFFSET, &reg, 0x32);
+	FIELD_MODIFY(MARGINING_NUM_TIMING_STEPS, &reg, 0x10);
 	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
 
 	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
@@ -76,13 +67,10 @@ void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
 		MARGINING_SAMPLE_REPORTING_METHOD |
 		MARGINING_IND_LEFT_RIGHT_TIMING |
 		MARGINING_VOLTAGE_SUPPORTED;
-	reg &= ~(MARGINING_IND_UP_DOWN_VOLTAGE |
-		MARGINING_MAXLANES |
-		MARGINING_SAMPLE_RATE_TIMING |
-		MARGINING_SAMPLE_RATE_VOLTAGE);
-	reg |= FIELD_PREP(MARGINING_MAXLANES, pci->num_lanes) |
-		FIELD_PREP(MARGINING_SAMPLE_RATE_TIMING, 0x3f) |
-		FIELD_PREP(MARGINING_SAMPLE_RATE_VOLTAGE, 0x3f);
+	reg &= ~MARGINING_IND_UP_DOWN_VOLTAGE;
+	FIELD_MODIFY(MARGINING_MAXLANES, &reg, pci->num_lanes);
+	FIELD_MODIFY(MARGINING_SAMPLE_RATE_TIMING, &reg, 0x3f);
+	FIELD_MODIFY(MARGINING_SAMPLE_RATE_VOLTAGE, &reg, 0x3f);
 	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_2_OFF, reg);
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_lane_margining);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 257c2bcb5f76..56184e6ca6e6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -494,15 +494,13 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	/* Set the L0s Exit Latency to 2us-4us = 0x6 */
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	val &= ~PCI_EXP_LNKCAP_L0SEL;
-	val |= FIELD_PREP(PCI_EXP_LNKCAP_L0SEL, 0x6);
+	FIELD_MODIFY(PCI_EXP_LNKCAP_L0SEL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
 
 	/* Set the L1 Exit Latency to be 32us-64 us = 0x6 */
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	val &= ~PCI_EXP_LNKCAP_L1EL;
-	val |= FIELD_PREP(PCI_EXP_LNKCAP_L1EL, 0x6);
+	FIELD_MODIFY(PCI_EXP_LNKCAP_L1EL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.34.1

