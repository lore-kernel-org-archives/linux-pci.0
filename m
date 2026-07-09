Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC13D3012
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578943; cv=none; b=gVHLK3yvTYmuWuw5Ybi+wbP6gqFJ7Kx7A8xVR7UQxYtDManxTq4cMMBedyeYEg8t/37Ro+lRFQRbuo9SGPKNuWh3g6zrVGPk7syJdYSYALqYyycE/3slkpY/iAIlN4Ou/Pj9WsYD3xfPbWn7KE8inbwfAAbU1ywGNUzBUmO6lnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578943; c=relaxed/simple;
	bh=R0/W2Phyy79uouOevakF9zWVoE+R9xIaDHzt9TBuyms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVGg7c9pLbdUQO5tFwyfM3U/yys8mb/lCBpETuKoLvDRwtjwD7DGVYGpaECr5+G4T2D4E6nHONhIAIusJJchqEOp5l2N7QhtiR9v5cLcmECsq6JLedla8SakxowB2Vu2b1/yirvt1qExuaajqfWtVWIgjF16QRNc2Kkyxc2LvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B2fcfZb0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIrwCyjP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2fcfZb0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIrwCyjP"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66961CVj933499
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 06:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xozTUbTiSFMcUs0rkGns4SRkNmiUaXwEd6jRiqtON08=; b=B2fcfZb0aFCKdWVK
	MgNLx20GCw2EPsjCr+ORonFVi7CYw0SHtf8dKo4VhjyZrM/5Gv5fcqrUnQ+Mmqon
	nzBiHeYKcro771eSoRmo8vVCp9uIKMJVr42UM+IdRvaZtmFRdjWg4UrsW3hURNMZ
	pEkNUMiv4g2QAbK+yhuaggGZYTji9m+Q5NvDHt6whNQXL4pAsneLrPUA1kPvxCAj
	azNXh1KQfshB5FgwWL/K9JnzAQJD/h9ySocMqAnCD6J0IkDwFpo7iyHbrGZQp23i
	BSSM12AQqmPNWuQUz5dfD6Q7/rp7w+rB9TN14G1U2+4cvVRoqvjNV/w6Jz5MFwab
	/qogXg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6j8u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 06:35:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so1622311a12.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578938; x=1784183738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xozTUbTiSFMcUs0rkGns4SRkNmiUaXwEd6jRiqtON08=;
        b=eIrwCyjPhSOKogEXoQUR3D/lHoSK2ZrhMB6UfSw6XARyQQWSt+NR1LCIGBpApuTNGv
         7e5qMgqHMDFTvXi77MrtJqf7hwv2eQr+5f3X7SVbLnT1gIIY8XvKaG5V0j338AJRu2dI
         yvQmG6ZJyX/vO76o42r2eDdBdZ1ct3bnb6GsSvGhs120V+pmWif91NC5docq8NUPI+kG
         WgsZFsfv+P32TsK6NODM+VmeL9iQDPO8fpuVlZ9ICfQbuGHjsnBwjDqdQlZyRuNEKrnV
         l60QBomgrg7ATt4p2Lgrns3IIl5QiCV4d5dTCXPjCOQKzwy7SGyu0avSAUzF/UJUKsfL
         o6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578938; x=1784183738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xozTUbTiSFMcUs0rkGns4SRkNmiUaXwEd6jRiqtON08=;
        b=PmrJ2gU0NxbA9gACYDaRC7MjMYe+dy3PWqw4/BZx7LVXlHYI2Xr98ioVnewGqX3rS7
         wTGCG9P4tbdiliOaMyeBoLu1ZDPJ1+Dpow9b2P/V4heMOm+GclaAhLa0aLvLPk/pvXF4
         88IPwzkavxDlXgULywPXmfbgfoYi+PqLId4NlSwbCHNnlZg+jmHu/NBVq+yYoMd4MHGF
         thLbm/5w09B359Q5EYEa8Dq694j53+F8YYp0+Tqw+3dz3iLVanYRH083PaG4lWFm5CrO
         n659n2/Zv9Upqs1SbF8aajZCxZifDzLlfFh4gV5Y7iXf2zqyDF/tjAY06uOxQXP2ZlHf
         c6Ng==
X-Forwarded-Encrypted: i=1; AHgh+RqRqUTWrwOuVtjdABPmjBe7/9b0lFiRzbfzeZdCwwqwiYPVQ3WYefqjRY2DILb3mfgt0qND6ARzSHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywahm012LoOo8xMfUSV1AXCJn9bsnHF1+sL7RA9i8ZD1TQXVDax
	9sfl5EKlfstaTyBVaIGHEyPv2dub8fwgiQUgswq9gr+FxLiSMkcIkRO4hHJic5R1cUJCDRkmAbY
	/qegC3nwqS3ViM+fBKYx5IlRad2Sk9dZRa9yjedVJ+Qn7eRQ/qIHo9UVeJlyJyI0=
X-Gm-Gg: AfdE7ck7C75VV+8NNsHbHdgaHVBmxgDkqh8BJT92ZDYAPRnWDub6rMKU84bVS8FS9Ez
	RccnhK+b24M1Zs7mb5Ec2XZr3DD/Juq0G/gitasu8xL+I2sf0sD/ECmrQXkDt+llZz7LUJBk8fU
	O4foFDbmgiGiO7UvloEgS3863oPzydykU/AtRLApYJje4Qtfnbr+0rfKs+yKBmpxIZv+e9nP/6N
	+d8sWyFRPtWJpxqfWSTS4SuWn9YNpQiUkMWwBYZ0JXEuyO7YBiQUuTQhWqTSoXL3/HiVxB0g2cL
	QhADeJSav01vQm8IUykQx9MXNOrvqi6B30va0Fc1+VAsp0gLa+i5dJway0j3sAtoIEamQHB0hP/
	ZLoNNT4g9BOGhuxtJmqlsRrTvIIIt4J8ue+kmLX5wZ/0Kqw==
X-Received: by 2002:a05:6a20:918e:b0:3ba:f5c7:6bc3 with SMTP id adf61e73a8af0-3c0bce1eb32mr6762097637.10.1783578938532;
        Wed, 08 Jul 2026 23:35:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:918e:b0:3ba:f5c7:6bc3 with SMTP id adf61e73a8af0-3c0bce1eb32mr6762046637.10.1783578938071;
        Wed, 08 Jul 2026 23:35:38 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm28304294eec.16.2026.07.08.23.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:35:37 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 12:05:16 +0530
Subject: [PATCH v3 1/4] phy: qcom: qmp-pcie: Skip PHY reset if already up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-link_retain-v3-1-81a9d187bb61@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
In-Reply-To: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
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
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578926; l=3603;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=R0/W2Phyy79uouOevakF9zWVoE+R9xIaDHzt9TBuyms=;
 b=zmgyhFhIkqGdHGjvKKkpfEdJcW0Brt3sMmnEgbFi4QYkVK845RWPNhu/gAZx5mA8RaCPIKD4g
 ZJcafkp+02wD4pfenTOgkkKbVRS0aSH8uswmthN8/DX9H4SZDn/PofQ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX094AjLWrTLj3
 iEk6dAnSS4+nMfGvvVDP9o0NvilXzwTxyJNnBAjU5tMxTxNiFS+YusOXv1fdd3RsEg286aePT/6
 007Z6q4lcTGQaEdCWkWik+HPZdtyHHo=
X-Proofpoint-GUID: N2gmESZH1pUXcijZLwkpQ4iK1o_lxeTJ
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f413b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Y7qMJ73t9LdsiZx4VnoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: N2gmESZH1pUXcijZLwkpQ4iK1o_lxeTJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX928zPL3LRizy
 CX7SWdkKCsUxDUdyBDpvvk21AT7OCHsXVWuCdWzm4heycKvc9VtmhYSHow+G9xCuGc8/uxJ9NoQ
 c+hUtTfBua9mipDqMjUGi4aARrf8kbC3M+gIZz6c/jexPZCDXv6zjw6nS5sVj37RjBvZdUw76Jr
 anmikxluinLcHyO/WlTBYL0A7pfzwbg0woAVwGvzU38uQimLIOU54exULqvxsndv6xBZhykeRXq
 dEyFHkZjm2ke3cnWAaWZiVmrW38Tl8+5uvvY8r2jMbDbttdXdSCCh7ThEYsC6n1p41iRpP8Mj9F
 jBQW6qW+r9JZaY2vFYBMhDQiv1/vVHhBmiyc0M9AaYZGXnaB1bB1TmeQARnQqAj2T+3m96vf2Yu
 5HBEcvE2J/SDWLT6osoYtYx5nW/gYrSezIsePgwK4SSoqi72o3Sv/Msxzap3agl2lMJapGp2XH3
 vjTvpHjQieNf9aGt9Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090060

If the bootloader has already powered up the PCIe PHY, performing a
full reset and waiting for the PHY to come up again adds unnecessary
delay during boot.

Extend the existing skip_init handling by introducing a skip_reset
condition. When skip_init is active and the PHY status indicates that
the PHY is already operational, skip asserting and deasserting the
no-csr reset while still enabling the required resources during
power-on.

This allows reusing the bootloader-initialized PHY state and avoids
redundant PHY reinitialization and PCIe link retraining, which can
add hundred's of milliseconds of delay.

This relies on the assumption that when skip_init is enabled and the
PHY is reported as up, the bootloader has already configured the PHY
correctly and the link is in a usable state.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d3effad7a074..49e10151cb1e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -4862,6 +4862,7 @@ static int qmp_pcie_init(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs = qmp->pcs;
+	bool skip_reset;
 	int ret;
 
 	/*
@@ -4877,6 +4878,9 @@ static int qmp_pcie_init(struct phy *phy)
 		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
 		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
 
+	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
+							    cfg->phy_status);
+
 	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
 		dev_err(qmp->dev, "Init sequence not available\n");
 		return -ENODATA;
@@ -4900,13 +4904,15 @@ static int qmp_pcie_init(struct phy *phy)
 		}
 	}
 
-	ret = reset_control_assert(qmp->nocsr_reset);
-	if (ret) {
-		dev_err(qmp->dev, "no-csr reset assert failed\n");
-		goto err_assert_reset;
-	}
+	if (!skip_reset) {
+		ret = reset_control_assert(qmp->nocsr_reset);
+		if (ret) {
+			dev_err(qmp->dev, "no-csr reset assert failed\n");
+			goto err_assert_reset;
+		}
 
-	usleep_range(200, 300);
+		usleep_range(200, 300);
+	}
 
 	if (!qmp->skip_init) {
 		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
@@ -4956,8 +4962,11 @@ static int qmp_pcie_power_on(struct phy *phy)
 	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int mask, val;
+	bool skip_reset;
 	int ret;
 
+	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
+							    cfg->phy_status);
 	/*
 	 * Write CSR register for PHY that doesn't support no_csr reset or has not
 	 * been initialized.
@@ -4981,10 +4990,12 @@ static int qmp_pcie_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(qmp->nocsr_reset);
-	if (ret) {
-		dev_err(qmp->dev, "no-csr reset deassert failed\n");
-		goto err_disable_pipe_clk;
+	if (!skip_reset) {
+		ret = reset_control_deassert(qmp->nocsr_reset);
+		if (ret) {
+			dev_err(qmp->dev, "no-csr reset deassert failed\n");
+			goto err_disable_pipe_clk;
+		}
 	}
 
 	if (qmp->skip_init)

-- 
2.34.1

