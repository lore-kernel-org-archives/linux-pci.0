Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0002BE035
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360935; cv=none; b=blTQ2vOPvvVxukkBDj33wu3sPQ92ENgVH4pjdJJA2oDUDTB2Dv0zkF8JsqvkC/wZDKs+NeFS94XIMPljXHtM2iggxwKjdI5DIOAeBmAjdJArtjVDK0/CDbGI2waeNOAxylqGfzApuInTOHh75J6wDfm8hNU+LwbAaB136uJDOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360935; c=relaxed/simple;
	bh=7AcFD6ehROAx3dk7C+nq+YPhYAqj+xdP07hOnsm6hDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtJI1isueW/ddt8cPlXd1an3GuR/NhlS0/3y7gI7bjmmgtfRuuPFYrqvcU45NyrB1Fi6XvmBe6thciv96mXeEfLghhe0F717kStJUQXiH+gyyTosAbz/PGfX9kbSU/SxPvoicWXUwIW4hnPc4XLlr6WbkamP8fGC7cw/yYYMbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZQxPdJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZQxPdJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8191B1F000E9;
	Wed, 29 Jul 2026 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785360933;
	bh=6WiikiU8NUaqYGe9hn21iQ3tyu/5laXl50oEl3HzE20=;
	h=From:To:Cc:Subject:Date;
	b=mZQxPdJNy3h4ZHQbTeUKGVfdX23xK23oevqZ4LIuTLlEsEtYktNPEM+4t9+z9jMbV
	 VUDvHrzKMR/WqObfoPF8MRDSVMzsKIKU+BlQNRZEn76mBceg1MsTmvm1gZZhAJt6JX
	 s+OeOiRK/LIzeI/NAc+303Vnwt+pH9FEN2jfqXw6wuCpJISVNsfvRk8O81cRi8JJ2e
	 qbAeHI3Hu5jam/1/PHKFVi+9ufRc/ErJV6wSjqGRJMOLPhd5TYAueXTIjmp0L11P1r
	 iJVV1vX0k3ynlv1fiDDwY5v7AX2nZkIeEg8LvP63J1brxmuOWrs37deh4YYwh9e22V
	 VwGspryzwiyNw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Koichiro Den <den@valinux.co.jp>
Cc: Sashiko <sashiko-bot@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU
Date: Wed, 29 Jul 2026 23:35:21 +0200
Message-ID: <20260729213520.1187704-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=cassel@kernel.org; h=from:subject; bh=7AcFD6ehROAx3dk7C+nq+YPhYAqj+xdP07hOnsm6hDE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKyiiR/vXKIW7jlwpH87TH9QXvvdglEN8bmn1iv0Nujl hJ77/aHjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwk/iMjw5H9ctda+o5nHV6n xG/2xkmC/X+tktqTFKHzKoHTX1T/Z2T4Hxp4J9Zg/cvzJieF8zelacxn/3q24Pbe5yUCV4OL6mu b2AE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The persistent MSI iATU mapping can conflict with the dynamic MSI-X iATU
mapping, since they are both using ep->msi_mem_phys.

If dw_pcie_ep_raise_msi_irq() caches the iATU mapping, and then
dw_pcie_ep_raise_msix_irq() is called, it maps the same address to a new
window/iATU.

When dw_pcie_ep_raise_msix_irq() later calls dw_pcie_ep_unmap_addr(), the
lookup function, dw_pcie_find_index(), returns the first iATU index which
has the address mapped.

This means that dw_pcie_ep_raise_msix_irq() can unmap the address mapped
by dw_pcie_ep_raise_msi_irq(), without clearing ep->msi_iatu_mapped.

If there is a cached MSI iATU mapping, let dw_pcie_ep_raise_msix_irq()
unmap it first, so that we won't have two different iATUs mapping the
same address.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-pci/20260729051542.DC2741F000E9@smtp.kernel.org/
Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..051b23426035 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1124,6 +1124,15 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EPERM;
 	}
 
+	/*
+	 * ep->msi_iatu_mapped means that an MSI target address is cached,
+	 * unmap it first so that we can reuse ep->msi_mem_phys for MSI-X.
+	 */
+	if (ep->msi_iatu_mapped) {
+		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = false;
+	}
+
 	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  map_size);
-- 
2.55.0

