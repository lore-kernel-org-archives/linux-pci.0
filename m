Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86553B95FF
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979416; cv=none; b=ioGDGpwNEu8kElxzp7RHKQ4b4Uod/r0sg+4vDhVmKvVXMru25Vm2CzrcnTojXs+XGurdyAwuZo0XBwmq3yqfjupyf1EAlGBwYh7Iym/jLTOn4N4Kuu/E3gjIkGwKggsm63OvmbwJoTOQw4h30YMOIhZtyTLfxQfJYvy6UZEzeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979416; c=relaxed/simple;
	bh=7EFFL8rzwwkNs2VFh7UxqjTSTsZEbT6FDog+Mkn6Mnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gOVF00QpTGSWwaAlXD7PzyYIS3EpiApTXvKDP46ulvxPL1sW76ecKpH4lRx+ecpR43xBTUg+2soKsNrxMU+pd5YEACN4iUEwFqqLdo5biEO8SWRYCgZkEQdjOWRC8QntSdrYjNl5c4B9qkrA2LhCOfekBtRE4kqcjWVYxcDS0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sq2TNcpG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sq2TNcpG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so4113160a12.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979409; x=1777584209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfzU9SNjvxnnqDKncwfyemtEYZFu8CMxXPZg5kqrMR0=;
        b=Sq2TNcpGCGiGCFgdGA72+Q/PWdzrkQ6vC1dD7Tv+NEMfhQdJW0cqAXNNBOkIdUp08/
         IucsfPwVoSFCb9VSQKxRz1+1G7zMFK0CLc1+fIOJnfyv9hfpU7eK4StvFM7HGQRiA3pB
         /z84SiYjOh0ejQaGspmV/wAuSGLJwpt6tJVE6Ztd0JmCFUjQGLt3wQPIQ0Al3dNRrou6
         DKRxCBQrn2xnNUkIvLWZmNUy3crfqRKIO/HyB8kh6nVf7zjq4mLbrWLZFjpziTUv/pof
         D2Pc5wQLOexIWr9ma1wcqINFSk2US7xqqye7kq+D0rWYNqsOhj5gnCK20Sk8duPAYAqT
         KARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979409; x=1777584209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfzU9SNjvxnnqDKncwfyemtEYZFu8CMxXPZg5kqrMR0=;
        b=mVnDsLBy/RglS+isgcDgyduG4AeTNFAPB71mtqHaVZWPdT2kjyuNIeEnyvlNc62qpr
         BnzEUI7qpDI/R7IuPVmFp8+kHEnLu/glQI6oGGNePzSrG4RG1PX5Yw2/xuDZWyNGadIa
         MDWw6niRg93g50hAODi8eqmnb9R682+SBYZNL9GXCGMiYOhmpWt0gx7A5OEfryLFZ9aL
         RpxgbOumdFeWzykdw2bN4bqVG+ktzWwXFer2dzXvZ5+0+926umr49ssZzGjm93kz9qdc
         8I2V3huhPX5/TNUuJ5gq1mCdvtdHs/js7WPtCmeB8kkRPPFfklmbVjgW8d7OvDiCxaNX
         gIFg==
X-Forwarded-Encrypted: i=1; AFNElJ/zs3UWQvdcSC37RfTYUVR7N5hKrWhc4f2FwmJa/JiNj/TWzW/tHQG5qcLrbiIfKlSRigfZ0q7AtWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6WS0+sahYqe8YOn5jVr1Nw8O8oQEjymydreXuiQnZFEYA+jj
	4JUy/aY0oEytATVgc+Ynox+8NnERPuS+7qGWn43x5fcXpNHpUSoS5//SdKH7Czj0xPmzoUYBY5t
	sp6UtaFPYhkcd9Q==
X-Received: from pgbcw1.prod.google.com ([2002:a05:6a02:4281:b0:c76:8acb:773d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d9c:b0:3a3:17f8:bedd with SMTP id adf61e73a8af0-3a317f8cbb2mr6879688637.17.1776979408708;
 Thu, 23 Apr 2026 14:23:28 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:09 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-6-dmatlack@google.com>
Subject: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during Live Update
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Inherit bus numbers from the previous kernel during a Live Update when
one or more PCI devices are being preserved.

During a Live Update, preserved devices must be allowed to continue
performing memory transactions so the kernel cannot change the fabric
topology, including bus numbers, since that would require disabling
and flushing any memory transactions first.

To keep things simple, inherit the secondary and subordinate bus numbers
on all bridges if any PCI devices were preserved (i.e. even bridges
without any downstream endpoints that were preserved). This avoids
accidentally assigning a bridge a new window that overlaps with a
preserved device that is downstream of a different bridge.

If a bridge is enumerated with a broken topology or has no bus numbers
set during a Live Update, refuse to assign it new bus numbers and refuse
to enumerate devices below it. This is a safety measure to prevent
topology conflicts.

Require that CONFIG_CARDBUS is not enabled to enable
CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
bridges requires additional work but is not a priority at the moment.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/liveupdate.c                      | 28 +++++++++++++++++++
 drivers/pci/probe.c                           | 21 +++++++++++---
 include/linux/pci.h                           |  1 +
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cf3807641d89..f412a4b77fb7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5156,7 +5156,11 @@ Kernel parameters
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
index 08398cbe970c..6ef457ff9d08 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support (EXPERIMENTAL)"
-	depends on PCI && LIVEUPDATE
+	depends on PCI && LIVEUPDATE && !CARDBUS
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index c0a30d16d9b8..cf8cff134a75 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -93,6 +93,19 @@
  * bound to the correct driver. i.e. The PCI core does not protect against a
  * device getting preserved by driver A in the outgoing kernel and then getting
  * bound to driver B in the incoming kernel.
+ *
+ * BDF Stability
+ * =============
+ *
+ * The PCI core guarantees that incoming preserved devices can be identified by
+ * the same bus, device, and function numbers as prior to kexec. To accomplish
+ * this, the PCI core always inherits the secondary and subordinate bus numbers
+ * assigned to bridges during enumeration, rather than assigning new ones (the
+ * PCI core assumes that the previous kernel established a sane topology).
+ *
+ * If a misconfigured or unconfigured bridge is encountered during enumeration
+ * while there are incoming preserved devices, it's secondary and subordinate
+ * bus numbers will be cleared and devices below it will not be enumerated.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -354,6 +367,21 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
 	if (!xa)
 		return;
 
+	/*
+	 * During a Live Update, preserved devices are allowed to continue
+	 * performing memory transactions. The kernel must not change the fabric
+	 * topology, including bus numbers, since that would require disabling
+	 * and flushing any memory transactions first.
+	 *
+	 * To keep things simple, inherit the secondary and subordinate bus
+	 * numbers on _all_ bridges if _any_ PCI devices were preserved (i.e.
+	 * even bridges without any downstream endpoints that were preserved).
+	 * This avoids accidentally assigning a bridge a new window that
+	 * overlaps with a preserved device that is downstream of a different
+	 * bridge.
+	 */
+	dev->liveupdate_inherit_buses = true;
+
 	key = pci_ser_xa_key(pci_domain_nr(dev->bus), pci_dev_id(dev));
 	dev_ser = xa_load(xa, key);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 938a28e4a7a0..fa26f4170add 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1374,6 +1374,14 @@ bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_should_assign_new_buses(struct pci_dev *dev)
+{
+	if (dev->liveupdate_inherit_buses)
+		return false;
+
+	return pcibios_assign_all_busses();
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1401,6 +1409,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	const bool assign_new_buses = pci_should_assign_new_buses(dev);
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1453,8 +1462,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_new_buses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1496,8 +1504,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_new_buses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
@@ -1511,6 +1518,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if (dev->liveupdate_inherit_buses) {
+			pci_err(dev, "Cannot reconfigure bridge during Live Update!\n");
+			pci_err(dev, "Downstream devices will not be enumerated!\n");
+			goto out;
+		}
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd6b26ca9462..9a602b322e3c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -511,6 +511,7 @@ struct pci_dev {
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
+	unsigned int	liveupdate_inherit_buses:1; /* Inherit bus numbers due to Live Update */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

