Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA843553C
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418299; cv=none; b=t4/AYQ6F8ZkaEDzkLiPIiALGizuuL7mmMgLyikBbn/hVoKYuiB7a94nswWkS0tR4lZIu64krZyh+h7/fOeANxn/5MOWjkvFC6pvEH1xVeixvsJLz/ZYXs61E0ZWKwtRpK8gs5tm9SNejWxExzhgpt1skvBb8bUcYVaGYCXIiRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418299; c=relaxed/simple;
	bh=CMM6rLcPdJ9+grmR52Wdcs9HHUvZD9lg+ZX1vFyzXWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC/c8GRLkgeLhvdhrTmEPqocR9QAXTk6wOcJKfyG9nO/y7j7HJAomJJMTNz+5mrVVuuGTdbuDpezFunlvlMzsJdBATFfou6vrIcjgW0L5RQAI6N8UMDUxdPnLWqgslCGuLsjpHEuUOY7tKUKWyeLo7ByRGDQu15SN64PlEbJC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFnU7W61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFnU7W61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1982D1F000E9;
	Thu, 30 Jul 2026 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418298;
	bh=fWcNB6TcJmBoqvhXK+qhxOXV57Xo4XuEksuCG5MQ9yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFnU7W61tpMqNHCH+51stofUx5XVGsgxUSb0jYTqTx8yHqtcWXC3dPBk+D/HePUp6
	 jWBCqH8+CQUo90Rym2JsBy+tbX3R4OfiRtlm/0QAEoK2ISHkKg1XS/IvIjgTU3qG3x
	 xjD6FZQQ3iuLN8YCZYRsJQm3l+b5Z+Zz+vwb8AwC+PA5SAa8ttZnBOoAPsvUfVPdJC
	 5Z8gQyEHD1xn4nTi2k4mF9DbIiFD6gbmSCc9gIgNbc5Gq6BhShzs4pBaCL4Ju65ZrF
	 WB+V87xRLMK+WEwQ34Zg2hqS9Lh10RLc0PsCxZljCJPxH7ZcDNyPZZdhqoNd1Hlez+
	 gYwXDoA/Iqn0w==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>
Cc: Sashiko <sashiko-bot@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU
Date: Thu, 30 Jul 2026 15:31:26 +0200
Message-ID: <20260730133123.1420413-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730133123.1420413-4-cassel@kernel.org>
References: <20260730133123.1420413-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=cassel@kernel.org; h=from:subject; bh=CMM6rLcPdJ9+grmR52Wdcs9HHUvZD9lg+ZX1vFyzXWI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKygwzuBGV/OT7j5oXFlt1mpg7Wj44Hzr29pyflbJDB2 n47T/15HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIwUJGhunZF+ZMk26S33Rf 57D4jQ/uW+/NbVixfRan1KKpDy8KHdJl+J9wf5PQ6Yt3M/iD9Zd9O9eySdAtcMoJB8aeNM3Vr0O au9gB
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
 drivers/pci/controller/dwc/pcie-designware-ep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3128e7ae8c5f..7cd169d45890 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1127,6 +1127,17 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EPERM;
 	}
 
+	/*
+	 * ep->msi_iatu_mapped means that an MSI target address is cached,
+	 * unmap it first so that we can reuse ep->msi_mem_phys for MSI-X.
+	 */
+	if (ep->msi_iatu_mapped) {
+		/* flush posted write before unmap */
+		readl(ep->msi_mem + ep->msi_iatu_mapped_offset);
+		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = false;
+	}
+
 	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  map_size);
-- 
2.55.0

