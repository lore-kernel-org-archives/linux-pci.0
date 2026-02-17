Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2B330672
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327175; cv=none; b=WuTdMVJ/GLq0lK2pWVdyIOnOC4MW3IDCDOvJ7E8bwZqGX1OnK7+g8CvMy0wE81mtXZHLaxPn8UzFJC1Wy+mH9MJvF9ZlrTMJJZKeuaIGc8U/7NyP22BUmsvF3/tfbKZA+l+QK/G/e4uXSOxh5TmLgnzW4PvWg2r+igv0Q1D0BBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327175; c=relaxed/simple;
	bh=RI4q6fSSubOmDgNNa0gqplTxflnkQiZtd27PDlBbjys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRB710n3c2CdwupbUYoihssyUtvyEbg72TLUSli6JMoqqGGZKdYYVjE8iWbt/3v+0mmaEnAoqjez61o/dmaEZ5DRT78BoIsUykFri06y2FhHDA7ZygP7TJDJ5wtlW7jktk0q6L0TCsDbknufk/p74R3yY2DW5pA/qg4WMkdBjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NEL5cgui; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eFtmxDb7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NEL5cgui";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eFtmxDb7"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8ihw3288959
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ufl5jZDzffZq1Bxrg/McQqGCvj9/TyQy203e6kES/BI=; b=NEL5cguilh1bR/cM
	a7PuV9BQ7AW0HX4J9m2MdiGrG7Fp46J7YHAotQdZJ99z6/tpvSWGq5aapmVf6WIl
	mVHE48iPMzUegKNvvF+8XDpPBV7klhOu65cFgU4kb6HhUepYDIuWqTZE6VLlc/7E
	1gSBeEnAA2psW0prH43t/H3TNRGYcS+PAIrHPpicWQV4fbanLwIBkdwOVheoo7xx
	tw93XnNt/gsh6CuvrcyOLmlr7h14cePr5rCZVtXh5r+F1JrWOVvFrcdYlnebaykL
	DsrkIZ/OWeTcCqUv5blkxgBJfWSGrZxbch77/zrE+qeiuACaIloYhimyD/+pAOzX
	DrcxeA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6nrt23r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-824a02e4d29so1844956b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327171; x=1771931971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ufl5jZDzffZq1Bxrg/McQqGCvj9/TyQy203e6kES/BI=;
        b=eFtmxDb79BG5Rkqb+xGKLy77w0mcHOeZHZpr53xwMaCNvO1qM2ebhnXIbpL6FmHcfb
         fAuQQRfN9E7eUnjL/FFV0HgzDHPMyGYmN9nV8aZN+86eKUjl96FtzJIEuhvNWpyC4C0e
         lrfXl10UwcBi9cfyquWlfkpt/4PJN7qbF1RD4T+J4BV3U8TyWdKKM/0x/fkkSyrb4dQk
         tvUrCd8KVqu8hgbl+f9y+DZYR0afaJv3DMn4t8XhABBU/FIqy3XQUjnzRxKoDOzFQXsU
         5bnoGzTbKx8n7gaXhMwjP9Cwsp8SAXDqULS3bRgREeywW7UOnHkmqZMD8txrW6R/3oZc
         TESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327171; x=1771931971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ufl5jZDzffZq1Bxrg/McQqGCvj9/TyQy203e6kES/BI=;
        b=f5eSIv++G4kWP0pSum908rfPt63ymtioktt/iGyqzcpLbHTKA9LTPmoaGPpxYcRocq
         BB3VSyzZDCyNRQbQXM6X4z+GPspm1VwiSYiAioNGBOGRTgZctw+S/n9BC4Dm3heBF751
         qEFx70ulF+yTzzo6mpEFbGwz2bl1XiaVxOxtSG80GNKQoEyiHXeZjG5A0uQBApB5PBhM
         6NKwAy23k8LVloUjoc7inTQJw7y18A1LOKh9iOFQoxAUh9jpHvftj44Q0kZ6DRjxnKKp
         TirqmA0C6x1BUT0qIZG5WHMIT2H3w6ZWFCMrb7DmeopRyjDz7DxCk9aMnCx4YlFCrEtA
         SKdA==
X-Gm-Message-State: AOJu0Yw5HfnRBHr7DIrRJT7rSV00JpvItTiyf86gQvBfG7k0SP+wzhtr
	RpCla/eTEDgWRqVfwpLbLCAivHcM3CkvymGvjm/s3Wztg2QabyxBc4gzYa+TPEZwwLNNDFZaTHM
	aUhhLSE5vzUd6IdTTfYVOkyY9UjIEafgLHpe8fWNg3DxDYzdx+tgIz5cmT0WchxQ=
X-Gm-Gg: AZuq6aL6pM8jfvz3uJcXWPBLXfwGoq7dzq/ZSbUGfdaMUAf8LeAZ48Sk5Mcoxe4mRY7
	qYR04nDqPOaaKOmf/TOoTNloXszQPbEFA1Slau2GyzfPCrS+++EL5TWqVKXn9ctMX4EvRvdhDBK
	jY0ee1Ipl74XB7aqPIw5fPQr1VonJENjxH0zbI88d8jUgwxPdHm/Ub6IYbyBk+6iN0pfbocpg2t
	fD4Q69YxyV+PuwJR+Lka1kX7aD+u6MjlsH9znd15Uut0upXY8YYYMlTaafAgp9IGSNpoPCmWhjH
	xWK41jup13zsmeznPV/HCB+d9bwtR00Pn7kbs/BjrjIwwPiDLmgKRwYPvk4tjSDNedZJHCX2g2c
	nPTt/QxXmNTPtF13jDVoJBAYQrC+ws9X1Ai3ImEuOE+akSYZdf3raHVJc
X-Received: by 2002:a05:6a00:4acd:b0:823:1406:8797 with SMTP id d2e1a72fcca58-824d953488cmr8975252b3a.31.1771327171079;
        Tue, 17 Feb 2026 03:19:31 -0800 (PST)
X-Received: by 2002:a05:6a00:4acd:b0:823:1406:8797 with SMTP id d2e1a72fcca58-824d953488cmr8975235b3a.31.1771327170627;
        Tue, 17 Feb 2026 03:19:30 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm13181914b3a.50.2026.02.17.03.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:19:30 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 16:49:09 +0530
Subject: [PATCH v2 4/5] PCI: qcom: Power down PHY via PARF_PHY_CTRL before
 disabling rails/clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-d3cold-v2-4-89b322864043@oss.qualcomm.com>
References: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
In-Reply-To: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771327148; l=4007;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=RI4q6fSSubOmDgNNa0gqplTxflnkQiZtd27PDlBbjys=;
 b=li0xu+gi3ab5XV55aDVCdK4EDUgeaa7g/6a4LpfP39jcV9HM2K+TWtxoLN665Lm7JJn/gDR6A
 p55CKSh6k9fAoU1f+ldOyKH3B3W6LSkcx7zyXglg17snwRy2jUfcT+Y
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=XKo9iAhE c=1 sm=1 tr=0 ts=69944ec4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NCBTYWx0ZWRfX8wzrnIoWUM+s
 g19YfzBCEEQgMmCQHNdxE+B/GRWOUhsSVGoUxvHeCfc25zDnEnUsN8DykhRLQ1jZ2GpuSXXMPT5
 vQsOxIGvTa7r0oSMro2JHMQ3epQ2jDCNMcwu7YI0PeReQIxbnD/318tuSpo0vTUMdr3H+2A9pob
 wuEroujU6T6iriJg60onYD/w0etJE8QhFXBXhRZ/iUsUXs1eEqEn5zsvUSlgT0FWS6+Lw8DAsY7
 58UOVlHi1edHVWfN0+VR0Ju2Aqqhrz8TzxF+hzbOalxLwJqtnAYOK7V96T1ChO+zKmwdaHNQ13x
 19wQSTLACW+K4583Dgmcw5pFriZkSILZx95ksdiqq3OqNYvTjki75Btau8x86APbIXgqyfLPhBM
 rEeA4UAnXpSyuqYCdVIExyl/mnzpEg7mYiqQ/xqEnn7pftimJcp0VuSiOi+/UkDSWpDsmxdF2NH
 T5qtEFneZGpwEdfA7QQ==
X-Proofpoint-ORIG-GUID: uaLTS7NP5Jbs7lCih-AexPB-sE0Zjs7C
X-Proofpoint-GUID: uaLTS7NP5Jbs7lCih-AexPB-sE0Zjs7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170094

Some Qcom PCIe controller variants bring the PHY out of test power-down
(PHY_TEST_PWR_DOWN) during init. When the link is later transitioned
towards D3cold and the driver disables PCIe clocks and/or regulators
without explicitly re-asserting PHY_TEST_PWR_DOWN, the PHY can remain
partially powered, leading to avoidable power leakage.

Update the init-path comments to reflect that PARF_PHY_CTRL is used to
power the PHY on. Also, for controller revisions that enable PHY power
in init (2.3.2, 2.3.3, 2.7.0 and 2.9.0), explicitly power the PHY down
via PARF_PHY_CTRL in the deinit path before disabling clocks/regulators.

This ensures the PHY is put into a defined low-power state prior to
removing its supplies, preventing leakage when entering D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2c4dc7134e006d3530a809f1bcc1a6488d4632ad..b02c19bbdf2ea5db252c2a0281a569bb3a0cc497 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -513,7 +513,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	u32 val;
 	int ret;
 
-	/* enable PCIe clocks and resets */
+	/* PHY power ON */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -680,6 +680,12 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
+	u32 val;
+
+	/* PHY Power down */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -712,7 +718,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 {
 	u32 val;
 
-	/* enable PCIe clocks and resets */
+	/* PHY Power ON */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -844,6 +850,12 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+	u32 val;
+
+	/* PHY Power down */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
@@ -994,7 +1006,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
-	/* enable PCIe clocks and resets */
+	/* PHY power ON */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -1065,6 +1077,12 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	u32 val;
+
+	/* PHY Power down */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 
@@ -1169,6 +1187,12 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	u32 val;
+
+	/* PHY Power down */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }

-- 
2.34.1

