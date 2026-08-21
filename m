Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B848EBC5;
	Fri, 21 Aug 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315306; cv=none; b=Avf2TFKGREkGxBIJsIlBuXYcEddiaSGkiKLW6i6tDrxd65zuwAiXQ6jdetiikAR7YL8/y4c3mgMmwEUOgzYWDzTvN5agNb6bgdDKF5kWaawScM08YVmsYZlKmkoyVwjQfCpLLZOBBuCcJyiyPGTWnBmMjA3OkusHYqX2AYLMe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315306; c=relaxed/simple;
	bh=fAluj3i5BGhCmNcz3pT7FH7h/WXIP9aqB0SGJICfyFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nhFQl8oPnvgR9FdjdMXNmbnvLuMdETPcB6FJsyU+PC8UvqDIn4SnZaQYisTsqWLSvd1o6CtaVweUEjWltQgnhDiM+EGP9IKnRqfi1cpYVD0EcHw5YKUGnQHXlmlm1kyo4JLTT48freb6pgCvpnM/LP8S2q+fPH16vBTL4C9SYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OqvkcGED; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MhmEoh+h; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OqvkcGED";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MhmEoh+h"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hRKN16d71zMlGH;
	Fri, 21 Aug 2026 14:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787315297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JOCKz6vPO82OZFPBoK6YiK1bVmbFlFNnDROZ9Nn17+w=;
	b=OqvkcGEDDXmzKUKcv0tSAEMtkPT4Tf6AvDSwsWllF4VM18TpOF/MFvH78SAMYuLdHiOT71
	gKI0tU9L5iGMgwwgE/kdaZb0yHN2PIshBwwvfFti89VsnInhQqbxZPVnzijjrkCpWm7H/f
	YwKHs95yTNbB9Eu7obAgTcwAbvE5fMtPiodI+AIh7jrfP5p22kD5eCA9TwxG9X1OULRN4a
	gJmioe3GypltVVIEGm5VT76eye4O8nw3Jieb0SiTNRU6roHot0SvI6cVceo/b1lE9hGi3t
	sIE60CJMYJ45eKvdlW5yszyjEsazrf3ytRBWSn6hAaaBuK5sviBKnApW4EhUkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787315296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JOCKz6vPO82OZFPBoK6YiK1bVmbFlFNnDROZ9Nn17+w=;
	b=MhmEoh+hez+sVbRLx0m9a90FNKtnK6ZgPVpD+d/BdPzaZmPjm9zv493IXFTx9MNHqUAhGH
	Wx4XUZdf+umeyn052Fe8SucE3jB2zkq8Secegj+hgZopcW7ciHp5TsT1b4Z81FBthnyFMg
	3WvXKyTW2Gmdyp26hxzZKsZdWRzNPwLXPoLcaDDF27fDIAcJJQ5Rf7zf4PKBbAbh02sP+t
	d5GkK3Uh6Emd7ij8ZUgWV2ofMdDsI9USE7Fm2atg+mj1c71HXC2Hv5yYFqWlxLMkWL9s9m
	xmjKjYfKUc0cWaH0d3vYdu39gGljFm1kJxMSHdSPduPnFyq54cpxV4fqtT1jDA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Koichiro Den <den@valinux.co.jp>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: dwc: Add .post_deinit counterpart to endpoint .pre_init callback
Date: Fri, 21 Aug 2026 14:27:49 +0200
Message-ID: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 469c63b69f73deb1a0f
X-MBO-RS-META: jxmusy9cjrt87yw9oruog5zs1bboyesj

If .pre_init() succeeds but subsequent initialization fails, it is
mandatory to correctly undo the hardware configuration which the
.pre_init() callback did. Intrododuce .post_deinit() callback to do
exactly that, undo what the .pre_init() callback did. Usually, that
means stop the clock, assert reset, and possibly program some registers
to quiescense the hardware. Invoke the .post_deinit() callback in
dw_pcie_ep_deinit() to retain functional symmetry.

Reviewed-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Koichiro Den <den@valinux.co.jp>
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
V3: - Update commit message slightly
    - Add RB/TB from Den-san
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

