Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D60356765
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611739; cv=none; b=t27pliTlHdc5o9NU2FPgSGjaQoZu51Hw+ACFItuRMTLtbKlPPUQbudV8SUbPvlt8qV+nrprIpfECc31Oorf7GG4+20e+UAqPLgj9LN8Xx4rfs4NCqwEZUGZJyKRkVbtQrgByQOuRaTcUakGj0UZKBJG5LMsZ+qUscsJnjzROBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611739; c=relaxed/simple;
	bh=5eV0dJJRt4VWJ4O9FhX9aKU43f4kGOcveDugXcXvQgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F1Fm8rQKhqV+6xYaDrNHLT5iP1fQZpLk18G5bUR9Qj3cdW4LmWVcl8PFKGbmQ6/b3VSjtWTRYkKw1ecVOh7SWg8mS41hlI4k8qih+UmdZZ19FSiepqMr/YTHNBrqsC/T2Z5umvKqgJqqvrYYdlWCTth7xhvvTmMwGBgTcwQA56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4EhqpIy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4EhqpIy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso1499683a12.3
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611736; x=1779216536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf7tBxAoZfUaNtQaP4XWMUKhokf1zfg+pw28xJapIfc=;
        b=R4EhqpIytnMOm2hqK9TEC69XNZjacl+1wy7ThPZCraxzakcAIe7x+xZor4j04fnxAX
         diW0wv3XY0TbHo5ew6FBfzt3JVDvqzwNK4AduzoIYl7IDxl1kVuHZ4U9T4tJIocVGWJB
         MZxp5bZkR580TLfi6y0hT24O6lITW2ccASih0OBFrsBnrcLJDBJeAh2UoDBSLtSpT0ij
         y0IBtQ+C+SN7DYvkBzNWxH16zozlTKJx/yTVwwn87TaqAH/FdgpPhxWoV5FHp77kJJNG
         qRm5E0R1/4AG3WSSHQATTFX/ki0eSY+uypSAkDuUiDYBVdbK6G/y/1/n0X1/X1DNS0r7
         XeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611736; x=1779216536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf7tBxAoZfUaNtQaP4XWMUKhokf1zfg+pw28xJapIfc=;
        b=DFlZ2P2YlpjR6L4Q5v+Rh3qz5kXMGhbLzE2UY6LZWR8hUbnuAmwLLtRDpNSiifEtP+
         f5YwMnVCmd1BNFbA9HOtbWwNlmmzAIDUWnbH+PeGA8nMUn0WPY2ycJzQ4QJIWh5WDRqx
         kELn8tXyRzUKoQ3GH5P0cqlkFmTpSXUgAwoQivjUXg5E2zGPO3fr1ZsrG/dhNnc+PP2S
         O80IPXh4GU0tlJtNzCY6OMgJtgMA6/a6CoifEQajK9yOBIOsU27G0I89/C0JkUGvDSsw
         5rVUzEeuzHbn3c/muxBuWtE7MnHrqxRxArenOHSJGqZdeKkF2jaIGRbmt/M4uW8SJg0H
         O9rw==
X-Forwarded-Encrypted: i=1; AFNElJ+oeScksD14wQsVWSD/ux2TASortpaQ7jGs2EMDULLiWmvlCBHjDoao231VJDfemUGOVOeeEJE7j08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUmGumyGy0HmkacNOoC3M6ruEIp/qsMNfH94ff304zFKiW2aF
	z9nFgE+5vMA8kgLk9Un9H89rBd6gSDeOIoo0yNXXEtpMScVAHnwLsQ2qjhYoJZZ+I/nbVsmDIR5
	u20HiwYE1haaBHg==
X-Received: from pfbem38.prod.google.com ([2002:a05:6a00:3766:b0:835:38e9:3254])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3386:b0:395:ce56:4448 with SMTP id adf61e73a8af0-3ad975a01camr4741664637.25.1778611735458;
 Tue, 12 May 2026 11:48:55 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:40 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-6-dmatlack@google.com>
Subject: [PATCH v5 05/11] PCI: liveupdate: Keep bus numbers constant during
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
to enumerate devices below it. This is a safety measure to prevent
topology conflicts.

Require that CONFIG_CARDBUS is not enabled to enable
CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
bridges requires additional work but is not a priority at the moment.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/liveupdate.c                      | 60 +++++++++++++++++++
 drivers/pci/liveupdate.h                      |  6 ++
 drivers/pci/probe.c                           | 21 +++++--
 5 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..a64af71c2705 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5138,7 +5138,11 @@ Kernel parameters
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
index eea0a6cd388a..aa665231921c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support (EXPERIMENTAL)"
-	depends on PCI && LIVEUPDATE && 64BIT
+	depends on PCI && LIVEUPDATE && 64BIT && !CARDBUS
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d77e64906a25..558fbaec8ddd 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -93,6 +93,21 @@
  * bound to the correct driver. i.e. The PCI core does not protect against a
  * device getting preserved by driver A in the outgoing kernel and then getting
  * bound to driver B in the incoming kernel.
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
+ * while there are preserved devices, itss secondary and subordinate bus numbers
+ * will be cleared and devices below it will not be enumerated.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -107,6 +122,20 @@
 
 #include "liveupdate.h"
 
+/*
+ * During a Live Update, preserved devices are allowed to continue performing
+ * memory transactions. The kernel must not change the fabric topology,
+ * including bus numbers, since that would require disabling and flushing any
+ * memory transactions first.
+ *
+ * To keep things simple, inherit the secondary and subordinate bus numbers on
+ * _all_ bridges if _any_ PCI devices are preserved (i.e.  even bridges without
+ * any downstream endpoints that were preserved).  This avoids accidentally
+ * assigning a bridge a new window that overlaps with a preserved device that is
+ * downstream of a different bridge.
+ */
+static atomic_t inherit_buses;
+
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
  * @ser: The outgoing struct pci_ser for the next kernel.
@@ -132,6 +161,29 @@ static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
 	return domain << 16 | bdf;
 }
 
+bool pci_liveupdate_inherit_buses(void)
+{
+	return atomic_read(&inherit_buses);
+}
+
+static void pci_set_liveupdate_inherit_buses(bool enable)
+{
+	/* Ensure updates to inherit_buses do not race with rescans */
+	pci_lock_rescan_remove();
+
+	/*
+	 * Increment/decrement instead of setting directly to true/false so that
+	 * pci_liveupdate_inherit_buses() returns true if any device is outgoing
+	 * preserved or incoming preserved.
+	 */
+	if (enable)
+		atomic_inc(&inherit_buses);
+	else
+		atomic_dec(&inherit_buses);
+
+	pci_unlock_rescan_remove();
+}
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing;
@@ -171,6 +223,8 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 
 	args->obj = outgoing;
 	args->data = virt_to_phys(outgoing->ser);
+
+	pci_set_liveupdate_inherit_buses(true);
 	return 0;
 }
 
@@ -178,6 +232,8 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing = args->obj;
 
+	pci_set_liveupdate_inherit_buses(false);
+
 	WARN_ON_ONCE(outgoing->ser->nr_devices);
 	kho_unpreserve_free(outgoing->ser);
 	kfree(outgoing);
@@ -215,6 +271,8 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 	}
 
 	args->obj = incoming;
+
+	pci_set_liveupdate_inherit_buses(true);
 	return 0;
 }
 
@@ -222,6 +280,8 @@ static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_incoming *incoming = args->obj;
 
+	pci_set_liveupdate_inherit_buses(false);
+
 	xa_destroy(&incoming->xa);
 	kho_restore_free(incoming->ser);
 	kfree(incoming);
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index eaaa3559fd77..0bd3e961d5c5 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+bool pci_liveupdate_inherit_buses(void);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -21,6 +22,11 @@ static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
+
+static inline bool pci_liveupdate_inherit_buses(void)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b5fdc5017f92..08ea9324647b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1375,6 +1375,14 @@ bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_should_assign_new_buses(void)
+{
+	if (pci_liveupdate_inherit_buses())
+		return false;
+
+	return pcibios_assign_all_busses();
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1402,6 +1410,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	const bool assign_new_buses = pci_should_assign_new_buses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1454,8 +1463,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_new_buses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1497,8 +1505,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_new_buses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1512,6 +1519,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (pci_liveupdate_inherit_buses()) {
+			pci_err(dev, "Cannot reconfigure bridge during Live Update!\n");
+			pci_err(dev, "Downstream devices will not be enumerated!\n");
+			goto out;
+		}
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
-- 
2.54.0.563.g4f69b47b94-goog

