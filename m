Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA33BB109
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718790; cv=none; b=WYg4sxSMS5yKZmEyWH6KaHuxm+RAsjqg4oFBI90TELHaizETEp2sQZfquIf+2wj4VuhMdBecFSvu7voxgGayHf3yBfLEfTQ4MBcgcTBHTzJg3tkF63wCwN2dZnOt+faj/G3hvj7fc9h2CNw3noiAVDvIAZpWBHys+sO5dnE57SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718790; c=relaxed/simple;
	bh=l99c6rideUNoGc9UcbCSKFpumoM8k0lZ5nIWPqVf/BA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVrUjV4bYa+yw0TNzu+CwzfPdi5TibTZIc57mwWkFeD20THmuCMuM4WYSTZV8iv85yaqHmSQoRo+7c1ygOyARzul3yyTXtGZtWPBkXW+pK1wyPVCmwJs7Pve1n0TL1Sp9itoSE8hyYgOayKn0RvP1VN68cUFp9t5MGVkMQLg5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnIjcl8G; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnIjcl8G"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cccfa32670so17449765ad.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718787; x=1784323587; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/hPVaDoRJAueZjNQ0NAjSyINZ2msgaXxj6lZgcfKzVg=;
        b=XnIjcl8GP0BeNPMuR3E+2TPaY46XpFdM9ZkZFwDBn899JoFKugXNr1DYLvHHI0fSGD
         OlSThidGYZJATznXk+tk2/l2PBocqDU5Xv41UqzQdW9rk6Zt8ufIME4kVJX7RN7BKU/S
         tHvJEU0EGbCjrM8mgu86T1Va8ftiRaFi9Y6Qh0qMTDu/txPMSIxfuOIJcGpYHaQK4ox5
         xnLdMD9PZgHTN8gzb8c/xXXaWh5SgSo4ENoA9/ZYIGLOu5eLZilwERnpqDJz8+PYzmZc
         E9AGOk/v1AcdJ0ClVW5Mbwze0j2z5fhdhzY/rv7yjGAMW7bjbbKr63TQzNbH46xhHhX/
         siYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718787; x=1784323587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hPVaDoRJAueZjNQ0NAjSyINZ2msgaXxj6lZgcfKzVg=;
        b=YawBp8RMwtYH+2cW7mSYKSFj3PmwNDWtt97VZlE6azgi1bLSsSPwz9USs9r8xlj2b3
         WcRZVE1fmtBw4s3qSD050N014DfAKK0J+1UNB3SD2NYWPqsRJvKBVAPh+Ql+FITappPD
         +Q0nTFLSMTxbIELtrhj2EOji9Kh+nCauZ36PpfF5FfCmF6zZLs6pis9mWY8L7bUpp5qP
         yiyeSKJ63FRhY654lT59UYv6k9XIiFBm3bUwn8NhpQlhr66mHstru/WvsyEQpOU8B6ez
         603qkOtAN2AiCjpr+5M0NYqaTysxoqSGbXYAplYMjK45JT61qwYqKRrwgLnHhWkMsnEL
         oHmw==
X-Forwarded-Encrypted: i=1; AHgh+Rq55tytB/L2Xd8aTjhu6PN09j1dBI0o/YOFLW4a0CLGFZjXe/YrgBhK1iy6XwvHONzE0PD9KR3EIG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ulDEJbZ6ITJ9PqMM0IrFe/VYsnhFTpj1h7n8xbkzIjQjg9Lv
	saNuBtpyfPUjgCUBB1J7ywf+jRW/6F0PRYKRaZMJx5aVL/ljV/s7KINQKLl09x9vouwcxySE7aQ
	TPPqPrcB+PcyPEg==
X-Received: from plhu3.prod.google.com ([2002:a17:903:1243:b0:2cc:c59c:76ac])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e94e:b0:2ca:bf68:2a54 with SMTP id d9443c01a7336-2ce9f021408mr7596855ad.22.1783718787297;
 Fri, 10 Jul 2026 14:26:27 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:08 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-6-dmatlack@google.com>
Subject: [PATCH v7 05/12] PCI: liveupdate: Keep bus numbers constant during
 Live Update
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
topology, including bus numbers, since that would require disabling
and flushing any memory transactions first.

To keep bus numbers constant, always inherit the secondary and
subordinate bus numbers assigned to bridges during scanning, instead of
assigning new ones, if any PCI devices are being preserved. Note that
the kernel inherits bus numbers even on bridges without any downstream
endpoints that were preserved. This avoids accidentally assigning a
bridge a new window that overlaps with a preserved device that is
downstream of a different bridge.

If a bridge is scanned with a broken topology or has no bus numbers
set during a Live Update, refuse to assign it new bus numbers and refuse
to enumerate devices below it until the Live Update is finished. This is
a safety measure to prevent topology conflicts.

Require that CONFIG_CARDBUS is not enabled to enable
CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
bridges requires additional work but is not a priority at the moment.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +-
 drivers/pci/Kconfig                           |   2 +-
 drivers/pci/liveupdate.c                      | 102 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  14 +++
 drivers/pci/probe.c                           |  17 ++-
 include/linux/pci_liveupdate.h                |   4 +
 6 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4f65b2a37521..ed9eef8de64c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5105,7 +5105,11 @@ Kernel parameters
 				explicitly which ones they are.
 		assign-busses	[X86] Always assign all PCI bus
 				numbers ourselves, overriding
-				whatever the firmware may have done.
+				whatever the firmware may have done. Ignored
+				during a Live Update, where the kernel must
+				inherit the PCI topology (including bus numbers)
+				to avoid interrupting ongoing memory
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
index a067632e70d1..b2b950d71657 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -86,6 +86,21 @@
  * bound to the correct driver. i.e. The PCI core does not protect against a
  * device getting preserved by driver A in the outgoing kernel and then getting
  * bound to driver B in the incoming kernel. This may change in the future.
+ *
+ * BDF Stability
+ * =============
+ *
+ * The PCI core guarantees that preserved devices can be identified by the same
+ * bus, device, and function numbers for as long as they are preserved
+ * (including across kexec). To accomplish this, the PCI core always inherits
+ * the secondary and subordinate bus numbers assigned to bridges during scanning
+ * if any device is preserved. This is true even on architectures that always
+ * assign new bus numbers during scanning. The kernel assumes the previous
+ * kernel established a sane bus topology across kexec.
+ *
+ * If a misconfigured or unconfigured bridge is encountered during enumeration
+ * while there are preserved devices, its secondary and subordinate bus numbers
+ * will be cleared and devices below it will not be enumerated.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
@@ -436,6 +451,93 @@ static void pci_liveupdate_flb_put_incoming(void)
 	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
 }
 
+/**
+ * pci_liveupdate_scan_bridge_begin() - Determine if a bridge should inherit bus numbers
+ * @bus: The parent bus of the bridge.
+ * @dev: The PCI bridge device.
+ * @pass: The scan pass (0 for first pass, 1 for second pass).
+ *
+ * This function is called by the PCI core when it begins scanning a bridge.
+ * It determines whether the bridge should inherit the secondary and subordinate
+ * bus numbers assigned to it by the previous kernel. This is necessary to
+ * keep bus numbers constant for preserved devices downstream of the bridge.
+ *
+ * Return: True if bus numbers should be inherited, false otherwise.
+ */
+bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
+				      int pass)
+{
+	struct pci_dev *parent = bus->self;
+
+	/*
+	 * On the second pass, reuse the value that was set on the first pass
+	 * so that the passes are consistent with one another.
+	 */
+	if (pass)
+		return dev->liveupdate.inherit_buses;
+
+	/*
+	 * If the parent bridge is being forced to inherit its bus numbers
+	 * during this scan then this bridge must as well, otherwise the PCI
+	 * core could expand this bridge's reservation beyond its parent (which
+	 * cannot expand).
+	 */
+	if (parent && parent->liveupdate.inherit_buses) {
+		dev->liveupdate.inherit_buses = true;
+		return true;
+	}
+
+	/*
+	 * Otherwise, if there are any incoming preserved devices, force the
+	 * bus numbers to be inherited to avoid changing the bus numbers
+	 * assigned to those devices during enumeration.
+	 *
+	 * To keep things simple, inherit bus numbers on all bridges if any PCI
+	 * devices are incoming, to ensure that no bridge's reservation is
+	 * expanded to overlap with a preserved device downstream of a different
+	 * bridge.
+	 */
+	scoped_guard(rwsem_read, &pci_liveupdate.rwsem) {
+		struct pci_flb_incoming *incoming;
+
+		incoming = pci_liveupdate_flb_get_incoming();
+		if (!incoming) {
+			dev->liveupdate.inherit_buses = false;
+			return false;
+		}
+
+		/*
+		 * It is safe to sample incoming->ser->nr_devices and then
+		 * drop the rwsem since nr_devices will only decrease. Thus the
+		 * only "race" is that the current scan will be overly
+		 * conservative and force bus inheritance.
+		 */
+		dev->liveupdate.inherit_buses = !!incoming->ser->nr_devices;
+		pci_liveupdate_flb_put_incoming();
+	}
+
+	return dev->liveupdate.inherit_buses;
+}
+
+/**
+ * pci_liveupdate_scan_bridge_end() - Finish scanning a PCI bridge
+ * @dev: The PCI bridge device.
+ * @pass: The scan pass (0 for first pass, 1 for second pass).
+ *
+ * This function is called by the PCI core when it finishes scanning a bridge.
+ * It clears the inheritance status after the second pass so it can be
+ * re-evaluated on future scans.
+ */
+void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
+{
+	/*
+	 * Clear inherit_buses after the second pass so it can be re-evaluated
+	 * on future scans.
+	 */
+	if (pass)
+		dev->liveupdate.inherit_buses = false;
+}
+
 void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
 	struct pci_flb_incoming *incoming;
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index eaaa3559fd77..c763255a8de4 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,9 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
+				      int pass);
+void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -21,6 +24,17 @@ static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
+
+static inline bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus,
+						    struct pci_dev *dev,
+						    int pass)
+{
+	return false;
+}
+
+static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
+{
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5dc9d86e3597..165973bc92aa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1397,6 +1397,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool liveupdate, assign_new_buses = pcibios_assign_all_busses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1406,6 +1407,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u8 fixed_sec, fixed_sub;
 	int next_busnr;
 
+	liveupdate = pci_liveupdate_scan_bridge_begin(bus, dev, pass);
+	if (liveupdate)
+		assign_new_buses = false;
+
 	/*
 	 * Make sure the bridge is powered on to be able to access config
 	 * space of devices below it.
@@ -1449,8 +1454,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_new_buses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1492,8 +1496,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_new_buses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1507,6 +1510,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (liveupdate) {
+			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
+			goto out;
+		}
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
@@ -1567,6 +1575,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 
 	pm_runtime_put(&dev->dev);
+	pci_liveupdate_scan_bridge_end(dev, pass);
 
 	return max;
 }
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index cfdc3d62ec02..2be98819e313 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,10 +17,14 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @inherit_buses: True if the PCI core should inherit the secondary and
+ *                 subordinate bus numbers assigned to this device due to
+ *                 an ongoing Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	bool inherit_buses;
 };
 
 struct pci_dev;
-- 
2.55.0.795.g602f6c329a-goog

