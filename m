Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104158;
	b=FnybBVDLNFmfiB3wEN3pL6RuIufQ9OwP13b9aiVC5UB6jhEWRdsxYNBn5riC2I8gBH0Q
	 2vVsi8wEoAFAIbJIXetofijHTnEk48MWx7uwFf0hCKLf2hP8V2IFln5Oo8WQXEpHXzhwL
	 pAripMwwI6VTIcTpkB3CIHfy5GLDHs0KmD9SIQu/G6Or7Qoe8iwxIrvxxqF1rW8c2g/TE
	 m4bj+LrC4uq9BIfZ9GKrLUWKHtLZoCW7VJ5vL6wKDcVZkpfdHGpfhfSChdcQWkc1V78sO
	 hNOSc/MwwD4XjuLKDd9x5JYqfpEosdA+DrY3+pHBLdMMLYzaaIJJ5NauGaemtB61Cyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104158;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=C8BtL4WHZEYvTyOrvB3s5kHvzLx9kujDt8bs3NHTAwA=;
	b=DI1rdO7ilpwTG6ZYYp2CT1oJoEaYdJhZjOnEG5GF8gvGAm9a1T8k0OZMgC+HfLyrP6ic
	 3PAzRpIfTGPc/K2tuEJZ7VrAfGPwYDVlrLk0/4XvyPypv6WxRCgrHijWmt3ztuSCXWnyG
	 fjR9B2HsF9FZbkF80v9O9BXgVD7wqintdpDblbUVGSkxDHF2wCw3NhPLVM39CLyaPAFya
	 mgusVxUNDhWYnQqDw2dCykbZWwRicnpJuu8AJxI/k/jgbk4864PalTvpt5qeF5KAYyz73
	 bHBvS0nkRWplcXhTgpqJIlnWFx7/Ge/4NHbBTrbvR4VOVJ8ASF81NuC0ydetL72YLeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BS8ockxB;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB5606A31D;
	Tue, 27 Oct 2026 12:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FB5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BS8ockxB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C8
	BtL4WHZEYvTyOrvB3s5kHvzLx9kujDt8bs3NHTAwA=; b=BS8ockxBgj9gcy+xdB
	S33DdiFaHGWtXwxynQe6OoE+d6YHUEHHmC14Syz6JvvInhcBO5+vBhSUlsrn0akI
	JlrtBtBz3C+7zI3yxpE7GW5zXxM4R5XhbNefv/I2g3CrYF4b1il88bkSvXGWPD9o
	WJaus/XNJtjpC1AVoLw8WuvGQ=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S3;
	Tue, 27 Oct 2026 20:28:33 +0800 (CST)
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
Subject: [PATCH v4 01/16] PCI: dwc: Add pcie_cap field and caching helper
Date: Tue, 27 Oct 2026 20:28:12 +0800
Message-ID: <20261027122827.2725643-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xCr4UZFW3KFW7Zw17GFg_yoWrJF4xpa
	y3JF1SyFs8JFWSva13Aa1SgFy3Aas5ArW7Ja93Gw1fZw13ur1UKF10yry5tF17Gr4Iqr12
	gr45ta48CFn8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEs2-8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BE12GrgmPEX2AAA38

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
dw_pcie_find_capability() call it replaces used to happen, so no DBI
access can be made before the controller clocks, resets and power are
enabled. This matters for endpoint controllers such as qcom-ep and
tegra194, where DBI is only accessible after PERST# is deasserted, and it
also means platform drivers do not have to call the helper from a
specific callback at the right time.

The cached value is accessed with READ_ONCE()/WRITE_ONCE(), because the
first lookup may be triggered from different contexts, for example the
qcom-ep global IRQ and PERST# IRQ handlers. A concurrent lookup stores
the same value, so this race is benign.

A return value of 0 means that the capability is not present. This
cannot happen on real DWC hardware, where the PCI Express Capability is
mandatory, so a negative result is not cached separately: it only causes
the search to be repeated, which does not affect correctness.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae940924..fa31e8b763bc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -592,6 +592,8 @@ struct dw_pcie {
 	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
+
+	u8			pcie_cap;	/* Offset of PCI_CAP_ID_EXP */
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -830,6 +832,38 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+/**
+ * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
+ * @pci: DWC instance
+ *
+ * The offset of the PCI Express Capability structure is read once from
+ * the DBI configuration space on the first call and cached in
+ * @pci->pcie_cap for the subsequent ones.
+ *
+ * The lookup is done lazily at the first place that actually needs the
+ * offset, so the DBI read happens exactly when it used to happen before
+ * caching was introduced, i.e. never before the controller's clocks,
+ * resets and power are enabled.
+ *
+ * DWC PCIe controllers always implement the PCI Express Capability, so a
+ * return value of 0 means that the hardware is not usable. Callers that
+ * check the returned offset keep working, and the (never expected)
+ * lookup is simply repeated on the next call.
+ *
+ * Return: the cached offset, or 0 if the capability is not present.
+ */
+static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
+{
+	u8 cap = READ_ONCE(pci->pcie_cap);
+
+	if (!cap) {
+		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		WRITE_ONCE(pci->pcie_cap, cap);
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

