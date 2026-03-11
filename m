Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F083CBE97
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224841; cv=none; b=fNgkYMFggnYmMsA0+M1Xoa2LRhO6IbXznMAfSgZAn2a8JTpezi/C7QuhqwDMsvdEdjMzcedsNSC0Vyjf34NJpDw+7Zihjb/Uc9RyiQddNbre1cuzp+xvLBf54Ir8Bk7NbgqwhdyFCuA6uqvY47XfIkIzR+gRVcL5MIF/gsdV60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224841; c=relaxed/simple;
	bh=0v4Fkx+XZDjpsl3JOqkuJUc5cmWHZo8Xz0ri4m2aC0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuFFWbELiJwZqTMsbYx/K/QuKIwIyvARuxUAmIgeNU1lVxEbW2sQJUpN78AIaGaeNTJU/MeTaMnfb6oLNDT1lQyCCZjoAlvHqWqtpuhnxHy/pQy+tgR72iAwrbI/IotL9nXTOvxV4w3pZTXzHV3XCzweXMK7OlIThL5ZnfvToHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4ydBhnX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aotEEAx2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4ydBhnX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aotEEAx2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B7Q1j42030825
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0UWEk66tIWWw7Zu8KKDmTOs/vpX2yaROK7XddUYgkx0=; b=j4ydBhnXyrXY+Y95
	L64lGMl5TB39e2h5birvkeaTnWCDQ60AvuTEwNgXlV0KgFocZu75Lpp0vwMnNVxG
	YPlyOdoAgIb4Cox8we9nSty/Ci5O5kaWgHIiNwndKOsS7JDWzheZIedxuFz4yGOE
	wnhoCeOwBAFohovg9Ciy/ib8pVzecKl7HnY1SPUTWy5UpvqS7q7diiiDrmqwgTcG
	wEq46vxWNxk+JB32y9XZY6vlwwGLLemzEyzPNR1RL//ikwp3Rfa5E+Q30dviTl21
	oA+y5WNfaQUHEHnqMhW7QHOb8y9OktNWkc7kzwkhhEbAgcsutNXZssO7z+aXWb16
	NG3Ugw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu40h0qtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adef9d486bso128529955ad.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773224837; x=1773829637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UWEk66tIWWw7Zu8KKDmTOs/vpX2yaROK7XddUYgkx0=;
        b=aotEEAx2L88RLPNYjdzGHPIPBgcepYHJvXRae+fQ78E1kMnxBHehYWNeUr9nrbvev8
         PTJtP4FEYu2f+fP14npArkEwfA0YlX86aMMNVzTJylLrG6wyY7yBbmD8Ix49yXNCD+xE
         98Bwemechh2Ldes/CVlBOnOZHl0gq0uMTqyRJRApbhAOr3rb/JjKgQtIGaSL+opDnL/M
         /+KJ4VJBOXzVEYQDpBaJBYxAg2dOw1/BuPcWRKEBMtVYzkWdZ+xMu2ucEUmdcveCaPk3
         1Dez5YclyoWHGhz94a6YfCn6LtArCaGtdm8KtH2fhjGXcKr/cASNw2J7/YHFi6wKtMc5
         wbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224837; x=1773829637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UWEk66tIWWw7Zu8KKDmTOs/vpX2yaROK7XddUYgkx0=;
        b=m0DEFu2aSfuXvKFxkZA0aT7rCLVXALtDBH2vAFFtDpzWWwPfMItV+trUSHmhtCgs+N
         cGp/RadTDMnbkO8DQg2mwxNqDlLRbRHAxY/4wn9yJfmCsL9AdnCLUhMBq4fWjjsnF/pO
         YcvZkcvRSCpdSDUONzOcS/5sc097R0Xt79R5wG74AlBcl76vqpb00dz+HfdVry9mN/LZ
         IZohaYRqnxUOgkjrnawBUyN1SR4PY90sYTc+00isPogbJ6bqckketro2e/zELXEU6Q3g
         mJ5PtMZ2GtyigXbuRfkTCdMYKdYMMhLs8eXBgKF2PbscG6G4LCa6r0oHs1NByhX+ZOWs
         LYfQ==
X-Gm-Message-State: AOJu0YycdwbMDXQNp/bYfkLdZYcJJ1Bd5Kx6aD7aWPPdGdZrPAvqisz/
	sh4T4pQ+86ELs0EwaMyNq1FQQRqIWJnk1mCJJK+5slnlxJMf6pQJ/nP5vB5f7kMIxz/o0Olf7vA
	vcJ4ubEnATcZM7pNatm09SAiOk8J93MNtc3MBh79M85EE863MI4/BNVjxqoXUg/0=
X-Gm-Gg: ATEYQzwixmVbU7PjZqlNgvhrGue4b2ozjcVV9jA8LDADtbaRPHozdZNPU4z4YeW+1zC
	h0Hjhwn3kirWTGxHDCGjCkEWgfCQfJ/n1PSUSkCuPH/J4img+MAxoehO7js8pxe9+Ut1kbl4zi6
	eWX+qcUg/ulXLWEa29RJIhtsoeKlRSM8LsJNgUflzIFRiXdH83NODBhk2Tvoc+KwuO+nYm7xYR9
	M57mare387YJKYIKlq6DNOb2Zzx+tLhqQer8tXGZnSgJbejV8u4/OIxxNPlrC2x60TDN7i2/OPE
	9BE2lpRqNjE34kCj88TzZ4OGYSIdtq8fISeqdpFaVzUmK5BaiiZ2aEYwd8PHh/6aMj2fQdSJs/y
	qwaiE2tYiElNcfHVu0Yz7p6PEWeiR+Aa5TayAxZC8P1jQ1xf04/x4pUE6
X-Received: by 2002:a17:903:a86:b0:2ae:a786:6663 with SMTP id d9443c01a7336-2aeae882461mr21336985ad.26.1773224837425;
        Wed, 11 Mar 2026 03:27:17 -0700 (PDT)
X-Received: by 2002:a17:903:a86:b0:2ae:a786:6663 with SMTP id d9443c01a7336-2aeae882461mr21336755ad.26.1773224836899;
        Wed, 11 Mar 2026 03:27:16 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222872sm19575245ad.18.2026.03.11.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:16 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:56:50 +0530
Subject: [PATCH v3 5/5] PCI: qcom: Add D3cold support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-d3cold-v3-5-4d85dc7c2695@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224811; l=6534;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0v4Fkx+XZDjpsl3JOqkuJUc5cmWHZo8Xz0ri4m2aC0w=;
 b=SnIVcO4hLWZtCxfU7w8+oUn/qP8keFHFwEx8hZLsyGowOrb4LgEnu6sFoJS0pWt49wuPjv9rq
 wJHOkis+50XBeK+3nsfQvv9kOH6UvijOD9DQ7+BO/iBiHtFa7TKjEYz
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4OCBTYWx0ZWRfX3ev/Y8mwOVei
 zrMNl4W09YcVbbEdysI5F0w3L9sFrk6qWom4EASNHbcIwiGZsD7wEfmApNh9S+4XDr3GyJ6ZQ4g
 ivOcGqv/QjGqKcwu5oHQSZd8qRBICJ+9otLTXvkywxwZQs3s85Kq7ieRKUosyocrO0US5EVxqQ3
 7VYdyqxmp6gWBQxh0Uwzbmxxjkoy7rf8JyqkY0QGR6ZfhXiaLDFfW8Z4nUC6SIkoIQV5ZldaIc0
 hV+bgTYG3QaRrAJCCBQSVUHX35fFuXQVU9moNwTX/q7MatQemYHCGV5JngZS2/P21GyX4uwyICI
 mAwabhsAR8WWePg+qK4RhzfGd1c+S8g+bnrwHby6nP2oUdLGVcoI2hycSF0Toby+ucvO8xV8y1V
 EmGwqwhyFirtW64UsEj87w0EH1TNHZZN6TXuSrTSVVk/cbyIkOG0ZCNFH/OpsG/iIdLyt2O5Y0c
 dqonYYsgkKnEQmbZKYA==
X-Proofpoint-ORIG-GUID: cH8Rq6cb7MN7NlVHMxujRl7S6jbxOrYH
X-Authority-Analysis: v=2.4 cv=YJ+SCBGx c=1 sm=1 tr=0 ts=69b14386 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RN3yzfvplrNe8VIVIhoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: cH8Rq6cb7MN7NlVHMxujRl7S6jbxOrYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110088

Add support for transitioning PCIe endpoints & bridges into D3cold by
integrating with the DWC core suspend/resume helpers.

Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
into the DWC host operations so the controller follows the standard
PME_TurnOff-based power-down sequence before entering D3cold.

When the device is suspended into D3cold, fully tear down interconnect
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
index c14c3eb70f356b6ad8a2ffe48b107327d2babf77..6c5e9e541d55ad7f90a2203b97847d15d56b59c3 100644
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
 
@@ -1404,10 +1404,18 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
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
@@ -2072,53 +2080,51 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
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
@@ -2132,25 +2138,46 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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

