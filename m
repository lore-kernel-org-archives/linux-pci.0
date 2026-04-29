Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74338F25F
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444981; cv=none; b=StvgPwlXB4yD3GdL8y4k+9aFgwOAnnZ1/WQKzBuWLAHibOtzev4cblst6G1ChkE8QCFETVp/PR7oNIm+b4KNKoQpGdJSoKCe04rddQ0gBAlfxns/omq1g7sHKPglIyNBbUDk/IhPcQuwid0DUbeeOAJJ+BnADlpCbAo+Esr7b7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444981; c=relaxed/simple;
	bh=pA76AmsNQb6QnqOiWK09b1zUzJDidnd19LIa2CcRAH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3QSG04blXCqp1Q55zOFkbRNNEVm4bRYxq3RmDrebjw8nlbx26L8QX6Fivawt3hD9oh1pIi0Rpaga2wGUNW/vTlhWDOnzTkdg1jRt3O7Q4PabvEPONznGl2V7HhEhgMi+yMXlqzLK2MP+VDkIJwDn0NY/1q5BU066hoao/ppBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QettX4S0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q9Aj5z7/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QettX4S0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q9Aj5z7/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T3YbMS017747
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hq//0MaTtB+D8Slz74o3QINBfe6mU8ByJ3ZjSrdZlow=; b=QettX4S0iLWjYPHi
	FTry+GOYf9EN4MCZS21DDK6lWwoeIaVCrqaYjhb12u1AuZHfDrJfpEGJF3H157+u
	TdRZUWD2xCLSIDpx+d0JGThXImnkN1LzSrY6sPV2Nqfief6hKiPeF8lOYgLboWgS
	F/39v47nnF9vgdFRT9bcq2mHnow7adqAoyWpgH6MpLid01qywToLqQDMMryqmknY
	wn923A9qek6cXlajP21RO5wni4uFH+YhCEyM8/T7IBsuFHBJul65tbOEXny/nhWc
	++PRj76dtgcuJSSM7P7ilXe9So2pT0sHSiuV87h8NEc42Vq+Is6T4YY5CEvTfnGh
	kNl0PQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du1eeabc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da86144daso11794146a91.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777444978; x=1778049778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hq//0MaTtB+D8Slz74o3QINBfe6mU8ByJ3ZjSrdZlow=;
        b=Q9Aj5z7/VYNnFqQsvZoisH+XPUmurFBF0xt8oBhlXeSqIXs1Az6lo7oB6SA9BTTH8k
         HesZNI50kU07iOQH5U1fnJFT2p1axyUR3H3JG/j4qjAKTEpzu6JVIebmThXMstMU1z4I
         JrNgHvHJ7MgEIILdSu8o1DmnSIQtlCiq/Vrs/TDqgkcbRVMqOq5bxSbjM9KNC1MVSHKv
         qGsHImfJruD230wtixLNZUlhJLyruxIsCXcoaNHayXSeAndyXqWrXme874EUi2ZfLu69
         4Reyu8cUEh40zlnTPeN6tO+4wR0uytRxewMPDWBUvHGQQr+THPcdc1qGO0hS9YhTW5q5
         pSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777444978; x=1778049778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hq//0MaTtB+D8Slz74o3QINBfe6mU8ByJ3ZjSrdZlow=;
        b=U8GanM7Sdk18TapLpLryjgyoy4pXkPhr0hCP+GEzAUK87W557f8kabHk9mwa+Kr4NR
         qVc169MWzzC21Re/nLy5AFr11EMKDJtgbXvwpZfEb2w+4Qmy2eNjuKd772M+ml+DcLHv
         mvQWdWFfeN29VQ0muEf1REzGv9at5wS3ShAcCiC2Mfmpyc5ChqPKKsSvEnfmFFH34jGU
         TP2oRXvOVqyk3la2vG0v68utjcTNxsuREZ+XltWhOOEtYjuogKoEh3RW0auedVUji908
         H1mlnm7pU55ax+WAhPSj3c9hQfNJVbLv2huWo9tDTvG7ZU+2xhUnLZxXW+2Q6YDpCfR0
         nu2g==
X-Gm-Message-State: AOJu0YxJNOaYgZxlEobxFyifsUE3bpTuDUmXcUW4t4ua0eM9gzFhXU35
	RbZf7v9KdAwG+UcGV+GqKU+Nxja74GaB28SybGZM69YTBgcP6fHyhifrSyP0j7TfDq3nDKFRiix
	OEc8uUp8P7BX4JMJfCeF9e+SHQDVxHwpyh+r2vYti7xk+oVAGHaRMOPXxdrJk10U=
X-Gm-Gg: AeBDies8cg9pKxCjhoQNwupB644Z7rrWtJ5kX7jvOwX4KjQuodzXsvLUJ17J0qDB+Mb
	qlLWkyUC27+eh/0vh1V/PGEeOpdzpWyHoDcHG+Uw0CZbfc53ZpoT2Vsl1up7l7faIAMynKfR06k
	gJ4R1BPYJvVhW0Ip83ELbp10lR1xFgvrZswkvIDWR0m+Wx/PuXCsTTIUGiETn1Z2mkdVaIibEIq
	vpcSNAxD/BM8bg3ouMJno+3JyhUJJQS/lyS6+rIILb2TVTe4qtYjo5+FJ0hHt3rFyUT67QmcbNM
	lbq5eNXY8rpge+erxnsw6qrD0VuCUsevZpJzGovwXlQuQHsBPla2xgYwKbzgsxpJKJSAKFU6i7p
	iMAQCaZVpeHuSDfZM12sPS+phZQLL2OIo+Dha/VWatjhUvBzMw0AjGrV3RMrdogZLvjc=
X-Received: by 2002:a17:90b:5865:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-36492046f97mr6801405a91.19.1777444977834;
        Tue, 28 Apr 2026 23:42:57 -0700 (PDT)
X-Received: by 2002:a17:90b:5865:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-36492046f97mr6801368a91.19.1777444977296;
        Tue, 28 Apr 2026 23:42:57 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303d59sm2021414a91.15.2026.04.28.23.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:42:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:12:27 +0530
Subject: [PATCH v5 5/5] PCI: qcom: Add D3cold support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-d3cold-v5-5-89e9735b9df6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777444949; l=8346;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pA76AmsNQb6QnqOiWK09b1zUzJDidnd19LIa2CcRAH8=;
 b=rBSaTdbJhOplkic9jOdMuWUYoZEN4Z5hY6sphVVqaapCV9NZRGxNjRynDSrXYWSeMPcIp8xB2
 /VMqJixAoW2CPphPAtumG5GxoEqm/AT6P2t6yJ4dDrOsgeIhSe5Pclt
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=C/7ZDwP+ c=1 sm=1 tr=0 ts=69f1a872 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nOXFll4yYCsuIFAjJyMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NCBTYWx0ZWRfX98WSfFIOtNAW
 BhvrWJVsznp0+eQtdz7D9hOi9SAjefsd9ZvH7LcPI3LNiVJC87hWO6Ygp5UistLAk8rhkhQ2xcV
 ZikBMNJzANXS/aMohfz33xnGu9ifsowFOflEMUQdNIJEFt+cBlDM2uKwfDksnbGeVS550luimjc
 vV0lJ4efWLzDGsuEdBu3NT4GaBTubtAfV/L7OZiFFzbLw7hBsIwJR/KXK4JymlVYDhU275ZiQpa
 NDfkIiGcvmIKXUiVKWFDp1F4CSydgC3ux2IlnEh+EDgBEYjaQiPffuzxWRF6OL3eXqD1LmnMMzX
 a65GOAxwey32GYTMCn48RU54Jw8xSqD3qxB8Cc7vd3mqB9d2KPnN5uNckxUWHQh1Amo/Jx4pCOg
 t6pG972m/qz0fzV2Arpize3oiCr8jhs9rcrxFFlTPN7SjSlKJWJUWeMe2ZCIIc/S/aOdKdxBqz2
 k4sZdvFzxlVBoyMAXDQ==
X-Proofpoint-GUID: Uv3HRCOGtkEHhgpYL4UKB3Ou20RC79Cm
X-Proofpoint-ORIG-GUID: Uv3HRCOGtkEHhgpYL4UKB3Ou20RC79Cm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290064

Add support for transitioning PCIe endpoints under host bridge into
D3cold by integrating with the DWC core suspend/resume helpers.

Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
into the DWC host operations so the controller follows the standard
PME_TurnOff-based power-down sequence before entering D3cold.

When the device is suspended into D3cold, fully tear down interconnect
bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
by keeping the required interconnect and OPP votes.

Use dw_pcie::skip_pwrctrl_off to avoid powering off devices during suspend
to preserve wakeup capability of the devices and also not to power on the
devices in the init path.

Drop the qcom_pcie::suspended flag and rely on the existing
dw_pcie::suspended state, which now drives both the power-management
flow and the interconnect/OPP handling.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 155 ++++++++++++++++++++-------------
 1 file changed, 95 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9dd808e85409..94403be5a05e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -146,6 +146,7 @@
 
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
+#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
 
 /* ELBI_SYS_STTS register fields */
 #define ELBI_SYS_STTS_LTSSM_STATE_MASK		GENMASK(17, 12)
@@ -288,7 +289,6 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	struct list_head ports;
-	bool suspended;
 	bool use_pm_opp;
 };
 
@@ -1364,13 +1364,17 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1395,9 +1399,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 err_assert_reset:
 	qcom_pcie_perst_assert(pcie);
 err_pwrctrl_power_off:
-	pci_pwrctrl_power_off_devices(pci->dev);
+	if (!pp->skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(pci->dev);
 err_pwrctrl_destroy:
-	if (ret != -EPROBE_DEFER)
+	if (ret != -EPROBE_DEFER && !pci->suspended)
 		pci_pwrctrl_destroy_devices(pci->dev);
 err_disable_phy:
 	qcom_pcie_phy_power_off(pcie);
@@ -1414,11 +1419,14 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 
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
@@ -1432,10 +1440,18 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
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
@@ -2102,53 +2118,51 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
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
@@ -2162,25 +2176,46 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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

