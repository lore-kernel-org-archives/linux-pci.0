Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247596;
	b=zxklEbmWlb2k4F8Yjsl/3GQLhU38Xk93m6s1ZbI5pSoG9BjDuFPne2cdb+Q4MMhpLsQY
	 SA5RMMK8ZowgcmEJFMwWbIeSQPjr0wqX0aBiHOKDsgFZCp0hL5xIqxBLlFrWKq3A3Lwbn
	 4d9rSqmGiLu6YRR6XI0SkuE6L54B+M5rmUdMU+TQZYtvf6ZIz2mom2fn6ptG7hHZxOYrc
	 CV9eaagUpgwMpFxT+LioTQhOveFkO2h0cAzdoBHI7sDuxQRC9kY049KtlaTk7HAPY0YcC
	 1pkQdRDYbO2Ct7L+0iXAq2YbFeY4E9Xi5YFiz3Xq4/csouRvUiKm+B3KjyuE0lQhNDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N0sE5Rrg7254a4JIqn8LaORoch9C7DlP93N+XE8pi0A=;
	b=AT2aCARXB2Z+mLcgr4ZUZceX5C0W5oLJ25M//pGXkyJ3Wkamu7h8vyWcYIZw93Uk6Qtw
	 LP6kE0dWf+8MPTuG3riTvIUOYhykXJqdTCLEpIYhUqpMOXkVpxp6+sN5lS5sgQXlHo9OU
	 amBzbDc4U9K2Q+HVtF/1JKxROFNlN0OsW/12MEyUptSuVKm35CbRiS3viV+5QsxOlT5bn
	 JUzHfNA9uAJIRD2/2oMvh03Gt97WwTDKTaUgPFwmzPl5FiofVg5FbY5AJMuCVW/lXMZYP
	 9ZsaL4zSsOvOpxVVW7MQB/cgi92RZsVk5SaREu4MpwO5SK+k7NZw0fXpnHlwTzfPKmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csRlgcFV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JJ2s7U3b;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E4606A324
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7E4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csRlgcFV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JJ2s7U3b
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T1jk1g3948101
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N0sE5Rrg7254a4JIqn8LaORoch9C7DlP93N+XE8pi0A=; b=csRlgcFVp6oRCFUv
	ilpTZi6shOn/BYJJZxxaZQLzR7aFV7C2PHBHVBe4Uu8oAHzI5dYDKHZFJPjLdVJE
	8zL8iPsX9CH8EKRqoLAOnbu3jQDtwE3NZku5ozovw01/UNiVW27b4Wjt1fVMlDCd
	JI2zRFFePIBdhUC7jC3xBdw+lYy2mkkIRjpfg/8MVrA4smMsEDRdvOuxeo8ZQ54K
	dLHNhjz7Warf5l2tcgicfllaq+JNXRW+1typGM/Rm1s55g7XB4BiHsA1o0fbB1Ts
	/ReeSzUvgcfcaPwMT6z7HDCvFSZT3qzfna38hQNgaVK/qRnDxrDFM2o7XUzhY2y9
	olWL8g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneut5ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a3451ea93so357788eec.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 21:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793247594; x=1793852394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0sE5Rrg7254a4JIqn8LaORoch9C7DlP93N+XE8pi0A=;
        b=JJ2s7U3bBm5Y0i6SDhWKntjA9xDRAm+hgqmy1jG7lEOMYOOWIktCf9wfthujjtYc6S
         NbVCtFWlD32L/M3nW0OZMQBAaHqJdV5h7JRv28FvXpFXBlVCGjhmPYHjsVHenDBPpEQs
         mGjBSMt43/93Eb08BR8VMu2ED0NYpHDvNNgS/bmoMkxERPEiQHqA8A/vV1tlF3RfNWAU
         cPHI1JCn9RiI9rHuF21zA+9NAvFL3qgJirqxf5iu696rfbMMrztJsez/kp9SwOHqU87D
         MMCVC1tR6tHkmZdNV28vTM4EkthJQI48sOAJ76Ff3Bzar8DpeVBjO0tVwU8SBtyDVO5W
         NY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793247594; x=1793852394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0sE5Rrg7254a4JIqn8LaORoch9C7DlP93N+XE8pi0A=;
        b=QCJzNM+Uu1sW83QoOC8G57R+/EUMYdJSu1cMD3XUt4mB9SRuRBNAATw6rGyZTDbJ0M
         /5Lul6eBUVcbCrGn8KLycuQWNirtKjycPTnQBr5pRnaBdZT8KT5QfHaHPoHKr+bMBWE/
         65WQcemIiR7NizWBqW4KFkj6ujIMPFAz+jPA0WhWEWvYz7veU16JR6hs8NXzJbVKzYGa
         hj33wxD+ETuaMOuN73k/L4I1MwGkEqWNKRnR+3ccMk4UCefbEng02FtZ2trI1J3Ci+xJ
         aH6hEfMzi6qSawseeMEeo2dnmfF15n4xOGMplEzSWivPXqHaE1DQUvZz5YQvv8dcsmBJ
         ke6A==
X-Forwarded-Encrypted: i=1; AKwUvBxw/kCiR31TuPmK2ZQN+fjGxBbilkB1WnnFjemSt2WhrFP/BtSS1O+KoiYqZSmXq2NaezR+PyWbkYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUJ6gdloisGHK2AhTZq/cTko2DWIvXez799iZM/PwoWz4eVlDi
	SOZcy1gIV7l97/JG3mvyPlmSmgb81UvmvBqefZDsJ/BkpPT867StqCyu06yckMjJgy6aV7dfvtG
	Eo3wuLljtijs/A67hT1XRbNOTt8JTWDiul5K2lx0oH90dwiFtdwOdl6K57QE1HCM=
X-Gm-Gg: AYBFou1gVgUxTEynzhRbJg2NuU6kwyXK5HdP5JAyr4vL2s4lZCFbpqviVNn++uCoGHL
	z037KRtxzazZJos98K4vF7wUC9yikEvFPd53awN+cDvV8z46FmmcNnuTibHnzAOfFk6n1k8Z8nr
	S02GuE5HCkOd+0Bq3SJDnMn4zl2hNx4Q2cAX54JkEjiSq4LDVbcpjsXmgCc7U+OyzRPYRETv22A
	HVaxUtJLBNnRPWkxRRsTV9FIcTF+1ve0gskrwfTHnmfwgJpUHrOKN7GKHlnkOO41UmUqHoPytVk
	HHprO6nJHTNxfqfACe9/tIwoFpZoIZuNBrfKSbB1EJc3rfXjE2bO8e8IeL/crnQDXXT2gKatbV/
	/MwH43k3fMPI8pl1GmhXP1z5UeP5xxBBfKeCZf1Ri0bYGP8cLZjIhnjoyu3/BleFEZFTu07GhhW
	NRuoNN3Go=
X-Received: by 2002:a05:7300:fa19:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-36a2007c0c1mr6317762eec.8.1793247594419;
        Wed, 28 Oct 2026 21:19:54 -0700 (PDT)
X-Received: by 2002:a05:7300:fa19:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-36a2007c0c1mr6317722eec.8.1793247593833;
        Wed, 28 Oct 2026 21:19:53 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm27504539eec.2.2026.10.28.21.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 21:19:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:49:29 +0530
Subject: [PATCH v7 3/3] PCI: qcom: Implement shutdown() callback
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
Message-Id: <20261029-shutdown-v7-3-3fd7a76a6991@oss.qualcomm.com>
References: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
In-Reply-To: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793247578; l=2818;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=oSqbVmWhiEtExXZiinyFNkHgOXlRYhi51p3ejlcaIAA=;
 b=Ts0eOFTto477uTOtC/lVVj0fCHhKCK2lG1oWhXLuQiuur3YKnTRyW9W94Tb0b+oipIN2FzzPY
 A82yGkUW/uhCoTKna1oPJFYIQaHDHu+UlTlst5qWKyKzvo1B3+3O4c2
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxNiBTYWx0ZWRfXyg3Jq8cwMII6
 BbF54eTnaceg4P7xVlKVSnf1V1mBZ3qqlEmu2fQAbZk9nrdzKF+yCxbkxWPqLrgKJTGCxOr5ozz
 9n/gYT733AWa82xvNnyIdLtiiDhMWZYObcLNKeQwdwVxPgZD0TSypJOW+NbcBKC7EEjiEUp1YU1
 eZkvb+UUwaCG3dV2LKjSgxS1Vjm7qR05uwzV++5/CPCDGD+f1Xv0fmdiz4Ok7JVnwOFxTpgUfxy
 J5cW8jkruVoAMsUN45axi3o+I5DN5VLSsWqY8GPeGxC9AvQD11q0ZGEAh/XBUH9TD3evEGxI5KE
 wlSE9RqLyENdVzUpLbN86ZjihlJgR1qXRf+aF6UHCssvlcZ81n1rkMW0Sajy+zbmAILLBAHcVng
 6FeG28/zCnmA26PM6scOkfNq8HeekYRgPULIAuNqdDvOtlWZv3sQXJKfRB4L/4d6eDjIDAxhaJd
 FWD4SvQqk5BQwIYFGpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxNiBTYWx0ZWRfX1WY/BQp33fgM
 Q1WtHrHkJXwncjOV6lEABLd01pQxn9Ithqq2t7rgDCXV4sPUgySPH+GNab5e8y43l4Ne3y0Q6cc
 +vbNfwtYujsr6EMdlddKpmfdS8V2z+U=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae2c96b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: T-TkFQzCn2HnhkWrFbJLBnvJKAS8unc6
X-Proofpoint-ORIG-GUID: T-TkFQzCn2HnhkWrFbJLBnvJKAS8unc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290016

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
 drivers/pci/controller/dwc/pcie-qcom.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a7835e8a51e0..423a90d6adfb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2031,6 +2031,9 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 
 	dw_pcie_msi_init(pp);
 
+	/* Stash pci so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
+	platform_set_drvdata(to_platform_device(dev), pci);
+
 	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
 }
 
@@ -2451,6 +2454,37 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
+	struct qcom_pcie *pcie;
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
+		dw_pcie_free_msi(&pci->pp);
+
+	if (pcie)
+		dw_pcie_suspend_noirq(pcie->pci, true);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
@@ -2641,5 +2675,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.34.1

