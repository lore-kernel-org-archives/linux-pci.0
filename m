Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597D3CFF77;
	Wed, 22 Apr 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857113; cv=none; b=X0cEQNtpKtktMEvzUqUgq57J6+iJOo0dsgQWorwhadrO0p6dYBjpgprRZ04cto9dHnisCq6chwh7P9Jgmj9qAxiYiuv/8mOQ7tNodoBy4NPhMku9e7F2a5+S30QT0HSykNRO6xXi+GdAdg5TPsZ68uFL+zl02DSoFgDcw4ox/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857113; c=relaxed/simple;
	bh=wNTq8bfKOhZVwTEppK+NyCHIphFCJQ60hjAPS6sIl0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sK4ewD1KMP7Qi0ODLbfNdd9aBuKv8IgNiaFhtV7EYaqClVdVD0VF/59jwZeqRPKrTytdFcA5cXh9CldSEfjlXfFc6uplllRADF+WgkrylU0TN0JaieikN7NC8lks6dyqDG2Z3Q67QpcW8KFLXYclkfDM9NA9i2JE6YuLphpKWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ/KR+Ed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ/KR+Ed"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC2CFC2BCFB;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776857112;
	bh=wNTq8bfKOhZVwTEppK+NyCHIphFCJQ60hjAPS6sIl0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hZ/KR+EdTgCtvzftOXnka8ufdsQ8E0d3oClRZ/Fu1CJFxzKmrUiozfHvC1Vz0unWC
	 Lwsae1hnpOxouAdT7+gnLgHyzM0piV2MTbvxWoL6ENaMsPfYpVp4LdtgDsfDbFqwnj
	 Nxt/IrPHT2Xh4ELBiCa8AWfgHC/6JKw930ngulS8bIYPiH2+dRAtmn9ugZBt7n8myh
	 5ijgyTlqAkqOEFZL8yYkxhF9jCc7dR6+7S00S8DWw7Vu8U9imJ2L+VSmY2QF0onzwZ
	 /r0Q2L2TK6VtoukZVOeYXOQtvpx5cvytqLyy4xgA4oYtZE93fcyKF1oNkKFfrdVy2s
	 BajDzqnA0JHjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B291BF55811;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 22 Apr 2026 16:54:47 +0530
Subject: [PATCH 06/12] power: sequencing: pcie-m2: Improve PCI device ID
 check
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-pwrseq-m2-bt-v1-6-720d02545a64@oss.qualcomm.com>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
In-Reply-To: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=9jfNJVU1vG/IbMKLhPiGnv2Pu5DaJsF1czYa74dvxC8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp6LAVzU48uaYh+mvxiCOrWmi+W6DA8++Z7TQUW
 F9ykItrraeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaeiwFQAKCRBVnxHm/pHO
 9TMTB/4wjc06WrFlO67nknTrUbRTVk22SzZRLP0y7hGCxhH2bcDY6dP53eBF6VnVyrYlOky26w3
 yDu/gudrLaly4zkvZJe4XB4R99+Z7MCtkznFzIhDIOWQoJoPtkonDP3Y6rTakg2Qul482SxWzCI
 4t3roP9/VioL73rX5GfPrf3jZcDoigkdUoShVh9GcQvdZexO9jbFFUjfktKoHZf3sRmyUYmHg3F
 xtBhWGhJeSP+a1t8rTNSS+P/IY+jI8arIwGIvC1F800X13qyXmv4nQDy4nu45kA7vWaOJ4VOQIs
 SPTfTcGs4LrHANnvsVd71jPZX8d+ATtyTDy6g8jiHOLb17M7
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Instead of hardcoding the PCI device check, use pci_match_id() to check for
the known IDs using the pwrseq_m2_pci_ids[] array.

This makes adding support for new devices easier.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index d4d246a30a97..bdc4391c87c9 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -351,6 +351,11 @@ static void pwrseq_pcie_m2_remove_serdev(struct pwrseq_pcie_m2_ctx *ctx,
 	mutex_unlock(&ctx->list_lock);
 }
 
+static const struct pci_device_id pwrseq_m2_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107) },
+	{ } /* Sentinel */
+};
+
 static int pwrseq_pcie_m2_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
@@ -370,16 +375,14 @@ static int pwrseq_pcie_m2_notify(struct notifier_block *nb, unsigned long action
 
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
-		/* Create serdev device for WCN7850 */
-		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
+		if (pci_match_id(pwrseq_m2_pci_ids, pdev)) {
 			ret = pwrseq_pcie_m2_create_serdev(ctx, pdev);
 			if (ret)
 				return notifier_from_errno(ret);
 		}
 		break;
 	case BUS_NOTIFY_REMOVED_DEVICE:
-		/* Destroy serdev device for WCN7850 */
-		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107)
+		if (pci_match_id(pwrseq_m2_pci_ids, pdev))
 			pwrseq_pcie_m2_remove_serdev(ctx, pdev);
 
 		break;

-- 
2.51.0


