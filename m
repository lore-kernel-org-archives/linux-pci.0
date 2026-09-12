Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F732E128
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789187807; cv=none; b=OWsJmoJCfrQGOYm/p06PdokAmJ08YJ7hLjm/+Q2clJABhY6mUEoRiz9hqU4qgiWe3psm6VV+PVARd/hYFvcqCKX8Zkw7Rv5APkULGe7gNNh1ij7L+YRyy1YIASTrOSzxolFkWJ/6aCFSzXe5xunSoRW33cgat04OPGdIznedYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789187807; c=relaxed/simple;
	bh=MeS/gTZ7PTwUcwERhfTEln/D294IBm9UtfgkPE67XX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE3169FuRgQJw4JF/S4TX7OLY5huRLvfQYrNOQbB+67KasyxN1HOBJL6/2mjuy1DRM6MRuGOQYNtx3t7bP+y4Le6nQ3VIMGe8XbuOnHDD7KiqHoFIS6jnyXMDx2csHR8ac/y919MVpQ+tDN9QzyfTVKAZ4DQcLOCbGYssVb8iKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRebeVE1; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRebeVE1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so1463825e9.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789187803; x=1789792603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UA9WVjEDN9IXL+AcnME2x3yVc4Y0zRQ+FWtK13UcSNc=;
        b=rRebeVE13DSJxd2d/tjIM+tf0razOycEmtg/XdWXdW26GhunTJtjHfBmPcOXqI7wyE
         eKEQebabACsLS8Aq4/VBfbZFVkIXWU2iP2c3mRY4vcgCDbnWtuAiJzD/xNoyo9cAOie6
         zDSXE5GuYr1CeaR8FtoKeR8Mi6c6p8FELmLpkyZuMf0/eE/UsGmBoZrd/Uuh/R0R2i3o
         azot1bYCT5WPt/A5Joxca0+MlH1QW7cJUBtZy4Y1e/GUzJDqLhZHd7RIEW52hstf31Ao
         BXUiqLzRM76HxH/nxKpsggAKT6b3lG7eSg23E09Qfs/dAFBBaeU1EwVrWz64NSV3M19H
         uCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789187803; x=1789792603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UA9WVjEDN9IXL+AcnME2x3yVc4Y0zRQ+FWtK13UcSNc=;
        b=cTfwXejOUkdTwTJ7E8pWodBZLUq5fFQ9mPx1iu0UMFK0g3U9zw7OX6V7DbVBSTMbnf
         QOgDOLySRFAK70AKMgSlvr88LWxNvEWRdkbGVuKF034OBra+h0Yxta4z6yDBAEslqCrE
         GuHPvBMaZeZDAwO1attyqeiy4LlBNTKf33K6ED88oadgTx4ejUW/bbFcZKpE0lcAikpu
         l2TMtJ/FS7TRg85JCEFJicSAQUq+Ttdf4vv7GYdpIyd3RfPliQHGb5x3h14xVdUteKwd
         lc8fiM57HhZW7L/qIls4waWx9gQA6FlD4bgsx+ZI3I9bdGuUMiqZoIfqG9BRZvJRjLXC
         JlZA==
X-Gm-Message-State: AFuF++n72F95GncAFDIR9zb3JpnvFL0aUfHlBUAOxXxHLA186AL2V2NQ
	JKnj0A3030KuGOP374y6LgiExKsJ0+YR1CBmOvIG3ZGMXmfpYg2baH89
X-Gm-Gg: AYBFou3xC9njJV8isTkS5EeFsfwp0GFXKkRL8R6Vltkoq7WLbqlT5MxkNSn2BOc1VEO
	uvfjtnBA1wAdWtRWWYgOCseiQ2b03V2COU150KsBaIt+5tqmCob5kgUY6eAbAHcAxgBa3Z2Xipn
	h6jf5k6IAysy7EP7sYTYR87uII5h9261/x1ceyGpAplnULgi9KH9QpFTcAcyh7h0+iCAtZ66+vx
	kXw4sMF5jFZoX05ypBShi1Xhgol7e+XLSIzFdvKQq3pHF3z/nd/ryy8jaAasDKvVPSiq3lAIjx+
	TLDUVi920fePNVL7NuGRq1DNuTBytWVgzZ21RQBOJiaQcE4i6WIjy26YlJCiTefaiJjGr6HN/Gz
	NsLfzQXCeJz0SBbkrWYFYm9sYZ8i2zOP/4HpxrUDG5N5VUn+njjYjQcr/jK50X1TSDLmIThegkG
	6UxoCFEt6MbUDxLwpoowAnSD2uBwVjAtmNCo0RiHI42PCPyF8qCE2VKsO0Hd4s/wV/npxfk9heS
	PdDNDW5n4+LEE43UXyKSDiv+qWF26UkH2H/41raary9k2s36G1uIaWFb6+0rWeOlHI+wlY=
X-Received: by 2002:a05:600c:e547:20b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-49e63cc640dmr46960215e9.6.1789187803072;
        Fri, 11 Sep 2026 21:36:43 -0700 (PDT)
Received: from SVR.localdomain ([158.173.156.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6cc11607sm21988015e9.12.2026.09.11.21.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 21:36:42 -0700 (PDT)
Sender: Semih Baskan <strstgs@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	rafal@milecki.pl,
	zajec5@gmail.com,
	florian.fainelli@broadcom.com,
	arnd@arndb.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rosenp@gmail.com,
	rani.hod@gmail.com,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Date: Sat, 12 Sep 2026 07:36:26 +0300
Message-ID: <20260912043626.437-1-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAsRjR=F7_7M-_tC_u1WRxB4Toj8nbcQh0WeXuNhzCQAs=vbuA@mail.gmail.com>
References: <CAAsRjR=F7_7M-_tC_u1WRxB4Toj8nbcQh0WeXuNhzCQAs=vbuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCMA driver takes its register base and, since commit 552aa843e4c5
("PCI: iproc: Use the EROM outbound window on BCMA"), its outbound
window from what bcma read out of the enumeration ROM. It still
allocates its host bridge with devm_pci_alloc_host_bridge(), which since
commit 669cbc708122 ("PCI: Move DT resource setup into
devm_pci_alloc_host_bridge()") parses ranges, dma-ranges and bus-range
from the device's OF node and requests the windows it finds. None of
that reaches the hardware here: need_ob_cfg is only ever set by the
platform driver, so iproc_pcie_setup() never maps the parsed windows,
and the EROM commit above had to throw them away again to keep them
from colliding with its own window.

Allocate the bridge with pci_alloc_host_bridge() instead, so nothing
from the devicetree is requested or handed to the PCI core, and free it
on the error paths and in remove(). The driver now sets
bridge->dev.parent itself, as devm_pci_alloc_host_bridge() did, since
the wifi nodes under pcie_bridge0 in bcm4709-netgear-r8000.dts are
resolved through the root bus. The window request
moves from devm to request_resource() and release_resource() because
the resource lives inside the bridge allocation and has to be released
before the bridge is freed.

The ranges property is still read, but only to compare. bcm-ns.dtsi
describes the same window for the platform driver, and on core revision
0x01 it points at an address the hardware does not decode. The warning
from the EROM commit stays for that reason: a wrong dts is visible on
BCMA boots, where nothing else would show it. Without bus-range the
root bus also logs "No busn resource found for root bus, will use
[bus 00-ff]" again, which changes nothing else.

With PCIE_IPROC_PLATFORM and PCIE_IPROC_BCMA both enabled, the platform
driver binds the same nodes first and claims the devicetree window. On
core revision 0x07 that is the EROM window, so this driver's request
still fails and the probe backs out as before. On revision 0x01 the
devicetree window is elsewhere, so this driver now probes as well, next
to a platform driver instance whose window the hardware does not decode.
That instance does not work either; the only difference is that the
second probe is no longer stopped by the collision.

Tested on an ASUS RT-N18U (BCM47081, core revision 0x01): the warning
lines are identical to the applied version, /proc/iomem and the
enumerated devices are unchanged.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Link: https://lore.kernel.org/r/20260911191429.GA549927@bhelgaas/
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
 drivers/pci/controller/pcie-iproc-bcma.c | 70 +++++++++++++++++-------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index 06a471f4a..fcae83ed5 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -11,6 +11,7 @@
 #include <linux/phy/phy.h>
 #include <linux/bcma/bcma.h>
 #include <linux/ioport.h>
+#include <linux/of_address.h>
 
 #include "pcie-iproc.h"
 
@@ -31,18 +32,42 @@ static int iproc_bcma_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
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
 	struct iproc_pcie *pcie;
 	struct pci_host_bridge *bridge;
-	struct resource_entry *win, *tmp;
 	int ret;
 
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	bridge = pci_alloc_host_bridge(sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->dev.parent = dev;
+
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
@@ -51,7 +76,8 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	pcie->base = bdev->io_addr;
 	if (!pcie->base) {
 		dev_err(dev, "no controller registers\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free_bridge;
 	}
 
 	pcie->base_addr = bdev->addr;
@@ -60,37 +86,39 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
 	pcie->mem.name = "PCIe MEM space";
 	pcie->mem.flags = IORESOURCE_MEM;
-
-	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
-		if (resource_type(win->res) != IORESOURCE_MEM)
-			continue;
-
-		if (win->res->start != pcie->mem.start ||
-		    win->res->end != pcie->mem.end)
-			dev_warn(dev, "DT window %pR does not match EROM window %pR, using EROM\n",
-				 win->res, &pcie->mem);
-
-		devm_release_resource(dev, win->res);
-		resource_list_destroy_entry(win);
-	}
-
+	iproc_bcma_pcie_check_dt_window(pcie);
 	pci_add_resource(&bridge->windows, &pcie->mem);
-	ret = devm_request_resource(dev, &iomem_resource, &pcie->mem);
-	if (ret)
-		return ret;
+	ret = request_resource(&iomem_resource, &pcie->mem);
+	if (ret) {
+		dev_err(dev, "can't claim %pR\n", &pcie->mem);
+		goto err_free_bridge;
+	}
 
 	bridge->map_irq = iproc_bcma_pcie_map_irq;
 
 	bcma_set_drvdata(bdev, pcie);
 
-	return iproc_pcie_setup(pcie, &bridge->windows);
+	ret = iproc_pcie_setup(pcie, &bridge->windows);
+	if (ret)
+		goto err_release_mem;
+
+	return 0;
+
+err_release_mem:
+	release_resource(&pcie->mem);
+err_free_bridge:
+	pci_free_host_bridge(bridge);
+	return ret;
 }
 
 static void iproc_bcma_pcie_remove(struct bcma_device *bdev)
 {
 	struct iproc_pcie *pcie = bcma_get_drvdata(bdev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
 	iproc_pcie_remove(pcie);
+	release_resource(&pcie->mem);
+	pci_free_host_bridge(bridge);
 }
 
 static const struct bcma_device_id iproc_bcma_pcie_table[] = {
-- 
2.43.0

