Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041442;
	b=QL8Z6C2NTcqAlcATyqUHp1I1ZMuARInYuSrd8h+NPZ7KSQJQZbKWq4Tiv2ZXCDZ2Nzfe
	 GFA1CAfY1kFnaoOaBLxqyGOVANpbY4ul1thai0eKn/E31rL8HK6wTitELzg25iKPIuP+G
	 NOTZ3FQMQhn/LIaL/MuPws4UCtwkdFkLHr2FbRLj6ecXUJUCqPiFdoODeGl1U7I11MDet
	 /yTtdfgdy9P6Qn9U+77N36oB2jKgjbIJw33JHhEOuLvUbGYSsSwXvdrCfsC6TQAyXqo19
	 LwAacVi1hKiV+MSzPVw8SnW/RyUqipnu15oaYvlazuZI6mTWA91BUGlmtx6CtBg88AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HNkkfP2cevkFVfIGomWPdBlTDGkki6pISPgO29QlZFU=;
	b=VCg9sTEoL8vApeCHWLUX2tbXljNVuUNKsOw9/LfLMi9z9rimltJG8X/LTaNJOr8LW41O
	 4KwE+VFgCNZm3y8VK+JfPMNVJPqV8C1+cB8ELgn4l3M46snyC+o73AzpKWdDC/4YPcdJx
	 OUYJ/BwLX7UxMSJoGyoDbWBJrvakjl0dwlin20HDxfV7ozxhk0DSdMuXQOtNZSkOUdRTn
	 yOyo5Ccz8W6yM4luMZDpgntNwje3xxIapb5KOBBXLxTpIAgR/ncWVirRakVeDhWeY3UtA
	 L/l/aDkWZfobYcTtlZIw/0MdYRci5n77pWJz0f6ijPBfaJAz6hzMCLSgFztVvQyCkig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GKZ3TwgD;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AE60A6F6A
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648AE60A6F6A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GKZ3TwgD
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-567e742f481so951540b6e.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041441; x=1795646241; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNkkfP2cevkFVfIGomWPdBlTDGkki6pISPgO29QlZFU=;
        b=GKZ3TwgDVpOhVv4K2Yl13YrEs3+5DcsK77RtcT2ZRw0y8zVT5a0R5AhqhOKIk1j5ac
         tq5L9VkTF9MK6W6KHgSaIupcuMsIMzB3Na3ESPZwp6MToNsCjzpG1mW9dnC6Q+0gzNig
         jiXgITzuE2ymGwiba/4S1Y60bbqifLP1j4UnMWrgxi7BeujxYwkqounc2/WBn/tov4PI
         taSelONdCawtt1M89XTOAaOxsLuNSIwvCNi6OLlDmLyg8C8OXGGcCwB5eFd40MKscY8s
         W9u2s6MxvtoeHnzU3ngfvlCArrNipao2cgGFLBGFv14hi0CZOVyllYCnLhdJw+XsDu5V
         WL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041441; x=1795646241;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNkkfP2cevkFVfIGomWPdBlTDGkki6pISPgO29QlZFU=;
        b=nL8UvH7MHeRkiOPP8lvq1KDgLec+vBVv5LiNqFqr3O7Q7C46STFO2m9Pj3OlliMjtG
         w7Gdeqfcc2zjWsvD8CWHFCkTHjX0lGbY4CM+6lt7u4p0LToOFuj5x9sUmahI3NlQ2UV4
         4XLbnVIZSFSkIiG73NhM+S+f7w/Zw6vEGC9bOREM5B4FxO+OawuENeBHiSlxTrLQI+Il
         KAjHNDH4Q6/orLwFk+27STHogeYmMisWL0xVDam9we4MtafVdP0f7hAzvGCKpkUijAJr
         nJnid7yPGLnREp20rwGe6c6JQPZvfeSAmq0obkKt+s7oY4SQBzThSecMUNPg1q/yqvUE
         8x6g==
X-Forwarded-Encrypted: i=1; AL+hErErYVRMPgYzPtGr/Nyr/F6JCq+mRnOihUmW3v5WtCHSkmaM/ehp1GynJnKINGBf2sM4Kl6wNgVKEOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hoJQ8k8srFVE+wvlUKz3UFML+mCzEBvA6mJx0Tm1RtDD+bhE+
	WWB/g3pUj5UYQxaJLijPTYM19whBk+pvtS7uAHkUMEMvtiiyahD+i2Izpoxb2Onr+2KnOUctwyC
	BHsxtHGkn5prP4g==
X-Received: from ilbek7-n2.prod.google.com ([2002:a05:6e02:4f07:20b0:549:da41:90bc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3385:b0:4c4:9f7e:92ce with SMTP id 5614622812f47-57741723d34mr4740022b6e.38.1795041441133;
 Wed, 18 Nov 2026 14:37:21 -0800 (PST)
Date: Wed, 18 Nov 2026 22:37:02 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-12-dmatlack@google.com>
Subject: [PATCH v11 11/13] PCI: liveupdate: Freeze preservation status during shutdown
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
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

The PCI core freezes every device in pci_device_shutdown(), not just
preserved ones, so that no device can be preserved or unpreserved after
its shutdown starts.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/liveupdate.c       | 19 +++++++++++++++++++
 drivers/pci/liveupdate.h       |  5 +++++
 drivers/pci/pci-driver.c       |  2 ++
 include/linux/pci_liveupdate.h |  3 +++
 4 files changed, 29 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a45ad86370d5..e26d2f5c2338 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -126,6 +126,9 @@
  *  * The device cannot require device-specific quirks to enable Access
  *    Control Services (ACS).
  *
+ * In addition, a device cannot be preserved or unpreserved once the PCI core
+ * has started shutting it down (pci_device_shutdown()).
+ *
  * Driver Binding
  * ==============
  *
@@ -520,6 +523,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
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
@@ -569,6 +577,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
+	if (dev->liveupdate.frozen) {
+		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
+		return -EINVAL;
+	}
+
 	if (dev_ser) {
 		/*
 		 * Endpoint devices can only be preserved once. Bridges are
@@ -784,6 +797,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
index e1c1d2fa00e4..03211dbebc7b 100644
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
@@ -31,6 +32,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
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
index 7efe808cdf0c..8b11bd3dc5bc 100644
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
2.56.1.703.gf848ed807c-goog

