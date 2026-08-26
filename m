Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD631327D
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728619; cv=none; b=Km2/ppFC93HHy0JRy692uvMr47foccd6qfZcE1hxI7I/7fJGoHLVu/n2PBrQGip+7GPXLwu6PPe9aPy3fSrHma2ni/cBxQVMBNiIjVx/XinVigeNfiD+SGsUf8ShOlKGxk8Qu8l/kUQQjARK/WhFLZtivi1wG3ZCkPsd7WqUV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728619; c=relaxed/simple;
	bh=A/jOtPIPzsGu+5AEAU4SsavTqBbpQwy1rF8OS55oVq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Md/YZKHB8XrZFB0tQSrbao4GQqhGwAUQoYA/kdVA712v8og7l2WEpwNmSQqO8b+WnzTJ/Z8L6VMXoy7qhp6ccNzCYUp/ELppCahh47AcfiDVsURb2O9A9JKwx0LN2QjRf6xwDA4p4s8Xq9/UNfx2pmSfXf9Th88mexYRzqvgLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UPv2vfBi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WnF35m8W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UPv2vfBi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnF35m8W"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RcSr3794497
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xXvLOxWUEjm7stkkC5GR6N0n9UM3KHHZuVkUy/3iUqs=; b=UPv2vfBiS+OBlAsJ
	wVQQPdGBwsYjJOr144v4u6hctYwtlRFkDbmHISIRVQPepb9uPc/wEIjm6Lo45vGI
	N5QzuqTNaJ7mbt7uaWkaaAZVixbRNgNgZ2+zGtdoEwRmrr17giMHFiNRMOMY9Etw
	bCO9Pi8VHNbIUrnEf/o/AnsOllLnJNYoqAzxSxfw92NsEoMNQnREbJXQPmSJL7jW
	/K+L6rKOpJZR5EUaOWv+uLTAMYs5HLGsfHmncjp6GBkczWir85PXDMnJeJCHyVZ9
	jlxNzB8ew8d3Sy5XsTioyycMECpTvry2oPtOzQlRnGUVn27+M2GX8GI/QvnL8xtO
	XdqoPA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx8ha9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so815370a12.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 00:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787728616; x=1788333416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xXvLOxWUEjm7stkkC5GR6N0n9UM3KHHZuVkUy/3iUqs=;
        b=WnF35m8Wm5iGj8Ui0uHri7xCiKZLuSFMNE+p+PEo/61CQBLkjkI5cQ6K4z5rx5gcu2
         41E/wug6PJb3VVVaJClN/AnZU3mEavfyGm0uhco2aH2L6skcLBLW9FpsNH1M1o0Ci69s
         8x1fDEIDrn55DWDuEImEZLOqPCvwUrL8KhR8NuizNEgPbpdfkyKpdoRDJwiVGf8aUjmP
         Y7q+IKgZm2Q9NpMQGAiIZBqw3BRl+7Vt3rGEOZ/dK+k7LFgHm0BN/5YfeTNY4FYvPxG1
         CMEyqbuBOd5JVWeQl4p40If2OVBUVh8drXVwHnuxR1eDAt0RylCEn23HKTHG7eFIajpn
         4uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787728616; x=1788333416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXvLOxWUEjm7stkkC5GR6N0n9UM3KHHZuVkUy/3iUqs=;
        b=sLluYwXAtNLjPPF/KsmBAIhLrDQKyM2nDhhLZKJyetvF4A1oMa1XyEEws4KzjP0eRb
         iQJMXjwrp52GtoRmy+6CtvlkiLbYKoNxNDq64S6oS84taP+pZL2j5yMTLfqYlrbFg7Yl
         r6SRJ8yEsN6Sz76nWfRoBuMJzobj7V48HFewwrArMwxR5jQdYqzCCLkKAvukwepeMr68
         Yo5MwmkaRpXNowonOqlZ0Jt8/k3qwNYAqA64pE228zu5vJBjRmQ2cU3ZAr8SmOM86BgN
         MzJiEX+LfJDceajaA50w3x7AF+aW61YFUogOIe1xcAzx9qInxdH/S369m9nKBe6dfkVU
         s+eg==
X-Forwarded-Encrypted: i=1; AHgh+Rpt2UTqbugNILP9Ob3Mnlc426pvTQBLXoBzajyn27v6/EeF6nQxdDVGMAaNvh8m7ptn/n/bNym0crw=@vger.kernel.org
X-Gm-Message-State: AFuF++n9052mVOUp5X65YYRdJX4+gF0xI7hTBG8YDvCiGUS9ylvLMnRw
	AxtdCYWtiDy1aAm34//9duMHpRj5dsdfOGwc3LC1mTdl4w/p23vhkPPzFiwpgXdqjvbIBaCunRn
	3N3KU0MmFIrs1ym0ebkla+/hq49zH48uy+UEK9BxPZlUKEYiu3Oi6Dv+MFB2htQRXJgd5MfI=
X-Gm-Gg: AR+sD124pekhMxrDfuI2Fd6VbA/w1zdRjEQKX235WYyuVo2vrlRuIJxgNOlwNVfLrLg
	7vXXGCretw7GXIbPy0TDSV0GDx/YOtnK7Omx+BOxoxPggbG23kIU2HFLokexOm2ONtsSssBwF9K
	DtHSIeP6muFI41O2FU8wHHQLxKV1itJzRUm7KJfm05gH0hRcKxtIjx7aLhVVeNkVvwqxGAKtXtm
	+mTY4VEMdSmxVZbUsWZIyVITUpVc3Dlh2VRGeh77iPURDH5ejdCO+KTLUWb4TxrC54tFRTmJBgf
	sivMqQwI0VgEG1i4w0ityAExISX7FExcrEDED5pqVsDw/4Ig0udyniHZPQ1w88MsrHrLglQkr/s
	AyyFcIRatX8JXPwDtAI6kHyqq4TtKAcDtDFA=
X-Received: by 2002:a05:6300:2285:b0:3cd:9bb1:c6f5 with SMTP id adf61e73a8af0-3cf83e174damr9343284637.10.1787728615986;
        Wed, 26 Aug 2026 00:16:55 -0700 (PDT)
X-Received: by 2002:a05:6300:2285:b0:3cd:9bb1:c6f5 with SMTP id adf61e73a8af0-3cf83e174damr9343162637.10.1787728615457;
        Wed, 26 Aug 2026 00:16:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8dc465sm5553772eec.24.2026.08.26.00.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:16:54 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:46:31 +0530
Subject: [PATCH v4 2/2] PCI: qcom: Implement shutdown() callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-shutdown-v4-2-eb5fe9d454ae@oss.qualcomm.com>
References: <20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com>
In-Reply-To: <20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787728602; l=3508;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=KaNGQCf+MG1eiH3jZvZbpQL7k40TDTTho9JS634y7zA=;
 b=nt2RnwH/BVC/ImTDW1YqIT9OqT5rxIlQI9Xi1c2/05Yh1PLianlBjeuAsUAbIi2CuvwvLOd1p
 5iAm/1p2J3tA7Ny4zaGeVVHUHKgfd2pT9zveMxnqNks5TC6cOiSOVyc
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8e92e8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iawlQURC5_C8fo7fAbJkjx4PpdBE16eR
X-Proofpoint-ORIG-GUID: iawlQURC5_C8fo7fAbJkjx4PpdBE16eR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA1OSBTYWx0ZWRfX62EujCA5tpSR
 iQxJUb1w+u/rK9mFtsaID15500OeHF1wYtxdLRhawD0N5O66BR+dCFQ7fIG4G0DsIMe172LnVhC
 wW7KwauLG7aYvnkmtN/ipEDURSvN4q8w1t+jkSTTakFDKok+9ULyXc+XukcWVXTPPGPV8T8XQ2V
 LUjAOW83PgpvSgxs+xvZoRXnS5xe6h5dIxMdpEjZMhdBw6gqn/pHyrCVneMwPG7sjSXTTMDr9wm
 QtFEvOG9N6tbH46qrkS0rNInKPRp9J6t3ytOFBSYKwTUjGBwp/HibR7Dd3TXv88aqWH6ywl0O6F
 YODiRn/BNm7lJXUdsbZhEzSdvmfVVQ0ttJbRM0knBTrKNzSI++7xX9St+fJA54MOl8t3BFhv7fO
 GOUmet6VSmiABZOEIq3cKBYqlRyA+AQQch0SDrxWPbbUGDb4vIXg11HUF3cSbgwZp5Qj+4qXI/z
 jVVjKwuH3O0SKblwocg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA1OSBTYWx0ZWRfX3ltR9DYePqpZ
 I7Cz/oB0+/emMgFbCpbFa0RDmOIINV/AhG+w7/6yxkE7KiibbWWzQwKq4sAxYlpOo6tMwqSbWyK
 XYrZFD1usozxSuW7EYTb3FT+iZZ9yHk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260059

From: Manivannan Sadhasivam <mani@kernel.org>

PCIe host controllers should bring the link down cleanly before system
shutdown/reboot proceeds to remove power/clocks from the controller.
Without this, the link may still be up and endpoints still have
transactions in flight when power/clocks are cut, which can trip SMMU
translation faults or NoC protocol errors.

Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
into L2, putting it into D3cold.

device_shutdown() runs with interrupts enabled, unlike suspend_noirq().
Mask the chained MSI IRQ(s) and the Global IRQ before tearing down the
link and clocks/PHY, since a late/spurious interrupt could otherwise
reach a handler that touches now-unclocked PARF/DBI registers.

Firmware-managed (ECAM) Root Complexes own their own link teardown and
clock/PHY shutdown; for those, only mask the MSI IRQs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..fad2f4e2d6be 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1924,6 +1924,9 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 	pp->use_imsi_rx = true;
 	dw_pcie_msi_init(pp);
 
+	/* Stash pci so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
+	platform_set_drvdata(to_platform_device(dev), pci);
+
 	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
 }
 
@@ -2337,6 +2340,55 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_pcie_mask_msi_irqs(struct dw_pcie_rp *pp)
+{
+	u32 ctrl;
+
+	/*
+	 * Mask the chained MSI IRQ(s) before tearing down the link and
+	 * clocks/PHY. Unlike suspend_noirq(), device_shutdown() runs with
+	 * interrupts enabled, so a late/spurious MSI could otherwise hit
+	 * dw_chained_msi_isr() and touch DBI registers after the controller
+	 * is powered off.
+	 */
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		if (pp->msi_irq[ctrl] > 0)
+			disable_irq(pp->msi_irq[ctrl]);
+	}
+}
+
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
+	struct qcom_pcie *pcie;
+
+	if (pcie_cfg && pcie_cfg->firmware_managed) {
+		/*
+		 * Firmware owns the link teardown and clock/PHY shutdown in
+		 * this mode; Linux only owns the chained MSI IRQ(s), which
+		 * still need to be masked off before shutdown proceeds.
+		 */
+		struct dw_pcie *pci = platform_get_drvdata(pdev);
+
+		if (pci)
+			qcom_pcie_mask_msi_irqs(&pci->pp);
+		return;
+	}
+
+	pcie = platform_get_drvdata(pdev);
+	if (pcie) {
+		qcom_pcie_mask_msi_irqs(&pcie->pci->pp);
+
+		if (pcie->global_irq)
+			disable_irq(pcie->global_irq);
+
+		dw_pcie_suspend_noirq(pcie->pci);
+	}
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
@@ -2519,5 +2571,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.34.1

