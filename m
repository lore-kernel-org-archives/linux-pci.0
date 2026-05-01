Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A63DCD91
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653908; cv=none; b=nMCdeJiXxgxnyodQfhI71RhMX2Cvh8k9/pCFOUM+hC054fkmosXYVTSrg7Bo8tiGTMC1l+KNzAcEOsKm+7WjQyBW8Mvhclmzf5FUoLUUS0LDef8NL+ui7YsqqgqAMzjSgIFM5ffemorh+pyaawhWFZS1GNMZxVwwqN1Hfc7x36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653908; c=relaxed/simple;
	bh=uRYbDRH3yFsoIBX5PA7y9pIJOKmzwquRTW6CKNMr1qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JReiuY75btePwjQU7yHoXUu1WKg3ClaK4DodjyxXY5on4UZaBJC9Tmjzu6zmU3a8yKOkzfSLhaepltY8l7dAdk/iGiZWxN8XedPv6kjKsn8H06aIempvAtaDLLhTP74BqsKsE6hKp2m1sOxisM4zk9Pg5LkncZpDMt2f/qV5Kro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mEFrc4JA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CXh85Y/O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mEFrc4JA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CXh85Y/O"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641GLmgw987856
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2026 16:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8qj7MfPHqU6avruC9ARP/wMLmeEJWmwTvqg
	Stsue6h4=; b=mEFrc4JAbHWE8b57adrdlM8UFAifD+vBOf6YWboeeig/z4bqgDg
	s/6k96pdgJSf3cAGRUCFk622UxgxSa55TadJBhaghWszYakciwkL4JGSklD3h/B2
	adSsEKgmBB9qEl6i0WxN4lPuo1poyoFclak/k8dQdZL1jeFGRdJmH1U9pObIdGP/
	me5zrhlgxlaj7NporLUWP+e//Hu9dStB8DcP3nx2giZw1hAMJ+M1SC9VfF5WoeWM
	AtgXhExGt2hxwN9Pxjo1cAvD/5EQBBXbN37ZP1hkrFc7T7rE2qwsBVSWtdFTYza5
	f0lPChEGyeu6c2h8F+f6QdXGpjvwXv69ZjA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvjhst13y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 16:44:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f504f6b75so1166011b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777653898; x=1778258698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qj7MfPHqU6avruC9ARP/wMLmeEJWmwTvqgStsue6h4=;
        b=CXh85Y/Oc2cvSACGgpd8/2keoen4G1BdaZzGIC75AKlZ3MTviiWcu5WsjczEqT17Rd
         dhYOGrbh+4uZOTOfAiqYYUlQ1O14NEYCaoMMwyTmBhj7qLa72qry+sA4iCTy1Fy/uFTY
         oGI1L+vyOMjCqZfyrzld0EVC16qZgT5Ibfv6QnsybuM8oNn6q2UDysYyj9tA8adc/f8o
         e/fdvLH20QefF58HMB4vtmVVokAN4gOEv/f+AUX21JnxBCsIt1K3CQdpKO3xc3AMs7bV
         S+lt2EExRQlbN9Cd5J2+wCNTaFvbI2/nTBMo/lUs0+GG7pAFo7jeoLaIUsB9dxMMAKk0
         Vp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777653898; x=1778258698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qj7MfPHqU6avruC9ARP/wMLmeEJWmwTvqgStsue6h4=;
        b=ga1EWZrSPqfwESvJ8wdrH9DQqhjQbgj9nG3QYQg+Cf5nG+IKh/ajkO1q86YOgCoaVx
         z8/jPKAsWMoN0VZ+DCmWj28UzE8eXb++Iygp727C9qKHCXpCsNIapz7D6+d7DwBtX52J
         IOBndD0bIKoY75Se+DGPfxBkTV4G7DfCE7xvsndS+Re8q2pV3SgMqvv1xCQl45V1sU5d
         wrCXRmQqt/PCWAM3PeyGK4Xa00iCTZQjE/qYCPZDWMeNPWpgs3Lqnz40b+pJsr8qPjmt
         ktLRwfbBDWa1r8aU++gZWWPYKJ2gNacdoJIGq5/tE7txpLphcapkvVO3YZTsVNBKT6Fr
         QTXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BmaWYZudUzKTdAysv69/Cdb0Dh7Wx9y++/4srUWZSQsH84g1ns3Sx0uJu4WzAYu/NQLMl6khGRVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUzSIwpsPRK5HHGx06KeaHww1k814KV+tlyDsvaI8POmjMYgt
	tmAZLcgUgoIH0wf8De3LLY37laiunx5Z+e0ItxgEsj6lo9MnWx7FLCJiUQH3CT8ncKZ9hB4V7nW
	gKKONKwUGrmDzq/jJl331B81oHD7hylHPkf6mP8WJHaCGg1nAOuPcjwv5q5GPwVJ83B924Zk=
X-Gm-Gg: AeBDies86j7d6uxq82wVEQfL5zu33Y0IMRKMXDembhGa4zA+OUqgn1hZWovjuJvwbL3
	hKaNRoxlh3rkGHA9k5u+tkpETEZfjbPbkF19rkX/oJRUwc96Ha1tfv2XP2NLopuOkfrDKrRWjF5
	f83kUKDjzQ1PntsnC1IGM8/WOECwhzu3sSDTWUBeZvKUxLIVnSPlwgilKlzDtq6Z4H8fVTynYTS
	kdM4k+c0jACXsd98QVNxEsFxUY2zKWKcUOb8Vq/hlazbxjyTMDhudRdwep8HF0iz7RQ/Ni2SiXI
	hoo4AvmJhn8XiMuMXlD/PptPxbJ4Wtr+ZiWKsA2MBmqZpyIbe/EPMwVZRqlNAkecAc4z81K+DNM
	jPQkINYzDINTtR7LvXH6+6pFIwXleLqyxpvJA6kzivk4B3Vw=
X-Received: by 2002:a05:6a00:3d4c:b0:82f:84c6:6510 with SMTP id d2e1a72fcca58-8352d15b751mr9706b3a.11.1777653898278;
        Fri, 01 May 2026 09:44:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4c:b0:82f:84c6:6510 with SMTP id d2e1a72fcca58-8352d15b751mr9651b3a.11.1777653897585;
        Fri, 01 May 2026 09:44:57 -0700 (PDT)
Received: from work ([120.60.59.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835293f022asm601103b3a.45.2026.05.01.09.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:44:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bjorn.andersson@oss.qualcomm.com, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, wenst@chromium.org, arnd@arndb.de,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2] arm64: defconfig: Enable PCI M.2 power sequencing driver
Date: Fri,  1 May 2026 22:14:40 +0530
Message-ID: <20260501164440.11788-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Br6tB4X5 c=1 sm=1 tr=0 ts=69f4d88b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=VvXziC1WMG9Np/cC0Lm1wA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Mt3aZHS-KmEbwue0ZEsA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: -_i5w5KdMXkLIarLjQmjd8RT2CM0q3l5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2NCBTYWx0ZWRfX/qvBF4dB5/JO
 RYbLL6fHiBuDHAzGu+gEyC0q35k6bV551h6krJcVuU4oifQIQA595PHDAluEyx+U52aAqBM4dEG
 ZEidq5Npc34coQnTNOTQmRihtyhMDAzGI3aYKdmkLwdKOSvJClTsxGQZ4pASrXpvz3INtxeTMOs
 yKcbSk5pltWoKFawM8mOHoyYCW3yQnZ96jQbr4sWvGCPCrDqMZ8f9dFEX9ctEdecTQD1INKwRm3
 JtOXRSybLVnQAUSTctppODZae0kHMoKZg0EPS/gyzp2CN6NrviiBqDFdQ9n16JD29w8pKv5JjM3
 gVgIUxSubi4lP8NQCgAnuCpiz3aSf+r7NhflzajJ4SvT2v7EpEPikxTWFSxSYa8kQn2caPihxkp
 w45WNbELjrdISmqIEB/bWAEHkrJsTTK6J29U4jn6Oa5YObgku+4uru/doDsjQb5C+ZwAWUEYn1I
 Y0LV541+MUkrZiXA2Zg==
X-Proofpoint-GUID: -_i5w5KdMXkLIarLjQmjd8RT2CM0q3l5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010164

POWER_SEQUENCING_PCIE_M2 driver handles power supply to the PCIe M.2
connectors and is required on wide variety of ARM64 platforms such as
Qcom Snapdragon X Elite laptops and Mediatek Dojo Chromebooks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v2:

* Dropped PCI_PWRCTRL_GENERIC change since it was already applied
* Reworded commit message to include ARM64 platforms making use of this driver
* Added R-b tag

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d905a0777f93..96ce783f24e7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -260,6 +260,7 @@ CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
 CONFIG_PCI_PWRCTRL_GENERIC=m
+CONFIG_POWER_SEQUENCING_PCIE_M2=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
-- 
2.51.0

