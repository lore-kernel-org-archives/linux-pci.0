Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F081330B3B
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326764; cv=none; b=iKcnb9xqxvvSGYqqZ0sqEh5Qiri5l6e3FQY3mN0A+OazWv7j4NdgjP4oHgIyiNWXaauMQy8QoGBDuBXrZHcZp+MPRH+nanNyS74htgG6ttvFatjzFygzwWDu8xi8JeHxJVNv4mS30d8fmbI9jWwP6p4NhyKGAFBm/F4l0QT0Lyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326764; c=relaxed/simple;
	bh=zAuuuDAfOmo+IuWHKBifeaU2hQGEpwMhsWGN5usV06Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maEJC0l8UQAhyXHH3V3K+SjoGj6BgsAZs1G/AYvO3vHSmk3vHMNL52yevyj4E4O75KZ9uyGD4xSysl7GlugLEgp5gZssbpaA3/H7VIB2s7x2eK2pLMFzzaiZIzol0nVrVT+C5CWy/4Q1ypswlXYkY9WVZeo2p8uXyAVGhTRMeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=c35HAsHd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="c35HAsHd"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBUFA082580
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2026 13:26:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dGHzdSHrYJuius4mOzcV7H7uRoXZaMVU0tAfoTmIR+Q=; b=c35HAsHdg40b
	vKYUZAdctdLPwYTcMbZeBKxd5Yw9AuU2obyElHQOlpHFWW+5Jvny3MBZ9Gv/kGr+
	C7nnQFoSNqJt8bvCouupqW280sRWY63n+Hy5ZJOhvjDRw/LS7kf7FLN2o4i2k4iQ
	qVRfK2WjBj/Fz+1vhPnx3oSxce5s/XVaiNpXJTtAR/2It1vdmzn2HmxOYjjC30rL
	OpJvjUbPqY0UA0m/OLGW63DmhOn/J23ZSJ+dIjO2icO8f+ncmJsPZx6+Q7bwUlSb
	1isgV5Eih6gOmx5zdh/XoTo+jaZqa5gCz2tAioL2exD4S7SROdbQ2evuQdBJN91E
	uQXw4MXHCg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c504t2m0a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 13:26:02 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 21:26:01 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 31D8772EC9CD; Thu,  5 Feb 2026 13:25:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 1/4] pci: rename __pci_bus_reset and __pci_slot_reset
Date: Thu, 5 Feb 2026 13:25:30 -0800
Message-ID: <20260205212533.1512153-2-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: xcAXxAfVlg7sxeLZVY0E48gVNE6ywAl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfX5ySgto+ycJLT
 8vvGZEM6uffJ9X8LH/2z+p96MjBDYeC/2kJEJf6030lbJgHKaUncCVRts1Wl4+0Ib7CXCienPFz
 U1tB/h4fWEVnqLCIohc3FRisFbQKUKsmJMST7w3lCcfNNgal1akezfHzrBm0ueI3yEF2+s10/9d
 7Eb4MDmXMEUpkmwGYjRmtuAjx5+fJOfcAdAy1Kr2OYtTdhQAoaA0kzkma2dcMys7LxCyHeGDBlT
 H5WlxPIqq5M0aMU7mDq1Ys53yxOapLGyEAkRtd8wAICMoD/zVVFhc0r/MFybx5iE0eVUTiCM3af
 5mwb51yhinxyqCILshOl2jJCQznLO7U8iJShJlSyGRD4OMjGRy4r2X0o78nYr/bAOnsIi0eSOJN
 AQ0rUBTErTAK+JKxMeLamr98zAiTcfsNE45Hb46XF4xhUoQbBewJWsXNFuu54HN1/67j1MKABc6
 azEDpb1+LjR99Y4w0yQ==
X-Proofpoint-GUID: xcAXxAfVlg7sxeLZVY0E48gVNE6ywAl4
X-Authority-Analysis: v=2.4 cv=XeyEDY55 c=1 sm=1 tr=0 ts=69850aea cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=Ez9eg-EiDgDVB8ixmDoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Make the code a little easier to navigate with more descriptive
function names. The two renamed functions here "try" to do to a reset,
so make that clear in the name to distinguish them from other similarly
named functions.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 57a5b205175f1..e00af20ea7376 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5480,7 +5480,7 @@ int pci_probe_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
=20
 /**
- * __pci_reset_slot - Try to reset a PCI slot
+ * pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
  *
  * A PCI bus may host multiple slots, each slot may support a reset mech=
anism
@@ -5494,7 +5494,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
-static int __pci_reset_slot(struct pci_slot *slot)
+static int pci_try_reset_slot(struct pci_slot *slot)
 {
 	int rc;
=20
@@ -5583,12 +5583,12 @@ int pci_probe_reset_bus(struct pci_bus *bus)
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
+static int pci_try_reset_bus(struct pci_bus *bus)
 {
 	int rc;
=20
@@ -5617,7 +5617,7 @@ int __pci_reset_bus(struct pci_bus *bus)
 int pci_reset_bus(struct pci_dev *pdev)
 {
 	return (!pci_probe_reset_slot(pdev->slot)) ?
-	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
+	    pci_try_reset_slot(pdev->slot) : pci_try_reset_bus(pdev->bus);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
=20
--=20
2.47.3

