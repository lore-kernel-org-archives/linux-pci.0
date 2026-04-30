Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCB47DD60;
	Thu, 30 Apr 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566315; cv=none; b=Lfk0BFKvEfD+cKYbL9X4m9s/hqUBKuM38GUWM3S2vnbmAw3EOhKk2B9//EFVU5Bi63aqIdDsdOd2EcWFUXXOKbejEs9ZUDDxnWmBcJPC8U2fSw0Ts0LBsz7U9gvuqBV1au+UHsKytDGpA9g5ZRP20dNXnuHY7KDGFIq4qvXnz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566315; c=relaxed/simple;
	bh=yQO3BGRmV2kjV7ZOVBoEhN3HcNfDmDzJd7JphAWGMg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnNKk7c0YSynuoWuZT6+QrZPMt0rxi1ojOmIwUVz755wHo3AniKe6QNoedLEj7Q3MQeKxuVW4Hs2ZTfxbWpBa/vFLyQEXJcORq6briFGXzBUt4Go8YJugcCKIWSPpZqHYD4JuID50b5595XmCDm47suAIhewLp2q+zB8qCAz2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=keShUSEk; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="keShUSEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ab
	jbWUMg51txoJ4eO3Die4tJLGoUyy9UCj0uefKd21o=; b=keShUSEkoxZscZNARV
	qXMhl02SxnOu1o+9iHV3NcO4I5q1dapq1OmuY42zPE/uIklMidooLNwh5kKZT6yT
	qW+wNEdVv3m6dH4gCUK7WQpV3gg5VSW7c81PXiilYLSglDTEETq77k4lZkjAhqd0
	GGtc5gBVhquW8cVRf1Dkf6V6A=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Df0_gvNpcypXCg--.51103S8;
	Fri, 01 May 2026 00:24:35 +0800 (CST)
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
Subject: [RESEND PATCH 14/16] PCI: dwc: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:18 +0800
Message-Id: <20260430162420.42839-15-18255117159@163.com>
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
X-CM-TRANSID:_____wA3Df0_gvNpcypXCg--.51103S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4UKFy7Ar13ZrWrAFy7Wrg_yoWrKF4Upa
	y5ArySyF1rtr45Z3Z8Za4DuF15X3Z3AFZ7G39ruw1xWFy2vr42qay8Ka4Yyr1fJFW0qry5
	Kw4jy347GFs8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRP8nOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAMIq2nzgkNcawAA3I

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 23 +++++++------------
 .../pci/controller/dwc/pcie-designware-ep.c   |  3 +--
 drivers/pci/controller/dwc/pcie-designware.c  |  3 +--
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index d0884253be97..945f8f9b6d0e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -265,8 +265,7 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
 		return ret;
 
 	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
-	val &= ~(LANE_SELECT);
-	val |= FIELD_PREP(LANE_SELECT, lane);
+	FIELD_MODIFY(LANE_SELECT, &val, lane);
 	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
 
 	return count;
@@ -339,14 +338,10 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf,
 	val |= ((err_inj_list[pdata->idx].err_inj_type << EINJ_TYPE_SHIFT) & type_mask);
 	val |= FIELD_PREP(EINJ_COUNT, counter);
 
-	if (err_group == 1 || err_group == 4) {
-		val &= ~(EINJ_VAL_DIFF);
-		val |= FIELD_PREP(EINJ_VAL_DIFF, val_diff);
-	}
-	if (err_group == 4) {
-		val &= ~(EINJ_VC_NUM);
-		val |= FIELD_PREP(EINJ_VC_NUM, vc_num);
-	}
+	if (err_group == 1 || err_group == 4)
+		FIELD_MODIFY(EINJ_VAL_DIFF, &val, val_diff);
+	if (err_group == 4)
+		FIELD_MODIFY(EINJ_VC_NUM, &val, vc_num);
 
 	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group), val);
 	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ_ENABLE_REG, (0x1 << err_group));
@@ -362,9 +357,8 @@ static void set_event_number(struct dwc_pcie_rasdes_priv *pdata,
 
 	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
 	val &= ~EVENT_COUNTER_ENABLE;
-	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
-	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
-	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
+	FIELD_MODIFY(EVENT_COUNTER_GROUP_SELECT, &val, event_list[pdata->idx].group_no);
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SELECT, &val, event_list[pdata->idx].event_no);
 	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
 }
 
@@ -469,8 +463,7 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
 	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
-	val &= ~(EVENT_COUNTER_LANE_SELECT);
-	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
+	FIELD_MODIFY(EVENT_COUNTER_LANE_SELECT, &val, lane);
 	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
 	mutex_unlock(&rinfo->reg_event_lock);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d4dc3b24da60..88e7fc3d5e9d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -707,8 +707,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
-	val &= ~PCI_MSI_FLAGS_QMASK;
-	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, mmc);
+	FIELD_MODIFY(PCI_MSI_FLAGS_QMASK, &val, mmc);
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c11cf61b8319..bcfc7bfcf232 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -938,8 +938,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 
 	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
-	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
-	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
+	FIELD_MODIFY(PCI_EXP_LNKCAP_MLW, &lnkcap, num_lanes);
 	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
 }
 
-- 
2.34.1

