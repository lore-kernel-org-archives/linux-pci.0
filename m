Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF23BB12D
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976473; cv=none; b=ThBhUnexJE6HaOuanG9tHh6u9Ypp2PNrguJkOyjbx+Qo0fVms+ee/8+HT3YRuoubWpOVd+wvBA7XBUVi3NGatdXnhS8UNmzUIctB5suHOGVyDWgc9AAbrFHAiRUqZZt59mMn+8AQ+5MVBYMn5YBd9g84utzGFsq15ZKChICNtIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976473; c=relaxed/simple;
	bh=HmPgbyk7nXjN3qe/UJMU7H7kyJ8BwWfT2ekvbiP/SkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs0XG+n3PvUkjSmyMmJSbKPoTKkkbj3w+LR8kWRvA7ni+6JIKxVtnoZ0Ds9JNLoGonSuspWQYRSripd+4N5ZfcaaZZkk/7c7K3ZRSoAabgxk9n5UF52SJQXFtO1BATps/oGYfIzNkUiaevlgyyjcGCuL5E+W2uMwLQKVYHYDIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPmTgFVu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPmTgFVu"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so902548a91.0
        for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784976472; x=1785581272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtMno+Tompl0pn7FTblYvM0TQFHt1IZrgraUf3aJQHk=;
        b=pPmTgFVudphssp00Al/mvCQ7G8UjOCyQnMWf7l/cAitmOou2aIlIp4ZaSzEp20LogC
         TphzMabLjTNxs1H5wYzMeMgF84Q4MqxDMTfPPHn7P3BujHj9HYaHo3OQNjBR512IWqDm
         AVG1jePWU+KST6ushdH3NZDlU2hwz0veZ/S7fuinRvX8b7M8SDg9I2HtyfxHGnR3DjcI
         vIb9wfgKRsw+76FPkXJL+oZ451+q1Ue7KkTz0KJiJn1ymfIV+pb/FrZUIUG051k/Br3B
         8C2RDwP8RrlJysY2kXTKAq9W9imD7EkrmLsiE2SGiQ2uK8uKy/QTQ7g4+2LxOQ6kBIaD
         fyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784976472; x=1785581272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtMno+Tompl0pn7FTblYvM0TQFHt1IZrgraUf3aJQHk=;
        b=Fil+3qzoDJqBBlSbvIptNfdNMCdDSKWYxc46RRGe99NbXJziwFc2pC4/vIjStUhiQs
         +eP+LdOq9R+HB2kBjYVR993ltjqb0zl22bGkj/3M4hTfWXpQKfh1EW12CrWCBZ7gvaxh
         TpHrCLkmQJkYgpowOU2VyQEZr0C5tmTVHq9Zjwo2nYvoOVtSvaJt49BcMY1+4WV/3Brf
         D9BAH8MwZGBElpkzO5JWXIdscuXZkQbhsZ/dJLi3eKQp2cRjWjFEeQT7Ryu4fyxTbwCD
         XJVm/7PhZycj5xG+xf/3iihYio+YFWKJVqZJrlmScRoJ+e8amIfhPTb/gtZ7R3qnvS4Y
         cXdg==
X-Gm-Message-State: AOJu0YzHQ3skufdEtCujBYByRdmn3Y31ctKC0SQCp4TXlQ92petv+JWp
	Tme91y4SC+gWvit7dr1HdcU15O0OcVcCsh+3MIGcO9E0+2sIYXXFp+Bl
X-Gm-Gg: AR+sD12bcd6URV9LldJ73DElSNa6jN3ixHbzb9pltvfyaLJbugCcmJ5jXmIUtDtEqbv
	TtvhxotwUp3hNgMpBRTZJ87fIc6nIiQoVPzYEI01Jk6h7pdSHUb78gYGdJ6zcBHuYjJX96dUgT9
	YE0K6YOuFYiR6Yk4oIglUdzYGZ8SUarNlnFh/iruawNItu1vwyd2oXBGRUwyy01lq6ObFvbNVAW
	/UBrQNIVn9BnS1f9zzx9r6ep/+sc84GXadu42SurasGrcSHRrMsJVdli9Hki2zQU+UwwCGr2vnN
	OWCIhQXqazlmdSi95+G5Jn8ea72IPTPzXaTQgAUj1HLyQqmvc54NjwHhz3mSmsf7cUhFNqEszhM
	zXyMSsUQl7SYEXvgnIhucvHxNnr6yJjocbv1wZRQDFs3jnsMUe7ZDiyufR1EUAZL/lZGv2XQaQr
	P7bFG6LWSPZBQ1
X-Received: by 2002:a17:903:2c07:b0:2c9:d277:2cdb with SMTP id d9443c01a7336-2cfdf3738c5mr14159135ad.9.1784976471611;
        Sat, 25 Jul 2026 03:47:51 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb5asm8360735ad.8.2026.07.25.03.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 03:47:50 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tarunsahu@google.com,
	djeffery@redhat.com
Subject: [PATCH] PCI: Handle dev_set_name() failure in pci_setup_device()
Date: Sat, 25 Jul 2026 19:47:47 +0900
Message-ID: <20260725104747.226575-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_setup_device() calls dev_set_name() but ignores its return value.
dev_set_name() allocates the name with kvasprintf() and can fail, leaving
dev->kobj.name NULL.

Enumeration then continues with an unnamed device.  device_add() rejects
it with -EINVAL because dev_name() returns NULL and pci_bus_type has no
->dev_name callback, but pci_device_add() only WARNs about that failure:

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

The device was already put on bus->devices before device_add() ran and is
not removed from it, so pci_bus_add_devices() later in the same
pci_rescan_bus() call picks it up and hands it to __device_attach(), which
dereferences dev->p.  device_add() freed dev->p on its error path, so this
is a NULL dereference:

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

Propagate the error instead.  pci_setup_device() already returns int and
both callers, pci_scan_device() and pci_iov_scan_device(), release the
device on failure, so no caller changes are needed.  Release the OF node
first, matching the existing error path for an unknown header type.

Fixes: eebfcfb52ce7 ("PCI: handle pci_name() being const")
Reported-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87bb32e345aa80c0554b
Tested-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com
Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
---
Found by syzbot.  The reproducer is the one from the report, unmodified.

Tested on 48a5a7ab8d6a with syzbot's config for this bug (x86_64, KASAN,
CONFIG_FAILSLAB), under QEMU with "-machine q35 -usb" so that the
0000:00:1d.0 the reproducer removes and rescans exists:

  before  fault injected in dev_set_name() -> "pci (null): [8086:2934] ..."
          -> WARNING at probe.c:2768 -> GPF in __device_attach() -> panic
  after   fault still injected at the same call site, no unnamed device,
          no WARNING, no oops.  The device is skipped for that scan and
          comes back, driver bound, on the next "echo 1 > .../rescan".

syzbot reproduces this on arm64 too, at 0000:00:01.0 with a virtio device,
so it is not specific to that controller.

Two things I noticed while working on this and deliberately left alone,
since they look like separate changes:

- pci_scan_device() releases the pci_dev with kfree() rather than
  put_device(), so on the existing "unknown header type" -EIO path the
  name allocated by dev_set_name() is leaked.  That was reported in 2022
  [1] but never applied.

- pci_device_add() ignores device_add() failure entirely; the WARN_ON() is
  all there is and the half-added device stays on bus->devices.  I built a
  kernel with [2] applied (it stops device_add() from freeing dev->p) and
  the NULL dereference above does go away, but the WARNING and the stale
  bus->devices entry remain.  Happy to follow up on that separately if you
  think it is worth doing.

[1] https://lore.kernel.org/linux-pci/20220817084444.2876059-1-yangyingliang@huawei.com/
[2] https://lore.kernel.org/all/20260716230411.2767394-2-tarunsahu@google.com/

 drivers/pci/probe.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..474c6cb327be 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2052,9 +2052,13 @@ int pci_setup_device(struct pci_dev *dev)
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

