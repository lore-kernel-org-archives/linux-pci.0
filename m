Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6D330B3B
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326766; cv=none; b=V/iun+PZMabS51vgM4x6jDqG0ckNrOzi1/avfniuqsAClVhK0z5wJ816kBVz5qXBsTyzA0Gm+XP3yTUmFkBktXtwHZ0EXQUXzf7Z6j+EiPJJwVGwKXN1ug/5GEZx86DuvBQviukOxmlP9AINzLM324GXkKD3q+j2nGogo8PRVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326766; c=relaxed/simple;
	bh=SqjPsXr6piVk6ogVoVIUTMT1jcjJYRJitl67noT+hvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTVSWyXBjkcCfbwFlFKq9QYdjCzN+hqdVF2Q3Ds8zUUrB5Dy7utGOX+KFdvWvpFTNjLyqM8V5QcWJ8FqGM5ZDkXW0ih4KwrA/Tx0vvaPN+4B4LdcWU/1gx4Ikoh9v+tk0m5aWmn8WA3TqZjCTuM+Ik2yRYJokef8QbPLlv0eudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=quSKeo8S; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="quSKeo8S"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615LGPq52800679
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2026 13:26:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YayacKBhq5fM8F+dwFjzyqDrFdp5PKOkZJL5HBfcF8U=; b=quSKeo8SQeH4
	3ZD9L7ruuwRqD8LiDFM88FOKba/iVh23PIp9AS4Uccc/yuhgGvR9ck9Y9tPXCeek
	6gKKcCAUnn6qDwDboboAaPbIKlC1ogTOhUsGRiqAqh4BRVpc5wXS+q3Npbns7aye
	Rwc1oLj+jlvzhWBdxgOpLF1D8SW62tmbe74pOcuf73OWJgbXNAuB7UOeLVs/Yima
	QZI7gf86TW39hss/UhxNgnDoEgITGpyqHxYxgeVspojEfQ0yQerxa2f8idWnJX6S
	r2pug0Lso7qVX36wE0o599u4TihKiGhDHLAJOLOrptLe/sX2jSp112i/cLEN+6W9
	Nmqsl6eKlQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c52ysr3n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 13:26:05 -0800 (PST)
Received: from twshared10186.03.snb1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 21:26:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 39F1F72EC9CE; Thu,  5 Feb 2026 13:25:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 2/4] pci: allow all bus devices to use the same slot
Date: Thu, 5 Feb 2026 13:25:31 -0800
Message-ID: <20260205212533.1512153-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205212533.1512153-1-kbusch@meta.com>
References: <20260205212533.1512153-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Wo0m8Nfv c=1 sm=1 tr=0 ts=69850aed cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=CNu0A2bchwO_Ns1ddjEA:9
X-Proofpoint-GUID: -IMNNe_71a_D4IKhVmp-NTmVblH8Cmfr
X-Proofpoint-ORIG-GUID: -IMNNe_71a_D4IKhVmp-NTmVblH8Cmfr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfX4bEmr1YiKHV0
 9PRvOHeBm+ESDYKAhZXxMYmNYCMnfCaKesuEv2mvtrvS4Br9qws6Ixo45FRJP5q2ENP71kN0pvU
 binuFMPOxKTwXkoOGUmNnQOFxIz2pI6xs+n5ZkIHaD/PHy6APJHbQHkyJboSC4zf7cbs81C4w+q
 KUb7SbAwLJhcJOtIVmD6PCCUJPasL+whkdz5ySrg9Y+RbwXZ15nUtEfeCXSAy3KBQOQrVku+iqR
 W45NH6ZyyzaeUxOUZCbxuB1hqVQYULQKRaecSKesjQTKtyU8FY0/DkjxRYxdJYc2IQOG/q0bJ1M
 JPgJtYwqK6deOhb54wMdJsnaKPWP8H2+Qd6SUNWz1mJbiPu44dlVfm0LAutOYHtYXMFHpFvNudp
 d7t6Ptn0Cld1z+6IgwztZ5vSl1y9kPbqnPhTJRo/ATySRzA4YzaKbJLPd4WZFc0QQbwbA5R/jFo
 HCWK2G2H2suhYblT31A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A pcie hot plug slot applies to the entire subordinate bus. Thus, pciehp
only allocates a single hotplug slot for the bridge to that bus. The pci
slot, though, would only match to functions on device 0, meaning any
other device beyond that are not matched to any slot even though they
all share the same slot.

Allow a slot to be created to claim all devices on a bus, not just a
matching device. This is done by introducing a sential value, named
PCI_SLOT_ALL_DEVICES, which then has the pci slot match to any device on
the bus. This fixes walking the slot's device list for ports that don't
have device specific slots.

Since 0xff already has special meaning, the chose sentinal value for
this new feature is 0xfe. This will not clash with any actual slot
number since they are limited to 5 bits.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/hotplug/pciehp_core.c |  3 ++-
 drivers/pci/slot.c                | 22 ++++++++++++++++++----
 include/linux/pci.h               |  8 +++++++-
 3 files changed, 27 insertions(+), 6 deletions(-)

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
index 50fb3eb595fe6..647f6d2cceef6 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -41,6 +41,10 @@ static ssize_t address_read_file(struct pci_slot *slot=
, char *buf)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
+	if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES)
+		return sysfs_emit(buf, "%04x:%02x:00\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number);
=20
 	return sysfs_emit(buf, "%04x:%02x:%02x\n",
 			  pci_domain_nr(slot->bus),
@@ -73,7 +77,8 @@ static void pci_slot_release(struct kobject *kobj)
=20
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) =3D=3D slot->number)
+		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
 			dev->slot =3D NULL;
 	up_read(&pci_bus_sem);
=20
@@ -166,7 +171,8 @@ void pci_dev_assign_slot(struct pci_dev *dev)
=20
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) =3D=3D slot->number)
+		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
 			dev->slot =3D slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -188,7 +194,7 @@ static struct pci_slot *get_slot(struct pci_bus *pare=
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
@@ -222,6 +228,13 @@ static struct pci_slot *get_slot(struct pci_bus *par=
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
@@ -285,7 +298,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *pare=
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
index 864775651c6fa..d9f85025d97f5 100644
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

