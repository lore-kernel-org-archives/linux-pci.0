Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0339B94A;
	Tue, 14 Jul 2026 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030947; cv=none; b=fkTuEeHB/uAIZMZnEXneQqFVZIqsN3nm3NesEQNNIb4CZE4I5pI8h9JNz/6RuzrNoTrWM+5c+KnBsO8CAi128LUnkX40PWY9C5z+2ZcsvenqwNUMevXPK3MEY/ge6iNPkLGNSGjDsrVj5RfNtXOz7CfSUjmiwgxW5aZuwpCb+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030947; c=relaxed/simple;
	bh=qLqfbvmjnz3X26mpqAuThVFaSvP9MX15HVPTE+SgzCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/h95vM2+IENwcqoyltaV9ORI6e5bBkWbgArqEUhqUHgpucElJZAR0hfVscreuvnPpKSbANIOiLPwuh7pnshVBiHUo6l2WnMg8Zn4ap/vNSQSHud0g0GA19o90lgGKBqG/RrbAEw7yMbGJjHHsygcYtJzeAOFVZmtip7jrMY4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C591F00A3D;
	Tue, 14 Jul 2026 12:09:01 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 14:08:34 +0200
Subject: [PATCH v2 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async() to
 flush DMA read/write
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-mhi-ep-flush-v2-3-b6a9db011e85@oss.qualcomm.com>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
In-Reply-To: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=qLqfbvmjnz3X26mpqAuThVFaSvP9MX15HVPTE+SgzCA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqVibQ2+h95kLAUBf3P96wpgqFqfpDTkUbjFhHE
 VtyFhIMHseJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCalYm0AAKCRBVnxHm/pHO
 9UnGCACadmnTY70mIwm6+exLoH0fGJYpDVbVCCp7NakpdS92kPSOsLqqaEzBwUfko/ThMdMYGOG
 H9gR0WkTaMQI5au0WodS8dRH2+OdbGgSQC2PBTDOQjOO40tDVi8myEQB2xdJ+P42WFGWSBxR8iB
 HeSbDPPh1dSjvB/DgOQ5EBqHwX8zvzCaJHbaXt7ceA+fXPhHXjQ1ikb72syU0dL53FUJv0VRS0p
 PiMJ08NR9PGufghFwUie17+KZhSJQfGBQCGG69++sA7b2QRwY7KTXuSE+33WNtgzSy93Z+DS5o9
 QumRNRBEfMdIRDWyMbXtE7bbRSuCbhyAZijVCuKBnO8OJqSv
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

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

