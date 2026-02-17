Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA23330657
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327170; cv=none; b=TzINNBHoP92gZnZvu8Rywy9Vq0OjwuABFhaoifA2EJwOpcgRsJJvOEFlARm7ApPD9hxBWCJUqTq6oimE5I6OXVJarbR09/0HLemNFhyRNledGAtKPSMD0YTYuRBOttiYparEiAkSoSVPwlVnt9kHCwaAPmos7AhMQNlPLliOy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327170; c=relaxed/simple;
	bh=ZcPk/Vi6V1NIpnr+WX6LGNudzcSd+NdHRwSIluMD/yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwnEMIrNHS/U0RwT00IiK2wVcLf29a0bfX7rqjB7/CRdtFS+KsQJxGoqE5hHraMnIOp5UTbchS/DM2N/MP5DtUQgMjYrdvYBMGSIV6vDS+e8cNat/F6fnLDkr7L1tsjaL1oylYpqy49rqmp64Nxav4AGGiOKJPN4oc6k11TCFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WDnVMHKn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BpaX50s3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDnVMHKn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BpaX50s3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HAA2Bj2803486
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2UqZI7iscHApYsWoxbSsIfOsBYwdXDoKOyc0XcojPzw=; b=WDnVMHKntMf7wzZf
	UJmFZWlfxOYLtbv4YWo82GzWA4NCgzanGcG2qFwa0HbXJjJaS51lkTfLard1TyNB
	urMSPCD0yIvFwxvT5j/qDX+vbeBG+xXdGSFsb2U7n3G42uqPWhBO+FVb4CG/D4ii
	dJP/+CpkgPwLgC3QQ/174RtPO7EvdEauzKirHDx+W6kWxKxQSW1Mv/Hpa0c0JPEA
	F6NIgEmAzimJJETKH1iZhhD2ik9O3l2VbvjaEfdugAc6oDWGkdPAcuo9IbtmKHMI
	iXyf5ixXPu5ajFX7oMKqpORlwBC2PFJVJQ+suIC1lBbD5wqvT8PO9ASZwTyWNpUh
	zfc29Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxuk62a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-824b3532298so2048851b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327167; x=1771931967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UqZI7iscHApYsWoxbSsIfOsBYwdXDoKOyc0XcojPzw=;
        b=BpaX50s3Zme9ORAJO0/48XzTSMUSZC0flSzq9kLV+KKzvYey0+aLLG1m8nZcMlW/xr
         LIArFfhbCMb/6eJoIxF6pitpqeCFAgS5NPLkA7WsToRrpBddM4jBrKkvQI+eQnsePiAw
         Tt4agj9seLQTNvbS9MRt0SP84CFiSleqM0DYHaNHCqXnEmw69GB4wUoMBh/DXXuiAdUG
         REu69sOGROXmJnxn5Q0JPzCpn+Wiew8iwuM8ICdW5bDMgttu2kL9q9ZXO8CsbNTt+m73
         zhSSXMCzwR4GgBxAdOv4rZiZ+NwzZZrhvT0AoJWaqE9WPnvjcYNdOIeVAyFQMDcyG0Ys
         JgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327167; x=1771931967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UqZI7iscHApYsWoxbSsIfOsBYwdXDoKOyc0XcojPzw=;
        b=E8t7v1CNXr21M1akQtqijjyrRzUAYs2tm6DcTlg26WF9d2z0vQGaqlHj9Zs5LDMFuJ
         vrKzQlNJFrBCyjy7lSDYPuj7aXb37IntDJbCQZAUMQ990oA/f0lVyPAW9AxbrVfEYvvi
         dztQ+TCZA56as8Kc4NN8qdxKD/GLfadimrGNgy1kOAbIiwaVl45ZMwHdVxtlRHZLMIdJ
         QV/nFAhxGCoHD/qXMnLZvwF4wP8tVtAU7LghymMrr69fG+RxN2MRUplqGoLo0kUxZtrf
         OtXidu3RCQxQkZuVQB9vRwb9HVD3CwQ/pGcW51BL2hJL0nPw9MJX/scQ/fSQOIAsqxAl
         QduQ==
X-Gm-Message-State: AOJu0YyLwNddjd4pnidnK44+vGdBCJqMb/j/BXecGYgDni39JYbIH2Jk
	rFfXCFDPQCRIo4zkdkEbyufzbDtId4bXwsoWCDrz5Jat1pa/e7vCbCqFwtweDL0Mf0CjNFDz8vk
	yDjAkoFhI8XEI84hOUXx5fAw1jV47aecIZbECbTVAWYY8dvfypQT0bBorUCkwsFA=
X-Gm-Gg: AZuq6aKWpzYza7iP4dwznqC0sOUMvwvy887qiUTCTWSOSi5R+pQdoHO+dQCqE7xPoli
	rRYfma7Es9UBrYgCTcXQkaV4FqTGaLwlWmQm2/SkrTauQPWMKwm/c2ciOBqTMEgTDwct3lSKxLh
	8X+FWywo0+9dexOi8Nfaq4LzOVVqQZy9E8AIiDUiPQA4X+YTMCCi5cxUZrzNCO6yWKODyGIXH8A
	ZjiXSFmmlIv7xvRxfYShR4oaS83ILu5XjwkGVQLXcXgKFT9OFplqSXbpgbdp5iT0RNQM+4fJxX8
	GPu8ipDNcO2mZ4uKFbDWmwF9r/rCsCp2Jw9y1vgi9g+C9K0I/CNBmb95qWu80LSgm2y8NKuJut1
	QliQn9Ww2MDEsGExnbAlCAtS3tphbZNCnL9XFYUVHfmGFvnbJf4jKJ+V2
X-Received: by 2002:a05:6a00:1d9c:b0:824:a8ec:ed51 with SMTP id d2e1a72fcca58-824c94defa9mr11493625b3a.27.1771327166767;
        Tue, 17 Feb 2026 03:19:26 -0800 (PST)
X-Received: by 2002:a05:6a00:1d9c:b0:824:a8ec:ed51 with SMTP id d2e1a72fcca58-824c94defa9mr11493606b3a.27.1771327166245;
        Tue, 17 Feb 2026 03:19:26 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm13181914b3a.50.2026.02.17.03.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:19:25 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 16:49:08 +0530
Subject: [PATCH v2 3/5] PCI: qcom: Add .get_ltssm() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-d3cold-v2-3-89b322864043@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771327148; l=1721;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ZcPk/Vi6V1NIpnr+WX6LGNudzcSd+NdHRwSIluMD/yo=;
 b=wlf3BtLYbA0NMXS2gRRkF9fo7E6YylcdKwmuOeuLWkmOYXxzeUzOvslTykYolcdSeh7TY+Q2k
 oYWx3bF2miTC2jawLmAMHHvoQseCHBVoL4fWsMIbES9uNXgRXzf+7Hv
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: TOtrW19Z3jghdm-XO-zBi7-mnTOkGSbS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NCBTYWx0ZWRfX5sikmYBa8ehY
 bERTwbuX5O1sF/5HlFMiEp4MhALL0jKdKu1U6/PvFty12kdOECojLopWSPwJrQck7VeNDkBvkxT
 k3vcX+RQDJGRRWS04O1e6KVx2BMqIeDssFPYEqUROtPr6V5XCcZic5Igtxge2d1UU3zB6s0Tuc/
 JJG9k482vo8rIpgQcY9qDiV5g2C7BD9iRltCGucLZvTENJCqQEUT7QzmuzOzVrJdE49zvk1ME76
 dJjPBQCU503QGDdXds4itrYatyIKPJFCu9H1ihclef2TF+u32H68DW0ogyWc901BhfHupRkeKwd
 0BnkEr9hLo6OvLjswz3gO8KwhrEGcjU7jFCyzipz8uwZWv4K9R5Ljf3ILNU/Pz8m0aUFvwxPEUD
 fjgiTnb/tkC8hm8LR5u7iki+Ki7xNb+9HfDG+xCL5PmPXYjCB2sTILe1szb1H1jLBDBorDZdEwQ
 H+2ClGwFV1rBgFEL9Kw==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=69944ebf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: TOtrW19Z3jghdm-XO-zBi7-mnTOkGSbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170094

For older targets like sc7280, we see reading DBI after sending PME
turn off message is causing NOC error.

To avoid unsafe DBI accesses, introduce qcom_pcie_get_ltssm(), which
retrieves the LTSSM state from the PARF_LTSSM register instead.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 67a16af69ddc75fca1b123e70715e692a91a9135..2c4dc7134e006d3530a809f1bcc1a6488d4632ad 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -131,6 +131,7 @@
 
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
+#define PARF_LTSSM_STATE_MASK			GENMASK(5, 0)
 
 /* PARF_NO_SNOOP_OVERRIDE register fields */
 #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
@@ -1255,6 +1256,15 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
+static enum dw_pcie_ltssm qcom_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 val;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+	return (enum dw_pcie_ltssm)FIELD_GET(PARF_LTSSM_STATE_MASK, val);
+}
+
 static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_port *port;
@@ -1507,6 +1517,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.get_ltssm = qcom_pcie_get_ltssm,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1

