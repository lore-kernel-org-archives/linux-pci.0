Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B93B6C1E
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567018; cv=none; b=iZj1B7G0xetwP9Wzj5KDxXKIRVh3+DgGoK5C7a47ZqT/nq20o32c6KGOBSNQ0xoYC2UGUxUKKocXYpiTfCjCIxEjNFkssQdSwO9S2WQyKdYUtGj/DXKk0Ltq32CRaQB+HpklfowxAQ6hsTCMp3mYFAsN7Qqqz+5+8JTjGpu+CnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567018; c=relaxed/simple;
	bh=p9k1+/wF5h/48gQ8oI4Nz1vPnqke7I1l9Z0Jkky+eGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMt4mVj8CaxQ2ksXXn1Zkir3257QQXN696UamaOlRkr+ec0uaJADvN/Upbitr/aPbMz34OOX1SdiNSBJ/eeoByQ0/utJVPIOcWe7Uhg20jI1h4eDuzYs2/0OBajtSBocATBeSfRpiieXm3JPumXBl6YrIrCtfOPlYr8LULB9WAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=neYlXzff; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pr2vuRZs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="neYlXzff";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pr2vuRZs"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CKTVG2550324
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 13:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0dWYOeGxguS+2oLFAt3NGnKQOAcHpW8zVfBpqLuOnk=; b=neYlXzffH3/tWdGL
	BP23zbmQhq3CKOr3rtHAP3Ji+bi/3KtGu97G5CY3SFnDVt8nGg8I30fSmHLF9elC
	d9Z1h5q3cvKELU2xZv0ObmZ2w0GUhPC/7o+mkJFGi7a7Wu33Xax2R5TjL1SlLrzm
	fH4uBzVFcenFQr1KGfEz1hzBEZTM9wivgAGYwqlE0gM+CbEhcRZTeXBS4M61bHk6
	765AIOAf5ZjTbzkqHSc746Ikw1jw8jlWeiTIwtQvAlXkMWmnr8YrDLVhKqLTp4FC
	3SLHHiQhwbmHCh6yLgfbyeQhmaAwZfpaR49e/KcxGcfqign5q1vLq9y+RoM2mQ9s
	o/2BDg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmreath4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 13:03:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso10943127a91.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567015; x=1776171815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0dWYOeGxguS+2oLFAt3NGnKQOAcHpW8zVfBpqLuOnk=;
        b=Pr2vuRZs/gsh6Amx4LvjxEJI0BU7269dKUAeSDZ0E1o2BnE80LRzfk8dz+CHacW7e2
         qy8kg9KDd4v7uqpNx1+BhiwXwctekPWMkeeCCyToEQoImW5yhG5l0JjjU9QANlvzbTu0
         A2bqwi+BnKzkP2oD6N9UjJqm2Tli3rwPPSmpBzcK9ipwPPKtQHmtGnu3c5WoOKSLon4W
         6PMOjy7Rha1BN1YR6y3+Q/NjOle5kVW2fYXLE4UP22Y3GBas7TvRkZIpllNP7tPfciKo
         GY7ujFuVZb0hOVeWOvGMtOAxqcxcWMKA2X7xs7Gi/rxelwYNA/UGqMuShRl7vPlTh1At
         5a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567015; x=1776171815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0dWYOeGxguS+2oLFAt3NGnKQOAcHpW8zVfBpqLuOnk=;
        b=Z8Ucfw2eXWaDgzsFYVrBL1Xh3FRQAMnpz/KzC64/sAe8/5/WXHKHA73aNXKmVAkj3M
         DDJMt7PkKvD4G1FI6KrEBei4kXTzyrdYUjYHmXTDtNZdKemRfErUP+m1vu4wwACj5Bmo
         U79AneXsegzhJWQE2xAFg932ARNng5hI4Eaoq+JkwtzcPXl/S2tIOPB8DlLf5Z1ZufgE
         dPS89Liby6hKdDKdkVUjrEVKjJaXmcqsAHpAQXOv77lYEN0MOpAnCaHU7XAGHkNN758c
         NSzMgnD0lHTq6wegFPm0SurPyo0CpcyJeoneGoM+6mV//oqAORJ6rS8DPc6hkpVqmjk+
         uHLA==
X-Gm-Message-State: AOJu0YyBkNkhi50cPr3sguzt3dJszyvhDOrlWgKOmaNCcsaQejcbmtyc
	g04ybEaY5l3FSSIJfU/vrsTsxYajRaGhatp5FrZTD6eorgLHJW/eOAzuZBO+JwA3+XBXKA4Hm9D
	w/TuCmqeLbdS3kWKKwxTnTNepkrRuw7XReEK+/Im7uS+sOTVKnqulYy8GUWxMrWc=
X-Gm-Gg: AeBDiesHg2n4nBzrGtKx9dp7GIROQATRvxNW9Sq9KG9rMqznj8KSxE2DEUQWk4nDbmM
	JM079knbXZK5LiMoVs/G0J8HKNMR5TDfFv7b7W4xBAUHHTAelK/DpGUmIPv4v+HVtIAz/ri1f2m
	iinGPS58dCx+ks4eOaqreeVIeM8SP8m5V+YSxnuKP/sgLbrz+6qr17fnHK0J7nbauRMnVGsUmOt
	Fl7lR8ssZs64KNIDPjH+UCCbRNbPEZKiLmM7ONN0yU7L08Y3kyKCD6Y+j0p0CfBLQijFS70RHpW
	V+I489n/sArZFcAD9B4TptQRIA/RgjFR2p55kV1AoCIpPsAMKXF14MI58m0brUZ5sv4cCwJQCM+
	d7bnUlkX1nFGi9ntIDwOBdOZGYP+9ECU4UKz+fMCp9mhEK3fvROqf4msh
X-Received: by 2002:a17:903:1a26:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2b281675682mr168863015ad.3.1775567015084;
        Tue, 07 Apr 2026 06:03:35 -0700 (PDT)
X-Received: by 2002:a17:903:1a26:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2b281675682mr168862275ad.3.1775567014367;
        Tue, 07 Apr 2026 06:03:34 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm181564885ad.53.2026.04.07.06.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:03:33 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 18:33:10 +0530
Subject: [PATCH v4 3/5] PCI: qcom: Power down PHY via PARF_PHY_CTRL before
 disabling rails/clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-d3cold-v4-3-bb171f75b465@oss.qualcomm.com>
References: <20260407-d3cold-v4-0-bb171f75b465@oss.qualcomm.com>
In-Reply-To: <20260407-d3cold-v4-0-bb171f75b465@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775566995; l=4739;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=p9k1+/wF5h/48gQ8oI4Nz1vPnqke7I1l9Z0Jkky+eGc=;
 b=A/9mrwa1cEZn/665Ty4xv3sS5FQbruMYgdYZxpmFWpzrmLcBwUA+5nbcZx9i8UdCzGN+Mh8Kr
 4mLUc8D2izrCNZohAfCFDN0posPPlZAgxsuu+twsHUjGoamViF7SSMd
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d500a8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=S-wDCh2AgS0RhsWIeBgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: rwc_btRyMMRMXFtXiPAMBTFD9g_dgvqG
X-Proofpoint-ORIG-GUID: rwc_btRyMMRMXFtXiPAMBTFD9g_dgvqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMSBTYWx0ZWRfXx9SisgwxOF7Q
 w2aDG19vd/gBWELEuuRaJ+ANs6ywZKQNJR9qBwuyIIl4PNvA+ZFwMXO1LJW7QgjsyvN+gsjdUPb
 4ekcbJIE/YLICocBjHSO1noCBEg9Wf+xn7J/QjSQkutG8GI9b3xBQNV5RySL4T7hZozRfXBLGQd
 D0e0drCvLciGg8OeyFJ/xYFr2gr4Zrv4+3mM9ipjngWTLfXtNIvXpB1VZ/OZToZFKS1TQv3z01R
 eXAR9GAkqJb2hEaGbGJFz+bTnrjt2ZmiKEDxQXKN8y9Y3gm86g8p+wq0jrgHpsOcilfLExhC7xC
 Ph91Ti3IViXttf2Kbgby9rlGrXZWgc3+Hi2rQ2xM7n0kD0A/0yTZMLJwO3hNSAdXCuqa4kb+y/1
 BU4OxWCso1MFnZBcFzGYJiKTRfdocWJ9Nd+e1EoFHxsGkVuBIGhiwZx22dE431MYirutrCweuCG
 ICSGk7YsKe2AD9vDlwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070121

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
 drivers/pci/controller/dwc/pcie-qcom.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b00bf46637a5ff803a845719c5b0b5b82739244b..c14c3eb70f356b6ad8a2ffe48b107327d2babf77 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -513,7 +513,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	u32 val;
 	int ret;
 
-	/* enable PCIe clocks and resets */
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -680,6 +680,12 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
+	u32 val;
+
+	/* Force PHY to lowest power state*/
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -712,7 +718,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 {
 	u32 val;
 
-	/* enable PCIe clocks and resets */
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -844,6 +850,12 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+	u32 val;
+
+	/* Force PHY to lowest power state */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
@@ -899,6 +911,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -994,7 +1007,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
-	/* enable PCIe clocks and resets */
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -1065,6 +1078,12 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	u32 val;
+
+	/* Force PHY to lowest power state */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 
@@ -1169,6 +1188,12 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	u32 val;
+
+	/* Force PHY to lowest power state */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
@@ -1209,6 +1234,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	u32 val;
 	int i;
 
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);

-- 
2.34.1

