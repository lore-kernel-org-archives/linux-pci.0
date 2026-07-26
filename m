Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F72376463
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058338; cv=none; b=H3TzjGfjdSybRVZkSvO/lbepaQCqfx3GVBIlpqAxU2BOvnOQTvNzm3ItgtCZHOhwZ8Tz/V/G1ciJbWYWnEp9VRvV5mALvLcwavvbGVslCgEFZ6P4Jt+toficoI6Rxv4in7mwVrC8W84GQHzQtbDlcdrCpkQyEVgO08TWGxufqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058338; c=relaxed/simple;
	bh=fG07hrQ1l48X770cHF8RcdRU2TsHjaQy+DZ7fXjGbqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN0vCjCJGsy/xISxohjnJb3PfO0Z6jB1rAr0AbmZVnskuJJX+NS1KLe0Ce+pC3rwy3Lmzwa4dZ9a7+Kfw4/29fui6nOS9Kt+BDXyzDHxzkOGAPsbnKWL3/SZDkpKX9DesmsZV4/hSP10QMjt9cAdoQu6L7vhuCL+bXXtd/581rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0knP7f3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0knP7f3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1782890b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785058337; x=1785663137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FQOVIwsk3OijID3nDRUAZqLvVmX/Gwe/ia7ILr7PvV4=;
        b=J0knP7f3t8K1GiMVpH5OJGn115ahZPPHz10JGPUsHO0vaLrDWxjotSivuG7ScnQ2Zc
         8qjC/bJS6gAMJrcXSareo/AUNzmSCeYa2Wsy+Q9SZC85C6sQPQvgGPpdheuDR2XGcQPS
         u8Vf0/SVejdoqEeG2PTlnTrRiMPb0/gpbQzJBcJhCtUg1OyFA5vVgouI5zmkKOwuD8gC
         rFagrKy1ApXAv7yUY3cQwsm8/KAOJVqdlGLzz7v8ayqzP5VljJ9ap8w6BlVaT3f4yKKM
         a0UxJ+VB4xcmq0ZRmFvKYOksvI+xbNc9alymn7o5UcWyGh/g+vB6dwRvPICmsPhPCYo3
         O+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058337; x=1785663137;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQOVIwsk3OijID3nDRUAZqLvVmX/Gwe/ia7ILr7PvV4=;
        b=Mag51afcQaBrxeFkmnIv1YKwZTdMOWDwxuN6ybJ7JBCjMMdRih9lnSmbLSTzM4zmad
         PWletqjPANirmSFWMxsWwEJfqVgd9U+YHh2DJ4Ox+ZqszCCJfQpTBb84IuAShuMXd3yH
         pDWsTYfkPDxu97k78V0y+iGKH1ouy7NivLGhhcuxtYygzJLh9xrvJ43TsE4kikK+PK7q
         UM8lFRsoKL6otAKqvItYebdvGtmd52IT1XeG0X8pPSexKTvBMJhiMBSlNP3gIcWytLmG
         XQieSuCywF97W5S9cuYL+8CAjZ6s/VXEh2p9MeH+FPBOG9pJgvgOYNM/zrnT5OPIUvLH
         52bg==
X-Gm-Message-State: AOJu0Yypk/bgQjpjaKzwUp7bF9v/KJMHym/qAIVvbXksILFnJ+p1CJeP
	jZo18r8jMnlBiStkwLYXC0ezJOECUvXaSW70/U0sak4LBxbCwD/e+CBP
X-Gm-Gg: AR+sD11iu+UZSSkaKX3gj2f2CcHfP6G+TrLr+XMUIAqpyqghPXLdBQuYiS/kPh88Al0
	O3QPDC4FJv0bx0ExLIOf38b+ELy30ym5uzPZWc6nV4EkX4P11nHb4A52S4EfdsriEH+4ID+4v/+
	H/Pq1rbw+4ROZ0pBiAH1BfHDznSTMcSTYqYfnlPzhh1AYlkuXCxfivkqt/HIuxW3Hyryzf+tNrX
	fMZ46GLO1K2X6OcunFxQHfVpypzoM6UzTyxafdMAdNa+T33H8dEcBdtsxC2Y0q6IBaKQAjDOr/f
	yhNp7dlmwOozqHCfulIbiZ3g3syvgu0PrkfKCBOLRRFu9SESN0YibwNbVVo1zOV3ZsgNEJK+5lR
	4cXNS84HKAUy62IaIPhEVsddRdUuwNoF9FvnvEZF7SP/Hk0jKLuQsNsqN+oiib43vUnFWOgaJaT
	OQ2Q==
X-Received: by 2002:a05:6a00:1ca2:b0:84a:2e5f:d697 with SMTP id d2e1a72fcca58-84e5949d58fmr3505697b3a.33.1785058336459;
        Sun, 26 Jul 2026 02:32:16 -0700 (PDT)
Received: from ubuntu.. ([2001:2d8:72ac:5ae4:b4c0:11d6:e62a:f791])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1448sm1731781b3a.30.2026.07.26.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:32:15 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tarunsahu@google.com,
	djeffery@redhat.com,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v2 1/2] PCI: Handle dev_set_name() failure in pci_setup_device()
Date: Sun, 26 Jul 2026 18:31:59 +0900
Message-ID: <20260726093200.146111-2-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726093200.146111-1-rihyeon8648@gmail.com>
References: <20260726093200.146111-1-rihyeon8648@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_setup_device() calls dev_set_name() but ignores its return value.
dev_set_name() calls kobject_set_name_vargs(), which in turn allocates the
name with kvasprintf_const() and can fail, leaving dev->dev.kobj.name NULL.

Enumeration then continues with an unnamed device.  device_add() rejects
it with -EINVAL because dev_name() returns NULL and pci_bus_type has no
->dev_name callback, but pci_device_add() only warns about that failure:

  pci (null): [8086:2934] type 00 class 0x0c0300 conventional PCI endpoint
  pci (null): BAR 4 [io  0xc0e0-0xc0ff]
  ------------[ cut here ]------------
  ret < 0
  WARNING: drivers/pci/probe.c:2768 at pci_device_add+0x133b/0x1810
  Call Trace:
   pci_scan_single_device+0x1d0/0x240
   pci_scan_slot+0x1c9/0x7c0
   pci_scan_child_bus_extend+0x6b/0x7b0
   pci_rescan_bus+0x18/0x40
   rescan_store+0xfb/0x130

The device was already added to bus->devices before device_add() ran and
is not removed from it, so pci_bus_add_devices() later in the same
pci_rescan_bus() call finds it and passes it to __device_attach(), which
dereferences dev->p.  device_add() freed dev->p on its error path, so this
is a NULL pointer dereference:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
  RIP: 0010:__device_attach+0xb0/0x4d0
  Call Trace:
   device_initial_probe+0xaf/0xd0
   pci_bus_add_device+0xc5/0x100
   pci_bus_add_devices+0x9a/0x1f0
   pci_rescan_bus+0x2a/0x40
   rescan_store+0xfb/0x130
  Kernel panic - not syncing: Fatal exception

Check the return value and propagate the error instead.  pci_setup_device()
already returns int, and both callers, pci_scan_device() and
pci_iov_scan_device(), already release the device when it fails.  Release
the OF node first, like the existing unknown header type path does, and
update the kernel-doc for the new return value.

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Reported-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87bb32e345aa80c0554b
Tested-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Assisted-by: Claude:claude-opus-5 sparse
Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
---
The reproducer is the one from the syzbot report, unmodified.  Tested on
48a5a7ab8d6a with syzbot's config for this bug (x86_64, KASAN,
CONFIG_FAILSLAB), under QEMU with "-machine q35 -usb" so that the
0000:00:1d.0 it removes and rescans exists.  Without the patch it gives the
WARNING and then the panic quoted above; with it the allocation still fails
in dev_set_name(), enumeration skips the device, and the device comes back
on the next rescan.  syzbot tested it as well.

The report also has an arm64 crash at 0000:00:01.0 with a virtio device, so
this is not specific to that controller.

v2:
 - Fixes: points at 1fa5ae857bb1 rather than eebfcfb52ce7 (Krzysztof)
 - update the kernel-doc for the new return value (Krzysztof)
 - say kvasprintf_const() rather than kvasprintf() in the commit log
   (Krzysztof)
 - pick up Reviewed-by

 drivers/pci/probe.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..3e6f0eb7d456 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2010,8 +2010,9 @@ static const char *pci_type_str(struct pci_dev *dev)
  * Initialize the device structure with information about the device's
  * vendor,class,memory and IO-space addresses, IRQ lines etc.
  * Called at initialisation of the PCI subsystem and by CardBus services.
- * Returns 0 on success and negative if unknown type of device (not normal,
- * bridge or CardBus).
+ * Returns 0 on success, -ENOMEM if the device name could not be allocated,
+ * and -EIO if the device is of an unknown type (not normal, bridge or
+ * CardBus).
  */
 int pci_setup_device(struct pci_dev *dev)
 {
@@ -2052,9 +2053,13 @@ int pci_setup_device(struct pci_dev *dev)
 	 */
 	dev->msi_addr_mask = DMA_BIT_MASK(64);
 
-	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
-		     dev->bus->number, PCI_SLOT(dev->devfn),
-		     PCI_FUNC(dev->devfn));
+	err = dev_set_name(&dev->dev, "%04x:%02x:%02x.%d",
+			   pci_domain_nr(dev->bus), dev->bus->number,
+			   PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	if (err) {
+		pci_release_of_node(dev);
+		return err;
+	}
 
 	class = pci_class(dev);
 
-- 
2.43.0

