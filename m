Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041436;
	b=rxgAM4JVQYPAX2IntXaU1g9ZfkiP7audzfHJi+//u1SCt3engrFQ7akCCDAcjkSfa45t
	 wevlKFj8cQXjStmHcxKFthobkL1mV4cmXgaT/4vbQ4W3txh/YkPcH+vwX4q1OZjpWkR6l
	 U+kcpKOPZ78gxMVrVivSQnCd70hTZkWk4yAa+A9onYz8ZxmFACK50VRPijwxk+GozFgzy
	 Wc9IZVSXHYXSfsKD7z1aW1AiqwNd9jYV1uuMulngGJSekIYk+lZLjBCwsmIgkp6vFYhtO
	 tZ5mIECu+NDmOy3fzsW/CR3xWtB+/KLIr8rSC/sHqjEXkPbieBfwLmRfb7driQckOfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BGyTYvu/JftJxBMsp5VYPQ/HUeGWqv9z5FyQtv5WTl8=;
	b=QHHqNJshDw0syQ0du9KVXvVQxd/pb0QJ9YGrDvrbB4i7QIpPZ/hLOHspKyVS3zxNMYPH
	 ZtxDjmpqlL/3mZB96zctIm2MaJBBOIeAUFpT8xV1ZGwjL3eF3HBs5eg4TlHCs6F+KZac7
	 VKf+W2GrmwQTUtUXDA4ZyFx0p5OVPcZS1bGCT1UjAbbje5w83Ktu7iOLK9GoFQtJz0YbK
	 ZCPJ10RoluzfyVTaCmeXOeRyeuT31dsJ3H47M94M+b51F/V3ZEVsRDLRVyl2C4dSWQuRj
	 gGdL79OvQRu6qcaFa+JPrrqKc3Obh1S6gEu6QzOX5cz3btC6x/DqHSQCn5V8yuHuIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KeiA4+Y3;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2B60A3820
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A2B60A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KeiA4+Y3
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-451d80641efso1772134fac.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041435; x=1795646235; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGyTYvu/JftJxBMsp5VYPQ/HUeGWqv9z5FyQtv5WTl8=;
        b=KeiA4+Y3VFj7ul0lRwAtlmdrAPpSBIPVg/a3YXbxeiCC6AcVvpt78lu3qZ43vTvz2x
         wXN1tBL3aywecU3Xhgma1WVcsMYafKCK8nP2NBFgmy+DelVzKgpPCfdufpKIuc4euV9b
         X+rqTjycRIsA7OzbC2beKdrwR0ydLsmam0/To3Qud2WMxLmI974AIoCysaMQ4IEqTkB7
         xUXjUOn7+RrUemLhpCSeQAlXU8J3v6k7P1LyL4XCxVTbkoLvIXAS15DjaTRa4DXEjvJ6
         eAvaehgPhhYeoiQzGO5sJZjjaY/tbtY0oD7JcGaoLMey5HwHUJt0P/OUXpQ/ezGn3GeD
         26kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041435; x=1795646235;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGyTYvu/JftJxBMsp5VYPQ/HUeGWqv9z5FyQtv5WTl8=;
        b=BVc3gkIEP6/Qd0o33yhojsLYeFlvDPEuW39NAvkRhFWqKpMEC07v3kY7cNFOcJyvS4
         vXTIAk4V+h8iXA9U6qrq86jqwylCNDKvRj7NZnduyBmQKtyxPihDV3O5t/3wdUBQLAG9
         ReIUPWnPUzGf/48pxBWxUzlTVFDehtZ2FdUBV1QQmTG9j/IzzYp5EdxSm06Ew24Hv3i4
         YLsHn+II66lhnamLv0msZSOo5jWGviclZQkNPiJAXvo8HrvOVFeNOIEAQ22jzsYv1PHr
         OnmMxd0UzMSQ2xiOCVNKlGr+P82uYynx6PVg4l0pVAQHeHyvtu/TeUQY9WrnT3Ma3Iym
         rtmw==
X-Forwarded-Encrypted: i=1; AL+hErHWWMeW4BlOpMg2LREROPK9mrBAtq/qgx80NDiHPdpitHcijedgaKgRRY+fw81tTtXAQ0A34MOOtB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8StmRZVR1l65HZFgFgY9H9LsaXL/lMmZxY5sVS+b7Rr/ysELW2
	Y+2WtUfEq4XtP89cxLu6btazxAET5PaBHnMsfoAKggHrGQTY7xAbTf97C9SLPixoyjC6uidvwDa
	+PVwptb0vo9s6RQ==
X-Received: from oackp8.prod.google.com ([2002:a05:6871:9e08:b0:49e:2cc3:427])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:687c:2c4a:b0:4b9:685c:1942 with SMTP id 586e51a60fabf-4b9685c2eb5mr1963935fac.41.1795041434805;
 Wed, 18 Nov 2026 14:37:14 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:57 +0000
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
Message-ID: <20261118223704.3286085-7-dmatlack@google.com>
Subject: [PATCH v11 06/13] PCI: liveupdate: Preserve bus numbers during Live Update
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

Keep the secondary and subordinate bus numbers that the previous kernel
programmed into bridges, rather than assigning new ones, if the previous
kernel preserved any device across a Live Update. Do this even when
pcibios_assign_all_busses() is true, e.g. with pci=assign-busses.

Preserved devices must be allowed to continue performing memory
transactions across a Live Update, so the kernel cannot change the
fabric topology. Changing the bus numbers of a bridge changes the
Requester IDs of the devices below it, which would require disabling and
flushing any in-flight memory transactions first.

Apply the policy globally rather than only to the paths that contain
preserved devices. Bus numbers have to be preserved above a preserved
device anyway, since an upstream bridge cannot expand its window. A
global policy matches the scope of pcibios_assign_all_busses(), and
gives an answer that cannot change part way through the two passes of a
bridge scan.

Bridges that do not have bus numbers are still assigned new ones, so
hot-adding a bridge keeps working, both during and after a Live Update.
The two-pass bridge scan guarantees such bridges are only assigned bus
numbers above those already claimed by preserved bridges.

The exception is a bridge that was preserved but comes up without a
valid bus number configuration, e.g. because it was reset during kexec.
Refuse to assign it new bus numbers, since that would silently change
the BDF of every preserved device in its hierarchy. Also refuse to
assign bus numbers to the other bridges on the same bus, since the bus
numbers of the failed bridge can no longer be read from hardware and
handing them out would let an unrelated device inherit the BDF of a
preserved device.

Make PCI_LIVEUPDATE depend on !CARDBUS, since preserving bus numbers on
CardBus bridges is not implemented.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/liveupdate.c                      | 81 +++++++++++++++++++
 drivers/pci/liveupdate.h                      | 13 +++
 drivers/pci/probe.c                           | 11 ++-
 include/linux/pci_liveupdate.h                |  5 ++
 6 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..d1ef1c93ec96 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5129,7 +5129,11 @@ Kernel parameters
 				explicitly which ones they are.
 		assign-busses	[X86] Always assign all PCI bus
 				numbers ourselves, overriding
-				whatever the firmware may have done.
+				whatever the firmware may have done. Ignored
+				if the previous kernel preserved any PCI
+				device across a Live Update, since bus
+				numbers must not change while those devices
+				are doing DMA.
 		usepirqmask	[X86] Honor the possible IRQ mask stored
 				in the BIOS $PIR table. This is needed on
 				some systems with broken BIOSes, notably
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index c37e68a6591a..f043776910fb 100644
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
index ad2bb73e1d05..00d6fa5236e9 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -148,6 +148,32 @@
  * This lets the PCI core keep the bridges above preserved devices forwarding
  * their memory transactions, without changes in routing, throughout the Live
  * Update.
+ *
+ * BDF Stability
+ * =============
+ *
+ * The PCI core guarantees that preserved devices can be identified by the same
+ * bus, device, and function numbers for as long as they are preserved
+ * (including across kexec). To accomplish this, the PCI core keeps the
+ * secondary and subordinate bus numbers that the previous kernel programmed
+ * into bridges, if the previous kernel preserved any device. This is true even
+ * if the kernel would otherwise reassign all bus numbers, e.g. with
+ * pci=assign-busses. The PCI core trusts the bus numbers programmed by the
+ * previous kernel.
+ *
+ * Bridges that do not have bus numbers are assigned new ones as usual, so
+ * hot-adding a bridge keeps working, both during and after a Live Update. The
+ * two-pass bridge scan ensures such bridges are only assigned bus numbers above
+ * those already claimed by preserved bridges.
+ *
+ * If a preserved bridge comes up without a valid bus number configuration, e.g.
+ * because it was reset during kexec, the PCI core refuses to assign it new bus
+ * numbers and does not enumerate anything below it. Assigning new bus numbers
+ * would silently change the BDF of every preserved device in its hierarchy. The
+ * PCI core also stops assigning bus numbers to the other bridges on the same
+ * bus, since the bus numbers of the failed bridge can no longer be read from
+ * hardware and handing them to another bridge would let an unrelated device
+ * inherit the BDF of a preserved device.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -168,9 +194,13 @@
  * struct pci_liveupdate_global - Global state for PCI Live Update support
  * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
  *         FLBs, and the references to them in struct pci_dev.
+ * @had_incoming: True if the previous kernel preserved at least one PCI device.
+ *                Set when the incoming FLB is retrieved and never cleared, so
+ *                it stays true after Live Update finishes.
  */
 struct pci_liveupdate_global {
 	struct rw_semaphore rwsem;
+	bool had_incoming;
 };
 
 static struct pci_liveupdate_global pci_liveupdate = {
@@ -341,6 +371,9 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 			      ret);
 	}
 
+	if (!xa_empty(&incoming->xa))
+		pci_liveupdate.had_incoming = true;
+
 	args->obj = incoming;
 	return 0;
 }
@@ -629,6 +662,52 @@ static void pci_liveupdate_flb_put_incoming(void)
 	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
 }
 
+/**
+ * pci_liveupdate_preserve_bus_numbers() - Check whether to keep bus numbers
+ *
+ * Bus numbers are preserved on every bridge, for the lifetime of the kernel, if
+ * the previous kernel preserved any device. The incoming FLB is retrieved while
+ * setting up the first device, before any bridge is scanned, so the answer does
+ * not change during enumeration. See "BDF Stability" in the PCI Live Update
+ * documentation.
+ *
+ * Return: True if the PCI core should keep the bus numbers that the previous
+ * kernel programmed into bridges, false otherwise.
+ */
+bool pci_liveupdate_preserve_bus_numbers(void)
+{
+	return pci_liveupdate.had_incoming;
+}
+
+/**
+ * pci_liveupdate_refuse_bus_numbers() - Check for unsafe bus number assignment
+ * @bus: The PCI bus the bus numbers would be assigned from.
+ * @dev: The PCI bridge device the bus numbers would be assigned to.
+ *
+ * A bridge that was preserved by the previous kernel but came up without a
+ * valid bus number configuration has no child bus after the first pass of the
+ * bridge scan. Bus numbers must not be assigned from @bus while such a bridge
+ * is on it, including to the failed bridge itself. See "BDF Stability" in the
+ * PCI Live Update documentation.
+ *
+ * Return: True if @dev must not be assigned bus numbers, false otherwise.
+ */
+bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+
+	for_each_pci_bridge(bridge, bus) {
+		if (!bridge->liveupdate.was_incoming || bridge->subordinate)
+			continue;
+
+		pci_err(dev, "Not assigning bus numbers, preserved bridge %s lost its bus number configuration\n",
+			pci_name(bridge));
+		return true;
+	}
+
+	return false;
+}
+
 void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
 	struct pci_flb_incoming *incoming;
@@ -657,6 +736,8 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
 
 	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
 	dev->liveupdate.incoming = dev_ser;
+	dev->liveupdate.was_incoming = true;
+
 	pci_liveupdate_flb_put_incoming();
 }
 
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index eaaa3559fd77..e5d2a19d2ca2 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -13,6 +13,8 @@
 #ifdef CONFIG_PCI_LIVEUPDATE
 void pci_liveupdate_setup_device(struct pci_dev *dev);
 void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+bool pci_liveupdate_preserve_bus_numbers(void);
+bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -21,6 +23,17 @@ static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 {
 }
+
+static inline bool pci_liveupdate_preserve_bus_numbers(void)
+{
+	return false;
+}
+
+static inline bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus,
+						     struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a70a6d2b6da5..222ad696a158 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1400,6 +1400,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool preserve_bus_numbers = !pcibios_assign_all_busses() ||
+				    pci_liveupdate_preserve_bus_numbers();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1452,8 +1454,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && preserve_bus_numbers && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1495,8 +1496,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (!preserve_bus_numbers || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1510,6 +1510,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (pci_liveupdate_refuse_bus_numbers(bus, dev))
+			goto out;
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 710026ada2d5..d45a5b524909 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,10 +17,15 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @outgoing: State preserved for the next kernel.
  * @incoming: State preserved by the previous kernel.
+ * @was_incoming: True if this struct pci_dev was incoming-preserved when it was
+ *                set up, i.e. it was matched to state preserved by the previous
+ *                kernel. Unlike @incoming, this is never cleared, so it stays
+ *                true after the device finishes participating in Live Update.
  */
 struct pci_liveupdate {
 	struct pci_dev_ser *outgoing;
 	struct pci_dev_ser *incoming;
+	bool was_incoming;
 };
 
 struct pci_dev;
-- 
2.56.1.703.gf848ed807c-goog

