Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F8356A3B
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792421; cv=none; b=taFIwSt2ASBzc7cLeIS7l2jKuMB27IKC0IQYCQg9b7Ci4ul18W4OIh9lJGIatRzX/12nqlZ6W+vlR8vF78vEXkhFn6zW/Wkysr3xgBuiZqYJN7rm6hQ+DazB3e/U7fKRDgBwRwBYqWa9eKvEVPBvMtJdMzj/bmhmKzAFsNbu3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792421; c=relaxed/simple;
	bh=mSfSgk8eWaJodp5LxzkUj1UYa4dgP3+T49p52HycBlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7VEL6COvV/g9TpeNEfi/txy8d1LBucd5D5BbPtWF9lejju7costIIhDd0sLhDm0ERa9uxGhSh5cZ2vJE1ci6bwoH6m3t5Qa43idxpZtjgsYg1bqfLQN0sz1R2y6ckCYEbVa5d5ut8WS4skcfRzVI2AoQFq73AFPwBFfEPiFvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=L+/5+nrF; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="L+/5+nrF"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBM7Gc2341509
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4aD6uHAv4h1fsjB3VKlAVOlhQ8FSUmqy9Pvz9GHnQkA=; b=L+/5+nrFTMGF
	E5HpjQaFY0LDBK2Whzfiu5vRewyAIbz3r1r94fZMvBLS+gS9FdoDKgHiheGae233
	zCrhc+sl3pK49hCKadnqNXn382BqFg/D72UWFWlJsby/+gyaDv7LVuRTdxesDT4M
	Q/8rUR8y4KGqxl9XAcNnrCgQoKQCGsoidhPM25Zqinp9qYCBTZAmTpVK5QP1ZISK
	59NfaPabVRvle9zWBPjWBjGuZaubovmz5l1lMQ1/zPH/JfoRIsS2Srb6w8kL5eIj
	MbATIgOm0CmMt/smIzBNZBAvlTv1kOPDxqqskUCbsMZaP0N7cT0Rg+Kx8dKTG/jW
	t5Xhgrljwg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c0uq7b3mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:18 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 30 Jan 2026 17:00:17 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id ED11C6EAF1D9; Fri, 30 Jan 2026 09:00:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 4/4] pci: make reset_subordinate hotplug safe
Date: Fri, 30 Jan 2026 08:59:53 -0800
Message-ID: <20260130165953.751063-5-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: fWO_dDzRYYr4Whm_SlMJT-HdUrzvos3E
X-Proofpoint-GUID: fWO_dDzRYYr4Whm_SlMJT-HdUrzvos3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX+ZY3RYXx0f6c
 7+ttS5NrZHITXXCHIwVxWiPCB1jMXHkhy5mBJRITMjng3sGHr3QGxU+3M07PLdt0W/Wk48pTID+
 Vp3ASYXF4ESOFKWgjbxbKW4Zc524vSwh22ICu6KJPFd+pDXrZb/cpscxz+9JGbnB61Adsjo1Lf8
 SwBNlOwxJXZ7TmeH/WDwoAG8uqHSkY06J4yu3mwpDG+Adc8We/a4YTw/ku6M+r0w6wjtb0NEk64
 iA71TS4h6u34PnXq5Lk6fm04oFbx6EQoK0T7tIWtJXmVoAkhv1+y6atczUnu6dG9lJqBCuktM4a
 XW8LwjcxQf8O/FM6wkycrhUAOf5UxP4GGLEE0RwR6fireFsSJ9zvCR6vC5vhElyB/rgAQlH8Z0r
 CiPAINM6DqY5NRdsP3b5Iu3/guS18mMVIqi5H3fnjN8MY0GD4kXK62J3FOZldBjIk2qyHWr92Yo
 3K5aXqC+j37OJ7HUvOA==
X-Authority-Analysis: v=2.4 cv=QOllhwLL c=1 sm=1 tr=0 ts=697ce3a2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=ZVLaCVSKNohXPzQMch4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01

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

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c |  3 +-
 drivers/pci/pci.c       | 70 +++++++++++++++++++++++++++--------------
 drivers/pci/pci.h       |  2 +-
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2df915ad2d29..0e1cef1c1c73b 100644
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
-		int ret =3D __pci_reset_bus(bus);
+		int ret =3D pci_reset_bridge(pdev);
=20
 		if (ret)
 			return ret;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 36427fbf7a747..12cf61a9bbeb1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -50,6 +50,7 @@ EXPORT_SYMBOL(pci_pci_problems);
 unsigned int pci_pm_d3hot_delay;
=20
 static void pci_pme_list_scan(struct work_struct *work);
+static int __pci_reset_bridge(struct pci_dev *bridge, bool save);
=20
 static LIST_HEAD(pci_pme_list);
 static DEFINE_MUTEX(pci_pme_list_mutex);
@@ -5419,29 +5420,7 @@ static int pci_bus_reset(struct pci_bus *bus, bool=
 probe)
  */
 int pci_bus_error_reset(struct pci_dev *bridge)
 {
-	struct pci_bus *bus =3D bridge->subordinate;
-	struct pci_slot *slot;
-
-	if (!bus)
-		return -ENOTTY;
-
-	mutex_lock(&pci_slot_mutex);
-	if (list_empty(&bus->slots))
-		goto bus_reset;
-
-	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_probe_reset_slot(slot))
-			goto bus_reset;
-
-	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
-			goto bus_reset;
-
-	mutex_unlock(&pci_slot_mutex);
-	return 0;
-bus_reset:
-	mutex_unlock(&pci_slot_mutex);
-	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
+	return __pci_reset_bridge(bridge, false);
 }
=20
 /**
@@ -5462,7 +5441,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int __pci_reset_bus(struct pci_bus *bus)
+static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
=20
@@ -5482,6 +5461,49 @@ int __pci_reset_bus(struct pci_bus *bus)
 	return rc;
 }
=20
+static int __pci_reset_bridge(struct pci_dev *bridge, bool save)
+{
+	struct pci_bus *bus =3D bridge->subordinate;
+	struct pci_slot *slot;
+
+	if (!bus)
+		return -ENOTTY;
+
+	mutex_lock(&pci_slot_mutex);
+	if (list_empty(&bus->slots))
+		goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list)
+		if (pci_probe_reset_slot(slot))
+			goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list) {
+		int ret;
+
+		if (save)
+			ret =3D __pci_reset_slot(slot);
+		else
+			ret =3D pci_slot_reset(slot, PCI_RESET_DO_RESET);
+
+		if (ret)
+			goto bus_reset;
+	}
+
+	mutex_unlock(&pci_slot_mutex);
+	return 0;
+bus_reset:
+	mutex_unlock(&pci_slot_mutex);
+
+	if (save)
+		return __pci_reset_bus(bus);
+	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
+}
+
+int pci_reset_bridge(struct pci_dev *bridge)
+{
+	return __pci_reset_bridge(bridge, true);
+}
+
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa0013..e537769cc3880 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -197,7 +197,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
-int __pci_reset_bus(struct pci_bus *bus);
+int pci_reset_bridge(struct pci_dev *dev);
=20
 struct pci_cap_saved_data {
 	u16		cap_nr;
--=20
2.47.3

