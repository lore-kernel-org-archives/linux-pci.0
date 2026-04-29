Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9A38E5EF
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444971; cv=none; b=Pvidupl9qWA873e14h7sGAtgSmhGA/XbdLVOCzjRhXORXe9VIDQb7RIi4C40p3C1x4ucU5D/6lPL4sKCwndeaRoquryuEk16kyXpwY4tkbBN3IJdqhbt2EiesKj4MKRQLdvPGDVAJB8fMLJMlF37E3pbY6EqGGyXAqJEDSh4nxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444971; c=relaxed/simple;
	bh=rgQE2wlPYdGz9Ms01FRnDjEVC8FuvzCU6MQDVXSfne0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/eO27oqWpGSkyX3gGCAj37Ug7lRbKh7TYpBYAPpiV5PwnMXeSvh57MbPLituyxc/1/Ma1lbZyU/Ikb5HnpDJjMXQ1Moiq9/E4yxjKSGGyo52ttxrXcEdfkM29BFyGfoiuHpoyIzbP9DCtw9G8CiYm/mEzxV4/Goj2leptrwDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brwlGrWb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cb0KhiHC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brwlGrWb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cb0KhiHC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T3JCUs831494
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sAQflqyXEjlR9lLObXfmGaKeIR8F1L/RE3Stk4NAyyY=; b=brwlGrWbpQWvfnNg
	Ra8fmfZthkqCqXFWESuHgcuNJf+NkvROFCbDVvOAmdbwTMJh8EbxVWmR0svUTStD
	pUroBYM+Zuzepc9ZsZlqdCQuI/KGg6zCnO3/CHFVTWGdu5Ta6484bw8rNqzYBDSL
	gOkFDTyWBxumA6iiLf4OJKmwm7CvFdDcobEy1rof0AwCgNpGDoQS24py0XnqfrXN
	rzavcS94b9cQ3/aI7fklP6HEevUbVpBtRoeZx/GZPnrthvfzsqXRmMv/X0TVPOPw
	sZ085E3Aqu8krV+e5FkfHH+SzPKFFjjGDNyFy025DpJoAGhiUAgRO2825ej1CdCa
	k1sf0Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0wqaeyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so22528309a91.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777444968; x=1778049768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAQflqyXEjlR9lLObXfmGaKeIR8F1L/RE3Stk4NAyyY=;
        b=Cb0KhiHCbRXne212vMS+is/8uvEKmiZfXekFnXv9Ve+dB6tcFobr3Bve5Y/aYqDUpF
         cFEsx3O2qdHeg8lz9fs+vy9phMFxTZAO3o2vLfy4KrntP2bebAiHHFt8sxQklmvAu/M2
         kE5Q28p/Cq1f8E5vxXwPA19g+HFQtUOtp349sZebjMiJ5U773BSSxIqvLvGHEqla+ZlP
         h69K8XZ4rOcPLJuSPzAsK8uodicVmuWX0BAgwrjXiOLSLoAa5FBnOZitZINVrK14lQdM
         CZtEsLakG3m4z6LuldesxliUT8NfUFfjEol9KY3k5IgiduZWe1v2+WDQeZJWWGIIEcpR
         3iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777444968; x=1778049768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sAQflqyXEjlR9lLObXfmGaKeIR8F1L/RE3Stk4NAyyY=;
        b=U4Aw8MvRnL3Pf/hA57aROI7/oUwpHnH4+wEzSBHZYF3EXadeujcA7F3+FdHgzP3yD4
         zovBUp1uKAWE4jfFdlrLdmRT6avz4C0NBOdwWAv2WwtA4dVnMWj4nM/n41h59PJMuz8N
         IyeCjXWCE8AlFwNuMmBNqPGtYMwyQ7iHf+PTp1yo2qFTPKSj+pN8bp9p+aHIBdQX2gle
         QDyMlDBjI39jjFi49Gm0EDgIct8mcttUS61nqL+a2JyFjC3Lfq9lgEru6cW/SXgzBAQV
         0KmcJPbvLq97o0mHKxGflrgjWfoi8AZfeg9BQcTRqJ7HqIhUMY/oJBkVmRBorb5xsek9
         2QuQ==
X-Gm-Message-State: AOJu0YxeNymJ/gT24meU0kU1jpu15gAlRobKX/jLRHQ02u3VadkC8PRv
	UjFBRGRmGrGKHhUsIMNl6fnYOePi5HPALC2QHqVainGNSQnfUN7tFE/HuIQzwadejV/4dPQtmbC
	/42fkOBW2x9JpaOLsX2sXFleoid29bBrp4NGzAkyqyQsiBMRr0kxtWJejWb+67SE=
X-Gm-Gg: AeBDiev5JJi0GG601j9Mxc1egsPpcV9rq0KOUb4mWDPQDF4OrOxrAFfzISARQ8V1vAx
	1ldpJX6hDC6WwHHlSsICdINPF3bRcTeQwdaaZlWVCu4OwCKQ5fCzyeo8JeTO4UTHG5ABuyPlJXl
	Lpx+9qcs7APifqRCV0mEzXjCwIvWPbCVWL0xo+pZMQgQqZphJT3gToXqZoBRKzBGW5Tc8Jjw+Xh
	UL/KaPFjN2gI9dePXoQ2kjKUxCIlJEMHz4MC8dyqIl+wH5ngTTqmZe6QprrxKQUgvbhei47rlU3
	LyV2MzNKkCflZdRa6aECDZzXp3SJ7Fuk+nFiPoT/1hJYiazHzHS3LYD2O0nzFBpy8NZpMOjLgMP
	AgQ3G7xSeuSkTi+6xoN8y0vdzGbWYOjixa1LigTzgCwRz56UPHoy0/p6rkqgciIeiKl0=
X-Received: by 2002:a17:90b:2f8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36491c8837amr6235754a91.0.1777444968414;
        Tue, 28 Apr 2026 23:42:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36491c8837amr6235723a91.0.1777444967930;
        Tue, 28 Apr 2026 23:42:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303d59sm2021414a91.15.2026.04.28.23.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:42:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:12:25 +0530
Subject: [PATCH v5 3/5] PCI: qcom: Power down PHY via PARF_PHY_CTRL before
 disabling rails/clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-d3cold-v5-3-89e9735b9df6@oss.qualcomm.com>
References: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
In-Reply-To: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777444949; l=5203;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rgQE2wlPYdGz9Ms01FRnDjEVC8FuvzCU6MQDVXSfne0=;
 b=JaOQDILfJYOoMchLl/cEYOB0wve+tsQCiwlZ6fMiP8IcMh282moLRs2rp/lrg+7a8ohN/4Pgx
 SXKbz9xiUeNAK/x7N3nEAaWjmjNYdphcZac1xnsDzcrx7NiIDmtyHad
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: qZWFRMzkWEe65UQKp7NEGLAmcqYqkAnC
X-Proofpoint-ORIG-GUID: qZWFRMzkWEe65UQKp7NEGLAmcqYqkAnC
X-Authority-Analysis: v=2.4 cv=BfDoFLt2 c=1 sm=1 tr=0 ts=69f1a869 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=oQbQ34n3Jerzy_GFPTkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NCBTYWx0ZWRfX7HrbJxb646hC
 1SDE+9KviNU2XmK20ejgkx9PpkQV0H02Oj1YzhguQNjJkXOSTOWLJCy3rbSkfPdBJz+So0IoqPd
 z3uXP24oLhsVo+fwbyjN+MCSy2QI9yg5XVWpOHj7uIRre4dJkXBUYOfYlU4vLuMjSjaogNrZtgf
 a4llA47Rriep+5JaUQyyD8+PJmolAjtJKrRykUS/Unim/i6vt3o2Zh7pwUAP6Gj7MIRYExoNBFU
 hshPUdfhjfsoYGI+UQnaDknRtPf7BU7aOQfsEL2YD+pmic87yMmOEQuFY//Mly6ZRDQ3SixIEGt
 Nm4nXbnKiG1bkB3oCGnFFxdsg+/2UKNrqirIThztCMH5nKx4suxBjcSb0ohEAiI1IrLEz9CieGN
 9DPkRCTCtAtD3jxC2Gk7ZEIxAmEC3eK78uIT5X0gGq1DHKz3jdwPyc7dYNgP+Ojr/3Zg+VwTsmd
 ZNqtVI0P4YZDZUGmSRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290064

Some Qcom PCIe controller variants bring the PHY out of test power-down
(PHY_TEST_PWR_DOWN) during init. When the link is later transitioned
towards D3cold and the driver disables PCIe clocks and/or regulators
without explicitly re-asserting PHY_TEST_PWR_DOWN, the PHY can remain
partially powered, leading to avoidable power leakage.

Update the init-path comments to reflect that PARF_PHY_CTRL is used to
power the PHY on. Also, for controller revisions that enable PHY power
in init (2.3.2, 2.3.3, 2.4.0, 2.7.0 and 2.9.0), explicitly power the PHY
down via PARF_PHY_CTRL in the deinit path before disabling clocks or
regulators.

This ensures the PHY is put into a defined low-power state prior to
removing its supplies, preventing leakage when entering D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 +++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 085300c1d1ec..9dd808e85409 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -532,7 +532,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	u32 val;
 	int ret;
 
-	/* enable PCIe clocks and resets */
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -699,6 +699,12 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
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
@@ -731,7 +737,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 {
 	u32 val;
 
-	/* enable PCIe clocks and resets */
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -795,6 +801,12 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
+	u32 val;
+
+	/* Force PHY to lowest power state*/
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	reset_control_bulk_assert(res->num_resets, res->resets);
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
@@ -863,6 +875,12 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
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
@@ -918,6 +936,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -1013,7 +1032,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
-	/* enable PCIe clocks and resets */
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -1084,6 +1103,12 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
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
 
@@ -1188,6 +1213,12 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
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
@@ -1228,6 +1259,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	u32 val;
 	int i;
 
+	/* Force PHY out of lowest power state */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);

-- 
2.34.1

