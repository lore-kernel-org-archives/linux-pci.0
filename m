Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57B46AF01;
	Thu, 30 Apr 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565631; cv=none; b=socFMVU78OgSC2Se5PB0gH0gKT4vSbYZutrz89azeNKS7CsYPqr58BemhyofUSmOUDuUwdUdb2Wt7hQk/ht281gBqbXhNPbKzQ75PhEYnD/AUJGPoRMtwR2IBm1Wl3DWHmSc0kpqyFA3HridVHNvbOjXqJWZFwhfH8e7p+3m89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565631; c=relaxed/simple;
	bh=sCsHoa8O9H1cL+Uy+UCJ1dvw/lw4dcrYTpEvOuCWps0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdm3mP9AEXfaI8umPhk1/h+FKxNd2KaqZqTjBfKMMRFwVHyEOaZeFIpxPyLWgcDr0ojEj+s1YhVhCLR1/DPANmDMTxd4kzrmz4itY2HxvwU9z3outX5I1T3duWjEpB8JROaOJS3nd9SCLl3Sh9zHdhj/zYffZp0CAaonKBHPnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CCaAOIXA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CCaAOIXA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=f4
	uCdZZ0oXhBkkne4HIBGaYPsR9cIC0DI5x1vctw3r8=; b=CCaAOIXATmR3/ykEA7
	Z+cW05MUr66+QVlrIAWQ6SslOgxV4M64A+DxJITF3O+KoVR15d7xJb/56WML6syi
	6DR1btEKj40EINRSE9VvPMTSuzTpUww8QGhUrS1cMCR0RGUP8C2o1T61RyJnzRTP
	DfU9Yg9mgjR7zNH2laDDSUUhQ=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S8;
	Fri, 01 May 2026 00:13:28 +0800 (CST)
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
Subject: [PATCH 06/16] PCI/MSI: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:44 +0800
Message-Id: <20260430161254.40278-7-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430161254.40278-1-18255117159@163.com>
References: <20260430161254.40278-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF4fKw17Gw1UWF1kAFb_yoW8Zw4UpF
	WFgFWUKayrta1rXFsxuF1q9F12vFs8tF97GF42kw17uryrZw1qyFy5tF4UKF1fXFW7Zr45
	AwnYy3y7Ka98GFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkOzsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwlhBWnzf6n2DAAA3Y

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/msi/msi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 81d24a270a79..33c8b5b98684 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -201,8 +201,7 @@ static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *desc,
 	u16 msgctl;
 
 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
-	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
-	msgctl |= FIELD_PREP(PCI_MSI_FLAGS_QSIZE, desc->pci.msi_attrib.multiple);
+	FIELD_MODIFY(PCI_MSI_FLAGS_QSIZE, &msgctl, desc->pci.msi_attrib.multiple);
 	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
 	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, msg->address_lo);
@@ -532,9 +531,8 @@ void __pci_restore_msi_state(struct pci_dev *dev)
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	pci_msi_update_mask(entry, 0, 0);
-	control &= ~PCI_MSI_FLAGS_QSIZE;
-	control |= PCI_MSI_FLAGS_ENABLE |
-		   FIELD_PREP(PCI_MSI_FLAGS_QSIZE, entry->pci.msi_attrib.multiple);
+	FIELD_MODIFY(PCI_MSI_FLAGS_QSIZE, &control, entry->pci.msi_attrib.multiple);
+	control |= PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
@@ -970,8 +968,7 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
 	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
 		return -ENXIO;
 
-	msi_desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_ST;
-	msi_desc->pci.msix_ctrl |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
+	FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);
 	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
 	/* Flush the write */
 	readl(pci_msix_desc_addr(msi_desc));
-- 
2.34.1

