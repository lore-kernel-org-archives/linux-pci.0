Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E1357D01
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611742; cv=none; b=nzwQdhcmJ5v9K+Rhf21tR4GLr8twb43IniUHV+etBhxFL4kBQCedHCAa6s1DIfvRcq97n1HmkrcX7UP4z6wsRz21Wvlw9QqAyg6WHqPpl2d5P//NAcQcB6pZiMwiMYvjAnrEx7uq7a+imUeBe2jnH6yzyPLTD8m6y1fhlVMCTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611742; c=relaxed/simple;
	bh=cmB/mzAF2hwoZBTtcFhlO949aTj5sQiWnXmoN+XyAIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S5ndgMSQFZnCAcXmAZN8D4W6/kA21vEnxNdLlKaDs1qaZGeP08bYEfeAe9ZeOp+DJhhgxZrPADZoXuKaJtopnzGxE0UkAgZSGDZ0fHecDZ+VT5Tz1vcyQTO0eJYkrpve5YE6Z17Rtc3KhDbblvApZGPiCM8ukHTXXCnsB6d5sI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUIEX+Gi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUIEX+Gi"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82894155ceso3251372a12.1
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611739; x=1779216539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+T00aeBm2op37uqoieTnlwhq01i0C6V7dLZN2p+Z22k=;
        b=cUIEX+GisWOKKve5d6Mx62tiyRTwF7HOMzYd7FwHsX+3qtLX7V578SJ5HYbrFUZgyO
         1yUVMbyBMbVQh/jdV7zgjGv9Hyu0k0temjGmtxs1039LHFim9kUyu3naqQ1Na+vZ6uia
         K7efnCDVGbyFP34S9lwahLcH2iBt2QUO3wlWisXbwJs5rQkSbXKMOXYYBVbmCxwF8EWr
         sNBx/V9TiiRRUqMkjC25m8mS8pcSg70fP6NQEg20fav+G8i17Dls4StosSWHDScXUW6j
         u19QrxBZPLvsfPKOvEE0H6kzvN6gGapbKRkoTE9qdunTUuZ5Dc3mDrJ3/SwMoF1viZJ/
         LITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611739; x=1779216539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+T00aeBm2op37uqoieTnlwhq01i0C6V7dLZN2p+Z22k=;
        b=JfC8nWXTcyO6QMjZ4tx+Lvs16vDlBbcWpXwcLEpmp7VH32oGQld6MlpjoSmU+sbEDo
         2jIN4i+jkniARh7xeSx67rheeZuh9tExEQF91bf26vUfgsbkgpEvI8A7R0DDEdThg+n+
         /cOnM7mz3VtJ2qlFu4aZpcxGFF7IOzN6b/r4KYZzhqHK7aZJfgsyw8KArvFqu47/YEGg
         OrUfICMRZxvbfMWQCbvNkv3GwM2IfRWxfx9j5ptYIWLzu0eVpvPYcQlnJStbP14lp4MZ
         Q65J1Qi1VIYQIWjQGiMX76B3Po14jcO/o+RAH4seridufBSyM9IjROvxCNpdT9AUISR/
         tf+g==
X-Forwarded-Encrypted: i=1; AFNElJ8zufLDNskZNSgWdi1FR5XxWhunsFqiMN8Sp4KSrujJudX74FeBrESvLyIr0id55qNDx8CnwjLiN+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKNjDUe0GzgnGuz0y26IBIWecpW7qpJFRV1StEQ+xs4SQEMAX
	wo03p3M3z1FoinUA3JIRoFanBo+T0DRKVRjL0GkIfxkT6N33hxpj+2xrC5EF/A8DJtHcGoxXL0C
	Scu+7+OgnT/nCkQ==
X-Received: from pfnc7.prod.google.com ([2002:aa7:81c7:0:b0:83e:d99d:7c4b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:94c7:b0:3a2:d68d:9e6f with SMTP id adf61e73a8af0-3aad44508e5mr15994706637.33.1778611738764;
 Tue, 12 May 2026 11:48:58 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:44 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-10-dmatlack@google.com>
Subject: [PATCH v5 09/11] PCI: liveupdate: Freeze preservation status during shutdown
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
index 6ab03bd548b3..825166a57913 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -334,6 +334,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev
 
 	guard(write_lock)(&dev->liveupdate.lock);
 
+	if (dev->liveupdate.frozen) {
+		pci_WARN(dev, 1, "Cannot unpreserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	dev_ser = dev->liveupdate.outgoing;
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
@@ -420,6 +425,11 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
 {
 	guard(write_lock)(&dev->liveupdate.lock);
 
+	if (dev->liveupdate.frozen) {
+		pci_WARN(dev, 1, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing)
 		return pci_liveupdate_preserve_device_existing(dev);
 	else
@@ -625,6 +635,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_liveupdate_flb_put_incoming();
 }
 
+void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+	guard(write_lock)(&dev->liveupdate.lock);
+	dev->liveupdate.frozen = 1;
+}
+
 static int __pci_liveupdate_finish_device(struct pci_dev *dev)
 {
 	guard(write_lock)(&dev->liveupdate.lock);
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index fd7693c7ddd2..30deaa673efe 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_inherit_buses(void);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 bool pci_liveupdate_inherit_acs(struct pci_dev *dev);
@@ -26,6 +27,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev);
+{
+}
+
 static inline bool pci_liveupdate_inherit_buses(void)
 {
 	return false;
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
index 34f9900c7d29..7e4ac7a0f4fc 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -22,6 +22,8 @@
  * @was_preserved: True if this struct pci_dev was preserved by the previous
  *                 kernel. Unlike @incoming, this field is not cleared after
  *                 the device is finished participating in Live Update.
+ * @frozen: True if the outgoing preservation status of this device is frozen
+ *          and thus cannot be changed.
  */
 struct pci_liveupdate {
 	rwlock_t lock;
@@ -29,6 +31,7 @@ struct pci_liveupdate {
 	struct pci_dev_ser *incoming;
 	u16 acs_ctrl;
 	unsigned int was_preserved:1;
+	unsigned int frozen:1;
 };
 
 struct pci_dev;
-- 
2.54.0.563.g4f69b47b94-goog

