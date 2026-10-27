Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117120;
	b=4CbAtsgX+O0WjlNGz1hbDJE9AK8z3ViDYD/9eFDhq2bzrJ90HEWEHtx8Kg4EmANaS+/s
	 NZu0quBtq2jSHt6cIaKVvbWQjeOUqMCkYp6MJufoUWcn4q9LOAH0qGtVt3dcjnl2xVodh
	 WqJTs+UxfAa/Tmj4hhF9fmAmCiD4DkPPR+2P9vcFEJ/potTWGlQzTS1zOIatWd1k/A003
	 u1sm0tHhhTRX8u4+QVqVIVZbSE4T5Be7G0jQHQPIn0I4xqL3CMAOV1gxbWG0PrEethTW6
	 3jgHALDd564rAg2k6hMNv0fDuXypMM6vZ89Sex6cwbOhOIu0p8y3WrmFJokvLbgxGCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117120;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=NxmjSRxPmqESw2yYglvEGyLzQGl9r/SqOB1pzBZHcgc=;
	b=u1ciEXTBwKJjCIDhsrNbUjGRHfJ5nH4XbpZPTJ5cO7aQ45Cid5r+r9S+R0V1RoPzq44b
	 6aNzWaebe8XKwhg97ENMA5X0kkQ90ssBG/2DRFDQwu2WcICvWX753w11nLI9REWfPBQRX
	 xMT2Lo0LEXOWFHmHeOrgQ6jEonaWHk9A74v1BnyRiytydEuFg3zQfb21QPM/Cyv4138/s
	 eKq2YMcUarIY3SbXgcPnzRSK5J68VPmpDCJvPQKihIxnWFaSy+Jh/TnXv6mocQnJ73JP0
	 C92c2ro3pmNRrGeOyQvlgVR8jun9gzJuVLdcXaG/xGDWDcV1vL8LEjIgx4is/K8kc/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EqzY5Qrw;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE660A2630
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29EE660A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EqzY5Qrw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117120; x=1824653120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NGYOfzJX27QkBrVxUPTnWKEW1uJ3JIJCb0jFM1Re0oY=;
  b=EqzY5Qrw8W8Wb0hbKRJLcP+SXFm11MxCNi5K6FyTDeohMjvYX4/Vv2kb
   YBVntZl6iIA65uOH8CzOTrBv3+gwClMBawSblDYe00aMmR5dJ33Q7/gyU
   7V8bm0NThWVjg+7up+G3tLVY59tFsRK2800Kn9OWHjasG53MoOStzrxIF
   W63qnz+ZdDrsF6LOXa5n3wfo48oXbw02uVaTjQizysfuzwSxqm/dmJxbf
   UMnOHCXn18yhsnbN8Gx9cuWf+aPTNufdFhrz90O7gAytlLOq2FSnJfFlE
   Q0GT93iZDfOppi95UmmQimDf/DpANRYD6ASdcZ4h7wStvc9u70If8XMgp
   A==;
X-CSE-ConnectionGUID: /S0PlBEFQemzWjVk36Kv6Q==
X-CSE-MsgGUID: d6gFFAl+Rlm+1XzNAbSVSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1852218"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1852218"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:19 -0700
X-CSE-ConnectionGUID: wC600k4OSQKa8xyan3ZFlQ==
X-CSE-MsgGUID: SL25+MDNT+WhUVxFuLbWCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5111846"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:05:17 -0700
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
Subject: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
Date: Tue, 27 Oct 2026 17:04:37 +0100
Message-ID: <20261027160446.858300-5-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027160446.858300-1-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
were handled like any other device found while walking bus->devices.
Since that walk is top-down, the .reset_prepare() was triggered on PF
before it was triggered on the VFs. Moreover, the walk recurses only
through dev->subordinate, so it never reaches VFs on an SR-IOV virtual
bus, as such a bus has no bridge. Those VFs were reset without being
locked, without driver notification and without config space
save/restore. Now, the bus walk skips VFs and they are locked, saved
and restored together with their PF.

As part of this, pci_reset_function_locked() now requires PF callers to
hold the device locks for all enabled VFs as well.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Co-developed-by: Lukasz Laguna <lukasz.laguna@intel.com>
Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
v2:
 - lock VFs through their PF during bus and slot reset (Sashiko),
 - handle a VF in the reset slot if its PF is outside of the slot.
---
 drivers/pci/pci.c | 176 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 148 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e524cee77457..d0b25b8979ea 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5170,17 +5170,48 @@ void pci_dev_unlock_vfs(struct pci_dev *dev)
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
@@ -5197,6 +5228,17 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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
@@ -5204,15 +5246,18 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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
@@ -5225,6 +5270,23 @@ static void pci_dev_restore(struct pci_dev *dev)
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
@@ -5340,6 +5402,10 @@ void pci_init_reset_methods(struct pci_dev *dev)
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
@@ -5360,11 +5426,13 @@ int pci_reset_function(struct pci_dev *dev)
 		pci_dev_lock(bridge);
 
 	pci_dev_lock(dev);
+	pci_dev_lock_vfs(dev);
 	pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev);
 
 	pci_dev_restore(dev);
+	pci_dev_unlock_vfs(dev);
 	pci_dev_unlock(dev);
 
 	if (bridge)
@@ -5388,7 +5456,11 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
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
@@ -5398,6 +5470,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 	int rc;
 
 	device_lock_assert(&dev->dev);
+	pci_dev_vfs_lock_assert(dev);
 
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
@@ -5416,7 +5489,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
  * pci_try_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
  *
- * Same as above, except return -EAGAIN if unable to lock device.
+ * Same as above, except return -EAGAIN if unable to lock device or its VFs.
  */
 int pci_try_reset_function(struct pci_dev *dev)
 {
@@ -5428,9 +5501,16 @@ int pci_try_reset_function(struct pci_dev *dev)
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
@@ -5459,6 +5539,54 @@ static void pci_bus_lock(struct pci_bus *bus);
 static void pci_bus_unlock(struct pci_bus *bus);
 static int pci_bus_trylock(struct pci_bus *bus);
 
+static bool pci_bus_skip_dev(struct pci_dev *dev, struct pci_slot *slot)
+{
+	if (slot && dev->slot != slot)
+		return true;
+
+	/*
+	 * VFs are handled through their PF, unless the PF is outside the
+	 * @slot (e.g. per-function slots).
+	 */
+	return dev->is_virtfn && (!slot || pci_physfn(dev)->slot == slot);
+}
+
+static void pci_dev_lock_tree(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		pci_bus_lock(dev->subordinate);
+	} else {
+		pci_dev_lock(dev);
+		pci_dev_lock_vfs(dev);
+	}
+}
+
+static void pci_dev_unlock_tree(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		pci_bus_unlock(dev->subordinate);
+	} else {
+		pci_dev_unlock_vfs(dev);
+		pci_dev_unlock(dev);
+	}
+}
+
+static int pci_dev_trylock_tree(struct pci_dev *dev)
+{
+	if (dev->subordinate)
+		return pci_bus_trylock(dev->subordinate);
+
+	if (!pci_dev_trylock(dev))
+		return 0;
+
+	if (!pci_dev_trylock_vfs(dev)) {
+		pci_dev_unlock(dev);
+		return 0;
+	}
+
+	return 1;
+}
+
 /* Lock devices from the top of the tree down */
 static void __pci_bus_lock(struct pci_bus *bus, struct pci_slot *slot)
 {
@@ -5468,12 +5596,9 @@ static void __pci_bus_lock(struct pci_bus *bus, struct pci_slot *slot)
 		pci_dev_lock(bridge);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (slot && (!dev->slot || dev->slot != slot))
+		if (pci_bus_skip_dev(dev, slot))
 			continue;
-		if (dev->subordinate)
-			pci_bus_lock(dev->subordinate);
-		else
-			pci_dev_lock(dev);
+		pci_dev_lock_tree(dev);
 	}
 }
 
@@ -5483,12 +5608,9 @@ static void __pci_bus_unlock(struct pci_bus *bus, struct pci_slot *slot)
 	struct pci_dev *dev, *bridge = bus->self;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (slot && (!dev->slot || dev->slot != slot))
+		if (pci_bus_skip_dev(dev, slot))
 			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
+		pci_dev_unlock_tree(dev);
 	}
 
 	if (bridge)
@@ -5504,24 +5626,18 @@ static int __pci_bus_trylock(struct pci_bus *bus, struct pci_slot *slot)
 		return 0;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (slot && (!dev->slot || dev->slot != slot))
+		if (pci_bus_skip_dev(dev, slot))
 			continue;
-		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate))
-				goto unlock;
-		} else if (!pci_dev_trylock(dev))
+		if (!pci_dev_trylock_tree(dev))
 			goto unlock;
 	}
 	return 1;
 
 unlock:
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
-		if (slot && (!dev->slot || dev->slot != slot))
+		if (pci_bus_skip_dev(dev, slot))
 			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
+		pci_dev_unlock_tree(dev);
 	}
 
 	if (bridge)
@@ -5593,6 +5709,8 @@ static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (pci_bus_skip_dev(dev, NULL))
+			continue;
 		pci_dev_save_and_disable(dev);
 		if (dev->subordinate)
 			pci_bus_save_and_disable_locked(dev->subordinate);
@@ -5609,6 +5727,8 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (pci_bus_skip_dev(dev, NULL))
+			continue;
 		pci_dev_restore(dev);
 		if (dev->subordinate) {
 			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
@@ -5626,7 +5746,7 @@ static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
+		if (pci_bus_skip_dev(dev, slot))
 			continue;
 		pci_dev_save_and_disable(dev);
 		if (dev->subordinate)
@@ -5644,7 +5764,7 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
+		if (pci_bus_skip_dev(dev, slot))
 			continue;
 		pci_dev_restore(dev);
 		if (dev->subordinate) {
-- 
2.43.0

