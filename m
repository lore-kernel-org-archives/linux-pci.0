Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555727;
	b=SQrDl2r9aEDKl+qXMNeE4TrrnRxj64qmrLUAObmu7sEeemG2naVSRpDwDd9cfvcOzozL
	 2TnYINItTUR+86WomSNQx041JvJdqlDNY7VagFOfvAzzB1x+bWj1wyPhMesYvrCTcikFi
	 7S6KbzSFB7Cotf8SsdKGm9IMLCk9ApG73ayGBcWKY3/FuK4yLHdIMMWqW1HdBn7verIWr
	 X+pmxRUJlaldXlkXUg/XxDpWyo4GWSkBZbwLPGASNziqCbDzsB7d7SD5NeqMeq/gOsqr/
	 J0zWH4TJ9aW57zeWTLe7Phmhhr8YKlBCOQ8CJa77601Meogyc/jikf6TCv/K3GDrtvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LH7xbAaioyaoYiHQ6xeOXhOEgpjuNa84XhYKEVkAJ48=;
	b=DDFKqB2Y9b4CV6AhTUo0o3Zy7wcLZzZPfA7dhmRI2qiL9KDJKl7X9aYrbg8IvGJmqkSY
	 toJ80F9HyRgFFkWqBtBmbURfFS8K+qMQbt3Bx48P02hjL7wLVX25o9YP4R7p4wVQq0TGm
	 Cqu+u2Uu7PYxWarmnyJW93egIYdwjsWKd1SnF0vfcRX7BmyN7ZBiU2/H+VlIcUtkyY7bq
	 Re6vin2Hu/28hPXfmpbGZdLXYvYgl2jtOdjydMJ4xd0Ozwvb1avorLQANE8u2ScOTCN/N
	 pik5phn1eKWoGRrNscTp79j0QzqXj89BWpbeQUFm86tBr+4YtuocwWYAF2tYgYdffUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9ZC6EjX;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3501606A323
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 21:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3501606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9ZC6EjX
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c734afb8deso5053319b6e.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795555725; x=1796160525; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LH7xbAaioyaoYiHQ6xeOXhOEgpjuNa84XhYKEVkAJ48=;
        b=f9ZC6EjXRbzHoHel5Gs2YLlS6npZo8QaHMvOOt8bTGivYZ8bi2I2rSSM2c8r5x9ygO
         VnttM9J9WEcAz7kd6hJwBH7ETT8GytejJahVu9kAoyn1+YvIMs2zWH+6V66uW17Lk5Rz
         EU2yMoeL4YZKqWLWYpgCb++ctuau6x221iaLl1mOD2fjU75Gpppvm7TV9BfSXmthkuql
         slPDxe5OeX+VdQP/HaQKa94c0cpeFKZS379dqngMBYmak5yqAGPYUQCB2o7XXWZRfegS
         doeHNZTDflxJEdJySianvOtWPL4U3mnGT1mAJKPI08SKTL31tQIMjFhPclMEha0L1TQh
         zHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795555725; x=1796160525;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LH7xbAaioyaoYiHQ6xeOXhOEgpjuNa84XhYKEVkAJ48=;
        b=SBAtqa0rY0xNXogvp/BRkGTRmyI9fqSthMuaPhWZcCuET5T79oX9ZcoM+hN0E9e/3J
         /Q2jioPfarO3RPgxhhvB9SsrOW1eCVnzrhx7BWeGLENliXsXdkOV+MzXXL7FCpf+bJn4
         tdNJtM+l/dhNYLB0oTV+W5ka+4dsaWjpRHhsmsvjMsFdh74T1zbKUuBP9Az8k3T0iqwZ
         IXrkrpSI5/kBG/qSewMYnA05YxhllguwNw54dBL/yQGjGsn1kimA2lkDQvBE2IxAYOdK
         uucvlDopyCkJz52KAyKb4CvCOB/5AINTGYdt1m1kHOKclGj9QgOFK01czrsdkgzjDseb
         yVLA==
X-Forwarded-Encrypted: i=1; AL+hErG9FOdOiqg+SXm6980bIAGS7wED0omS5T+OKA3Xvu7dUgqmNRKees4LMYfp4uozVVWsbcQ0xubXv1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VCJX2O8D0u7jw7XOkuUmTbzjr0/5RCX8uZHq4Xj2wYrHxXj/k
	PXYG9yS+TFCwpO91MP6FAMDUEBAZXfUH2GrznSNSEBXc94exXDOjO9NxB/a7UnXosB+xpRdm2AS
	wlO869/rYbKAiRw==
X-Received: from iojj12.prod.google.com ([2002:a05:6602:820c:b0:9c7:7732:c3c1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:151f:b0:4d5:295c:a82c with SMTP id 5614622812f47-57a0c9c65b1mr17326090b6e.57.1795555725290;
 Tue, 24 Nov 2026 13:28:45 -0800 (PST)
Date: Tue, 24 Nov 2026 21:28:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124212842.1934651-1-skhawaja@google.com>
Subject: [PATCH v2] vfio/pci: Only lock the upstream bridge if the reset may
 need it
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Anthony Pighin <anthony.pighin@nokia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ionut Nechita <ionut.nechita@windriver.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
upstream bridge before resetting the device, and skips the reset if the
trylock fails.

All VFs of a PF have the same upstream bridge. Take a device with two
VFs, both used by one process. When the process is killed, both VFs can
be released at the same time. The first one takes the bridge lock and
does its FLR, the second one fails the trylock and is never reset.

The bridge lock is only needed for a bus reset, which is done through
the bridge. Add pci_reset_function_needs_bridge_lock(), which returns
false if there is no upstream bridge, if bus resets are disabled for the
device, or if the device is a VF. Use it in vfio_pci_core_disable() and
pci_reset_function() to only lock the bridge when it is needed.

Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
v2:
- Replace pci_reset_needs_bridge_lock() with
  pci_reset_function_needs_bridge_lock() as suggested by Alex, and use it
  in pci_reset_function() too.
---
 drivers/pci/pci.c                | 25 ++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_core.c |  3 ++-
 include/linux/pci.h              |  1 +
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..cc6647d091f7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5256,6 +5256,24 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
+/**
+ * pci_reset_function_needs_bridge_lock - check whether a function reset of
+ * @dev may need the upstream bridge to be locked
+ * @dev: PCI device to check
+ *
+ * A bus reset of @dev is done through its upstream bridge, so the caller must
+ * hold the bridge lock. The bridge doesn't need to be locked if there is no
+ * upstream bridge, if bus resets are disabled for @dev, or if @dev is a VF.
+ *
+ * Return: true if a function reset of @dev may be a bus reset.
+ */
+bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
+{
+	return pci_upstream_bridge(dev) &&
+	       !(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
+}
+EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
+
 /**
  * pci_init_reset_methods - check whether device can be safely reset
  * and store supported reset mechanisms.
@@ -5313,10 +5331,11 @@ int pci_reset_function(struct pci_dev *dev)
 		return -ENOTTY;
 
 	/*
-	 * If there's no upstream bridge, no locking is needed since there is
-	 * no upstream bridge configuration to hold consistent.
+	 * The upstream bridge only needs to be locked if the reset may be a
+	 * bus reset, which is done through the bridge.
 	 */
-	bridge = pci_upstream_bridge(dev);
+	bridge = pci_reset_function_needs_bridge_lock(dev) ?
+		 pci_upstream_bridge(dev) : NULL;
 	if (bridge)
 		pci_dev_lock(bridge);
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..5dcbefd2eba4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * overwrite the previously restored configuration information.
 	 */
 	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
+		bridge = pci_reset_function_needs_bridge_lock(pdev) ?
+			 pci_upstream_bridge(pdev) : NULL;
 		if (bridge && !pci_dev_trylock(bridge))
 			goto out_restore_state;
 		if (pci_dev_trylock(pdev)) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..aee6a178a535 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1486,6 +1486,7 @@ void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
+bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.1.831.g720f3f5937-goog

