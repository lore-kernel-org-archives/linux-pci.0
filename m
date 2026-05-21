Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10703D810F
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368232; cv=none; b=A4+nt7+GQVFUEFXfQeF6UMobVOqB25uYT32Ryk8HCcHNKPFOxhF7hfv/0SgEPMREqjWPs6eQ6GV/tux1z+hgcggAaUr/IgBLYvCtzMdwquu1H1T3M267gKud83AA3wIJTShyqDcDrsOFacF97OrZRXtBlwA6inVWYugjiDMIy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368232; c=relaxed/simple;
	bh=yPovg+NF82r2PTFn5jJ23qnB94f0op4A4x75FCu5p2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gw6KKqv/pjP7j2vW0vQhQUhLzTVprNgCQS8CCw6nxq2VdhNe3aOEKZJz1nhB8xAPvrEWOkn+LkTVi9w+qyLa7n0GNtwnc4P/VEuTYp6upi/MjrtuCZEvq/O9joJcqWj6eRcSvM7En3+d+lWajkqSYhTvOyIho/ZZ+/+XlqyuUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTzGK+53; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XD7HjLBL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTzGK+53";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XD7HjLBL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99oUU3009540
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eaF1DDc6ubWUrA0leEh9fmSU9s3FEthmlcwUOHBpY60=; b=jTzGK+53vZy+fALu
	XH/4BIMUCsYaOxLobAdl5lLyJ/LroLUyArodCX0XDM61C23KUlSBAOBK+z6YU/Ek
	XM10W83SnfGSxRe6XpQWhhsWvOc63YDnIcaSQAktozqv+iDPQtVjkULOlXPbp8+6
	bYj0+0jj1LNq+kSGzxa1ILlqBpkjVlU+4JrDR8LmKDxwSZK6NlukHlKhBug3YjcV
	JxfXQmWLRx2USK2MbV/N9/TuHT8hP9+8aKpRyAN/aGNJxNQwxWu/FHr1hLIAoKvA
	VRIzXdvmjIGAXX6e6mScsH2CIVvk4j8qx1rL4m9bJN0i3pqTUF7CU1El+ZP8WePv
	hvN5kQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9sr328cn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso9639113a12.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779368229; x=1779973029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaF1DDc6ubWUrA0leEh9fmSU9s3FEthmlcwUOHBpY60=;
        b=XD7HjLBLjdYXZPpr90w2CAi9Ho468ZdoElciPzbhdrTs4sSPKfyNmc+tGrD6vNwDDg
         1UsLLJgitFzv3c1qELCpp+O1ai5iv6TWwVDVDUvbEQf8lnIOYLNCCZz9RjphsQPvOY4J
         f5Sdm1ZUnMp0hGLPdal6MQkR1mm347NsoYLTvRZqEVu/n3M3XxEPLu/DrktzBhMkI0d7
         K2+J3khLKBgUV3tD6AxItU4DQx4sgg8mKvdtva68VITcMXaUqs2ykrNnMev3l+xVMsII
         EETabeLnKS/zs7JzTMHS4xqOSeToI17w233il/1BDs4/BlIjB2HIZLlopXi50hKW98MD
         K6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368229; x=1779973029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eaF1DDc6ubWUrA0leEh9fmSU9s3FEthmlcwUOHBpY60=;
        b=ZWJLOQJOIN3qEgGsTmgAsCsAhFyzIdvEhha3RgCV1Cd+JWbvtEkmDE0xUUCPglSaRp
         6CTazmrAR8Jfp8d/L1HN8Kc7odyoSNI3QQ3Geuw3LhSR8YlcWUAXXtb1+WqxcS++MVD9
         qwvZLe9MsIHSvI9+aDduHwvMNKc7dK5yuP300Gj7BLFuuzRF+EW65iiIViKl6UG9VVKe
         V/jM+KdqBGGm0ZZXCNQ+s0yBieVOBNefQCwfybqYbA5gay9SKhyYzXzAh4T11NiZ6Qr7
         NKVqEfpeY53sFvRG71sR9odbX63mkUJF9ubbaKNwKE6rctuEZFIBJwbK/8gsbmBr5YCd
         i83g==
X-Forwarded-Encrypted: i=1; AFNElJ+QCRl7NTT3nLJVxkp2G5BYLkq2t/b8a6M6H0Jp70+MktGBLh6V+2cCV+t6NAP0cc9h9r43MiQwKkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMaNt3hm805b7UKSwzLZ/oOFAjzXnvEWUbxAmYBB2rr6sdiAW
	CUtHT7MGDsIvWHHaH0Kd+x3HVeOOe5+LAsBpth8t/uVqLeWAKZAkJLklo8EBELiS50J5Y4JEtIL
	rj4LOtCRGnyAygtvMaCMh6sVZ8HbrEAegBNxF4gXKXCKqJTG2NioTrurI538FDew=
X-Gm-Gg: Acq92OFxmMV2rb3MiZWDtCWQrMgZ3QiRHx+bMZw8C2MERBvAWt4LEPhaSDWAVg5LJMH
	TocabPd99LTBv4fGZSK9QlgsCzPbRo/NQOTpppvuIroUSpRxvdIlrudPQmC4yBB3nhZVyGRxZlC
	VHE5libk4NlHSCdIVJbUtQgirdSDqsImo60aRw2RBgi/mRDFw7Ynzt55coHKSAfUDjRSh10Js26
	6Zj6LTDEIfnf7KxNHlyAiNEIK1CeU41kfcYDZGxKw5ximybCajqh2Kg10otXJnEFWAhQm7IKe/4
	RjwFBS/HKvLykSNqJ24VB2JhMMn4l1GkHN/Nt9lwQKrNOkoRSx3jbephs4HFdolKgdPObk8aIPG
	u6jg15Fxy8hFUHScKAv4xidEQK3bGFkIsFSJOHJnsndNbQHpmM/IV0oTG
X-Received: by 2002:a05:6a20:e293:b0:39f:3efb:e888 with SMTP id adf61e73a8af0-3b30878f3efmr3393719637.25.1779368228902;
        Thu, 21 May 2026 05:57:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:e293:b0:39f:3efb:e888 with SMTP id adf61e73a8af0-3b30878f3efmr3393672637.25.1779368228395;
        Thu, 21 May 2026 05:57:08 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85198f508bsm357984a12.20.2026.05.21.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:57:08 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:26:34 +0530
Subject: [PATCH v2 2/4] PCI: qcom: Keep PERST# GPIO state as-is during
 probe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-link_retain-v2-2-08ed448b081c@oss.qualcomm.com>
References: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
In-Reply-To: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779368212; l=1719;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yPovg+NF82r2PTFn5jJ23qnB94f0op4A4x75FCu5p2w=;
 b=UJOfMHyj8g6i+MjsTcuZrBZlxT3uum2fmETZmxbR8XciABJyMNU67dRa29dfz4/uZK12B4lqE
 F9bA502GmjGDVBY9dJ5lNDEjRcrWR+pt+aNRq6HqdlZ8WuvWDhFPGCd
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: qCCnethZJcviSvPmr8SgpCD_2zLoRV8O
X-Proofpoint-ORIG-GUID: qCCnethZJcviSvPmr8SgpCD_2zLoRV8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMCBTYWx0ZWRfX1Ky7ozM42yoV
 UH0MrssouHaA6V/n1x1Vil+bVk/rkt37EFbyLaq29jKjWZH6qeitQOwLG8vaLXwDeGWO9MzqULj
 zGiJkCFtObRvQRuw2le9TISOtivxcfBPx+aRezvzH20mhPhc1kCtczwXbx3XaaLF1U4SHHf0VPQ
 FRyHUCcLophoX3ozJ0ROVrfP8CkGzUI8jgdMLGgK6HWFhM0sOCYs2RbIdQEDi6sBxi9U3r2DFXx
 FY/CGnx29cpw4gkAiO49isCgLfTplgO3/BftOwVr2NmBBBc4kWoNcRUCS8ctwMDhXiINiZcE3iy
 GmH0lgwJkZQO1oesBniRBiIJU49fBkewxzTbusWkJDVwHwkbg/OdjjmPTH42fn1QzmehgQVtmbt
 Dg7CqhVNid5/TGgR6UhtIIbxBWe2ogBCgNDXPnX7WYfio9szDsPiiJTmYxRgIQSMtyUQauTAj4O
 rRI8zB2jjD7QfEdV9XQ==
X-Authority-Analysis: v=2.4 cv=L+YtheT8 c=1 sm=1 tr=0 ts=6a0f0125 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210130

The PERST# signal is used to reset PCIe devices. Requesting the GPIO with
GPIOD_OUT_HIGH forces the line high during probe, which can unintentionally
assert reset on devices already out of reset and break proper link
sequencing.

Change the request to use GPIOD_ASIS so the driver preserves the existing
GPIO state configured by the bootloader or firmware. This allows platforms
that manage PERST# externally to maintain correct reset sequencing. PERST#
is asserted explicitly later during qcom_pcie_host_init(), so forcing it
high at probe time is unnecessary.

Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index af6bf5cce65b..bfe873cbf44f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1707,7 +1707,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 		goto parse_child_node;
 
 	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
-				      GPIOD_OUT_HIGH, "PERST#");
+				      GPIOD_ASIS, "PERST#");
 	if (IS_ERR(reset)) {
 		/*
 		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.
@@ -1812,7 +1812,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
+	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_ASIS);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 

-- 
2.34.1

