Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDC2DF12F;
	Wed, 22 Jul 2026 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699697; cv=none; b=WHf/ZPwlgEsnoKz322b2dUWRD1jwHpI+UwqAl282r24xhh4hIUafipFcc/Wvpa2hCferA7Bc7HyXx766EJOvITHrUV4NmsD45LL8KyfE8cxl3LihuI7qlq5QRNTlXpgztY0r0rG8uT32RanNLwk35W4D0rekxXLH31QXSZE1G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699697; c=relaxed/simple;
	bh=9dEPT3RpH+LXlUxgzUAD8P8587PjPqNLki2jIn6r14s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ke512UTPTmz8lpWhV5YhEq1lJULdueIKU3DwPPUkokismhwlXqhhMHaWT+rk11NUThvyZaRFXqB9MuKQ3qXowIqvl2mFNZWV7W9ium9K1faVDCkRdVBYVxZtoywMbLog138o9Z2S0jYZwcztqlUVV/44XvNztZ4elmMhBcLa0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA4V31y9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA4V31y9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DBAEC2BD01;
	Wed, 22 Jul 2026 05:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784699697;
	bh=9dEPT3RpH+LXlUxgzUAD8P8587PjPqNLki2jIn6r14s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DA4V31y9Jni+rIc7pqc6bkpWwKvbGNXfrL5oPqvrT0u269k0m9QvXO8bl0lEXI2i7
	 /1Hn/o+XucLjAH5QKohPmzfMdiInj6untyiAwAgDztKPslT/2tAB6J4pViLhJ8Av7D
	 MjKrFpuQ2hezg/veAVG475HhmBubarQ9Wgq8LtiKR2+Wo5Cb4lN9gtZMAyHTXDKwHT
	 3pVhFFki0FHB2aS/fHBdMnNsXbhNKYSGPPLjhUfDt7u56hPjmW3kD21Jmk/HrIDrbm
	 vHKbVT2pK7cgzMk84WR8C8f1GdVf9onnGoR8fBghcVdZf3Agb6tAU3jVpfKa8r0BVV
	 mewt+yXeFY/kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F9C44538;
	Wed, 22 Jul 2026 05:54:57 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 22 Jul 2026 07:54:46 +0200
Subject: [PATCH v3 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async() to
 flush DMA read/write
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mhi-ep-flush-v3-3-d855e715264e@oss.qualcomm.com>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
In-Reply-To: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=qLqfbvmjnz3X26mpqAuThVFaSvP9MX15HVPTE+SgzCA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqYFsuC5PTByf4wCyyQefH6+dH7fRf88dhESowk
 g8bnZx4gV2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCamBbLgAKCRBVnxHm/pHO
 9fPIB/4tKg/A7Sh52QXah2k7JDw+eLTsYikqwlLXwhDPptp7RQX/qFLQ0DgVysZpfZcZckmyA5S
 6nk5qorgHBaBKqaxK11czAOEyCLCce/g3WU8L509g6PdgKAol0YiwIMHH9zzJ7b2f7RhDD8w/UE
 M3RxgU+XEGTL1eQ5t6BCrVQwHYFcHI3OBxVtWVCgmr/OveC5cBafP/aMBEJm/fWBLgE0X/8RX8m
 1HyCQqzKl5hMoqMOendaQvux0lpehBvwm3EJDuXfSKtuUqQ7wmTnKyqxKXYaReRxSChlkFfV3xu
 lcOSlcIn4g9ayftzxSN8PAH5hgasKJR+jImIlazUaMicwUJk
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <mani@kernel.org>

The MHI core needs to make sure that all the current DMA transactions are
completed before removing the channels. So implement the
mhi_cntrl->flush_async() callback by first making sure all the in-flight
DMA operations are completed and then flushing the DMA workqueue.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7f5326925ed5..8d2d9d01cfd2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -644,6 +644,15 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	return ret;
 }
 
+static void pci_epf_mhi_edma_flush_async(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+
+	dmaengine_synchronize(epf_mhi->dma_chan_rx);
+	dmaengine_synchronize(epf_mhi->dma_chan_tx);
+	flush_workqueue(epf_mhi->dma_wq);
+}
+
 struct epf_dma_filter {
 	struct device *dev;
 	u32 dma_mask;
@@ -812,6 +821,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
 		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
 		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
+		mhi_cntrl->flush_async = pci_epf_mhi_edma_flush_async;
 	}
 
 	/* Register the MHI EP controller */

-- 
2.43.0


