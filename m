Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82579356A3B
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792423; cv=none; b=lb5gJBK9mE5wFQgm2nUxR0PsJxDqvlDI/DhQWFunfo+6co6eU4rAXVrHwMqNHuyIJ+gnugSxrxXZeeYpqJEH81ZAiwnwc7lqk/OjL6RrBVRTfJmpj+JVBkJMBYf5g+nfJ35wu/hD9q3SmhWAJQznF62UFbJ+rMWsscNDMXwamUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792423; c=relaxed/simple;
	bh=AehL96my016dwhyNpn2/TywBzR7TjfH+SGrIAyFUzss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyBWNRTdJ6kKhCl9G+PMGyZsrld3zL1IdAr+06J7y5XzhzjdCLYMRxoCGLRf+UmjUQoM/RgveBG/O1Ur3rdcu1g2ZWf+mNbQ2T+W27oYL6MA/TkzG/XYI9bmnity5X0Q57iKJ7N31izMhGnA2hM2WZzZHTeIV8mSQ8Bkk9i4Ank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Kvew6y4S; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Kvew6y4S"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60UD9Dlc3839412
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6PSP3v+F/zZjleC+9AXZTQxLlWWElEf/5NclLxCsGOY=; b=Kvew6y4SCYTM
	93OoWWv8eODP3+TP5olUAsBt5Ke5sXFz7lywrq0ynQDZTVx9CA/ic6SlQgnhw6EZ
	sPL7Dr1/8k86CjboO1fU+zLboX759GSesG3juoqYYwtOJ8mMH2Bc1x++FgujkPlE
	MD8f+o/EKADI50Ru1qENTNPN6HqUdLIbRm41a2OD9bqoA6EIgUArwQC2wsKqRbPl
	qo25lJkhYyZ/sRNZCMSAqkrqhCqiwsNJxOEMkpNCBbxHcbLcmDpDwAZZ4A5vP0MI
	2TR/qJq3BbhxZY/Jce1eKaVZrpVIZ2WosCOwNYoJKTDFtty7yBRxrzUKyLqidwdq
	kM81DCD2cw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c0w9ctd2d-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:21 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 30 Jan 2026 17:00:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EB1346EAF1BD; Fri, 30 Jan 2026 09:00:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 2/4] pci: fix slot reset device locking
Date: Fri, 30 Jan 2026 08:59:51 -0800
Message-ID: <20260130165953.751063-3-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: ina0-V3ufxTIALfl56LjTOOcapmEAHZ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX2hlzBY95q6sB
 kU8NeQA0rtKxpzeKWjiywn+iNlR2Kw/zFqMEmgfmOig1mQqJpj4qH4h0YpLUoqjtHYmL9IWZTln
 DyilxHbuKk8WEm/VrIFzfuOeNB3SDtvLcj7DxjLQXScICTOORGfAbkvYriTctalEmatFkXsyFkI
 ouVF2TKcTSphK1Br3I/DUTqlzjc+kDA5OddkDsZKLmPC4fa8p3337knhpFdJDcYRIxUDIUCzsed
 VhzJ9DBt9RO8LwXZmESyBhN0gJNh/4Il1qnF+LgEMH9Rvuj3Ps7DYVEldBeeGbxfDtWXe5i79m/
 1HRibACye8g3B8IelGWyq/MiJ+1W1OJahrr80BO+nqxGOBI7xj1TFDkpZJ2dB0TRhWoYdwy37VU
 T+DJd99DoLY8KgoCX1g7qsPd4/UCcWJPD9nPk1VxbSbQJkoPRNdaNxdNUINVOLyvRddhSSkFWeV
 Y+UOnp7FdKT3MOsjDnw==
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=697ce3a5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=T-2OefsR-unKv_WLUSoA:9
X-Proofpoint-GUID: ina0-V3ufxTIALfl56LjTOOcapmEAHZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
prevent warnings like:

  pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_s=
lot+0x55/0xa0

Take and release the lock for the bridge providing the slot for the
lock/trylock and unlock routines.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59319e08fca61..57a5b205175f1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5290,10 +5290,9 @@ static int pci_bus_trylock(struct pci_bus *bus)
 /* Do any devices on or below this slot prevent a bus reset? */
 static bool pci_slot_resettable(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge =3D slot->bus->self;
=20
-	if (slot->bus->self &&
-	    (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+	if (bridge && (bridge->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
 		return false;
=20
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
@@ -5310,7 +5309,10 @@ static bool pci_slot_resettable(struct pci_slot *s=
lot)
 /* Lock devices from the top of the tree down */
 static void pci_slot_lock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge =3D slot->bus->self;
+
+	if (bridge)
+		pci_dev_lock(bridge);
=20
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot !=3D slot)
@@ -5325,7 +5327,7 @@ static void pci_slot_lock(struct pci_slot *slot)
 /* Unlock devices from the bottom of the tree up */
 static void pci_slot_unlock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge =3D slot->bus->self;
=20
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot !=3D slot)
@@ -5335,12 +5337,18 @@ static void pci_slot_unlock(struct pci_slot *slot=
)
 		else
 			pci_dev_unlock(dev);
 	}
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 }
=20
 /* Return 1 on successful lock, 0 on contention */
 static int pci_slot_trylock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge =3D slot->bus->self;
+
+	if (bridge && !pci_dev_trylock(bridge))
+		return 0;
=20
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot !=3D slot)
@@ -5363,6 +5371,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		else
 			pci_dev_unlock(dev);
 	}
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 	return 0;
 }
=20
--=20
2.47.3

