Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0A3B7779
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567013; cv=none; b=pXZhhOXYyTkw+ZfDmE3rUPOxP54dRs4juJfF806MiNuAJuqIUHpungAkIKSEB9GqPZmW/N/Jgf+MxJ5KE9fc+7/3uT+bm7Of6/x5Wc4jfoxHUcpu7kNEeFPHe7zj69RVGw/X0M+e3/2HJmglt/TCkGI9LwTwr7geet4icDWk3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567013; c=relaxed/simple;
	bh=pO8vVScrKCYroJtbrmCEg0jsQAkeOLwy64wLlBodYLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idFbLyfJsIRkWAhUvsi1ebcbe0+xE8hF2WLRjU7i86EmM+Ygu7w6iRwQy91BHlW++Ya4H0OqcWLEZeNy508SVkE/FJP8wP3G6wWYYjx7twa8S1QoGTvwEmsDG+9iIRWfIiDKw7wufqXH5hKDWMFOPyCoEcLgl0UqcSI0a0f8cFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lz5ZVzbc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UmzI5/XJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lz5ZVzbc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UmzI5/XJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Co9NE1405862
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 13:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RUOhnCtucPISnasSan3rTKScJjVUfYHl/P5qU80U71Y=; b=Lz5ZVzbcPa+zPuxZ
	8PAmGhNHX3aP2/zMbFaj1bI/wpj8xPjAKe1HEYaT0kNJRCzj4OvsWI5u5iWUWiEg
	kooZHIqWKDQcFmsrfU6QA1s3C+0UH6VyXBPyJyczmTvZie8FxxO27xfFxveuHfuk
	zTtnbAe283gRn5hAQe8OkG6d4LUOKxvol2Xa8I7vN+AfH1fSqgcozZLk5/NHcxv0
	9kpqZLSFrB+4//CeUpfRqLHQ4L0H+OmvBRa9kA6m9qRE5yFUzpLadXV/l8pxZtS1
	iIiQoE837F6p/DR4h9+2BxuNmjEUcbBLOehZaq1YYLznl3m3zUWA+i9IicSvUgBA
	oKyf/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmratsng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 13:03:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24305cb3cso60985675ad.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567010; x=1776171810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUOhnCtucPISnasSan3rTKScJjVUfYHl/P5qU80U71Y=;
        b=UmzI5/XJnruyzKNc8TKTUMf62FbfTNWrtwP0MNkpjIM326q9ffUDXzM8gK1F+8usUu
         R8qkCebaU5fYB5Hmun4TTOPP4Cpfhu+hzqJ4ZTSP+EOu+01YUXIH1NJ/Kk79ojugAZ6T
         57sdbhw+o4TfpwHWOgnCs1qpBJkWWsMuDoGdSCptfqUcZ2hyU67WsthJ83EsJyfS7box
         zbrEQsP8ZAyONIeMzdHMHAXNBgiqgBg+iJKyJckDXx6xMProkIhZ/sSfLGBL0qa5eLqT
         Y+3AD9kGEZ7U6AOIaHgNskFBn0rKqAkQBL9iClsswUPmYbU4Wf94ALOimL7Nl20hNxYQ
         7g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567010; x=1776171810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUOhnCtucPISnasSan3rTKScJjVUfYHl/P5qU80U71Y=;
        b=UnOE0lsLOGrJD2whJGUvBONxlBDBXjWnPXmEstfEtffpGQAXK3nMz7IN/06iLS9A09
         V8aIJxONTUPBEkuVsYGMw1bLsOFYMpD/VxVTjLAIJ3gnr/wh4K/5vfL+9CsjY58+PpNb
         7INRwA6ywYp2msJWHNnrfBIAin148LuOsDaWUGguS5k4zFtn2ItqBUSGGinT6MkZ9hU0
         jKSyCYSpmP2Lhvkfkgd0eJXYHkUNbUkxaG9TcXYkauYms+XV6gkmCcckyQCKa0pA2ffC
         toY3qyLxaRH5U69RU0dNyf79tUKH3/rTMavJIW69ivfjGjuy69XnFOeghSqTaeQTDwZq
         eW1g==
X-Gm-Message-State: AOJu0YxobtF1+auVnFbopH24iatmT7XlxOnW8WmHX7IbyIRPlSx80G49
	1o64Rc0g9bVjjZvKdrskxejAbvFAUDKSafOvI4nknS36bvlC+JP1bHhRf1M2xb7KsfjspcLnyY+
	ZjOcUlQZKWQLf1/Yiu0BQifCCJV6uqhNUkSyPg1Oh384BVwexekxXKNpVnq0RRQM=
X-Gm-Gg: AeBDies6X/XiZJbTvpBCON8JpNDcue8sb95OSoQcnKJ5zceb0VKuJeHoLcqpYd9UxMw
	Q61H6jxmDrpAjGoIkU07DZlvubf2azMu7FCM/ysZqm+oX7AkbCduLIjDUHz0BkQVPT+QbisrOwy
	s0dJDo5OFWwXv3tvu42mVLOTenn41IlbthRNDiWF4UfL5tbcNWsR+rxKBM5pXRUTH4LwngNediR
	SENLyKjwprUnP0N1xCQLg9r2jBS/tqe+PjoSxtwHvwscSosFlL+7uhBIAIQ+fnSTX+BdCATlJ0K
	NgbfMSm2OSFjNBDvAd94CkVFVyLXBUmnPQLHWG0OIna7RvASCGY78eFDnUCZu31etBrtYPWEApC
	5ePBdRfj3FXbGYEJZ9tZGXlVeQIgqmVuLa/k6V3KWCMk9g+rLsn0p1b0K
X-Received: by 2002:a17:903:3904:b0:2b0:c0a8:5000 with SMTP id d9443c01a7336-2b2816ae915mr193383045ad.14.1775567010335;
        Tue, 07 Apr 2026 06:03:30 -0700 (PDT)
X-Received: by 2002:a17:903:3904:b0:2b0:c0a8:5000 with SMTP id d9443c01a7336-2b2816ae915mr193381885ad.14.1775567009563;
        Tue, 07 Apr 2026 06:03:29 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm181564885ad.53.2026.04.07.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:03:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 18:33:09 +0530
Subject: [PATCH v4 2/5] PCI: qcom: Add .get_ltssm() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-d3cold-v4-2-bb171f75b465@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775566995; l=1941;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pO8vVScrKCYroJtbrmCEg0jsQAkeOLwy64wLlBodYLo=;
 b=M3puhT4nVYwMiJ7XYXSfcZrmSGJerFMTB6LFXEag8ihvt6K0hDXMWnl/7zCZKMVkQqDUhuKx6
 6VZ4rPuVn4qA5/B5oeAe+YY5sgXYSSIlGet2S5d3Rm3zsRU3N9wVOH5
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: S80RaxKAJVTxMbE-gQR_sQM5m9wlBEag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMSBTYWx0ZWRfX+ikNYbhHjQlx
 hdHCYbDyUpmHwuOJFYfM2dc6rmUlIvn+ox0gHARLBXkihuhNMCDjJW+X7m1TMNVZLDnCNjtGuqk
 qg7H4iLFKLUxozoggj15U9yb75eK9jJFJPUnq5IgKJNoaSEK+um3se8R79ZbP6h7WYHy+Qe+Cyy
 z30SiEoHTFD57SskComUStOP3dJP1mInZHpmdut0SfaxBgSM8KFWM6YdL49MKNFpMypuJcsX9oT
 3XEVbZK03bo1bfKQ3VyrQVM0YE8iFC+Q0XVbPXV63tLrL4W1CHlpNDw1jGmz5JcAxfObPRPouf1
 pbKeffPV3lv93fFMhV1U9LpVheQWt+Xr/AgUzgLZgqwGJiE08CPVAwLbcLI4+AZU0MZXXG5JW1I
 dS0XnAAOIgqV1dst8cxKsitAO/i+4o6CpltHhxm5/ELQMgvbg/VsbybGnnGSrHVJ/MtcxRPTeCg
 gnQ7RrvlibFqgg7Z4vQ==
X-Proofpoint-GUID: S80RaxKAJVTxMbE-gQR_sQM5m9wlBEag
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d500a3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070121

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

