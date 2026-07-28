Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9C477E24
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276633; cv=none; b=BtOQ3GZxylR5NfpsTMuQCYyOjzgVWUC9S2faWyaYfo1IJOXfMZ9sigLKHBUAeOnd5ba+2YrO6KvpDBtHQDeKV/tATUE4mR90MCS081uAJcldx0BspYA7lLCuN4ZjJich+yXIZ2odhYNb3DPNHVp7+S3vZTz5Xlypq9RxXPcPaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276633; c=relaxed/simple;
	bh=e50nSOwdR1VqexlVkqhhrlj7y5D2Ddh/5PBNLm3zoi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tzPMRQrWfEDxpp7m3sRdNol3O7LwBe3BlgPjYr7NVZ3evF3Exuw+nRtI4PKOVOhlKqzP2ayqO4xbm5SL69KppgAW4cg2CRaepphZeOneDPlrFLidtmy4sq3SQ7yD0vcrmpMI50q74ZE+c9gBMVoNBC6PyDZ1anXZKiJhXpxmwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzlwNB84; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzlwNB84"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so219276a91.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276625; x=1785881425; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ie+eI/koF7po3m7kzWZc+lJwyneNfjZRODTLriXqOwk=;
        b=HzlwNB846MRWWBWfbb1GyRER1+RVBG3ovM/tYv6OBB6PQB9ex94YPPXFuqJ2ibrXc2
         l3p6C0vvItomXv7e4D+Rp6xkaVt/NjiHDJRovuY6uGq88BduDa5Wtoj8TuhZJGj/rIjQ
         2YB3vPs5FmSw92+hFzptHATzhz+qQzVyMlsXzh0QjpR1oF8c2Dg0WwuoA5cA9mKHmery
         QwyVFkel67CV8jL4dkNzHlZLiOuNYor3817jC/NmwO6YrZlZgFkXX903G9DtQH63JAfc
         6L+KkXR2mGmQaClZv5PzpPgB26rfsn4A/rMmsuHjJy7OWjWOpc0Qb66eMWzbFc1Bc+9S
         5I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276625; x=1785881425;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ie+eI/koF7po3m7kzWZc+lJwyneNfjZRODTLriXqOwk=;
        b=A4CURhoyn7SIMmy55yhyc7+gzfzxIkrkc5yniZwD80jghNE8Od9rRGNX0drgnuE+ny
         MlHLaDKaMfgES7gxeg/mgfULwAjRBVfmpkw2a2Zv+DIhct1CuR6jma2xdllOv9srzx7T
         EGp0OLFDVuEdd31SKq4ZIiiA9qsIPpYrKM1PFV3E3/M5JOGbh9ua75kFYhivH/5qofjZ
         oiBCrb9v8FXtnl3n9h2ZpOrXi6/p9t1TaaOrvvVVKedrSB62WcK5cdcusRGXwpKxlEAe
         Lg6DfvxVMKVJ1+Xeh0f3MW7nuZotuNe+9bvqd6JrN9PdKjwir1Pmvp+qfg1MwLyKidYd
         v42Q==
X-Forwarded-Encrypted: i=1; AHgh+RrNwb4Gka7QyXKPen6t2G4SdmOYiLwbBS2JZ0GvHA1ukEWQ42hefeFho4spgsDp2gaE2yTv+5yqAVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5v+nA+BRyL80WEhG3BUp0aNNh9aS3tb5uCsIV1L2Ne0pXkTb
	8t2iInw72zX3+Q/Zpo1YG8BojD6a0IDVInFH5l/UM2y9CqIyLO5p+8sXiom7IMboWHZtyGHlTLJ
	WKTuENErfKoyKxA==
X-Received: from pjqh19.prod.google.com ([2002:a17:90a:a893:b0:38e:ffcd:b70f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d46:b0:37f:eda5:5169 with SMTP id 98e67ed59e1d1-38f6a44b293mr4069719a91.13.1785276624975;
 Tue, 28 Jul 2026 15:10:24 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:09:59 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-6-dmatlack@google.com>
Subject: [PATCH v8 05/12] PCI: liveupdate: Preserve bus numbers during Live Update
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

During a Live Update, preserved devices must be allowed to continue
performing memory transactions so the kernel cannot change the fabric
topology, including bus numbers, since that would require disabling and
flushing any memory transactions first.

To keep bus numbers constant, always preserve the secondary and
subordinate bus numbers assigned to bridges during scanning, instead of
assigning new ones, if any PCI devices were preserved. Note that the
kernel preserves bus numbers even on bridges without any downstream
endpoints that were preserved. This avoids accidentally assigning a
bridge a new window that overlaps with a preserved device that is
downstream of a different bridge.

If a bridge is scanned with a broken topology or has no bus numbers set
during a Live Update, refuse to assign it new bus numbers and refuse to
enumerate devices below it until the Live Update is finished. This is a
safety measure to prevent topology conflicts.

Require that CONFIG_CARDBUS is not enabled to enable
CONFIG_PCI_LIVEUPDATE since preserving bus numbers on PCI-to-CardBus
bridges requires additional work but is not a priority at the moment.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/liveupdate.c                      | 95 +++++++++++++++++++
 drivers/pci/liveupdate.h                      | 13 +++
 drivers/pci/probe.c                           | 18 +++-
 include/linux/pci_liveupdate.h                |  4 +
 6 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4f65b2a37521..c394a0df8e31 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5105,7 +5105,11 @@ Kernel parameters
 				explicitly which ones they are.
 		assign-busses	[X86] Always assign all PCI bus
 				numbers ourselves, overriding
-				whatever the firmware may have done.
+				whatever the firmware may have done. Ignored
+				during a Live Update, where the kernel must
+				preserve the PCI topology (including bus
+				numbers) to avoid interrupting ongoing memory
+				transactions of preserved devices.
 		usepirqmask	[X86] Honor the possible IRQ mask stored
 				in the BIOS $PIR table. This is needed on
 				some systems with broken BIOSes, notably
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8af20f558086..16fbd4212e0f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support"
-	depends on PCI && LIVEUPDATE && 64BIT
+	depends on PCI && LIVEUPDATE && 64BIT && !CARDBUS
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 0f7a018ddc66..d312381c9e10 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -87,6 +87,21 @@
  * bound to the correct driver. i.e. The PCI core does not protect against a
  * device getting preserved by driver A in the outgoing kernel and then getting
  * bound to driver B in the incoming kernel. This may change in the future.
+ *
+ * BDF Stability
+ * =============
+ *
+ * The PCI core guarantees that preserved devices can be identified by the same
+ * bus, device, and function numbers for as long as they are preserved
+ * (including across kexec). To accomplish this, the PCI core always preserves
+ * the secondary and subordinate bus numbers assigned to bridges during scanning
+ * if any device is preserved. This is true even on architectures that always
+ * assign new bus numbers during scanning. The kernel assumes the previous
+ * kernel established a sane bus topology across kexec.
+ *
+ * If a misconfigured or unconfigured bridge is encountered during enumeration
+ * while there are preserved devices, its secondary and subordinate bus numbers
+ * will be cleared and devices below it will not be enumerated.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -489,6 +504,86 @@ static void pci_liveupdate_flb_put_incoming(void)
 	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
 }
 
+static bool pci_has_incoming_preserved_devices(void)
+{
+	struct pci_flb_incoming *incoming;
+	u32 nr_devices;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	incoming = pci_liveupdate_flb_get_incoming();
+	if (!incoming)
+		return false;
+
+	nr_devices = incoming->ser->nr_devices;
+	pci_liveupdate_flb_put_incoming();
+
+	return nr_devices > 0;
+}
+
+/**
+ * pci_liveupdate_preserve_bus_numbers() - Determine if the PCI core should
+ *                                         preserve bus numbers when scanning
+ *                                         the provided bridge.
+ * @bus: The parent bus of the bridge.
+ * @dev: The PCI bridge device.
+ *
+ * This function is called by the PCI core when it is scanning a bridge.  It
+ * determines whether the PCI core should preserve the secondary and subordinate
+ * bus numbers assigned to @dev by the previous kernel. This is necessary to
+ * keep RequesterIDs constant for preserved devices issuing memory transactions.
+ *
+ * Return: True if bus numbers should be preserved, false otherwise.
+ */
+bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
+{
+	struct pci_dev *parent = bus->self;
+
+	if (dev->liveupdate.preserve_bus_numbers)
+		return true;
+
+	if (parent && parent->liveupdate.preserve_bus_numbers) {
+		/*
+		 * Preserve bus numbers if the parent bridge is required to
+		 * preserve bus numbers. Otherwise the PCI core could expand
+		 * this bridge's reservation beyond its parent (which cannot
+		 * expand).
+		 */
+		dev->liveupdate.preserve_bus_numbers = true;
+	} else {
+		/*
+		 * Otherwise preserve bus numbers if there are any incoming
+		 * preserved devices. This ensures that the PCI core does not
+		 * allocate a bus number to a non-preserved device that
+		 * conflicts with the bus number already assigned to a preserved
+		 * device.
+		 *
+		 * This is slightly more restrictive than it needs to be. For
+		 * example, each host bridges have their own range of bus
+		 * numbers that won't conflict with other host bridges. But the
+		 * previous kernel should have assigned a sane bus topology and
+		 * it is simpler to just adopt that entire topology.
+		 */
+		dev->liveupdate.preserve_bus_numbers =
+			pci_has_incoming_preserved_devices();
+	}
+
+	return dev->liveupdate.preserve_bus_numbers;
+}
+
+/**
+ * pci_liveupdate_scan_bridge_end() - Finish scanning a PCI bridge
+ * @dev: The PCI bridge device.
+ *
+ * This function is called by the PCI core when it finishes scanning a bridge.
+ * It clears the bus number preservation status of the bridge so it can be
+ * re-evaluated on future scans.
+ */
+void pci_liveupdate_scan_bridge_end(struct pci_dev *dev)
+{
+	dev->liveupdate.preserve_bus_numbers = false;
+}
+
 void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
 	struct pci_flb_incoming *incoming;
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index eaaa3559fd77..107881183fda 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,9 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
+					 struct pci_dev *dev);
+void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -21,6 +24,16 @@ static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
+
+static inline bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
+						       struct pci_dev *dev)
+{
+	return false;
+}
+
+static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev)
+{
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5dc9d86e3597..5ecb55412854 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1397,6 +1397,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool preserve_bus_numbers = !pcibios_assign_all_busses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1406,6 +1407,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u8 fixed_sec, fixed_sub;
 	int next_busnr;
 
+	if (pci_liveupdate_preserve_bus_numbers(bus, dev))
+		preserve_bus_numbers = true;
+
 	/*
 	 * Make sure the bridge is powered on to be able to access config
 	 * space of devices below it.
@@ -1449,8 +1453,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && preserve_bus_numbers && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1492,8 +1495,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (!preserve_bus_numbers || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1507,6 +1509,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (pci_liveupdate_preserve_bus_numbers(bus, dev)) {
+			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
+			goto out;
+		}
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
@@ -1568,6 +1575,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 
 	pm_runtime_put(&dev->dev);
 
+	if (pass)
+		pci_liveupdate_scan_bridge_end(dev);
+
 	return max;
 }
 
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 710026ada2d5..fc1f5640968a 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,10 +17,14 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @preserve_bus_numbers: True if the PCI core should preserve the secondary and
+ *                        subordinate bus numbers assigned to this device due to
+ *                        an ongoing Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	bool preserve_bus_numbers;
 };
 
 struct pci_dev;
-- 
2.55.0.487.gaf234c4eb3-goog

