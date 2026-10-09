Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134B4D990A
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550327; cv=none; b=a7TMUbXJIA/VUHHLS6p3jV08P35AaiG+B0eN5JRJTnnkGUfTjaTMoELnbgXOpBC1+D1KIw0ha73Y3qAX6eqZSpjZw0Nd13S1mqaDOHMrTLCL8yk4BtOIa7MxzzsFvyVfpXuE/3cY6SI5MsYtFGIvL1816LxRR+5m8ofdFfH8BQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550327; c=relaxed/simple;
	bh=UwboIcLvo8L2QPyEHASS/xgFWR57jyxEQJ+AMdJMRIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3yBIYP5s+1ebq9+C6QWZ8Dw5agiHF+m23BMZdIXdQhUjANWrF/cr1D1XnmScYqCYqptR5PUxjEIDY21RyJE9tnfjhpME5eCPjqiTk6InWTQq9yO0QCZUcYuWrNuXKtYjvyH2t4CY2svlF1xYBBZaoO4IhJmWdGMswaNRx/niGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAnUfN6n; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAnUfN6n"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6df0b02fe91so1245179eaf.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791550320; x=1792155120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r4zoLo6TEGlBfruK7UlHr1Vnlx0k0bueLiUiQyZg9BU=;
        b=kAnUfN6ndGpJnwLKmLLm+h+QLR6n3vffG8FgKn781p9ZtWChx/W9Vi+lsXRFhACD6A
         TAa3B6cP+v+vhk4vIEOmpGc9GHpAAm792vFZSdnwBkyBk4MnuSK1LnFZlANcUJ2ipcZA
         XttPfcWetCXaJBmuckJ4nLtyXErFozsX2qYjq9ApLVxgQ6dMQun9yal7e027r9dQwXKR
         EH4yBge581Qj7rE4G+62eBhOm459bgI8wNVPDYUvKi0BgYJ6ptGFvUcdOlRO53BrvJms
         wQxKaElbwsDtlj7zzzY25t9mN9SQ0OO4u/4UpQhZPECFHHGpz0aielHvso7fIo86SrEq
         t8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791550320; x=1792155120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4zoLo6TEGlBfruK7UlHr1Vnlx0k0bueLiUiQyZg9BU=;
        b=p5BmjfwgbD0scxUA1jOUViOef2pJpAliITBd7Vuc+P+rMxlEe3miPF3xx8whzuACpo
         vyvzDeGQK2CiW/vmJB6D29ZFWs44xb5lwOXoRyZZftBZdmuJNvLj6e+EzooUqVief4C2
         cQ2tD5DIWcCunVd5tERnnPaylvqUg84Ur7z3pXUZ8uT1cJRYe4LplQ/+BeWA2ZWGo575
         0RbAMmcxXV4p6AS/ZqjBMGoHqY4hJ0cL7I1Z1csZDUnTuGhajNvaRIcwpkAzYVCYfcMh
         mhFgbIYp0e+nq5fI6mA4JDbHjn1QLbOf79ru8/9oO+l8jSaXr5BVlKuNF11VwYMWv0fS
         UaPw==
X-Forwarded-Encrypted: i=1; AKwUvBxxQHHwDctbHBo2IUbyZKXwrX81xwQd8+035JLQEjkDkTwfwrHlQCVazZ7W0EGn+rbDUj9Fo0o88Rg=@vger.kernel.org
X-Gm-Message-State: AFuF++mHrDcFpJgLYnFoUQynA6XDH579+2SWO3jst66v3gNjyawaRzyc
	UKJ8M+y69JojBcuy1PHlI/AG2UmV7NMvwD2wKpzzWYEzjm5zH/yn9W3g
X-Gm-Gg: AYBFou0YjrDCGAdNy9vmG2pnYYOBURzUGWc2mTznT5RopPLXYSAbrYOqyfgcurni/Hb
	/Umj33m0iSTCOJgPakdRGq9DH+EvZaVO3XbcCFqfhxwvwPIfzHANNAgx1yOz0OoFjTnQ9dDcrua
	9QzjKvIJmxaDnuF3Ubtbpmh77tHE8TyfNv7Jd4eYvTyLkWb9+QaWie/+7Sq+TwyXtdxnSumu9HV
	ndzqv8S/XqBg03pUizoEH/nF6CMRDs9s83luHyLaAijHdKaqU6Gps/V9zYVJtTWi0VO4ykRJNfH
	bfoWtlIrzpPKNeXiiVuMeSVTBWWDhN2cDvKw0LIEOWuErN4LqGUCXH/pzN7MtYwlMBFYK7ujCrR
	67DHPPesNcBAuyS0wEsyeL4bjjTz5RzyLqnSgMhJY8GlrbT0Dbud3fWJIqaYO619m60hiWm2rCW
	GH2CUoLZ/+bn9R/IJi/DPod51ZmISH0g/iAKq91lZPOyZVZaJfFh9va7IfVtZFHW9/Cmy23RzNa
	3TeSJsI2Jc7DcnIKs+g3asMgS+8g7cFuRHhppKb1M8S0khY
X-Received: by 2002:a4a:e84a:0:b0:6d9:c309:6479 with SMTP id 006d021491bc7-6eee48577dbmr1105828eaf.58.1791550320542;
        Fri, 09 Oct 2026 05:52:00 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a801:250d:38ba:9672:afcf:65b8])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a84a1482sm1514908fac.6.2026.10.09.05.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:51:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3] usb: xhci-pci: Add TUSB73x0 definitions
Date: Fri,  9 Oct 2026 09:51:54 -0300
Message-ID: <20261009125154.266435-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of hard-coding the TUSB73X0 PCI ID, USB_CTRL register address
and the PWRON_POLARITY, introduce definitions for them to make the code
easier to read.

No functional change.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
- Move the TUSB73x0 PCI device ID to the shared PCI ID header and use it
  in pci-quirks.c too, as suggested by Sashiko.

Changes since v1:
- None. Only sent it as a standalone patch instead of part
  of a series.

 drivers/usb/host/pci-quirks.c | 3 ++-
 drivers/usb/host/xhci-pci.c   | 9 +++++++--
 include/linux/pci_ids.h       | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ba158d63bb8b..f670e7aab984 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1189,7 +1189,8 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 	val = readl(base + ext_cap_offset);
 
 	/* Auto handoff never worked for these devices. Force it and continue */
-	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
+	if ((pdev->vendor == PCI_VENDOR_ID_TI &&
+	     pdev->device == PCI_DEVICE_ID_TI_TUSB73X0) ||
 			(pdev->vendor == PCI_VENDOR_ID_RENESAS
 			 && pdev->device == 0x0014)) {
 		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a8889081ae82..54b76e2bddd2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -28,6 +28,9 @@
 #define SPARSE_DISABLE_BIT	17
 #define SPARSE_CNTL_ENABLE	0xC12C
 
+#define TUSB73X0_USB_CTRL			0xe0
+#define TUSB73X0_PWRON_POLARITY			BIT(22)
+
 /* Device for a quirk */
 #define PCI_VENDOR_ID_FRESCO_LOGIC		0x1b73
 #define PCI_DEVICE_ID_FRESCO_LOGIC_PDK		0x1000
@@ -479,7 +482,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    pdev->device == PCI_DEVICE_ID_ASMEDIA_3042_XHCI)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 
-	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
+	if (pdev->vendor == PCI_VENDOR_ID_TI &&
+	    pdev->device == PCI_DEVICE_ID_TI_TUSB73X0)
 		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
 
 	if ((pdev->vendor == PCI_VENDOR_ID_BROADCOM ||
@@ -678,7 +682,8 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
 
 	if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
-		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
+		pci_clear_and_set_config_dword(dev, TUSB73X0_USB_CTRL, 0,
+					       TUSB73X0_PWRON_POLARITY);
 
 	return 0;
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0693e4532a68..030c86dd6d67 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -889,6 +889,7 @@
 #define PCI_DEVICE_ID_TI_XX12		0x8039
 #define PCI_DEVICE_ID_TI_XX12_FM	0x803b
 #define PCI_DEVICE_ID_TI_XIO2000A	0x8231
+#define PCI_DEVICE_ID_TI_TUSB73X0	0x8241
 #define PCI_DEVICE_ID_TI_1130		0xac12
 #define PCI_DEVICE_ID_TI_1031		0xac13
 #define PCI_DEVICE_ID_TI_1131		0xac15
-- 
2.43.0

