Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527825;
	b=f+A9kH4Jw5WkubWjkYjoVfBLg8r2fNVi6ITYGx+rZI2udgDbfYI+3k+LrTduaSnfaf30
	 RgdE7yRrCMMtmVhRBArk+w6PMpqSxt8e6n5RPH4gTqt7782CXiKSfp7PXEjioIS9HO8i8
	 K9dx9zSfdLnhyfxDSRhkofYwSmIl0XCDqT2F6wuYHHLSp1tYrRM4jP4AZXK1aZ1b8P3Em
	 3cjNItmdAYiR4rjULtXCln9HV7Yu3yB4eET7e7BRKjgFBD0X6vf9JsND+F3vZ/02Q6S+B
	 riNCFvTrKXKZ80sjaIkAS5D6Plw9OXLzYA484DgWQN347rfmwsV44WXr+/Ww6DebnQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ElwPfqXeirLqqsU4zQh4EAXIe0nkzZW28c2DWS+oP2I=;
	b=zvAk9d3NfcjlJ5XIpL1LOSBBvXxph+HoLNKgrAu5dCS+5/yiQIPZDm5PUk5th8IHEb0I
	 EgKvAXC5Ms2YISXWZmtP1Y0Gbv0XyM9+G9oKBrswbLyW3BuQLXGgDVFfnLqViOtmVesKN
	 NWPrSynCblLxyH7dTtz8OrD2zSHp8kjmMIGRRqHb7U+xrtncFHf8qgAgfKVUOSAkzcxQL
	 n5j80wxXT7AVFNvPBZtljNAY+I6fsN46BS+ugzIi0B07PqNzSjEZQ6fI0DM5C1O1u+pZb
	 Vvh8dbI1QityF4rIcLv/B898tyYDhTyvwTZTNYha9IqFhntpkIbl+jpCZUSXaxTZWIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AalXEhu8;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8E606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 23:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB8E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AalXEhu8
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8615931306dso415764a34.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794527823; x=1795132623; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElwPfqXeirLqqsU4zQh4EAXIe0nkzZW28c2DWS+oP2I=;
        b=AalXEhu85XLeavKUGJEoFPwFWjTcQjZ4Txj4QKRuORMa5u/JxvRMQDijHWuC6WR9YE
         F9xZKhlT+ZIAWNJP0aTGXAb7cY1q3kKWVZPiHbsQKvBsF87tdzlzk/qE8PRoWbAOYN6d
         66gw3T/dWo/17uwM+alpeXiaRku0KJH1HEaxl/AtYNIn4yEP7eLchrAoE0wigC655RWX
         i468OPERQ3/LBnLJyKc1gTz58azBMlpqIJOH4w5kLGp2ifVgdstmNOYKm6X4LI3TWFm0
         6GD8XDYITJMfvsjkIhu/GUAzMaBL5Dep5F2coVrBOBKyGX9eFQYOFkasyfqLOcpnljPE
         AKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794527823; x=1795132623;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElwPfqXeirLqqsU4zQh4EAXIe0nkzZW28c2DWS+oP2I=;
        b=j9qdqfJ68WuteMR8BF4V5GTxLtI3/HN+eRD1nCpOvsxP80ec+rN1FPbtPcRlGtYnOE
         RFCR9TGmxhJwZmH82iH5++8IXBVLtSeTQDHfiAZ9zODvd8mQTOZrZwqV8KPJEGcwCJ39
         YKQ67okYyUKrDJ5XAB0pGgd3wpP8yhhvNcuaLLVfWiQq0Ny/I9F/Sg31XyT0mA0jBP+7
         1rBp6/duQMGZl/Q5M0Q0fsgQ2CdOw5Bp0MIzhY3eurAs/dTcY84mAF/jCFy4XhKOKK4U
         rig8kAqu7Qcq221j0tQzRRiWke38eYSWtfsy2QSZ3vSnnSMUOkoGK0RMGRq+I7vteMfD
         I5jw==
X-Forwarded-Encrypted: i=1; AL+hErHlSkDPt3Jjbc+ZoJ3aHjyfR+ALItEu6AnP2OkawnQN8Xa9nQPGxdSk/kO2R9KTAVH8ePnvPMh/0cE=@vger.kernel.org
X-Gm-Message-State: APuU4Z81//GxbWPckyLfMqZDKobyAPt3M2FVS7pcYcGJRnmFCSITV/Ak
	dOiaXr5mW4liOFcj3GIAw6Gc+A7Jer5o9J2LQfLNVm0Zk/PQX1ldFb5O/oN+LFWkPEqqLYTsHKw
	D8T4UWEwnCsQXVA==
X-Received: from iocot30-n2.prod.google.com ([2002:a05:6602:c29e:20b0:9ca:bccb:ca8a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:181d:b0:564:3fe1:2fad with SMTP id 5614622812f47-56e645d54a4mr794959b6e.42.1794527823209;
 Thu, 12 Nov 2026 15:57:03 -0800 (PST)
Date: Thu, 12 Nov 2026 23:57:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261112235700.2029562-1-skhawaja@google.com>
Subject: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may need it
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Anthony Pighin <anthony.pighin@nokia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
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
the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
resets the bus for it because the PF and the other VFs are on the same
bus.

Add pci_reset_needs_bridge_lock(), which returns true if any reset
method enabled for the device is a bus reset, and only lock the bridge
in vfio_pci_core_disable() when it does.

Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
with two VFs. Both VFs are opened through VFIO and then closed from two
threads at the same time, counting FLRs with a kprobe on pcie_flr().
Without this patch one VF missed its FLR in 50 of 50 rounds, with it
both VFs were reset in every round. I will send a VFIO selftest for this
separately.
---
 drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  3 ++-
 include/linux/pci.h              |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..c44e4d4d8774 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5256,6 +5256,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
+/**
+ * pci_reset_needs_bridge_lock - check whether a reset of @dev may need the
+ * upstream bridge to be locked
+ * @dev: PCI device to check
+ *
+ * A bus reset of @dev is done through its upstream bridge, so the caller must
+ * hold the bridge lock. The other reset methods only access @dev itself.
+ *
+ * Return: true if any of the reset methods enabled for @dev is a bus reset.
+ */
+bool pci_reset_needs_bridge_lock(struct pci_dev *dev)
+{
+	int i, m;
+
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		m = dev->reset_methods[i];
+		if (!m)
+			break;
+
+		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
+		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_reset_needs_bridge_lock);
+
 /**
  * pci_init_reset_methods - check whether device can be safely reset
  * and store supported reset mechanisms.
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..ba3dfdadae39 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * overwrite the previously restored configuration information.
 	 */
 	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
+		bridge = pci_reset_needs_bridge_lock(pdev) ?
+			 pci_upstream_bridge(pdev) : NULL;
 		if (bridge && !pci_dev_trylock(bridge))
 			goto out_restore_state;
 		if (pci_dev_trylock(pdev)) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..cb2856f444ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1486,6 +1486,7 @@ void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
+bool pci_reset_needs_bridge_lock(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.0.611.g1030f0b940-goog

