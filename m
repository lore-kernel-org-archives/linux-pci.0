Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE63B2FEB
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549722; cv=none; b=SDABEt+n3zQGAQkwEuk1Heg5hae+ir4hdsZFTTmnP+57+KkxPanY292gLJ5mSlgPTqVzr28Hkl0YxDVWLfrwGA3z7p8NegSBzhLr5IIBbgj2J20nbWiu4y4kKFwbQ2HEk6wwyVXgCTyka+JN5NbZrarXNLMND5ia8Ay8b/LJtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549722; c=relaxed/simple;
	bh=Gr3j/bc4r8i0ncFhXrYatBEkauE3ZXxaz9dWnL/CP58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvG5h1XZ2ehmHMe5mzkF2THgLPICAmso2ROyMQOajVnLUYwtRwS3XvAflsXbY+vz9HzUqRxMTQsXOHGpJbVEhK/9RRq75Rrh8btVTVzVNRn1jbuB9IM7FE/JnFp8JO8u1xLchswmrT5QFAJOvJdNRlBXOPd9Qv9v6fHYGwZVChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLRkxMXE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RtQ5RWkD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLRkxMXE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RtQ5RWkD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RGN41577105
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7gnxc0Y7AdzTUkeyoIh5jJdd1ZA5WK6Avh0PA7l99A=; b=XLRkxMXESNVs6pTJ
	DvBTXyVCIKFhhrx6KTOnyrkGvTEWyjKWDcviICjOhvFcYEzH2MI6iPl6F/XVWXJp
	fH4AJ4pIcQLx+9Luqe6MJSTg9nqtzuHlChXmyV7q1iFet1X0P/AtO+LNhUpk8UIz
	lX2NXbSS10s/1DRoBl8lvJNvn2cWjKdP1li6R9ZHKaU8SDIvrnCd2ZSSt2CI8CMf
	20MEinB1o4S3t8dIh3TpV8WRxBVByl4iir3Euj/kMKON0xFFJlKzZP8BVQpTJPq8
	wa2ndeo49WiFO9CMvQByc8bZ3tudz9jg42zAmgrMbgbE+W5+vS8EF4fGQMToCNFw
	g8tHAg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74hcwb4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-385d2703b64so4359178a91.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 22:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787549716; x=1788154516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7gnxc0Y7AdzTUkeyoIh5jJdd1ZA5WK6Avh0PA7l99A=;
        b=RtQ5RWkDP7/Bs/N5B4NVC0NdgLYXWzRN0bpLFk2kisLUsbSnhhQ1QOXEOM+9FEPchH
         UMxj9TUtFfIYGm5xOMJxt87Cpmki+yidsVSrrRef+lCWELk93RqdDST1Ual7dEclrhxD
         /5Yhw7TjtMbLyhvbGy7AuoqkwkG0FClCa3Cd6HuNbTDw8SNA/fuG3vwDaPD+HDLOUjDu
         gNJI+gSGyWvP/peyLhpdELuJvj3p4L7Q7/no6Wbe3TFK5CpyjJ86kvU3RDI9K9uOFSak
         I/iVwIRsEV9WlZ6YisjK0yKMDCxsVK+KpjD8BlPhJVFSV0o/uvd/XnQCKilEutw4g2fG
         ycrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787549716; x=1788154516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7gnxc0Y7AdzTUkeyoIh5jJdd1ZA5WK6Avh0PA7l99A=;
        b=shzwVhPsN3tdnMM2JuL1w6fAkzlTIC2FtHEJtPkruB46ULRWjnQCnBxkT8jOs+LYgD
         7RJTMmKbNicGF5Y94p8m+u6hItXc5P1j/piXWgAyrUxNvn35E4bSKGS5PD4R51PZNjqi
         AEneZqlwPRNcU40wFi+HEO1Fg2ST2Tu4X2g25KkbyzXDlNJFXnvQTev4mbAoZbr/Hd5I
         ghuwLhA3BPwv+tIkKdbecRsllFFmpppFBWKZ+qXbsAA95bp/PLd2d/QJjY/sHcOoC8zC
         7oZJb1g7b4B+/SweDf03nV1tQk/SpfR4K0Cor6Spa5CR0K3bXuxY/ypJYkg49ilRfgr1
         5cGA==
X-Gm-Message-State: AFuF++nynacQs+XfNj1DNk66Y8EPxIRyIU8/a3FLWUToIxpu43pC4zks
	Hk/92Gf6QRf+0Uyq6s4jXi3/AcjQHBJIlnCXz2dgpMOLtP4J+mnbalHRWrBHUZiAq1T6nB2GU79
	DyqfadS7gL6Ov6H7DIhSMATxQBtX8TAFaY1FY6Nh9hPZXCuwPima18HeNpH4Upo9kn1oYf2k=
X-Gm-Gg: AR+sD12cnu/e8Ia81JxZrZOIio2jAoS8DScEca4QxiJvjcp5VI2+iCDDpO4JT/juGlE
	Q2wiUzA1TNirrbFWeQIbac6xi1KnSswO//HNlEph2Kbuo5QlVjBlurSPVwevvcLbmmGirl3gM8d
	KGTK1NZSqQ8U/nj3UzROQCviE7Qa9cyBuwl4EfVQEP+7zwCtf+hrteoK59dXcltwWFOrKveGHZs
	f9lVmhaN5WzNVTseq6Bh1cJTJuLtrEqLhdA4ODBa4+5WZaN7rsIGeDu9vl+MugbxFJW4BnvtNhG
	tVijrlbsE92tdXT0hjyrt3gH2pe62QjdC7jEW1BrSx5z5GmIbX3Wb9dpwjZXbeyslBF2OzIB+9M
	fn49s+afk/GvPeq/eKCVxcqPuIhlIoizIFQ8=
X-Received: by 2002:a17:90a:d40e:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-395a071b857mr37436813a91.19.1787549715994;
        Sun, 23 Aug 2026 22:35:15 -0700 (PDT)
X-Received: by 2002:a17:90a:d40e:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-395a071b857mr37436750a91.19.1787549715545;
        Sun, 23 Aug 2026 22:35:15 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327ff728ca7sm20166492eec.3.2026.08.23.22.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:35:15 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:05:00 +0530
Subject: [PATCH v3 2/2] PCI: qcom: Implement shutdown() callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-shutdown-v3-2-81c14bb7a1af@oss.qualcomm.com>
References: <20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com>
In-Reply-To: <20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787549703; l=1611;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0cHTaxCZhYijIaWac3FDVreKAhduxOIxg24XX1VGE0w=;
 b=La6xvZgrg53OkQBdhXJXN3dWr7kVxRj/tk2n1HR8Vs6RVyUql38BNbLRgN8czTXxn0bR/oo0B
 9nVL6LA8o4ZBkD1u2m7iFDbNqRb7fhKUYf6w91MndAR8I/MTcDroyL4
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 13bFrTEVA19a-MvyYhCagXtqdZ-wj0HF
X-Authority-Analysis: v=2.4 cv=U7iiy+ru c=1 sm=1 tr=0 ts=6a8bd814 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 13bFrTEVA19a-MvyYhCagXtqdZ-wj0HF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA0NiBTYWx0ZWRfX95YFX3bifsnK
 YDkvI4SPmX4i7nGqLWPJse2Xs8uPd5unCx1sx7FUFrWAFjBP7X0LeAb+RZtt1Qnhvm/s2L77M8h
 hejGaAewpdW0KyNfKgYRubEuEZg0cHwYdAmHpwxVDKETlGl8Qj+cPnANyAsPD67rF3irxNX/xiK
 sp7DaQonF094bT4HMFdrOcygwJoQ4kO2cC81Y/lHxQlUc9SBaV2oAxuh7TkJ4mKaeRs38oNBeJV
 6SFBD08EHKzQx9YyqKkEjJBsuZWvQN7rX0hFFvjiSS+NKCeoR2CvtyLy1Lmj9yjBJ36Usw7pd8Y
 URZ6YJauDZh1eyc0LP/Vo6zi/0aBJLKg3IlDp80xgel8O+9LKJWZ8oOxwEwhVMlpMy+sESAzpa6
 iJaz9Nph3gwsdrAE+IdJvQY2yT+rN8+Ur01/ESXdXze0TuZSBXpC9LVjWpzPceBVzCZ+CH8TTGr
 RS6sFELxtF5AAUyazCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA0NiBTYWx0ZWRfX/AeWHn4tqfTI
 fRuXdRKGofWE7wEht0zPoCl8N5O7j+a4epovL+nX44qWtwgxVKm2K7KixE3/7faApWlj0IyeLLC
 qBp2WfHkZnfzPMicChE/N7F/203yFew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240046

From: Manivannan Sadhasivam <mani@kernel.org>

PCIe host controllers should bring the link down cleanly before system
shutdown/reboot proceeds to remove power/clocks from the controller.
Without this, the link may still be up and endpoints still have
transactions in flight when power/clocks are cut, which can trip SMMU
translation faults or NoC protocol errors.

Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
into L2, putting it into D3cold.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..a4284c64de27 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2156,6 +2156,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+
+	if (pcie)
+		dw_pcie_suspend_noirq(pcie->pci);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
@@ -2337,5 +2348,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.34.1

