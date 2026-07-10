Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB33BFAD0
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718798; cv=none; b=GPJmYCiTNDaTZxZ1qczj3hpCXyDBZFb2AkhLDo4vN9clJw5gWtAFDPx3CiuHRvsC2bJLrZhyKq4NLMGmhXN638pd2yCI9ql+y8qTzb+ps66yi+dGzH794q9D6jDE/iHulNDylWko5KU/xso4YqMIDJeEBPMYerfsWP4yCBth6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718798; c=relaxed/simple;
	bh=hBpyAX1ANil//5hIqEWoMbY4GyRjYVO8UOaUzZ3AIBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qwxO0Xwx7MxHhBiiqSzNpz4Fec3jSypLmfEN4ms+ah6y/Q67fij9AGt1uw7GMkLRwVQkdHN5XiXu+eXQHnaA6kTb2+E9F180CBppwdsLkAzgwuRcshYataRzaDb/cvrb/YHDKraIflETubPdMcFDLcpMA40LgJLjXVII62sDlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEIN/LiG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEIN/LiG"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8484ba00601so1449747b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718791; x=1784323591; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vh0w4YZ9EkCKSJvWXCxWBgNBQIG8ERULbiy01R/Xx2Q=;
        b=HEIN/LiGTO/ZqWzPQ4sPvjCX1KMrMXJR7nLySDNp7uxlzuY1b1ttY3t6A8+xHfksfm
         RiqYJ1C4pvAiS2sTL2QyP8M3MhCr57Svt04ongjl4UWaBjZIf8hb74LWbutMSAwdDk9x
         TPMeSpy0jXHuFbzxEG9O0cFRoZBCRwzjmFuA496mLCIVMfZglG442phWFHvmB7Gw7Sw6
         ZmMyRgkEUFR3dom1nPPT0IBN3jGdP3+5XQmdcxJG97jau5cNW2eiFBGHkjcusJcHySfj
         lqiH1tPWGB0imnbtJsOh2M2diStgILk0pgbeWkV+Dcwfq27FefHK3zb+tUKr/nD952yY
         gN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718791; x=1784323591;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vh0w4YZ9EkCKSJvWXCxWBgNBQIG8ERULbiy01R/Xx2Q=;
        b=UMFaKwZZ6zgu7dRxS9mx0FhUC4QzoTy0F0zLOvkv1LYm0vkHQODEZs7w5xQfUekE4a
         3L7u5x3zaGIBq7HC8Wniaa7vED1H5TZ+G6DlNrvE+4m65d4XlC2KzmeQt4IE0wDh3yzN
         AV29Ijxhpg5VkHCMRMjTr6/ti46MPI3AAE7n8r01pUECYNFIsxxgvH6AM85xqdjf9R0L
         D+8sarYSj+sZhtVJ8lqir/usirVZ5pRBK0UQWz6TAengRnEX03ewvCNUguuyjN0RTTIe
         qAIpz0yr72Cme61wpF6rVRUqmY8gBz+tfAy4ab1sMPAp3Vd7bKZzmU9hQgDaYW6HJ5pY
         HrvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrd/IeO4p64UBm/ct7zc29WgNlLCMOeqUU+RK2jPP4iw65GlD89lmVMITOLhJ9bgbbqWplj0f3XGCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYRsOwPZjtMwDIe2mb0yN39w6TKrzl4Exe1wSescp9YJfbeOL
	urFjKGjJvnpogDxiXE3GnIYMDCZ8jj4HtPIBE3CPYKB2SZhBCD5DhJqjOiLdmbkAS9hKWhgd3Ql
	1fspzGy6deldE+A==
X-Received: from pfbfe24.prod.google.com ([2002:a05:6a00:2f18:b0:848:401c:994])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:14c3:b0:847:9c06:2bef with SMTP id d2e1a72fcca58-8488971669emr605929b3a.29.1783718791168;
 Fri, 10 Jul 2026 14:26:31 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:13 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-11-dmatlack@google.com>
Subject: [PATCH v7 10/12] PCI: liveupdate: Freeze preservation status during shutdown
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
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 16 ++++++++++++++++
 drivers/pci/liveupdate.h       |  5 +++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 74a11e520f0d..64052892ea84 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -352,6 +352,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, s
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
@@ -422,6 +427,11 @@ static int __pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, s
 
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
 {
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev->liveupdate.outgoing)
 		return pci_liveupdate_preserve_device_again(dev);
 
@@ -713,6 +723,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
2.55.0.795.g602f6c329a-goog

