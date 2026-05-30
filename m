Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3732B132;
	Sat, 30 May 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155103; cv=none; b=jC3zmR7cF/tR5VZ2rQiXpfa2nYjQ+xCl+IZUdFssuvWq+G9RoXE1nzG6Aa4Id+jsn8urbVWXvKAj3zkpvhDXcqhomsQ4W7A6+miMHPnGxA6k1aQbvw+FtcSn3EkElB2Jpnt5ASC2DPbM2n6vw3ZwEY/wxgw8nR+ilQHVvxKL+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155103; c=relaxed/simple;
	bh=9Wi8kdht8lhxIjVDT1F1ydsI+q/9FXN2ycAGic8ObUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgIOZrZq7eAEGWGbA96NtGOEg/KzIxUZoM/9goINA+5AquJFMuuQz16QvvYJC45HTikIfdZCkOtL7t4Ajf4i+iDUeUFC0AqF5caE6NeanStbUcBWBrGj0/pT+tyoZRm7QLMgkHrcr1Uaxsy73zf1rvfVDIt5sPfGnezFA/NcyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DE7HBqXE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DE7HBqXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uU
	GqaCcyquHK8pE7kIHQ3gogw7hU58ZTcDwGQkRQHYQ=; b=DE7HBqXE2n39u44hH3
	Q79Q8U0OHWgG4rN2L8BQay9lC0uIsRaTM/1+58yr4Ca7JpONou740vwYhtWsZYUL
	FxFAb6Njn0uF63QALQKuaSB+diq1PVX37AYKJC8HVZe3UpWOEKFueHMVg/ePpu3O
	SqkwtELU6Pj27vHiTwkBZt29c=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S3;
	Sat, 30 May 2026 23:31:06 +0800 (CST)
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
Subject: [PATCH v2 01/16] PCI: dwc: Add pcie_cap field and helper in designware header
Date: Sat, 30 May 2026 23:30:46 +0800
Message-Id: <20260530153101.695580-2-18255117159@163.com>
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
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWxCF4kArWUWw4fGr1fXrb_yoW8Ww45pa
	y7JF1akF48AFWavF43AanxZr15tF93ArW7Ga9rKw1SgFyaya4UGa10yryYyF17Kr4Ikrya
	kw45t34rCF45JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zN4E_UUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xoQs2obArovlAAA3g

Add a pcie_cap field to struct dw_pcie to store the offset of the
PCI Express Capability structure. Provide a helper dw_pcie_get_pcie_cap()
which performs the capability search on first call and caches the result.

This is a preparatory step for replacing repetitive capability searches
in both core and platform drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7dac37521b8e..561b434fe335 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -596,6 +596,8 @@ struct dw_pcie {
 	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
+
+	u8			pcie_cap;	/* PCIe capability offset */
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -834,6 +836,21 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+/**
+ * dw_pcie_get_pcie_cap() - Return cached PCIe Capability offset
+ * @pci: DWC instance
+ *
+ * Finds and caches the offset of PCI_CAP_ID_EXP on first call.
+ * Returns 0 if the capability is not present.
+ */
+static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
+{
+	if (!pci->pcie_cap)
+		pci->pcie_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	return pci->pcie_cap;
+}
+
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
 {
 	if (pci->ops && pci->ops->start_link)
-- 
2.34.1

