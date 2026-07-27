Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C172367CF
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161389; cv=none; b=t1ons/dFNvfn5bA+sSrO45nJuSERvrNzIgc8RnWMaOJ/nhqQL6PqKfoJYNJ8TBx1Vrx5x1t6gu+kyLJfoGDQqXvgxAVBApHu92VT2e9WXAEPn7RRFVf6VYb2QmcmZqbyeN7/wG/yZjgo2uxOqwjGrbH35VkvOlBvkasmn4rGVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161389; c=relaxed/simple;
	bh=3WIQJvc9lnLLSeKOoT5+1ZMRLYYJBqxWavcaabtTA0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4HtUlsLElWAzUzLpbznMjGbQakGMOgUMsuB/fhoKnWbtsFSekVyXvehBiIgOlNijrPPOqOTGx8Mvn0oZUebDGDA2v+wueiGgFTcnrPZtljHNepx93MaAYa69iaIdHObnpHp/3sLLBZgl0EFriwn3JzStjWSp5w9ON2LcA0rwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHpZtgVV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHpZtgVV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so4379451a12.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785161386; x=1785766186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZQGufv8V5UALActQvoi2xI1X049Urg9KaUNIMjb1xY=;
        b=IHpZtgVV1xrqBmS1aDLg+OBMUCkEQv2jUCowO03QR0owR5yB2l5P0qdmct2nxjmyOS
         G1GVQi4JqzLZun/yoYcRg+MR8EqlE7jH/gvV29rSgu4xtNBHP6jtIBA9DwxK5VrAQ68G
         a4KiGsrm9GgbZLQjT0ahhRapwmB0RH0NL3ocXIbihlpm8fpbisfxdW94sdOT6gMyHPVE
         X8PWwHoqzXeuoJ+lPYWF/Yxf8cEzh7QPT3kwnNqnseQipXPxQWSwYCDtiUVb440yHqL0
         G+lWIFs7BcKgdCAh7xDbct6FixNOUu5WAcooLlGi6rbXQZUgmH95ZO84EPyyxvsryG0H
         IZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161386; x=1785766186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZQGufv8V5UALActQvoi2xI1X049Urg9KaUNIMjb1xY=;
        b=XpMLbH7qm1s89AQyKaG0E3p1f5oi3O5rxYvwbw7rMQGSgR9E5vE2uOQeRvwG8p1jKQ
         qdkJ+H9HqXxwpng5ZIrqm8o/9NKvt+mYg6A4a40CgLc642PHKek3HqAL5D6ny8hIJxdb
         QT0sOb7Enw8MsRbN6dlzGsrRlx2ZLC43BmRbS/3rCrgIHsyCkpqgC0Er8wZmP/8oDCMk
         VB+2ZbI2ygMtWDRsuakwTywpl99WaQI1S/6dUWNN/tlibnqPFZ0KqdqORl8XLwYj60Cl
         Puk62iSvozlA+sb/HPDpsB6lSnqS6QOfYXdz9/KWPRDNAvl5ve2DdTZ94nf0pywrfhf9
         b22g==
X-Gm-Message-State: AOJu0YzU8rYCGnhPRGzciXE1GSWwaXYEQAcvQDCDzMz/+NcHXDPpz6MZ
	v80eAxfiOqzSbCGWLh1b+dyXTWXgoVpHPVgu07uEcjN0mpY9MT4FYaDo
X-Gm-Gg: AR+sD120yG2JeL8chH3nBg43kCOtFzgpFQEPwjQ7WGBpgAgLcgvzmY3/VAmniYFCBle
	nJa77apjFNnuTXcxgyS8Wzb/GjAfWxG+WtgHQ31oREJMCcx4X5klc5UI9a32QM8S5wdplAFTOK5
	oQdKTe+ZVIz1sI7E59DPRbqfSFGyEQTvlJkVMlH8EV63sj25pNt4Y7aRE62jykFkvl4pmWmysbf
	twn0JKUWv2J/DFOMyKQPybLM4fpPZj+HKDdpj8v2o17t/j98ew7wNcuofM+TgFcW64GeVbvd4Fx
	TUgecQlL6fSOZBfbjc0ijw5Zub7qVx1ZCPeNtVvN6TbSdBbpr311xLlEPzKvsjSrk+FByKeJ1+G
	vsFFTChAsFgp5aZlu67nWjB4dz9WQjcaXnq6aDMAKIjxtEPsXkfV8AjUWOGRGvTYt6yxtUg+T0P
	KFrdtEVQ==
X-Received: by 2002:a17:907:2683:b0:c16:7969:12be with SMTP id a640c23a62f3a-c1f1f0bbe1amr399763766b.31.1785161385818;
        Mon, 27 Jul 2026 07:09:45 -0700 (PDT)
Received: from SVR.localdomain ([185.189.114.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac6ff3sm658071166b.19.2026.07.27.07.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:09:45 -0700 (PDT)
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
	florian.fainelli@broadcom.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rosenp@gmail.com,
	rani.hod@gmail.com
Subject: [PATCH] PCI: iproc: Use the EROM outbound window on BCMA
Date: Mon, 27 Jul 2026 17:09:39 +0300
Message-ID: <20260727140939.389-1-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
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

devm_pci_alloc_host_bridge() parses those ranges and requests them, then
this driver adds its own window and requests the whole list a second
time, so every controller fails to probe with -EBUSY.

When the DT window is used, it is only correct on core revision 0x07. On
revision 0x01 it points at an address the hardware does not decode, and
the first MMIO access to a BAR takes an imprecise external abort.

The enumeration ROM reports the correct base for the revision actually
present, and bcma already provides it as addr_s[0]. Drop any memory
window that came from the device tree and use that instead, requesting
only the window this driver owns. This makes the driver correct whether
or not the DT describes a window.

The same commit also added compatible = "brcm,iproc-pcie", so these
nodes now match pcie-iproc-platform. With CONFIG_PCIE_IPROC_PLATFORM
enabled, which is the default on ARCH_BCM_IPROC, that driver binds them
first and this driver's probe fails inside devm_pci_alloc_host_bridge().
This patch fixes the configurations where the BCMA driver is the one in
use; OpenWrt builds that way, with PCIE_IPROC_PLATFORM disabled. The
platform path takes the DT window as-is and has the same wrong address
on core revision 0x01, so that side needs a devicetree fix either way.

Tested on an ASUS RT-N18U (BCM47081) and a Linksys EA9200 (BCM4709),
both core revision 0x01.

Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")
Tested-by: Rani Hod <rani.hod@gmail.com>
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
Applies to v7.2-rc5. Related DT-side approach:
https://lore.kernel.org/all/20260628231156.1254012-1-rosenp@gmail.com/

 drivers/pci/controller/pcie-iproc-bcma.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index 593418c..f0b8d90 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -36,6 +36,7 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	struct device *dev = &bdev->dev;
 	struct iproc_pcie *pcie;
 	struct pci_host_bridge *bridge;
+	struct resource_entry *win, *tmp;
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
@@ -55,12 +56,20 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 
 	pcie->base_addr = bdev->addr;
 
+	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
+		if (resource_type(win->res) != IORESOURCE_MEM)
+			continue;
+
+		devm_release_resource(dev, win->res);
+		resource_list_destroy_entry(win);
+	}
+
 	pcie->mem.start = bdev->addr_s[0];
 	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
 	pcie->mem.name = "PCIe MEM space";
 	pcie->mem.flags = IORESOURCE_MEM;
 	pci_add_resource(&bridge->windows, &pcie->mem);
-	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
+	ret = devm_request_resource(dev, &iomem_resource, &pcie->mem);
 	if (ret)
 		return ret;
 
-- 
2.53.0

