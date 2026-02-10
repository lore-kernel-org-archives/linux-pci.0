Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19532D0CC
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747175; cv=none; b=KFZgokJRvBOafkN3Gq9f96f6HcSwI5JYPrpKlulb6lesv7G+1ExF7pSGjCnC/wB14pOgyvwI1zHwNXSdbXRU5rkgeYb2tvnFihEdAC62FOpt6Dmi6u6c6sj6af4JnjM6PV5NrX7Mt0dMHRJ4XQn+3LCCj8AHoQRRfBr4yCQHhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747175; c=relaxed/simple;
	bh=NqXhpkLmHxy/mPRBnrbNBV0OuuxfDuYPJUyfMqCPueU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZVcERafpcjHGD3rHrZR76PErIarAbB7f2/M8VO4bMdN6A7ADEBzRetCHVFQlmGUgvyFNLbB+YOOFgjJO2/TjtIJCSrqWKK0APcuIoITWby9HoJ1CrZv2pHrxCAq7dCefHf3s5ZNXZaHmOA+MwEfjFHmpE75AtyizOmAoAcXQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgm1HRg/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgm1HRg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2766C19424;
	Tue, 10 Feb 2026 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770747174;
	bh=NqXhpkLmHxy/mPRBnrbNBV0OuuxfDuYPJUyfMqCPueU=;
	h=From:To:Cc:Subject:Date:From;
	b=Dgm1HRg/J/6YDsudEYi+uPpKPonyyBPsYAQSGuQvai22QRNOvIhxA+AUGS1HgczGU
	 EwTD1BeXVZN+F5IuCKEjKJJRFEVR/30N1zibdar8MAnLr3u80Ezzo3wEp++OKDY8XS
	 h/Ok+ZDUj2YgDp5GZF4FkElDIn6PQvnAzgyDWFbmDSFm3DIqpKiKNjgoGXzRiBLRxi
	 6jtKQ+3BRO01ipVC0fa4T5h9xl7zhlKH9Vp0Zk05ODa57zMMjU5mgG6q5hbaErCQxL
	 xIuBS5ly/uGVbkTdFFfGuO8cFOFUryoOuchg50NAWxLqGapnC3HfSOgM5drKl76q2Q
	 H5OUWQ70byHnQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Fix regression in dw_pcie_ep_raise_msi_irq()
Date: Tue, 10 Feb 2026 19:12:25 +0100
Message-ID: <20260210181225.3926165-2-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3124; i=cassel@kernel.org; h=from:subject; bh=NqXhpkLmHxy/mPRBnrbNBV0OuuxfDuYPJUyfMqCPueU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK7SzmnbhT5yf+44+TMWI/tK5bcn/+U5XX2i4/rA0MPO 7s95flt11HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJ8Fcx/M9U2MKw8GNx2/V5 t+RvfJ+2SiaXY4JTwfYVnxM3f/V/6BrHyLBt+ql0s1r9o1P4g06vCTq9WlRE1SQtK/b9/M79y3S eb+IHAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When using the nvmet-pci-epf EPF driver, and starting the EP before
starting a host with UEFI, the UEFI performs NVMe commands e.g.
Identify Controller, to get the name of the controller.

nvmet-pci-epf will post the CQE (completion queue entry) to the Admin
Completion Queue, and then raise an IRQ (using
dw_pcie_ep_raise_msi_irq()).

Once the host boots Linux, we will see a WARN_ON_ONCE() from
dw_pcie_ep_raise_msi_irq(), and then the booting of the host hangs,
because it never gets an IRQ when loading the nvme driver.

The reason is that the MSI target address used by UEFI and Linux might
be different, which will cause dw_pcie_ep_raise_msi_irq() to simply
return -EINVAL.

This was working before commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
outbound iATU mapping"), so this is a regression.

Also, remove the warning, as we cannot know if there are operations in
flight or not, so it seems wrong to print this warning unconditionally
at every boot when e.g. nvmet-pci-epf is used with a host with UEFI.

Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..5d8024d5e5c6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -896,6 +896,19 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	 * supported, so we avoid reprogramming the region on every MSI,
 	 * specifically unmapping immediately after writel().
 	 */
+	if (ep->msi_iatu_mapped && (ep->msi_msg_addr != msg_addr ||
+				    ep->msi_map_size != map_size)) {
+		/*
+		 * The host changed the MSI target address or the required
+		 * mapping size changed. Reprogramming the iATU when there are
+		 * operations in flight is unsafe on this controller. However,
+		 * there is no unified way to check if we have operations in
+		 * flight, thus we don't know if we should WARN() or not.
+		 */
+		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = false;
+	}
+
 	if (!ep->msi_iatu_mapped) {
 		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
 					  ep->msi_mem_phys, msg_addr,
@@ -906,15 +919,6 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		ep->msi_iatu_mapped = true;
 		ep->msi_msg_addr = msg_addr;
 		ep->msi_map_size = map_size;
-	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
-				ep->msi_map_size != map_size)) {
-		/*
-		 * The host changed the MSI target address or the required
-		 * mapping size changed. Reprogramming the iATU at runtime is
-		 * unsafe on this controller, so bail out instead of trying to
-		 * update the existing region.
-		 */
-		return -EINVAL;
 	}
 
 	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);

base-commit: 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c
-- 
2.53.0

