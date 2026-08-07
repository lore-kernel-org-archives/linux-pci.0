Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EE313E2C
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786075079; cv=none; b=uTfQ0HErTDCfCx/OMQFlbTK5agj+O3M7nrsY1Qa19tgfYa0UMVFWc/s7Eovklva2bxmfNbj9aezT4dBfvWPZ9rzmdYWzjGrCjYrVBXYbp+U3im/1c6UXzucNPR0CdI/bsX/iK/1jglKH3/YnhM5s2OoW6b44kIIFJvOf9NHouyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786075079; c=relaxed/simple;
	bh=IxeqDGev1wPs9EPLAz9TfKcr6xaZ0gXbUjVbETWtZrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPlgVEvu32f3KtyrcFOcnVU06wD74a0cZQJXevGOs5vyTx0sW9dxu2jVsLVdMtisH5mwStE+LQMS2pyjihsNQ7vr6gYuLTCW/zKVx6ZmBcmiHQEM7JEM233dRMqBQ3f7l03Jpcz77eaPgNgkSuvSTzyv365wjKcRGw/996JHafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds3NYm1P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds3NYm1P"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4994c49f588so15922355e9.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 20:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786075076; x=1786679876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBz6oNG/36Qp57t3ZEunGGxMAR6zZhWKYud3RSOdL8s=;
        b=Ds3NYm1PIl4dSCslvOPhdMQLUOy6h6SKw7C9hxcoXxuXsWuRM8tsXE1zsIjN0Etnma
         39MGuDRcGST0zp1YT7UKRg7a4hRqFey/cGiD5+ma5qkyj7RaPHK+4Z/QVL7+fB4ptvF1
         BSuzXJrCQH972yDdpYhuwivTZtNPlu2GUTkJ8qmAIxw5sazuLGmSlBCHFi1x04b/j3G8
         /IDZz0TnGS+AnyUAzyJVvLn1JsVPWY52pL7OKQoPkHxMp31EGMjtvIECUbnYJNxNg4lO
         RqN1U/DpRNDIlfs9PquWONGJsEeJtZjFm6Lmx//vM2/BshlAsRnKnEI70OsrS8ANYqu5
         p9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786075076; x=1786679876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBz6oNG/36Qp57t3ZEunGGxMAR6zZhWKYud3RSOdL8s=;
        b=arfc9B0i18ADzIFphtZTtbMehNWPpTryJUqvEVqxC9HDmP5bxuGsHYJemf1jy4QdLg
         5TZ9ZMWdg7EeAm5GUmF7vNWbzOELrylrBkGCLRhlcrR2oKYQwcWT4FGaVlEyuJqzcYcv
         e//kK+sKf8ylChYGqh5/PAzlPopHx5NVyhqntwaieQTFvWpWdBRVDifdl3DL6y+NTADL
         dkP8Yj55FcqE/pWn5zvyK36cXQ04SzK8F5LLBCVYUhG+gb1zXL/4UlnA8AkQNm4LnbzT
         JjBjcOk235MvEsIXw1B9OwZ0G0XTH42T2RrB1u0lRwClQ+FcQRBkwunTLwhPWjO2NNHS
         O4jQ==
X-Gm-Message-State: AOJu0YzPRWwErC+ULqFZHWIgciveS23KnBKfUSzWDgXZCXKVwfxMNA9g
	OpuHE2LSrEH9Tz27OndVqBiPTG1xx3x/2NDbffoXzK2qLvmb1N80WvIY
X-Gm-Gg: AR+sD12FBBg9Gb4wp0zbfUTXPXvhgXGl8H3ym4z/ANTw+nuvFt9bN4kIzkXJa2QUptb
	vpTDgrFjr0Wop3shXAwPiNvWn6C/MCG68cVneK7uTQ88weAqISUrloiNqAjnagyylbwWeVhxbCe
	w5ZXjvW9ujHdJp3I/1NsL1Pgk54QZPu81Hb8h8mUM603t5a6rCp3TfvjxET0FdcrCk8/cpDUI0o
	ldDzFFNSlLDv+GjGy+RTYR/DPF9vjdgMHx8TixPbWHIfqGvmqC6lpr5cm1vBsN59+hfxhAfWRL6
	EEW+pXqX8JbGZyw58HQCvgghFLgmGkj/zCPpQHvrxy4D6Ix5n2dyhjTOtzv1+qDu0mUQHTMXoDl
	jSwwd6Y8aciLsyEhPVo+tHdX7N+Tgeslk8cnDnpzITeyOe/wGqhNQz0RCZcHdi4PTMbNZXmfisn
	gBUw5felb3kpSWRPZMHLX3KwnwjRGUamHCHGMQFL0jI4ay4fs18Td0bBBhc+6zlYYDnYsz4MaT
X-Received: by 2002:a05:600c:a48:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-499553f4c4cmr105550845e9.8.1786075076143;
        Thu, 06 Aug 2026 20:57:56 -0700 (PDT)
Received: from SVR.localdomain ([86.106.74.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm1055165e9.1.2026.08.06.20.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:57:55 -0700 (PDT)
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
	florian.fainelli@broadcom.com,
	arnd@arndb.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rosenp@gmail.com,
	rani.hod@gmail.com
Subject: [PATCH v2] PCI: iproc: Use the EROM outbound window on BCMA
Date: Fri,  7 Aug 2026 06:57:26 +0300
Message-ID: <20260807035726.387-1-strst.gs@gmail.com>
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

When a dropped window does not match what the EROM reports, print a
warning naming both. The mismatch means the devicetree describes a
window the hardware does not decode, and that should be fixed in the
dts rather than ignored silently.

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
v1 -> v2: print a warning for every devicetree memory window that does
not match the EROM window. Requested by Arnd Bergmann:
https://lore.kernel.org/all/d05ffeca-f289-42dd-b454-5a7c7741c6d5@app.fastmail.com/

v1: https://lore.kernel.org/all/20260727140939.389-1-strst.gs@gmail.com/
Applies to v7.2-rc5 and unchanged through v7.2-rc6; the file has no
commits in between.

 drivers/pci/controller/pcie-iproc-bcma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index 593418c2b..06a471f4a 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -36,6 +36,7 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	struct device *dev = &bdev->dev;
 	struct iproc_pcie *pcie;
 	struct pci_host_bridge *bridge;
+	struct resource_entry *win, *tmp;
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
@@ -59,8 +60,22 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
 	pcie->mem.name = "PCIe MEM space";
 	pcie->mem.flags = IORESOURCE_MEM;
+
+	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
+		if (resource_type(win->res) != IORESOURCE_MEM)
+			continue;
+
+		if (win->res->start != pcie->mem.start ||
+		    win->res->end != pcie->mem.end)
+			dev_warn(dev, "DT window %pR does not match EROM window %pR, using EROM\n",
+				 win->res, &pcie->mem);
+
+		devm_release_resource(dev, win->res);
+		resource_list_destroy_entry(win);
+	}
+
 	pci_add_resource(&bridge->windows, &pcie->mem);
-	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
+	ret = devm_request_resource(dev, &iomem_resource, &pcie->mem);
 	if (ret)
 		return ret;
 
-- 
2.43.0

