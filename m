Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539D44DB63;
	Thu,  7 May 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169978; cv=none; b=BOLQqz1XPtDBDFfQIj5IMqXiLMzQtXmEanHeDUaZSOytW9JDwScxIW9fr2Nv3V7YTkahpeeo17slgodGTODUM6TqOxpr01sl4QyYfgCbPajsS/995IIn2JydXGykCb+sY+ipOX1MOk+e0JZAwYG+Ig66NJ5RTQd/Rv3B5XtN9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169978; c=relaxed/simple;
	bh=K5lKxcKH4fmRhknhlE5axpq22XQnDH4mLawgXRhcu38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CaGpikloifwIbrD4cfWGi4fH6m+8llFpItQi7RGis7S/VKvdK4d5nkhCbz94atNwr9ziHfc3OoG+fZJU6YVt4XKMF8hzW4xkjsyLW1jynheix3wu+6UyWfcU0twWDiEs0OfcJHwrXKvN0Wf3J+zxaEhOBP6+VDrT8hEakGgKcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U//BkpTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U//BkpTN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50529C2BCC4;
	Thu,  7 May 2026 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169978;
	bh=K5lKxcKH4fmRhknhlE5axpq22XQnDH4mLawgXRhcu38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U//BkpTNb4VyAw2ZImn+1pGS+RsafjIPYwqZPhJ0Jweb1c37/h4JgAhantULDaiOS
	 DrsmVNUqTdG0Mv1UlbjulxyGTMYuMJIVEFgwPcrxCC8fPjc4FPzvzgNAvxRqLXQQLf
	 79QZEAiq0Mt/UAZSbyCioMzSRjVlxdDayWnORbnYutXd7VRQQ12bhmJXAcWsOBbG8Y
	 peVObaIap+eaytF/v9o2u29vdhFRuABVqI8etG/Cle9KpxeYhsn7T1eAt06mYweUSE
	 SFZhUkgM9u3UckJTtZlTrGHj/pw2iIKSydHlwCxUebzzgI7LGc4ao5fP9DFkvIu7l1
	 SPNHvs17bYJgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49207CD3442;
	Thu,  7 May 2026 16:06:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 07 May 2026 21:36:14 +0530
Subject: [PATCH v2 6/9] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-pwrseq-m2-bt-v2-6-1740bd478539@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=IvZ9CIq//p0HdqR9ryzttaoiBLfV1zSyMeR7RNa/KYI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp/Lh3/yNB+NsR8etCxiPVXy5R8wdmBIwBzwR2x
 TgElyscP1mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCafy4dwAKCRBVnxHm/pHO
 9Xu2B/9xt6sFExZbI2SblITHoNVnKQOz1ua7YHC/biIJgmPcV1nLazK2H/1bpFfwZvPsBwMVHjY
 Eh8+0b3c9eIP1fmRcoLuAIL7nahCNE8H1itohGdhjYxoqMOYrVUilw9fXzRiggM8OTYSdKvI0n4
 YEVrM8XWSJ0So63GVk/JU2quPE5Woy3rjiONApOjH4FcLgSpctKPlqFkGqsgqr8RSsN4Jo5U3Mg
 2upVXxEcg/Vu/Tu2lacdvOviSLjHR2WEm2cCG2nDpCCyYlVg3S6BRTO23KGVRlCv0D/30NmfLXx
 PZk3xUiYcymv6WhGsdeX9VGRqO3Nh7MeFtccs8qHE0UfbuX7
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index cd1834246b47..c83fe72bc549 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -26,6 +26,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2443,6 +2444,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+		/*
+		 * OF graph link is only present for BT devices attached through
+		 * the M.2 Key E connector.
+		 */
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								   "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the

-- 
2.51.0


