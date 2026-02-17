Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BF32C33A
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327178; cv=none; b=fWLtnxNGCV0/0UWsizjkVzYxTHFNxwLFO7izd3tKoyoWFWQR8xo+ACt9k+B3mkQYlka2Xi6CQ7pWV10R6TV3gtHHQAV9dZVbhmC4v1rRQWm2N7710+EL+5s7lk9rNuYZ+P6sw2lvpjYhpClEe5Fv7Vq/bvpcgGzSrlH59/WeYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327178; c=relaxed/simple;
	bh=IAVEMPt0tOVYVQCFgBm15tr3uSMRBtLlDbxbCnOFZrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLuWD/T6nHyE/U5wWqljOiYfru6ONdETmaBTVoisc3kp/8WDMSkM0HJI0NSA+97qDYcNPToOJpN0XVX98dLATvcYN1b5OCspRIIuK4lrNhNOHPgQ4dyhcZf5vGXBmjf7Ds3fYUMYW2OtfZ1dhOGSNGdYjaGbnN23P50xN9jl2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsNyqI0P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=boqNUyMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsNyqI0P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="boqNUyMY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H96fMO287788
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rMBPdn2LsAmivgwpb9UlFxbQ9zyThXTU/1K9VkXS3k0=; b=UsNyqI0Pm/RmWoKl
	ymA2wqIzXteu5X5pBcvJ6asNk1aNLXpsaFUORhO3J/G24jq7mbr7a8smaMha9G3+
	LaBYZlcaXmO/UtpQ7ZlD+48WYGsmSUS6MlVLZV+Uff1Uo89y4/mqxccHU8jwYZLt
	3nW+V6heBwywIxUGP/zKp/TAfkoiBW6yDjjG2MoHCi3mJJdzjTLctRzkfl47WsJ5
	n7rUHjnIEIKzriLWiCYYQ1JMK5UZma7bHyKlq20eiI0nG+J1L0wj2hrCG1GQaCtP
	KltZ6j0esTAhfMDt8hwm7mFOBrbDVX35HC820e4+l2dVh3hjUEWMIR7sVQMak2U8
	ce/Udw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6nrt23y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-824ae2c9ff4so10646697b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327176; x=1771931976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMBPdn2LsAmivgwpb9UlFxbQ9zyThXTU/1K9VkXS3k0=;
        b=boqNUyMYdAFS+DFLCLUgqd1vX01La8ck8o3gdMKc2L9Bz97W2ZxQicBDKmHRoZl7ZU
         sO/EQKjAcIydcTNnBCz8NK60uEW7FNF4ySsA+nVFPW7N2p33lzsF3SUH7OLVXPaCRHbZ
         6Rxcpe5iiFx8cIQypokIOzoHs93ss/uK2yKob+V72QhRQ8dBM15Jwx4TpBtKyCv6+YIK
         oIIQMkhIMokpELWulMx1dhbc1WnM6byplLUGkn5VSCAzgtNTvBPhoWKr84epY1KMgxAs
         QhkjZnNanRAanoRtzzjtFSmNBODaSxRL2hgbXXVbjo2LzW596n2Pj/cl2mN0gB/UI5LO
         pRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327176; x=1771931976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rMBPdn2LsAmivgwpb9UlFxbQ9zyThXTU/1K9VkXS3k0=;
        b=hpb7OyrHFg0iUUEjKAptsMvyqk85f071KOIkyLNGguj7rGdx7xwPyoStCSwWimWjRW
         kT4z1ur7aXowCsOb2nuy+AOLQafBa8+t5iz+cakyImbg9+RBYfr4YlnE7tdY9JzIplpW
         lUsRuxkyr0EpUeuc9tQNpEl4sf+D2gfJVelBIL6PipK74umVHXSbys2Bm/dpuaL6B5EV
         YcFnckLkmq2tOlyCRSh+TMFCtpZL8CWns9BRtjwj2H/Bnkjx/vWORHVt5wx+o8CRYW4K
         GGpf1vLcOffrs4bplFXpl8Iip6fNuHbq6l3Tgw0vV5hfueFnZmDMbxr0wKXJn8SDcHFA
         Tqlw==
X-Gm-Message-State: AOJu0YzqgdBwk4g7OAS2Y9Rlf3KdHbaxc8cAw+DsaFhjdHLSIJZKnNMT
	/VWEqaYIvpCrPRg+RLH8qu5jT71i0TTx0WV2yS+r9Ou2jH7z+Ec7pPrYsfZpIs5Y9iPS2JraZEH
	PfFtqvXE4r6xaOUA412V9XKZ6aEea6VRMORMLk83cXb02+TFs+pzXreq9Il6l41M=
X-Gm-Gg: AZuq6aIM4C5aS6gI63P7ZCHv4P+BBuVPzlV6QOlyUEJLMNYtb2Xs+aVNX/6/vIyJ+es
	OXAwNc/AMOhhNG0q9vp63xaSJF1xWlQd0xGtaTTXosDCep8s/xEtz5pokjeR8HTCvijDCN1/gyS
	o4OdDniSwsmgApGMgJ5t4oPkrr/Sno/fQO24OJvWkdG8sKLTB4zbMO33dQPd8GyDAEVZ+zxkXLq
	/7qBpIAK4HztxYpxBMeRvDuKHhV7T9TtUyWSw06RA71V/yh72BXaablB1fFl/YqiwMnr+WrKAIZ
	D1LywHjlxXWfFo5OipsvZ7oo/NqcDW9svENQIqx/jKciIJUP5XtHQfMSZy7MP9eFcwNacIz27Wh
	y+v1pAGQFRBgEtiLH9g5VLBxKH4luDynTAbOzEeYcUm6Lzgwa2dMdk0Rf
X-Received: by 2002:a05:6a00:2d28:b0:824:374a:13f7 with SMTP id d2e1a72fcca58-824c613370cmr13273737b3a.55.1771327175578;
        Tue, 17 Feb 2026 03:19:35 -0800 (PST)
X-Received: by 2002:a05:6a00:2d28:b0:824:374a:13f7 with SMTP id d2e1a72fcca58-824c613370cmr13273711b3a.55.1771327175048;
        Tue, 17 Feb 2026 03:19:35 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm13181914b3a.50.2026.02.17.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:19:34 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 16:49:10 +0530
Subject: [PATCH v2 5/5] PCI: qcom: Add D3cold support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-d3cold-v2-5-89b322864043@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771327148; l=6515;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=IAVEMPt0tOVYVQCFgBm15tr3uSMRBtLlDbxbCnOFZrQ=;
 b=wjF9Ok40l0LOgqKQkkPhl/h8dRDieyHrE+JHl4vXu3qG6H5Qh11tQtZ8Q5SfvNRzzzehxTmMs
 jJvG1KZaYAcBoHrk9mJo/xorBCcy23VvTGS4SE/tE4tf96AU3a1QeZ7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=XKo9iAhE c=1 sm=1 tr=0 ts=69944ec8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=RN3yzfvplrNe8VIVIhoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NCBTYWx0ZWRfXwwiSs2qpridl
 WttgRar6I19x7NdDuZ/MlWeiUuNvhK0iCF+Ex/720piyj6NkNDbvPhds5y0PZH7d5VsWC15xQWb
 gAIvXgekBaTE2L9DC89wkdDU2fKugkbqPVoMFz9sBJTyi/VzgvOIUV+vd/SMjq6gRcsBvWMAOun
 T8I6NFhrFxjvDv5WRqLmUInCRhIsAmA15LSS8EQro2zqJiAXuqdICODpQ4Cj1rfWXgW+j8rj3CG
 WlRy25dm8LVH8Jse9pJVBulqfnWI/I3baHewpquMqK6SyKOxpX1yydVaKmGbSS28afjuioTcVUa
 EBpFk0tpE5haFZejuFpSvkaMLQ1YayfllZU4bc+31Kb+OUUEBj26YIdk3N0ui5v4ST54LbkGuA9
 IqRtRzE5oJY6Nf1hsIke0k8Y7XcINv+AS1P7tOLCfX2qExAzA5PSCM3oUh0Jpvc0HiF68bBcD24
 Yubef5XWZXWdgAva/bA==
X-Proofpoint-ORIG-GUID: r-xi2sJCbWKINQRJPL-L1Qy7a1HUgI-9
X-Proofpoint-GUID: r-xi2sJCbWKINQRJPL-L1Qy7a1HUgI-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170094

Add support for transitioning Qcom PCIe controllers into D3cold by
integrating with the DWC core suspend/resume helpers.

Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
into the DWC host operations so the controller follows the standard
PME_TurnOff-based power-down sequence before entering D3cold.

When the link is suspended into D3cold, fully tear down interconnect
bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
by keeping the required interconnect and OPP votes.

Drop the qcom_pcie::suspended flag and rely on the existing
dw_pcie::suspended state, which now drives both the power-management
flow and the interconnect/OPP handling.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 121 ++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b02c19bbdf2ea5db252c2a0281a569bb3a0cc497..37442bbe588c36b0b0414cc4d0016da2d8424a87 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -145,6 +145,7 @@
 
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
+#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
 
 /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
@@ -283,7 +284,6 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	struct list_head ports;
-	bool suspended;
 	bool use_pm_opp;
 };
 
@@ -1401,10 +1401,18 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 		pcie->cfg->ops->host_post_init(pcie);
 }
 
+static void qcom_pcie_host_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pci->elbi_base + ELBI_SYS_CTRL);
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
 	.post_init	= qcom_pcie_host_post_init,
+	.pme_turn_off	= qcom_pcie_host_pme_turn_off,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -2069,53 +2077,51 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	if (!pcie)
 		return 0;
 
-	/*
-	 * Set minimum bandwidth required to keep data path functional during
-	 * suspend.
-	 */
-	if (pcie->icc_mem) {
-		ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
-		if (ret) {
-			dev_err(dev,
-				"Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
-				ret);
-			return ret;
-		}
-	}
+	ret = dw_pcie_suspend_noirq(pcie->pci);
+	if (ret)
+		return ret;
 
-	/*
-	 * Turn OFF the resources only for controllers without active PCIe
-	 * devices. For controllers with active devices, the resources are kept
-	 * ON and the link is expected to be in L0/L1 (sub)states.
-	 *
-	 * Turning OFF the resources for controllers with active PCIe devices
-	 * will trigger access violation during the end of the suspend cycle,
-	 * as kernel tries to access the PCIe devices config space for masking
-	 * MSIs.
-	 *
-	 * Also, it is not desirable to put the link into L2/L3 state as that
-	 * implies VDD supply will be removed and the devices may go into
-	 * powerdown state. This will affect the lifetime of the storage devices
-	 * like NVMe.
-	 */
-	if (!dw_pcie_link_up(pcie->pci)) {
-		qcom_pcie_host_deinit(&pcie->pci->pp);
-		pcie->suspended = true;
-	}
+	if (pcie->pci->suspended) {
+		ret = icc_disable(pcie->icc_mem);
+		if (ret)
+			dev_err(dev, "Failed to disable PCIe-MEM interconnect path: %d\n", ret);
 
-	/*
-	 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
-	 * Because on some platforms, DBI access can happen very late during the
-	 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
-	 * error.
-	 */
-	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
 		ret = icc_disable(pcie->icc_cpu);
 		if (ret)
 			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
 
 		if (pcie->use_pm_opp)
 			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
+	} else {
+		/*
+		 * Set minimum bandwidth required to keep data path functional during
+		 * suspend.
+		 */
+		if (pcie->icc_mem) {
+			ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
+			if (ret) {
+				dev_err(dev,
+					"Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+					ret);
+				return ret;
+			}
+		}
+
+		/*
+		 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
+		 * Because on some platforms, DBI access can happen very late during the
+		 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
+		 * error.
+		 */
+		if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+			ret = icc_disable(pcie->icc_cpu);
+			if (ret)
+				dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n",
+					ret);
+
+			if (pcie->use_pm_opp)
+				dev_pm_opp_set_opp(pcie->pci->dev, NULL);
+		}
 	}
 	return ret;
 }
@@ -2129,25 +2135,46 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	if (!pcie)
 		return 0;
 
-	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+	if (pcie->pci->suspended) {
 		ret = icc_enable(pcie->icc_cpu);
 		if (ret) {
 			dev_err(dev, "Failed to enable CPU-PCIe interconnect path: %d\n", ret);
 			return ret;
 		}
-	}
 
-	if (pcie->suspended) {
-		ret = qcom_pcie_host_init(&pcie->pci->pp);
-		if (ret)
-			return ret;
+		ret = icc_enable(pcie->icc_mem);
+		if (ret) {
+			dev_err(dev, "Failed to enable PCIe-MEM interconnect path: %d\n", ret);
+			goto disable_icc_cpu;
+		}
 
-		pcie->suspended = false;
+		/*
+		 * Ignore -ETIMEDOUT here since it is expected when no endpoint is
+		 * connected to the PCIe link.
+		 */
+		ret = dw_pcie_resume_noirq(pcie->pci);
+		if (ret && (ret != -ETIMEDOUT))
+			goto disable_icc_mem;
+	} else {
+		if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+			ret = icc_enable(pcie->icc_cpu);
+			if (ret) {
+				dev_err(dev, "Failed to enable CPU-PCIe interconnect path: %d\n",
+					ret);
+				return ret;
+			}
+		}
 	}
 
 	qcom_pcie_icc_opp_update(pcie);
 
 	return 0;
+disable_icc_mem:
+	icc_disable(pcie->icc_mem);
+disable_icc_cpu:
+	icc_disable(pcie->icc_cpu);
+
+	return ret;
 }
 
 static const struct of_device_id qcom_pcie_match[] = {

-- 
2.34.1

