Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D801134CF
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404425; cv=none; b=HHAe8XE2tfBZZbSQCXlsYcnXOvIrh9Bl5J3qR+8PJPn1zsf4hmsJ30IFS6mkZY8MUZr3dDB1H98rfK2cfYaTLZlW6g6lK+TrcsJFmghirikG6oyOCLXM8V7ljrxuZ9yVqrQTygEEw5NaEppFjKRD+VtRoq2Z0qpowx/3dZd/DRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404425; c=relaxed/simple;
	bh=A1oFKTw571TqpMTTx+jNIYLWvzy4xitrLXt5pysuEko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MdWbqF/vWLBi+IJQlzejc6SVOSMB57iaSIRt4nUgCt6Xz5DcoQBpJlIaAvl1Nsufn1LbOb7toccVO/HmSKrnsQ4s34Q5QA1D+WyyEbWPyRoFwowOZA9dzRsqfdPM6BETZFkD4PNruQAY+0ba0nFLtIFuZJQ1PByUY+WU03dmjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UgJ4kgFT; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UgJ4kgFT"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c5849819;
	Thu, 3 Sep 2026 10:44:51 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Peter Geis <pgwipeout@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: dw-rockchip: Bail out if the INTx irq domain creation fails
Date: Thu,  3 Sep 2026 10:44:36 +0800
Message-Id: <1788403477-71491-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa06527a43003a4kunm355d5a8763ed0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGhhIQ1ZIGR5KQ01LHh
	9NGE5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UgJ4kgFTHwGbDxyquArR5Bmt3wum1Z2WsBLHGy6kq+f4DVkqFSX1oG9td6XSGM8VLcsCrmqpgDjv9G3TLrCmK4OOHyPJMLarJn8qqGuRKwMoejH4zQR/VxCm9e9pcBQpF3UoAw4aqvbKqgY9gcle0GD5HKyk2tFfTkWX7R9TMek=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+buA18ALK+RC3oCEXsr81pLBNdzYPp29OxYXJu09Ugs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

rockchip_pcie_init_irq_domain() can fail, e.g. when the DT node is
missing its "legacy-interrupt-controller" child node. In that case,
rockchip_pcie_host_init() only prints an error and continues, arming the
chained INTx handler with a NULL irq_domain. The first INTx interrupt
then dereferences the NULL irq_domain in rockchip_pcie_intx_handler(),
which panics the machine.

Propagate the error to abort probing, keeping the error message for
easier debugging.

Fixes: e8aae154df61 ("PCI: rockchip-dwc: Add legacy interrupt support")
Cc: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index af26a07..50824c8 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -432,8 +432,10 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
 
 	ret = rockchip_pcie_init_irq_domain(rockchip);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to init irq domain\n");
+		return ret;
+	}
 
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
-- 
2.7.4

