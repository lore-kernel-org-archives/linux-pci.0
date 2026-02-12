Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4E334C3D
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936091; cv=none; b=cbaho07JkEaATxU6vQ8VROebWN1l59kuoYnE7FJqbi6CvZjLPJLtQyvRFywt8CvLRZxh93nBMDGGRtyOC2gy059pDvkpDIkQp8vUheKQ9fkeL4drP/Tw1TXPqExJjh2esGz3vAu9J/kTDbQJi+AgDjohhg5AP0f6f8qbEO5HEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936091; c=relaxed/simple;
	bh=7854eXgWaAnuliV0YJpVYIhMw5s8GJgPvktvULOsn+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvAQo6tdP8Z/jUD/b9moJGpzzWgDris07yHJkLD74Kjl0O40zBROX5LHq+0oAGALI2KhZZ/nfpBHO5UCVtiuDHVmUTBCg9t11DmGGJm46+hxWQ7mN+dw4S37PoElkUdg98foWIsd9BGl1CrMxu5Hx8Mz6sm3Zb4mkx4u0+zOUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZBUSxLCx; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZBUSxLCx"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CJlqJd2149970
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=qnWvBzmTChH18J7v1ZffziJSY/TlS1zoWPtXI9rDyyY=; b=ZBUSxLCxmLLN
	pWFZOzP81SAJfd+YZeZKuy/RfPYXqBn7k960dlERgNtRCYkY9/6QuaYMl1IzqNbn
	ZG6pJsHCw1PTNY7d05/S+tmQSwud2Vf0S26d5xe11LKu7BztOu5i0w0RjeB8SUhk
	2yEngwGJXmkXaonMBZA0PlY/UWaIgNm8iYtbhbJIgT465TLjeUSUwliCJ+wuwe8G
	b2Y8ocKDJxb6nFlvp3HUqp41Zf4oEK8919SU79+YOjmmJQXbayMiqx4pGgt36NWA
	s8FPABMSUxiHWbrrUZiBQCRxCLVfmQ8MhGmUhXM2NEFh/ilB0Q3x7fQkg3RsI7AB
	F+wo26h9CA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c9hynn1r7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:28 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 22:41:26 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AE2F87AD50DC; Thu, 12 Feb 2026 14:41:13 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>, <alex@shazbot.org>,
        <dan.j.williams@intel.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 2/3] pci: allow all bus devices to use the same slot
Date: Thu, 12 Feb 2026 14:41:11 -0800
Message-ID: <20260212224112.1913980-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212224112.1913980-1-kbusch@meta.com>
References: <20260212224112.1913980-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xCo_Cm-aRWyL2ap9FDHEP06JdwwIhFxM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE3NSBTYWx0ZWRfX7dNmGdpKnD/N
 CY65FJ+QL3D+7bR5e88xMWsdQKJjlIFqdMeJYjh/5rimRZEUfTZcmaEemP8gi3BeL32Pw+rkTI1
 f/+OjyPHi6l7/OX289O25MRB/Gny+izyOfYYAef0KUI37Cl7+XZ2PMAJHwevuuYV9vdgKNtiY0w
 h+cyvz23lWs3MzVR8ywqnm7g2MV635Md5uLr01DwFpmH8iVtTOTCAiLclNTiwEnSn3jpvPukvzQ
 K/SB60dAz95R5FqgL7/0UJ9Zc/iE9agX1i2tV+gvLAApUBcBuGyDenXWkEKzAXz0GR/mRBb0j0D
 4mzm1Xn6avBU10IQggfqEi2Vbn4FaFhLu6hYGysRgerTR70zCSN8OELZJS+czIeQaW0hsO6V4O7
 kNc7ew4VTAKoNZia9w9wL9hRBKLrD2eTkRpn5Q32HW4UxitOqzY4jVHtXBRjjQvaWHv4vRGbcUV
 uFDEnDQv3Iit68E8yHg==
X-Proofpoint-ORIG-GUID: xCo_Cm-aRWyL2ap9FDHEP06JdwwIhFxM
X-Authority-Analysis: v=2.4 cv=DfMaa/tW c=1 sm=1 tr=0 ts=698e5718 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=CNu0A2bchwO_Ns1ddjEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A pcie hotplug slot applies to the entire subordinate bus. Thus, pciehp
only allocates a single hotplug_slot for the bridge to that bus. The pci
slot, though, would only match to functions on device 0, meaning all
device beyond that are not matched to any slot even though they share
it. A slot reset will break all the missing devices because the handling
skips them.

Allow a slot to be created to claim all devices on a bus, not just a
matching device. This is done by introducing a sentinel value, named
PCI_SLOT_ALL_DEVICES, which then has the pci slot match to any device on
the bus. This fixes slot resets for pciehp.

Since 0xff already has special meaning, the chosen value for this new
feature is 0xfe. This will not clash with any actual slot number since
they are limited to 5 bits.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/hotplug/pciehp_core.c |  3 ++-
 drivers/pci/slot.c                | 27 +++++++++++++++++++++++----
 include/linux/pci.h               |  8 +++++++-
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pcie=
hp_core.c
index f59baa9129709..d80346d567049 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -79,7 +79,8 @@ static int init_slot(struct controller *ctrl)
 	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
=20
 	retval =3D pci_hp_initialize(&ctrl->hotplug_slot,
-				   ctrl->pcie->port->subordinate, 0, name);
+				   ctrl->pcie->port->subordinate,
+				   PCI_SLOT_ALL_DEVICES, name);
 	if (retval) {
 		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
 		kfree(ops);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 50fb3eb595fe6..bf6f265454a84 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -42,6 +42,15 @@ static ssize_t address_read_file(struct pci_slot *slot=
, char *buf)
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
=20
+	/*
+	 * Preserve legacy ABI expectations that hotplug drivers that manage
+	 * multiple devices per slot emit 0 for the device number.
+	 */
+	if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES)
+		return sysfs_emit(buf, "%04x:%02x:00\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number);
+
 	return sysfs_emit(buf, "%04x:%02x:%02x\n",
 			  pci_domain_nr(slot->bus),
 			  slot->bus->number,
@@ -73,7 +82,8 @@ static void pci_slot_release(struct kobject *kobj)
=20
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) =3D=3D slot->number)
+		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
 			dev->slot =3D NULL;
 	up_read(&pci_bus_sem);
=20
@@ -166,7 +176,8 @@ void pci_dev_assign_slot(struct pci_dev *dev)
=20
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) =3D=3D slot->number)
+		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
 			dev->slot =3D slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -188,7 +199,7 @@ static struct pci_slot *get_slot(struct pci_bus *pare=
nt, int slot_nr)
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), -1 for placeholder, or PCI_SLOT_A=
LL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -222,6 +233,13 @@ static struct pci_slot *get_slot(struct pci_bus *par=
ent, int slot_nr)
  * consist solely of a dddd:bb tuple, where dddd is the PCI domain of th=
e
  * %struct pci_bus and bb is the bus number. In other words, the devfn o=
f
  * the 'placeholder' slot will not be displayed.
+ *
+ * Bus-wide slots:
+ * For PCIe hotplug, the physical slot encompasses the entire subordinat=
e
+ * bus, not just a single device number. Pass @slot_nr =3D=3D PCI_SLOT_A=
LL_DEVICES
+ * to create a slot that matches all devices on the bus. Unlike placehol=
der
+ * slots, bus-wide slots go through normal slot lookup and reuse existin=
g
+ * slots if present.
  */
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
@@ -285,7 +303,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *pare=
nt, int slot_nr,
=20
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) =3D=3D slot_nr)
+		if (slot_nr =3D=3D PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) =3D=3D slot_nr)
 			dev->slot =3D slot;
 	up_read(&pci_bus_sem);
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index edf792a79193f..7073519bcc1ad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -72,12 +72,18 @@
 /* return bus from PCI devid =3D ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
=20
+/*
+ * PCI_SLOT_ALL_DEVICES indicates a slot that covers all devices on the =
bus.
+ * Used for PCIe hotplug where the physical slot is the entire subordina=
te bus.
+ */
+#define PCI_SLOT_ALL_DEVICES	0xfe
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
-	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
+	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
 	struct kobject		kobj;
 };
=20
--=20
2.47.3

