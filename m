Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A683672AF
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419964; cv=none; b=qgAcc0nkDvBxVsBSgHJsGXgrVM32uxundEqGzMzdjzJfIvgslCCLx5O4QBiLy3oMj0VNSEJp7j+PqXO1+00VXT1CXeapIfiAEKW324+4ekNGdvzkuMjyHgG9gg3YUfhWhuOIwLtpCdXTh/r6ktm7Qt14PkdW+AV53v7O7UF+0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419964; c=relaxed/simple;
	bh=g/vNPd8VALc/K45pOjMR098nGh6TjliGmsMVyh6ua4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgGy1ah+aQRzTt53bAC/UBO67d0N0tkx5HrSEWOlTiPRfAoPaFpOEWLRNSuJC79tMclPmCfgbP7lwse7VlxiVimh0HmBtGDV4rr0u6eUyWOQDFUCm16z+UPHQL/iI+IaGv3XAAl+YY1hffyPiuuAtn4/01W0TKRP0myRNhPe8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BR1gbFcC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LJRKs0ta; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BR1gbFcC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJRKs0ta"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFe4E22511179
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 20:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QseTlbfAn880N8txRVuUBddykUypUNSw2k1D7pjirE=; b=BR1gbFcCoONrG3B1
	D/iYK0DQp6U0IJmGuVVJGU91UTNYEQTQOl3szD+9kFJUT7jdt8L0bq2lpc/Ty3KM
	NNuoRvXJOhPqqD6nOONRbycKW/6yvymWWrdQ0SoTbblKwhwy5yoDoCOsNwHidhev
	JgvjRqQqVzCNq8iKkhIotPiTyt69h1t1HYyL2FHqnnj7M2vQEiDtSzCkYB4qV5Wv
	QlJXIJnkKSHRXhKGVZgKLdIegC55Ce8oii9kQacmNBE6ycsKGgR05/81Tn8dj5LX
	8G2ytMGxQPADlm1H5Im9UHW5jd6lagMNrwNCTjqgIkKUSYNDloEeI2cNTo76rLg3
	ZWhHXQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16jg9dw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 20:39:17 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-13980b6561dso49868c88.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782419956; x=1783024756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QseTlbfAn880N8txRVuUBddykUypUNSw2k1D7pjirE=;
        b=LJRKs0tadOXYXfdTlPcRKCpDmUsw59W74BEqnw5uBVJ+jru5acsAmmRGgSwgk6tc/5
         1enlo7TqgOKsm+ZAvQ8EfdVvTKvULgCfaZtVU96tStuTQrxLsu7g59ZoMw8NHeF/e801
         0xNRKB7OwCsWN9XY/8bUFmYowad3OWBjELWTxRNeI7CTV8lsHBMPOrPcpLSR4oKUNhfL
         EHCNbUSwAWmtkDf9j3vT10cHUCRo5s9n+nYdm4gefflP0PXbUbVrVHt9j772bfnN29hN
         Zr11NuunywSyXXUfX7B8i5Cgxy8WTMhcN8poX1QDtBeGqw8a2k4afRm1HbedJfvo0Vfj
         J5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782419956; x=1783024756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6QseTlbfAn880N8txRVuUBddykUypUNSw2k1D7pjirE=;
        b=KsDNbl5GoUFfo9uouSPLPui/NOr2mkPUp+9R5DGJzFWMqEKIQFuq4hLKnEyXENiSlC
         u0AQ7mjkyr7pZvmEZnAOM4vwwVhGMna7DopkYXxEVsZYw15ap6QVBGw6480Ugm1/8dnt
         Brx+VXZI2QloSVWl0sCmkE2oRRZvUYaSJn9pB7fXtlZxAc6JbD0pk+44ClrEmvRP10zI
         jtZ+FLVso1ajvHsMR8c5nkiNl+DQ3Jkscl5WC2cNaXTEJX2DJYMRDL1JD7ldvmm4AiTX
         OmS3Olt8RgAUnRumoWsN+2sQFnKYjuRAbZjfDxq8ixmfaZI+zWci11nZ764R3bE5vbuM
         j7Ww==
X-Forwarded-Encrypted: i=1; AFNElJ9XHkccSSmPQSHWr/aj75RTHenXT7uwC17QnZ2UYvyxto1tdBg+RPVGMgTcJIriuaLOLLOSLWm+cFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjt9VzAglQjid8dev/gWEn8Ws6te8s3uxazEIR/uCUdZcnUiC
	pIs+RTsGJAq0CnieUme4GW4TJi151JB8yl6qT8TMTo4BaRiE6+1iL8ShdTlSC8lGF8j1GFdnqc0
	7/ULrBQH/4v5e8QocsGOEtKt8R2aREPgbtFW3I4566SwuBIXCFOCXi7jm7OlwiZc=
X-Gm-Gg: AfdE7ckiPecrjlpLiaaitY9VqkWvk9NaK+DP2RrDLEyyGVnNJJrzwt3ZDEB27+g+Tco
	h4ym825wgZK70Z/e/bHfOIT6GWJxifRecTBogduhKzNzCa+o1l4BGuQ+TTKw5mguwHvHHOJn2Nx
	kHEhem1UfsVaue8rwxe0VCi4zjhJPoJHLdl9Njeob4NANqVDTizEVeHWaYWioRuloPFk8GO+FSF
	jrktYucxeSRhoq9Xvs9ZXl/OPQ41rTALBPWYcgDHA1wTG2oEVgsC713V/K9zgXBlw6j464MsVZR
	HDXAcLEl80JsWBF0Ov6/Fa4pKp7oqhBThh2Avckd/bCcr/OH4rJYwrzR1+Xx9qjY1SfBOU+p+Mo
	UESOtiPtaRkClUUX7ZJRoPCcm0/Jb+FnAKuK6TRMeRlfUFWds
X-Received: by 2002:a05:7022:78c:b0:137:ef8d:a58 with SMTP id a92af1059eb24-139db9ed769mr3336993c88.3.1782419956291;
        Thu, 25 Jun 2026 13:39:16 -0700 (PDT)
X-Received: by 2002:a05:7022:78c:b0:137:ef8d:a58 with SMTP id a92af1059eb24-139db9ed769mr3336968c88.3.1782419955764;
        Thu, 25 Jun 2026 13:39:15 -0700 (PDT)
Received: from [169.254.0.3] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8ddcd34sm10858623c88.0.2026.06.25.13.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 13:39:15 -0700 (PDT)
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 20:38:59 +0000
Subject: [PATCH v4 2/2] PCI: qcom: Add support for Hawi
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-hawi-pcie-v4-2-1a578603cd86@oss.qualcomm.com>
References: <20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com>
In-Reply-To: <20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Leung <matthew.leung@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782419953; l=919;
 i=matthew.leung@oss.qualcomm.com; s=20260428; h=from:subject:message-id;
 bh=g/vNPd8VALc/K45pOjMR098nGh6TjliGmsMVyh6ua4k=;
 b=A5Mue3yAIOcauVRSNX3v/Fjj30fGyHV4HsRl3sIcSaEdE3H5M6nJ4GPlLFS4AsOu4jserBaMh
 s+YYM1hLwR9A04rhKJdiJPPaxO7HaDATRAkSei2N8owi5gvOSlZaBTy
X-Developer-Key: i=matthew.leung@oss.qualcomm.com; a=ed25519;
 pk=aT25ggJo5PMHLN9N+TsZ3s/BVU++kEYuiFebPWe21+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE3OCBTYWx0ZWRfX1j0ONrPvgqag
 icYkmUZRQvqW7hpQwr7aP66XpelziSF5cIfaqz/SoxOfrkLHiJ7KdGBOHbWMctFItnvTYuY+BUw
 Vuc3iXLhLRobigk50k/QWHVy2EoOPqh6gT43zqUJGupSUyIBiIl0qpBHxZFq89wg8rws7FMTETZ
 xlu+RAptgfTmqyr8/oEkp0nVWt9gh5MUakH/6UhEA0scr1bIz+6cBUF0gCmOm0qT4S2BHMwBV7X
 HLA3pD4+D/iGqEs4AwDWYirL9ZorYqp91m9wVOGIDgIS+rIdTDJi9d5mraO4HEqf/sBkCNTp7KP
 oy/7tk8zzVGnt0l7mWcG6NiY7dD9rQO5g6wUJ4RornAdKjhf4O0Q8GTYTf4EGTosrJxch4x1puF
 mKAsok3hUAiTjc3R5s6rW0K3Vz7dmjhtSXaVLrl+88bkjJCehJem1f9+XhIkje9JkC37D+z0u77
 n2OPaHxxFaheLwjLaKg==
X-Proofpoint-ORIG-GUID: RWHR2Hy1B9LGrDysh8HHn8wxZ-JSgrAE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE3OCBTYWx0ZWRfX4JWuA1o/gSdC
 lMIovC+/YIil0RurKvNax0FVS+Jd2zWA3r/E9XQzhiGcOraIzE5PJTJb9RSb6KmmzmY2akiddsg
 cap8rN1RcRJm317nTC6XYZ1PJdDRXLA=
X-Authority-Analysis: v=2.4 cv=daqwG3Xe c=1 sm=1 tr=0 ts=6a3d91f5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KdxOZhL9OB_EpBcCT-QA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: RWHR2Hy1B9LGrDysh8HHn8wxZ-JSgrAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250178

Add support for the Hawi platform which has two PCIe controllers: one
capable of Gen3 x2 operation and one capable of Gen4 x1 operation.

Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..89ae006fb6c3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2282,6 +2282,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
+	{ .compatible = "qcom,hawi-pcie", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },

-- 
2.34.1

