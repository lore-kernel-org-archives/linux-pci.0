Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F93E5EC6
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906654; cv=none; b=sJLDFKUzQQsikags3CT/MVGXaVRUmxSvcKwE1gJHrXQVzJT/HcfDlI2PRVK+c6Q1bll97MUk9B+pS6Aux/NZLpP3ETqL+VYgPStbuqx5Vo0o8fc/NzPSu+VFIbCCJGJgKMIChQwCAQGIBMUIFmRsXXclsayGAoCJWLWho4zwgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906654; c=relaxed/simple;
	bh=5x5TirLtHA0c0Rb9PKOOjbyhhs2shQyZ5pqbvgZXqk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgmM8+FHSftI6qMM40CytuBInRdhP2SdB9phA+NcfpsMZ4m5kfXMmadCPtmPzj1tzZVBaTe8r2quII9SgAneEiiFxIVcGy7jdCDWAhjhDodmnnTR4uNF91weZyB+YIIX14rdWYJRVY7WVzYmUxTFdHMGG1a/ftiN2NmdzrRm4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ep6PIZSQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I+YiNbiG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ep6PIZSQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I+YiNbiG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S66lGH2045968
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 08:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oqpp/YqJcmbInDW8NldSo8VxqiOBNOhc5Rb5jj2yQKE=; b=ep6PIZSQAJWh9+CJ
	DHUfyd9B+GP3xPPswsw1/HCdB4ePEc22XCkhVeh3bYEyEMU9sLWx2opdPWMShUHo
	Ppzvw1R5P5M5ruThZg5Viv/fNBrJYjPELTIWlmf22y8wsVSKLrjdQn4ysODiYR4B
	ncGb1D8gKwL65HXKtkDbwQffMNc6b7hDs2hCEFh+Q7lzb5w73D6AV8ALUOXbnTbS
	0eLjgorj5up28hi3EkBZY+yZ97EgjSXsgMw+bccSIgLoxmdqEV3ohocqxtqlIPkZ
	n6UP603TmG4WrhgcyuL8eWoUTUi2qV/dvoDlv5O2lCfMaaJTc5x4rQuaGoXzhxJT
	07yAgg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v39as2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 08:44:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d70d8839f0so10360285ad.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 01:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787906651; x=1788511451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oqpp/YqJcmbInDW8NldSo8VxqiOBNOhc5Rb5jj2yQKE=;
        b=I+YiNbiGB7aF6ctGIz1sBNwyjTGyeeZbqVkjujq6iS2DQGkiRXfaOOndyj5caOjQJP
         RevEYKX8o2RYc9VFvc1UYUNtTf28ktNN14dA/L0/u/z8bx5bZ1Cry7PE7zJLWu/sAGFh
         RBzyjHpHEOj6ZNMhnjLysJahqLK2lNqTYU3LWeXaEbDXdrqAQyRcpqq7IRkzeXHehfU8
         GQ7OPRCMYUOWwBAMFjE7VYho6t33Gu/kwcO0AOJ5EDvaiPZYUetH0YzpcICuT5n6TE8i
         Cpo4RABAkSZ4LU1w46ASaqhmqUvf2xMFfAe3qf/JEzcBR6rggu2VaUQC3GTUf2BPXqHu
         DlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906651; x=1788511451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oqpp/YqJcmbInDW8NldSo8VxqiOBNOhc5Rb5jj2yQKE=;
        b=T1xCUEixjRUtgIVVwHPJwEvdq23SlqU8kvl5SpWoMQpFo/uG3K0c9oIGSGzZJP6qZb
         s/FVVIIF9qqB2EB21AaNwhRcG41lKXYjpdahraKAwkYBCyN+hZTkvM/Jp4EcjlWBd8UT
         MyYUXmpDPytFbWu/L3HD+X8+S6Q3WXHYBxK+3suA4YP/I+C64aYKjM0nx++oJYv7X2OK
         uMPIEEw5q2HOjVcJxEFfzq8rgGLAmdB/j1fsQ1U3J0Nk9VMIgcG+HK2MacPXfIbrSOoP
         Wlyar0Y3UkTyB87KAPWGdequW5pTyIv5KtCjDC/FyhOxDcdgSRI1R+3kyytRsc6aEQkK
         yq0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoY25gPJSxnf8sAnYN47VutmZEmfb7BZmkQxGQ33auH+aO0+F9+eHtqMnr2VHoXcCL92BD1ji+V7jU=@vger.kernel.org
X-Gm-Message-State: AFuF++kmC4MsPi7HWRXH3w6biVAtC+L3KDDmrnKe1kLrAoQlfmnR4lRt
	V/pgLjC0UpdWWCCkEY6ikPU7q7OycrIKdgT+zNQWZFybTT42yHb0FW3Yg71oGhz4wM/TNH9qG8B
	Z7IpcZSMMn7rYuQzlOmjRiMal3boNsmejTgqwtOS/mOyGWjaKyG4sC3jdujYMPzM=
X-Gm-Gg: AR+sD13rKdXbGKAV8NDTNE+Y/YHLE+pe47BfPPdGVsqiSS37i+3KaMBKHrtBUJzvK7X
	mGut4u/i+UKVtCus6pbCwnLfufKj9L67MsOX080UWpEsx8PRMiBFpiVoWP7ar21M7aj2+fFw7Ml
	GiXENFEP5ZXx83TMXRWrenWnM0NwxTbP7xlB4KVDSt6mEL/kfq+rlkRpEmL9U5hRl9ODaepAbnh
	gEK2O6ldIsBgxvLgipzomX3LxV5fNCiQB2zn14IaNRNiI8e0JgiZPHD/Xl1qu645Nbbvcda1GHs
	M67fJou+mIqNJ1HrVi8MfFq5wYV5YirDkq1OTkYd2yQZaT6DWLldeEMJaml72iERdgM4FQCHyn6
	w7F8/y7Y4bJfCSofnl3iTdDET9O33qoXemv0=
X-Received: by 2002:a17:903:24f:b0:2cf:c543:2c7e with SMTP id d9443c01a7336-2d74df5fa9dmr90023345ad.10.1787906650698;
        Fri, 28 Aug 2026 01:44:10 -0700 (PDT)
X-Received: by 2002:a17:903:24f:b0:2cf:c543:2c7e with SMTP id d9443c01a7336-2d74df5fa9dmr90022845ad.10.1787906650197;
        Fri, 28 Aug 2026 01:44:10 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm3673459eec.3.2026.08.28.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:44:09 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 14:13:37 +0530
Subject: [PATCH v2 3/4] PCI: qcom: Add CGC disable workaround for Nord PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-nord-v2-3-18bf59d19d6f@oss.qualcomm.com>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
In-Reply-To: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787906625; l=2355;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5x5TirLtHA0c0Rb9PKOOjbyhhs2shQyZ5pqbvgZXqk0=;
 b=IBotV43TcYpZpOfwsLPTB8XIkHg7+NNwBpXZCCtNFvB6kmG8fHVAB6hp3VkFYdr1DodhCbrZZ
 tHIu15FOJ/MBazQOqF4rdUggYLGaaymlDjGBZ/GECtR7jmRc5KklXoA
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA3NCBTYWx0ZWRfX+pBj8Ij73jnC
 GFPAxYqNGWM3UM8OpSFUzGhZRmgyiJRaddPC7Mu0vJL6ans1C/EMzv3ddhzhNe/xgo/0zLzVjUV
 ruTILgi/tv5y+/bNjoo2CLfxKLel2DqLqTJGFhdVa+JlwJLT98PmJv5i6AS0f+5/1OSTJhDaiOp
 Oafcy528Wb27Z8ScI+sYZ6lB8ABLA+nKALeTXmOZb3jjOadaaLrDevBOHY5IgVCFgI0Odwf8Jgw
 6sctjazCnHvVEmiv3IcRSMs3E+3nGsFLOpNcelyPRGEwWmQmTmrtu/0Px4+K+hWc7C3jyNttzgu
 2vryd0DvV4T74aoo4VL9bYhEx34q8zWrywAmZf3JTKmERMz/2isyPGxXL8Q/7KOkhY9XQdjIlGD
 lynWYtZeg0DwN5FAgNV4YQTybk4NMs1nFhFBljpi+UVGxwI57qJx27Ec1hrC3XmjofCssgGS9nJ
 JX+CBOUguylpItbpdMg==
X-Proofpoint-ORIG-GUID: wzubHVlSeBgcKpV5BxK7eC1TzYs4Hhhx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA3NCBTYWx0ZWRfX1UW6uHED+mIv
 oPACRBLRLJ6o7JoZuipKj8qVEBIz4trOzuQaodZ8IOCvjjSThSnRuJ1x2v9JX6uFs5x7ChBDG56
 uBundCu9kR2LdGepZpZlePy666O/8yU=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a914a5b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: wzubHVlSeBgcKpV5BxK7eC1TzYs4Hhhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280074

Nord requires a workaround to address a timing convergence issue in the
PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.

The SLV_ACLK_CGC_DIS bit is already configured by hardware reset. This
change adds the remaining required settings as documented in
QCTDD11972446.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..b97e40fb7ec8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -281,6 +281,7 @@ struct qcom_pcie_cfg {
 	bool override_no_snoop;
 	bool firmware_managed;
 	bool no_l0s;
+	bool cgc_dis_workaround;
 };
 
 struct qcom_pcie_perst {
@@ -1097,11 +1098,18 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
+	u32 val;
 
 	if (pcie_cfg->override_no_snoop)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
+	if (pcie_cfg->cgc_dis_workaround) {
+		val = readl(pcie->parf + PARF_SYS_CTRL);
+		val |= CORE_CLK_CGC_DIS | AUX_PWR_DET;
+		writel(val, pcie->parf + PARF_SYS_CTRL);
+	}
+
 	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
@@ -1630,6 +1638,13 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 	.ops = &ops_2_9_0,
 };
 
+static const struct qcom_pcie_cfg cfg_nord = {
+	.ops = &ops_1_9_0,
+	.override_no_snoop = true,
+	.no_l0s = true,
+	.cgc_dis_workaround = true,
+};
+
 static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.ops = &ops_1_21_0,
 	.no_l0s = true,
@@ -2464,6 +2479,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,hawi-pcie", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,nord-pcie", .data = &cfg_nord },
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },

-- 
2.34.1

