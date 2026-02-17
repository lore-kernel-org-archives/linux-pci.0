Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05552ED873
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327914; cv=none; b=jep7p+fVjk4dYhDj203W5un6qk5mP2KvPCfTNqM6gTiYpjPS/MnfDhCELddV2rke2/RqX2rC3Nb7e8XaSjAdeQhOxtfSNIBmTMzlnQyXvKLbMkH3hqlNPaL9r8c8pL9kVUoH4c0Ust4+QAfuSDrIOu8HdiQfHjOacHS+vGbxEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327914; c=relaxed/simple;
	bh=A+edGfhNUSAdpz53Yj4yLYWTYRjAcMaFYefUDHnbxhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dl0l7lPBvcSpn9hNM0G5ZpzP0m88Q2WsvJqwpakXxwtoBqhoeW3cCIY8ClowDTTzygosVQsxdjb4I3fKsfTdFgkYcqOJBCy+Oxo0a5pDAN7HIQuvgqXS/I3tHr7RzHEFYfPF/fRq3RSLIoIkni4wvk/m1c5lq0t4zb5hdHCtgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVf6Rt8O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUfDnMNG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVf6Rt8O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUfDnMNG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HAcsHv598036
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8RIDGS7I/Y6iuZvXDaZUiKDoW3f88m9v7mj
	zm7QvuFw=; b=kVf6Rt8OySfrN+EnMlXREA1ngVYUK+8pnGlmKwq2svkply+cmkg
	rXZvyCctBjHddzFa3di290f4KpSsAJIragWpx3vlTjpndXcUSRsNc+ZMm2KApyaY
	3YFRHp/xH7/rpItDPlb42GApkHfr3Vdr+e4/s8NXT3g4ejnahzFLqabvQ8Ifu1gh
	PTd95eOUKYSU69en5UzZRV+BaLZfBbLDCdAqlEYcJRT5e+6zHWU607Tz1cFlEgEr
	H4xRuj3BXPPL4HqiFSATzZskFhVrQXDGfRQVtF96pRPeCkHOhtfhRmBMi6Cm6UWR
	yxeTD8jwJSlILgVy7DyGNZ71lz/dP1Zp5Tg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cca361m5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:31:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c503d6be76fso14066741a12.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327912; x=1771932712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8RIDGS7I/Y6iuZvXDaZUiKDoW3f88m9v7mjzm7QvuFw=;
        b=CUfDnMNG0/4rTCh10X1TW0FTAKx8wXckZgOVbtsU6NQhpah07nnGLi3igYwWwysxuC
         waRQaRoq7luT88aqu8YLerY8Py+HpmRW5QQymwx/D8IsEH07TjeiSZdNKxmSq1vIbGZC
         cKfHhS4odXC64vM8oWhhgJLknRyqEOiGXJDObuj9Eva+IeW6hQwrC1iG9L6NUMQDLYcw
         ylhO92B+uP67Ith11clojHA+oGK9nJY1nNmzeFHCVSp6sUtHsDotq0bFL5GY6ApKdyfy
         iUmbTnOL0J5+ENlbBuQA81PffsMk1u1UTWtrdA6VA1uboQ0IolaeNvGvaZ7fTuEvBo/W
         K5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327912; x=1771932712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RIDGS7I/Y6iuZvXDaZUiKDoW3f88m9v7mjzm7QvuFw=;
        b=usCmLmTzwq9e9kNmSemPKMVrQJXCiB/NBEimTSOYGqQslyYsmYXv+TsEHDUOnWRXAA
         5J/48a0Kk68zGOB8Dozcoml5ypXkVIAsPcGzKuUZms84nkR+cU7MSXy4bgZlgOFp5HiK
         OvDsq2RMfiUxDxD/G7IyxB/Zd26l3DLRL82H/3HGJ6DbRv9cbxhhHswmFos3Wor8jZof
         0aLTmOC/CRvBCJLQtZ7kGN1qYZ4CFXyVzKdqnHdg5sSyxW4JuQQ5M/CtK2PQczf/fU+y
         vSol5OpTNnugVJTmIMxFiqx3g2sy9nPC3lbOG6UcmW/ikr2aE7eEBYEpizbxdjdKyxQq
         sw1g==
X-Forwarded-Encrypted: i=1; AJvYcCVXLRrQxT2+q0HsUIzsIHDjPZ229aXcootFmH5aMeQBzrRfHydc5pFjVorN97KGsGLPS1Atzo/77uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWeKbS554r9GVLxqZNzi5RsHTd3C68W6Ursy/OutalOhe6Qhf
	QW2vowNC7OXRdhSKe5XsD8/DsCLWsCTB9cqYU6jN3ieDM8kivAVYiv07H5jTV5qVNMM5Ue/Jw+6
	C72506kW1Kd7+JLUMrby0g2nNb5XqRV+ySdaoY1X0Rajs9L0Ja5dK1Wgl8wuhWfc=
X-Gm-Gg: AZuq6aKGd4UA5qpsaGDE1ImMDO3JjJJkoN0pctoRH1yNbFpPP37gwiFCm3pODnlWrpR
	/J1NM/bREw2nFgtOIIytdn4t6P6QJGLPdZ9jSBuLyB4pMZ12ltIyqKlcOH+kHwdnBeesEqXM39D
	6s43oybTdNTZRo2RJMeb8ILfG1iJ/7+VNiG7SIC1cOUCh+Hh1/m2kV/8toonB9dPh1eiPx8MfQ1
	ImmdZOadFFdmcGMGRO4SuVZUMwRVB+sd2JIakdpWDud1AHnp043Ho7q36hutc+fBuXgS31+Ajgj
	sK/LnCtpaCsGuU3vNVeSa7MlnRNXao78iBPAwE2omCZeokwIkMwdvXl3IZFLV/7oVJTyG51C76g
	/WKvdjvMYleRH7TMQRdCjCx0FLvCnu7iBaWVcENY=
X-Received: by 2002:a05:6a00:44c3:b0:824:9451:c20d with SMTP id d2e1a72fcca58-824d9633e83mr10435020b3a.62.1771327911977;
        Tue, 17 Feb 2026 03:31:51 -0800 (PST)
X-Received: by 2002:a05:6a00:44c3:b0:824:9451:c20d with SMTP id d2e1a72fcca58-824d9633e83mr10434994b3a.62.1771327911426;
        Tue, 17 Feb 2026 03:31:51 -0800 (PST)
Received: from work ([117.193.209.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2ac83sm12372958b3a.12.2026.02.17.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:31:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2] PCI: dwc: Proceed with system suspend even if the endpoint doesn't respond with PME_TO_Ack message
Date: Tue, 17 Feb 2026 17:01:42 +0530
Message-ID: <20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NiBTYWx0ZWRfX+FY2mAkLSRSV
 9/meaP8ktLteVHa+fbOGRV8sgxXAzrD0qc0wrwgavZSchmGV4yZy1s1WKgcJ7dEXySljuvhwANR
 o25/FxsGFz+8R6WlvmZpt2LC5Ay/aX47PcmmEoOFbGhDGvkBX/LlrzdlemCcnl6lzCJQK14XXyY
 zXov8XyJCuW4D+JDfapSiYClem60b1nfPIOMeqPhQgBSERuKODKuy4d+mqvRtrM2f5NLf2bNLCo
 5XJraEAbdcnoCvU3GznXpc9MXWDqrgMzlnKha3Ezsi2Pi9/szdgXQd4teluQ2uzrw/vQwkFL2bj
 JBHKV7/fOqtDlqF3CXZiEJmfG+Vyq4ESVKFm6pCTpbegv/CroHNdG4IsRmFx4VunT1g5JkAj3HE
 lA/1awJu8TOKdQYH/zmw8+O6vCGxyq453bsoL0gMpp6slSqr5PhI6TN0xU5ndmpj44s2Cuqnlce
 1HbyhSwW6cSHeFaowHQ==
X-Authority-Analysis: v=2.4 cv=b+G/I9Gx c=1 sm=1 tr=0 ts=699451a8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=SjHr3uEWn81Gzxy87858+A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=8OcN5Qi1sVG3Ylv8c8YA:9 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WquKpI4O1Hks-Sv0Dnr_hDx-vJvl4Wsd
X-Proofpoint-ORIG-GUID: WquKpI4O1Hks-Sv0Dnr_hDx-vJvl4Wsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170096

PCIe spec r7.0, sec 5.3.3.2.1, recommends proceeding with L2/L3 sequence
even if one or devices do not respond with PME_TO_Ack message after 10ms
timeout.

So just print a warning if the timeout happens and proceed with the system
suspend.

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v2:

* Added 'ret = 0' to avoid failing callers

 drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a..ba183fc3e77c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1256,9 +1256,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 				PCIE_PME_TO_L2_TIMEOUT_US/10,
 				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
 	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+		/*
+		 * Failure is non-fatal since spec r7.0, sec 5.3.3.2.1,
+		 * recommends proceeding with L2/L3 sequence even if one or more
+		 * devices do not respond with PME_TO_Ack after 10ms timeout.
+		 */
+		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+		ret = 0;
 	}
 
 	/*
-- 
2.51.0

