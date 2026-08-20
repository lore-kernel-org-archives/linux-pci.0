Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155511D5CFB;
	Thu, 20 Aug 2026 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787198403; cv=none; b=PrKALwtq4Z13goOzVjgeD76t2AUeJ6fiiDr/DXoNcrqqakeWWyru9HouuGEcu1lvuZ8po0lK21AB/NYWOOqMe490p8kLmNXih4HnFpexb418qzF//jNOAsl+eq136+Jq1NKBlIoz84ivVi4jPRGo+Wik8SJb8iKvm0B1ClDppyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787198403; c=relaxed/simple;
	bh=VQPnQaUtZFywgUu6nIJFuUhokcpVMCAbWYbh/7CC9eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPoB4nUvdKqqXEBWIbvpC54lsQ/hBQC9VhyUsYIJwAkN3MWHhOwMU0QZAU28LeSZePLeFTBL+kPmJe/gkRcFM0X9363+w2MA+CA1ehs8TNoJ4nAYz6mAWr3aFyWtYyJNCq4GqZ3MOuNd5OwW+qcW0lHbh7JtUCyWJUHZjQvexdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ydQpBB09; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xBwP0wMX; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ydQpBB09";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xBwP0wMX"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hQV7r3d6nzMlNf;
	Thu, 20 Aug 2026 05:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787198392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioar08OrLDf0jEtErVz90dfMY6h0ExmkNlaUxKgN2I4=;
	b=ydQpBB09JkSbZCmckI8Dzrc/65R4F56A1wz8vUIuysi+Aho41mFV9frvILR//EF8KXGzh1
	KF4dBzSiJFMWlcAm4LrTeEtlz5zahOcktPJO+PQrTFj0dPjSDVBn8eUr5+JMcchHxwzWmi
	OWEvy6oTpbfCV3s+WvT6+hTNzb0mxrA4YZleufjKRGfPM1ZpkPLr1Zvt21yPUm+xYEgVRu
	cfGLYaZ9k79bbwDqE8+RWqz+wppX4vXPCmMhfHO/oRJefGkwIfLiGLeGLJVXTOk1tSZdky
	0U3awuMog8YQcE9+5x0ck0R+fzBwWDKeNB/jGODRGi7W8QDkOFts/VUoOnJLOA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787198390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioar08OrLDf0jEtErVz90dfMY6h0ExmkNlaUxKgN2I4=;
	b=xBwP0wMXhPglNGhthINIPmFUkyn+0TDQE1SWdmofacj35DC726XtBWii1MwgWUdlULDUEU
	lRQvZhZhnLRkzAcIvkxAevKcqO12I6C/GvUpUmcVnXek6+1coVipqikxls9Ac+ZfSvO3WM
	+iIXoT3347U3sDcaTQMeRBwWiQFOV243rAGDQZmuzBQ3vRy+4QgZZYuUK8Ku/8wNyqa7Pk
	XiguO1NoS8tLg2lh+OvUM3bBQSn9DCS+TTNDpM0oH7pEiuMqhfWygtefPstdP1RkjhvJyL
	BUSybA9+GeMrvHLvv1wrZTOw+mq1NdLyiHaWe7WdlwBujoh+xio27GuVXrnvuQ==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: dwc: Add .post_deinit counterpart to endpoint .pre_init callback
Date: Thu, 20 Aug 2026 05:57:55 +0200
Message-ID: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 379092dd772b72f54e4
X-MBO-RS-META: xq9uf6tugq8z73hdhg9jbmaw9rbfsjsj

In case the .pre_init() callback fails, it is mandatory to correctly
undo the hardware configuration which the .pre_init() callback did.
Intrododuce .post_deinit() callback to do exactly that, undo what
the .pre_init() callback did. Usually, that means stop the clock,
assert reset, and possibly program some registers to quiescense the
hardware. Invoke the .post_deinit() callback in dw_pcie_ep_deinit()
to retain functional symmetry.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: New patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 +++++++-
 drivers/pci/controller/dwc/pcie-designware.h    | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de8ee3db43601..1a3491b5003ec 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1194,6 +1194,9 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 			      epc->mem->window.page_size);
 
 	pci_epc_mem_exit(epc);
+
+	if (ep->ops->post_deinit)
+		ep->ops->post_deinit(ep);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
@@ -1553,7 +1556,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 			       ep->page_size);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize address space\n");
-		return ret;
+		goto err_deinit;
 	}
 
 	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
@@ -1568,6 +1571,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 err_exit_epc_mem:
 	pci_epc_mem_exit(epc);
+err_deinit:
+	if (ep->ops->post_deinit)
+		ep->ops->post_deinit(ep);
 
 	return ret;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae9409240..a53ac27cd2447 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -475,6 +475,7 @@ struct dw_pcie_rp {
 
 struct dw_pcie_ep_ops {
 	int	(*pre_init)(struct dw_pcie_ep *ep);
+	void	(*post_deinit)(struct dw_pcie_ep *ep);
 	int	(*init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     unsigned int type, u16 interrupt_num);
-- 
2.53.0

