Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831B296BC1
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703015; cv=none; b=WZmGgfsLPQMPGE2ktWSwxOjaZB5jLAwAS+09uonar1HCPPRcEi3QsBWClh1EI2akpRdB5l/tEdln1d+wjlhIHnAknkgGYch4m9vUrTDpR5sBIc+WP5W1ggyRBaCwINHngcCNIXkhF5CZeahxyzLJLpa1d89P3ECGQWMryGJ2R64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703015; c=relaxed/simple;
	bh=ht5bHr5CNmzQEYqD2O1bRnV7zm7RIPyY/WRdPZhSwk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jsUfSie9BVnMWACIWhkwQotbWJlrCoKuLGBn/kTULsioCEitJJ75uXLbI6BcrGVlnMyi4Hwl7tIfBtTxGGbLvhbx7fvkz5ntalx6Z76QEFptczKNeI7iAZYG7mG8ABHVVm5HOXuNiZzTX1icXsyhMBIWiMV4LM8ROhzlzGrzvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kwWHa3D+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kwWHa3D+"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TE5SSB3568231
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 08:10:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=Y+45tB43Xki14851QM
	u5ykS7qcHZwKcSTzEQla46+Q0=; b=kwWHa3D+lEA3KlSzfAFysFsgozm0LUgbjz
	TyLPcX5eW1zn7qpfZvggpj2PKXPXI8sH0FcUvyaq8IqhDfBvpMH7LP2TK50YD604
	of+BebPVpErfW3ArVPOzHCMQtjbp7/Od7ct+yYxzAvoOHWv5rZUAe3ahlRUpfq4i
	3ZW4vx3mPTvSo9VhpLcmEo6oE3dN2ddG5J3lkaIR5KltwmxZhN+RkIFwO4ZD3uDN
	bCUmvLx7eG0gALii3zsUnBridrf0748htR8d2CKRe56kw8lP+GjOTOgITkM2Sqnc
	RwAEsbPKCx7wWMMu3YjMzfrL+PIddtCccqi5ZowxLL2jy/8dXuZQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c090jsaue-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 08:10:12 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 29 Jan 2026 16:10:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 822516DF084E; Thu, 29 Jan 2026 08:09:56 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] pci: remove slot specific lock/unlock and save/restore
Date: Thu, 29 Jan 2026 08:09:55 -0800
Message-ID: <20260129160955.2637158-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 54bz9RbCCGcYk1eUiSTrNHiOvryBgbuJ
X-Proofpoint-ORIG-GUID: 54bz9RbCCGcYk1eUiSTrNHiOvryBgbuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExMyBTYWx0ZWRfX8tacsEHK4vnY
 Bc2tqJg7kVmT1NjJEvYP9j7s7T5oIMONO5isaFML2ghd93dQMnVNdB5pZTsD7y/izdpJRyCLjgE
 mhYrJLI9+pRf8jf4WHbzQp++0S0B7qQjoBdk9HwmzE+l77UqoDg2WVqDN69kFyQYzWJbjL7iKXl
 WGxs7zz3zRcp8RKUgdI9WgUUL+a1aHm8m5rrXIklUSh/K4oMmM0WQEm2tgVwqa5dBTBP+DcN1T5
 G/e8VCC7kjasCAJRCwxad6VT3bCAVlwvSW+/8Ajm0/uMrHnUtVL5sCkgC9pmyWPqfBhVqkggPwo
 yRcKtgIN5i3lOQyFX7ciT/qQJ5cAoL87zOtGRoZurUp+0rfQzXmfx/xfpcQ9Fu3FSK8y2jyWmOY
 5EcTwwk7hxb35kFJxD5P3ybbKLXNkj4J7aVVoY2GJ5bieMi+foiUb2mEVs8sWz/1b5WzHfW8SYr
 Oo8fyYmhQj2zpMTsRAQ==
X-Authority-Analysis: v=2.4 cv=MdJhep/f c=1 sm=1 tr=0 ts=697b8664 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=NneaLmsyqHuzaAIrNYsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
every function on every "D", not just the ones with a matching "slot".
The slot lock/unlock and save/restore functions, however, are only
handling a subset of the functions, breaking the rest.

ARI devices with more than 8 functions fail because their state is not
properly handled, nor is the attached driver notified of the reset. In
the best case, the device will appear unresponsive to the driver,
resulting in unexpected errors. A worse possiblility may panic the
kernel if in flight transactions trigger hardware reported errors like
this real observation:

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
This patch is based on v6.19-rc1 as requested. Note, there will be a
minor merge conflict if this other patch fixing the "trylock" handling
is already included:

  https://lore.kernel.org/linux-pci/20260128225344.GA422463@bhelgaas/

But I don't see it applied in any the pci git tree.

 drivers/pci/pci.c | 113 ++++------------------------------------------
 1 file changed, 9 insertions(+), 104 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31f..8c19939d633a0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5307,67 +5307,6 @@ static bool pci_slot_resettable(struct pci_slot *s=
lot)
 	return true;
 }
=20
-/* Lock devices from the top of the tree down */
-static void pci_slot_lock(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
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
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-}
-
-/* Return 1 on successful lock, 0 on contention */
-static int pci_slot_trylock(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot !=3D slot)
-			continue;
-		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
-				goto unlock;
-			}
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
-	return 0;
-}
-
 /*
  * Save and disable devices from the top of the tree down while holding
  * the @dev mutex lock for the entire tree.
@@ -5401,59 +5340,24 @@ static void pci_bus_restore_locked(struct pci_bus=
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
+	struct pci_bus *bus;
 	int rc;
=20
 	if (!slot || !pci_slot_resettable(slot))
 		return -ENOTTY;
=20
+	bus =3D slot->bus;
 	if (!probe)
-		pci_slot_lock(slot);
+		pci_bus_lock(bus);
=20
 	might_sleep();
=20
 	rc =3D pci_reset_hotplug_slot(slot->hotplug, probe);
=20
 	if (!probe)
-		pci_slot_unlock(slot);
+		pci_bus_unlock(bus);
=20
 	return rc;
 }
@@ -5487,18 +5391,19 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
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

