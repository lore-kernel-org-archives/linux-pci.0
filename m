Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D452485508
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398948; cv=none; b=NxQsvSTO4WLj7JIIomDaZMZSduVN0A3Rlv47Uiq1NcaLyCL3tk805V+rb2D9BTDJ0v0aWyp4qrNrzD4YBmJqcd/BCv2fuUhQEBjw5EsOFCJkm4qe6KhUaG+1+CGd8DTFtLfwlTYRg0wAKQx9gVamsIZ1fU919BuGELbHOa/KXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398948; c=relaxed/simple;
	bh=S4/H+vROa9vsiZJciWIYw81zArovCOBim6pplgl9abk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+N7k6sSiTutHw50SaE41ol5I6SKTqzNIUE6WcYvSeua1BX49a15jPnJzlzgDxhKDLf2EYywD6fb7bogQc1J6+8nid8Jb5vOa+EmMvnmvB6pgnEeyx0amxssTSWbla1N7USTwedyk654MD0YVEJCpaPqaCBOA7ugMzfzW2ppbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VS3qIcYW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VS3qIcYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792398947; x=1823934947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S4/H+vROa9vsiZJciWIYw81zArovCOBim6pplgl9abk=;
  b=VS3qIcYWIubCZ66n2p31utvr01vkA3611qNhzHEJdGcTpAWofAcm5s/I
   b9oUUqJKStl5xWdooSSIDRm6J+JUIYnlLRRdrQTUDGCPyhpNTwS2HaSQJ
   Hj6y33slrfgk5D/SQAFvBlMqE9/97PQqC7OBFF/lqHOdqt/9R5SQte2io
   WyqUeLhx+ihmNTX3XSPk94LQbUZwjXGSDMrBbPew9+hLbqs3E3I56dVH6
   PHMMBtXaKOOkZg/uwfnhx1Q8Ngq1QHmDKdtLF14QjAafJSVILc/r2tjor
   c+jDSKa19uyibjSOl3TsWP6UWoJj9Skqsbloyj6wn9I8tg6oGjEr5/MIi
   Q==;
X-CSE-ConnectionGUID: R8mDvBb5QS6QaQEetrvnKw==
X-CSE-MsgGUID: e/IzohKnT+ipl92a2Q+mWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1061728"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1061728"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:46 -0700
X-CSE-ConnectionGUID: GnDQy50DSlKnPPqI/ks8Sg==
X-CSE-MsgGUID: 3QCaWn8HT2Cj+p4gcTd8sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2857772"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:35:44 -0700
From: Lukasz Laguna <lukasz.laguna@intel.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: michal.winiarski@intel.com,
	djbw@kernel.org,
	brett.creeley@amd.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Subject: [PATCH v1 04/13] PCI/IOV: Allow VF drivers to handle resets
Date: Mon, 19 Oct 2026 10:35:05 +0200
Message-ID: <20261019083514.838640-5-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019083514.838640-1-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Winiarski <michal.winiarski@intel.com>

While the kernel representation of VF device (think struct device) is
preserved across PF FLR, and the PF IOV state (among other PCI CFG
state) is saved and restored across reset, the actual VF state is lost,
as from PCI perspective, VF didn't exist in the time between PF FLR and
PF IOV state restore.

Save / restore all subordinate VFs config state, and notify their
drivers using .reset_prepare() / .reset_done() to make sure that both
architected and unarchitected state can be preserved across FLR.

VFs are disabled only after the PF driver's .reset_prepare() and their
state is restored before PF driver's .reset_done(), so they can still
communicate with the PF while it handles the reset.

This also fixes VFs handling during bus and slot reset. Previously, VFs
were managed independently, so reset preparation for VFs was triggered
while walking the bus devices. Since that walk is top-down, the
.reset_prepare() was triggered on PF before it was triggered on the VFs.

As part of this, pci_reset_function_locked() now requires PF callers to
hold the device locks for all enabled VFs as well.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Co-developed-by: Lukasz Laguna <lukasz.laguna@intel.com>
Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/pci/pci.c | 105 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f1669f88e768..90468e38dc5a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5150,17 +5150,48 @@ void pci_dev_unlock_vfs(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock_vfs);
 
-static void pci_dev_save_and_disable(struct pci_dev *dev)
+static int pci_dev_trylock_vfs(struct pci_dev *dev)
+{
+	struct pci_dev *vf;
+
+	device_lock_assert(&dev->dev);
+
+	for_each_pci_vf(dev, vf) {
+		if (!pci_dev_trylock(vf))
+			goto unlock;
+	}
+
+	return 1;
+
+unlock:
+	for_each_pci_vf_continue_reverse(dev, vf)
+		pci_dev_unlock(vf);
+
+	return 0;
+}
+
+static void pci_dev_vfs_lock_assert(struct pci_dev *dev)
+{
+	struct pci_dev *vf;
+
+	device_lock_assert(&dev->dev);
+
+	for_each_pci_vf(dev, vf)
+		device_lock_assert(&vf->dev);
+}
+
+static void pci_dev_reset_prepare_and_save(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
 
+	device_lock_assert(&dev->dev);
+
 	/*
 	 * dev->driver->err_handler->reset_prepare() is protected against
 	 * races with ->remove() by the device lock, which must be held by
 	 * the caller.
 	 */
-	device_lock_assert(&dev->dev);
 	if (err_handler && err_handler->reset_prepare)
 		err_handler->reset_prepare(dev);
 	else if (dev->driver)
@@ -5177,6 +5208,17 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 		return;
 
 	pci_save_state(dev);
+}
+
+static void pci_dev_save_and_disable(struct pci_dev *dev)
+{
+	struct pci_dev *vf;
+
+	for_each_pci_vf(dev, vf)
+		pci_dev_reset_prepare_and_save(vf);
+
+	pci_dev_reset_prepare_and_save(dev);
+
 	/*
 	 * Disable the device by clearing the Command register, except for
 	 * INTx-disable which is set.  This not only disables MMIO and I/O port
@@ -5184,15 +5226,18 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 * DMA from the device including MSI/MSI-X interrupts.  For PCI 2.3
 	 * compliant devices, INTx-disable prevents legacy interrupts.
 	 */
+	for_each_pci_vf(dev, vf)
+		pci_write_config_word(vf, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
 }
 
-static void pci_dev_restore(struct pci_dev *dev)
+static void pci_dev_reset_done(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
 
-	pci_restore_state(dev);
+	device_lock_assert(&dev->dev);
 
 	/*
 	 * dev->driver->err_handler->reset_done() is protected against
@@ -5205,6 +5250,23 @@ static void pci_dev_restore(struct pci_dev *dev)
 		pci_warn(dev, "reset done");
 }
 
+static void pci_dev_restore(struct pci_dev *dev)
+{
+	struct pci_dev *vf;
+
+	device_lock_assert(&dev->dev);
+
+	pci_restore_state(dev);
+
+	for_each_pci_vf(dev, vf)
+		pci_restore_state(vf);
+
+	pci_dev_reset_done(dev);
+
+	for_each_pci_vf(dev, vf)
+		pci_dev_reset_done(vf);
+}
+
 /* dev->reset_methods[] is a 0-terminated list of indices into this array */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
@@ -5320,6 +5382,10 @@ void pci_init_reset_methods(struct pci_dev *dev)
  * from __pci_reset_function_locked() in that it saves and restores device state
  * over the reset and takes the PCI device lock.
  *
+ * If @dev is a PF with VFs enabled, the VFs are locked as well, their drivers
+ * are notified via reset_prepare() and reset_done(), and their state is saved
+ * and restored over the reset.
+ *
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
@@ -5340,11 +5406,13 @@ int pci_reset_function(struct pci_dev *dev)
 		pci_dev_lock(bridge);
 
 	pci_dev_lock(dev);
+	pci_dev_lock_vfs(dev);
 	pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev);
 
 	pci_dev_restore(dev);
+	pci_dev_unlock_vfs(dev);
 	pci_dev_unlock(dev);
 
 	if (bridge)
@@ -5368,7 +5436,11 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
  * over the reset.  It also differs from pci_reset_function() in that it
  * requires the PCI device lock to be held.
  *
- * Context: The caller must hold the device lock.
+ * If @dev is a PF with VFs enabled, VFs drivers are notified via
+ * reset_prepare() and reset_done(), and their state is saved and restored over
+ * the reset.
+ *
+ * Context: The caller must hold the device lock of @dev and of all its VFs.
  *
  * Return: 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
@@ -5378,6 +5450,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 	int rc;
 
 	device_lock_assert(&dev->dev);
+	pci_dev_vfs_lock_assert(dev);
 
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
@@ -5396,7 +5469,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
  * pci_try_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
  *
- * Same as above, except return -EAGAIN if unable to lock device.
+ * Same as above, except return -EAGAIN if unable to lock device or its VFs.
  */
 int pci_try_reset_function(struct pci_dev *dev)
 {
@@ -5408,9 +5481,16 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (!pci_dev_trylock(dev))
 		return -EAGAIN;
 
+	if (!pci_dev_trylock_vfs(dev)) {
+		rc = -EAGAIN;
+		goto pf_unlock;
+	}
+
 	pci_dev_save_and_disable(dev);
 	rc = __pci_reset_function_locked(dev);
 	pci_dev_restore(dev);
+	pci_dev_unlock_vfs(dev);
+pf_unlock:
 	pci_dev_unlock(dev);
 
 	return rc;
@@ -5564,6 +5644,11 @@ static int pci_slot_trylock(struct pci_slot *slot)
 	return __pci_bus_trylock(slot->bus, slot);
 }
 
+static bool pci_dev_skip_bus_reset(struct pci_dev *dev)
+{
+	return dev->is_virtfn; /* VFs are managed by their PF */
+}
+
 /*
  * Save and disable devices from the top of the tree down while holding
  * the @dev mutex lock for the entire tree.
@@ -5573,6 +5658,8 @@ static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (pci_dev_skip_bus_reset(dev))
+			continue;
 		pci_dev_save_and_disable(dev);
 		if (dev->subordinate)
 			pci_bus_save_and_disable_locked(dev->subordinate);
@@ -5589,6 +5676,8 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (pci_dev_skip_bus_reset(dev))
+			continue;
 		pci_dev_restore(dev);
 		if (dev->subordinate) {
 			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
@@ -5608,6 +5697,8 @@ static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
+		if (pci_dev_skip_bus_reset(dev))
+			continue;
 		pci_dev_save_and_disable(dev);
 		if (dev->subordinate)
 			pci_bus_save_and_disable_locked(dev->subordinate);
@@ -5626,6 +5717,8 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
+		if (pci_dev_skip_bus_reset(dev))
+			continue;
 		pci_dev_restore(dev);
 		if (dev->subordinate) {
 			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
-- 
2.43.0

