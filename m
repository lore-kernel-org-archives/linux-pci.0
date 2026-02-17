Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6336C0CF
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344535; cv=none; b=GiyfJJwjgVGObh5MwwZlAxNv6tIT5Nr6SnjxqCg1/XoIZn1jmASLNJL7uqIgbCr3V3pfrb4joidynBqOVH0iXZafzQI/yHkHLpS7/3wA+gRfe5S8HJXbna958fbw4iNAXorGICVcqXCoowh2VDNOOjRxcXngEKHUPAGgm/0wsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344535; c=relaxed/simple;
	bh=jgDHUr3cr3inVo1HyulVq1ejvs211Lq2ujVKQzh6evM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/JeWAz4hUexbXMpvRvqTEXpNwl/ymqYlkT35Rzr7CzlxE7WWtBF7doAa2tIROHlBgomRT3UorNw3YyE1Q0NpXoVA7IXKf4z/sPzTk/DcoS+tEbM9qeM3AwQVfm4r3ui3huWU08as3Bz8UOi2xtZgXOJb8aLB0B7MsTl+MdPQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=k5XXVM0d; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="k5XXVM0d"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HC1aPK2053945
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xgXQ7cFfh0zjc5joR+GiffW1h+2SQFnjJA0jIXipN7E=; b=k5XXVM0dQU2g
	XxcH5Rp1O6r+cTRSLz2h6w5GEuqW0fRB9Uh9M/M3Q7+vRdlOboBWUwgKF/I3dEXe
	DdmROyEUy89biCB0mzbt2u4frg6qDHS7cDymkh+6BEnBy6imC2nyO/LP6Yo0IV5q
	EG4OQNV6rs5+ZqfHuWVuzi2/chV2ueNbYEmgXhgelnY9kXHsPlfhJcGRJHF72dbZ
	wLPVCnTuwRw+S7DNYM5b2iUctXhbMguQfIC/74ROa3UcWZJGFOZDS19DjMINvetv
	2k8x0PtQFk2k5nEMSOmbHxL6MU85do28mV4FdeOMOGcnk6f/cuL0Es4u0+3YfHAF
	iUf0QIGebQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ccgx2y55h-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:52 -0800 (PST)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Feb 2026 16:08:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5C6CB811FAF8; Tue, 17 Feb 2026 08:08:39 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <dan.j.williams@intel.com>
CC: <alex@shazbot.org>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 1/3] PCI: rename __pci_bus_reset and __pci_slot_reset
Date: Tue, 17 Feb 2026 08:08:34 -0800
Message-ID: <20260217160836.2709885-2-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: Q5LOxAxaqSBuhk17iOAVKQXDZ7qH6pnj
X-Proofpoint-GUID: Q5LOxAxaqSBuhk17iOAVKQXDZ7qH6pnj
X-Authority-Analysis: v=2.4 cv=QqhTHFyd c=1 sm=1 tr=0 ts=69949294 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=piTmfLtOH4KJcwlmKd4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzMSBTYWx0ZWRfX59BppKo9atlL
 pQGOy+ECjuI8wcXP+gobkl4weNU4Ajo4uWU6b4CkLda9Gl7hkD9vj/6BHsF/aPusTvqtmpxiqvm
 d4TjKMZzoune/sJ8Nz3ckJv2J8h3XKjDLCga/gy27cQlFA1s9vdk1mjUFOx5FEBBQY2I1Nrte7G
 MzmGOpirl2L3bFxC7unSZZz5OBdNb63hZq5x0OPbgE9v/H37oW/mGkrsRGRuIq89CGuR2Rxt1m3
 jgJUtLfxzW16hCUEoy4pvYZkTGAGNMPaCCE+fBpqIE/XGSysXvM6ravyO06HVfatov9kjDD0a4F
 rmrvPGoaBetUm3rxadU1AZLBAJZytB6QuxAUUs/fiOpVYaYooeI5CZliZZeLqcrWHR6rA3NpQlA
 OaQJF+91YRS68x72Jm/4VJ3ObOivzToddnwb3vfObFmNum6CXe7nRWYXGbh5SGKO9H9VWByM1rr
 Ziwz/+6OLjhf5Jr5qgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Make the code a little easier to navigate with more descriptive
function names. The two renamed functions here "try" to do to a reset,
so make that clear in the name to distinguish them from other similarly
named functions.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c |  2 +-
 drivers/pci/pci.c       | 10 +++++-----
 drivers/pci/pci.h       |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 363187ba4f56c..b44e884fd5372 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -563,7 +563,7 @@ static ssize_t reset_subordinate_store(struct device =
*dev,
 		return -EINVAL;
=20
 	if (val) {
-		int ret =3D __pci_reset_bus(bus);
+		int ret =3D pci_try_reset_bus(bus);
=20
 		if (ret)
 			return ret;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 06bb01b3bd6c4..3bd0a830872c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5541,7 +5541,7 @@ int pci_probe_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
=20
 /**
- * __pci_reset_slot - Try to reset a PCI slot
+ * pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
  *
  * A PCI bus may host multiple slots, each slot may support a reset mech=
anism
@@ -5555,7 +5555,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
-static int __pci_reset_slot(struct pci_slot *slot)
+static int pci_try_reset_slot(struct pci_slot *slot)
 {
 	int rc;
=20
@@ -5644,12 +5644,12 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
=20
 /**
- * __pci_reset_bus - Try to reset a PCI bus
+ * pci_try_reset_bus - Try to reset a PCI bus
  * @bus: top level PCI bus to reset
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int __pci_reset_bus(struct pci_bus *bus)
+int pci_try_reset_bus(struct pci_bus *bus)
 {
 	int rc;
=20
@@ -5678,7 +5678,7 @@ int __pci_reset_bus(struct pci_bus *bus)
 int pci_reset_bus(struct pci_dev *pdev)
 {
 	return (!pci_probe_reset_slot(pdev->slot)) ?
-	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
+	    pci_try_reset_slot(pdev->slot) : pci_try_reset_bus(pdev->bus);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
=20
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c8a0522e2e1f5..d1350d54b932d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -231,7 +231,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
-int __pci_reset_bus(struct pci_bus *bus);
+int pci_try_reset_bus(struct pci_bus *bus);
=20
 struct pci_cap_saved_data {
 	u16		cap_nr;
--=20
2.47.3

