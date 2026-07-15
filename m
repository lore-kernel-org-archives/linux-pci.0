Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31309446C10
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784147072; cv=none; b=hHVo0fGEDnCc2wXzneb4LmrlXF7Q0mNu1W/nUFXkMiXQpNCVymMVQg08mXzzalyfpkoJ9KMoVbh5+zvWT6862Wp/KFPwWADgpkaEsKrTu+JA+Mxc/dBRFiLmGgt841Knaj4kBtJjTEg/UCslYYDvoRptL15tIsZPQ/O5L+KQElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784147072; c=relaxed/simple;
	bh=qXxZygeDGdb3Cs9hUiCNFUaBdU7ZPIfK3IGwww4NFHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f2o8kFWHC1DJZl4j9p+9krj6cUtjxnskgNq13bqHq9xqYD2/kH/tCbLEhOM6ZQtUvLFmKgp0n+wS+Q7LPuN93LZ8cHbnHphSRa97mh27GZw8B9ss4Jiy4HBVdZRn/VGk4sSJu465Ar45IMMVCEv815ag//b7OUbUXwBVgb0917M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MQtn3OOy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MQtn3OOy"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FHVsQF665775
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:24:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=SosxtXEwaaPBi9Pj+I
	05e19Wzb4ZSsibxfiyJFLTTpg=; b=MQtn3OOyL6+CkLkdzcRMOvjnVRP61i1iFh
	bHNMWVGeycjLbSnm4u0vbXWRGIdNwESOzoIaayChii9gwagQLD3l0A09AT25gnMw
	YBHZdq07k98DQFkYdSM6DRcFpFkwAfR46WPMIyWF396BDYus+XAilIszoryDqIqU
	4eMXTc0tBdKzJY+BGZ82NlSP2wwkkv0lI4jSZAThlyVJXPomqoe/mHwo0VGAz8gW
	llEcw8xNEkeBvfueQowfqGdjgTVD4lstlz2FOCDB8TSrSuVFA3+9A8uld60gapqD
	RjGLUb2Z9+W7Y90mdO6aBHC2V0m+DpK8eYf1teeNE9Gfp0etqcmA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fdn02jm7r-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:24:30 -0700 (PDT)
Received: from twshared19691.04.snb1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 15 Jul 2026 20:24:27 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 8CC1A423A594F; Wed, 15 Jul 2026 13:24:10 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v2] PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
Date: Wed, 15 Jul 2026 13:24:00 -0700
Message-ID: <20260715202409.3767494-1-zhipingz@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIwMiBTYWx0ZWRfX0Tq/rUVttUXk
 QCrp8zbYYPdn+RZT/PPFgQdNbj6c4uFnd3S/jvYeYIlt9EpNSWCqKorW9ElqgBliUhe3VI1oa9T
 NUhjsGE/l/JKW7mbV2NyuWGd831OfEzEXqJ3MB/IXLrWvbkOT2XBInYZzdEA53DiGmxnbboxI0Z
 EZSOFDwl+MCoj4zSSJokiwEfs1H9cgXJifeO3HVoufbwjtdxUCVg5NWQ0rX9J3XopdZXc6aaJdz
 vaFrNmFeeKh0SzbOod8/QQpGGSB4H/yhtP1e9r33Zo+VkPlXtNk8vDE0yZsZ39cxMb4Cq7us61U
 LuNgZ7IY9ZF9IQhx3ffNexeQcRre8LSoSTmd+j6nO4DPnMF/1qfjTAh8rkl5mEhX1/yD+wEBF9e
 Ppmwc8q3mX3AQ3guvzxwKlnYw1BQ8Dyuk9Vwh7eov6KPrA2jCTvTxlbvzasbN/gOi/jT7pkLTEL
 ZNq39VD2BJS3mWoR34A==
X-Authority-Analysis: v=2.4 cv=O+kJeh9W c=1 sm=1 tr=0 ts=6a57ec7e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=10P_XigQlVKDyM0i7pYA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIwMiBTYWx0ZWRfXwAxho7tvccrL
 wWo76kdIhYi4cMzfRsCHvqhaQCIWU99q7YmPwTotr0pKVEJ2UoqrClM8HILdapvlHjYWoGLpe+X
 Kn27bTOtbAzayFY4tZ14Er30H+FNdLA=
X-Proofpoint-ORIG-GUID: SRPit2s2jG2N749apXrv6NDh10idC7Wq
X-Proofpoint-GUID: SRPit2s2jG2N749apXrv6NDh10idC7Wq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01

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
 drivers/pci/tph.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..ebe1aa5ba5eb 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -196,6 +196,21 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_size);
=20
+/*
+ * Fold the reserved 0b10 "TPH Completer Supported" encoding into
+ * "not supported" so only the three defined values propagate.
+ */
+static u8 tph_completer_type_fold(u8 comp)
+{
+	switch (comp) {
+	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
+	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
+		return comp;
+	default:
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	}
+}
+
 /* Return device's Root Port completer capability */
 static u8 get_rp_completer_type(struct pci_dev *pdev)
 {
@@ -211,7 +226,8 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	if (ret)
 		return 0;
=20
-	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	return tph_completer_type_fold(FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK,
+						 reg));
 }
=20
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
--=20
2.53.0-Meta

