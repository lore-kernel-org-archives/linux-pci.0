Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156858;
	b=w5vcNMWrmud/4cTl53X7V3gHDYtc2QdVPjgVGAkOtMUJ6iwbXZsHUkv3TOtVUGau7Lj6
	 pXOVwQNic1xZw3P1XRP519yyCcOQBTPrGCVsTSMmfbkGHTtRbDf7Ff3boxcjUPTTvQayE
	 Yb9xxp5+rz9a7U8fzEOhT4Tg5RtPQUTj+es7gnn9yxBGvkM7OQWuOOc8AGrjIdm2F7/GB
	 cHNcJFwXzlrPZyiBFMyBJIiJrfp06Zja/FGor5at5LfshIGxAMEcylXQMWgbIqWulfy28
	 iJsb/QTu+C8O1S+jHvQ9qNe9d671x+ewnhSI9J7z3F2B2NbHpKnFTBl1gLjgjsbXVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156858;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=hFLHtyAEUbucyklnv273Nmookz4wD3SmGr8qXgopcSE=;
	b=eLKS3QrPnjMftm1zBjTmK0073WLemR9GL9T2P3OrxD98Cmg9FBMfD/5ft3riVIk/EAVw
	 SqCC0xHqtCHCiK15kylIGbrcR8DfOhb4kJLAgO3iuHikTpIn7+mTbUgkpTLtCvUmXKOVh
	 lWBxkm0ykBueSOodKkGcshyRlvZhPwKfFczEawj7uQkgtsy9lcJBSYJH3xNjw9RpP8FYl
	 6BjrppMmtb+Q+bi98pTZPk0EXXlKPnID071aCaYXVdi1GV+yWzH3sGZfT6XZ96AsUF9dB
	 zwKaF2zhX2PWcRFgfrc1Sl8lWhjR8VlrxRgtY/zPMsYGPY10Tip8ETSIvgQHXADx84w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g6BGph+W;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D356606A32C;
	Wed, 28 Oct 2026 03:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D356606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g6BGph+W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hF
	LHtyAEUbucyklnv273Nmookz4wD3SmGr8qXgopcSE=; b=g6BGph+Whp9fOSqPrP
	uV/PKq/RbpyX101MLm4jpxdDC3R5aRquWyjZvCUmy7eM3i7B8v/w+RYzHxn3c5OU
	kAuBV45nPuzwJlYwq4TZFSEQhxg5S25F/dUjffZpbM3wpC3j+BNePDaw4d0nJt4V
	HRihUeKzIwntnvAvOqFGnCGe4=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S3;
	Wed, 28 Oct 2026 11:06:59 +0800 (CST)
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
Subject: [PATCH v5 01/16] PCI: dwc: Add pcie_cap field and caching helper
Date: Wed, 28 Oct 2026 11:06:37 +0800
Message-ID: <20261028030652.2917756-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xCr4UZFW3KFW7Zw17GFg_yoWrZr4rp3
	9xJFWSyFs8Jr4SvFsxA3W09F13Aas3AFW7Ga93Gw1fZry3ur1UKFW0yFWjyF17Gr4Igr12
	gr43ta48GFs8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zErgAOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BPghGrhZtPOwgAA3p

The DWC PCIe core and its platform drivers repeatedly call
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
PCI Express Capability structure. Besides being verbose, that performs a
DBI read every time, including in paths that run repeatedly such as link
up polling, suspend/resume and interrupt handlers.

Add a pcie_cap field to struct dw_pcie and a helper
dw_pcie_get_pcie_cap() that performs the lookup on first use and caches
the result for the subsequent calls.

The lookup is deliberately done lazily, at the first place that needs the
offset, instead of at a fixed point during controller initialization.
This guarantees that the DBI read happens exactly when the open coded
dw_pcie_find_capability() call it replaces used to happen, so the series
does not introduce DBI accesses at points where the controller might not
be accessible. This matters for endpoint controllers such as qcom-ep and
tegra194, where DBI is only accessible after PERST# is deasserted, and it
also means platform drivers do not have to call the helper from a
specific callback at the right time.

Reading DBI while the controller is inaccessible (clocks or power gated)
is platform specific: some integrations hang, some return zero and some
return garbage. dw_pcie_find_capability() already rejects offsets below
the standard header, unaligned offsets and entries whose capability ID
does not match, but a transient bogus read could still look valid. To
prevent such a value from being cached for the rest of the lifetime of
the controller, the offset is only cached after the capability ID has
been read back at that offset. If it is not confirmed, the offset is
still returned to the caller for this access but not cached, so the next
call performs the lookup again, just like when the capability is not
found.

The cached value is accessed with READ_ONCE()/WRITE_ONCE(), because the
first lookup may be triggered from different contexts, for example the
qcom-ep global IRQ and PERST# IRQ handlers. A concurrent lookup stores
the same value, so this race is benign.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6d788aa000117..dede6b3966585 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -594,6 +594,8 @@ struct dw_pcie {
 	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
+
+	u8			pcie_cap;	/* Offset of PCI_CAP_ID_EXP */
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -832,6 +834,42 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+/**
+ * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
+ * @pci: DWC instance
+ *
+ * The offset of the PCI Express Capability structure is read from the
+ * DBI configuration space on the first call and cached in
+ * @pci->pcie_cap for the subsequent ones.
+ *
+ * The lookup is done lazily at the first place that actually needs the
+ * offset, so the DBI read happens exactly when it used to happen before
+ * caching was introduced, i.e. never before the controller's clocks,
+ * resets and power are enabled.
+ *
+ * A DBI read issued while the controller is not accessible returns
+ * platform specific data, and a transient bogus value must not stick in
+ * the cache.  The offset is therefore only cached once the capability
+ * ID has been read back at that offset.  Both the not-found and the
+ * not-confirmed cases leave the cache empty, so the lookup is simply
+ * repeated on the next call.
+ *
+ * Return: the offset of the PCIe Capability, or 0 if it could not be
+ * found or has not been confirmed yet.
+ */
+static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
+{
+	u8 cap = READ_ONCE(pci->pcie_cap);
+
+	if (!cap) {
+		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		if (cap && dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP)
+			WRITE_ONCE(pci->pcie_cap, cap);
+	}
+
+	return cap;
+}
+
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
 {
 	if (pci->ops && pci->ops->start_link)
-- 
2.43.0

