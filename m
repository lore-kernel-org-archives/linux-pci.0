Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055293CFF73;
	Wed, 22 Apr 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857113; cv=none; b=Ud6+9yjKjp23h7qU3vMKEMp/PR+2b8K/0u/IjqnDjbn4vG78SbrcdeYVhPrl+0MK4WkWoMG7rZSjPflkT4pE8mxGAbKRTob+Ju6h22Q2dkvyrr2Um0JzZBtrQV4+t0VL39kV+gmvWBEQLvbs4nNvehjvXpADbJ1dPQ/8ONincU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857113; c=relaxed/simple;
	bh=rahIK407Uf2DgR2AcY120luq+IbRKhapEgJAn9AFJa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCDgNc940WgnZdJFBNICDD36IitGo+/XJl4WuM8Aw4AbkJxD2Fqnfaa/UB3bZWJc1Gg6Ty7HfT0BkmJtxra3DebA7PNA8YLvRDIyJsKrDN7pvo5GvG3Us6eQWnxPtRSsIFXmgw/i+kZsb1q++ziLlxBSMZpf7HJJxsNML1ZIgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+5UYEQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+5UYEQH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7387C2BCC9;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776857112;
	bh=rahIK407Uf2DgR2AcY120luq+IbRKhapEgJAn9AFJa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N+5UYEQHoaK8Q60BrBtaMgSadbgDe6ZzQJa3IcQS1G0ZRPh5aqlpu3qrlSjwnRyJt
	 O9fHeuuOU+0Vy8j7Kn7rcd0HogXMbeiIWDnLJ1YG9j+FQkJNiPQfzfw4nR9W1ursUa
	 0TLMI5Mn78uB9stpSc9l/l3knuBFlU89TYotARX+zokGj4y48OT9RwNNJjVqCQ7vQ8
	 RrkFQXPmdWfI6mtHqGxqrJAatzw3eixCOA07NWlMNyyli27DtiC/GpHYi/nvUJB79T
	 1Sicwb1N+pSDOMSPRK340alro3Q10A22er/cgWoJleTl2O2V/5P6j34Mclb2RMcL7i
	 NnF4GO5dmru+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D4F5A8DE;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 22 Apr 2026 16:54:49 +0530
Subject: [PATCH 08/12] power: sequencing: pcie-m2: Create BT node based on
 the pci_device_id[] table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-pwrseq-m2-bt-v1-8-720d02545a64@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=gwqWztQ2vBGh5JXCHhwF7Sem2dA5HgVW+YJLGPrMk3w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp6LAVV9Sl4KSgjtyUczECqKLK18IZ+VW0DgOZs
 CMcQtapewqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaeiwFQAKCRBVnxHm/pHO
 9TCsB/9hzdnKbSX7cxGGZtqiNVW08cTyu3KNGCbmesZe7YNrw4yKGzcElM0lXYbtu/dJsmlXf9A
 x0EFRzFyajbrKsaURicDPjIpgJTJZHXx22YLxNWzq6PdW691FZrcfE4+rrzHJGVYdbVfpYmC+/u
 qSfzNvtYSds4KrzsJzhyaqTGNIlRjTRZnCpeRtSv4ZJzh3UHaknbS6UVOnwZs2t9ayrNdWZsZBn
 HLsYjjYItl2WX3mTShfTncKzSYONlWaQW8D0E4Av9j9hBWnb9KvpadcIAoCX7sHkqMUhJF3Apdy
 IzRryhYX9fMapEJrQVm0fkc1bSCN/dHq3DoD1cCK48p+RNz3
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Currently, pwrseq_pcie_m2_create_bt_node() hardcodes the BT compatible for
creating the devicetree node. But to allow adding support for more devices
in the future, create the BT node based on the pci_device_id[] table. The
BT compatible is passed using 'driver_data'.

Co-developed-by: Wei Deng <wei.deng@oss.qualcomm.com>
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index b21fcc089580..23dc91e2b128 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -193,14 +193,29 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	return PWRSEQ_NO_MATCH;
 }
 
+static const struct pci_device_id pwrseq_m2_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ } /* Sentinel */
+};
+
 static int pwrseq_pcie_m2_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
 					struct pwrseq_pci_dev *pci_dev,
-					struct device_node *parent)
+					struct device_node *parent,
+					struct pci_dev *pdev)
 {
+	const struct pci_device_id *id;
 	struct device *dev = ctx->dev;
+	const char *compatible;
 	struct device_node *np;
 	int ret;
 
+	id = pci_match_id(pwrseq_m2_pci_ids, pdev);
+	if (WARN_ON_ONCE(!id)) /* Shouldn't happen */
+		return -ENODEV;
+
+	compatible = (const char *)id->driver_data;
+
 	pci_dev->ocs = kzalloc_obj(*pci_dev->ocs);
 	if (!pci_dev->ocs)
 		return -ENOMEM;
@@ -214,7 +229,7 @@ static int pwrseq_pcie_m2_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
 		goto err_destroy_changeset;
 	}
 
-	ret = of_changeset_add_prop_string(pci_dev->ocs, np, "compatible", "qcom,wcn7850-bt");
+	ret = of_changeset_add_prop_string(pci_dev->ocs, np, "compatible", compatible);
 	if (ret) {
 		dev_err(dev, "Failed to add bluetooth compatible: %d\n", ret);
 		goto err_destroy_changeset;
@@ -289,13 +304,14 @@ static int __pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx,
 		goto err_free_pci_dev;
 	}
 
-	ret = pwrseq_pcie_m2_create_bt_node(ctx, pci_dev, serdev_parent);
+	ret = pwrseq_pcie_m2_create_bt_node(ctx, pci_dev, serdev_parent, pdev);
 	if (ret)
 		goto err_free_serdev;
 
 	ret = serdev_device_add(pci_dev->serdev);
 	if (ret) {
-		dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
+		dev_err(dev, "Failed to add serdev for PCI device (%s): %d\n",
+			pci_name(pdev), ret);
 		goto err_free_dt_node;
 	}
 
@@ -361,11 +377,6 @@ static void pwrseq_pcie_m2_remove_serdev(struct pwrseq_pcie_m2_ctx *ctx,
 	mutex_unlock(&ctx->list_lock);
 }
 
-static const struct pci_device_id pwrseq_m2_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107) },
-	{ } /* Sentinel */
-};
-
 static int pwrseq_pcie_m2_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {

-- 
2.51.0


