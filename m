Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C95477292
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118757; cv=none; b=WXFxZEK5Ruq9Ilh9VdovjeTwCpkGh9354d2JrR1WjsHdJjuK78ioUijheuP+5hwZQ8Aq4eDno2Jha5uBmctUsHdIgGJJ3dhc36BuITBdJps9dba4FYgLDNaWzNYMQugAF4bpQtNZ3iyQKKCgLBCCgBGqFFKJ4tfG9P/+k+l/Gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118757; c=relaxed/simple;
	bh=hcSkAkIghcJU5Anh/2rmQX4w6Beqf0lTTyZuYMH42fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5hLt9KD8lsacqWPZU6RuqORoDB/qUCXHGiwpbuGVBd7llmq0EUcanSHHSYza9vCpVdx1aVXTaAAuQ+TTnhtKKJRBrizOg7n1XBzQX8BuBvD4iPV5TKcUrPoAX6v7/qCKgPkVD/WxIe7FBZ+9gAMlB3KULD4SO0DOmtz1YBt0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPsqBueZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPsqBueZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954d29264cso18904545e9.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786118754; x=1786723554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DY/d6gKFTVZUvwR7r+EZgSjCPiJOiVZZbCY1T/z/Asc=;
        b=OPsqBueZQlaqlhlMtIfmFi4Y/fQNru/8jHEqCmCa0A83DzhSuiv92UQNfdaxzT9FhF
         iE/g8BBp8Aby0bA5AKYvnX+MoW+5Bm/aY/DWhFIFUEdQyHsP+TOGZ8rVl1rgCUTwJ3aa
         inMjjeA3vx2Ys2toE4xK2EE2tuPQANT3O0V7oa+DbDaJVp+o6E3JucySXLPo5IqlMROL
         43TR+wuTfEB3LV8F7q+feQMlhvQM5qviSruoJYnap/hJmLppyl5Gn11wRqo6fHiblwEU
         Qro3672Uua4yH5ieNFXyJTohii8rpF6Wq5XralddY/9pMMwzJH+/QwE6ALkpbOrArTmF
         gWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118754; x=1786723554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DY/d6gKFTVZUvwR7r+EZgSjCPiJOiVZZbCY1T/z/Asc=;
        b=GeWXGrjElFag/e90SOnC+pICzFlRxrgYkxxVkXf96nMB3YwtTOf+YW7VSgCQuEdaIa
         2AePnW8d5n4qs4rmN4LM8eV5Ov/vW/rhlE6yv7BCj40ffXrFtzEvgvReeb5cAcmvKLms
         H090BN8A/FTDXiB9NykfmZrhWiaGE4XYQc0c2pCYj9ugEGZhdshKKxOzYsojrbmKNNtP
         FC5VuO9b3MWmfR7ZQEuOtLk+kYxzFfsxvIzMUpx1BXk9621SH7Ji+BbMJK/KZihDpFJc
         uvBjr+CrbE7Gp9UE719OC8QbF6Rwu6UKPTShZ2cDiEG3y0JxAEh/vi5mUPpJ9A8vWhAu
         VKxw==
X-Gm-Message-State: AOJu0YzuePR0L4CsyDj6nvRe52vz3caBU77Dd5wIPG3Bn4pSEpvXvWd1
	rkW5XdEdQEYrnZu7G2abWM8udEV6I4Ya1JxLlHQllBRtDSVwhcMk8URj
X-Gm-Gg: AR+sD13b8+Po385ahwoALt3v8v9TdA9/3hVSUGNNSNPuzw+eNZWkFANx4rnjNPNc51g
	ZV8UrTu9LzjHlYgTvMZ3gC6ng5aUk6ihF4T5N7/GOn+MbEkxw1z0mooxU/kI7Z23kc6LjS8K1o0
	kbor9+PRnOKKJhL1Cr4+LILxGX54H7QHqHEjbFcXW04Ji9iwooubqAfZZygUULT17wd+hV0G1AT
	6gp79zzWFgoz0rmTSz5OUBCl0Wv5/8kCz+V0EMu534Z0kwUj1+kzy+xopaZ1Qc2E5sxiq+5mGd+
	AhqxYFgCehxdT2S2tIrxtqOjJ9+4No3tyH7yo54jEIWWi2YEkJW8wtOOLd1WqOD3+TVIhpJBRpY
	UwwjEE/yDcfXLisrX841QG+XTDXE9357eHzqCzL0xsOYPQ9C+clgWYApbnKYeCnyJKKEweyvZxh
	bkrNPWi2X0zKZW4qwl9/DuzWp1QVEvQGr4w8QcIUKsppGFp7zPcr8Ppd93xAVHMPVZ5v1Y13/P
X-Received: by 2002:a05:600c:1d20:b0:499:6123:ac11 with SMTP id 5b1f17b1804b1-4996123ac36mr16811575e9.11.1786118753602;
        Fri, 07 Aug 2026 09:05:53 -0700 (PDT)
Received: from SVR.localdomain ([86.106.74.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995428f294sm161481675e9.15.2026.08.07.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:05:52 -0700 (PDT)
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
Subject: [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
Date: Fri,  7 Aug 2026 19:05:26 +0300
Message-ID: <20260807160526.379-1-strst.gs@gmail.com>
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

 - devm_pci_alloc_host_bridge() parses those ranges and requests them,
   then this driver adds its own window and requests the whole list a
   second time, so every controller fails to probe with -EBUSY.

 - The DT window itself is only correct on core revision 0x07. On
   revision 0x01 it points at an address the hardware does not decode,
   and the first MMIO access to a BAR takes an imprecise external
   abort.

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
v2 -> v3: format the two problem descriptions as bullet points.
Requested by Bjorn Helgaas.

v1 -> v2: print a warning for every devicetree memory window that does
not match the EROM window. Requested by Arnd Bergmann:
https://lore.kernel.org/all/d05ffeca-f289-42dd-b454-5a7c7741c6d5@app.fastmail.com/

v2: https://lore.kernel.org/all/20260807035726.387-1-strst.gs@gmail.com/
v1: https://lore.kernel.org/all/20260727140939.389-1-strst.gs@gmail.com/

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

