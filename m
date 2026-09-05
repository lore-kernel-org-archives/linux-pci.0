Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B750276
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569356; cv=none; b=hZ8XbF0EJkcHlhf3XTwsLsTQ1trEnMB/Pj24+mk/47Wbk/v83SUPU8S3kpYxdJcfOdRkl+95GopsL4095Oc/ixROET4gv5iDlpCAmLadfAle03asV9xkTZCaVzHd6KbnSyKByvimuIofvfrn8RiGhDgIiiRsPGkUpXu1S05MZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569356; c=relaxed/simple;
	bh=PvQXCFikz7+VcAqvA6t2Ujka4N7pKImpgFaj/e/tCBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcdGKGTOXsrTB45xlFu/2HqOeTmVfBul4OhL1B9PG98/WvSbp5Wh7hMWDji6Kkzo+G7NXLeidu/236tw9G/9d76Vi4qW72XB2h8etehI7Ix08QmicTSS4iBRK1n5nhyQdvuyBN+gCHb/9g99iFXxuJ6wRVgKrzGSrcHfH4kYvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ASedEVdE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IlKM4z1Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ASedEVdE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IlKM4z1Y"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Kb2P43939647
	for <linux-pci@vger.kernel.org>; Sat, 5 Sep 2026 00:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Md8xapU073VDnkdcz3pCROBsNDKkTMi0kEel5VMy/bo=; b=ASedEVdE0zSIDYaB
	+DgOrxXAq5errKEo0SFT2hcz+H5yEHTfqdcx7PpP5ZbOsReYKxhCt1mBO3HmzTvM
	cNA6ZNFhlZOmx6HQmQchrU9bZsqz7UjgkUw18AvON5hECETz3tXjED6ZatE9Eb0Z
	pgnQLh7FnT5yM0oEURelsW53XVTOljuWxusqbLBT3i2M5f19CoGuDvBaIKf10Xqt
	8+x9U8BqW1NqBAG4IPWOL3Z8yb+dHPtMSbpvY3GuTA5A+TvwNc588Zi7RtCSD7e8
	gOPitHFPJmqQO00dH7iPYLsNVkyU8r2XMnesu5GfUxn6Ey1Niib/mXp1Gw5rnAHa
	21ZArA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg010jec3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 00:49:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so2274444a91.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 17:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788569352; x=1789174152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Md8xapU073VDnkdcz3pCROBsNDKkTMi0kEel5VMy/bo=;
        b=IlKM4z1Yj2OOib7S4kKtRtj6jCuzpAcwyZTtFUqAEa2DrB2KoAt04uxsqutHH3Y+df
         Qb2MYf1X519CERU9OgjogMH0y01XWB3cE+bIOE3uHQfmxQuwq2kfWYrvV/Sf5SAM5uI5
         7IzKwl4Lw2Uqk8NKNofNrNj68J9qfRWvUwPQXSfANCjzckp7my3Fo7awvBEEmmjd76Op
         858JvlcShNb+noT81rK9phfRrnUKvCIqKdH4mqT19cUnEH9jW8EDtfWCyFAHeiWbMaB/
         tU+/EDYfm/Xz15e6iNMwnMOiq5G7mpFDWWfASd1kh9OTfY61f9435OU0PYggDY38dNHO
         taPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788569352; x=1789174152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Md8xapU073VDnkdcz3pCROBsNDKkTMi0kEel5VMy/bo=;
        b=jaA8YzA07VeZa4aIBc64eaQoepvZA9j/4QUMnYxVPlFKE9PBcEsnH/9TmNP/+jUd9J
         fRXkpwWgoU4nxDu1JHDTVjkB59Uq/BLvH7uyyFF3dhfU1g6YksbGOZHvBfeTcmv6GTlz
         jQ9NUIkjiNhxwS2sL+R/6Dyaripyjm55CQ3kY4BKYftSCIq79w+SgBDJ6L26vmreD5nd
         BYTuiocY0IbDPnv44FyIZ4swEFa+zR4SPN6kuoLif2uyDUu34+CkKdOt/TC6X5iAHBIU
         5FPTT/oSOmBlW8b2f2yFuqo5rD7XhFvENsGw37VH3BjVozzVX9ch+qQRtSzpXNrLHWsv
         Q23g==
X-Forwarded-Encrypted: i=1; AKwUvBwGkBz4+yTNn4t1zhbsi03UkblEfbKZKq23/Mpj5t/UlAEqbqIXDpKxoWqAtH86/00a9KINk0J2y0U=@vger.kernel.org
X-Gm-Message-State: AFuF++lGKRKbIAPhVSIhPg7j/HxG0sc8PmAsZwg61baLmfr9fgzuMxql
	985u+xiBYdSL5f4viWDZ/N1YJ1Zb/2JpJ6aZiAiRz+gim8XneIPMbJhXvVgSESsevd/37G8XKRl
	D1Wh3Dj3vT3e8xYZb1vYOKWZuWzYAMd/YAQS5i05e17AOL1RjBVnvdxYz1kid0Rc=
X-Gm-Gg: AYBFou3k+eke4s9e4pqi4w7wRenrat5H+7Ry9pcrz7LV9pFvtCzXH1vIiiy3SP9t60k
	0Ru6V3n0xBUO69S3TbCCeMCjrsnjnvCrB5hMUrbPldshoPEPrHC2O4s6JIq+Dq+LUx1RmJVju0s
	FsJhKELtEekL2UYYYWm2Zbh6UHbrVboHWQWNQQV/cbrwSP5YKVYTv5zEBtOPH5DB6+AgWvNGp0B
	rRRqvfjEI6QeYq0ZQobi3PVlXXYj5lEJF+qnvSz9Naz805gjZZPBung747Scclj7bs4v3vGvB/T
	2ySe+7jIppF+mbATv+K1+eWgjDa7YuFEbtBpUaQfOaajOtxEOI8Kmr8kbeUCmUjp091jmNF5AND
	qQ5OH+nIVOAd5H++91nxi5+G+kmzXoVGZUrA=
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr13817686a91.23.1788569352338;
        Fri, 04 Sep 2026 17:49:12 -0700 (PDT)
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr13817649a91.23.1788569351908;
        Fri, 04 Sep 2026 17:49:11 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432441f5f2sm10843907c88.15.2026.09.04.17.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:49:11 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 05 Sep 2026 06:18:50 +0530
Subject: [PATCH v5 3/3] PCI: qcom: Implement shutdown() callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-shutdown-v5-3-f0c6bafa1d4f@oss.qualcomm.com>
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
In-Reply-To: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788569335; l=2931;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=X9pEskPcIL//ByohSRkzhW7Fg5XmyuSC5RVulFPk/RI=;
 b=pJ23BNDibNBii90irb9rRFMgg7dcmuKxLM4wLglTXh/j7Gci2L6JJTysrMIAX+oWLsr6Lkj2S
 5s1I/A2ydQmAO6bUH7dy9OhNP0JiViY7pA3Y9hbpGS1smQBpDSgJv4X
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDAwNCBTYWx0ZWRfX6HOrYQsVrOdO
 wR1sXb4D38eXyZsEoXQvDoeGIgyTEUUdDdb6TAuh4GnAhX0nvsoeY4MDb6zKcESnEOsur1KNdzi
 RGlSzWvKncAHMs1m8pifX1axvNHc//gtRBbI6t1K1nrBDhteDHBPjsU4aYxyz0h4XbVf/6pyg31
 kjBhn3bjp6QxnWtfoQTIVxnbS4C17m8e1QApT18Ndh3CdkjhA/Kty5LKcUhi7DZ5CHInHGb74NH
 g+1t4lspq2Rt7IFv5+lOmb6dtUfO7LcO1Okn/WzhVnwyp/T7/iJ0QUjMVPoM49+dRJuh/Lelj8h
 lfEoPO+Jo3VgxiiVSXzVZ5lbMvN6FftUmf+MCRO1YrNH3zyfRGJplUdLFQ6BegndQNqsmIMP+aq
 CDcXGqWfIqoxq2yr55p4JfNZPlbVSxdRGRv7XXqSkJUoUbkGrECTiqf7LLnVVew78YLH5030fSp
 DzjAqKZzBF0zyAICZPA==
X-Authority-Analysis: v=2.4 cv=YNavDxGx c=1 sm=1 tr=0 ts=6a9b6709 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 61_u5Vy_ot5X6GmS7l3rBHecDUoVtwid
X-Proofpoint-GUID: 61_u5Vy_ot5X6GmS7l3rBHecDUoVtwid
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDAwNCBTYWx0ZWRfX/Aa59bx/bz21
 kDblUDUcP4OzFFIwaS4HJHMVaMWOFcf77jfxYOH/bXBC1MoUxTMrKJjSVcnAOd+wmKjiYG/GxK9
 U+QiUssyK2TubzsLeDLnEe8yqLR6UJI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050004

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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..38801830fb70 100644
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
 
@@ -2337,6 +2340,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
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
+		if (pci->pp.use_imsi_rx)
+			dw_pcie_free_msi(&pci->pp);
+		return;
+	}
+
+	pcie = platform_get_drvdata(pdev);
+	if (pcie) {
+		if (pcie->pci->pp.use_imsi_rx)
+			dw_pcie_free_msi(&pcie->pci->pp);
+
+		if (pcie->global_irq)
+			disable_irq(pcie->global_irq);
+
+		pcie->pci->pp.force_d3cold = true;
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
@@ -2519,5 +2556,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.34.1

