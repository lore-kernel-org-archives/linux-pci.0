Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFA19ABC6
	for <linux-pci@vger.kernel.org>; Sat,  6 Jun 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777826; cv=none; b=JW/wjJJz/nXJIk3LXUma+L9TcO7unt1H5k9FOfX8abdk/jmHRRoQWuJjJuLdAFqCsYF5fEE/vX1BoHIJgh/3Te9H8xvcpeRk0/vtDFdSWofSoyfGbp4l+dDiFyywIH5nwPT23dCWP1PLkhx+y4SNpG1EuGd5z/lYbioMTBmeB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777826; c=relaxed/simple;
	bh=u92jV22VLV9ouxlAl/HRwRNCHL8oMyyYXZ5pNiAPpp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9AlQqcgJ9taXZCllKNLqj5az9mh/20hMHEMpqXJVpHq4s0ARpM1m0nCT7jbFo4WrDCgLNRnrTLMl3FuH0GwPJ4gNvrB/eqFBoeiNTwK2KuUoreRFGYhiZ4IqJsGT7avfhqMDyrxdEaUiR4TF+kOR9gdE7Rvz6s/C5+uqtRTz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+4BhKdz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+4BhKdz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965451F00893;
	Sat,  6 Jun 2026 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780777824;
	bh=3DswfjC9THg7ZJUw8BBegEJ+5ox8pNPQM4adaKK/11s=;
	h=From:To:Cc:Subject:Date;
	b=W+4BhKdz9hFvoa2kFzH4MDdiE2+qm8GA98f9jj/bPdaD+R7C24iaWt0DdxUsodPUf
	 R7L1QZKjRAA53WOS7ngRAGfXba9fF7Dw2nlNAY55y+yCcsgKkyzqyHVl0nQsq0xLb6
	 qZbz0VCh77AGaCj0eQID3gvBrKUFrPAHg73Bha3qvzNcDRJXqF8L9oMUxwAIKyAtmj
	 0lWUGZ59aT97/Meac7nZD1ArPh7r/BS7S7ffaWV7Q81aPl596RZNET7HI/NXkORipq
	 NDV35nCKvy6f8ygZrxo6z4wisqyARqkCPh9DbyvdXldc+m1eNEJe/RKXnsvTE2YMb1
	 kLcyVuLAXFCbw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Shuan He <heshuan@bytedance.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()
Date: Sat,  6 Jun 2026 20:30:22 +0000
Message-ID: <20260606203022.743558-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_proc_attach_device() creates procfs entries for PCI devices and is
called from pci_bus_add_device().  It lazily creates the per-bus procfs
directory (bus->procdir) via proc_mkdir() on first use, and returns
early if proc_initialized is not yet set.

On x86 with ACPI, PCI enumeration occurs at subsys_initcall, before
pci_proc_init() sets proc_initialized at device_initcall.  The
for_each_pci_dev() loop in pci_proc_init() then creates procfs entries
for these already-enumerated devices, but runs without holding
pci_rescan_remove_lock.

On ARM64 with devicetree, PCI host bridges probe at device_initcall.
With async probing enabled, pci_bus_add_device() can run concurrently
with pci_proc_init(), and both may call pci_proc_attach_device() for
the same device or for different devices on the same bus.  As
pci_host_probe() holds pci_rescan_remove_lock while pci_proc_init()
does not, there is no serialisation between the two paths.

When two threads concurrently call pci_proc_attach_device() for devices
on the same bus, both observe bus->procdir as NULL and both call
proc_mkdir().  The proc filesystem serialises directory creation
internally, so only one caller succeeds.  The other receives NULL
(duplicate entry) and unconditionally stores it to bus->procdir,
corrupting the valid pointer set by the first caller.

Thus, extract the bus procfs directory creation from
pci_proc_attach_device() into a new pci_proc_attach_bus() function,
and call it from the two bus creation paths: pci_register_host_bridge()
for root buses and pci_alloc_child_bus() for child buses.  These are
the only two callers of pci_alloc_bus(), so for buses created after
proc_initialized is set, bus->procdir is in place before any device
can be added to the bus.

Therefore, by the time pci_proc_attach_device() runs on these buses,
bus->procdir is already set and the racy proc_mkdir() call is never
reached.

For buses created before pci_proc_init() sets proc_initialized (the
common x86 ACPI case), the bus creation hooks return early.  As such,
add a fallback call to pci_proc_attach_bus() from pci_proc_attach_device()
to handle these pre-init buses.

Additionally, wrap the for_each_pci_dev() loop in pci_proc_init() with
pci_lock_rescan_remove() to serialise against concurrent PCI bus
operations, add an early return in pci_proc_attach_device() when
dev->procent is already set to make the function idempotent, and clear
bus->procdir in pci_proc_detach_bus() to prevent use of a dangling
pointer after proc_remove().

Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@bytedance.com/
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
Changes in v3:
  https://lore.kernel.org/linux-pci/20260606170146.673140-1-kwilczynski@kernel.org/

  - Used local variables in pci_proc_attach_bus() and pci_proc_attach_device()
    to ensure that bus->procdir and dev->procent are only assigned on success.
    If either the proc_mkdir() or proc_create_data() returns NULL, the struct
    field will not see a new assignment, preventing a valid pointer from being
    overwritten.  This was reported by Sashiko, see:
    https://sashiko.dev/#/patchset/20260606170146.673140-1-kwilczynski%40kernel.org?part=1
   
Changes in v2:
  https://lore.kernel.org/linux-pci/20260430003542.455198-1-kwilczynski@kernel.org/

  - Extracted bus->procdir creation into new pci_proc_attach_bus()
    function, addressing the suggestion to move proc_mkdir() to a bus
    creation path, as per Bjorn Helgaas' feedback.
  - Added bus->procdir = NULL in pci_proc_detach_bus() for symmetry
    and to prevent dangling pointer after proc_remove().
 drivers/pci/pci.h   |  6 ++--
 drivers/pci/probe.c |  6 ++++
 drivers/pci/proc.c  | 68 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..5e8520bb229c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -343,13 +343,15 @@ void pci_allocate_vc_save_buffers(struct pci_dev *dev);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
+int pci_proc_attach_bus(struct pci_bus *bus);
+int pci_proc_detach_bus(struct pci_bus *bus);
 int pci_proc_attach_device(struct pci_dev *dev);
 int pci_proc_detach_device(struct pci_dev *dev);
-int pci_proc_detach_bus(struct pci_bus *bus);
 #else
+static inline int pci_proc_attach_bus(struct pci_bus *bus) { return 0; }
+static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 static inline int pci_proc_attach_device(struct pci_dev *dev) { return 0; }
 static inline int pci_proc_detach_device(struct pci_dev *dev) { return 0; }
-static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 #endif
 
 /* Functions for PCI Hotplug drivers to use */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..90248813d2cf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1071,6 +1071,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(bus);
 
+	/* Create procfs directory for this bus */
+	pci_proc_attach_bus(bus);
+
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", name);
 	else
@@ -1279,6 +1282,9 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(child);
 
+	/* Create procfs directory for this bus */
+	pci_proc_attach_bus(child);
+
 	return child;
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ce36e35681e8..6e12f41cc8c8 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -416,34 +416,56 @@ static const struct seq_operations proc_bus_pci_devices_op = {
 
 static struct proc_dir_entry *proc_bus_pci_dir;
 
-int pci_proc_attach_device(struct pci_dev *dev)
+int pci_proc_attach_bus(struct pci_bus *bus)
 {
-	struct pci_bus *bus = dev->bus;
-	struct proc_dir_entry *e;
+	struct proc_dir_entry *dir;
 	char name[16];
 
 	if (!proc_initialized)
 		return -EACCES;
 
-	if (!bus->procdir) {
-		if (pci_proc_domain(bus)) {
-			sprintf(name, "%04x:%02x", pci_domain_nr(bus),
-					bus->number);
-		} else {
-			sprintf(name, "%02x", bus->number);
-		}
-		bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
-		if (!bus->procdir)
-			return -ENOMEM;
-	}
+	if (bus->procdir)
+		return 0;
+
+	if (pci_proc_domain(bus))
+		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+	else
+		sprintf(name, "%02x", bus->number);
+
+	dir = proc_mkdir(name, proc_bus_pci_dir);
+	if (!dir)
+		return -ENOMEM;
+
+	bus->procdir = dir;
+
+	return 0;
+}
+
+int pci_proc_attach_device(struct pci_dev *dev)
+{
+	struct proc_dir_entry *entry;
+	char name[16];
+	int ret;
+
+	if (!proc_initialized)
+		return -EACCES;
+
+	if (dev->procent)
+		return 0;
+
+	/* Ensure bus procdir exists for buses created before pci_proc_init() */
+	ret = pci_proc_attach_bus(dev->bus);
+	if (ret)
+		return ret;
 
 	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	e = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir,
-			     &proc_bus_pci_ops, dev);
-	if (!e)
+	entry = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
+				 dev->bus->procdir, &proc_bus_pci_ops, dev);
+	if (!entry)
 		return -ENOMEM;
-	proc_set_size(e, dev->cfg_size);
-	dev->procent = e;
+
+	dev->procent = entry;
+	proc_set_size(entry, dev->cfg_size);
 
 	return 0;
 }
@@ -458,18 +480,24 @@ int pci_proc_detach_device(struct pci_dev *dev)
 int pci_proc_detach_bus(struct pci_bus *bus)
 {
 	proc_remove(bus->procdir);
+	bus->procdir = NULL;
 	return 0;
 }
 
 static int __init pci_proc_init(void)
 {
 	struct pci_dev *dev = NULL;
+
 	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
 	proc_create_seq("devices", 0, proc_bus_pci_dir,
-		    &proc_bus_pci_devices_op);
+			&proc_bus_pci_devices_op);
+
 	proc_initialized = 1;
+
+	pci_lock_rescan_remove();
 	for_each_pci_dev(dev)
 		pci_proc_attach_device(dev);
+	pci_unlock_rescan_remove();
 
 	return 0;
 }
-- 
2.54.0

