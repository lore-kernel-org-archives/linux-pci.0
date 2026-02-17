Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FF36D51B
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344537; cv=none; b=cW2gpSTvh+clPXcieYdktcZ+tOynSrB7VcWcHE75Dqy4u6SxCdqfiRE5vpyqGbGg28Kd1AopGQ86q4DLcjF030cnEFjFpV1xWD65hrB4h30CwHD9ydkwIo23tlN5sR7bk8AnLYf5iH6o5QHnkimekWLyC7SXGkhLYCXbvzR7agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344537; c=relaxed/simple;
	bh=JLVgi8q6f3sQJATnw9sxLY9D6/Yo8lWQM/rllZpPTvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMRfaLw+8CaAbq8do4Cv6S4I1WCHA4K8anDAHD42EDnzhfnoquo5q6sfNS4D3blQuHlH5ZJPZVjA8uOC1dHydTh2PwKMYfGlyZ0BNiT3HZ76VzOtvgfuhBQFmUmnHS34CMkfdcjUlGD7XYjW9Jpejn8iP651Ks1sk5ptGVup6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VQgSuzbJ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VQgSuzbJ"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61HEr0D2546040
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KBw06S5crApuXlHs1nrTIyurzMj3sXa8L5hqLN/NtVM=; b=VQgSuzbJh91p
	ACk1G3D5DcmTyk89Pb7kohdlXUIKFZPYLqjjNtUha9AdNbQrPs5Ku+mCjAi9liEc
	PaEOmCaje2RJNKa5FuDg7vY8uTPeiK5sNfu8I6CaVbUc+r3teNdEe1GCLa7wq7o5
	UQ+iEjDsZ+iUw7/CaON//W2sK7/IJKywl1NPcWXM0kS4hOUk4yyzd0OBsdeVOX3y
	iVqIYfyBbjv8Pig7bw87gs5oTQYqIoW0xyZMAOFTfr92fbab8Nbe/ePOdiLwwj8V
	vhVaSjZQXVq46sNzcoeHVBeQHJ+UEh3RPTNoho0aEVmBC/ViTDWNPFgQKc7S+y5v
	84hMax0clw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cctg217jb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:55 -0800 (PST)
Received: from twshared10186.03.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Feb 2026 16:08:53 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5D515811FAF9; Tue, 17 Feb 2026 08:08:39 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <dan.j.williams@intel.com>
CC: <alex@shazbot.org>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 2/3] PCI: allow all bus devices to use the same slot
Date: Tue, 17 Feb 2026 08:08:35 -0800
Message-ID: <20260217160836.2709885-3-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzMSBTYWx0ZWRfX7pFFri50C5Xf
 tW+QfeMz4P5nDE4zjJTdNC19126BJ8kM1AnxeUnTV+8wRD2m+URuvhd0XXTskcvYqfB7ZCMKV/m
 aPHUmSYf+JuZRp+VvCEd0gIBR651HmDDDF77faQpcwW0cfXbr8nBULmRHb/SVmxnIHWXCsw6FQs
 /5frYnI9LNsO5Op8yWSgFs13g0CiKX/yVcez1Cgkhdf5yZFihOc/g9Ljhl3z+qOez9i5HOj44/v
 FKfqsg1C+xRaYK82eg0m4idAZndiwnfqmiJUn9K0zfKtgEsRnyYFocQv2PkfsTNSr/BWxMGnPsX
 e2lNehMuBgp0VPROgvr42c5U4LRW4+Ij4hQwDhrvRtBqlLiWdisL3eAS8vI5aHwpKalFIHo2RlP
 uOCdFaq/RnCFFeWwUm4XDvc72ZD3URjBmkqW4x8LUELVXgCsukjH5ErnTLhcg8co3JWwJ/Z/erX
 6eA32jiryAe2VGuw4Ng==
X-Authority-Analysis: v=2.4 cv=RbWdyltv c=1 sm=1 tr=0 ts=69949297 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=zHBkS0eXDblhuCRJbxAA:9
X-Proofpoint-ORIG-GUID: hhaIcouuNJHN2P8e688_CeWxRHnta4gB
X-Proofpoint-GUID: hhaIcouuNJHN2P8e688_CeWxRHnta4gB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A pcie hotplug slot applies to the entire subordinate bus. Thus, pciehp
only allocates a single hotplug_slot for the bridge to that bus. The pci
slot, though, would only match to functions on device 0, meaning all
device beyond that are not matched to any slot even though they share
it. A slot reset will break all the missing devices because the handling
skips them.

For example, ARI devices with more than 8 functions fail because their st=
ate is
not properly handled, nor is the attached driver notified of the reset. I=
n the
best case, the device will appear unresponsive to the driver, resulting i=
n
unexpected errors. A worse possibility may panic the kernel if in flight
transactions trigger hardware reported errors like this real observation:

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

