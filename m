Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011863DEFF5
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335075; cv=none; b=HU2asQM/2lGqnlhKpzoJsTaQObuN8cNWZ0xHzA1FBnE0PYiL1Lgph2b/3Z810cXtUIf5/KfX6K9jhzphAOUbdfDwx2ouRnbl32Rdbo7aqu1do1Z6XAkYnxlbjntXfQ1NoNltfaNYuId5xLqBizvYxd2AOMHJg96NJU10iaYn8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335075; c=relaxed/simple;
	bh=7iP551rdIZqWRceuZPhGlp/X6IV7S6J757MfaV4YtJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIxLqGmCRwz+ZH/pAo8R/Ay3R0zZRvkvQuK0JDFWLP7+Yf14kK5Xn2I8XYXyiXJHp374vKOiBE/HR07i/2MF//1G+gLSw67lMmyRtVQCqcWlfMlX/YTrYaYS7A9mIFNygbuylkewg7O053TkNBaezM8PkHXOgsPy/ktB7zfhFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XH1qp2Va; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C/v65aSg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XH1qp2Va";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C/v65aSg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651HMrMU334628
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 17:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NAzujdDV7tIM1fqduKpVYcQ2/xyyEKE8IHJ1qImwK3U=; b=XH1qp2VaLZHzLMA3
	6JV+N5VKSxcv/Gb7HJP2ZX3MhxOeV57KOk5oL+4v9xOjOQWXkkbTslIpIc2Vv0xj
	PD702yxjfVSACfvEwqmg9SmDOw2NV7efHL06U47OMwnSyUGEOR1bf98hobwZbP77
	YDCoDXmi09J/EHTw/rW1GPMuYU1eMIoZFSrFh/h109tzAOAtLXOkRyehq8RVxxue
	h4ylUsXb2JzK8jRSYQ08E8jcg1a1oDbOpaKQM829RbJdJWxNxXCksMUNZcb8XuGr
	v5bVV9kkyl9iGRWW9E9PCZgOCfy+5/fZht6Lf1eumcqz4cHzUTOOhf25n7gR/KyD
	ejenxg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh8tfspyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 17:31:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c858e0cbca3so1019511a12.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780335072; x=1780939872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAzujdDV7tIM1fqduKpVYcQ2/xyyEKE8IHJ1qImwK3U=;
        b=C/v65aSg9ynaA7uYD4yPVsnuxT+PRz/hZ7OcterxAbPMfGGtiPgXi56sWq4y2yfg8X
         dOV0Oqmbmhfcbs5OYJZtE+uG6CO5cLX96RkqoiueQU3YZ6gH4j/UbEIzK3jM1/vFCU/c
         96Atrzc7GCIGhc10ftykwqKcZuj/q9TSsBy8hB9ykfbcbQLmRec/jmdeUbJYmj5JdrVz
         Q7IAU1gIRpJlzEwPGWDBFXbHb7/zgcczT9p2qM5M6Xyguj+swKE0HPLqrKUABNQ5Xf6v
         goIBf0DfOAukpbEj6fZhwc6WGygH+oF/xUT/dJkRv+e9Xv83LQ0eR/IsALntPHMJTQ4O
         r1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335072; x=1780939872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAzujdDV7tIM1fqduKpVYcQ2/xyyEKE8IHJ1qImwK3U=;
        b=EytHEKiJr8pEkU+V4gpviIQjplMmMy/E3jUdmOzli36HkLCfnTWaG1Q6cQh0mFjYaf
         unEQIFCipm9cEPW5mUd4qj095jhY2OJH4BLrvXDIr+sRpm6W1EYAK0ey6Zymr6Ktx/ue
         WwGlwci8u3O1Nlm6oVPnrZHowy/QTAlBp4XK7hit/RXHAfLfKW+jtz4ohQBhCM81H6N7
         mufb7XyMLXl1KxhQZG3C4g2+nGGiwJ7tjzUmgscMuZT+FACIDWwVZBjcIwfVuuWPTHDt
         BAUUCy0qk1GcN8shD0ylOYXfDg8XutVcRdcZHppcCOlJ3LbHXH0zmZPLGf6g7t2gEERM
         9fbw==
X-Forwarded-Encrypted: i=1; AFNElJ/yt1B2M4D/fYFp5C1z5tWPk9JRmPDup3xRFU8B4XcgpE8zLPEhWiTlt4ZgSI8oNcWPUAaQn6PiLXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUUckNI3rxOj86f/8A0IiczKV+a8bMY8UHW16fS0oONccQiN4
	fG+dL0CtoQox/Z9wGFKxOzQQ7aicc0wCiUXNwSI8o4D9opVfyPGPb6idph2MxWWbY2ex3lOOF3z
	AahAs6uudXOVpVE9iRDUHu6K/ae7+j9LJqJNv4St6QSI0AeIsB40axdZ+3deJkBa6qPr4F6U=
X-Gm-Gg: Acq92OHK+I4NaU7umJaACSPgXVko1fXND0Cr8RAyAm/IVHUPwZ/LWu/7WBh70Hnu45F
	Bbg4L/P8myfADlVK5cs+UH51lLpK/cQ+cEC9zSM50agag4tvbYVfTsOnf0KgMTjKsyJCJjEXhjC
	GxsTfikYL6cm5aCqTqezFokfYqlhIDqpgXa+n/JOO44+RxQ3eOk2OsSbDIbzJTyESkhfV/K4cvJ
	RfaGAotFCZTtDwvFMSJGhwmpgRg/e8CxqNXxfZ29j0tuQEvu1yxUbuvIirvsspZ2XHewCmqZNtI
	viipOiAPT7si0z7CqEvvzheShPmCeqShh0MXkOnlq0l4godx6R5yA3psJfQ7qON3jVdPWXMenII
	SjA6tio1yTyoljLonY3OakcyPFRG22HJK/Y8KKFt+/whUWRQVKF886p6wwcH8qZ+GLCc=
X-Received: by 2002:a17:902:ea0a:b0:2c0:ccdb:e023 with SMTP id d9443c01a7336-2c0ccdbe53cmr76671725ad.17.1780335071611;
        Mon, 01 Jun 2026 10:31:11 -0700 (PDT)
X-Received: by 2002:a17:902:ea0a:b0:2c0:ccdb:e023 with SMTP id d9443c01a7336-2c0ccdbe53cmr76665545ad.17.1780335063631;
        Mon, 01 Jun 2026 10:31:03 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm149136085ad.41.2026.06.01.10.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:31:03 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 22:59:46 +0530
Subject: [PATCH v2 3/3] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Eliza
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-eliza-v2-3-6b44c9c23d5e@oss.qualcomm.com>
References: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
In-Reply-To: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780335042; l=9259;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=7iP551rdIZqWRceuZPhGlp/X6IV7S6J757MfaV4YtJM=;
 b=rZJ/eG55S5EW1ShOqf9GbkFA2NOi/5FsJGM4wa2Vj+arOOuL62571uzvqZforQxiXDe+NH1tr
 LavIrc8URN5CCinLDlS/3XsDpMuiP3fDPh/hAAYA9DDAESzNMbgRxlz
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 41ioHe1OksgWZUZ-Ka8dC0si7h44jwnT
X-Proofpoint-ORIG-GUID: 41ioHe1OksgWZUZ-Ka8dC0si7h44jwnT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3MyBTYWx0ZWRfX2BGESjM4+Yrb
 iV3kMVxFSQAi1Taa0inSGqrjzH9IoF4DUVK3Awm7veteYXx0DjLqCG1go6VhbbLP+zCx8lE2i7P
 MucByRwl1fqWKMruUJMo/bt7n/0aQe0X6fJ+2Q3zGwIfqrz1jTIRPSXtVuEPhmQ2CETgs++wEKO
 rJrgbqNklKpX/tFn6pkX1M5oDQpy+Yd7NwXIh3R8VNwsfSsf+HsI5baBjYvKOhG06xQdYxuBALq
 lgx+h8QyFD7rPFo21O2HdR2LKOeQJJbH1cQQ/KqVg3Z3h9NVAFIN0jQPXQ9DR05Lt2D4We7WdYV
 ozeh68hUtcjH1xmjvax7nexcoPwHtMBD2t35k4GslMGLYQK+focm7XSzNfZKRJSjZEcrgMCtKVZ
 dR/Pxl8wephA7wjL7YYwynvR+HjEud+YO2DEx/aIId1CMQ7gnHn6DnWQk486wWvqeOUqNU/2f1B
 iFk4cvQxj9yVcSfzk9A==
X-Authority-Analysis: v=2.4 cv=P4YKQCAu c=1 sm=1 tr=0 ts=6a1dc1e0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BvlutTLlwcMiLWs3sTYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010173

Add QMP PCIe PHY support for the Eliza SoC. Introduce a new Gen3x1 PHY
configuration with Eliza-specific initialization tables, and reuse the
existing sm8550 Gen3x2 configuration for the Gen3x2 PHY instance.

Also add the missing QPHY_PCIE_V6_PCS_PCIE_INT_AUX_CLK_CONFIG1 register
definition to the PCIe V6 PCS header.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        | 139 ++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h |   1 +
 2 files changed, 140 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index fed2fc9bb311..257b4df965c3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -198,6 +198,112 @@ static const struct qmp_phy_init_tbl msm8998_pcie_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
 };
 
+static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x93),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xf8),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC_3, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_REFGEN_REQ_CONFIG1, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_G3S2_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RX_SIGDET_LVL, 0x77),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RATE_SLEW_CNTRL1, 0x0b),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG2, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_misc_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_RXEQEVAL_TIME, 0x27),
+};
+
+static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_PI_QEC_CTRL, 0x02),
+};
+
+static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FO_GAIN, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_PI_CONTROLS, 0xf0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_TX_ADAPT_POST_THRESH, 0xf0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_GM_CAL, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIDGET_ENABLES, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xb7),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH2, 0x9c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH4, 0x89),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_10_HIGH, 0x94),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_10_HIGH2, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_10_HIGH3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_10_HIGH4, 0x89),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_TRIM, 0x08),
+};
+
 static const struct qmp_phy_init_tbl ipq6018_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7d),
 	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
@@ -3532,6 +3638,33 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
 	.txrxz      = 0xd000,
 };
 
+static const struct qmp_phy_cfg eliza_qmp_gen3x1_pciephy_cfg = {
+	.lanes = 1,
+
+	.offsets		= &qmp_pcie_offsets_v5,
+
+	.tbls = {
+		.serdes			= eliza_qmp_gen3x1_pcie_serdes_tbl,
+		.serdes_num		= ARRAY_SIZE(eliza_qmp_gen3x1_pcie_serdes_tbl),
+		.tx			= eliza_qmp_gen3x1_pcie_tx_tbl,
+		.tx_num			= ARRAY_SIZE(eliza_qmp_gen3x1_pcie_tx_tbl),
+		.rx			= eliza_qmp_gen3x1_pcie_rx_tbl,
+		.rx_num			= ARRAY_SIZE(eliza_qmp_gen3x1_pcie_rx_tbl),
+		.pcs			= eliza_qmp_gen3x1_pcie_pcs_tbl,
+		.pcs_num		= ARRAY_SIZE(eliza_qmp_gen3x1_pcie_pcs_tbl),
+		.pcs_misc		= eliza_qmp_gen3x1_pcie_misc_pcs_tbl,
+		.pcs_misc_num		= ARRAY_SIZE(eliza_qmp_gen3x1_pcie_misc_pcs_tbl),
+	},
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_v6_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -5399,6 +5532,12 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id qmp_pcie_of_match_table[] = {
 	{
+		.compatible = "qcom,eliza-qmp-gen3x1-pcie-phy",
+		.data = &eliza_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,eliza-qmp-gen3x2-pcie-phy",
+		.data = &sm8550_qmp_gen3x2_pciephy_cfg,
+	}, {
 		.compatible = "qcom,glymur-qmp-gen4x2-pcie-phy",
 		.data = &glymur_qmp_gen4x2_pciephy_cfg,
 	}, {
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
index 45397cb3c0c6..17a0f9d18acf 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
@@ -12,6 +12,7 @@
 #define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2	0x0c
 #define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG4	0x14
 #define QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x20
+#define QPHY_PCIE_V6_PCS_PCIE_INT_AUX_CLK_CONFIG1	0x54
 #define QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
 
 #define QPHY_PCIE_V6_PCS_LANE1_INSIG_SW_CTRL2		0x024

-- 
2.34.1

