Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324A34F27B
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777678; cv=none; b=T+C1PIKPaUkD+m03SG6xHWBe+31Vcew3aVHcO+9AMuy/T9Zg/vaD1Bc9aU/T0AeElE9eUjPhHMJVE3FZIr+xe3hTobovgVkInovALtVAsVH+sjMig1McubMfreUc+mM21z1OKuCBMxBhF34+cnuzVsGrSI3pBnSEAciu8YyV5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777678; c=relaxed/simple;
	bh=1SZtk/6itkk7jnoids8+nobTa+90ATFJ3nBExnhk4jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q7i9s4jn0mlX5JveO0wh9GdLayyKXrQDG3QJc/LhjhfjcYFGbfOmn3dHDdlzQMui57H/jkwBOaST2cJpUMhlkSi8zcg7xXXG+75wunrPd4mcuUkr5dxscJo1xm5sofYSSFPvNhwt07+VMboqilauZidN75E7DQVROZOOF+LoLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JokoA5If; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPSll//J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JokoA5If";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPSll//J"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0X5892538606
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 03:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qbfAd5hooSeWEDkAzv9Kct
	PdQQKDZzzw8NU4r55EwsA=; b=JokoA5IfRCRtMqT5mgv5U5mKPWhxvJRyhLZtvO
	D8U+2vsZUXih25i0DjCdUPdBnQBbVLWvT5zcYzRLW6aiBJoUZkwpehZAPuljuqkX
	Cz47te+YnB5K/2T/o0eh+1dn53Dz4D7HZgsSIi0ir0dSiz/JhRdui8Vg+r2rDxMe
	2HW2ij5HSNEKNJwucC0VIaMTrsg1sBaj40IPR0n7Z+gYpb1bC8Bxn5LTeuH5IiAV
	3WqS+Wc52NMmOpT/83AE/FEHEdrH5dgo/PCPnGU3HiI1T5/qyZ9dzJgbaVl3smjj
	V/lXWNIb8ANQpDJIowXYdQQN5yLzfSQe36E0JAxxlHG1k/mw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc16q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 03:34:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ced1ed870fso1372405ad.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784777669; x=1785382469; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qbfAd5hooSeWEDkAzv9KctPdQQKDZzzw8NU4r55EwsA=;
        b=JPSll//JaN5ncVcV2HEVIWD+dMCOoVilxHpejb/ti2uWqybx+om/0uuuuSfmC+iuzh
         mSP7wWavPogcUcNGVBwyMC3dVcJRkqYff/3KLpW5LPEgg/Do7+EEKITqe4ApxSZ8aCQT
         I9LxgmYRQPLEBRBnhRTNtilf0uQ1997ek8CTOgLs0nSE4ePkY+Bghanx5pxoa5Ux7xjL
         /GR/KOCzWi63j6AeeCqYQ7PniykPKMqmEJ0KiW2D/9FQynfEPK7H09TrFRxxfvQ1Ns/v
         El/7uX666wTnl615oUrvoHxKtM3dagjOuS+0iFgbd4/1b2GC3AtcrIdmFvMsySultDd6
         7KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777669; x=1785382469;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qbfAd5hooSeWEDkAzv9KctPdQQKDZzzw8NU4r55EwsA=;
        b=lU5ZwiQrMoSwEkL0X4N9wRdazRdwJ6N3xvFngUCR8ksR2bs7iNhdhz7jydYVRJunws
         3NMjvuh8NilL3lRlc+ftPK34bF6gVAIDQAmWExOtDcSPP9cFhm5lW3Pssj/u+IwXBMMy
         XYgE5CVsCOEcRtEe/INuN0jSc5ffwnj7zhxOe/hzz94hePdxzI53ZBi9aOZZMdmdVeo+
         mxwvMmbKTwUPGhf8eS8o8o0ojp5AlynKiKqwzRhnpvKVGoI9UwfoRHcZ3oE13DadHhPK
         7zBtcN3wNwXy4VlI+C/luiKgrpbnAbVgcg0p1CNSeERPsQGVwy4hx5C6X3RB/ELsBGWA
         zFmg==
X-Gm-Message-State: AOJu0YxxyJMDMPXGXmL/WHaNIsgQWNzz/WWgs5GjBvQyJrta0XeEFZOe
	iup7N3lSBDqrkeV6aUErzWu9c6P1NuxXcPnUu153iO9jt/pk15UcJdVMMCPC9Di0XbKdvc5dvVn
	LDIpbiehyZmNNHbV4y+Uid/JD29HvNd/rGqrzSwIgIp7CWbRc3rTEETSBpL0qFOJuETCHEu0=
X-Gm-Gg: AR+sD12x5NjPuk+M/t8akMAnQ82aZGQVxAR6unj3ah/7qdcjg082NdGGBGVpcVNlkJx
	WwZNWgdrw8q6AGoNoNFGaLdMKljhY3B6Q7Ujsd0lkwAZxmeYjvVbeIL/pHaszg/m3ZINcx8f+Wm
	WpnjHfK3cYeLhFf1lS94oZmP/qttLS26UAd0pgW38Z/MXHe6Fe+e4puBullxBsauS8QFY13cKBW
	13wWP9VuXNCEzjq7Nr381bOmC4EmVf/Me58aHhNQdeKulk9CaDTtKoYaNQuAWEOsLJyrt4Zj/rF
	7blD8xGvT5nm0BBxDV4tc0OCdhKjtmS7cK6UpbFlvaxUBSVjdoi7lRH0kuwEyUsTDiAHs/Wxkl8
	M6k7d5vw+ydlwFQX2kYbeeDI9crTj/tjNL+T3ct+16MgNqZMP5sI=
X-Received: by 2002:a17:902:d550:b0:2ca:d9ec:3217 with SMTP id d9443c01a7336-2cfa71d94camr13095265ad.7.1784777669215;
        Wed, 22 Jul 2026 20:34:29 -0700 (PDT)
X-Received: by 2002:a17:902:d550:b0:2ca:d9ec:3217 with SMTP id d9443c01a7336-2cfa71d94camr13095145ad.7.1784777668768;
        Wed, 22 Jul 2026 20:34:28 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e088d3fsm14776028eec.25.2026.07.22.20.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:34:28 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 09:04:24 +0530
Subject: [PATCH v2] power: sequencing: pcie-m2: Match WCN6855 and WCN7851
 UART BT variants by subdevice ID
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260723-hamoa-m2-sub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL+LYWoC/x2MywqAIBAAf0X23IJsT/qV6GC21R7UUIog/Pek4
 zDMvJA4CicY1QuRb0kSfAGqFNjD+J1R1sJAmjrdU42HccGgI0zXUhzehNvQNdpYakmvUMIz8ib
 PP53mnD86QXk+ZAAAAA==
X-Change-ID: 20260723-hamoa-m2-sub-id-v2-f8640ac2520d
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: dM2urbOWM11mjjX7zC80YFfIR2drD3j7
X-Proofpoint-GUID: dM2urbOWM11mjjX7zC80YFfIR2drD3j7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAzMyBTYWx0ZWRfX1Hj3dHS94h5y
 0J6/H/zrgWgdumxQsL59pMsSekxUDAxv4YxFgFEB4sZuHdifIjpse2Aez8a3iYotiiNhnuWEQqI
 NDuhUCBeelEgUDKBmQHIAsisRSoQCuc=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a618bcb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=718rDa6z-us7KMpumiEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAzMyBTYWx0ZWRfX5N1hGwGak7lh
 N/iK14jcnPyHzcWLwYjPX7olQBybHgiZCR5QGtVROz3jBSW390FoNRLx5HwI4vwULSULPVyCt/x
 4HUz6Slt670h5dB9KFR89yOwXZcDIrO1tA2N7sR244vBeVnRmKANyCALIAlmV/2py61OW6584DN
 M5JAZHowpPvW7/O4D8lL3QioyvpvTgCt1uiT4OPoZtKcARvQBIJk25mi5B4N1boNbcy9bHW/YkK
 EvBisvtThV/hEWWbOrfh9Okx+PlwU8XHJpchJ9ULMhVT2p9ycO6QO+kpSTLj/etlQms3lYmc9jP
 lYmvKdOYxYPAKEmVeoq7DxKmZ1IP7mYTP1+9quTl1Q7PiW4r9jYo2WtsnzZQYeOQufwB7ETtGBi
 K9DgSlOjOIuUF6O4FLs8n5FdFCD7xrECKGMSiaTuN2OQY3/bCuKrNtPvmwXulXVBb3wdHUx3u65
 fFMAkned7MZaVUZ3nBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230033

The WCN6855 and WCN7851 combo chips are available in M.2 card variants
that differ by their BT interface: some expose BT over UART while others
expose BT over USB. Both variants use the same PCIe device ID for the
WiFi interface, distinguished only by their sub-system device ID.

The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
USB variants hit the same table entry and trigger UART serdev creation.
For USB variants this is wrong — there is no UART BT interface on such
a card, and the serdev probe will fail.

Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
their respective sub-system IDs, so USB variants no longer trigger
UART serdev creation.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
Changes in v2:
- Send this patch independently, at Bartosz's request.
- Update commit message.
- Collect Reviewed-by: Manivannan Sadhasivam.

Link: https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com/
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 26f695b98d2b..5dfc9f9ef64f 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -192,9 +192,11 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
 	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe105),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
 	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },

---
base-commit: 162ea02941a936f8899f3dbe10607b1d5af1b07b
change-id: 20260723-hamoa-m2-sub-id-v2-f8640ac2520d

Best regards,
-- 
Wei Deng <wei.deng@oss.qualcomm.com>

