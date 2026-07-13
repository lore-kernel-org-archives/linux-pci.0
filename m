Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E57353A74
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978857; cv=none; b=lkaxaZuzj8oof9/xclZJ39gMLMa9lyLSYANRgjR0qy4H5/J7wHErqS3/c0pbcP3fexzp21fhx2kAqRQDnA07W0tYXNZc6Ib27d6Mp/jtpqAe1b2gZg6Z6gl+qE/9vIcteT6PFlIoyu1gfRYF9gEAY+E10np2aO4Es9KheIDhUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978857; c=relaxed/simple;
	bh=+pxD5k7mIuoIfPyIAdkRZhf8dNXAZs1a8TEGYu19aSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gl246nd0GMMCqqIlUYH/PrS06EHX07c4zYkmXy2Gf4HLb9IIOW3aDmy8bhKDAm36iIaPr8W/IeVnzGcJFpQs/8rlTdms/1OB3ru1/+Xmc/6Utm6oK9mzRmsSbZKxQCyyO0dd04lV2otgpqhhcIne34/hK/2aq4bvXJA+j9CrKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bJLRzCw/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bJLRzCw/"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJBYnS3208082
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 14:40:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=e/Qd4NYOi1yVYkgD50
	jVlqte4xmtaIr5xmOMJIUWSBU=; b=bJLRzCw/5kmvggnfNZ7GZGShBTjZ5+XUTM
	R3fdc1odRaFD6iwGDM8aD6/yFJP72XmKiWVipU9TjZ92a3shsTLbvExFOx3mYWpJ
	z41Vq0FRQ/9FJjFO4jwFsGguN1mpJ7hC84UlTsrl2a2TafV9E9UXpnVplfOrvjO3
	5jBgemVwADJURFGHCl/YUg8mAlZI+GVnBTEmG22WiennCtsS5aALhquQbsqN4JJW
	G+sfxpSv4FNSkENTrYRw/ImfMRD0YvkRuvX2YrOwJTvo4ZN1rE2IgRXD4utj4f1y
	5SZdiq409SfR1exzzzzbozm9xUZMw1Bwa3d51w/1zMKMFyHBlFjg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fbjx6c4h1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 14:40:55 -0700 (PDT)
Received: from twshared10463.03.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 13 Jul 2026 21:40:54 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 54AC441FE14FD; Mon, 13 Jul 2026 14:40:30 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1] PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
Date: Mon, 13 Jul 2026 14:40:25 -0700
Message-ID: <20260713214026.793795-1-zhipingz@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyMiBTYWx0ZWRfX72H9IHwJpYey
 2iEbyWtefS/gUMQBW3TQ/cp/7/MHkGUP2slGdv1tJxpNNGsIYjeAiAVXrCbhIYof9W46uZ+Obik
 nxxZ4orcL977PpAIIsrs0nzAgxa6g6M=
X-Proofpoint-GUID: G_q27O78crrPxgtAoULY0PhQup0dgrRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyMiBTYWx0ZWRfXyEol3LUHxe4G
 uzDtSfPHTtFOwPx3bRash3Xl/5xB3RuLUIMk/wrh+90/pdItoQDnk0s/cH++kM2hOvawOaj/bRZ
 diwLKmtq0/FOzGNybpaV98gHmp8beJnBC3VjspIkTjNkTwpT+OKgI2BWh3fY13QTftuwGJcvHN+
 SD2w9fjjAnmJqVKp5d5uWfyYZ+ArtXWG0depJTL8LIzbUfSSoMomo+n1RjHcne0e2s5Ib2DrtTg
 gOHnDwnFPkDv2CNXxA9zDqg3Yy/Wscv29md/m3PAkaGnN/IDoFTBdf+Nz/Cp0Y6W0veKU1hIkD9
 GnX0IvRSjs+73BZ3pAd7faJoAenS7ewZ/uCaXNIJXF48JA1q12hbuXMrRStQBlOVHFOvkJNJ8LD
 UdHV5wGMi/GH6iG4aYBwNp1nKu0IsIfqMOkp0M03VJVCF7Dd/CqmkWmiPkPo+ZOiEprEKVx/TZa
 vcJhcgnX6+viXuJtIHQ==
X-Proofpoint-ORIG-GUID: G_q27O78crrPxgtAoULY0PhQup0dgrRe
X-Authority-Analysis: v=2.4 cv=cLTQdFeN c=1 sm=1 tr=0 ts=6a555b67 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8 a=SdC2vBNBQt3qShdCGKMA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01

get_rp_completer_type() returns the Root Port's "TPH Completer
Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
into the requester type:

	pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);

and later writes tph_req_type to the TPH Requester Enable field, which
only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
If a Root Port ever presents the reserved 0b10, that value could be
written back to hardware, risking undefined behavior.

Fold the reserved encoding into "not supported" so only the three
defined values can propagate.

Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..28c8d6676fc2 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -196,7 +196,14 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_size);
=20
-/* Return device's Root Port completer capability */
+/*
+ * Return device's Root Port completer capability.
+ *
+ * The "TPH Completer Supported" field (bits 13:12 of Device Capabilitie=
s 2)
+ * has a reserved 0b10 encoding. Fold it into "not supported" so only th=
e
+ * three defined values can propagate into pdev->tph_req_type via the mi=
n()
+ * in pcie_enable_tph().
+ */
 static u8 get_rp_completer_type(struct pci_dev *pdev)
 {
 	struct pci_dev *rp;
@@ -211,7 +218,14 @@ static u8 get_rp_completer_type(struct pci_dev *pdev=
)
 	if (ret)
 		return 0;
=20
-	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
+	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
+		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
+	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
+		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;
+	default:
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	}
 }
=20
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
--=20
2.53.0-Meta

