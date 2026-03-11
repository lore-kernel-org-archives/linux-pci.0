Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8953CF052
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224836; cv=none; b=f5/AdF0WxdSqyzPrDvFw30htp4nC8fTmQcWqfMd+C2b/WB4e7Ql/cw6lFAy/0C6kwYNxXGdAGyU4GkylbYOKpzSTaqxBRPSmh+2pHE/SzIKrFaUsF3gaRQPN1pJReNjGdC22E0rVQF7xEqfkMiVOB7YHUVlj9FMfYQp6t621nDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224836; c=relaxed/simple;
	bh=p9k1+/wF5h/48gQ8oI4Nz1vPnqke7I1l9Z0Jkky+eGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTkwKYHsswdt4TiLjVFtTeH9qtbQVeRuAxlreg4y/KNOcULEIe4CY6cSJl7+Hlp2CVPr7F+Ky0+w38Tfy0q7MzTacfILgxcCyvdx26kxjtgyQvOt08+ZeDuPIw78RdxuaCBbZA8hXaSRqcgiFjafHC0zGKSiRQqTIHfca/k8RtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DlcRurO4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SwOz0NWM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DlcRurO4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwOz0NWM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B7Q0ED2030820
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0dWYOeGxguS+2oLFAt3NGnKQOAcHpW8zVfBpqLuOnk=; b=DlcRurO486QsnPGT
	h78PTY9h5G2h8sKgFQa7VBbU7olOipI4V1IhJ5V8DRvom9fQLrABODFNC1hipbBI
	QrTQ9XM5v+4Tg50qGo5gCkyZs9A1TD4vDrriMCYFKk88/iJXUjmOjmetjscUzmm4
	n3+wfX8Czu1+Q/2yQzeENwoIOUo00bWBPz83ckiHn4oHDP6g6uaQ1yWqaVuCsEft
	ZZiY1ivYySfRlgiSBPbs3zdHUYXlp16E+slReDOyckU5lsGHgm7jkvwjqvjcBmwN
	zRUTXPfwtO9ZR4wIBy3miPN0KDQOnW0AymX2j580SWkhIFZNhYg/xvOKpKhm7A6m
	nvGOXQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu40h0qtf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae3badc00dso121120815ad.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773224833; x=1773829633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0dWYOeGxguS+2oLFAt3NGnKQOAcHpW8zVfBpqLuOnk=;
        b=SwOz0NWMm3B1x6pfB9Ka7kUQdYU1aCp6zK3kHcwYTyNtV38LfcgVn7VxoJR2H29tGU
         7Qen9u9Iu+oyTqs3fVM5wgLdk1z16jumbmZeomjKJPzR9Vowylh7tSG3DpDGwHxu1vn/
         +Ve23cLaaFWkTv0spLEwF29GxGHXtYJXFuqeB3DKS2JcJhT0/clUruxudrmOb+ffEpZX
         nulbofuS+Y6LKooGTgMat1sfBQIh7X6r8SKVLudIStoN/fVsykffM56WVQ16ow0IILxY
         EqFvi6euSxA27rO9iX9iGllLlktfgwL3dZc0Rgqczj8jVDfrrClPd2kxmjZkNA8NM2Mv
         XAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224833; x=1773829633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0dWYOeGxguS+2oLFAt3NGnKQOAcHpW8zVfBpqLuOnk=;
        b=hMvK+2dfe4BCItd2ajWSHECJGbPupdKl5jPEpWurNGIH2hYzlPuGKILfPI/cPrgBAI
         BDgH1D8s7aIZc1fdR67gVLgp7LsvnWVESa73F+79WH3Y8EK1xC/GPuerACl74x/Lumfe
         32Ye87B+jmcHOdlzzBRNjm97RxgEKbBsMrmjDO8JJrEcXhnoWljWplwNQUbdj2axmKbN
         HBGsv3bIVsKSmK9ZQ/KRW46nRX+BImf+rAPiQFjzp3RT0NG8vTUn6qiBaVRNJPhX2wzS
         UNDHr7l6Sx0Vu4rqnW3ysXcL1PAPJTngg4XvqKrVg40MBArdoCtO/z9HqFx8i4MRYkao
         4lrg==
X-Gm-Message-State: AOJu0Yw11h/mJpVxe3FkZfN4x3VAmk+oRhZG2uKE/Qr2uAM4I5GEIRHt
	1qIZLQ+BZEy6yjLYTepBlqsxY6uIh80lGVXEigs+4QFcEGCAd8kK5xkAO5VwGLkxzdSfmvNhS56
	g18LOA8SLto9ZHOLSwVTvcdulXNMe3flk5I8Y19VvmwC/wwUK3+Dk3VuOWBowAebheXQ5wkE=
X-Gm-Gg: ATEYQzz0XrACv806inadFMFzLV5/LSFwdgWBMS7BlYgNEMnbGXNG4IZlcrAOY+ReO0B
	vZm0l8yigbJJNLl+4Um4EF3O+/B/e7jMYej0xZzmHNICoCai/1wwnJ7D3SDt3/K6yBQz4i0dxWa
	ulE5SfZ1A7SQVpJbs214FYvCrvg87ep33mDNcpqIquOIhR+k7C/nnF3JUJYUktavtTiyRkqMQaD
	YuIvJgXTxwLx9qKm462dtn/USwl4Z30EfVrIgPamZQyMQ/cqEEi3dpijNCOcl2GLzu6djC6MOkf
	sMVpPXZUnEpXjgGy6hgNQbDyfOyaivnFyyrsNaZoaY8Jn/TO0usPouxhLcoSw6MiTFrQjQWRGNI
	VsX5wE5lMFViSOJ2WB6jAVGBD2A/Rc/cjia9Q0LmHrHHNIEAgnFQpiQk8
X-Received: by 2002:a17:903:2b0c:b0:2ae:3b36:23e7 with SMTP id d9443c01a7336-2aeae7cfd6amr22264805ad.16.1773224833110;
        Wed, 11 Mar 2026 03:27:13 -0700 (PDT)
X-Received: by 2002:a17:903:2b0c:b0:2ae:3b36:23e7 with SMTP id d9443c01a7336-2aeae7cfd6amr22264455ad.16.1773224832553;
        Wed, 11 Mar 2026 03:27:12 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222872sm19575245ad.18.2026.03.11.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:12 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:56:49 +0530
Subject: [PATCH v3 4/5] PCI: qcom: Power down PHY via PARF_PHY_CTRL before
 disabling rails/clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-d3cold-v3-4-4d85dc7c2695@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224811; l=4739;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=p9k1+/wF5h/48gQ8oI4Nz1vPnqke7I1l9Z0Jkky+eGc=;
 b=z1UX2znW0tNQnXQikEHUVz+yoSQwhJ/CfsyzJwxDof3560WJyIXchPHVP9PSe7GbW4/Fkm/sH
 wyPufFOw5duDoya2OYCwIK8uUeNk7eCIVU28b7Kz+WNeSKoelULm+KV
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfXwKdDnrvDdGs/
 B/1fJtRz5ssv2qGrLUX9KcEl/AygT3ukchhh71gp9ZTk5MxSGYiekQ2xBe5RcPFgd7zAQDEudrT
 3B6o2vQLNZy82Jy2pxftQeFF4ZYjauonJUtbNXSZjfUzDvpokIrBt4dDvP0+Om/nbSOniZ52NiN
 4mE8i/MbeWET+yeNoCRjc7lr72gXCTx44Ynbowelrd0JGcq5tCYcc3O42+H+snco81lomOFbP9F
 HAZauRbPLRvJI4UhKEdTrWwd4pwfGjGTXvqBuvGFS/cyotKftx4Qu/y0oQQEARraLNZ3DydfOiw
 S0mUapr45kbcAJAmwBoal9r8YbCgggwYR9aIKReaVGlHnf99yXqFbj0Sjm++Lppfwg7urXNCB1F
 2y0+auzsqyn/VpEPVOiAEMxgiuIBqLA+7D4XSM93Apt4Z/JAGtM55XWt+czbVtHWlkuLIkUEqpj
 dHM17ls7KvwoN10hMTw==
X-Proofpoint-ORIG-GUID: pt7opwzREPddTy61kdlaPrxpItQxKCOv
X-Authority-Analysis: v=2.4 cv=YJ+SCBGx c=1 sm=1 tr=0 ts=69b14382 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=S-wDCh2AgS0RhsWIeBgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: pt7opwzREPddTy61kdlaPrxpItQxKCOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110087

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

