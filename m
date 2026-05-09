Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1738B140;
	Sat,  9 May 2026 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332087; cv=none; b=byDGd7ZaO8ULgZ1nC1De0ATwK2j0yxJiF916qlg8NXQ5lphd7zQrjGjYutVene0NMnS8rztS58EgWLrvPDTyFO1t7t71xdq5sF+QtFNQSIGIr4KQxKevQmS708X9fF4SUrrxm42XWOZ2kxk5OIw5iRvJmn9DQ3I/Fh9pDe6b1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332087; c=relaxed/simple;
	bh=8UsQ8ODIaKHNARGlNV8zeg4b5v5mx+oMLZjK3ISDOo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MF529WmYkz+szBWLAstv4UgOswp0b6T4jPsMZqMZ6+1fc3jaxUNFzFRM6OqK4Edu6VPkXQqVccn0T87uhDhZ6LMe9HVXMqeHSyWFP9N/X/pG+PrHDko7w9isn7wEZSgIfF9iNHE07Ov0hepiHJybrxNLTmFktRs8HvSaId2zn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kB3/v6PV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kB3/v6PV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G2
	voV/4bTfj6ga8/syXqTbj2JOBf62JPJ24eOcc6mQ8=; b=kB3/v6PVGR57waqw8H
	7lVlpNYlmM2x3xqBuFf5tpmDNRuKasIY7AmKafCk5/r+xxFTXxFQ+EUK4FmB8x9f
	kjFuMzTO1cqgpyMFcYa8r+iM5VVsfNtYWrw3/gItJCXkkGETmpvzzVsTzKCR2dHJ
	ZDBhgEU1GDkJx2lyStkWwgfYM=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHYi+GMf9pRitfDA--.13014S4;
	Sat, 09 May 2026 21:07:22 +0800 (CST)
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
Subject: [PATCH v2 2/3] PCI: cadence: Add cdns_pcie_get_pcie_cap() helper and cache capability offset
Date: Sat,  9 May 2026 21:07:15 +0800
Message-Id: <20260509130716.2104103-3-18255117159@163.com>
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
X-CM-TRANSID:PygvCgDHYi+GMf9pRitfDA--.13014S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45Jr1xur1kZw4DWr18AFb_yoW8uF45pF
	WDWr1fKF1rJrW3u3Z3Aa1Yqr13tF90k3y7t392kr13Zr12kr1UGF12kFyYkF1akrW3Cr13
	ZrWDtr9rWF1ayrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKhF4OUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAvIbGn-MYueIAAA35

Add a helper cdns_pcie_get_pcie_cap() that finds and caches the
PCIe Capability offset in struct cdns_pcie::pcie_cap. This avoids
repeated searches and follows the pattern used in other PCIe drivers.

The helper uses cdns_pcie_find_capability() to locate PCI_CAP_ID_EXP
and stores the result for later use.

This is a preparatory step for removing the hardcoded capability
offset from host driver code.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index c057f4b393e6..bbd275193bc1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -219,6 +219,7 @@ struct cdns_plat_pcie_of_data {
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
  * @debug_dir: debugfs node
+ * @pcie_cap: PCIe capability offset
  */
 struct cdns_pcie {
 	void __iomem		             *reg_base;
@@ -233,6 +234,7 @@ struct cdns_pcie {
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 	struct dentry			     *debug_dir;
+	u8				     pcie_cap;
 };
 
 /**
@@ -651,6 +653,22 @@ static inline int cdns_pcie_hpa_ep_setup(struct cdns_pcie_ep *ep)
 
 u8   cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
 u16  cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
+/**
+ * cdns_pcie_get_pcie_cap() - Return cached PCIe Capability offset
+ * @pcie: Cadence PCIe instance
+ *
+ * Finds and caches the offset of PCI_CAP_ID_EXP on first call.
+ * Returns 0 if the capability is not present.
+ */
+static inline u8 cdns_pcie_get_pcie_cap(struct cdns_pcie *pcie)
+{
+	if (!pcie->pcie_cap)
+		pcie->pcie_cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
+
+	return pcie->pcie_cap;
+}
+
 bool cdns_pcie_linkup(struct cdns_pcie *pcie);
 
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
-- 
2.34.1

