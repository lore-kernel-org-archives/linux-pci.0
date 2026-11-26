Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670255;
	b=WXZIwnhXou7OvyHYQHQeLwlp3Gd10FJZT9n5XM3DZIPlEg+I32yC7JuPwNf+uKFDo4JF
	 jWSBeaiprz314COjYvYUqFY+Jle+1Yab5BYEi8QGIs+SnJ2ClWVaMVJX9RD12EqrNJ2MZ
	 vttnNGxF692J3AfDvoS9YAx0A5R6g9+BIj8TSlRd5ykiwC3D8RLIdoucRSvtV2kOBhjB3
	 HV+E0+naeCDuaWiDiPb1cHwOFJsJTJyVKJcpOGbTHwroj+icy7pWbi7g0YvbYfDIKcMW4
	 xojnkIZ2WisuXw92VB//O8HUnrp0mL81f1IPaFRyln303CDY30k3/bgW7+Se/IfSKaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670255;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=;
	b=eMDVTsFtnBH52AbBnrRRRBOo6utAfv4p955RqgwGhsJK2xwIGk1WMkyF2ns8O4Mz6b+Z
	 7Sxfz4+ZLOzIDICORaaKq6jXf/5/wc+rCl7szo4PZEAlIs8UUSYM90PZRyzxKKzHXB8rD
	 +Jn/SU/YngTOKkienRkk9ksN+kI369kDCcQlCwClHCgdNFGDrjxL3EmXVewMBQ9maduTG
	 OXvyShtVLWD4KKnohNY+kEzh9RTe7xCV2zOJ2yn6B/aLcD/Pt7ufRc5cKgf019nmOxpgG
	 3VNfeDqFP0axwTwXppX66lfAXbIqgzJgMSJwuphPu7bXFm8kdoEko9r1PEXj8n+e+NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ojnssEii;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GMtLevg9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3ED606A32D
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3ED606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ojnssEii;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GMtLevg9
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ37RbG3731009
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=; b=ojnssEiiqWWT5Vxy
	jK67y9be/JOUY5ksWIGSduhq+kE9Vwfn8oqHEJX34pNhA9Tvmz3IiJ0c2sZfTdf5
	bLcqD9NgpICfwgmIcbR6pdoHvzivpvpEP6EiaQDe54MCUEb6Cb848PZgc+KDSKgu
	eQoj35HoW7RfryqbisDD0rWPJ21aSXO2hTXi0I1dwUJNY06c2YInMx9VrGWroXxC
	6OeNN+kpeg3OOMmV2JKb1nvX4I86JY9m9D6celMw2am6DN/QhLQWCSFGxm5pb/f5
	OuTps9wSSjknbOKRyLEoKj81/B4RbDjaaBkZohNUSbt35sgrLQgjIKzOJ4g45DMT
	J0irYg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61arjsth-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so4104690c88.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 21:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795670252; x=1796275052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=;
        b=GMtLevg91q+djFMcmXiS0msqWhcVEDf0xROyBpsLoDjmXFq2Zk7DGkMaNuVub+ZWiI
         8gUr9fcAxWohe3FosHtGsgJfpqOcx1QtTx/4+e33kxxyIH0S+mD2A+N55XtsK60vk6xj
         Ah+YOdi7Sk/wzd1KMYE1IdqhhfHfDnfgQsUGEelrdl8OwqdHCgiFSKgoesGQ4ubnUE+I
         26rGBX38EFub2zn7uP98VPv+QqzrLYYB6BWZBRbXbwaTaO0heIVSLcrt5jWfuvxhdLEh
         PWJdWC3aljg7w1w5E21Su9XieXZjBGrdHrkIFHl5uyaJvBi0Mit8SuEJLQViUEMl/win
         R3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670252; x=1796275052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=;
        b=cA/Pm8ZSmD83BwTQmjQW0ThkkqEPUHnWmDUOTbLucrmlIMeOxaPLWvkJSpjwBA4ud6
         CYMSuJq56eGWiv8fLiCJIa29jFyjNYSY3860JVX9GdP868VCzNOMGwNStt/6EvdKUhpE
         eeMndaZ7hZBQnu622GNOmXyyb33d0r77qbbZYhBZIHz/hnILjg8k3mHUO0CIzi2jLm23
         txhUfNKj7o7zdmwanTHTowTfNS+iAvJOAi0bJm0hFpX8dyc1EELmnvIxtvXCQsPfpc9o
         w7u8qFh38ToMCagdm5nixj4fhAalenK9LdftgE6vGhzTedbZqLiul5bPS39zjVbWCY41
         Hh4A==
X-Forwarded-Encrypted: i=1; AL+hErHM0bYWmX2QhYiN0O239AoqW11lbYJ0xYn9nZgngyqmfdAJWW7ZxkVBUVlhP24bW/HtOLKcBpELs+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pkO8FMNxO0DbhfaFOTRHc/R7ziq+EWm/SXZdu8pZ4JpNeNAxd
	fnugCL8RycjXAfmLSg4v7I3c5BPt/I+UjIDeiQ/q377IuAtcBtaKFghuo31k5Pb9KMUBntjCvM+
	2FtKGSV3EG9gAzwOqcvclySnyEUdrvbs0TSh04NDhN8L2jd2eNA/EqkZjkmCvsuqe3v4B/fo=
X-Gm-Gg: AZFdTZeRzM/sz3x6U34PlGNT3jT+PKgv0CeSFkXIKj7+3b26pXfOUnWfgJgJQJxLxzB
	DImIeLTslvPqRDblxWqxnBamPP3HvQG67KEJcVhnKnQWCxmVvF+PGu8R6PKNsB/IwpgNuP9wH42
	iPTcDgHLWIu3kv/QTIFJIJT+6hv3qAsRA40YQEUFAOxHpnoQBTq4hRpuz8Y0VcBIdNMYSTG61+Q
	ax3/lSYThfUP5qeACxNR/6RRsUcQIMx4ZzjOmrQJmvq4Fny/7E5OQxUa/o6/hrfq5H21T4xmd36
	UTTJCKDrOeD/2hTKkGkzsIm/sStEHZQ7JSKbkQPgZpvCfYulpIkHxth+4N8o1ijaUTjVbGc/YHc
	69uvVL58oR1NizOV81qemjZ6Dyx8z7fSh1cmtZfpBb2ggAQgAkx3/OSym0ZzyBa0jsvuu71G9Fd
	ATKDLkWwHP
X-Received: by 2002:a05:7022:2209:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b5568b9e59mr25408815c88.24.1795670252345;
        Wed, 25 Nov 2026 21:17:32 -0800 (PST)
X-Received: by 2002:a05:7022:2209:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b5568b9e59mr25408791c88.24.1795670251781;
        Wed, 25 Nov 2026 21:17:31 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm52132934c88.13.2026.11.25.21.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:17:31 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:47:02 +0530
Subject: [PATCH v10 4/4] PCI: qcom: Implement shutdown() callback
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-shutdown-v10-4-fed60d9687f2@oss.qualcomm.com>
References: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
In-Reply-To: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795670232; l=3652;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=THWTFBYwq2lZQWgLvpr0AlF/FWIRcJOgtOn7/GBUACc=;
 b=DBnr0zgrgH9rEzWHP54pMz9eSXu76S56s4LQXs82zfqP2HOMXmT0pI+6XqVnP7xY1kjkSCoBk
 cv/6pBkRIvbB+C8sc8VtJ8EwnbBfBI+Ju/4LDWNCS6i/4bhx/q0xevo
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: HiPEtdO_iz0QX7R1QVb_Jo9Jnx4PwLLr
X-Authority-Analysis: v=2.4 cv=OIOyTiaB c=1 sm=1 tr=0 ts=6b07c0ed cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gM652YqJFP5vwQx0TG8A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HiPEtdO_iz0QX7R1QVb_Jo9Jnx4PwLLr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfX12z123ymTleX
 9CUCKnp39y1pUfgL5dOQPJt/y6TG+699P1HUJaubwpiKCjN/7LLtiXpywomDI6Irni4XKJgUnnd
 KDKCaYoBJLeNv3PUNN10zKhfy1PPTvw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfXxslmQbtLFSH9
 QD00tZPNpv5QtCKEOUm19hjacuN704tfo64DL9ffrvbZvnOxNMWa1+oN8qguYL8gEYXSa8VOd30
 zY7IpWGpaYlArUDDCkodEKfCnxkoipyoVyS4KO2Jiz29etMoTd3g7JA7A69TIASQg4ej9oYAnqA
 7KI2oPY5Lv0bLtcSKcRpTWdXLfQq1XOT/JnAq9aXBuvWBH1+Z5KbxbxcfbA7nQ4dqKh8xEFVGwg
 D4KCmmyqTLfGDIDV5l3bQOOe7XI69vnfodCOD8CSS3gjAqPt7rCX+b5CayyO+MEBKTha1upnumv
 6bhyto7zEpLHq0F7oR5IN30WeovmGwGaVPlh/WKBWOiLtcS7pae7kynC1fgWBLB8Uh/HuMkQFep
 V6WoNxO379qPLCN8RRnr2Rp/zDBxge7upWV2IBfkGkJOgcc1Ie5Auy1TjF/QkwU0+DNVrW2OITr
 8TeashGQeaVwsdnAxLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260019

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
reach a handler that touches now-unclocked PARF/DBI registers. Use
dw_pcie_mask_msi() rather than dw_pcie_free_msi() so the MSI IRQ domain
and the MSI mappings held by downstream devices (which device_shutdown()
does not remove) are left intact.

Stash a struct qcom_pcie in the platform drvdata in both the normal and
the firmware-managed (ECAM) probe paths, so shutdown() has a single
path and recovers everything it needs (Global IRQ, config, dw_pcie)
uniformly via platform_get_drvdata().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 532779295734..0f548c6ce6a8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2020,9 +2020,14 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct dw_pcie_rp *pp;
+	struct qcom_pcie *pcie;
 	struct dw_pcie *pci;
 	int ret;
 
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
 	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
 	if (!pci)
 		return -ENOMEM;
@@ -2032,6 +2037,9 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 	pci->dbi_base = cfg->win;
 	pp->num_vectors = MSI_DEF_NUM_VECTORS;
 
+	pcie->pci = pci;
+	pcie->cfg = of_device_get_match_data(dev);
+
 	/*
 	 * dw_pcie_msi_host_init() is called directly here, bypassing
 	 * dw_pcie_host_init() where pp->lock is normally initialized.
@@ -2047,6 +2055,9 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 
 	dw_pcie_msi_init(pp);
 
+	/* Stash pcie so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
+	platform_set_drvdata(to_platform_device(dev), pcie);
+
 	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
 }
 
@@ -2467,6 +2478,24 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pcie->global_irq)
+		disable_irq(pcie->global_irq);
+
+	if (pci->pp.use_imsi_rx)
+		dw_pcie_mask_msi(&pci->pp);
+
+	if (!pcie->cfg->firmware_managed && !pci->suspended)
+		dw_pcie_suspend_noirq(pci, true);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
@@ -2658,5 +2687,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.34.1

