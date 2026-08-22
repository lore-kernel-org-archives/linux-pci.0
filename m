Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDA374A0E
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787376884; cv=none; b=kGIj1VkHFrESN7dHIebiPbeZU/hh+sQuNdrWAlR+/F8jThtuk/+ttLZ8PXKgr924N6uWvTeSlmQOs7J7kEVVefLHw9qRl9VawoSArxqNGVfX8Lx1jhETOQ3KKhuy8kTd2036sL3Xmg8K1ZCr4Si4WItFYQmFiiz2c4/qX2NWqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787376884; c=relaxed/simple;
	bh=lfm8sjkOPTADQxZtDBD5hzF8zBc52BR/6QvdYJq558c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2fSPIJsz4qKWKpFkQ7LAAAD7Z3faAGirwQa/vUqCrJt+QLHCSaudHYikdw8N4FBEFh/Ti3NOZiaa5MQfQkyAB6ymzkD/rBcGsUgJn5MPNgKALFG1JMacSNCWz5zoTcXTXU4zmBgRMHfcx0tAezRRGPq0CxMbhVcX2vpPo2lV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D8ieEsxr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XwbLwgyK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D8ieEsxr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XwbLwgyK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67M4ldlq3948553
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ph8WruSKEbFc6T7Mv8UFdoVf04BR6u0RSAEvYc1fLXA=; b=D8ieEsxrL6SMh3EW
	lXLBjMf5AF/igij2djvrhdeFmnSPTXtcvOyfY1H4y2/d3Ed2uUrFHOklAS4iZKnM
	VxG9e5aY6TOEP/iEC8267GcSD8WFcj1fOESVqMFRA9FI46smCFXZM790PcFdnTMm
	rWHLyXsVtphjgsTDM6w7HRlOZ/jk7Nt4dYkwv6yTmBPqcT3K2YqePsZdQt8W5sH8
	2rBxv/JDSvfulckWwS2ambPE0qsTCxfXDWBdPP3k17zqmnpXFjAGR43pbNLUjrFR
	+moR//DRe6DN8rlLejKIOpjHLzNlz2eFUsJ85H4ppdWN+v+HT52JuljLf4czVm15
	JVr0cg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7528g2d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:34:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb7049fa552so1670142a12.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787376880; x=1787981680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ph8WruSKEbFc6T7Mv8UFdoVf04BR6u0RSAEvYc1fLXA=;
        b=XwbLwgyKHMCn0rGoqNo0JxO9O4OollYJNbCSL6NeKsEZqjZPF8/yr0YKyBaIg3K638
         hcnuuCQ6Hh1l/fZ8Ts6nsx2FofBNLRjpHXU+IWG+zahwevfAWGnE8Vv8apODoXBo56RH
         r2YWXqjm4B16qUbbFk2yyq88sf4PwXW6+Q5nfIewCjJU39zptStY/xTsW0JYrRUPo4t/
         Ijc2YA9pexnF5+BccAHe6Z1Kkc7/NI5boAXZV+vtNGA/0Wja1i+1j74gH7JwWyUcCfAu
         UlW4B1AwK2NLqH3L2FY+DavhB4Kb8PFH/wRewltLaf3G1fi1ExiY5E/wTQPxVWHh/oTW
         VKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787376880; x=1787981680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ph8WruSKEbFc6T7Mv8UFdoVf04BR6u0RSAEvYc1fLXA=;
        b=jFsu4UxQM5/YWertVBh3yyh7KJbhSYehS1GXDbT2tJ392LusVNF7VCsd64WoorM0EO
         waY2TBaMqWQHDot2kWggwoNz7hwfTbI75XzvPAWOJf/07+AOt3AZYejh3lVvkMOAaOGQ
         hQkNkimnlHapPnj9xIaD+p2z1+9I+c+ijJRn25rCuyFC8BOb2H/fCIzKYVOrBrNwCr+b
         DMoyWhM/LvS3D9z684Sp0DaMt0QWJ/0HPwWup16ErjM/Qi7p//EaIxoENRRwXFl02xXC
         iAPS51f15yJLCxFyYRo21z7DZXeCxFCkINT3RkWZK+0L4MVAELKomgUCo4Kv8saBAIdy
         CcVw==
X-Gm-Message-State: AFuF++kwm5jV4BAK8Us8V/6Kw4z5dL4H4GvAgMJO4RflJqpDG61WzzHX
	BdtUFnyFQF2IceoWRriUDlNpqKMmqdF4ECzSPCvlfY5mx3iXkpsosTWYE2JJRWfrbpMKckQ9r2u
	EQRzwZKTwqRvjbSY1smR5X/hWAYg4wpy68ORBc2fSeNVGe7aZscKdH6N6hTBnUXU=
X-Gm-Gg: AR+sD10VttrQ07TiYNAPaZzw5T1DBY0kS+iHDsrxB/MbuNBncJlXS9yPf2mw1QMs6S0
	3Ny9Rr/BgQVT0FTRqNNXx7IKor8ans1A0yJ2Nv/9HkMoSC1rrwM6tJ3Elmmy+NKCTH8nGO5pBmt
	9LQWHmHd/8vHYguDmkhCUNxBb/TgMspeYzdlljVDTCJJj227W19IrF4rx/At7qL26Sj3x5cUy12
	lSBto+zehCVLkTsWpondpG+1Jr6KAR9QeAVcMk5cc+KABlmIvK2qdddGNpb37T6XLt/7wungUaq
	671KabGgImwQXewgAqEz17ImoJy1wumFZ+27d5ILJpTobJB2siCTMzn9OlExqZnZDlEYbgdvyck
	FNGy05ZyGz+o/lYaM4J0Xo4ftmjpgCbeTlNQ=
X-Received: by 2002:a05:6300:14d:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3cd2fd4d873mr22960154637.1.1787376880265;
        Fri, 21 Aug 2026 22:34:40 -0700 (PDT)
X-Received: by 2002:a05:6300:14d:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3cd2fd4d873mr22960112637.1.1787376879868;
        Fri, 21 Aug 2026 22:34:39 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923490bsm3533807eec.26.2026.08.21.22.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 22:34:39 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 22 Aug 2026 11:04:18 +0530
Subject: [PATCH v2 2/2] PCI: qcom: Implement shutdown() callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-shutdown-v2-2-520a68f1b4a5@oss.qualcomm.com>
References: <20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com>
In-Reply-To: <20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787376868; l=1587;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ujdneBqqEPNhVSFLkyQEDWkRBsSEt5wYKZCCzw50To8=;
 b=+ZOvppKnuS2RSPiNvGJ9Upw1ktAZcfvFKgBoa8GkdTdI19krrIHQ4aUJbTddu28w+e2xWvswp
 dMlHft84jZ5CBKaAncybB2q525upjgCZazS98B7/HDZixO24SEO1EN1
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=DsJmPm/+ c=1 sm=1 tr=0 ts=6a8934f0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2HGXtJhCZC5-pDRKouR2u-30rxNKgCX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA0MSBTYWx0ZWRfX945mOPAltad/
 iH1beBpTBuyf1Pyo41GrAXS7Wm0CRFRkMQ4b1g9ZGh3gikRfHRtEV86cHbO8ZVHZNgrthEyGivC
 Dp4qhceURQ7VRXk/hZp2QFnRi/tz1AoCOAUJXrVQCnhQmkDHEYiPiVKxcrTFCzPuj7BwzFtJJ6Y
 0DzvHuiovTHj9lN5cC2TQGEqft1FYvfiuAyN76wyKO2K1TizlnYRaZ/ZypdTfTHeqdi2AQcviD7
 uxYogx4hNOWCFX/4GJUGQ8dT2Z8cJfucde8mxTKtjK+WkdON55RvJ3YP/j23jA9fJzlZ9rrwMxk
 5LMXE53YWY0wGL2op5Tpcn4iClKYNzCTf4GNWhdUSMLoXfOuXWPeDUq6nMTar0PaZzjnb0sNkbC
 CfAUv5HSW+XQkBbw4tteqST3bJKlrbbDRqkMB4t8fe0vEmi4DoRc+iTq6nn0l8iHWv0573ubJP7
 uHACOKvoQxuPRT7o+DA==
X-Proofpoint-ORIG-GUID: 2HGXtJhCZC5-pDRKouR2u-30rxNKgCX2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA0MSBTYWx0ZWRfX1+trV3CtukGU
 aFmYE6G+LiAMdU/D5w8FRbmPwWQ+43j7g5i0Ndv8X6xlpfYmFo6jC6/oTKZ6Q1/uteoEBfvpNE2
 wlW5Q1lrC9Q8qWl0+2vASiThpYRzCHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220041

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
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..f6a0cbb6a49e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2156,6 +2156,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+
+	dw_pcie_suspend_noirq(pcie->pci);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
@@ -2337,5 +2346,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.34.1

