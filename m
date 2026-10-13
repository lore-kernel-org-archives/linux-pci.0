Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708A51E438
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908754; cv=none; b=VcIOsYpfbWfS4IYcp+K/um4q0gCb8L9WbZkhEvyq61Nm+uqtOgWVesVCBAoZj1hNRqOQRtkCdfQYn9E2/qd9fVgKOiz3tQN3D3Bz5D1mFWRcbMRtiBc3EhJJVv9o2knpslTQeJYrPo2ihQ3xVX09Ufihw8CCARMUHOIy5a4hVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908754; c=relaxed/simple;
	bh=mpYpUjtI1IMp3Po9n51+NyGnURN9gtib7Dkh7rXVaAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvHiJBGOoT9O1T/a1aCZf/xiDUfD+PvjxwNPIYdusOyNClAlI+SpCaaiKjTyj6wmqerqAgB27B8ndGBRGtfV5ZeXbQUh8km/Loz9GoUJ2vvDTOVOOxUjinhx9QMy5ytaP8QgnyYDE+QLtMzocUYtPhoySh1v9PCEyp9XeEkWDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYTSeSk+; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYTSeSk+"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df375fb9b2so38578475ad.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908749; x=1792513549; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MskRkxPSFzbqMyyuEL+532dIkv44I1UDvOc3a8yN8g=;
        b=fYTSeSk+mBphDn/xFedlZd8Ke+jOo8gGZb1lDUAieiCO/ijIR/5mVfrQ5xkpCW6Tsw
         cactevIdXFhuA8cOG647G9zTEGoe9TfzO5GLYiUqfaCIVomMcZKDPAD5rEpK81WrROzv
         LdZg0tM8k4pPwycGJi/6dYZime4EEKtEtGpqDrXJeLSWe9WCHE6FGzpaHi3/hlKjqCep
         BRmHZf+LOWGzlWniRvRYdyBECu+lRS1SKvO/xAmXDgP8/O1yLNM1khJIm++q0zsI/XBe
         hLYUUmFoGfx2qXX7ja1TWqo6oSE9dnenlYlDKPvg5S9SPRLOBcRrYVjpXm6wVQ+c7JjS
         Dgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908749; x=1792513549;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MskRkxPSFzbqMyyuEL+532dIkv44I1UDvOc3a8yN8g=;
        b=BEfym3X2yqUw00TsMQ0kfkMHXb4ty4tif6dxDvhcHNBMQiefZ18Zjq/u19BAKU4Esu
         3ZwRCxOuW9CPF8BZF9FEyS+ijwLKrPsDR8D2tjiGQ7R75Erra15t3cv5xxRyWzFbLd6c
         8Bno4nKoHVyJcGK9B1bNaSEo9r6lhW/ZvXgC/Nun7ABlarBqbr4fT9Nt0fI3Qp/GxoEG
         A7EfmKdaB5s8XsGmWAj/RrEW4noe5ZY8I8vmhprAZunL8h2NiBjdeBgUk5a8nNNfUdu4
         vbCooDHWdp2n44N4J00T62kL9kFPrP8RI9KBq9us8ksX/Lp8pi1lSnIxgJ7Ik3y3f+e9
         vBSQ==
X-Forwarded-Encrypted: i=1; AKwUvByobNlS4PspCidzHuvWStRJhyGyxcxcnx34nsq+dizT+lh1F+e5UW+ATsezEwV8U/eA5dbE1wm7ew0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+i8MWYEXhGcGyNdeCEzFgeWc+T/tsEXDo45+bfkcBjvcG9i1T
	XRdYkHeAfwDsCZIQ+jCpWDF5FasNQgkoTvegheJQgZqegbogSFW+UPIrqsN35+vy4rv3+rdDqs3
	zHAHG0/kOeFukrA==
X-Received: from plbjk21.prod.google.com ([2002:a17:903:3315:b0:2e3:1af5:b57b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc4f:b0:2dd:c0ff:e726 with SMTP id d9443c01a7336-2e842dff5damr107249425ad.56.1791908748449;
 Tue, 13 Oct 2026 09:25:48 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:27 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-12-dmatlack@google.com>
Subject: [PATCH v10 11/13] PCI: liveupdate: Freeze preservation status during shutdown
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Freeze a device's outgoing preservation status (preserved or not
preserved) during shutdown. This enables the PCI core and drivers to
safely make decisions based on the device's preservation status during
shutdown.

Note that pci_liveupdate_freeze() is triggered by the PCI core rather
than from drivers participating in Live Update so that all devices can
have their status frozen (i.e. prevent non-preserved devices from
getting preserved late).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  5 +++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e640794cc8e6..38b7815fe7d4 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -499,6 +499,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
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
@@ -565,6 +570,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (!dev->liveupdate.outgoing) {
 		struct pci_dev_ser *dev_ser;
 
@@ -815,6 +825,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
 }
 
+void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+	dev->liveupdate.frozen = true;
+}
+
 static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 90b2754ecc0c..5aac19f7bee6 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(void);
 bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 int pci_liveupdate_adopt_acs(struct pci_dev *dev);
@@ -26,6 +27,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+}
+
 static inline bool pci_liveupdate_preserve_bus_numbers(void)
 {
 	return false;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac..dff60a03204f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include "liveupdate.h"
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -559,6 +560,7 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index d45a5b524909..bb79348769b7 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -21,11 +21,14 @@
  *                set up, i.e. it was matched to state preserved by the previous
  *                kernel. Unlike @incoming, this is never cleared, so it stays
  *                true after the device finishes participating in Live Update.
+ * @frozen: True if the outgoing preservation status of this device is frozen
+ *          and thus cannot be changed.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
 	bool was_incoming;
+	bool frozen;
 };
 
 struct pci_dev;
-- 
2.56.0.385.gd3acb90ef8-goog

