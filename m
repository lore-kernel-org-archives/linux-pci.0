Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF812D876F;
	Wed, 22 Jul 2026 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699697; cv=none; b=Au9b2xJkGOmUY+HFkAbVn0ggKnY/EFENm3K+wULL2VcXLPbuyQwoKymcI8+Po+EMCLfVNq6HIRrPfyPh4CStVJ8pF9WWWhOVEfI34aLaU1oE5WY1bLuMLfTjgMhpMcNUbx7ZGOm8anD2pN5tyYEexpVsMlvu/2ahbs0iHV30kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699697; c=relaxed/simple;
	bh=8ISXVHhswyDJiLXbd9bq0w0gVpCRGbYE2cLAKgLPSUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hpge0HU67F/DuE2WbGiv/zZmTBGFW7yGsMh50xJd2PWyt7LoOAycQwvZTtlppWIkb+25txL9hpbhbRYL3Ck0iv7s4geKYzsJYNaFsUjU1/Yg7dvET4hQ6ZY0doK14QjT/D7uxXSmx+6MKiafA62hECkVoaIxVvvGahtxMymKYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXobRvag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXobRvag"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B729C2BCF7;
	Wed, 22 Jul 2026 05:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784699697;
	bh=8ISXVHhswyDJiLXbd9bq0w0gVpCRGbYE2cLAKgLPSUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IXobRvagSWXHg8OgG9asw/rKXt/J2+uIP9N++yjhwLuoQVQjbykDSYZd4bMtjI72L
	 nwUuR/7sG1eLYzCg2aPxlYUzimIy5tXA8+Uoj8z/7ejrp37N/G2fFLCgaZXboodK0q
	 h58TG5FkXQW8dKEb4GkG6BJ5raUZgQEWY5XavbogcrUOg+eldinlnSrBe3EjIKOv7y
	 vcGWy9Xoml/XtDcubW8Iuvm1s+5auvg8tMSx29AcE3XXG2+IVyTb+Ge+tJOVOpVXnZ
	 YC5yToZwqi0Fmr3eWcnbN3ctnHfDOjbUyPiOF+0p3mN/+X1a4s+Rfc6QPmY4iYCDVi
	 CrVVcVToa5DGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4960C44512;
	Wed, 22 Jul 2026 05:54:56 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 22 Jul 2026 07:54:45 +0200
Subject: [PATCH v3 2/3] bus: mhi: ep: Flush async transfers before
 notifying disconnect in mhi_ep_abort_transfer()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mhi-ep-flush-v3-2-d855e715264e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=yYP+ssCeYGN8h3YxfGvLUNdFi6kTstff2HKocV8IchA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqYFsuWs6hV/EA0gNZPq6G7FLIVAjdbHcNC87kr
 1+V7QAfQg6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCamBbLgAKCRBVnxHm/pHO
 9ep4B/9Z9JoR7B95Sl+cR/qb1BirNG2gugm/gIFZDehEC2drABtPwmU0hgh+/i/fl5mTF4Babmn
 00ljcznoLYLuKnRx+q0RBg4W7wxavypisjsdWVsZMm3OTRl37wDPrMset2twIWKXu2+tA7AUj/a
 zz0B7eJxVFgQt80Mc4p+4YN8I6b2rIqJG/p960ehVIGKPErfa77VqJfG+gFHn5qH1E4+imDcmuc
 VmG+Cn8RN5X9qsOJ0NNXAr3U6J4sYTzfSpqEG7YM3x8x87iPD/veYqRSgXLO7uRV1/5dA8JKkbt
 G9dUFWbs29pAoHd+uvHNCwd5V1BLADIcblyOrFTyJejD2Ew2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <mani@kernel.org>

mhi_ep_abort_transfer() notifies the client drivers about the channel
disconnect using -ENOTCONN and only then flushes the ring workqueue to
drain the in-flight transfers. But the async DMA transfers issued by the
ring workers can still complete after the notification. And the completion
handlers trigger the client xfer_cb() as long as it is set.

So a transfer completing during the flush can deliver a success callback to
the client even after it has been notified about the disconnect. This can
lead to UAF (Use-After-Free) issues as the client can free its per-transfer
resources in response to the -ENOTCONN notification and the trailing
success callback would then reference the freed resources.

So to fix this issue, disable all the channels first to prevent new
transfers and then drain both the ring workqueue and the in-flight async
transfers before notifying the disconnect. The completion and queue paths
bail out once the channel state is not MHI_CH_STATE_RUNNING, so disabling
the channels upfront makes sure that no new transfer sneaks in during the
drain and all the pending completions are delivered while xfer_cb() is
still valid.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bus/mhi/ep/main.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b94c571f01d8..51735f87017f 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1025,26 +1025,37 @@ static void mhi_ep_abort_transfer(struct mhi_ep_cntrl *mhi_cntrl)
 	struct mhi_ep_chan *mhi_chan;
 	int i;
 
-	/* Stop all the channels */
+	/* Disable all the channels to prevent new transfers */
+	for (i = 0; i < mhi_cntrl->max_chan; i++) {
+		mhi_chan = &mhi_cntrl->mhi_chan[i];
+		if (!mhi_chan->ring.started)
+			continue;
+
+		mutex_lock(&mhi_chan->lock);
+		mhi_chan->state = MHI_CH_STATE_DISABLED;
+		mutex_unlock(&mhi_chan->lock);
+	}
+
+	/* Drain ring workers and in-flight transfers before notifying disconnect */
+	flush_workqueue(mhi_cntrl->wq);
+	if (mhi_cntrl->flush_async)
+		mhi_cntrl->flush_async(mhi_cntrl);
+
+	/* Send channel disconnect status to client drivers */
 	for (i = 0; i < mhi_cntrl->max_chan; i++) {
 		mhi_chan = &mhi_cntrl->mhi_chan[i];
 		if (!mhi_chan->ring.started)
 			continue;
 
 		mutex_lock(&mhi_chan->lock);
-		/* Send channel disconnect status to client drivers */
 		if (mhi_chan->xfer_cb) {
 			result.transaction_status = -ENOTCONN;
 			result.bytes_xferd = 0;
 			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 		}
-
-		mhi_chan->state = MHI_CH_STATE_DISABLED;
 		mutex_unlock(&mhi_chan->lock);
 	}
 
-	flush_workqueue(mhi_cntrl->wq);
-
 	/* Destroy devices associated with all channels */
 	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_ep_destroy_device);
 

-- 
2.43.0


