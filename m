Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760634F490
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600468; cv=none; b=RyQYtA2xD/iHE+BMwOy4OlnQdN8HdGkSaOVqbfEFbcoHX6pH6pQZ/PdRpcuMTntWDXOcXMsp/J6u1hTRGN4Jv5z5n6oMwhTk5c1siRxTWG8UQn7H8O4M0EGab9NnNhUvywGidymyKeQJSAiXghTwTUuoDx3/7Q7aQUZaw/Tr+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600468; c=relaxed/simple;
	bh=HVoOGzL63Ijzzcm+Ssa/TUlQo3nbrzHFSzAS3cC/ySY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhdTI1DBdVnc5KuKulIKLqI07OWeWid6fHYPFR7IPYnYVF1q5YL+xcMyazXVf/WVms2xDeVrJaqrGA1mmmHDwcZXKsjuf+kGAS31AKwbcNgUZSS/n6E3PD0eC44u3RZlDK+YrvJpk798seas7vxsIPOLv7mQCWuzx89dV3Q8Zxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lGCW27Wf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jhbIPFqR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lGCW27Wf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jhbIPFqR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S927jU320202
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MI2ACCcBLhNm8EawqxzIFOQ8LYd0rskoVDW7w3nT58Q=; b=lGCW27WfxOhtkMg0
	xmAYayt5U+Y4tPqs+Uhg0uS4WmAMsvMTCmP16m52nowl8wApNPqpodNX8gvpZTju
	iX9dlYsJ6iO/VFEqU7MWR6GOiLGS6305WEwB//yfv6xL0ADbMADFJquemAasWEWd
	Bbs0NFoYlsIRhIVnc7Ox2E0Sd6JzgPASWJt4pDBu/tAC47Cch8q0qv4G4sE5XDhe
	3Ne6hfc8LNysM2HYBOpuuljmwVCrjJRYZbrig8DblK0I/henJJErPRUTfqbgIGiB
	Kl86j1oypwFeOd8sGoZm3a7O33LGXruVlX+LD36QEcG2rwNo3jCu+cxQ+A6RSz7B
	OMKPXg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by4sjtj6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:41:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso12751394a12.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 03:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769600465; x=1770205265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI2ACCcBLhNm8EawqxzIFOQ8LYd0rskoVDW7w3nT58Q=;
        b=jhbIPFqR2uByjGBFSWZAYp1ehyAIJ6rsNQh0PseQeOP07Ws9v4XMyF5UQeWEg9opWo
         6V+HvLia/hDE2wZJ5eAMASSxnNDoeyCIfy5dchPTjEgEi/Ovbp+9Xf4XA5cBs+DWbhlz
         h3PFoidsuBdu72td7B5huK6+JjW4DSY2kqgoJQM8B6ck+CzfQPxcHCZo8VU1JcNXoqhw
         RkFThP3rDltm1Qowvx4sDXfIaMcysKhdXxlGKjIwbi8clIeTDLhadSbNqZXQ5mPrb3WA
         68Z0kDyEZFCkZ4nMFY0hltDWg3oJEvvQg9qmXC8Ljup/cJ7j0aY7XoT0yR8nepz4r4mm
         cNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600465; x=1770205265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MI2ACCcBLhNm8EawqxzIFOQ8LYd0rskoVDW7w3nT58Q=;
        b=uY7NLPHUo3l/Mb5UihOjhUP+nZFIOsvmy0eQLw+c94/JExl3bUuj8NhOwjS5t45E4Z
         J0jUksK9zga6OrlBnHfrRidQrDah1GCYO9fv9zmbAuEbnkk/lbirU8TNnqiay8Yx+DhV
         GwBTLUomwHcKYtkIZlMLbdvYbc7tsnHGhLeGB95zqTQV5N+2jwRpkTncKFwDmFLf0ODB
         bx/O6T0qAZX2VdV2vXPs333ZgivDY8loWrKW9JJK/4OsWLFo77zyjHMf0LSpKMpyr0Uk
         FaYpHG9IDdHxpsahkJHJGx8z/o9yC8WTcD/uS0mW1Io1YV58uh8/GbNUidKb0GN2yoFF
         Pu0A==
X-Gm-Message-State: AOJu0YxzJvCWDmLP9C8h/75qN3ZNn5xxRax+NWOqlM8X5eE3L0XDYNbL
	03WnH6vPLISTzMm4c9r3877lWveA+nZLJVOuToSfs+ri3IbXBbqwKNRSdoZ2kqXnUV887HmWgh0
	YrUy6GxvSypy9c0tV+mmXYKadIAiCBd+Uzd1GgcPAT3168pwke1n6y2p+xVYucIo=
X-Gm-Gg: AZuq6aKSIYF+Zr7Vx6cG+VcCjF1PIxuKr1nQph63Ov9swjDFSy/cZj6OhKuLrGPgJLr
	t5oqJPLgcL0lx9T/zfw4GywxXP9dyQ7yvINJ044hybX9wFhgQpKmElTtq/QFcBr8nmY5jYNdCxr
	/7b6zcPF93ammKefdnLNO6FeS+K14aOjL4ZNbHKG80mxghMy88iZQvAV+re4+EofGrhm3Jracei
	X6y+aXe2rv4YKPZZ5xJ1mg0BhG6eTSOfsIq5RE975k6q5JqCj9VFS0ll/Qsy8XuA0YFBnavZRRh
	F4y4IiwLmYwMh8W8Iud8i/ZuhWPrJLgwYk+31aNbDrgn0Hx4U4T4+ByiSxGI/W2QYot4R2w0qnG
	rrukWrqe2Aoc8SKUkmzxixr+hGDTOKv134E40ehmt92nb
X-Received: by 2002:a05:6a20:9f05:b0:38e:9c64:bd39 with SMTP id adf61e73a8af0-38ec6551533mr5233569637.44.1769600464652;
        Wed, 28 Jan 2026 03:41:04 -0800 (PST)
X-Received: by 2002:a05:6a20:9f05:b0:38e:9c64:bd39 with SMTP id adf61e73a8af0-38ec6551533mr5233528637.44.1769600464044;
        Wed, 28 Jan 2026 03:41:04 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f41d0sm2010678a12.27.2026.01.28.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:41:03 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 17:10:43 +0530
Subject: [PATCH 3/3] PCI: qcom: Add D3cold support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-d3cold-v1-3-dd8f3f0ce824@oss.qualcomm.com>
References: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
In-Reply-To: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769600446; l=6254;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=HVoOGzL63Ijzzcm+Ssa/TUlQo3nbrzHFSzAS3cC/ySY=;
 b=CsCdEyib+IazFFEPavyzrwGgd4MZSvEXbcDP68eJlH11HaYRD0YNkrmgi8ygULfmBrSAlkeyQ
 wq6ImzoJ7xsCVXM7kQgEAsJ3AC/yE4UYBzxQ1iYDV0csAg8B7Rcy0P2
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5NSBTYWx0ZWRfX2HPfc+q4x3AV
 7Qth9cmXamD1gOjWWaS1ri8B/4pG5Ri+h4l+mb3Kym1oPG+kmZfBJlZxtCHvNSyOWUjzppPNM/g
 ZLzfTWbDCOyWDxvlvYLqmIdVuRo16luooTb0BDlzxJ2FCLCoEi9meX3v/2PQekYtNfLllg5KvWg
 zy1BlHnx0AknERHr8/iGpfDC6F1lD9Dl8G9oquPzb4hOSIgkWFG8WaNUSNxC5Nr0lgNUxiIBYdH
 fIAZZC+maQitcWrsZcwO0keWhme2Qlm10kGxrL+USDNzbWZ/OOFwkArnMEzdO3C4i2oBuPQhIqP
 LN//I63txgsX0T2KKXG0i2IXP1nN69TrJAu9SMqxEeewhmVqttI29szBtOpkcnBLSNXhKKhV07B
 zUEjHITfNIv5wneIP3fhwasRDlj4XRe24ojhnEIpeXdXTWmj/ZVTTsGNGxDlMoT4VFjETayEZD1
 XezmCOJVPLJ8E7l5agw==
X-Proofpoint-ORIG-GUID: 4KeeU-S2bZsKdVRa5HghFWuKoPE6Z4Sw
X-Authority-Analysis: v=2.4 cv=KezfcAYD c=1 sm=1 tr=0 ts=6979f5d1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RN3yzfvplrNe8VIVIhoA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 4KeeU-S2bZsKdVRa5HghFWuKoPE6Z4Sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280095

Add pme_turn_off() support and use DWC common suspend resume methods
for device D3cold entry & exit. If the device is not kept in D3cold
use existing methods like keeping icc votes, opp votes etc.. intact.

In qcom_pcie_deinit_2_7_0(), explicitly disable PCIe clocks and resets
in the controller.

Remove suspended flag from qcom_pcie structure as it is no longer needed.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 114 ++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7b92e7a1c0d9364a9cefe1450818f9cbfc7fd3ac..bb4e5a29c452a6c0d4b31b2a9ff3aa62b984fb64 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -150,6 +150,7 @@
 
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
 
@@ -1075,6 +1075,12 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	u32 val;
+
+	/* Disable PCIe clocks and resets */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 
@@ -1355,10 +1361,18 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
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
@@ -2016,53 +2030,51 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
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
@@ -2076,20 +2088,30 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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
+		ret = icc_enable(pcie->icc_mem);
+		if (ret) {
+			dev_err(dev, "Failed to enable PCIe-MEM interconnect path: %d\n", ret);
+			return ret;
+		}
+		ret = dw_pcie_resume_noirq(pcie->pci);
 		if (ret)
 			return ret;
-
-		pcie->suspended = false;
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

-- 
2.34.1

