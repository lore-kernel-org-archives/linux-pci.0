Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F12354AC3
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792416; cv=none; b=n1kLg2wMrPynWKeoj1Lii5TbpzFk1+yM+JLYgy71Q1GnFQt+9pQSZUMW2rxy1D5IbOnKZFKPObgxeDHlf15OQkofb/yp8yr/PJxpII8Fvr4mbAnldmeS+4TYMHM4SGW+1EGL8iptt/fcJ8W8Hg5U+ogEMK3E+PbIiRLmoGlG1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792416; c=relaxed/simple;
	bh=IYFYGDB+TlXDbG3VhCUn1qruBqJ7wXnGi+na33dUGw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVsKdSYrTwSO4JqkSfTO2cBBwYwrJ4aPnMcHk4d9mkb8h0qCZMtM6W3xr1ODBGj6ekKtOic2YQtIt834J6+X2sg47YjWLAl7v9AENmS/DmpiX8KOLBhj+DjX7BrEtKJmseOUZ/RTFXqfvi3P/8xFWPwXs6zD4sK9HIKBswLYhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=l4cTU9vD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="l4cTU9vD"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60UD9hxQ3840522
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KPBZ+VNELC7oR8Y49mhFaiMxEL+qSKFDP3nGKaafsUs=; b=l4cTU9vDumyq
	2xTUqeAadC6BhPYzCEwkreylJBiP2YblTgVtcNnLQO2C7kWYsrLH1pLRfok4zvAo
	eVWJeq+3JDoe/HZ994qhm8db1Npfs1tZOsDaOzaVtae8tfoQivjE5im40pT2IU36
	dTHulHkFaU0VJwZr87yCSrz35Q2hCJ1KUZXGYVIP0R3M6HPxCmebzL6VKMj1pge8
	EBNeyU0KiOi9a7teGnkfTKuaeYYWjksrEpvdpInN2xAM2dnqIMXCYCDZq/U5/TXp
	LDl9RwC3fCEeKgO+dP0kRJwZOx1dW3YM+xZrF1eu05C3obxHpSCvAzHFYt+Bbk9u
	sYbP6xvIpg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c0w9ctd1e-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:13 -0800 (PST)
Received: from twshared18212.03.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 30 Jan 2026 17:00:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D0A8C6EAF1C7; Fri, 30 Jan 2026 09:00:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 3/4] pci: remove slot specific lock/unlock and save/restore
Date: Fri, 30 Jan 2026 08:59:52 -0800
Message-ID: <20260130165953.751063-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130165953.751063-1-kbusch@meta.com>
References: <20260130165953.751063-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nOOuVBiWOaxBcAvHSGojuwryLPZzHRMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX4b9Oh/FWOv1Z
 SRnbFzS1qWMSCOnI0bg4Kik6WG1rifSr9r/PzjungCC+lTDD9M/BU/LBV7R4H9XaGCzZi0mZdGx
 Ri3GJLWIJWKsYklFfOZLdeeo3frtTq1ICV779t8lwxVwu8a6GaKms2RvDiQPRkrYWk/Hb0+DCAG
 bCN0b8HLWDmHC+f5z9285tOggAIgnO8fa0aDmqiocZNCmsSUcJgqBkBaX97/NM394pQex6C6QgR
 GRVVEvzgJUrrRgsx2/hwEBf7o7mfgMqRzJVeQBBdX0xX7KW8lv414QF+rDmE/7mNdZCUE0I1B9i
 PJ27ykd9zGveP0NZwi6IgE7YjubA91piy1KpYTCb9zJxF367kX4SsgfP+GWF0Pasyi5YJekpwtF
 PSa5UBj4C4dgtubLJGi8CpUSqtGxR+QJRM/ZRAf/Lvb1Se89+AzUQ6xmq9Akd+ATox/4OIadKTL
 aYpzNc5BTJCcTjqpiLQ==
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=697ce39d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=R5VB0q6KzM-PVnaiiKsA:9
X-Proofpoint-GUID: nOOuVBiWOaxBcAvHSGojuwryLPZzHRMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
every function on every "D", not just the ones with a matching "slot".
The slot lock/unlock and save/restore functions, however, are only
handling a subset of the functions, breaking the rest.

ARI devices with more than 8 functions fail because their state is not
properly handled, nor is the attached driver notified of the reset. In
the best case, the device will appear unresponsive to the driver,
resulting in unexpected errors. A worse possibility may panic the kernel
if in flight transactions trigger hardware reported errors like this
real observation:

  vfio-pci 0000:01:00.0: resetting
  vfio-pci 0000:01:00.0: reset done
  {1}[Hardware Error]:  Error 1, type: fatal
  {1}[Hardware Error]:   section_type: PCIe error
  {1}[Hardware Error]:   port_type: 0, PCIe end point
  {1}[Hardware Error]:   version: 0.2
  {1}[Hardware Error]:   command: 0x0140, status: 0x0010
  {1}[Hardware Error]:   device_id: 0000:01:01.0
  {1}[Hardware Error]:   slot: 0
  {1}[Hardware Error]:   secondary_bus: 0x00
  {1}[Hardware Error]:   vendor_id: 0x1d9b, device_id: 0x0207
  {1}[Hardware Error]:   class_code: 020000
  {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x000=
0
  {1}[Hardware Error]:   aer_cor_status: 0x00008000, aer_cor_mask: 0x0000=
2000
  {1}[Hardware Error]:   aer_uncor_status: 0x00010000, aer_uncor_mask: 0x=
00100000
  {1}[Hardware Error]:   aer_uncor_severity: 0x006f6030
  {1}[Hardware Error]:   TLP Header: 0a412800 00192080 60000004 00000004
  GHES: Fatal hardware error but panic disabled
  Kernel panic - not syncing: GHES: Fatal hardware error

Fix this by properly locking and notifying the entire affected bus
topology, not just specific matching slots. For architectures that
support "slot" specific resets, this patch potentially introduces an
insignificant amount of overhead, but is otherwise harmless.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 152 ++++------------------------------------------
 1 file changed, 13 insertions(+), 139 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 57a5b205175f1..36427fbf7a747 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5218,7 +5218,6 @@ static bool pci_bus_resettable(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
=20
-
 	if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
 		return false;
=20
@@ -5287,96 +5286,6 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	return 0;
 }
=20
-/* Do any devices on or below this slot prevent a bus reset? */
-static bool pci_slot_resettable(struct pci_slot *slot)
-{
-	struct pci_dev *dev, *bridge =3D slot->bus->self;
-
-	if (bridge && (bridge->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
-		return false;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
-			continue;
-		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
-		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
-			return false;
-	}
-
-	return true;
-}
-
-/* Lock devices from the top of the tree down */
-static void pci_slot_lock(struct pci_slot *slot)
-{
-	struct pci_dev *dev, *bridge =3D slot->bus->self;
-
-	if (bridge)
-		pci_dev_lock(bridge);
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_lock(dev->subordinate);
-		else
-			pci_dev_lock(dev);
-	}
-}
-
-/* Unlock devices from the bottom of the tree up */
-static void pci_slot_unlock(struct pci_slot *slot)
-{
-	struct pci_dev *dev, *bridge =3D slot->bus->self;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-
-	if (bridge)
-		pci_dev_unlock(bridge);
-}
-
-/* Return 1 on successful lock, 0 on contention */
-static int pci_slot_trylock(struct pci_slot *slot)
-{
-	struct pci_dev *dev, *bridge =3D slot->bus->self;
-
-	if (bridge && !pci_dev_trylock(bridge))
-		return 0;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
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
-		if (!dev->slot || dev->slot !=3D slot)
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
-}
-
 /*
  * Save and disable devices from the top of the tree down while holding
  * the @dev mutex lock for the entire tree.
@@ -5410,59 +5319,23 @@ static void pci_bus_restore_locked(struct pci_bus=
 *bus)
 	}
 }
=20
-/*
- * Save and disable devices from the top of the tree down while holding
- * the @dev mutex lock for the entire tree.
- */
-static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
-			continue;
-		pci_dev_save_and_disable(dev);
-		if (dev->subordinate)
-			pci_bus_save_and_disable_locked(dev->subordinate);
-	}
-}
-
-/*
- * Restore devices from top of the tree down while holding @dev mutex lo=
ck
- * for the entire tree.  Parent bridges need to be restored before we ca=
n
- * get to subordinate devices.
- */
-static void pci_slot_restore_locked(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
-			continue;
-		pci_dev_restore(dev);
-		if (dev->subordinate) {
-			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
-			pci_bus_restore_locked(dev->subordinate);
-		}
-	}
-}
-
 static int pci_slot_reset(struct pci_slot *slot, bool probe)
 {
+	struct pci_bus *bus =3D slot->bus;
 	int rc;
=20
-	if (!slot || !pci_slot_resettable(slot))
+	if (!slot || (bus && !pci_bus_resettable(bus)))
 		return -ENOTTY;
=20
-	if (!probe)
-		pci_slot_lock(slot);
+	if (!probe && bus)
+		pci_bus_lock(bus);
=20
 	might_sleep();
=20
 	rc =3D pci_reset_hotplug_slot(slot->hotplug, probe);
=20
-	if (!probe)
-		pci_slot_unlock(slot);
+	if (!probe && bus)
+		pci_bus_unlock(bus);
=20
 	return rc;
 }
@@ -5489,25 +5362,26 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  * wrap the bus reset to avoid spurious slot related events such as hotp=
lug.
  * Generally a slot reset should be attempted before a bus reset.  All o=
f the
  * function of the slot and any subordinate buses behind the slot are re=
set
- * through this function.  PCI config space of all devices in the slot a=
nd
- * behind the slot is saved before and restored after reset.
+ * through this function.  PCI config space of all devices below the slo=
t bus
+ * are saved before and restored after reset.
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
 static int __pci_reset_slot(struct pci_slot *slot)
 {
+	struct pci_bus *bus =3D slot->bus;
 	int rc;
=20
 	rc =3D pci_slot_reset(slot, PCI_RESET_PROBE);
 	if (rc)
 		return rc;
=20
-	if (pci_slot_trylock(slot)) {
-		pci_slot_save_and_disable_locked(slot);
+	if (pci_bus_trylock(bus)) {
+		pci_bus_save_and_disable_locked(bus);
 		might_sleep();
 		rc =3D pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
-		pci_slot_restore_locked(slot);
-		pci_slot_unlock(slot);
+		pci_bus_restore_locked(bus);
+		pci_bus_unlock(bus);
 	} else
 		rc =3D -EAGAIN;
=20
--=20
2.47.3

