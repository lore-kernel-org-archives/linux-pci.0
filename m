Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25C3AE189;
	Wed,  4 Mar 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626911; cv=none; b=DclD9GO8mtw3o86eRKo90+LCJDkRIeZ3nzzPLlBc5LzHn3TBF2sqUaHiFDRNDpx5vQXDBdLgkASkrYZt0D3jUb5LKAbpSyzTKaTXxJYo4LchKa+86KbRn2cgCeA1XyOvzUYfZmIorAGu0DazOTq+pdEfOG/1ERf+dcx+mSTsA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626911; c=relaxed/simple;
	bh=VCgfFxUsK7AkkEJWYGENpudb7MX05VzUNGeLrQCz80I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f8XZlcMxh8sR/6VcNdKg28Jx2BiZj1ivkOWJ96YEr13zVvN1trio3+jlNnksqYrSkGxxcFWwpliEfDDQMn/xBUNCXXPSebXd9iurAI70nkNu1fLpTh/0JMK/adQk+CtZM2tRNzLu/tRemVOH98hGrt4WfqaxcQJRtTuDMUdfoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNwNd4fO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNwNd4fO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772626910; x=1804162910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCgfFxUsK7AkkEJWYGENpudb7MX05VzUNGeLrQCz80I=;
  b=YNwNd4fOF0YPTwUjTYgs/kL8gcbfkbpp2vS10GM9UQ65oOzwF8R66fQp
   V03yCrthiP/XBUwKsBXSIzcRZWLU/ySCGgyqtINbsDGs2vJMY9BMnjv+8
   KSrtYRWXLoiYSShwZPEWuuHHi58z1lY/5p6vZ2PhbdId1ofr8ifXpJ2v+
   Vo1JAbapJkOFipPbJn7S/0F56e0TpA69ZFCHQwz80oppDkumXva4DOjU+
   cHwRuCwInOmrCV4j1N6BCXqwUz5iV0ZajYiBqKpr1riCgFUutGOOTZp8g
   AGkIodhv3RG69Adrn2bIyEHxTS8I7Of4UDFREB8GVP6af/k5T0cl6N2MD
   A==;
X-CSE-ConnectionGUID: NqUt2FU0Q/29kpyqQk/3nw==
X-CSE-MsgGUID: HrEgMV/ET4SSKxbG4l+stQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73559019"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73559019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 04:21:49 -0800
X-CSE-ConnectionGUID: 2kT8oMB+Q7ifyJcY0XTHJw==
X-CSE-MsgGUID: i2N6ZurZRheyYN4Z+fL2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="217483678"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 04:21:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>,
	Keith Busch <kbusch@kernel.org>,
	"Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] PCI: Consolidate pci_bus/slot_lock/unlock/trylock()
Date: Wed,  4 Mar 2026 14:21:38 +0200
Message-Id: <20260304122139.1479-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_bus/slot_lock/unlock/trylock() largely duplicate the bus iteration
loop with variation only due to slot filter handling. The only
differences in the loops is where the struct bus is found (directly in
the argument vs in slot->bus) and whether slot filter is applied. Those
difference are simple to handle using function parameters.

Consolidate the bus iteration loop to one place by creating
__pci_bus_{lock,unlock,trylock}() and call them from the non-underscore
locking functions.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Rebased
- Fixed rollback path dereferencing slot->bus (changed to use the bus
  parameter directly as slot can be NULL)

 drivers/pci/pci.c | 115 ++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 66 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..c248224e0861 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5292,13 +5292,21 @@ static bool pci_bus_resettable(struct pci_bus *bus)
 	return true;
 }
 
+static void pci_bus_lock(struct pci_bus *bus);
+static void pci_bus_unlock(struct pci_bus *bus);
+static int pci_bus_trylock(struct pci_bus *bus);
+
 /* Lock devices from the top of the tree down */
-static void pci_bus_lock(struct pci_bus *bus)
+static void __pci_bus_lock(struct pci_bus *bus, struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = bus->self;
+
+	if (bridge)
+		pci_dev_lock(bridge);
 
-	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
 		else
@@ -5307,28 +5315,34 @@ static void pci_bus_lock(struct pci_bus *bus)
 }
 
 /* Unlock devices from the bottom of the tree up */
-static void pci_bus_unlock(struct pci_bus *bus)
+static void __pci_bus_unlock(struct pci_bus *bus, struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = bus->self;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
 		else
 			pci_dev_unlock(dev);
 	}
-	pci_dev_unlock(bus->self);
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 }
 
 /* Return 1 on successful lock, 0 on contention */
-static int pci_bus_trylock(struct pci_bus *bus)
+static int __pci_bus_trylock(struct pci_bus *bus, struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = bus->self;
 
-	if (!pci_dev_trylock(bus->self))
+	if (bridge && !pci_dev_trylock(bridge))
 		return 0;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
@@ -5339,15 +5353,37 @@ static int pci_bus_trylock(struct pci_bus *bus)
 
 unlock:
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
 		else
 			pci_dev_unlock(dev);
 	}
-	pci_dev_unlock(bus->self);
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 	return 0;
 }
 
+/* Lock devices from the top of the tree down */
+static void pci_bus_lock(struct pci_bus *bus)
+{
+	__pci_bus_lock(bus, NULL);
+}
+
+/* Unlock devices from the bottom of the tree up */
+static void pci_bus_unlock(struct pci_bus *bus)
+{
+	__pci_bus_unlock(bus, NULL);
+}
+
+/* Return 1 on successful lock, 0 on contention */
+static int pci_bus_trylock(struct pci_bus *bus)
+{
+	return __pci_bus_trylock(bus, NULL);
+}
+
 /* Do any devices on or below this slot prevent a bus reset? */
 static bool pci_slot_resettable(struct pci_slot *slot)
 {
@@ -5370,72 +5406,19 @@ static bool pci_slot_resettable(struct pci_slot *slot)
 /* Lock devices from the top of the tree down */
 static void pci_slot_lock(struct pci_slot *slot)
 {
-	struct pci_dev *dev, *bridge = slot->bus->self;
-
-	if (bridge)
-		pci_dev_lock(bridge);
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_lock(dev->subordinate);
-		else
-			pci_dev_lock(dev);
-	}
+	__pci_bus_lock(slot->bus, slot);
 }
 
 /* Unlock devices from the bottom of the tree up */
 static void pci_slot_unlock(struct pci_slot *slot)
 {
-	struct pci_dev *dev, *bridge = slot->bus->self;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-
-	if (bridge)
-		pci_dev_unlock(bridge);
+	__pci_bus_unlock(slot->bus, slot);
 }
 
 /* Return 1 on successful lock, 0 on contention */
 static int pci_slot_trylock(struct pci_slot *slot)
 {
-	struct pci_dev *dev, *bridge = slot->bus->self;
-
-	if (bridge && !pci_dev_trylock(bridge))
-		return 0;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate))
-				goto unlock;
-		} else if (!pci_dev_trylock(dev))
-			goto unlock;
-	}
-	return 1;
-
-unlock:
-	list_for_each_entry_continue_reverse(dev,
-					     &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-
-	if (bridge)
-		pci_dev_unlock(bridge);
-	return 0;
+	return __pci_bus_trylock(slot->bus, slot);
 }
 
 /*

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.39.5

