Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515C4908BD;
	Fri, 11 Sep 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132985; cv=none; b=JZC/wOs1tYuZaffUPPXzWkjIUTfUSHB/x/blx0G5+/bUW8KmgBUfSsrqZNQUXevrPI0mbRAf4nTzhCXvy1J93nLeN5hfMwELcUVVj1dA/xA6mUrna/AhjTUz/1/z3/C4vDnTXiPOdywrjAfGwJx8EmwIjV6KASr/P4jnsp/5OE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132985; c=relaxed/simple;
	bh=dnjU1hTCfDHlykP3Paur3xNq12npdatLt+IQGPslZPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjBRBXweLaWBmod1QRAihltRbM+xZ+WzjvTjEHf+akSfzmS5q6HIYClJu+6kaKIZKSVVxee3S6UXuQSaR8VUKmsoCLRRg3YTWZQdWv14HQ6iTLpm0B8cOEA1Sy9APQGYP6DUmFgHA5DKJm/vgje+YRV5MwNDScWNYYHk679RfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=StNdYO1C; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="StNdYO1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tV
	nKxjEqjL5K9MQsTn8DQ/hXl6/AJIPEzzM3B7nx2sM=; b=StNdYO1CVQDdyUpXBZ
	cc7FLd0UxaTVrpzO2tWV9G0Kbpcn40nJAv6rbS4GW9/3cl4PAt//+NAcjkq5+WJr
	qSE+YZ2vg2GMi4zIXNk5N0GYbwhTzcsac0vH65Y5unt7LxuhrxQ2qvG2zSyUFB7K
	OznMTxnssA8Fz7XboP3SyHP74=
Received: from zhb.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHqBJmAKRqYh6mRA--.52761S3;
	Fri, 11 Sep 2026 21:21:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Ricardo Pardini <ricardo@pardini.net>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v8 1/2] PCI: Configure Root Port MPS during host probing
Date: Fri, 11 Sep 2026 21:21:44 +0800
Message-Id: <20260911132145.211380-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911132145.211380-1-18255117159@163.com>
References: <20260911132145.211380-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAHqBJmAKRqYh6mRA--.52761S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DCr43Xr1rAr4DKFy7Awb_yoW5JFWxpa
	yUWanYyFs7GF4fZFsrZ3WFvFyYqF93ZrW3GrZYv34qvan8AryDJrW5ta95Jw1kGrZ29Fya
	vFn8tryxu3ZIvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGNtfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxArdgWqkAGrXVAAA31

Current PCIe initialization logic may leave Root Ports operating with
non-optimal Maximum Payload Size (MPS) settings. The existing code in
pci_configure_mps() returns early for devices without an upstream bridge
which includes Root Ports, so their MPS values remain at firmware
defaults. This fails to utilize the controller's full capabilities,
leading to suboptimal data transfer efficiency across the PCIe hierarchy.

With this patch, during the host controller probing phase:
- When PCIe bus tuning is enabled (not PCIE_BUS_TUNE_OFF) and not
  PCIE_BUS_PEER2PEER (which requires the default 128 bytes for optimal
  peer-to-peer operation), and
- The device is a Root Port, the Root Port's MPS is set to its maximum
  supported value.

Note that this initial maximum MPS setting may be reduced later, during
downstream device enumeration, if any downstream device does not support
the Root Port's maximum MPS.

This change ensures Root Ports are initialized to their maximum MPS before
downstream devices negotiate MPS, while maintaining backward compatibility
via the PCIE_BUS_TUNE_OFF check and not interfering with the
PCIE_BUS_PEER2PEER strategy.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Hans Zhang <18255117159@163.com>
Tested-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
Tested-by: Ricardo Pardini <ricardo@pardini.net> # on Odroid-HC4 
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/probe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..dc4747858918 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2229,6 +2229,18 @@ static void pci_configure_mps(struct pci_dev *dev)
 		return;
 	}
 
+	/*
+	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all) or
+	 * PCIE_BUS_PEER2PEER (use minimum MPS for peer-to-peer), set Root Ports'
+	 * MPS to their maximum supported value. Depending on the MPS strategy
+	 * and MPSS of downstream devices, a Root Port's MPS may be reduced
+	 * later during device enumeration.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pcie_bus_config != PCIE_BUS_TUNE_OFF &&
+	    pcie_bus_config != PCIE_BUS_PEER2PEER)
+		pcie_set_mps(dev, 128 << dev->pcie_mpss);
+
 	if (!bridge || !pci_is_pcie(bridge))
 		return;
 
-- 
2.34.1

