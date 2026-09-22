Received: from mail-m49218.qiye.163.com (mail-m49218.qiye.163.com [45.254.49.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F929AB02
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044959; cv=none; b=KNPOPu0aEv7pY3LQuSaUNfG2JEWGtrEdrWsoFJbcuQbhG+eDGiUE0hVt6anRxuM+XJ1jVnRh4mYt1EGguNqR1QrbC6Sal5Ovi33bKJygAg0iVbUjKFAswNj6x7MB5FjprwyY2FCEpA0aWUhpqMBE8FddDKi9O2sTIZlfSraFis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044959; c=relaxed/simple;
	bh=GPZtCsvc88B2i+qVBWqKA4pimRKiWxbkuDETQnIcue8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BDVEMAxwuuqIxjufkziAENKmct2qBVHAJ6bmohr/z5uvmgnyHtyN+T+8s7DJ6kTO8sZ7bJUxeYwj1wn4IP57J/uDMAHx8r9uCTVuMpzxpB448/zDdYJnCMnucwAaeHWwpmrvD9UhuLzQAWLhq8OABZv/oAe2WzoJbqJaX69iFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AOKqTXkR; arc=none smtp.client-ip=45.254.49.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AOKqTXkR"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ea70fec8;
	Tue, 22 Sep 2026 10:37:21 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 3/3] PCI: dw-rockchip: Mask the INTx IRQ while the controller clocks are gated
Date: Tue, 22 Sep 2026 10:37:02 +0800
Message-Id: <1790044622-164744-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c6f99ab603a4kunm27853d20398d79
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUNNTlZMH0kaQxlLHx
	9NTEtWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AOKqTXkRSGqFq1fEzs0ov+9BglDWsp28kYrlumywI4Ix/9rfrPnng4JvzRwPcFEx0s4RPa/GRyXUSL/WQHnRA3FJTIQQ9KWxRtIdBtI8lCagOarWQ1R+JqvIIPSgJ7eJdlx5LY2y4swnNQJCrgfAsiY7W+/FJIvu34m4U647vwQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=v6siiizUWVS2NDNT9IPCWzDsKSNZnVJES9EOoQV5CEc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

.reset_root_port() gates the controller clocks and PHY before
re-initializing the hardware. Devices on the bus may keep their INTx
line asserted across this window, so the chained INTx handler can run
and read the APB registers of the unclocked controller, raising a
synchronous external abort.

Mask the INTx IRQ before turning the clocks off and re-enable it once
the clocks are running again. On the error paths the clocks stay
gated, so the IRQ is deliberately left masked there.

Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2:
- keep the INTx IRQ masked while .reset_root_port()
  gates the controller clocks, responding to the Sashiko review
  finding about accessing the unclocked APB bus.

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f395a66..fd5cc6f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -925,6 +925,16 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	u32 val;
 	int ret;
 
+	/*
+	 * Devices may keep their INTx line asserted across the reset. Mask
+	 * the INTx IRQ so that the chained handler does not touch the
+	 * unclocked APB bus, which would raise a synchronous external abort.
+	 * The IRQ is re-enabled once the clocks are restored, and is
+	 * deliberately left masked on the error paths where the controller
+	 * remains unclocked.
+	 */
+	disable_irq(rockchip->intx_irq);
+
 	dw_pcie_stop_link(pci);
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 	rockchip_pcie_phy_deinit(rockchip);
@@ -975,6 +985,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 
 	/* Ignore errors, the link may come up later */
 	dw_pcie_wait_for_link(pci);
+	enable_irq(rockchip->intx_irq);
 	dev_dbg(dev, "Root Port reset completed\n");
 	return ret;
 
-- 
2.7.4

