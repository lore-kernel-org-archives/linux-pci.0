Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484138F22E
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310341; cv=none; b=VdvyfWQY7QdkDltjfWhuwC5fyQTTv5dADxxI6j9aHa9hXr23CxaJ734n4X0DIR7R/JbNlBBkHExoZzQ8yDk0BpWMYcWyXLCXWPeXpxh7PRZhD3PEIjQ4hPV+NAiCae4Cwv+VHsQNhEBUzGP0UPpWGNS1xuppGvefXobaUZhGjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310341; c=relaxed/simple;
	bh=YnyFu7Hq5DfkB2TP1cJWlWPeBT9cbNudoys76NodHZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/S6dfV8KGJw0sPQ2vh7JonozvfE++7zUISQ9fXgIUZft6RAiKdXorGf8a5xsPWmnJGm+7jkDFDiX4k6X/yKtT7fuALV4MWVCZmRrWNC7Spjxg6/Ul2g9tWl6WkX3wIvqf2qSn/ybT8lZMShwKoNJsMQPpUI7ztyAI51XDc5qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHoH3/1q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHoH3/1q"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b0565d77a6so10203115ad.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310339; x=1774915139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDvzsZ/wW7otbfhEhu+LWvOHypwI+AXZcNsT2i6QVdU=;
        b=qHoH3/1qrDc4Llk2/CjdmQ5F+FP364nEtKTdWQnSA+Aq0mjTS3KiiMBqQO0aD2IxfT
         30/YPj2MJMudFABAIgGABWxSqdZb5XGCiqA8tfS1fiIizdebEV3Y0m7+5ekOMFvObXAK
         JhxaUbgiscB1Y/CDHuSYXdlq4HcKBvhIObzPEI3KqKJ/T/58WPh+GbKtzqjqpZQ/Wbi+
         C98iu1eBMhTS+rv0QwtpnBtghxO0T96RWnpX1jdzdIKBySG7n7RUj2p5E98wLt9HVuFP
         B659dpJf4RXvE8TL6eiUFzkUGtX/K8Covb94i0raIgP8Zh1jxaIXDYHGtrw1SR0795ON
         cgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310339; x=1774915139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDvzsZ/wW7otbfhEhu+LWvOHypwI+AXZcNsT2i6QVdU=;
        b=QLHYlLIGrkNK51jGIvGbUBmVu3zAMadt87jv7PZI9xaUXKJHPTi4byK8wPVwWoBUj+
         A6boBhmFWfg+1vVrJA2EjAZUAE5RQfSAGz87Nf8++KeglRUu8+c51bZBG84N1nOBw493
         f4M6V2pSU6B6PAUwqzb1NFaOSJ2BZClIqYVS5eHI9DrFU25/FKJptWaYLUm94VzdIPZg
         8V4B0uPvHyfE++1Dig+mWNh8y47UXAF60I9NSaodLFdsguhWxt5yIddK73I/vCsbcQ8l
         NVzEpqMzjb6ySKMLsnXxDN+K/JwXKxJuP7QNpOW3XW0rIjpDxQn+xDxGDFEoIIgx8QLZ
         u9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXIbREsqHykfxZjNHEx7bczEYVTPA0wE4hAcLyslHNAREmK/9A+bsu9uu+WoUi8Zk9G2vaw/fCN9p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QKzmcXcZIRAWFKRMQNqWk7+ImNUJZC/OVXZPa9AwDANj2M/1
	L35V6wlMqFLRb9jKFUhEzO4weNwJb7KWHbbqYeRKStVTae4Tm2BMq3YpYTtrCKxLBHxtg4BAYXy
	B9BaSMRQaSC9osQ==
X-Received: from pldt15.prod.google.com ([2002:a17:903:40cf:b0:2b0:59ce:931b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1c7:b0:2b0:5fa5:a68c with SMTP id d9443c01a7336-2b0826b9030mr140489925ad.9.1774310338569;
 Mon, 23 Mar 2026 16:58:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:04 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-13-dmatlack@google.com>
Subject: [PATCH v3 12/24] vfio/pci: Skip reset of preserved device after Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Do not reset the device when a Live Update preserved vfio-pci device is
retrieved and first enabled. vfio_pci_liveupdate_freeze() guarantees the
device is reset prior to Live Update, so there's no reason to reset it
again after Live Update.

Since VFIO normally uses the initial reset to detect if the device
supports function resets, pass that from the previous kernel via
struct vfio_pci_core_dev_ser.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       | 31 ++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_liveupdate.c |  4 ++++
 include/linux/kho/abi/vfio_pci.h       |  4 +++-
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d7c472cf4729..849a3b57d56b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/kho/abi/vfio_pci.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
@@ -494,6 +495,30 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 			   NULL)
 };
 
+static int vfio_pci_core_probe_reset(struct vfio_pci_core_device *vdev)
+{
+	int ret;
+
+	/*
+	 * This device was preserved by the previous kernel across a Live
+	 * Update, so it does not need to be reset and reset_works can be
+	 * inherited from the previous kernel.
+	 */
+	if (vdev->liveupdate_incoming_state) {
+		vdev->reset_works = vdev->liveupdate_incoming_state->reset_works;
+		return 0;
+	}
+
+	ret = pci_try_reset_function(vdev->pdev);
+
+	/* Bail if the device lock cannot be acquired. */
+	if (ret == -EAGAIN)
+		return ret;
+
+	vdev->reset_works = !ret;
+	return 0;
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -514,12 +539,10 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
+	ret = vfio_pci_core_probe_reset(vdev);
+	if (ret)
 		goto out_disable_device;
 
-	vdev->reset_works = !ret;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 8d6681e1d328..874c821bf6eb 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -91,6 +91,9 @@
  *    kernel guarantees the these will not change across a kexec when a device
  *    is preserved.
  *
+ *  * Whether or not the device supports function resets. This is necessary to
+ *    avoid resetting the device after kexec to probe for reset support.
+ *
  * Since the kernel is not yet prepared to preserve all parts of the device and
  * its dependencies (such as DMA mappings), VFIO currently resets and restores
  * preserved devices back into an idle state during kexec, before handing off
@@ -162,6 +165,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
+	ser->reset_works = vdev->reset_works;
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 876aaf81dd92..c057794a044f 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -26,7 +26,7 @@
  * incrementing the version number in the VFIO_PCI_LUO_FH_COMPATIBLE string.
  */
 
-#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
+#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v2"
 
 /**
  * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
@@ -34,10 +34,12 @@
  *
  * @domain: The device's PCI domain number (segment).
  * @bdf: The device's PCI bus, device, and function number.
+ * @reset_works: Non-zero if the device supports function resets.
  */
 struct vfio_pci_core_device_ser {
 	u32 domain;
 	u16 bdf;
+	u8 reset_works;
 } __packed;
 
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
-- 
2.53.0.983.g0bb29b3bc5-goog

