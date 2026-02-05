Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD5330B3B
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326770; cv=none; b=pPSie6+bIndx2JD8kKbBt4NhR2TLsvkdLFNRxfk0vatObWIsDyvvAY125Yw3qr/CAcvMKKHrquCnGKHWLvOpAkoj6DfhSK1hJQaPbLByLNOVZAqXqRQHEnjNzAfgGF4dRKnoxnRt2Q9yxkjAiSH8g8IyheuHO+y8zr4gSqHaeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326770; c=relaxed/simple;
	bh=F0UnsJzUDxr49j3JuWF675M03CqrIDw+/8P3bEqJp1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+x4r2EZ9cAafW1Xl6nXQuQbqrPK7r6PyGGfyFa7TigeFIS6BwPYLf8DzRtHyYRFi8Zj/0W0H9ySm698mQiff96GBJRTAQU4T2Pz7mTdhcpMgDNUj9bGnuclr6R0zykY5J6z+woiw/q4DF5ufLzFhq93tybEyg9Cfv2YiJO7ra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LDEIhll3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LDEIhll3"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBUFM082580
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2026 13:26:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=lqUi4UsKsfoN9+YSJcgu5okJspYhsg4nd7i5pVngzWM=; b=LDEIhll3izfb
	nFEcux1fnLUthOdgVh5CD1V2aPgDTmIB2nyQnG5LEfrfS/33xXoM9zjnFfX1e59i
	mnMVO79rmRbCVaTE3FebC0tI00o5fB8+bUEts9ytOz2mSkThSG3nQkSpRdecoY6M
	KDbwc29Jd4v5L3DZ3u9gsfJC7whtM6rolKaOUefCnj17x83CAgpgzg4B8US0HHGa
	TZ4ioL5P9qas5EGiZcrCE2yI/E3D8ERshHhBg4yDCy5QUp5G4UWDg779VHtJomwz
	4wGFiLuya3ED4F+7cxXtrfirfcJjJrnEu+/WD1pGhfc2yTwBCO/nB9pcaZn+oyFr
	ZcvPTv988g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c504t2m0a-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 13:26:08 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 21:26:02 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4D36172EC9D2; Thu,  5 Feb 2026 13:25:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 4/4] pci: make reset_subordinate hotplug safe
Date: Thu, 5 Feb 2026 13:25:33 -0800
Message-ID: <20260205212533.1512153-5-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 8Vok6dV_qJ2_VwUS680HAVn6aEamKzsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfX7NQCFD5rdpMe
 I6JRu5QIIarOrYqyRVdSS1Tr9GuENqfxALa9gEl393/56AfpbqAbsCOC/IcQvbItCR+ryyMKUH0
 I5nx2DrEnUY3Z4WeP1oZaJqLVsFE3RRt4q0srynG37JTBY5v5+5m+6AITa3Rw/x1Crxkq7P1PcT
 crNzyb8Fu/gISUy2/DYhGc7d+jGJpV7Q3NvVssqUGWtfD6g/M9sWq3VdVwXFOaYZ32NHzNPIQkR
 pFl0nqha2LaZ0VmSvLpM4zLlbdu86C1m5g2X/RC4z0stx5/wcT6zG9hT2Dan9jNJKrGeSY6ApZl
 0qqDf12VAQFFWVQmJh7PlkymVelq5D5iepgubVKIfti4o+SfWBEfCzNCKqoSm3R1+Hv/TzcaCXt
 7SFAjKlZ/i/tVBtDvi2SrISpdh7+FCompSglMS8EAC1Mj6BDukqPv09Li/wwfoWrSBD7v9rkFeD
 6KnCE+8iAgJqZ4Gfk3g==
X-Proofpoint-GUID: 8Vok6dV_qJ2_VwUS680HAVn6aEamKzsD
X-Authority-Analysis: v=2.4 cv=XeyEDY55 c=1 sm=1 tr=0 ts=69850af0 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=2wUrPlsJMn_ct-MveNUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01

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
 drivers/pci/pci.c       | 71 ++++++++++++++++++++++++++++-------------
 drivers/pci/pci.h       |  2 +-
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2df915ad2d29..039d3dc157006 100644
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
+		int ret =3D pci_try_reset_bridge(pdev);
=20
 		if (ret)
 			return ret;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index df9ed73dad416..27817c6603a5c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -51,6 +51,10 @@ unsigned int pci_pm_d3hot_delay;
=20
 static void pci_pme_list_scan(struct work_struct *work);
=20
+#define PCI_SLOT_RESET_MASKED true
+#define PCI_SLOT_RESET_UNMASKED false
+static int pci_reset_bridge(struct pci_dev *bridge, bool save);
+
 static LIST_HEAD(pci_pme_list);
 static DEFINE_MUTEX(pci_pme_list_mutex);
 static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
@@ -5420,29 +5424,7 @@ static int pci_bus_reset(struct pci_bus *bus, bool=
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
+	return pci_reset_bridge(bridge, PCI_SLOT_RESET_UNMASKED);
 }
=20
 /**
@@ -5483,6 +5465,49 @@ static int pci_try_reset_bus(struct pci_bus *bus)
 	return rc;
 }
=20
+static int pci_reset_bridge(struct pci_dev *bridge, bool masked)
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
+		if (masked)
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
+	if (masked)
+		return pci_try_reset_bus(bus);
+	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
+}
+
+int pci_try_reset_bridge(struct pci_dev *bridge)
+{
+	return pci_reset_bridge(bridge, PCI_SLOT_RESET_MASKED);
+}
+
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa0013..790f2350b890c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -197,7 +197,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
-int __pci_reset_bus(struct pci_bus *bus);
+int pci_try_reset_bridge(struct pci_dev *dev);
=20
 struct pci_cap_saved_data {
 	u16		cap_nr;
--=20
2.47.3

