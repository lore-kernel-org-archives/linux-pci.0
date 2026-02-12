Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F6335067
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936091; cv=none; b=I9lbFizxv0dw6NYn914R3io1bnlf7G6K9Bhr6R74hQZzLsgR5AEgtTl2zXCmWqy5MZy4AQm4cFq1Q5zXigzSFnMWFcdENPin9pn3eY823NLQf1kKnQdO5dxIRrLe/Tu4qgInnfLJ69fDdymTN1FQEkcThU8JjX6eXvRTEH2uJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936091; c=relaxed/simple;
	bh=bOGaX/SlZW8OlwVJe5GdR4EJl6eywMScyiHZN8i4QVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGsOWx0eXzqEZn4Jz0YwjHhZzQ+48ZC66c6PpaAy6oHUeFb3VS8Il4l6gbcW1/ggA5d37UzMBwF047PyMq/wxi+7yZ9yEgOl3VREB0AdEGzgUiosg06iDE17AWyKxwcWonH/MASSw0EBrzaJwc9AN+xoxZhGA/O1+lsQzxa6oX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jUWf5z0W; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jUWf5z0W"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61CL6H0p3534862
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=as7XcEeIvEV80qYgsRrOpQZV1N+wMsCokCLkgzf3DCc=; b=jUWf5z0WSnWo
	wKiQkUZzgpWWQDJSDh9r8ULC7U0PR6Wi1b4KtNDdzfwtQypB437TvDKJlmrn9gEn
	koXAyCUeLgXMfhfZ2mHu3hZg3ouQ2YfYxyFfNpcuNSBZEg6RWUOu0SVuc9fw8Gez
	TytJtI4tnh9DIc/sO0v0848L7BJte6u26cP+D1LNGStyU8Opf+hrX8udBb0B7BBQ
	+SCqEGOYNpZZaZRYX3xv4SioQNgr02Efty7a2mq1IL5+vwb32MrIEnStRYywUiwD
	AvKk3pFtEeBnf4zaN5QGcAcdgXF2Rfr/SKNwkmhy7fCINXvMcWx7Bgiyzx9PXm4Q
	tvqNS6XVHg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c9pg1h0uk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:28 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 22:41:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AF5AF7AD50DD; Thu, 12 Feb 2026 14:41:13 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>, <alex@shazbot.org>,
        <dan.j.williams@intel.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 3/3] pci: make reset_subordinate hotplug safe
Date: Thu, 12 Feb 2026 14:41:12 -0800
Message-ID: <20260212224112.1913980-4-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: f9EPigOqQUJy2q2M-S8BCaiCLwRYtKhM
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=698e5718 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=ejDskD-KKpTUFPmLGuEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE3NSBTYWx0ZWRfXxLkEJhYjSygZ
 aVt9tjHOkKlJi+39N7Ul5u6koEKkvjRMMBfv5nu/6v6EMiM1ELmOpLWrkooc7tRFoqySgHb9O7H
 AS75njeSHEo8FKFYBY5rAYBI6d0Bkd2xg7mLpQM6R8BD1M3tb4E8ZD4mbMGrWctUZT2Qk+0FmT3
 jGenvXNbT26fF2/fZXWdkbPoCP9aBJJp/e3gXarsI0dESpVlbIamTXrMOtmZFYj7kv3k6G0j5B4
 4g5EHDSG3XnQ53ifrBwi5ew8X9aW8k2B1IbJkISN15hKenqBW6m/itgGf+ozyzxTibdevjrono4
 QaYVWGknGfxUCZSxv0HVlSf0EIp0zLmnwypWyCKX+mn8tVnFA6qcAx6uhVORsRnEg89CkagHoNp
 BUL+ht3Jn82njdjzX010vmlhAIB7UKmHq2SGGs0FXE6FMAwX/tZOets1AiaqqQqmOY0kaWZyNMX
 78xoP/1y7atp4WhYJow==
X-Proofpoint-GUID: f9EPigOqQUJy2q2M-S8BCaiCLwRYtKhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01

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
 drivers/pci/pci.c       | 86 +++++++++++++++++++++++++++--------------
 drivers/pci/pci.h       |  2 +-
 3 files changed, 60 insertions(+), 31 deletions(-)

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
index 5ab0b22dc7274..c535cd7f45013 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -54,6 +54,10 @@ unsigned int pci_pm_d3hot_delay;
=20
 static void pci_pme_list_scan(struct work_struct *work);
=20
+#define PCI_RESET_RESTORE true
+#define PCI_RESET_NO_RESTORE false
+static int pci_reset_bridge(struct pci_dev *bridge, bool restore);
+
 static LIST_HEAD(pci_pme_list);
 static DEFINE_MUTEX(pci_pme_list_mutex);
 static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
@@ -5600,36 +5604,10 @@ static int pci_bus_reset(struct pci_bus *bus, boo=
l probe)
 /**
  * pci_bus_error_reset - reset the bridge's subordinate bus
  * @bridge: The parent device that connects to the bus to reset
- *
- * This function will first try to reset the slots on this bus if the me=
thod is
- * available. If slot reset fails or is not available, this will fall ba=
ck to a
- * secondary bus reset.
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
+	return pci_reset_bridge(bridge, PCI_RESET_NO_RESTORE);
 }
=20
 /**
@@ -5650,7 +5628,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int pci_try_reset_bus(struct pci_bus *bus)
+static int pci_try_reset_bus(struct pci_bus *bus)
 {
 	int rc;
=20
@@ -5670,6 +5648,58 @@ int pci_try_reset_bus(struct pci_bus *bus)
 	return rc;
 }
=20
+/**
+ * pci_reset_bridge - reset a bridge's subordinate bus
+ * @bridge: bridge that connects to the bus to reset
+ * @restore: true if affected device states need to be restored after th=
e reset
+ *
+ * This function will first try to reset the slots on this bus if the me=
thod is
+ * available. If slot reset fails or is not available, this will fall ba=
ck to a
+ * secondary bus reset.
+ */
+static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
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
+		if (restore)
+			ret =3D pci_try_reset_slot(slot);
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
+	if (restore)
+		return pci_try_reset_bus(bus);
+	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
+}
+
+int pci_try_reset_bridge(struct pci_dev *bridge)
+{
+	return pci_reset_bridge(bridge, PCI_RESET_RESTORE);
+}
+
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

