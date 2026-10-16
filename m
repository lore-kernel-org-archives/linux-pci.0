Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85F4A482F
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155454; cv=none; b=gMeTbox2n3Nbllr5ujOeiZ8A4Yp+jfGp3qpH4+hvXL2H1EkQb+GxQF8qtzQSS00kzIhxvVsLrrhUCyaKMDdZEFzNjuDJR+1BBpryQwQHINrU5UQDqkKwV8yNZ2oB3hw8cSzmMkOUz4HSo/Tm9wGQYEPfnPf7ETp8stfREifQa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155454; c=relaxed/simple;
	bh=ib8kN+zutpgyERC03fFok903wnLQJ2cn8/iqOzdazek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ML6kmSlUyL/1quvANTIqb5g5pcXon+9OmjhdsXUNFWbhYkN/d36Of48fyHsUoT+0U2jnDUwx5TSKwBeW77Tirq/f05mhr1+Poqr770zFGIQiYddKwTHNfJRQFJGQvxWG/ZuzVEsb7kFxdH7v/OTqIjsOyfKgOQ1EgWZlZEqMrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNdbZpNW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VUo1uhC9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNdbZpNW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VUo1uhC9"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAE6q1983359
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ovxg1R8USPr9BWV1mSYFdl/aecC06ac6FLDeLyMSI/s=; b=bNdbZpNW/aqB+qbT
	v1cU1ijoRwt795WB9Yss/N9Ue1a2xoPVqOP2w/IiyQPT7TZFysJCd03nf403dvJW
	97HYlcIw9BXutDRXdl9llL733dy8M8NCN6udFMz/T5McNLS55EIO+mpgGF9+ylu3
	9hAMKI5TJ1/lwQoLDSS/2KJHdStShBQBwwKpZxeqDfuFqjbiZapu9gWLm7nrR6e0
	JiH2ki1fxje1wY9PofsfhZDTyX01ukaChV/uxgZQBsGlSVVwTPnHSix0jLHxGzl7
	QPLxklm8xYwVLzS7w1dsjXLFKSvQKm5Ctm//j/ILQzNNaTZJ/OELeWdzCoVFPAN2
	r811ug==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a8apgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3425098ae4bso1409548eec.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155451; x=1792760251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovxg1R8USPr9BWV1mSYFdl/aecC06ac6FLDeLyMSI/s=;
        b=VUo1uhC9pg+ga1APsc+VOU9o9P/6XmL8MAdjWa27TxMm4XsOMTEUmDFZjUq8sZRnxE
         pQvR5VUkEyJWZi24uph8CJl1+1Qd0iEN5iJQfts2bwi2hX+Ew5Qsn/qadML1lMikHOgk
         XjHGaUlbYhOTdp+70lWqEbjm6ENINtugybk4GeA/JVrjtWIUqBcwQkZmShSk7zBx3lRe
         1VMPA1rukK6FdcTCCrZ0KqFJOIblEF/6gVpUTOgpYfvSFC0xJhc0/M8VSsKyjPUsrjl8
         9+O+3kDkQS1rCCVNM4itCsCtJYr150uVLYEMsKRAtsKmZOxdfChLKkMDHMLKojcm20Sy
         gWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155451; x=1792760251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovxg1R8USPr9BWV1mSYFdl/aecC06ac6FLDeLyMSI/s=;
        b=qaee6TPHgV/GG7aspOzIOeAS55iaxfRB32agg3D8GrUaffwU7cimttO9BbjeC7f4eB
         JE2MCXq0aR/lAcmVfpd/uZl6wGln0w8FzJc6J26D5KIEUgE8y8aWXX702DX92DYjoO9A
         ridfaQsDyARTUbel8mpmmKttE4VzSVeFTIWmaZAycdpSKepFdtXH+TxmBGsZvaeOMij7
         8rpv3goyTn2gdPdOimHJcLgf9v7uUC2lMi66TJD9MV7nZ5RuFJ+GFMDkBU2o0h3/xJSn
         0rFlXdXYr33RfEKxcV4xFYvfDCSu6DIC7uE5AojQnGDe4KsCeIilKZjJww2zEqtHYJvs
         lZHg==
X-Gm-Message-State: AFq9FYJAFvHx31ZxsjaG/azMBrywCxWNNGMUQHtOxSMdy69t0zQeGEFl
	rx0O32MXwdIm65w1ju5yR1W1ZAj/Gbg33BlHnKHFUcDLzjaCjqqBQBlOFs9BxPV1AatBROAGhlC
	dkWjkgLf0dPJuvn5/Zb8eSVWwGCwbhs97a5sR1mVMh5Bd2kI/XPbjQhthGHowdqU=
X-Gm-Gg: AYBFou19m1hVy+fKhGSCpjumgGZUW8E1L2ssEB9ZOwKRJSoWOqGxyTu3i1u6IlGnte3
	rOVYVxG1enKKa2yltbTH3x06mEPF0f1qulWAiHBfPmMJWgBMXYEQoTJB7knNbBNcHDLPdi63SOO
	g/ffVoqMOYoDPd8iH3ZYBWGkBn0NBth4M3JAtjlp3fFIIF/kBvQkWYyqHcJjvQ6gqcc+7qMWjDk
	goDogP259/OGfGEZ4eMvScNWnwy0MtevzUAwy9aZ5bjg7soVO7g9VJF6IHCoCdIE29XkRo4LGu4
	FU5hufrSRFjgnMC600q5L2EZ4RgvM6a45tDobFlKGvAl2OBlMfxX/nSqo+nsn9ur0eU2ixHTtsH
	EReKZxIIimB5dHomCcqqBrmQHpg1LLHVvwg==
X-Received: by 2002:a05:7022:e989:b0:146:5f73:d45b with SMTP id a92af1059eb24-1824fa8be63mr4450281c88.3.1792155450972;
        Fri, 16 Oct 2026 05:57:30 -0700 (PDT)
X-Received: by 2002:a05:7022:e989:b0:146:5f73:d45b with SMTP id a92af1059eb24-1824fa8be63mr4450239c88.3.1792155450109;
        Fri, 16 Oct 2026 05:57:30 -0700 (PDT)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831996071csm6188285c88.9.2026.10.16.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:57:29 -0700 (PDT)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:27:19 +0530
Subject: [PATCH 1/2] PCI: qcom: Implement .reset_root_port() for
 firmware-managed controllers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-pcie-controller-reset-v1-1-51779736cf12@oss.qualcomm.com>
References: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
In-Reply-To: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rama Krishna <rama.krishna@oss.qualcomm.com>,
        Nitesh Gupta <nitesh.gupta@oss.qualcomm.com>,
        Ayiluri Naga Rashmi <ayiluri.rashmi@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792155441; l=2776;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=ib8kN+zutpgyERC03fFok903wnLQJ2cn8/iqOzdazek=;
 b=D60ip/GMyULXRdWpThlRxv2nYKGqS03EOplPh0LDWYmuSTEIPZ7dAH2Yv6MhZp9qutQgmgA4V
 nwMMy1qnhGjA1Y89dtPP5E9EzkYqY6SdGrEzp8duFJ0rmpmwW2xphDl
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX+C30l0fZzhiq
 PyaG61/rsQyMXp+Dyf5wd6lLTwf4NDW10yBNjxRJL6O14OZtO1HiiC1q9wQ2M8Fk7bg+4O+r4k8
 WexXSE8NVB5TpLgT3boi9zyE0SwDbc8=
X-Proofpoint-ORIG-GUID: 4VL9xdb2Y0gEJgpHMVyPSul-qSlYshTc
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad21f3b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_Z1ICBCpGxnOzRxCLNAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX93tsuBYFFn9b
 wJa3NT5cu0uGAHoH0FRSJJPEDLMmNlkukf3CSh/c5FtwovQKWVd8qyBl8Y5ClSb3Z55VMeLq6iT
 dUX7ohPyAM/GlPfJDXf+nAgK2nWS+NmM9X74eaI69lJgaV23xofB3QCb3QzPoYcvUqGrPGN+Mxs
 jmEUO+wkmrc4ETSMNTFIBb8u2uthQNvBjCniRjlWwAq7jZrYMveDwVhEUaYaQonw/Ot8mTGFKVB
 d3F77YXMuyWQZn0Qoo0+arXVw9EMVOLCWa6jJsC7au0yeKJFGpROmLZtDGDNvYzcPwQKG7OnrSi
 fKWxF1GxmirMZrHV9D4J5tQyVNvS3omSERIZVqhbmgqQOcMyROZSuIu7ud1aC3GoNucki2pIQaX
 anvT5fsIiYV+eRM5HTAhAqsEApFT1xvE+jduM/jhvBXoy0G76cm9SFfiX6O89LeMAFlYoMMf/iX
 77SE9CvLoLHnSNDPSVA==
X-Proofpoint-GUID: 4VL9xdb2Y0gEJgpHMVyPSul-qSlYshTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160051

During PCIe recovery events, such as a fatal AER event or other
platform-specific PCIe failures, the controller may enter a state that
requires a full reset before normal link operation can be restored.

On firmware-managed PCIe controllers, Linux does not control the PHY,
clocks, resets, or LTSSM state directly. Instead, these resources are
managed by firmware through the power-domain framework.

Implement the reset_root_port() callback by performing a Runtime PM
power cycle of the controller. This allows firmware to reset and
reinitialize the hardware before bringing the controller back online.

Since controller state is lost across the power cycle, reinitialize the
DWC MSI configuration after resume.

This enables Root Port reset and recovery support for firmware-managed
controllers.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d903f10211c2..744455ae90d4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1855,6 +1855,35 @@ static int qcom_pcie_set_max_opp(struct device *dev)
 	return ret;
 }
 
+/*
+ * Reset for firmware-managed controllers: power-cycle via runtime PM and
+ * reprogram DWC MSI registers on resume.
+ */
+static int qcom_pcie_fw_reset_root_port(struct pci_host_bridge *bridge,
+					struct pci_dev *pdev)
+{
+	struct pci_config_window *cfg = bridge->sysdata;
+	struct device *dev = bridge->dev.parent;
+	struct dw_pcie_rp *pp = cfg->priv;
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		dev_err(dev, "Failed to force runtime suspend for reset: %d\n", ret);
+		return ret;
+	}
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(dev, "Failed to force runtime resume after reset: %d\n", ret);
+		return ret;
+	}
+
+	dw_pcie_msi_init(pp);
+
+	return 0;
+}
+
 /*
  * Qcom PCIe controllers only support one Root Port per controller instance. So
  * this function ignores the 'pci_dev' associated with the Root Port and just
@@ -2031,6 +2060,8 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 
 	dw_pcie_msi_init(pp);
 
+	cfg->priv = pp;
+
 	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
 }
 
@@ -2292,6 +2323,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		bridge->sysdata = cfg;
 		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
 		bridge->msi_domain = true;
+		bridge->reset_root_port = qcom_pcie_fw_reset_root_port;
 
 		ret = pci_host_probe(bridge);
 		if (ret)

-- 
2.43.0

