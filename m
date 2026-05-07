Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9504508F2;
	Thu,  7 May 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169978; cv=none; b=dayUQaHH2AcMD2FeDTt2QtEoLK+WIDKFvQdVpDnkvIzhl0VAz8fK57qWrNVfG7g61mGeaoSdd7aO2Zeu0We6tF3utbzuEXjB9wbWc34pr6wZ894fIkjF9yvHqBSbNHtydT2uFdPww2yxNEoFx+/Lzs/yt5XKjEc5DFQvT9wmb4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169978; c=relaxed/simple;
	bh=aNhmryQKE395W4APYigHylzo2/j+j50biYPcg5iB8Ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9enl6YdhPCDOWsQVpVc9Tsa4Y2Onz9ewkPAXYVZCcu22IxQEoTqlj3JQFCUg4HpcwuMneTRGsVjpMmiKRK+rt/QmY94RmQicIp/+G6lF3dYApOcj80Pla4hmTRb+eL7N5eFS0TXXLPQnGhuSE99lvRWvwdU4bco17crAWqSvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGykYgPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGykYgPG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8353AC2BCB2;
	Thu,  7 May 2026 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169978;
	bh=aNhmryQKE395W4APYigHylzo2/j+j50biYPcg5iB8Ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qGykYgPGQ1F1vJkiDVZ3m6JEZ0OwWb8W/escRi1aoONHoqCqMOKzkPISI9Xzx4NNH
	 WuF1ZUBTdm/hbeym2W+xTHSab9HhSCibBnV/jHS2mz0/Ujxa7RdByDskZev4h3r7qH
	 hDrl0e/tfm4XPgBMBb3M8zTrOguTmDAOG7FQoU11kPkGtpCMb4GTPIM6w2OVgDCZPB
	 CxC07yCUm4lZp1NxtfuIxSedoTEnIon4xX8zN40h6WMliuq5PNN1j4Is1EhhA0k/M3
	 EZFzrYOsngYvlSmet6uroOUIedNnaYNwK7O+wduZJX0p6JCmpWKilPjWjO5Wua+c44
	 FSO3IZrZSWpkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2FDCD3442;
	Thu,  7 May 2026 16:06:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 07 May 2026 21:36:17 +0530
Subject: [PATCH v2 9/9] Bluetooth: hci_qca: Set 'bt_en_available' based on
 W_DISABLE2# presence in M.2 connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-pwrseq-m2-bt-v2-9-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
In-Reply-To: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=kT/daCATvUeblQjstk/xz8aGuQ4+x8sVK/KhZTDC6as=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp/Lh3qBHbqcZIzl+5YqO+PrOKii2iHINB9NljG
 TRznrWuJaGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCafy4dwAKCRBVnxHm/pHO
 9dQAB/9HaNIKcu7vecDN+DH8+r+PzhQyxhZlVjgokj6XPnBAtQXxdPZn699QwTXKoypwr4XcS65
 2J+gS2k8DRc3GVP3nADCvi0rLacpymyyucsPKiAmZGVXOn24XH6YDzhoO3ki4OUyfsb+D7D7GbR
 E2e8KpXCaVg94siJVNbfD9z+U6fyUEQvJ3G5vG0+DN4wcNxD9huMPcL74NCw+6eYjfy7Pwyo2VI
 6hf6age9p8eUQ+OriJXToL6Dt0nQjzSBbVUNpnMCKZc7CgCgbSQfGRJZw1ZeAy62ADFx7cgdm9i
 2yfrUrQ9Mfhm29bBqDTYgAHGqMWqkxmqF7A5IFBI/YzDbZUK
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Check if the M.2 connector supports the W_DISABLE2# property or not by
querying the pwrseq provider's DT node. If not available, then set
'bt_en_available' flag to 'false'. This flag is used to set the
HCI_QUIRK_NON_PERSISTENT_SETUP HCI quirk, which informs the HCI layer
whether the shutdown() callback for the device can be triggered or not.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3e71a72ea7c7..b5439b9956cf 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2449,10 +2449,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		 * the M.2 Key E connector.
 		 */
 		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			struct device *dev;
+
 			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
 								   "uart");
 			if (IS_ERR(qcadev->bt_power->pwrseq))
 				return PTR_ERR(qcadev->bt_power->pwrseq);
+
+			dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
+			if (!device_property_present(dev, "w-disable2-gpios"))
+				bt_en_available = false;
+
 			break;
 		}
 

-- 
2.51.0


