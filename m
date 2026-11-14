Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621680;
	b=Jbv67z6/qsC+9hbgFTymA5/ntKPvHyITENaZip7bh0OF6GShV/d5XNv5uKqV/3ePxbGI
	 RwCjaICmaLHi35m31RTMDrdOxRLhK3xUox5OYuKqPiclwkU6ttbeU7eM+mFIxYQNbgFpq
	 L9e1fw2Hqe93o/3v65MHvdj6J2t3iKLAC8FN++9YlXupZ5Vy5rhr0Qh0YKLWwFfRD6ckp
	 OYpZ7W/NTb7C/FgLL2M8ZmA8Pw3czrXpGh1VxbO+cGJd9+uwxaBB0sLOPZBU3zj603Sdm
	 /IR0n/78T649gHHl7Sd+c3fl3LFuie6cBY79WfDSAEep6VJez/2vYjA3iGv98Sy5N0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621680;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=;
	b=XB1DS+O1DsVZkWblgewwZ+WhFpbk1tyFGok/y3qpRicRBou9qPM/dBjSkzwNvTZ9Kzdf
	 /18LEkW3l8yMGB6RGNx0sPc4dMhEqnOs8CfQJhxL7qlfNF77LIxJiedTH66nEc3tbaUbK
	 bFIwxkYCW1RXk4Y12g06s1mUXXOxZ3w9YCk8lQYHQ7d19fjyDxW5XdzavNm8sIJV8yJgE
	 +CurUW3siQcG3Rj/RY7CejJ5B9Okoz4FmNSxmWfagev3NPHD+uPOfCGCEU2VANfUi0ixd
	 NrwFnuW/sGif+6IeAZkcS8bbfcjsrzA9eYpnk+NwkYGK9hX1fVtAPZyyDijc2r6KziQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RnBEZk5t;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SMWrMN5e;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A5606A8BC
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 729A5606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RnBEZk5t;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SMWrMN5e
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE206TA3350064
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=; b=RnBEZk5tijUDlM4m
	NLIIw3VVnwnpgiQUSi9DxfZZapBB49T+a/PeQZHNkBn07Bjf1NrA1+D4fBVVB2de
	Yyt46JOGyPdisT8VD6KrXMA111rEfPgrML6MxQ3zxQ3kwyv+ORmO/L+lgJ1pg2Yn
	v37k6Y2bKfoeBTrvUHbWBKgg0GxgUWTGC9vOgjwEa23WGo4XjkGnCX5ACeB/LiYG
	ZSCI68WRX/mKwrvShw6CZCIWldmGS1oDCkTp9SGmJqt7zfUNZX2FkU00zb5JHXN7
	meMHOh1khq8oAozGW/WdHhGe6knfjeVvHCnoulQCC7tQAsIh/EVJ5SSvKy6dy8MX
	5ioiVA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bpb2y1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so2370899eec.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 18:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794621678; x=1795226478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=;
        b=SMWrMN5enOY8VCGZmzd5qKVIgf7lsMZPZJtVTZoEx+QWMCM//30iJxIqUNNRL3Vv9h
         KyHSvVIbZcEvFHWlrXuWEAFAV6TFDJfYOze87JRcjI3Zjcgiqc3MFMRjUO/6tbN3WR4W
         PA5SNIzLg2VrdkKnJ55J3HSULW3TEPlD5XzlL9mJm3tU77KW4AOB/UPKVuTEaa2oivoK
         BvWb7e2VDjOl0zZ222/4+nBeTUUdyFRhADts8GZfuKgr9owhrMzYbIk0aFp12RqLjNzR
         krjM+haj6kOzWuB8haITcNcDm96f4o+A3BBs6ctV+NrDqCimuQzlwFSFVmWkshG0YDDw
         EY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621678; x=1795226478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvuVNeVnAijWURIP2f6FyFqznxRc4/b2a0oI9wlKPJA=;
        b=rUQNVZd6sdIkpuBpdjwUywlUF0AChsirw+xjLLwaSNyWAwFGj9qD8rRJpKbOfpuGHc
         FkL13aDmSxVpQrt5paahtSKvvOi9UXjRdo1EvIxeOLV0al/ujf/ZedSsz8/Pmw39RRUA
         nG3jXTMEXYTA1/NGopP3REVgr1xCDBIFa6lcDpAKC7prNC3hO//e38pcYS5k+Kcuxcbp
         yhu84z/4mXKjA2n/f20cW50y8NU2GideavO4vlZgy0IhM9q21+xTFTBoYRFAjYb6S+/J
         xqKsggbhdFkSDBMA3ATbx3whZI/cyp3fcYrb4cX4WYA6h41gLUrVFX8XKeQzu50k4aHQ
         Bnig==
X-Forwarded-Encrypted: i=1; AL+hErFqJNa8Jc6u3feaKLkijN8canKoVOE4vFnWxGMU0dCWorbO3yLTXd+H6iNhC+J2IJWDAMZ6OM1bj1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TaCn7Du6bPUpbNSOhA9MmXRoTk7xAt/Md4KjtOb7HzO+kmJlc
	kgdNgUWVvpmvSzQZ5EPX/pDqc4ETxrZnHYSwl2pKCxOTW+HFDsePB7ishPwMCcpTibfPXiHcYKn
	Gh6HXPejPhJXrH2O34wTaApUN3GpVm0CODSGVfVu1A2ETJEa+kZ/aCJeiyGqF/3w=
X-Gm-Gg: AYBFou0AMFGnk6DiIPdYzJE6Ts1eXi5EDHYQJWVvN13qlxuU2FUy2qA/Gnp2ocvleiD
	JHm3KXBUgMk/U3Nqm6fli0x4so3hTLNXVcoNPnfYlicUuT3psuyqgT8kyGpqIP7/dymDFoynGwj
	sAjDG4Wch9WCTYnTpQxTB8yW8hOIYPECrkxNaBj0Zpy0bQBk1ogc/vB/MKBsHN8wLo/GmIRhS/0
	1aXYgTylbwkUeuKhDQpXPHBEUNjzz6+WICEiRb1ZkK89n5jh7OHTDLzTXDzeotFpagFcaeIL7lu
	/fKW07/tKYIDrqWx5xS2x1cJ0j0AidOKteoXDhTK2RqvZMnnqA5tIHobtg3GI5z1XRcYPUOXZCZ
	2oz2spSD0/oNHVYkcNDM1XgtDZhwrptSoSxVcosSdMbJyWAyxfr6PMnBkpHE4SEtJBIZzMVvduo
	VOS92KJmeX
X-Received: by 2002:a05:7022:ed07:b0:1b2:588e:f89b with SMTP id a92af1059eb24-1b503169362mr4105729c88.47.1794621678058;
        Fri, 13 Nov 2026 18:01:18 -0800 (PST)
X-Received: by 2002:a05:7022:ed07:b0:1b2:588e:f89b with SMTP id a92af1059eb24-1b503169362mr4105627c88.47.1794621675559;
        Fri, 13 Nov 2026 18:01:15 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm9952742c88.7.2026.11.13.18.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:01:15 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:30:54 +0530
Subject: [PATCH v9 4/4] PCI: qcom: Implement shutdown() callback
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
Message-Id: <20261114-shutdown-v9-4-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
In-Reply-To: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794621655; l=3652;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=THWTFBYwq2lZQWgLvpr0AlF/FWIRcJOgtOn7/GBUACc=;
 b=Ju38qQrTI2vyg60ari8vmEap8HMp9kPUucQv+4rdG74A0mFYkoU4CwYRBokY1nZ4S0lGjGzKI
 jYtJlGjeNqvD1r08rt0/GOUEn4dt+GT67DwQDtJh7PcMqjdGR11lF1H
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af7c0ef cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gM652YqJFP5vwQx0TG8A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RkCfskmGGlvhXQy2pQBMqEaKAIU7mT7-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX6xW07vCdZz/Q
 BZgapk9Kv2Ax/nVDDuTdJm21SoklZEZm6dV0SLJO2P7BficDNXqXKlf1+7YseDYRB5xfNtCBRZm
 YdXutULeMY4Pj6sRIhB6LDriOQt7SrU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfXzb24dnLnOcy5
 qw/4Vq8NEr/he31yBKnCAwKdzmgOC0r0/z6VtMdGRF2PJ4z/lN3RvW3Ztc0W8iNcaoaQ5wGa6ra
 gABqNkEzbnX/kluDUxD3w9ZAhu03SYmAcQ001LwvLPh7E9hWxIz188b9H83O4uksHXHw52gXgaQ
 dltGyE0JQIOjAKCnhbKtf9LdvCPUK6K8wWxKDduvtqYaswvhSfyfWqECyVxhZZiKwS2AVRL7iLA
 D8W8Qfwk8l4IfHtv+RON13+LdAUuiGFm6B5MhDaLUKNWZl9kyJlP37qf4N7GycAwY574GO9/41i
 xQbGJwyljKxAUF2qXcfN+yOK8fgP7GUPdDbIbEAZayHkdVyeaMXuY6kpEdgfKk/sRkWr8WzhCEE
 /ax/TPPy1HbL0ucOBHfrPkYoAIVf0EyYLtGxDKQ2NBmIww+eqkBJqp3xbgx/I4ypW6jHNADWqrD
 VttFbI6v22Ni4+VjDGQ==
X-Proofpoint-ORIG-GUID: RkCfskmGGlvhXQy2pQBMqEaKAIU7mT7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140007

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

