Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680B301465
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190347; cv=none; b=EuDJElj5CJFnS05kouAiA7yNGdmNEdz8SwLjdbNozhEX+0Pi45sUsijlSc6GcByxC0sUGTSCrdXsM49L4A1bTz38+eaQTzqmqDCyHZDGvfyS1YudIlMwldxlcWYWMGVblIa0AdcZ4SOVkO5SaCok71UCXs51aDyw5ohWwLWLAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190347; c=relaxed/simple;
	bh=Gr0JFxrlKTfB9cvXhx2CdDuraA23j+057lVM0O829sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KavOs1/uYQzDJD9b2Yfqtx51UoPHmTUL64x8W3PsGw/jybqltMKYTg/I4xJ79W0ZRh9KYpFheR+0sUYlH9gOuEJY6zQ3pvo6FedTMRii/m8ROJ++TiJpFRzTm/+NuaFfeOX1NpFOc58vd2bLXHUwS5ArTO189/xbsx+QRkWb0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1fJP3Pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1fJP3Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174C81F00893;
	Thu, 11 Jun 2026 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190346;
	bh=go2KM4+v56cy5TQS7b7R5oJgxVehyt3qB64HKqNHqg0=;
	h=From:To:Cc:Subject:Date;
	b=Z1fJP3Pe+glgMNT4up7O0yMeTfvVhn0vYKri0YZDx9eRKnK3iQjv/rLeRvNQ+dh3r
	 XdqcL9uvN5ViN3dmHkTGNtQTMG2Y89GGm+DQmxjN7sdQTcVfoGEXw55CDtcxKpEgPe
	 JH7geEgVufZya5+qCio/Iu92+qajjyF/S+SZLQqI924QoRma1aTZ9ROCL5dF78+Hd6
	 AI2VVrRp4zG899a8QEVCdsZVFnI2gvzFmP0h3f9TBQw5s9nz2zn18Nk5IyjGp1gDeN
	 t47zBPe0SrRzNHWqUo+FvrlTrHoKZ92V2LRtCC3r3odD5aFJm9E2PSKM5myaQRR6DP
	 yAVpLM5UjNxrw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Shuan He <heshuan@bytedance.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4] PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()
Date: Thu, 11 Jun 2026 15:05:43 +0000
Message-ID: <20260611150543.511422-1-kwilczynski@kernel.org>
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

When two threads concurrently call pci_proc_attach_device() for
devices on the same bus, both observe bus->procdir as NULL and both
call proc_mkdir().  The proc filesystem serialises directory creation
internally, so only one caller succeeds.  The other receives NULL
(duplicate entry) and unconditionally stores it to bus->procdir,
corrupting the valid pointer set by the first caller.

Thus, serialise access to proc_initialized, proc_bus_pci_dir,
bus->procdir and dev->procent with a new mutex local to the
drivers/pci/proc.c file, and store the created entries to
bus->procdir and dev->procent only on success, so a failed
creation can never overwrite a valid pointer.

Additionally, wrap the for_each_pci_dev() loop in pci_proc_init() with
pci_lock_rescan_remove() to serialise against concurrent PCI bus
operations, add an early return in pci_proc_attach_device() when
dev->procent is already set to make the function idempotent, and clear
bus->procdir in pci_proc_detach_bus() to prevent use of a dangling
pointer after proc_remove().

Reported-by: Shuan He <heshuan@bytedance.com>
Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@bytedance.com/
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
Changes in v4:
  https://lore.kernel.org/linux-pci/20260606203022.743558-1-kwilczynski@kernel.org/
 
  - Dropped the pci_proc_attach_bus() calls from pci_register_host_bridge()
    and pci_alloc_child_bus(), returning to creating the per-bus procfs
    directory lazily on first device attach.  Creating the directory at
    bus creation time left directories behind for buses that never
    receive any devices, changing the visible contents of /proc/bus/pci.
  - Serialised pci_proc_attach_device(), pci_proc_detach_device() and
    pci_proc_detach_bus() with a new mutex local to drivers/pci/proc.c.
    The pci_rescan_remove_lock cannot serialise every caller, as for
    example pci_enable_sriov() reaches pci_bus_add_device() both with
    the lock held (a driver probed during boot enumeration) and without
    it (the same driver probed from a later modprobe), so the procfs
    attach path can neither take the lock itself nor expect all callers
    to hold it.
  - Set proc_initialized in pci_proc_init() with the new mutex held, so
    that a concurrent caller can no longer observe it set while
    proc_bus_pci_dir is not yet visible.
  - Added the missing Reported-by tag to credit Shuan He properly.

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
 drivers/pci/proc.c | 79 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ce36e35681e8..71ad289fcb8e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -18,6 +18,7 @@
 #include "pci.h"
 
 static int proc_initialized;	/* = 0 */
+static DEFINE_MUTEX(pci_proc_lock);
 
 static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
@@ -416,40 +417,64 @@ static const struct seq_operations proc_bus_pci_devices_op = {
 
 static struct proc_dir_entry *proc_bus_pci_dir;
 
-int pci_proc_attach_device(struct pci_dev *dev)
+static int __pci_proc_attach_bus(struct pci_bus *bus)
 {
-	struct pci_bus *bus = dev->bus;
-	struct proc_dir_entry *e;
+	struct proc_dir_entry *dir;
 	char name[16];
 
+	lockdep_assert_held(&pci_proc_lock);
+
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
+	struct pci_bus *bus = dev->bus;
+	struct proc_dir_entry *entry;
+	char name[16];
+	int ret;
+
+	guard(mutex)(&pci_proc_lock);
+
+	if (dev->procent)
+		return 0;
+
+	ret = __pci_proc_attach_bus(bus);
+	if (ret)
+		return ret;
 
 	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	e = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir,
-			     &proc_bus_pci_ops, dev);
-	if (!e)
+	entry = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
+				 bus->procdir, &proc_bus_pci_ops, dev);
+	if (!entry)
 		return -ENOMEM;
-	proc_set_size(e, dev->cfg_size);
-	dev->procent = e;
+
+	proc_set_size(entry, dev->cfg_size);
+	dev->procent = entry;
 
 	return 0;
 }
 
 int pci_proc_detach_device(struct pci_dev *dev)
 {
+	guard(mutex)(&pci_proc_lock);
 	proc_remove(dev->procent);
 	dev->procent = NULL;
 	return 0;
@@ -457,19 +482,27 @@ int pci_proc_detach_device(struct pci_dev *dev)
 
 int pci_proc_detach_bus(struct pci_bus *bus)
 {
+	guard(mutex)(&pci_proc_lock);
 	proc_remove(bus->procdir);
+	bus->procdir = NULL;
 	return 0;
 }
 
 static int __init pci_proc_init(void)
 {
 	struct pci_dev *dev = NULL;
-	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
-	proc_create_seq("devices", 0, proc_bus_pci_dir,
-		    &proc_bus_pci_devices_op);
-	proc_initialized = 1;
+
+	scoped_guard(mutex, &pci_proc_lock) {
+		proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
+		proc_create_seq("devices", 0, proc_bus_pci_dir,
+				&proc_bus_pci_devices_op);
+		proc_initialized = 1;
+	}
+
+	pci_lock_rescan_remove();
 	for_each_pci_dev(dev)
 		pci_proc_attach_device(dev);
+	pci_unlock_rescan_remove();
 
 	return 0;
 }
-- 
2.54.0

