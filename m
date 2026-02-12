Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F02C0F83
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936090; cv=none; b=HT0ie9BCVTkX2OkuWsOw6UCyoRVQa2b4pbt80SKOg0vgdPERiVxaxGKn0R/VdtMqFyVw9ZzX3dZAI/7I/HZBVc23AYA32qOaIG5I48HFfAT3gXP+b/k3zM40x2E0IXXrfu6zjkiAXhaeV1/4ghYV3VWtNILpAz6Lno5JZjqBOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936090; c=relaxed/simple;
	bh=pgJzfkNa2ryfW/85nK79HPLnJSfqKLcCmU7/YdA4y0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inMVcGVhxOvAnAQd9+3gq6TUcHG8twttwanWh7/h9NDNvLwNqPJrdiJPvmebrairhh/aldPlBNeEa1E2UOwJHOL5FdJCU8B9Peu+78g4obTGBP/QLTaUChU2RYmT2bVqkyHn7xcxeCWTxFM3kLYih+d/F7dzYNr2GOzgo5Qr9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Y+gN9tb9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y+gN9tb9"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CIx1vo367946
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xqwQuWaAkKU9ZmmPBcb9DrqGZmJZtKrJFTDXWftQZBs=; b=Y+gN9tb9jROT
	sfCLx04tH8poKrTwCogBAh9P5aiHAeTduP1d7igqn3uZjtIv8u5KLTPjWOds5mQ2
	5mM04LBOZzyW6xkNtZgK+4ga8z4UoCOAgB7Qohg3NTzLur6X++U4If09DbdzmJa8
	dND4EclAFwbpy1rgBW+pw7l7bVdUOblPuoiyJGjJMs9ll5s8M8i0ECPHelC7iAsa
	I6Tus1DJzx6ZHe3AClLVGUqcxw6TnJdSMcwsRt9jhz33SpKttULfn4ksofRXayHU
	bqHTOmsnlF9zmoh7TRhI1Xa08+U5+4uYg2CK0Bq5P06u0vHU+DNkiHcJTQehLJbh
	tgSumsztIQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c9mmcahdc-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:28 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 22:41:25 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AC7247AD50DB; Thu, 12 Feb 2026 14:41:13 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>, <alex@shazbot.org>,
        <dan.j.williams@intel.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 1/3] pci: rename __pci_bus_reset and __pci_slot_reset
Date: Thu, 12 Feb 2026 14:41:10 -0800
Message-ID: <20260212224112.1913980-2-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=QtVTHFyd c=1 sm=1 tr=0 ts=698e5718 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=piTmfLtOH4KJcwlmKd4A:9
X-Proofpoint-GUID: 1GboublzjiZjAwUSyCXDw7Zn4X6pEHVE
X-Proofpoint-ORIG-GUID: 1GboublzjiZjAwUSyCXDw7Zn4X6pEHVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE3NSBTYWx0ZWRfXxAOZXyUVCHIV
 3IvtoGbLlQ+V64xENsohcr8erGpzaKoHBxdmp0W7vxtNvVltaKLsh2VhEenTdkhl6ru6Ag23YOC
 X4S0HYlWAd0H9GSxJa8Fd6YpF4KHc1n+k8VzrPump1yWohB0op8csdCspkL1wbxcEpcQ7FpgesJ
 +jeKRYu7VsZS/Ud6MuETjbptfSysA5LyDOgrjJJ1BWmt5cNXmqPC+qnx0hRYNJTkJrNeQ6O6P36
 g9KNEaFneJ1JLDKUveKJs32XuvKsTf3+wbSQJLDFRg240Y1F+rjipspZNMkYeZ0QJvz+0QgKkkO
 a3ofhAp9YwSrxjq/E4gS68gwZ5idtKLc2ynHn+O25/jOXK9SSmS3FrEUTuvzny0NqHG3Da0Li57
 0yZdNcInJfCDoBfPONnFxHi+xbya7zEuOwXmdg2R3Gcq0gkLNXBSOZhuJ7SepB7LZv7RdR70+oJ
 +VepLB0dFWC1FS7zKVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01

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
index f3244630bfd05..5ab0b22dc7274 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5542,7 +5542,7 @@ int pci_probe_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
=20
 /**
- * __pci_reset_slot - Try to reset a PCI slot
+ * pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
  *
  * A PCI bus may host multiple slots, each slot may support a reset mech=
anism
@@ -5556,7 +5556,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
-static int __pci_reset_slot(struct pci_slot *slot)
+static int pci_try_reset_slot(struct pci_slot *slot)
 {
 	int rc;
=20
@@ -5645,12 +5645,12 @@ int pci_probe_reset_bus(struct pci_bus *bus)
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
@@ -5679,7 +5679,7 @@ int __pci_reset_bus(struct pci_bus *bus)
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

