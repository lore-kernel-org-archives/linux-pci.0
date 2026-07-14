Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC283932EA;
	Tue, 14 Jul 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030938; cv=none; b=moQe7otc2H7O65jluY1N3do4M2v2OUxcyxReQvIYh9njA13+iHLbGHXY/8/gksMN1L8/Ou2ahGOkv7NWiAOAhZIl51z/RHv8P7JsdPt7GzKNIkeHjXplQ9BlakScIKLNBNGbbZ6XfrY4vGOR9HaxDu52bMS4znnkTNdkJyldG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030938; c=relaxed/simple;
	bh=gXZ0kfWQwe20nG1CyMHlfe7DegLPDEYaIMsWcXHUCCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFgqCR4FLMnIl71VvBuzUdoIby484lo4SrNS7wR9zAYJoevfyBr2piilznpDnDTju3wiKfEO/fRMqk1xK9TWCGSCN5Ti4czlSpGsDLy9jF7Ciqrmtngrnc7e4k929+W2aOZngbjtwhnspZBH/kedzIcMgA52Bv6OJmkp+57hHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108BE1F00A3A;
	Tue, 14 Jul 2026 12:08:52 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 14:08:32 +0200
Subject: [PATCH v2 1/3] dmaengine: dw-edma: Implement device_synchronize()
 callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-mhi-ep-flush-v2-1-b6a9db011e85@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=gXZ0kfWQwe20nG1CyMHlfe7DegLPDEYaIMsWcXHUCCA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqVibPBpXj3VkynQpUy6PTp0/uEgS3iefzI+E4d
 x62q/7AWguJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCalYmzwAKCRBVnxHm/pHO
 9QQiCACjXyf+XO2z4Fc9k5RWTLCDxaeOgk4G2fvKMPu/BNLT/2UqYH+r+2kt4A5+h57xna8XUkZ
 6XooahzqatkOFcvjOeBIwOD7LNA1oStZP03kNlIadMutRYehD6mwf94Jsj89B7aLo7IRkVTairO
 3Y5yGCVYu9C9DDHc0vnrew76+SeHUeQ21/8y8NkTj6p1gUUCjITqytm+eL6p4WXdFT1ERiPYOEz
 3cAdVF6MKOK2pfLQOhKQa2bWMxDIq7DkAuW4eM5zNPshR5jHftS2p7cRikkXUMx9ckmKiB/lOaB
 lFw5n/S3Sc3QAXPOG8VETxuKMaPd7+QSOGOlpJJNwYuzXzEU
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

device_synchronize() callback is required by the client drivers to ensure
all the DMA operations are completed so that they can free the memory
associated with the complete callbacks.

So implement this callback by first making sure that all the in-flight DMA
operations are completed and then call vchan_synchronize() to drain the
DMA tasklet.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79f..df0d1a946ed0 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/dma/edma.h>
 #include <linux/dma-mapping.h>
@@ -331,6 +332,20 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 	return err;
 }
 
+static void dw_edma_device_synchronize(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+
+	/*
+	 * Make sure all the in-flight DMA operations are completed before
+	 * draining the tasklet using vchan_synchronize().
+	 */
+	read_poll_timeout(READ_ONCE, chan->status, chan->status != EDMA_ST_BUSY,
+			  10, 0, false, chan->status);
+
+	vchan_synchronize(&chan->vc);
+}
+
 static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -968,6 +983,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_pause = dw_edma_device_pause;
 	dma->device_resume = dw_edma_device_resume;
 	dma->device_terminate_all = dw_edma_device_terminate_all;
+	dma->device_synchronize = dw_edma_device_synchronize;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
 	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;

-- 
2.43.0

