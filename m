Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2A37647E;
	Wed,  8 Jul 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504700; cv=none; b=DRrnJDXPC5mpf0ZSJZq70V0rsuANHKQFxOkp5HcqJhFj1z/bHmD8jAcvNebG1io2esP0PMbd4QiCOd8syr5mcIP5h96N1sRh5OUcG9QUST0WMu3WWUe9BPkm/WrU9ZDRlXzdmbAwEy2s9jTvzeq7YMwIVqTcp7HAgsfMn3kGm9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504700; c=relaxed/simple;
	bh=/pag6WqfUx7M6W9IF09UbWrL57C1eYrYraDPiIBWQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bg5d5b0e1cT6H+NKil+bvS3wETD+/hIUjjUZFEUuKLmX7arcIFSLfLKrStpIOYPLokPx3Md44+x4NzVw1VZ9JZNhRM1ja+6Plmw796d06AhdRr8Os34pq4N//o3wOoYKAxuXkK+lwkaHGv65Dw2czG4K2TPuvSkuyuaR2dm3teI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9aDP3qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9aDP3qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904611F000E9;
	Wed,  8 Jul 2026 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783504698;
	bh=RWwnnS6GeaolTc9bMDjJoioBxiXpdchd+xEqkloj854=;
	h=From:To:Cc:Subject:Date;
	b=h9aDP3qaagnR2LQYiES34wpJhH6BpLm1rDyCK1/kU+o2iPw9xoXYUyWD1pDFq+hFF
	 DtP3VWpsBT5QZ0eKeqQrZaLFSNVu8NLdBH/mBGbTtQY7w1JpzsntHQgqvWdvq1Nkah
	 HrmXFkyXFKhOq5l4NDjtwnJY4GZ16QVa/V6ZIdGuhwvBWTYUWAryOxWNTjXn9CHuhm
	 glJA1Fxh0YtkK/2CIRZ1OAkMgCDiU55aIZAYwg+ybMF6i6nL+LFEf2TyHhp6+jUOqp
	 SqBOae0AQ3tbOuSP8XiPXSQNum4YRitjWC0Ssp2EBpKRxKVzZ2IFmm/86Y3wNNqQ5k
	 VWXQ3kjKC9n2A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: aspeed: Switch to irq_domain_create_linear()
Date: Wed,  8 Jul 2026 11:58:14 +0200
Message-ID: <20260708095814.385480-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pcie-aspeed.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index 9aa9e14c6148..74b03a55643f 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -725,10 +725,10 @@ static int aspeed_pcie_init_irq_domain(struct aspeed_pcie *pcie)
 {
 	int ret;
 
-	pcie->intx_domain = irq_domain_add_linear(pcie->dev->of_node,
-						  PCI_NUM_INTX,
-						  &aspeed_intx_domain_ops,
-						  pcie);
+	pcie->intx_domain = irq_domain_create_linear(dev_fwnode(pcie->dev),
+						     PCI_NUM_INTX,
+						     &aspeed_intx_domain_ops,
+						     pcie);
 	if (!pcie->intx_domain) {
 		ret = dev_err_probe(pcie->dev, -ENOMEM,
 				    "failed to get INTx IRQ domain\n");
-- 
2.55.0

