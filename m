Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EA5AA673;
	Wed, 16 Sep 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573219; cv=none; b=kz3efg3ZdSQ5IsOlG5zSTaZlqvpbNvXYRk5vbVLIhc+xMOV0oOsow8ErXvw3pyMi+lIQLU1elFq9mbmN3/RGgjPcNju1uHZtqrNxR9WQOSmHZbdJSVgzLoFw0Ex3dvnKJxbeA0KyY4N0jUtFZD8E4zxvLfsPDKBmpxb9ClxDV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573219; c=relaxed/simple;
	bh=9cNtCcBxaNM9ENDzMLMHnnKX7k7LHPcYLhmV6DXJm3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4ma2wwwcSNS5D6n+8Pp7s9yUMSljuhEOIrD1NWqeER8+vA+XlHcDPdbF/ixv7902J9vrWs/5WsLl04edfEyCG0GzOEZQ4EBoxE3zHHz9M58CGYx50AoXYGZ4+rVqofcQ6qIu5fczEjFwxtsszW5A8MXXxMF9GWAWLt4HIWHQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R4mSVdX0; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R4mSVdX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tX
	XLyITMJT1yST+MFquna26ESmZnA30Nae1jXyWuEoU=; b=R4mSVdX04i829VBmYT
	cmXwOwWC7FEurPwMRCcJeY0lIReA6OQdYVbBFjfxBeKwNXP0pHKRfK+uFKw4qmlf
	tMVnF5VOgpVzljpaGoGx40wnuzRu0CmRZsTGDVEdLTDEuPuwhtOlNVPAgC53Bgbt
	C1DZTQj8Sl3frPxwHVVqYEhco=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnbxQduKpqGzAlBA--.54876S4;
	Wed, 16 Sep 2026 23:39:12 +0800 (CST)
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
Subject: [PATCH v9 2/3] PCI: Configure Root Port MPS during host probing
Date: Wed, 16 Sep 2026 23:39:06 +0800
Message-Id: <20260916153907.60344-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916153907.60344-1-18255117159@163.com>
References: <20260916153907.60344-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbxQduKpqGzAlBA--.54876S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4fJF15AF47uFWUuw4UArb_yoW5GrWkpa
	yUWanYyFs7GF4fZFsrZ3WFvFyYqF93Zry3GrZ3Z3s0van8Zr9rJrWaya95Jw1kGrZ7KFya
	vFn8try8u3ZIvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVyIbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAB7H2qquCBtpwAA3y

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
 drivers/pci/probe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 232bce2819f0..08af75aa7366 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2248,6 +2248,21 @@ static void pci_configure_mps(struct pci_dev *dev)
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
+	    pcie_bus_config != PCIE_BUS_PEER2PEER) {
+		rc = pcie_set_mps(dev, 128 << dev->pcie_mpss);
+		if (rc)
+			dev_warn(&dev->dev, "failed to set root port MPS\n");
+	}
+
 	if (!bridge || !pci_is_pcie(bridge))
 		return;
 
-- 
2.34.1

