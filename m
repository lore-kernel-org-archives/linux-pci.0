Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015961;
	b=hQIb3JEmNtL6ngMXj1tmC2SOGxUL22dlUMDJ4rZ/dYdHrRi6fh/G9SoTQoTkF2jiGQRQ
	 jaKP3HWm8VdXbI+qksTXNzg3XF9OJweCd0Z8Ww4zcIFHh2H5AZBzGzJa7vdDk1eYtO5Gr
	 4STe4x4aIAnTCYZBbf7RXzy1DHxVJHMnHAR3NsTdLqzXEpfnuDt4sU+GY/c3von6xb34K
	 oRw+YND8jq3Rafgdf2BJ2oZNgq6l8JZwnuNIuZ/Mxq48sIR5xy4Ri9F4GP7Xi0VGrTW4X
	 3mcaUywtESdILN7aEf4myoUkAs5GWoBGN5qESkr2wglzmx8rEV1xFOUSfQGWuCKCyhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015961;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KMNbb3rJ4gmMLXtZaN4598zNytchSh1teJ1n3udB1yM=;
	b=rLP48QUwzcsTn7yg/EbhhrfJGYM09+kVU/bxrp331kap+9PfGi49K23ITwgGMHodKD12
	 XOhHyJuYb9rkin3pp4fS3mJmTss0fllsoC1SfdM/8vbMoiEis6fzG0/qJpwgt1g2i6qF9
	 RGJWH5jzymmBlyaVZybkQbLCWjws1ukiQk/997sceg3XGaK3RDKU+P38n7nR9/SMLnLUk
	 rq2UjJ1FI09LEIP43tnjMEVvWtB579em+dOCPH0YYH2+UHSnn0X2HQz3sWs3YWQZkwaBd
	 9hcN2cGsNhMvUWwmwnhoDv+BXUfJbgKke6i6KDJz2fAbNDFOsHDLp7oMpY0gailKF0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZdJ3sFAb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eAPd3Sl8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6A606D827
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 01:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED6A606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZdJ3sFAb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eAPd3Sl8
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A70ge7x2321590
	for <linux-pci@vger.kernel.org>; Sat, 7 Nov 2026 01:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KMNbb3rJ4gmMLXtZaN4598zNytchSh1teJ1n3udB1yM=; b=ZdJ3sFAbH3yC+84h
	70jmoOJGECZQUFi0TiJNg5baGsmFiZLPfPl2KQ+T8tMaCOD4tBatSh8ZeEox7E5X
	YkwP2Jd7z0B5LGYi+0zgiXhrSLf3LMA25b9CtArmh/lMjJ8YLs5n0TxMIKK/jGG4
	LkvzWRQF9a/cGBC/AOfTo9+UM8R1papwsi9puvvfPR7aIEz/v019FPyeyWf35JkJ
	xxBCQt5Pi+bOvC3lLoTlc4YYKlvMSP+Bt4uLTbaJ/yTtzzGT6YtBPKVujOrLBbz/
	XGk1Zh5HDca0itJpzifO0vcFnOCfX23PbLrrdNl4n+PSXHWoeXIx6ps93LjenZ1J
	/AfBCA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf040n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 07 Nov 2026 01:45:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2608412eec.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794015959; x=1794620759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMNbb3rJ4gmMLXtZaN4598zNytchSh1teJ1n3udB1yM=;
        b=eAPd3Sl87xiDD2KsA50PV7Ot6bjF8vzj4eqcPsWilMaA2rNVfAWLEhFiaShFnSIoM4
         1+pylxAJGOwkuguEZ8ee7uVWCJWBna12cVU6YNPEJjozH34xJiWJFSP/tKCw8jfHyMHx
         yO/KD/76+v511Dq+KP1WtuJLeZ2M+fMKkBcL1WTl6kJ4J/+uDEBLus9xKE9DI383iIHv
         YPuN2D2ET25Q9/DHt2vZcVYNBqvhAkz1jSMjAml6nY6+DYqyuZ5AADL1qmpgmOqcaLPR
         72tFrZ//KrU/BPfazcBKH9Teu+U+NjL72ULvoPwrl9x3j5x0R3lwOM+Xbb9nknqbM75V
         2jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794015959; x=1794620759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMNbb3rJ4gmMLXtZaN4598zNytchSh1teJ1n3udB1yM=;
        b=vksUhWNeFWVxF/Yiw/JPLsh5q9kXFjdyJCIqEvMjL7s/4O/9aEgvWyKgCCBIKRwtPS
         7YvIYxcDG9Sk5NaEshI8NJSs7koHNfncHo+cxzJ342AcdizOx816RXcAJ2YjZAq5uQ7L
         fRh4ypRAxFfEs57ySxatTZeqpyRZnbKaipM8wbzkWL2bp8Zb7cd5kblSHJhB0auQPeuH
         ldPvD7OO6mvOQb/xH4GbM90d1Adksm1kIhRT1W6mmwQVViOhEAYc2oJeNEOj0t+aTyCb
         HvUizLn1vWLS5l4tQKNEdOcowGMbTUqR6EFiz/5NT9cMeUak4k2xgFe7pzpj0HT0xAmt
         7jQg==
X-Forwarded-Encrypted: i=1; AL+hErF9dykFePi9y4DBy/9ZOrYEBh8kpm2jzy8F5b+IUa0CgX1ALRRFyeFumXj0aBgA2A05j19clMXpB0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NbGpO9PbYYugjJZ6cbZ4hTZP9Goe/MwRHdwaz5faiI1phYKjB
	E+d/LjkqL4yxuuJ/rTnbSjr/ta2lvQNwmBU0wg9z+UGNAyZvT3oUTZZDZ+V/QxFTZz/q4XBxWhM
	jkZtakmtfLthJcNs8s7eaFtBBdg7Dez3lmK18/BMkjvKiI4ipk3LyeXdpxb4AnqU=
X-Gm-Gg: AYBFou02ct7fd0bEszaW8VexyuyC/T2n/3nQQmZtBqqWWiNpC9HHF4kZAZa1MSW+lC9
	KcCWcVAMyRaq1i5oFY7mHU/5rol8pVM73ljc0HRdJPpZWc4xFNrbZkqeyEzO0ObdPjEFDVDJDt9
	HKjphaNKT33gyAe0DTLsDO6pgTJEeVQ6tqDH9utwuX7wUmNhU+6E5FWFIerFeOm9+SlwQoKz5sN
	xl/nqiYCDry1j8zYf+PMr5evh56TbhYgadYjdggOspd+UWcVEPQPnKnajpF2NtG/eIynjhK3zp4
	fddtIoUUjuFm2lt9fecnyMlOKvGBAAv9KELxHsSaebgswd1lqWULdrmc/1fz2JBBsvdWOLhU7sc
	D7J9IqZdesskdxxcLIbhlnVKj7rbrkIXyEJXLOsrtNJBgiW1xfh9KnpCMc7NHeX4gwS4QHCHr3b
	w7ZRx8A84=
X-Received: by 2002:a05:693c:8859:b0:35f:2bc:82d3 with SMTP id 5a478bee46e88-36f75a25e5bmr5793955eec.15.1794015959184;
        Fri, 06 Nov 2026 17:45:59 -0800 (PST)
X-Received: by 2002:a05:693c:8859:b0:35f:2bc:82d3 with SMTP id 5a478bee46e88-36f75a25e5bmr5793925eec.15.1794015958533;
        Fri, 06 Nov 2026 17:45:58 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm22861123eec.3.2026.11.06.17.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:45:56 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 07:15:22 +0530
Subject: [PATCH v8 4/4] PCI: qcom: Implement shutdown() callback
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
Message-Id: <20261107-shutdown-v8-4-bf607c6429b0@oss.qualcomm.com>
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
In-Reply-To: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794015933; l=3339;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=JmdrJ94XKia0WQjg0e57QQB8kLzW3inNONqx8lGBXPc=;
 b=917PJjZ5B/jW1tBkcC6BNjr1EG7m78SUtwkcA81Uk1hI4MbokabZNcx45AgfwPErtQcumeFaD
 DSWeUH1OEOVD5G5MfLTxaJNVQmhsOzRuDc5841/SWIuJUbHw+HbEVAz
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfX8tM0YRg33x5U
 Xs+8Cc7MRqXWfrrw1piEanVnSSphUfAEqpuJbpVYTC87ai1eA3Wz2vV6J0PuobIOUTzRX6Yn+9q
 MU3p7Tl2IdXVstsztuc8aCj6U3OoT7M=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6aee82d7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gM652YqJFP5vwQx0TG8A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 27NxUoy2JAxFECIzMp_T_i7q55lvAE6c
X-Proofpoint-ORIG-GUID: 27NxUoy2JAxFECIzMp_T_i7q55lvAE6c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfX+OOeFlLBO3X9
 Wd12J6X/eL+uGwJDGQYBLe/oWuq6pzGQWxmUsc9ZE4Bimzn7+9wogW4d0WnfZRT59gEmk/QCg9M
 KzI5BgKm6fKxowoWafUusitXzVels/mq0Az3bkMWHDE9RuXZGoG9+VVb7SY2xFihpCNG0m49lxa
 Vh2rcbLBK6SKYNUEP7GNacs2Yh6UL3WwbhXH3x7rV/sTgVkwM5RZJzC1Fzk4Ov34aSxvbWL+6Mt
 Y5VNH5dEJ+5hmooc16Fat2cmUDYm9pf/jOMeXP2ZEzFGszmIowuxguIiLXtK+V7oJ+qsXpiPizp
 V7wuX5BEFs43qENdM1QpltoRVdoN+ZLqTbvhxey80Yaw1lR7jJCfQpP3Rym9XwxgNUqzwK4SW3W
 oSNPB/G7y3JjrOMZWM8/YkDKBiXxtbQH1t22jlneYeSC9ItVJPHSbztj6t1MXuTQIHBgqVmAZ3H
 XBDYnkCxnQELydtRMPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070006

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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d39753f0e724..c5b06db3b92a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2046,6 +2046,9 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 
 	dw_pcie_msi_init(pp);
 
+	/* Stash pci so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
+	platform_set_drvdata(to_platform_device(dev), pci);
+
 	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
 }
 
@@ -2466,6 +2469,43 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
+	struct qcom_pcie *pcie = NULL;
+	struct dw_pcie *pci;
+
+	if (pcie_cfg && pcie_cfg->firmware_managed) {
+		/*
+		 * Firmware owns the link teardown and clock/PHY shutdown in
+		 * this mode; Linux only owns the chained MSI IRQ(s), which
+		 * still need to be masked off before shutdown proceeds.
+		 */
+		pci = platform_get_drvdata(pdev);
+	} else {
+		pcie = platform_get_drvdata(pdev);
+		pci = pcie->pci;
+
+		if (pcie->global_irq)
+			disable_irq(pcie->global_irq);
+	}
+
+	if (pci->pp.use_imsi_rx)
+		dw_pcie_mask_msi(&pci->pp);
+
+	/*
+	 * In firmware-managed mode 'pcie' stays NULL and firmware owns the
+	 * link/clock teardown. Otherwise, skip if the controller is already
+	 * suspended (e.g. a prior resume failed), since dw_pcie_suspend_noirq()
+	 * would touch DBI registers with clocks/interconnects already off.
+	 */
+	if (pcie && !pcie->pci->suspended)
+		dw_pcie_suspend_noirq(pcie->pci, true);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
@@ -2657,5 +2697,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.34.1

