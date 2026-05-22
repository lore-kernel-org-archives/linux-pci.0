Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B4388878
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481463; cv=none; b=AuG0x0MyLGhcWRl7e/92TjzyjhCSF083sWcDpr781znfbWRK2qtgJDdflnwY3N3TNH8JGkp5lv2kHR9W9bi1TTXrXiwKrq2ww2liVTrz8k2ikUVV39q9dnziAf0a6eleCWMm8EFD46irL3pyxOJt8BkbsVbdSHs4xWFsKhDqWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481463; c=relaxed/simple;
	bh=vt29mpxfdN0oynKpwfSKNPgSGC8PTO+Nd0Edazw1zxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ieh6OoW4ubrUewsiEeU/vciKMzgTU+supIX78/Ky+6ju+tuG+2fbELoXrNhIrIsDaz6CVnsjNfyt1S9VC25vTV6vLCUnQNjTc06wOHHRVFdvDevWHOyVzE6HKLyP7uwKu+xFZZl5qWbVzpucVdXYIYxJfDtNKe/ucE4KL04gcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hW6XQh/Y; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW6XQh/Y"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b68a33adso11253632a91.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481461; x=1780086261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gRktteoUb/1GJUOFc5t/RbM6I0eXe+lj3sebUBczU=;
        b=hW6XQh/YG3z/1o2uZJGwCH/Z3VVLev90bLEAbA3VuUe5tWjA0xmyf0PBoXOlWM6r9h
         bifsIEFxC9Ry8WNTQ+ZtiiORIOJ97Odhyn04SkUXTneUN20dedMheytQv4iQ4YbPTTdg
         tqDg6uiSA+e731mBDXfA72CxP3SsuHfQzIhGkE5povIPRGbTuK9h38X+/7t9RlOmi3tE
         zKX/nszskEKWT3Np7TLzyUjVpc8vz7nW5xrm+WBcVV2HlQIeMPfVBOGHhGTvdqjBDwoP
         zzXaJjhdSzUz25w8IE5zxZ+lg1dyLsiwAYUFxs95WF7rYIldLRt2FYzLD683MJ6n/HXb
         zg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481461; x=1780086261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gRktteoUb/1GJUOFc5t/RbM6I0eXe+lj3sebUBczU=;
        b=OV9ph2fSnx98ok2YVz/Bj4cNtgqS7b2FE65fSYZcY0OnRPryXaedj3L2+dbClMoOwQ
         jM7jXW/Buc7TEyHiTpkmBQoQtmL7afLiW360cPEVBREpJ2Ny9alGttC0DWLeCCOauyvr
         Yxmr9O5KN9hA2ncUREERG7Vug6VV/DZEi3eSJ0t6AOjC9FRYPQDlW2Z00tbjUKaAFhPX
         GgtY9v1nBygaM8stTbxjLsyoDHhDoaAMaRI4avbLoj9C25RmTxwGBwL+8m8gkEGOo7IU
         OR55FIPlYcsV2XMeqtbPh0xnIpN9hv0X5h6UnSYzCPkA1IT5+fi+EkKSFekD5bLr0IVo
         mljw==
X-Forwarded-Encrypted: i=1; AFNElJ/0MBwLIYXl2hzRQq1JwPATAsY26tzNKCMfOpJXaQiNHYE04uLwZvm5ArMkZIHxnm6wHdohI13gyRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdezMwAiYjeAazNYCQyuoLx35LaQqS3fodKTPRvCSC7Edi17c
	FPaSQIbPo78Vq1yQ8HKHIJshJfS/MOiIecmQnBmBYMKwEsBMiVX/LHlUyGoGvvzlUehs3dfzo7+
	rh1iYj3utOpfsPw==
X-Received: from pjbtc4.prod.google.com ([2002:a17:90b:5404:b0:36a:81c9:4523])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ecc:b0:369:d7c6:450a with SMTP id 98e67ed59e1d1-36a671e974emr5405438a91.0.1779481460825;
 Fri, 22 May 2026 13:24:20 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:08 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-11-dmatlack@google.com>
Subject: [PATCH v6 10/12] PCI: liveupdate: Freeze preservation status during shutdown
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Freeze a device's outgoing preservation status (preserved or not
preserved) during shutdown. This enables the PCI core and drivers to
safely make decisions based on the device's preservation status during
shutdown.

Note that pci_liveupdate_freeze() is triggered by the PCI core rather
than from drivers participating in Live Update so that all devices can
have their status frozen (i.e. prevent non-preserved devices from
getting preserved late).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  5 +++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 701276ef6cfb..d404e64a4e55 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -297,6 +297,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev
 {
 	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
 		return -EINVAL;
@@ -380,6 +385,11 @@ static int __pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev
 
 static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *dev)
 {
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing)
 		return pci_liveupdate_preserve_device_again(dev);
 
@@ -653,6 +663,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 	}
 }
 
+void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+	dev->liveupdate.frozen = 1;
+}
+
 static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 6f21ec50927b..bcb0bc73d684 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
 				      int pass);
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
@@ -28,6 +29,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+}
+
 static inline bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus,
 						    struct pci_dev *dev,
 						    int pass)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..f7a5e65a7c75 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include "liveupdate.h"
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -536,6 +537,7 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 2446c6d237ca..150993405754 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -24,6 +24,8 @@
  * @was_preserved: True if this struct pci_dev was preserved by the previous
  *                 kernel. Unlike @incoming, this field is not cleared after
  *                 the device is finished participating in Live Update.
+ * @frozen: True if the outgoing preservation status of this device is frozen
+ *          and thus cannot be changed.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
@@ -31,6 +33,7 @@ struct pci_liveupdate {
 	u16 acs_ctrl;
 	bool inherit_buses;
 	bool was_preserved;
+	bool frozen;
 };
 
 struct pci_dev;
-- 
2.54.0.746.g67dd491aae-goog

