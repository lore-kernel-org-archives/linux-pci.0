Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F846AEEA;
	Tue, 16 Jun 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626527; cv=none; b=HkiZ9K4bGDGF3j/svGAaegseUXhPMuOIuT/fqBUkWYSuKO0NA2VGMyVTsiD4a/44xgZDDsI1Y8p99/RQgcenuD54XG/7tQKY6eDLjMTDG354P1kfZSMFj31WpdUxTxaqq6inVcuO6Y0sVUnYtluPPxtbZFpSHCcCES8THkm1sQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626527; c=relaxed/simple;
	bh=U57JNrDB7ODII7hspI+3+YIU9zfHODcQz050DPxq3P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o1V3NxEal6765KKIh7+2UvpAtuTT89WQlMuxps2KYfY/pnGtxkoAMxQdu/qnEr04oqTvNuRV5j1xbKHypwHe6ITRGQY3vBYq330PldKOa3YYeE/k8osO33KgjS/WG5b/D5G8/34mVObUDy9wHsmcwAmIhOZtCFCKlgoZMJFQGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQIjWPWJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQIjWPWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 163F5C2BCB8;
	Tue, 16 Jun 2026 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781626527;
	bh=U57JNrDB7ODII7hspI+3+YIU9zfHODcQz050DPxq3P8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tQIjWPWJZak3ZY5xY25UE3mqmr6KEi48GOd46LL5838GcFpTtirzOv662/74QGUR0
	 lY2svz1vAk1/HDsZE6jpkE+3eCeGj+ZDgCcUPkBXY+Wj5T71E7Y1NeDM47egVRjgrg
	 9c6NuhvR8GX9fLNIrkkrrivTQNuCKUqMdjTCiH+wu8+TVtKoWjU7p+UWM39Y/8qdBt
	 0IZC+MsCOz7K3q9jXA0rchMNQvFPwcHMkWZMTSL803PCNvs337UivNtGqnXJT0z8Bg
	 j07tDXxSFhKEQwARAbDhofeI9aUCZfkfYkMFE5GmdDZxAEPIKQYbCifT592Mgq7/T5
	 bcu3p0iY9OeIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA02CD98E1;
	Tue, 16 Jun 2026 16:15:26 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 16 Jun 2026 21:45:19 +0530
Subject: [PATCH] PCI: qcom: Skip PERST# GPIOs provided by downstream PCIe
 devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-pci-qcom-perst-fix-v1-1-27600d6ae357@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJZ2MWoC/yXMQQrCMBCF4auUWTuQFJugVxEXcTrqCLYxE6UQc
 vemdvk9eH8B5SSscO4KJP6Jyjw12EMH9AzTg1HGZuhN74yzDiMJfmh+Y+SkGe+yoDFH60MYfDg
 5aMeYuM3/6OW6W7+3F1PeSlDrCuwFEj12AAAA
X-Change-ID: 20260616-pci-qcom-perst-fix-00417aa57a96
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=SAG1WtlnXkQauMnV0DcExAZh86wK4HSUyapFJVHHEa4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqMXad1EQZDA1Q+azZIoD14TsRxfPwzlzqAWMsJ
 QDCPpo1y7SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCajF2nQAKCRBVnxHm/pHO
 9QKTB/41ovfWXcOGtCXxtK/RPBXxzZmvHF6TmIDcmgrzyztBsljFajLXdEIeX3zu1g0UDKKO1Ny
 OzV0XFUkUxz6NQi00U5EdUkFJRS4oFThbdxWjyz8vM+z95pKaoDru1lwQ2ZGJCutfTq+e834Aj3
 h1MeUBAeL/g/p5xknPldWjUI4SM3UXJgNe6NZEm5+UR0AJw7uGeMyKmqVwhfF0Efg0MSruYjkCU
 gUo6sudOQ5POYaTJ5kW9pM80FDjgcsdfl/vNk0ajYSsYxsBuuiVK3BQpEdN+TO+8nm6rL3j7q2I
 0DBQOGgUBglrv+zoC9CiJsT5VG3xJgl8qoyOHEdD3eUs8YlE
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Currently, the pcie-qcom driver recursively parses the PERST# GPIO from all
child nodes defined in DT and acquires them. But this creates issues with
PERST# GPIO provided by one of the child devices like the PCIe switch port.
In this case, the RC driver cannot acquire the PERST# GPIO since it will be
provided by the child PCIe device which was not yet enumerated during RC
driver probe.

Fix this by checking if the GPIO provider is a child of the RC's DT node
(i.e., sits behind this PCIe controller). If so, skip it, as PERST#
should be controlled by the respective PCIe client driver implementation.
GPIOs provided by external GPIO controllers (e.g., TLMM in Qcom SoCs)
continue to be handled normally.

Fixes: 2fd60a2edb83 ("PCI: qcom: Parse PERST# from all PCIe bridge nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index af6bf5cce65b..f90ff68cdaf2 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1693,6 +1693,22 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
 	}
 };
 
+static bool qcom_pcie_is_child_node(struct device *dev,
+				    struct device_node *node)
+{
+	struct device_node *parent;
+
+	for (parent = of_get_parent(node); parent;
+	     parent = of_get_next_parent(parent)) {
+		if (parent == dev->of_node) {
+			of_node_put(parent);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /* Parse PERST# from all nodes in depth first manner starting from @np */
 static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 				 struct qcom_pcie_port *port,
@@ -1700,12 +1716,32 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 {
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_perst *perst;
+	struct device_node *gpio_np;
 	struct gpio_desc *reset;
 	int ret;
 
 	if (!of_find_property(np, "reset-gpios", NULL))
 		goto parse_child_node;
 
+	/*
+	 * Skip GPIOs provided by a PCIe device which is a child of the Root
+	 * Complex (e.g., a PCIe switch with GPIO controller capability). Such
+	 * controllers won't be available at RC probe time and their PERST#
+	 * should be controlled by the respective PCI client driver
+	 * implementation.
+	 */
+	gpio_np = of_parse_phandle(np, "reset-gpios", 0);
+	if (!gpio_np) {
+		dev_err(dev, "Failed to parse GPIO provider\n");
+		return -EINVAL;
+	}
+
+	if (qcom_pcie_is_child_node(dev, gpio_np)) {
+		of_node_put(gpio_np);
+		goto parse_child_node;
+	}
+	of_node_put(gpio_np);
+
 	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
 				      GPIOD_OUT_HIGH, "PERST#");
 	if (IS_ERR(reset)) {

---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260616-pci-qcom-perst-fix-00417aa57a96

Best regards,
--  
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


