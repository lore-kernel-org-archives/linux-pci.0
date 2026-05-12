Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C2387346
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611743; cv=none; b=ABIhVCPfDqZIjXwgot9WEB+2aN9tWya8cQf/DdY50j0FaP+3hvcc31NnZ9fkCmXwfTFr0GWA+arwhY+z4a+76ao70Odlqs4EgaMIn7vC3QhCuIOIti6ijc92uSKdprpMKR14IFG2rejgtJWhKtSJu/oJVcyRFiMjg8m/jDgpzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611743; c=relaxed/simple;
	bh=DcYUqGBrMjbaUc6Mk7jCfWJIKE6QDjGPDqYU0wUrIlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pz0fjtWoBHpZ1PVjzPqjNth7sydQ5f1jN0QOwdn/ASfoPuQIBGVCVoTa0RFNBHQfxxjVZco0ElvzEfB22V/zQ1CyDIrnvLLI2FTgUog4tGPEfCL2xRggrEoU9d1vgfZsWwDYM1dYObawE+FHdGChsefLWmofHcBq4V3YYCeaHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhrRhSdw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhrRhSdw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so3413621b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611740; x=1779216540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAKIEIbekI8e2jyBQPj/1aDykzqqCbaXW0rj6vQUpoI=;
        b=WhrRhSdwsFz6bAtsRM0A+/LCwBHSHxiVzzcj3kyvkjIwg/0DwsZcyaXXtvqaXJjxAU
         YxsHdZZHlWCojB9UAlWt+yBgfv+qFwZtpZddw6XQMHvcjJbSQAdOhhXl1YV4/f/fMOQt
         LNmupZjXR55NQ2rtw0AvC0VnahiuoXKk7rropEFEfAWGZhWBbuPS0JaZiFRtgPdUjRp+
         kYEC+UKsy9/CdAvt6nVtqcIBzKNxQFc4zzhnuEo3wRRm3NDl4MZ/2W1j3TtJL+tFGYiT
         B2Sy5H5fBWzs0BCCny2V8rOGJw8HS2k3fbUq2mQZr4LZ0QCgL3BFpMunaYBQ7FPsy+tQ
         ndhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611740; x=1779216540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAKIEIbekI8e2jyBQPj/1aDykzqqCbaXW0rj6vQUpoI=;
        b=i1LfeJ6wg1RcXmo7Nqm19wAWuqJ1F5IcCp4AGQHRnuNxSbWLGG/l6TD20J2nZ0dnBk
         tbr27GngbVZc1j9EdvJT9hr17aes4DDEM9TLYbuDpNqe5F/yJCFqNEVOp53IZmBDJDGU
         +aBnBct93qK5lGBffJBb4GUMyFL+liLURHTiZn5KjBR8KOCxp2PNxKLCfHEi84O+spRB
         usd6spYElxAymXQUdFwRi2QE8DshhtLqywubglbiyi8fdeBirXsK6W/ueLNYpEu5uWO3
         8ATCPyp493FRbo57f1c+fsNFqtDeLvxJM3Na/fupmYwVhOp81MKDpixU164A1r954u9s
         6ibw==
X-Forwarded-Encrypted: i=1; AFNElJ/dw40Mp0QSMUN1pUVQ+LV8SGHimJ+6YFxTjIIBkqBn9BrlYoRJBGHCigL+pkycl7rt/N4gwMHXSX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykfGOwxsYZvzvBIQs/XBcdCglYsKo5sX39DC7ONKG8bFo4PMmR
	QJ6hrCroce7AFS1YCJggcRrWD8MORk95HiIx9qujx0NjZUSBWZqcwtOzClh9hdRT3USPjY2Htd2
	iINJq0iSZj9rNww==
X-Received: from pfbks2.prod.google.com ([2002:a05:6a00:4b82:b0:82f:b296:c01b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12e4:b0:82c:f035:6748 with SMTP id d2e1a72fcca58-83a5dd560e6mr29210159b3a.42.1778611739675;
 Tue, 12 May 2026 11:48:59 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:45 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-11-dmatlack@google.com>
Subject: [PATCH v5 10/11] PCI: liveupdate: Do not disable bus mastering on
 preserved devices during kexec
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

Do not disable bus mastering on outgoing preserved devices during
pci_device_shutdown() for kexec.

Preserved devices must be allowed to perform memory transactions during
a Live Update to minimize downtime and ensure continuous operation.
Clearing the bus mastering bit would prevent these devices from issuing
any memory requests while the new kernel boots.

Because bridges upstream of preserved endpoint devices are also
automatically preserved, this change also avoids clearing bus mastering
on them. This is critical because clearing bus mastering on an upstream
bridge prevents the bridge from forwarding memory requests upstream (i.e.
it would prevent the endpoint device from accessing system RAM and doing
peer-to-peer transactions with devices not downstream of the bridge).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c |  4 ++++
 drivers/pci/liveupdate.h | 12 ++++++++++++
 drivers/pci/pci-driver.c | 31 ++++++++++++++++++++++---------
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 825166a57913..6c4b57d8f780 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -136,6 +136,10 @@
  *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outgoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 30deaa673efe..8ad404307a70 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -18,6 +18,13 @@ bool pci_liveupdate_inherit_buses(void);
 void pci_liveupdate_init_acs(struct pci_dev *dev);
 bool pci_liveupdate_inherit_acs(struct pci_dev *dev);
 bool pci_liveupdate_inherit_ari(struct pci_dev *dev);
+
+static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	guard(read_lock)(&dev->liveupdate.lock);
+	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
+	return dev->liveupdate.outgoing;
+}
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -49,6 +56,11 @@ static inline bool pci_liveupdate_inherit_ari(struct pci_dev *dev)
 {
 	return false;
 }
+
+static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f7a5e65a7c75..b6c931ebd3be 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -532,6 +532,27 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
+/*
+ * Disable bus mastering on the device so that it does not perform memory
+ * transactions during kexec.
+ *
+ * Don't touch devices that are being preserved across kexec for Live
+ * Update or that are in D3cold or unknown states.
+ */
+static void pci_clear_master_for_shutdown(struct pci_dev *pci_dev)
+{
+	if (!kexec_in_progress)
+		return;
+
+	if (pci_liveupdate_is_outgoing(pci_dev))
+		return;
+
+	if (pci_dev->current_state > PCI_D3hot)
+		return;
+
+	pci_clear_master(pci_dev);
+}
+
 static void pci_device_shutdown(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -543,15 +564,7 @@ static void pci_device_shutdown(struct device *dev)
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
-	/*
-	 * If this is a kexec reboot, turn off Bus Master bit on the
-	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
-	 * If it is not a kexec reboot, firmware will hit the PCI
-	 * devices with big hammer and stop their DMA any way.
-	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
-		pci_clear_master(pci_dev);
+	pci_clear_master_for_shutdown(pci_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0.563.g4f69b47b94-goog

