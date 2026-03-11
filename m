Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6E3CCFCB
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224831; cv=none; b=NJv9/46Nt0LL8JEkS5YgvwMXVrefea9p/BzcXLbQVg/8ReoEiRGo2NUoeJmXO+mdUdibIGtEIQvvp2X0dDmMKX/nY3zkpFlZgdsPnLsFkb9fhFwwOsssV61d7wPOPvRyBLYmxm/4huytjT93yj8UPO7oxf49yamvulS19D7XLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224831; c=relaxed/simple;
	bh=pO8vVScrKCYroJtbrmCEg0jsQAkeOLwy64wLlBodYLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwIOQPSyJa5ZdaDgwOufwNXGVExy8cpQ16yEK7PQfBQnXhLDTDmmF0o4Lzu8bZU3+uS/+fOGCJdVGdUyCh390C0PysvSxUkHoB7GmZ75f5/18gJxdq21EnTRq+YuaGFPsmtmFcXutshgDdfGM3LVPTuQxTQVlpcW1iO9QoGWVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npOBf5Ea; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xp370KDI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npOBf5Ea";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xp370KDI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B7hDTM1265897
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RUOhnCtucPISnasSan3rTKScJjVUfYHl/P5qU80U71Y=; b=npOBf5EaqDgpNRp/
	eJChLrp+bcqb7qUFw7PsXocRwTdCeZjkLZ11TegHFzDPY0sT7MtX9fYrUXyNcH0f
	daT4UdxHQtkBaPboSxi3IS804Thcb3CTRw5X352M3rLLLB91huy2yVN56JUKT6Zk
	yU4HeEJVvoF7QHSTHYYU9pbzXXZk1P62dhnIaK7am7FTQCpVAmdzyinqOkQNcYR4
	MAj+eu4mzuWUI+LdIcV28b+NLXgSZN3xl1ayGn2kByH9eVMreO+ejYQ83pI8qXgc
	dsyM0NhRCb1b0jpZHMqfeFWW2yzvdw6GCSgBvkAJgQZtaWnIngXaOVm273F1uPjU
	xq5fsQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctpkfkj0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae4a6bb316so107249435ad.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773224829; x=1773829629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUOhnCtucPISnasSan3rTKScJjVUfYHl/P5qU80U71Y=;
        b=Xp370KDIecRKXnk1kZ3S5gWy/iFF1jkuN+9CUWa5x4Z+tfE3wM/8ZI+S4qoTTVtRlT
         HGshr+mdpdmXzKiEdYqn2WK3j+MEsYpKQPsHeZUVk++ABMIL4FJfZ8YRXCTyR+vMv4xI
         4PGdn9XZN50Fta8uV81WQZdFshrh+pi5pgWFK/yzAYVIVK7OaZbHcfnGhCoQ64q68ZGE
         0aiWO8M/SVO5FDgJm2oEPA53aoy0i6w9NGWSqPzcqnUKpxgvvItxlAVM2YHY8p5i2yBc
         n4eiWy5KgCBjSHd+oOnPcAMx5dbTWgDIGrN5m7ggi23HYZ7UfDLCQlldkai2epYjMnlR
         qOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224829; x=1773829629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUOhnCtucPISnasSan3rTKScJjVUfYHl/P5qU80U71Y=;
        b=bMQ4YW4/3q1noWByWN7mPHu/zDT6DKmzfmZS98IFuWvU81h8vBBDgymOo+85YvCu4a
         wtj0Zn2gqTzVrrewmdhHS1ZKG0IP6qfc5TXx68fmbKdDVS0jHkbhmnPvkGGUq72TLDD0
         dv+WD6lCoV2gkqHWX7q3arVoRu1ka7X7Lw1tURuyA+bHyxo+7Ff7x4hFQ1Ufa03Zx7jA
         XuuloYT8yWAqSSFlb6KBXcquqPux2FC66XOqd6vd2ccJShhbMSFhWnIvMM1V5wTlSl1q
         qVfm/IbweXQYowH6xt7rMP7rPsM8JRgtNWRX+JJQ0dq28ug0SvlZlnXKbwwRx88uZzDx
         1eLg==
X-Gm-Message-State: AOJu0YzXkfj9+MDDk1V/ekGCR9C+6wWvQYf+8n12Xq8j9FfD4pnn8Xd8
	PCERGlpn9Up9MHsUE0R5QcerOykn236DoYOYj/en67RHlmOA8XPHp5A/JI+9C+fgN9VZxN5ERmc
	lggSccJUUsP3WmHBqB5vRtwTIgrzRlgUgtRG7gR5Unm9mAoBFLrDx0xC38mxkrUY=
X-Gm-Gg: ATEYQzwlH/VMxgUeQBCWAw1WsfYRYndDLf3VCXYOVLdUgw8vbr9qYSCQ+9CGW0s/5e5
	zPUELjCAES2BSjoI9CYDbdvTDDz6DKY/8+Jt4WriFNqHgx8LmyfEB5ZZv0aTzDlhDg9NDJRRz0o
	6Q9B57ZeBJ3NmXCE7yvpSpvT4GrgLukyLa6yw5Rqeef7912HJIvNjo+C84oOGlDpckWvOD+rfjU
	DtHrs3oHpRpg+pTjoRHnJUdYob9dNyOZwJqI3W/qXJkwSVF5GNnaXAZOWg3dGmcLcQTbL6Z7bqf
	JNuwlyBfTgmX8yjslqX1lcTQqj9NUFVUdi9s+pnl0YcBjBB2xoUv1Tb+HmOWT4xxMEAiob1j7T8
	b0EBMpsuhNVlWdLKTlv9senWNCprli2NOsoZtO2a2iHR4BgUTROo7viX8
X-Received: by 2002:a17:902:e784:b0:2ae:a73c:f773 with SMTP id d9443c01a7336-2aeae8c5744mr23019235ad.41.1773224828677;
        Wed, 11 Mar 2026 03:27:08 -0700 (PDT)
X-Received: by 2002:a17:902:e784:b0:2ae:a73c:f773 with SMTP id d9443c01a7336-2aeae8c5744mr23018885ad.41.1773224828202;
        Wed, 11 Mar 2026 03:27:08 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222872sm19575245ad.18.2026.03.11.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:56:48 +0530
Subject: [PATCH v3 3/5] PCI: qcom: Add .get_ltssm() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-d3cold-v3-3-4d85dc7c2695@oss.qualcomm.com>
References: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
In-Reply-To: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224811; l=1941;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pO8vVScrKCYroJtbrmCEg0jsQAkeOLwy64wLlBodYLo=;
 b=mBoYVYbl4in2XbB3yxFCeM/XXBIXcAl9LHDpdikA7pS5QlbwM886Ekp6fjfgzZwEbo3PkVfPH
 g7ToHnyZqlfCURgd+My7B1OtZ+2Bc1yVqPNI1oQScXlvgARxdS/DGgf
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: r0f9rX0f_ZilhmAYbl2dggmrtlQiJU-n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfX+0LVSNW9LVUb
 brQGjknl5Z31Gt7bCouM82Q/sGhAyumh26jI/NE3vFcHibzJfkK4+60hF14jCqXd1aMo5pRRQOZ
 mthKIRmy3beR39Y9c8Aab+W33/wIX9ow04r+aXOAVx/ARslS0TbDSN3LASByuLABv8XJgdDCAGY
 2nf3+N1tjEpiK2NHWqq9N2gdDrtJS2zPKrMNRjD3n8SrvZbvxipxhDknshmA27+iTdAwyG2/FxZ
 Qy6INOppHrtCdSAPYlT8Y4n8WuSFRHCpa04g2f2YJUKinfxeTDSF/tRKizGT5yrsjw1NQv+RG6J
 myTTHTSuQjHqEspI85otoxTZHCGmXSoPMb0+n6UidzYrhGktPCLdIroryzFcz4D4lTS5z3piNb4
 B1ArlvCJY74islLStRrsZJFsUcm/sGYWHEkhgUgKvKBsu9TDzfubojCCPU9ssF5vbmsVELgnv58
 Pvcf6f1q6w1cDl4DQRQ==
X-Proofpoint-ORIG-GUID: r0f9rX0f_ZilhmAYbl2dggmrtlQiJU-n
X-Authority-Analysis: v=2.4 cv=Gq5PO01C c=1 sm=1 tr=0 ts=69b1437d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110087

For older targets like sc7280, we see reading DBI after sending PME
turn off message is causing NOC error.

To avoid unsafe DBI accesses, introduce qcom_pcie_get_ltssm(), which
retrieves the LTSSM state from the PARF_LTSSM register instead.

This helper is used in place of direct DBI-based link state checks in
the D3cold path after sending PME turn-off message, ensuring the LTSSM
state can be queried safely even after DBI access is no longer valid.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 67a16af69ddc75fca1b123e70715e692a91a9135..b00bf46637a5ff803a845719c5b0b5b82739244b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -131,6 +131,7 @@
 
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
+#define PARF_LTSSM_STATE_MASK			GENMASK(5, 0)
 
 /* PARF_NO_SNOOP_OVERRIDE register fields */
 #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
@@ -1255,6 +1256,16 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
+static enum dw_pcie_ltssm qcom_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 val;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+
+	return (enum dw_pcie_ltssm)FIELD_GET(PARF_LTSSM_STATE_MASK, val);
+}
+
 static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_port *port;
@@ -1507,6 +1518,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.get_ltssm = qcom_pcie_get_ltssm,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1

