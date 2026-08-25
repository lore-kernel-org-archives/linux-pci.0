Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D830D402
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629255; cv=none; b=sp3iPwvKCyzU/V7TJY2L7u8JtY+3ouMkFYq1i++mFflA+n62jN2tJgZ9cBIOk19Pej4DxTnwU0ATsYe/Waa8pFiCSgyAhXzi9ZGk0f8voqzccEgMHMmYEyxnFZWsLH1yiMf1rtBdz1Ijy+33dauezcrqvY4QboA/JMzUtm2UKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629255; c=relaxed/simple;
	bh=pnUfS1D4ryHbnN3ay1WHwI/EX6dn6xIWedo2EUlAh/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5jrEq/lNDrCvD2/39IEU5Zp6zawa+s2VeW4bkbxtz7r4fqqN8OZt4HzDgAnhLzPemiiVD9pAC6Q9MGKZYevY5+EfW71Xi5AorpTuSn1xdbCtiM3MlyuNFwpBga74UCe6pc8ipDWePjeZ4wI6K8QcYRG+AVdgkHBht9x2FXkW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mPppTo/9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A9taXG3h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPppTo/9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9taXG3h"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2R8rX3741560
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mghAs4DMl2QziDdbSxmizHokUORt+deiKrfMBKoEfws=; b=mPppTo/9avOwHGMm
	dKBrG/dYKB/oUI51i2f1MUnFSYAOGbtCUszwmZb1NvnGuV+9w4xlTxcg0qlBGSHw
	gAJb4eDwIqFo+oMPd2gbwYIJkt3WzIbrB3gzz7YLFiPb+1eJJkFS2x1Ds1TwteW3
	g30uLKm9qzeg9WHQ14QbohVQxOCPCuaHlils57Igf5F58DAMPMcIbXXiwKu4sSR5
	4RzF22c2fMbb6GU445H08QeQpmYDIXy5aqkCKeRB/IaJSI6BgsAmQ7qT6bCJz1Xm
	FJ7cb1etuFLpzEHu0KvDnzADi4N4Ui+ngpOq2jNLATRLmfTzzSTv1os5gyvr/jSp
	NnpiMw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv7bsxw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:40:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so6393330a91.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787629252; x=1788234052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mghAs4DMl2QziDdbSxmizHokUORt+deiKrfMBKoEfws=;
        b=A9taXG3haTiwHB21z2dhsxEkmcrVwUSTk5pLKDy2VSZCG19/RA8USDqt7tVnCT7YVD
         ktcwx9iUt6MWzk08xfzXt7bmbfpLMJeQKtIUHIsuuguO2IF1JMmDcxE/i6HGLbkH0lza
         frMV2XXmTdfyb7usXUcmwubk4Osrvoz/iLFNaGHZ8Kkh/ZwHS+dNmoP8AFfU1GdhErau
         zr5xmZDny7edR0WjTA4KYikVN77W+0dgi64lymmQNs/bMkOcMKY3/j/FSPW+PUiKfppf
         xdGcfGy/jWYKZpJ/LduOJjhHiuK7AKPuNOHW724SpQMCtHWZ1/pdg1u9KdxA9B/ZQXgr
         32LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787629252; x=1788234052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mghAs4DMl2QziDdbSxmizHokUORt+deiKrfMBKoEfws=;
        b=chDDOzRcDsciYGgaVAwol1VV2i+UU2sEQhoMuXDBgR9syk7KfuXrgR/NGcJAUXYnP6
         wzlkUHESEc+YdVD/XZDYiGDPqY2mMJumRnIdzxi20T3mt9T6ogkQHXalJDIaU9DY+oO1
         SmeEADnRCCuxSqbdDJoavWk1WBGkdtcfZKou1T9YGQOxgsjwsJ9vghYgiTx8xx1bcHn3
         7ZGEhLBJEM9kRuYNmGwsSFYSRquLVEJH/6bTkkMh75dJ12S3mVKh6QAsKAaJPuCgZW+e
         YTCE5uaQKauhMsTD9S6tneJpt8DFatCUd+l+/ZsQGCIuIelHnbxDyT5IikPjrc9BlJK9
         Sw1A==
X-Forwarded-Encrypted: i=1; AHgh+RqIlk01iJpz4CoZWfaL4Xnxe0IY9nPlHwMXL0/h8w62cXXUGjpSbKeUH+I4uBiClEUNIKv1WLS/xK4=@vger.kernel.org
X-Gm-Message-State: AFuF++k8XHmBnaUBPa7LGeyDeRps1H01EQfew6B3oFGLg2ybpO2pJB7Y
	eAY/j0+NglgaK5inCCYmX+AY8GUtP+FDJJtDwMbwtOK6k7z3s5QFgriZJzhXh+F0lZ/h83Id7N8
	qEJO6UME/55LC5OJKKIEQDzs6M2s2dU/4wkc/DTLkgAQ/5mptxHE9cJMVpFlutG8=
X-Gm-Gg: AR+sD10KrCLvENaG6Wmh4PrOXhzzGygG0ReA23F4JNQRLvzzRN6U+KDC7mdtC7VATUl
	p7n3X9G4q1F0krKysLgD1r4LSYfKl1F9vYH6a2oHmtQzJvYv9EpimoecLcom1iYupySofKFwCbo
	voxBtqxrExl2CUZfYRAefPXRpMiNg92ZtIqSHYk/8TdiiZB1XY2FrXdIP5Pgw6eRNVyAhab1ZB5
	LmmJJfE4LYWxnqsVCNXxjuGubI4XGL1FgPk4TbRAtUaWzrPFt5SZjsg3cqdpRScdKX8pDDwOot5
	qjAXqZByaet8rThcOAW3BGFL6ucoixeuiFgWmVqPafn9zoglP3iI+a/iNTeemBUwxpooKzozwnA
	k101H7AjaQwz3PA2WlXkO/qzsVlzIP7Bl8sg=
X-Received: by 2002:a17:90b:1b41:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-395c39f97e8mr51196090a91.16.1787629252090;
        Mon, 24 Aug 2026 20:40:52 -0700 (PDT)
X-Received: by 2002:a17:90b:1b41:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-395c39f97e8mr51196015a91.16.1787629251637;
        Mon, 24 Aug 2026 20:40:51 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d36f9sm46440083eec.16.2026.08.24.20.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 20:40:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 09:10:24 +0530
Subject: [PATCH 3/4] PCI: qcom: Add CGC disable workaround for Nord PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-nord-v1-3-7c02f2b8765a@oss.qualcomm.com>
References: <20260825-nord-v1-0-7c02f2b8765a@oss.qualcomm.com>
In-Reply-To: <20260825-nord-v1-0-7c02f2b8765a@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787629229; l=2301;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pnUfS1D4ryHbnN3ay1WHwI/EX6dn6xIWedo2EUlAh/M=;
 b=A5+LJQ0DvKPTuC+Blx8ArneS2OlrX+eeCZcHQm7Vd8/jAHAYY8say82bXyMadyPhau9mYbezZ
 gO8kabdxMNTDZOjgajCNrJiECDYr9EwAn2LoPTA4K3vJwLP3J57E/VU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8d0ec4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAyOCBTYWx0ZWRfX385ClAMXlRIE
 J/39gOV1x+fN/Av/ugK9uaNJOY1PIzJlVskQ1CIeQb3JL3mABH1sAmeKqMqe/eqbxc2hW2XlpD/
 S2ADfLCGAAmqnW1jW3YvA7CjPcWbJ7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAyOCBTYWx0ZWRfX2Eq6ebRJMDHu
 hp/Uu5FK0MwNIoGbkJ6v9APx1fIbbnrTGITkRteB3sWzFtSBa7YKRrVCLwUfoBBLI0P+XOkMBQw
 6m/JZkz1ddvealiAE3wppd8kYgGsUt+P/wdR7JhmfB/7y3n2I6xscc8uWUmAY4mvEKcO6hAY8/s
 hCE0IkULEaJAIVIUOXIIN+jDXCs9FstXJZ22jGPjzOEuJX+KJvYTGd0K7tYchUmob1dOxoVWDyn
 gWzL4uNdMmJWweKXQ7vqOpvLqcoyjNGfj6sra0/EUQWRk4BSIpncKQYzKuZYnMR2tLL50lFT5dN
 DDrP4PcIYjENRGpg14Powu0Zw8o1h29lGzRYh0mUqArVqnN5Z6E7F0JTl0WQIAKiYNKrRAbUfpE
 nKQiB7zowaTk3lg+2eknKh0leG1paTpz6h3cCisPtVMVZFthtQWaRt1002kfr/J9m3OWvTVKjMb
 4SwZ/td5EdjX+mDrTCQ==
X-Proofpoint-ORIG-GUID: O2dcWYplL6R3LzKHI5SLZ6FIYQSDhw5v
X-Proofpoint-GUID: O2dcWYplL6R3LzKHI5SLZ6FIYQSDhw5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250028

Nord requires a workaround to address a timing convergence issue in the
PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.

The SLV_ACLK_CGC_DIS bit is already configured by hardware reset. This
change adds the remaining required settings as documented in
QCTDD11972446.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..9fa7ab47c86e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -266,6 +266,7 @@ struct qcom_pcie_cfg {
 	bool override_no_snoop;
 	bool firmware_managed;
 	bool no_l0s;
+	bool cgc_dis_workaround;
 };
 
 struct qcom_pcie_perst {
@@ -1073,11 +1074,18 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
+	int val;
 
 	if (pcie_cfg->override_no_snoop)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
+	if (pcie_cfg->cgc_dis_workaround) {
+		val = readl(pcie->parf + PARF_SYS_CTRL);
+		val |= CORE_CLK_CGC_DIS | AUX_PWR_DET;
+		writel(val, pcie->parf + PARF_SYS_CTRL);
+	}
+
 	qcom_pcie_set_slot_nccs(pcie->pci);
 
 	return 0;
@@ -1604,6 +1612,13 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 	.ops = &ops_2_9_0,
 };
 
+static const struct qcom_pcie_cfg cfg_nord = {
+	.ops = &ops_1_9_0,
+	.override_no_snoop = true,
+	.no_l0s = true,
+	.cgc_dis_workaround = true,
+};
+
 static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.ops = &ops_1_21_0,
 	.no_l0s = true,
@@ -2282,6 +2297,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
+	{ .compatible = "qcom,nord-pcie", .data = &cfg_nord },
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },

-- 
2.34.1

