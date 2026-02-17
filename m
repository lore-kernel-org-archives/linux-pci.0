Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A336D516
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344537; cv=none; b=uz0rSfRHqZEtHpCLwvEYjPH6Z3X3du/w5ScQAGixREolTSz4f3PPbpc2juzqs2ysMyUNwuS3ynpMvmWu6MfuB+VEKm5JtK7HWPs+XngES0j8Llgp8Nx8rWd1y1gtGcchZZcp9dlj7hIgu5zs6c3XQpyh+adqkfS0Ld4sAOaQOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344537; c=relaxed/simple;
	bh=XQJxbqinXbso4V3N9Foq5QpawTUbqAtI8tokFNuwwx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okrF7fhrI5pnRiHUd5lDjQY/akVxKmGSISQb9FEkI5iQo39re6xr0v4Xm0C78gc47BA0LHENVfKz65WBlY0kGecwV69prGUnNKJbyhCJdbS8cpeJlC4MV2yd7Fk06JkrOVYQmbKgqNL3i0maWNa77vRCM7Ba3Xhi9Hzyus5F3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S34Y+R4i; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S34Y+R4i"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61HEr0D0546040
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=UdHZLAxhWYSq6Kv1ne8jpsRY6lRHDS4S229KNeT83e4=; b=S34Y+R4iwvMi
	B35HSgGUDz5NQHbo9+2OqAtzO8kgcQNPs23ywIZgvkvS1Pr84ClIltaQrGQ+Uh1h
	9zObkwQG8bFsj4mdqTC9/TrjbwLWEWrrKSOjluePEBCYScvGlbBjThRZyGXKa1Gc
	0M9gevx71q/icNqX9pZK5lrUGoc+B0G3XAKQ8Dv6qk6H1Mo+ErxokOAgxQllVCxg
	aFugD1Ft6Hs40kS7UmmKlWnHkcEFqmmNgbLkfu2rbFKapvsDw4FPMYEwuePyX4P5
	v0f5hUjkEngf7CuGMH7xTQNppa1XqcF1qbQJHIfcR/G6ELh9KNUrNwCPIyEal/Q7
	H6ey8uRovg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cctg217jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:54 -0800 (PST)
Received: from twshared18212.03.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Feb 2026 16:08:41 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5E6C0811FAFA; Tue, 17 Feb 2026 08:08:39 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <dan.j.williams@intel.com>
CC: <alex@shazbot.org>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 3/3] PCI: make reset_subordinate hotplug safe
Date: Tue, 17 Feb 2026 08:08:36 -0800
Message-ID: <20260217160836.2709885-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217160836.2709885-1-kbusch@meta.com>
References: <20260217160836.2709885-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzMSBTYWx0ZWRfX7CKOzdjIgytk
 7RnMLQu1ngyAFYhl8H4/Az+OE4PjLrGUQqjrVwOm4smTMmPRNPEOjhtoLGMbHAIlkjHkyiedwHm
 z1pFD+Lf0kD7R+/IR2wmgdIwpFne9lBc4dLTBWCZYrh1DXLquVhzFShaCeuV6BeKMskPGFwPE15
 Hcl+G5oXbXMvEHafoxZuQMKW8UBLzteIgQa65Ue1mGo6hAYxD9Ey9UjYtFHTrLzJrFfzvPt9G2+
 ugQll0e+fxhPNxIP+O16WcNDYgmBtJ2Tv9NOsw6mIbECaYVgZvqNsECYsWqARfv9nDGUUg7tSXu
 o+bheQD4123P/5lxXFvcLXmh5y5tna8C5l95+drNEGPBwt9f2xw6N2a/8KBDDPCI2iqTsX7iOPe
 wf+V1TUNveBWkrEdF8gxB7WK9TV1aeqm5R7uE1g80E1Q5YcfM+flcq85joXBirODT662EVlfrBm
 +omGYye0kv7M0fbJoJw==
X-Authority-Analysis: v=2.4 cv=RbWdyltv c=1 sm=1 tr=0 ts=69949296 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=eI16JKCc1AcFLPAmXCIA:9
X-Proofpoint-ORIG-GUID: nlyvUXnMu9QAUQ39TImz0rRzwabiRcyl
X-Proofpoint-GUID: nlyvUXnMu9QAUQ39TImz0rRzwabiRcyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Use the slot reset method when resetting the bridge if the bus contains
hot plug slots. This fixes spurious hot plug events that are triggered
by the secondary bus reset that bypasses the slot's detection disabling.

Resetting a bridge's subordinate bus can be done like this:

  # echo 1 > /sys/bus/pci/devices/0000:50:01.0/reset_subordinate

Prior to this patch, an example kernel message may show something like:

  pcieport 0000:50:01.0: pciehp: Slot(40): Link Down

With this change, the pciehp driver ignores the link event during the
reset, so may show this message instead:

  pcieport 0000:50:01.0: pciehp: Slot(40): Link Down/Up ignored

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c |  3 +-
 drivers/pci/pci.c       | 91 +++++++++++++++++++++++++++--------------
 drivers/pci/pci.h       |  2 +-
 3 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b44e884fd5372..6187b0f3e2833 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -553,7 +553,6 @@ static ssize_t reset_subordinate_store(struct device =
*dev,
 				const char *buf, size_t count)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
-	struct pci_bus *bus =3D pdev->subordinate;
 	unsigned long val;
=20
 	if (!capable(CAP_SYS_ADMIN))
@@ -563,7 +562,7 @@ static ssize_t reset_subordinate_store(struct device =
*dev,
 		return -EINVAL;
=20
 	if (val) {
-		int ret =3D pci_try_reset_bus(bus);
+		int ret =3D pci_try_reset_bridge(pdev);
=20
 		if (ret)
 			return ret;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3bd0a830872c4..747f35bad60a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5597,14 +5597,44 @@ static int pci_bus_reset(struct pci_bus *bus, boo=
l probe)
 }
=20
 /**
- * pci_bus_error_reset - reset the bridge's subordinate bus
- * @bridge: The parent device that connects to the bus to reset
+ * pci_try_reset_bus - Try to reset a PCI bus
+ * @bus: top level PCI bus to reset
+ *
+ * Same as above except return -EAGAIN if the bus cannot be locked
+ */
+static int pci_try_reset_bus(struct pci_bus *bus)
+{
+	int rc;
+
+	rc =3D pci_bus_reset(bus, PCI_RESET_PROBE);
+	if (rc)
+		return rc;
+
+	if (pci_bus_trylock(bus)) {
+		pci_bus_save_and_disable_locked(bus);
+		might_sleep();
+		rc =3D pci_bridge_secondary_bus_reset(bus->self);
+		pci_bus_restore_locked(bus);
+		pci_bus_unlock(bus);
+	} else
+		rc =3D -EAGAIN;
+
+	return rc;
+}
+
+#define PCI_RESET_RESTORE true
+#define PCI_RESET_NO_RESTORE false
+/**
+ * pci_reset_bridge - reset a bridge's subordinate bus
+ * @bridge: bridge that connects to the bus to reset
+ * @restore: when true use a reset method that invokes pci_dev_restore()=
 post
+ *           reset for affected devices
  *
  * This function will first try to reset the slots on this bus if the me=
thod is
  * available. If slot reset fails or is not available, this will fall ba=
ck to a
  * secondary bus reset.
  */
-int pci_bus_error_reset(struct pci_dev *bridge)
+static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
 {
 	struct pci_bus *bus =3D bridge->subordinate;
 	struct pci_slot *slot;
@@ -5620,17 +5650,42 @@ int pci_bus_error_reset(struct pci_dev *bridge)
 		if (pci_probe_reset_slot(slot))
 			goto bus_reset;
=20
-	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
+	list_for_each_entry(slot, &bus->slots, list) {
+		int ret;
+
+		if (restore)
+			ret =3D pci_try_reset_slot(slot);
+		else
+			ret =3D pci_slot_reset(slot, PCI_RESET_DO_RESET);
+
+		if (ret)
 			goto bus_reset;
+	}
=20
 	mutex_unlock(&pci_slot_mutex);
 	return 0;
 bus_reset:
 	mutex_unlock(&pci_slot_mutex);
+
+	if (restore)
+		return pci_try_reset_bus(bus);
 	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
 }
=20
+/**
+ * pci_bus_error_reset - reset the bridge's subordinate bus
+ * @bridge: The parent device that connects to the bus to reset
+ */
+int pci_bus_error_reset(struct pci_dev *bridge)
+{
+	return pci_reset_bridge(bridge, PCI_RESET_NO_RESTORE);
+}
+
+int pci_try_reset_bridge(struct pci_dev *bridge)
+{
+	return pci_reset_bridge(bridge, PCI_RESET_RESTORE);
+}
+
 /**
  * pci_probe_reset_bus - probe whether a PCI bus can be reset
  * @bus: PCI bus to probe
@@ -5643,32 +5698,6 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
=20
-/**
- * pci_try_reset_bus - Try to reset a PCI bus
- * @bus: top level PCI bus to reset
- *
- * Same as above except return -EAGAIN if the bus cannot be locked
- */
-int pci_try_reset_bus(struct pci_bus *bus)
-{
-	int rc;
-
-	rc =3D pci_bus_reset(bus, PCI_RESET_PROBE);
-	if (rc)
-		return rc;
-
-	if (pci_bus_trylock(bus)) {
-		pci_bus_save_and_disable_locked(bus);
-		might_sleep();
-		rc =3D pci_bridge_secondary_bus_reset(bus->self);
-		pci_bus_restore_locked(bus);
-		pci_bus_unlock(bus);
-	} else
-		rc =3D -EAGAIN;
-
-	return rc;
-}
-
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d1350d54b932d..9e363ad22e161 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -231,7 +231,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
-int pci_try_reset_bus(struct pci_bus *bus);
+int pci_try_reset_bridge(struct pci_dev *bridge);
=20
 struct pci_cap_saved_data {
 	u16		cap_nr;
--=20
2.47.3

