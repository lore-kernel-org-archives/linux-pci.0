Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B13B637C
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567032; cv=none; b=Hn0ye5o+xiZzYJiaeJ9/z8Bk7AQr13DncEEmKzx7gF1dVvZXgFgXPcAA0ujiUSLTjEJOC/su6d33mUTJlpOS13D5VDYuSMdQOb6y0Up58ZDl6KLvvPLqqoFpXounGfW+FKJsrKnNdx/gDfyxagLeoOs1SDJ/6EDJtSXvVX4SH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567032; c=relaxed/simple;
	bh=W1OhNcEspfBwAlfmZve2ZqD5tZvvm1E8mVApzAXXGuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNQQG2BefGX3dPMC3bDaDSugRfGZSDz6EZAR1VvMHYv0Zq/1ZL+fpGDG5uZHSw1dij2YbCzd4amcvSW46cdaV64Jxz99Sl7dKp9oW+EtEF2tyzoTFXibVPW+WbUp1n/aJMWtk6hpXP3D03Dp2567FQ2qCHm0BEhJd5dslBfqg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bCnvo+02; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SBPvjqDH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bCnvo+02";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SBPvjqDH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Cc8f71405987
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 13:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	33isoV0yWVJ9xotd+3ciXf4Msdfdu+7UChBrj+6r8Zg=; b=bCnvo+02LZ73oC4a
	eqaGfX+dMblgz/tmkFLmUryVC8AsbKahxJw3KkHa49PXG2aIEFG4pyZQBGTAQNqk
	54RqPlyHWxE+hWnEP07Gz6MBvzGaTWbyreMmBdoPVRjVSs1NonS/wvoiK1vZjQFi
	DFcDlMeD+SnxH5B+ZOTLHjfxAqca00CboKsTjcW4f6VDpEerqFRFcuHKosXPQA2+
	se4Gzic4JU8h7qKl7kCiLKes/msnmiIkMHgllj4+F4tEHDw/rd371UB6vnxoYwag
	mtfyotCOoZ9kBllaT3KB9tkG190fFMhiikAAWZ19JT7ZWCNxDI4rvfWTPSgTJzhR
	c0QwHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmratsps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 13:03:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b256ed2cc8so54940015ad.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567029; x=1776171829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33isoV0yWVJ9xotd+3ciXf4Msdfdu+7UChBrj+6r8Zg=;
        b=SBPvjqDHoMwSnVxcv6XOLh4kIhI8YZZroVKIiSz4fTgoqAhd+EIP7GLf8ha3jggtvO
         3ovQDtFDH/YxdfO01x4vBJPh7HUG/8dQ0BvFEi6gWAS5r08AR9d8qUV2YLE65sz+70Q+
         lMgrwToICoaSGTJ5rdvb41lGCrLs6vt1G1HbMTgm+DcFbZ8WR+mjBvuHdMu3OBwsAokq
         fn8w9Is012qT3Hb2tC7vivi1pB5LGOG+tO3XXbaL6wRVa/GMJif3UD8CFp8/yGfyr+9P
         pYY63tb4u6vrWLCJJBFPIULuYL0U/KCPcWUhs8uMjkbAvNi4KrPi5MHJF8D72bBPT6nu
         bVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567029; x=1776171829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=33isoV0yWVJ9xotd+3ciXf4Msdfdu+7UChBrj+6r8Zg=;
        b=L/huDClsMWeJCD/frpD2tGGYzddu2LsNsnf86ShLSZrnknXD9LvIYz1+svo5n/HavR
         EVVSiZ/cfabMT8WByZLkcwh26dgf1iLWfGFd8dMrA7KOHmcISsBHIpxyMEOHuPmk7Bgj
         uxmWVi4HZ8yKjV2CbAPJEfCalk0+vqIaefZfUAiw1ikzPAkUNs5uvpX9JJhUDNHJzpfj
         990GHBL/qhpxK5yv8Ps85TbJ1hAnAmnVMgyzPTpnjsmlJCNv8BQXL+b2HA2/lAWeH18o
         SucU73iCVcoy9ktOwFxCg+359tvPSUtG3Ox345sMBdsak82f221+8nqCe7OmpzV63XZu
         Gxaw==
X-Gm-Message-State: AOJu0Yz1+cXeyQbkvMrBGNRzRSbF7yIKMnKwI4wylOk0PrPU1sKmB3Hh
	zLWKUv58EbYAs2TUwl1tqp8vr1ejYnVmRx67zKf4c+BOz7K2onud1pJwgXc6Vxzfe2/szVD7tMO
	v10DQhVnKWlfyyDWnp/ySRJ+TXGprjRIeYcr3gXZXVeKzMVJHABIrsvOtCIP0i6o=
X-Gm-Gg: AeBDiesNGmRGi8U0a4HNTs6BxBH2tyWBfJrgDA/0ZnWvYVygneJWFaPfHz4HWG6GTDz
	OtmH+22GU3ac8J3K59vhnjOn7/HgHKsRSLXce7wUnFdKiWxYEHSIcc+zVd6v4aUQzprW40BTs28
	PF8ZrSEd2XXbFD8zbJOt0e63UmDGu93kzAYYb/TpwfMcQuXDhfWlgIQ2Vx67Rqoh/aIWm/IMP65
	PxsITfcgBbP6otAvp8dG3zIhZgnS503KQWfP3pRL5sbaVjmTw8WPUfpWMNnwnC0Uypbr0bmR88E
	hsOugR9Eke97f7zlpDp0pQ1GICx3fxmwpInzNtmpsAIelAIAgqdvILn9TStcocL+BfZrzCyH3Pm
	SDY/5luiYb79hXTD8DWk9DpOmm8Qh8mvRU01x/lZpl+1LwOXuvNgQoZt6
X-Received: by 2002:a17:903:185:b0:2b0:5be9:f423 with SMTP id d9443c01a7336-2b2819180c5mr167577665ad.43.1775567028610;
        Tue, 07 Apr 2026 06:03:48 -0700 (PDT)
X-Received: by 2002:a17:903:185:b0:2b0:5be9:f423 with SMTP id d9443c01a7336-2b2819180c5mr167577015ad.43.1775567027939;
        Tue, 07 Apr 2026 06:03:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm181564885ad.53.2026.04.07.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:03:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 18:33:12 +0530
Subject: [PATCH v4 5/5] PCI: qcom: Add D3cold support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-d3cold-v4-5-bb171f75b465@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775566995; l=7930;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=W1OhNcEspfBwAlfmZve2ZqD5tZvvm1E8mVApzAXXGuI=;
 b=o5n5mzRCb1hInEwIP9Lo/mkqs1V+NaPD+q4D06Qd+qeyiIvLq3qU775agBpWtloe/QTme7jjR
 nCXcRkr1zXNBKMFJTclv0uXBflgy6ODXlnpBwnYuu/TuB08Ps/73MqU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: wxUSY-AF3roXzLfZDjaMRphm1QC__uUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMSBTYWx0ZWRfXxaCMyLE8NleC
 wAMRXNm+9Mce5N8Y87JTMfZEsjFKb0jt8awPeOfllIjMdIP67HpRzsbVGFSdTn0WhYawM20eKBL
 BbSQV4owTMLo30ILUcru3gBK8z59o1WkVkD25e4mf7DVfMVbdgygdg60P9kebrnu3aIcnOiwk8i
 TO2eP6tY+brOsr8+467Fxt9YP1sUNi2q0FY4ju1ifFW+HHnvsNOWdZ4TE3QFzMfFKhIh1Rc/s+O
 FP9i9xyS8y//03m9wMU17thGml26qRKCdCSIvmRSzljmWg6GZYB5oSrAYV1/9EVgKP87f64lYHu
 QNZEYeb+Ett+WCtbK3O83XxoTDswByDWhsRS5UZVzqB+hihgziFqCljmfNcJoasyuL7UAnAeNgz
 UBz63TeuA/L9xnsyeH5Ze6vxC36MNFkj+So7lNjB1yhc3RQ5WFClyYocqWKRT/qhUect73VevMs
 3r9JQGiHX64UkcKdH/A==
X-Proofpoint-GUID: wxUSY-AF3roXzLfZDjaMRphm1QC__uUS
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d500b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=3yJ-4rlz3SFKGY1FFUMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070121

Add support for transitioning PCIe endpoints under host bridge into
D3cold by integrating with the DWC core suspend/resume helpers.

Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
into the DWC host operations so the controller follows the standard
PME_TurnOff-based power-down sequence before entering D3cold.

When the device is suspended into D3cold, fully tear down interconnect
bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
by keeping the required interconnect and OPP votes.

Use dw_pcie::skip_pwrctrl_off to avoid powering off devices during suspend
to preseve wakeup capability of the devices and also not to power on the
devices in the init path.

Drop the qcom_pcie::suspended flag and rely on the existing
dw_pcie::suspended state, which now drives both the power-management
flow and the interconnect/OPP handling.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 150 ++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c14c3eb70f356b6ad8a2ffe48b107327d2babf77..e8d109c44dd270610272906244d1afeec3664f41 100644
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
 
@@ -1336,13 +1336,17 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_deinit;
 
-	ret = pci_pwrctrl_create_devices(pci->dev);
-	if (ret)
-		goto err_disable_phy;
+	if (!pci->suspended) {
+		ret = pci_pwrctrl_create_devices(pci->dev);
+		if (ret)
+			goto err_disable_phy;
+	}
 
-	ret = pci_pwrctrl_power_on_devices(pci->dev);
-	if (ret)
-		goto err_pwrctrl_destroy;
+	if (!pp->skip_pwrctrl_off) {
+		ret = pci_pwrctrl_power_on_devices(pci->dev);
+		if (ret)
+			goto err_pwrctrl_destroy;
+	}
 
 	if (pcie->cfg->ops->post_init) {
 		ret = pcie->cfg->ops->post_init(pcie);
@@ -1386,11 +1390,14 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	qcom_pcie_perst_assert(pcie);
 
-	/*
-	 * No need to destroy pwrctrl devices as this function only gets called
-	 * during system suspend as of now.
-	 */
-	pci_pwrctrl_power_off_devices(pci->dev);
+	if (!pci->pp.skip_pwrctrl_off) {
+		/*
+		 * No need to destroy pwrctrl devices as this function only gets called
+		 * during system suspend as of now.
+		 */
+		pci_pwrctrl_power_off_devices(pci->dev);
+	}
+
 	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
@@ -1404,10 +1411,18 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
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
@@ -2072,53 +2087,51 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
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
@@ -2132,25 +2145,46 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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
+		 * Ignore -ENODEV & -EIO here since it is expected when no endpoint is
+		 * connected to the PCIe link.
+		 */
+		ret = dw_pcie_resume_noirq(pcie->pci);
+		if (ret && ret != -ENODEV && ret != -EIO)
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

