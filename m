Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AF4CDDE1;
	Mon, 12 Oct 2026 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828999; cv=none; b=ZxGufscY+rtNgQDFKi8MOYUP8pGz6t+xKaVKw28AqJmxJetezSg/uPRMz6CEB0NAw5JzQadon1MkpOkGK/VXyRNbs4rfGx1OHt0jp35bnPa1IQH8NLrXKOb/oD3fvlFxTccr5m3kLtKz+InQmYIH03p1YPyKAHGQkpLqRtdpTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828999; c=relaxed/simple;
	bh=Lt+UNC4uxIJzZgFW8CCuvyJKWVBbuDL7xi4PmG9eKTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kOnW7PupMDxWSUQL98N0MtFIBVyUJofOgtADSrQgX0/R4zcCBOVdgbIIREr2Dzvearh+t5yiR3aK/wapj8clMnzCNEuJHWrqNmFs9iEpbp7BvF8WSBgZQeryXLggTMDG4jcQVkbgKBZ5WObPaN0nc45KBtgMwLWcOa8GtIFRVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTq8ue5D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTq8ue5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3C61F008A1;
	Mon, 12 Oct 2026 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791828998;
	bh=d9tpJLzz1kOLSftpAE/8ZpMKaHae1W61puA/y0/qc1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OTq8ue5Dmf4bVRJO2IfDWOlDk2E3BtsTvdyVuain2qcnz2ih+RtBYEkSZ4T97Rxzd
	 MllC/HrDirI0Bm9VipYyY0H74zq0bo7vx1Ostm9v3/oqVcI8tZ9NXpAD+0bJ/2rAJ1
	 ISIWOprqhQBjTV/XoCYu2RRQYhXO5YBbLYNUGnubIRyRBsml/klJahLWBm0f7WEcw8
	 5f0ziJjyfcYJSfbyNQoqL8opcmH6D1BV921HyW+Uqs8A/OkF4hfbTe25CcEuLWzaGI
	 NylsFdtXgAMSyeVA/Nhh2Ti1FvuOibJKooRFJR0aaiOnLq4Wc3dUCfDfVMFOR1vyn8
	 SH/wL3I4YOkBQ==
Date: Mon, 12 Oct 2026 13:16:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, rafal@milecki.pl,
	zajec5@gmail.com, florian.fainelli@broadcom.com, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rosenp@gmail.com, rani.hod@gmail.com
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Message-ID: <20261012181637.GA1313446@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912043626.437-1-strst.gs@gmail.com>

[cc->to: Mani]

On Sat, Sep 12, 2026 at 07:36:26AM +0300, Semih Baskan wrote:
> The BCMA driver takes its register base and, since commit 552aa843e4c5
> ("PCI: iproc: Use the EROM outbound window on BCMA"), its outbound
> window from what bcma read out of the enumeration ROM. It still
> allocates its host bridge with devm_pci_alloc_host_bridge(), which since
> commit 669cbc708122 ("PCI: Move DT resource setup into
> devm_pci_alloc_host_bridge()") parses ranges, dma-ranges and bus-range
> from the device's OF node and requests the windows it finds. None of
> that reaches the hardware here: need_ob_cfg is only ever set by the
> platform driver, so iproc_pcie_setup() never maps the parsed windows,
> and the EROM commit above had to throw them away again to keep them
> from colliding with its own window.
> 
> Allocate the bridge with pci_alloc_host_bridge() instead, so nothing
> from the devicetree is requested or handed to the PCI core, and free it
> on the error paths and in remove(). The driver now sets
> bridge->dev.parent itself, as devm_pci_alloc_host_bridge() did, since
> the wifi nodes under pcie_bridge0 in bcm4709-netgear-r8000.dts are
> resolved through the root bus. The window request
> moves from devm to request_resource() and release_resource() because
> the resource lives inside the bridge allocation and has to be released
> before the bridge is freed.
> 
> The ranges property is still read, but only to compare. bcm-ns.dtsi
> describes the same window for the platform driver, and on core revision
> 0x01 it points at an address the hardware does not decode. The warning
> from the EROM commit stays for that reason: a wrong dts is visible on
> BCMA boots, where nothing else would show it. Without bus-range the
> root bus also logs "No busn resource found for root bus, will use
> [bus 00-ff]" again, which changes nothing else.
> 
> With PCIE_IPROC_PLATFORM and PCIE_IPROC_BCMA both enabled, the platform
> driver binds the same nodes first and claims the devicetree window. On
> core revision 0x07 that is the EROM window, so this driver's request
> still fails and the probe backs out as before. On revision 0x01 the
> devicetree window is elsewhere, so this driver now probes as well, next
> to a platform driver instance whose window the hardware does not decode.
> That instance does not work either; the only difference is that the
> second probe is no longer stopped by the collision.
> 
> Tested on an ASUS RT-N18U (BCM47081, core revision 0x01): the warning
> lines are identical to the applied version, /proc/iomem and the
> enumerated devices are unchanged.

What do you think about this, Mani?

I still don't quite understand the issue with the DT and discovering
this via both platform and bcma bus drivers, but we should make
progress.

I *think* that if we squash this patch into 552aa843e4c5 ("PCI: iproc:
Use the EROM outbound window on BCMA") and use
devm_add_action_or_reset(), it will simplify down to this, which is
less intrusive and would need less explanation:


diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index 593418c2bc3a..73f2b6c424cc 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -11,6 +11,7 @@
 #include <linux/phy/phy.h>
 #include <linux/bcma/bcma.h>
 #include <linux/ioport.h>
+#include <linux/of_address.h>
 
 #include "pcie-iproc.h"
 
@@ -31,6 +32,34 @@ static int iproc_bcma_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
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
+static void devm_pci_alloc_host_bridge_release(void *data)
+{
+	pci_free_host_bridge(data);
+}
+
 static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 {
 	struct device *dev = &bdev->dev;
@@ -38,10 +67,17 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
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
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
@@ -59,6 +95,7 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
 	pcie->mem.name = "PCIe MEM space";
 	pcie->mem.flags = IORESOURCE_MEM;
+	iproc_bcma_pcie_check_dt_window(pcie);
 	pci_add_resource(&bridge->windows, &pcie->mem);
 	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
