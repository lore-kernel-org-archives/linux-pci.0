Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57461F151C
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784022; cv=none; b=tFbpm6NylDqAcT5YCl7sdxl6xYCM2uSB98BPSuQuROLV4TZft/Frlt/TLefnC7QnWgGCIYHuNs9GYXM8DPixYGxIni8rmkj8G1wSmL4JfX3v0yO46SYCm/6jc6xJAgbuPbUSNeY+zew/b5rToJslMvi2hhpMwqDWNHb4D844AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784022; c=relaxed/simple;
	bh=Mrqz7m6HpU9WRPFXdfRfHEnd/B/hJ3bdwROvofyVG08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QtvDQbdoS9GVvhFAidbFr3pD7i/rbyMaquU+bUuXhRhKm/FeDapjeg716NrR93e1ktzsD9gggZmWLoHlLO7868Hz3H4KL2mfdr03v7uLp3CfVXSczRfwV1r2CK9+9VP68oFDtyToO0/YoWPxtEyKOq/paAGAH5qq3Wyyw+dYtZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DSKFuqQQ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DSKFuqQQ"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KNHf8F3578630
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 08:06:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=fGbXtufI6dAfRa73Au
	T+VnwGEzi3Mz3C6hkyTHXXSlw=; b=DSKFuqQQuAfcJBxSUTgiJTJv4U10gl8KrW
	mz2Kk5AGiUgW109K85kw/pGInS08iR/z4WF1EjbR0CJ7G3hF1jHIInh1hPqN/m3n
	znfkMavyLwRQXDABNnGNZ/cyUwTiyOzVaEgDVstak9VWPkMhu/yaDWQaA8L4RV8z
	O4VkWU3H6hR3n0Tj3ko6v4tywZE+JsVEKEgS2V3P89nhtxQk3iEUTkQ4BZiHqimL
	PvPQjxpr7FCpPit1om7DGtXPQF3u6FIv6mQ2BgNkr1MtjIhZ0auBDoY3GficE8gO
	+xBZmO7KF2bO239gH4rd9tYe+L5V2vgAPvLFBNvXTcS4au4ArswQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm7fb0p9f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 08:06:59 -0700 (PDT)
Received: from twshared22734.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 21 Apr 2026 15:06:58 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4966612B01994; Tue, 21 Apr 2026 08:06:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] pci: don't fallback to bus reset after failed slot reset
Date: Tue, 21 Apr 2026 08:06:44 -0700
Message-ID: <20260421150644.3543733-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1MSBTYWx0ZWRfX9RCNQFrx+pgL
 aeKMWW/cO4P2H0jrMTwNlcldP+rN6IcVVqFRk2q+v+CDCpyGk6workBEaHsXHghVaDpaMF4hjxT
 50a1wGNz8UZBbDh+FagFF6ubA/TKNItTPSJRmZ9QnYxqNF4ys//kMSe6j2JibDJXO729ucRc57U
 jrsmIL4gpKN+mTeWf93rI+06qjlH9ua7x1Wj+xpwKmEs+7LjQpECzjJlVaF5GLr/Q3s7otY0psC
 m3qY4+RY1r1LMwMNquD8/r10dd/MDn4Jd1VNWy3ryXanmfcHw3VtKqsWALKMs+/ku6XXLuyGZlF
 Ewch//vgWgzpkszIJVC8Zay8LP0vowu0ZEH1YV6MVMtA3CvdFjjsUUGLoquKKnK7cmvuwQoOs9S
 LAdTMKvOGEA1f2mNi7YWqj3KnTxpSzjI0vnSBr2t/7AnWNVQEH8C6ZZkOEYTWNVCGZizzx3Y47n
 pXDNc0uaziiPcJ/Mz4A==
X-Proofpoint-ORIG-GUID: Pki7irbW3f4vn3khCIchefv4YTOsqEYI
X-Authority-Analysis: v=2.4 cv=VevH+lp9 c=1 sm=1 tr=0 ts=69e79293 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=XL7pVx86RMmQbKPDkIYA:9
X-Proofpoint-GUID: Pki7irbW3f4vn3khCIchefv4YTOsqEYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

If a bus has hotplug slots that implement the slot's reset_slot
callback, it is not safe to do the non-slot specific bus reset, so don't
fallback to it. If a slot reset does fail, the subsequent bus reset will
attempt a 2nd link reset on top of previous and fail to handle the
hotplug events.

Fixes: 8238cb69c01fe ("PCI: Make reset_subordinate hotplug safe")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc000901..d34266651ad09 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5607,13 +5607,14 @@ static int pci_try_reset_bus(struct pci_bus *bus)
  *           reset for affected devices
  *
  * This function will first try to reset the slots on this bus if the me=
thod is
- * available. If slot reset fails or is not available, this will fall ba=
ck to a
+ * available. If slot reset is not available, this will fall back to a
  * secondary bus reset.
  */
 static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
 {
 	struct pci_bus *bus =3D bridge->subordinate;
 	struct pci_slot *slot;
+	int ret =3D 0;
=20
 	if (!bus)
 		return -ENOTTY;
@@ -5627,19 +5628,17 @@ static int pci_reset_bridge(struct pci_dev *bridg=
e, bool restore)
 			goto bus_reset;
=20
 	list_for_each_entry(slot, &bus->slots, list) {
-		int ret;
-
 		if (restore)
 			ret =3D pci_try_reset_slot(slot);
 		else
 			ret =3D pci_slot_reset(slot, PCI_RESET_DO_RESET);
=20
 		if (ret)
-			goto bus_reset;
+			break;
 	}
=20
 	mutex_unlock(&pci_slot_mutex);
-	return 0;
+	return ret;
 bus_reset:
 	mutex_unlock(&pci_slot_mutex);
=20
--=20
2.52.0

