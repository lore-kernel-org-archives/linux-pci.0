Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39E556B9F;
	Tue, 13 Oct 2026 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929090; cv=none; b=A55WDMmvcpDe1ZABYD4Iqn2aKqyyzy4gpGhvv6NhemiDPQnIsYGO2uyaPNsQHAr9y9UPWVRyZOKyZxamENDmVMMDfaTs4dKAocQENFXtJGUefD5jERQUYzI2j6S4N0VqFdivErUYjdHL61lIEtZ0gVEC63QCFsI+hg/ZhQtT3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929090; c=relaxed/simple;
	bh=WJ0PsKJJ9GEZOIwNf+k33/yd+qdg96T2bbsHymMmrfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQLJNI21nery8nimZwElBsmMKdsuQeXiGTEqabXGn9vcRaAnji8zJIw4p2piOdH2MBURqURetS5c9QgKtIPD0GqBWJLzIF1ITeat+ru8DHHtKnOJMlEDKnKriCgMDHvHKRUSOxmiANNlaDnTRQIzED6qlvQy3wb1xVMFSIG4Zrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN+4oJ02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN+4oJ02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4091F00898;
	Tue, 13 Oct 2026 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929088;
	bh=jCSgEGxqrKkW4tQWVEb2obBRfbgXfhgd/LNbZr68fQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BN+4oJ02D0ywdFvJsLoN0AZeasbdwaRZALns4Gp/E/6dhp55FMwxlEzqXc+pCNpBI
	 MNFDdBozSYdFJthvwqSaj3pYp5kCj2qoUqGg/HnMK5qTvsRuCmDN7P8uT3INiiK/5l
	 hlLthbK7AYGAYMhLopqCs9HIah7cJ2TuzAti7DRNNXHLTJLNz8Oso++Tunh77hXnPG
	 J6RPHdJ7twpeE2saZHosSMCLXuPglg37Q30BevonXhotN696a/3ge1JGUPslGNVvJz
	 pomKqU4e/OALAW2hwmT24001gqKte1QSQ4VGGH6m8PWYw4RjuR8JYXzYWGWlXZa0e1
	 /bMC7kJCgp6nQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rosen Penev <rosenp@gmail.com>,
	Rani Hod <rani.hod@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 2/2] PCI: iproc: Use the EROM outbound window on BCMA
Date: Tue, 13 Oct 2026 17:04:21 -0500
Message-ID: <20261013220421.1588051-3-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013220421.1588051-1-bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
0x20000000 and 0x28000000. Broadcom's own driver branches on the core
revision for exactly this reason.

bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
Describe PCIe controllers fully") gave the controllers a ranges property.
The commit shipped in v7.1.

With that property present, two things go wrong with this driver:

  1) devm_pci_alloc_host_bridge() parses those ranges and requests them,
     then this driver adds its own window and requests the whole list a
     second time, so every controller fails to probe with -EBUSY.

  2) The DT window itself is only correct on core revision 0x07. On
     revision 0x01 it points at an address the hardware does not decode,
     and the first MMIO access to a BAR takes an imprecise external abort.

The enumeration ROM reports the correct base for the revision actually
present, and bcma already provides it as addr_s[0].

To solve 1), use pci_alloc_host_bridge() directly to avoid the request of
all the DT resources done in pci_parse_request_of_pci_ranges(). Instead,
request the memory window from the EROM.

To solve 2), parse the memory resources from DT and emit a warning if it
describes a window that doesn't match the window from the EROM.  The
mismatch means the devicetree describes a window the hardware does not
decode, and that should be fixed in the dts rather than ignored silently.

The driver is correct whether or not the DT describes a window.

The same commit also added compatible = "brcm,iproc-pcie", so these
nodes now match pcie-iproc-platform. With CONFIG_PCIE_IPROC_PLATFORM
enabled, which is the default on ARCH_BCM_IPROC, that driver binds them
first and this driver's probe fails inside devm_pci_alloc_host_bridge().
This commit fixes the configurations where the BCMA driver is the one in
use; OpenWrt builds that way, with PCIE_IPROC_PLATFORM disabled. The
platform path takes the DT window as-is and has the same wrong address
on core revision 0x01, so that side needs a devicetree fix either way.

Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")

Based on:
  https://patch.msgid.link/20260807160526.379-1-strst.gs@gmail.com
  https://patch.msgid.link/20260912043626.437-1-strst.gs@gmail.com
---
 drivers/pci/controller/pcie-iproc-bcma.c | 40 ++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index 593418c2bc3a..1e258cd8fed4 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -11,7 +11,9 @@
 #include <linux/phy/phy.h>
 #include <linux/bcma/bcma.h>
 #include <linux/ioport.h>
+#include <linux/of_address.h>
 
+#include "../pci.h"
 #include "pcie-iproc.h"
 
 
@@ -31,6 +33,29 @@ static int iproc_bcma_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return bcma_core_irq(bdev, 5);
 }
 
+static void iproc_bcma_pcie_check_dt_window(struct iproc_pcie *pcie)
+{
+	struct device_node *np = pcie->dev->of_node;
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+	struct resource res;
+
+	if (!np || of_pci_range_parser_init(&parser, np))
+		return;
+
+	for_each_of_pci_range(&parser, &range) {
+		if ((range.flags & IORESOURCE_TYPE_BITS) != IORESOURCE_MEM)
+			continue;
+
+		if (of_pci_range_to_resource(&range, np, &res))
+			continue;
+
+		if (res.start != pcie->mem.start || res.end != pcie->mem.end)
+			dev_warn(pcie->dev, "DT window %pR does not match EROM window %pR, using EROM\n",
+				 &res, &pcie->mem);
+	}
+}
+
 static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 {
 	struct device *dev = &bdev->dev;
@@ -38,10 +63,20 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	struct pci_host_bridge *bridge;
 	int ret;
 
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	bridge = pci_alloc_host_bridge(sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->dev.parent = dev;
+
+	ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
+				       bridge);
+	if (ret)
+		return -ENOMEM;
+
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = iproc_bcma_pcie_map_irq;
+
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
@@ -59,13 +94,12 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
 	pcie->mem.name = "PCIe MEM space";
 	pcie->mem.flags = IORESOURCE_MEM;
+	iproc_bcma_pcie_check_dt_window(pcie);
 	pci_add_resource(&bridge->windows, &pcie->mem);
 	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
 		return ret;
 
-	bridge->map_irq = iproc_bcma_pcie_map_irq;
-
 	bcma_set_drvdata(bdev, pcie);
 
 	return iproc_pcie_setup(pcie, &bridge->windows);
-- 
2.53.0

