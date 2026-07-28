Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10914756DE
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276640; cv=none; b=ng2m8SW1WT+R4dZG1xVwhSFP9eAOQEeGLDNJu8O0C7nX8AQGVrs3kqghSYLz3GTst5gvs1uLWUPXu8eEj5jDYAcQBmTjcspVqrRjWcwFf+uyGyuM1PhmZhIIpLVx7UJSIjgetIpSaHZhnta6eUWtv6uQscrY+rRAt8SjAiuSLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276640; c=relaxed/simple;
	bh=lx0gvaLUapR3DtUuP7DJUxKhFqzySRplFurFf4ebi+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qye6VSLFdz93iWdB0ZrXwdhwoDA8qJDucXUdeSwy5XGPLJoux1+SjGxDBFts8gzc63nKp6QaUbDq0RIXyqKymudb863ZbCDmVz25w5q5Ehv2cBjti76atltxjbaan4r/y6DMiWbFDLO2A3Ga318oawNLxMnxgMH2UJPQoo7C9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhmfGFt8; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhmfGFt8"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so447669a91.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276629; x=1785881429; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5W2sBTENi+WOUrZGfaki9B1D/ksXXAJzGZ/5VFVBZM=;
        b=bhmfGFt8Fx9arRVn0Jj2b87vzoNmgEnGEJF6zlf2oyPTgSUAYP19IKuuk8HyZhK78N
         l0Jnnae9oyt1jFGtPmV8pYxxR+A9sO2gmB5IiB9MMj2e5Kw6gnZ43MTJYkoCsWYNBjO8
         dJ4nMv90GY5iXi64W4bT9x8ngkGb4y/pwPP3JBmEH2MYDCilXV86JVVUpk5+1hdaBpjn
         stkYrwDq6EIgMYC4MXjMekde072N8KMkrZ8GcoFzAbYZUkUj/dJQh4VjntV98ssxB8kG
         eo+5Qzm6LWZghewfe9p7dDM/0hQYnl58mTPgUgTOBEN2KwC0Bmf1ho3TF26U50rtktN/
         LZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276629; x=1785881429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5W2sBTENi+WOUrZGfaki9B1D/ksXXAJzGZ/5VFVBZM=;
        b=IYWu8yIHS+2/W+dwN0CdhyKNfUfKFnT8pLKJTxaDhcv4utneSUW/CLlpx7XFxqxa6u
         8bHPYvDH9DVCnxLjJ1S+GhgcM3NENCXDAQKmJNML18mL1A9d/UmzVeoKjNV+Gpj5YCNX
         SBe9aHmlIUUkokeam1ZXJJzv+YsQgyrLgvdYDlOJCT913w6Fh8WhCZ96FL1XdDL2/8eZ
         p3kis2hPBe71bx1h+1ryWGAmcaw/Kjh2K405kGk3ehiYewPbKBragPRbLPtjnKbKultc
         rHFCV+jB7r9BxWuscdyH4qX9Xzj0c8GRxeEXIhL53YciDDzPJhdmVG1bvvS7N29syw00
         R+DQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+DFs3nLKkPMqjE9aQoMC0FO+Vdebbu1TSu4zWMp/4ZGqTNYbHeEHFlacGeyTH4NfGUdFgEF+SNZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1U7TTws9kuRrjW8jQkB4V4TxmRJJFbIXGYJjrXv0CNEGyDgz
	L2Mt4CNrYCNhimicuSdBlLJNvOdBfs9UpW7fAaubG5/7u/VBgDiuB6oBJ4PT9Tfv0Uj2Whm7b2D
	twznAGkDAO5oSWw==
X-Received: from pjqx19.prod.google.com ([2002:a17:90a:b013:b0:384:f6e1:ff81])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f0b:b0:38e:7f34:b23d with SMTP id 98e67ed59e1d1-38f6a54897fmr4380325a91.35.1785276629379;
 Tue, 28 Jul 2026 15:10:29 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:04 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-11-dmatlack@google.com>
Subject: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status during shutdown
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

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  4 ++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 25 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 744513ee11ed..65bcecb1b64e 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -394,6 +394,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
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
@@ -447,6 +452,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing) {
 		if (!dev->liveupdate.outgoing->refcount) {
 			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
@@ -718,6 +728,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
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
index ccc23031e99d..49d07fd02132 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+void pci_liveupdate_freeze(struct pci_dev *dev);
 bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 					 struct pci_dev *dev);
 void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
@@ -28,6 +29,9 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_freeze(struct pci_dev *dev)
+{
+}
 static inline bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
 						       struct pci_dev *dev)
 {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..51616e4327d3 100644
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
index 04a2b2a3102a..31898685a406 100644
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
 	bool preserve_bus_numbers;
 	bool was_preserved;
+	bool frozen;
 };
 
 struct pci_dev;
-- 
2.55.0.487.gaf234c4eb3-goog

