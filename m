Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD133C18A;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931266; cv=none; b=dzUiAj229IfHcUJ5wYZyve19OLVa5Oj7oDW1QYAmDg48y1fxTajdNAKH7KIUnntPYbOHmK3OjVImWhltESKeIHCSDXYxpRIaDKz0qibOzcPcTPg8dJrsqDNsaQZhh3jsMrWGvF3AwB+dFjcDuKZ8amwAPmsSz5dGcWGlHSH8mNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931266; c=relaxed/simple;
	bh=bgXK6fVCuK9gj2LIP3pQaoqOPFYMwod1nKJ2KQxvZU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uT/1ksU3OIU+keOVEuLpTBarH+AqZlBcC8dV628G6vnalCMOCJlx8RXq7MfHSdpWIktetSdCXuLCxx/iEK/FrI7OuiTXKIkbr9FfwRbtty1wmpba0HmhyLdGjK9ro1oqj+Wkz3VIWM2gYQ35Zw5rZbUFU/kOgdiMCL6+VoDfY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9+lyQTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9+lyQTe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71D02C19422;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931266;
	bh=bgXK6fVCuK9gj2LIP3pQaoqOPFYMwod1nKJ2KQxvZU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T9+lyQTeOU87iqrilyOuLURltMW9WYcwCDdihjMK5UjZZZiopcprvkBbfwsAQ3Gom
	 ZkDbG6/P7/pTbRWTKnyZ1xmES+s02h1/X9Id9v9DRAXiaSxB2JH0/49PSry/CzMR9T
	 o6k1hXouPU3ev3MlzRV+pRBaexBDwSNNfVTywdnwDZYKt5q0bxUGIeeLQSGezgTsSm
	 c/OjbDZ4ErGKoQX/tlHuUWguV1Z8s3Jo+5K3xt5yXDzPHTlcr6R7AhVPnsGimV499y
	 +gJ+8YVovASC8FhWpsgl/+4ZCajz/j5dXeJIrad/2k3mVLRHVMmDE2HtUVU8PrfmTa
	 6q/k/hKzTRjCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF94CA5FBA;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 20 Jan 2026 23:17:40 +0530
Subject: [PATCH v4 1/5] PCI: dwc: Return -ENODEV from
 dw_pcie_wait_for_link() if device is not found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pci-dwc-suspend-rework-v4-1-2f32d5082549@oss.qualcomm.com>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>, 
 Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=aJ16lo8KOnS7CZMNjxJ6dxKG/LnfuQvAluvyn1kC0vE=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGlvv8CgxblkdAyDYscd9q9adYM640nDPnRHODrmi7qiuDMiy
 okBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJpb7/AAAoJEFWfEeb+kc71M0MH/36d
 qBkUfw0KE3+UDas9zSZvc68cM3HBU/yD8HTu/XNaCsfEQhF4smqFIrNAkYgbpyYa3xkCH3BUfDk
 szYdnqV1ctxPtal9p5yJWAEkd3lEKWhhFtx1EUJZrnKD+BC684GFWEXqH78PP5+zNBFejIIT5SA
 VpS8qEKLRMNNwJc0DD4jW8VU7GaRFnrNX+fn4QXviXraJIK8UpRV7jQpreIpo1T8PO+/gh4+k75
 zEXro/2gsQcbQlstByrSROw/SZ6EmqnS0a/twlXaAVWttnZC/u2k1WrOGbDlVbUicmllRcxfxZd
 w2vD2SmWXaRmIfCu4uEvE226KsOEAg8M2WFfPNw=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The dw_pcie_wait_for_link() function waits up to 1 second for the PCIe link
to come up and returns -ETIMEDOUT for all failures without distinguishing
cases where no device is present on the bus. But the callers may want to
just skip the failure if the device is not found on the bus and handle
failure for other reasons.

So after timeout, if the LTSSM is in Detect.Quiet or Detect.Active state,
return -ENODEV to indicate the callers that the device is not found on the
bus and return -ETIMEDOUT otherwise.

Also add kernel doc to document the parameter and return values.

Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 345365ea97c7..55c1c60f7f8f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -692,9 +692,16 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
+/**
+ * dw_pcie_wait_for_link - Wait for the PCIe link to be up
+ * @pci: DWC instance
+ *
+ * Returns: 0 if link is up, -ENODEV if device is not found, -ETIMEDOUT if the
+ * link fails to come up for other reasons.
+ */
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
-	u32 offset, val;
+	u32 offset, val, ltssm;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -706,6 +713,17 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	}
 
 	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
+		/*
+		 * If the link is in Detect.Quiet or Detect.Active state, it
+		 * indicates that no device is detected.
+		 */
+		ltssm = dw_pcie_get_ltssm(pci);
+		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
+		    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
+			dev_info(pci->dev, "Device not found\n");
+			return -ENODEV;
+		}
+
 		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}

-- 
2.51.0


