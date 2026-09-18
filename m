Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4E344021
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762026; cv=none; b=kj5sZDVgXqvHT/5sBvmsk2kdVZi86HiERI4cGDJhu5sID9efzYxOLoaiFXowXL2V5KDHVsqIapTsNMw9SpHdw+E1X4OXrPoNpeh91LFg6ErL6h6DJJWPcRcXW2A/twqIk/0xDErAj/bd8cV6zIdTTK908bwZYbYZhHzVYaEojAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762026; c=relaxed/simple;
	bh=QrywdoolN15JiKsqZMowqLAM7mFL6Y+xqQxJhjNOwG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXTilm44rXfosmEXF/LD3XZLVv/G9bV4Aj0Ue9AAQOEFNYKwLQcfI/cc9xeXPzRzYseX5FC8uSgevCpjAd63ckJ6JbuhfbqwXTJwYxYTNihHpXpjKFdAxgbwL50GPnkoh8Lu/c60cY+jK8WvyE3iDYNacorJ2hWwhUGCHzTebx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRJiIZFK; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRJiIZFK"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so1456524a12.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762023; x=1790366823; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DtzV4A7ubsZUgCkixUUqpezuoGcnB31d+FYFVqWSkUU=;
        b=qRJiIZFKll6SRnnopTcx8GRSkjJjRz2IkkDlYtRPjTMdq6zadrD/ioLEzIy8DInbl/
         x/00RuI2F+U274yvNt7eKnSX5cv4bhP5DDNSL2y4e1qBKNHIhKY8HqNZUOdOriZaAJrh
         BYCIA87ZO8YbNNLT2JYDUGMsdvnZB6KgJO2l1ZZ8GJxEvXMbjWwiEcF8F0iEHht7+wc7
         QGUFxErPNE4HA6Wr9ImTrs80hI/tKph3fSxzBcTg2PH3lpiPx7YDveKMSZXOCwcurQYH
         jSUXP7e/ZV7oavKI4CjhvVW8afUCaKO79vBMZS+EZgwI1ceCh5CwVfCqjAQnywlofbAG
         7sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762023; x=1790366823;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DtzV4A7ubsZUgCkixUUqpezuoGcnB31d+FYFVqWSkUU=;
        b=y22v+uvkmpFsGbX/fwc16ykz4hrheDveuO5KxuCaeHDUDkB8lASh18HA2mT2Fe39qq
         f0CJMULJA2AW3Nr9OuUDgQ2ZKQkZQGYd3oKEVlNB2iR6avYYkWv1Uj0JxwbRekNG9Q8S
         dndStCQ8Qy+uL9/fbj9BME+WZIa6D/ullAleRZkcXOf8FSLYU2fhpn2oTrOvCowKB5y4
         Hxg65I06Qw76agIo3/9lj4hu0TwdnHxXUrw9Fk/MosfE7nL+QmcXP1k+R++82CTDqwh6
         jk6NxkBT4u1E0qOToja805HuHSIyGZCPW22bQb3DGPHQ+Yq5DOOOBtt5FmNPEmwafhW1
         CgGg==
X-Forwarded-Encrypted: i=1; AKwUvBxCE8OVYbVVLiGq9GrftQ8yyU3ScRBuOuJdVuo2u9uAu5nZvqKAnqIptNTLirG+FEITcQGfvNfiyyw=@vger.kernel.org
X-Gm-Message-State: AFuF++mXuM1u/sxttunmUQ1Ef6241ntcu+EVmmaeRSdRwBIGMRKGIhkF
	mlGLW5ozz+D+Osgyh5odGGub5TOlH6iYrXeckX5nrexWqMSxEAileGEL8cPfyD8BtAVhEE+DvwF
	YbgIVv2+oxY/uyQ==
X-Received: from pgvc3.prod.google.com ([2002:a65:6183:0:b0:cc4:56ea:7ae7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1b81:b0:3da:bea4:6215 with SMTP id adf61e73a8af0-3dd8c52948cmr7756540637.19.1789762022690;
 Fri, 18 Sep 2026 13:07:02 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:37 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-12-dmatlack@google.com>
Subject: [PATCH v9 11/13] PCI: liveupdate: Freeze preservation status during shutdown
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
index 3c9a10a892fc..496ba74c26ce 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -481,6 +481,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
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
@@ -547,6 +552,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (!dev->liveupdate.outgoing) {
 		struct pci_dev_ser *dev_ser;
 
@@ -797,6 +807,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
2.55.0.1082.g2b9226bbc0-goog

