Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB15384CCD
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481459; cv=none; b=o12Jwrjsy7mL8up2mw0WPGwxxHsQLLSP7lcrzOUNDdXifYHfuZBdANmqgDJyjhZJrn5paafJIYsDCMcS9udV22RyhWDvMSUHGyTkBZz3UCBfzKoU9MQjBs1cM4z+aAj4craBqS2i8KUGX3PUCBNwTJqKGWPVE0BQZclxgUac0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481459; c=relaxed/simple;
	bh=GDbQ9PBK+SH7NBlxXyWCko/j1KI2JfV15RzVb+Cl0x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hLQMeIGXsfafPWGbQ/rtq+MLZfes9Rsljiyx4AxN6+WsEQgc1/op8ArcyO8CTkeRNoz4TcjtcHxQpcvLzNJhKodM6eCQXt6z0xYl5w2RfTvcDF/9PWO40AADuJgxiw/ZRPTjUgGye0CFq0B+GEBYTLUW3+f223CeEaY3mEdE1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubUJSnyD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubUJSnyD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-366344513a3so16024290a91.3
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481457; x=1780086257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=35prD7a6muthxJ5uOKWSGr8dWxpX6CiZ2+eQPVuLFrU=;
        b=ubUJSnyDiqugVjytsBa7NzAfMOCVFqRLBRgl0LIxwBnVBEQo0L6sSP72cdvCwjebx0
         vvUaBdzMVv+GE7SMnXrrKx8BqvV5nKsJJgY/LfUmbWl4DF8dcIft/NKkUfb5Z2ca62b8
         yBkVtq9bUECYcgr9UaHVVltqlBd4wSoersu+pjHViX7wglv8vEjnARXLHV4Vfqv+SFny
         EUzrEUx4gJieqQEaWv2393BhB1cpgdRCCGXhzN27ldllxk58HFMEOCBQaDVqnKv5glt/
         95CVQ7y3hbI36t3qP5qVFYk/jbKgp+chLdjPlQrzryAy7iDJFRz4AQS5r1DGSn3Df9cT
         dwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481457; x=1780086257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35prD7a6muthxJ5uOKWSGr8dWxpX6CiZ2+eQPVuLFrU=;
        b=dC2CDLfxJJ6ZnspnLMVhOh3gU61LK0Oo6/6MG4TBY+dNwmmm7bdnWodWm4bPOCWS4Z
         HVzopTCXw/N6qkCIgrn1eBOjxf2s9V7CMoij35tkxx/phGxNvvbpFPs+O4MHmCscGTFq
         t22BOoi+e/gt4/CRiL9G1im3mdd1Fi8z8tRF6y2ffL4ls3kFc2m7jc2bO7vLvbzpCKcZ
         9R90YUbeEpI4uujH2nNPWuopSwOfB8x90Zjb59+7iewtOiiry8BLYOThxISj5RkaGbVI
         7Gk2r2O5BdBgvwdCI75jWU+d9diifHjRl/40v9c0+YVBF5/6ULUHIUAVyWylvUwKTccm
         o8Hg==
X-Forwarded-Encrypted: i=1; AFNElJ/+2h0EmxfqAKtI/M5J332cgC1hhLvNveb1FxPl9Ri1LXmSDFRSr0erHvIcZPyjk/daLSqDKrohSD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8iSvYggRsqSTm/rODOI89rYmSNKB4414OrCeWpU1VxvluWc7u
	OV+W2kpk13X9bfpIhpVNCRuEvSdPcYMO2+u8m7z0pw2mkh3vaC7bMFVSyjgGpSFnUI4ghv6dk8n
	uyf3BUwJzzSv6tw==
X-Received: from pgbcb21.prod.google.com ([2002:a05:6a02:715:b0:c81:2646:5294])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5746:b0:364:78a5:8d40 with SMTP id 98e67ed59e1d1-36a67639d6dmr5223710a91.20.1779481456386;
 Fri, 22 May 2026 13:24:16 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:03 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-6-dmatlack@google.com>
Subject: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant during
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

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/liveupdate.c                      | 83 ++++++++++++++++++-
 drivers/pci/liveupdate.h                      | 14 ++++
 drivers/pci/probe.c                           | 17 +++-
 include/linux/pci_liveupdate.h                |  4 +
 6 files changed, 119 insertions(+), 7 deletions(-)

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
index e68ae5c172d4..a597fede1b3b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support"
-	depends on PCI && LIVEUPDATE && 64BIT
+	depends on PCI && LIVEUPDATE && 64BIT && !CARDBUS
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 4f2ec6ffdd16..2421bc218916 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -86,6 +86,21 @@
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
+ * while there are preserved devices, its secondary and subordinate bus numbers
+ * will be cleared and devices below it will not be enumerated.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -103,7 +118,7 @@
 /**
  * struct pci_liveupdate_global - Global state for PCI Live Update support
  * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
- *         FLBs, and the references to them in struct pci_dev.
+ *         FLBs and references to them in struct pci_dev.
  */
 struct pci_liveupdate_global {
 	struct rw_semaphore rwsem;
@@ -396,6 +411,72 @@ static void pci_liveupdate_flb_put_incoming(void)
 	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
 }
 
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
+		goto out;
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
+			goto out;
+		}
+
+		/*
+		 * It is safe to sample incoming->ser->nr_devices and then
+		 * drop the rwsem since nr_devices will only decrease. Thus the
+		 * only "race" is that the current scan will be overly
+		 * conservative and force bus inheritance.
+		 */
+		dev->liveupdate.inherit_buses = incoming->ser->nr_devices;
+		pci_liveupdate_flb_put_incoming();
+	}
+
+out:
+	return dev->liveupdate.inherit_buses;
+}
+
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
index 2e2be8af6976..19965bfd347d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1402,6 +1402,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool liveupdate, assign_new_buses = pcibios_assign_all_busses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1411,6 +1412,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u8 fixed_sec, fixed_sub;
 	int next_busnr;
 
+	liveupdate = pci_liveupdate_scan_bridge_begin(bus, dev, pass);
+	if (liveupdate)
+		assign_new_buses = false;
+
 	/*
 	 * Make sure the bridge is powered on to be able to access config
 	 * space of devices below it.
@@ -1454,8 +1459,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_new_buses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1497,8 +1501,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_new_buses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1512,6 +1515,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (liveupdate) {
+			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
+			goto out;
+		}
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
@@ -1572,6 +1580,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
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
2.54.0.746.g67dd491aae-goog

