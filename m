Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41985 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753727AbdIHJyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2017 05:54:01 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        Yehuda Yitschak <yehuday@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        stable@vger.kernel.org
Subject: [PATCH 7/7] PCI: aardvark: define IRQ related hooks in pci_host_bridge
Date: Fri,  8 Sep 2017 11:53:48 +0200
Message-Id: <20170908095348.16578-8-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
References: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from
pcibios_alloc_irq()") was assuming all PCI host controller drivers had
been converted to use ->map_irq(), but that wasn't the case:
pci-aardvark had not been converted. Due to this, it broke the support
for legacy PCI interrupts when using the pci-aardvark driver (used on
Marvell Armada 3720 platforms).

In order to fix this, we make sure the ->map_irq and ->swizzle_irq
fields of pci_host_bridge are properly filled in.

Fixes: 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from pcibios_alloc_irq()")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v4.13+
---
 drivers/pci/host/pci-aardvark.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 6d6a2ae35481..f682650bf037 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -999,6 +999,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie;
 	bridge->busnr = 0;
 	bridge->ops = &advk_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0) {
-- 
2.13.5
