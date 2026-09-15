Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53F3B5314;
	Tue, 15 Sep 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482262; cv=none; b=tg4+ofXhF6mzMYAkNx2tmwSukk0OlOF0zW9y17dFwu+/2e4BNDbca+pDQrf9tNgW0JQqvfcYWHS9bx3Y6zgsuBTqIcuKnxrsfc3eX9+fTkURosFqCGq1qckWHVArsXPxLyMJanQlpeiX6wafm6sG72MWzokXQsrgKbcY1Xep8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482262; c=relaxed/simple;
	bh=ebDqYY4U9FVWlZxckUTVJvTup8qiCi+YooN49jm+VUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcvfryLtSKKI8EuQ44Rg3l6X3mkCHmlj5sHkHXgaFMjHjaw5hT6gvQVkj7fKhIvuz5fRoSF+DtuiGn4OVrhJRI2xnamljT8IvNGs6c8fkxRA4R9FQJYdw9j53Ms+FHBwQPI1lJ6ar7GNPmUX9DViZwMLTEQg5c5zUv0Dn3CxArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoSxpRDj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoSxpRDj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C6E5C2BD05;
	Tue, 15 Sep 2026 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789482262;
	bh=ebDqYY4U9FVWlZxckUTVJvTup8qiCi+YooN49jm+VUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LoSxpRDjYddJV0ZD7sucgELhV123tPEU5jN9AkoLM2hnytdslTz0U6V5UiPyzzWMF
	 4HJz7ZEfPdJaQblN97CgRlzwz/S11BsK4lISXrGSl0tPDvKQOHkE28tcJtaUHRhr/0
	 mSMHOkud4EW/BncTi19wmxFx9MUn1S99OEsSD+sLFpDSH4nFqeu73lJsk6aFhLxBCg
	 2zFR+GebFLUcMWjHfT9Nh05kFyNQjdwrk/1z+VIVLQhufXREqMkNEkeboHNldxCGoc
	 j4mQIejUOF8P3vyeYJVJRqgW1bROvFbd1+40MEu0TvFtz6jW+3oVAf8BU9aeaI5NNd
	 pnlQudZX3XEJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A9C982C4;
	Tue, 15 Sep 2026 14:24:22 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 15 Sep 2026 16:24:06 +0200
Subject: [PATCH 5/5] Bluetooth: btnxpuart: Drop serdev based M.2 power
 sequencing code
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-pci-m2-bt-rework-v1-5-3c7d9cf9c010@oss.qualcomm.com>
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
In-Reply-To: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
 Neeraj Kale <neeraj.sanjaykale@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, Rahul Samana <rahul.samana@oss.qualcomm.com>, 
 Wei Deng <wei.deng@oss.qualcomm.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=+YzVex5t/UFDNNH6FtEmazomhrj+PormXoK6KhBhZYo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqqVUTH7YYitnfHOUyQSnpkRPlZLBO68tqUNH23
 AuTotDAoamJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaqlVEwAKCRBVnxHm/pHO
 9QuzCACee6+MFgwP7AqcyjVGPJ49iNhWnNA/QQBP5XWHvZIRUwkSM9nGmJOKCNtA6/Rt5EbBtJS
 QjXcjGxZZGH+a/wVnKK3hj/HYljm3l32CScy14+i8qa6htukWCXBA/F215lEJ/IjrTYEp7X7+RJ
 TJGqOFj1oDtT44KMkBhXxcnxlucOpaXC/9rg9pvFIpaehY6LwshJdkFRHd1wHMXl1vzjtQ6hcj8
 6NxYgrSMZFhX+cIkd5tusO4VcLBJsyZrxLuiY5Q+8oievV4bU5OzMSLOiZbt/gaOrxxT9TA6IQZ
 5KoARp+qth/nE6Gd3c4jr4S9I6cYoIa5UIJKbm3A4dnTKq7v
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Bluetooth interface in M.2 modules is now enumerated using an auxiliary
device instead of serdev. The power sequencing driver now allocates an
auxiliary device for the Bluetooth interface whenever a compatible
M.2 module shows up over PCIe. And the auxiliary device gets bind to this
btnxpuart driver using the existing auxiliary driver matching logic.

Earlier the same modules were brought up by fabricating a bluetooth
node under the UART controller, so that the serdev bus matched this
driver, and nxp_serdev_probe grabbed the "uart" sequencer when the M.2
connector was reachable over the OF graph. That node is no longer
created, so the serdev driver never binds for an M.2 module.

Hence, remove the connector helper and the serdev power sequencing code.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bluetooth/btnxpuart.c | 48 +------------------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 2672e481ef15..eaa82cc6444f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -10,7 +10,6 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/serdev.h>
 #include <linux/of.h>
-#include <linux/of_graph.h>
 #include <linux/pwrseq/consumer.h>
 #include <linux/pwrseq/pcie-m2-bt.h>
 #include <linux/skbuff.h>
@@ -1820,28 +1819,6 @@ static void nxp_coredump_notify(struct hci_dev *hdev, int state)
 	kobject_uevent_env(&serdev->dev.kobj, KOBJ_CHANGE, envp);
 }
 
-/*
- * Check if the remote M.2 connector device linked via OF graph is present
- * and available. This is used to determine whether the pwrseq path should
- * be taken. When the remote connector node is disabled (e.g., by a DT
- * overlay switching from PCIe WiFi to SDIO WiFi), the pwrseq path is
- * skipped, allowing the BT driver to use a direct bluetooth child node
- * instead.
- */
-static bool nxp_m2_connector_is_available(struct device *dev)
-{
-	struct device_node *ep __free(device_node) =
-		of_graph_get_next_endpoint(dev_of_node(dev), NULL);
-
-	if (!ep)
-		return false;
-
-	struct device_node *remote __free(device_node) =
-		of_graph_get_remote_port_parent(ep);
-
-	return remote && of_device_is_available(remote);
-}
-
 static int nxp_register_dev(struct btnxpuart_dev *nxpdev)
 {
 	struct serdev_device *serdev = nxpdev->serdev;
@@ -1962,30 +1939,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
-	if (nxp_m2_connector_is_available(&serdev->ctrl->dev)) {
-		struct pwrseq_desc *pwrseq;
-
-		pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
-		if (IS_ERR(pwrseq))
-			return dev_err_probe(&serdev->dev, PTR_ERR(pwrseq),
-					     "failed to get pwrseq\n");
-
-		nxpdev->pwrseq = pwrseq;
-		err = pwrseq_enable(pwrseq);
-		if (err)
-			goto err_pwrseq_put;
-	}
-
-	err = nxp_register_dev(nxpdev);
-	if (err)
-		goto err_pwrseq_put;
-
-	return 0;
-
-err_pwrseq_put:
-	if (nxpdev->pwrseq)
-		pwrseq_put(nxpdev->pwrseq);
-	return err;
+	return nxp_register_dev(nxpdev);
 }
 
 static void __nxp_remove(struct btnxpuart_dev *nxpdev)

-- 
2.43.0


