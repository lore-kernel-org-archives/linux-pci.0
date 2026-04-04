Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AA2BDC26
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290662; cv=none; b=IS7AdXMrTSQClYnIFxrBzanJ6Av7wdP3KrvrHur/sLmFn0Cajbj8Ncctj0cWUJ9/J+XqutCZtGS7SRZRSI7IiUcucAxuAZDUG224AJFUgXI4RUmofI/DWvb04dQ8FOoMp30UY9nMcBQ2NApFGKD+wr9InH3X1gj01btbJ/ysDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290662; c=relaxed/simple;
	bh=eLlhRSUUKQzMD4xw0eb0Pj6hBFVgOdEaGYz5rmdOD0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1HSYHdKY61GycavRHUcd3dP5oy6/rqNWwC94DyHM/FCf1oNMXgHz/AmjtxD20ib4Dc2A7tVmQDIhEOLAe3Nl7dHG76PP88YBIi2w2x8VZQXYYjJR7O7Im9Mos/QR6+oH1RgeZ2aM2Jhu20E+zBba8wCKQTVW3SPYsGpnhyAvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffcfS3+B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IPRYAPXk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffcfS3+B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IPRYAPXk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6343QuA43674654
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OB5z5FGO7HAe2Yk+IBBuPNkY5p8wo0CfJYzjPRUQkDw=; b=ffcfS3+BTvBbv+EE
	I1wBJogTYOW9h/dznyyI+oU00H/m+uCTecxgEZjY4aomjxMrR6l9k/XX0qNiUmic
	rucV2m6DOST2+CpolTqMA9+HsjeeREmg2PbqYguf+MfG/W8CzPkYLgNfw0KOVE6q
	vvqXT7/TwwSRhM1VMiZlrKgcpUbprCbuhjp+Y12mUh32DOSENOERsAiJuDehPnBD
	wm7kDGcfuCMzV6QJyWllRNXgBO32FfGJnOA7tTTweExUXUMHick0CMZBAIBszU9e
	meP21wXDwIO4MAThzwF2UF8TIPI0mD8XMCBUfPi2YJCQhr4Ap3lLXs1J39ksVaoe
	62LX1g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datqsgfkv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:17:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76b6ccf298so1441876a12.0
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775290659; x=1775895459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB5z5FGO7HAe2Yk+IBBuPNkY5p8wo0CfJYzjPRUQkDw=;
        b=IPRYAPXkHh/Pl7szWWUZgYjS87/oQrUEDzf5u1FoBajDMxL/ZAprfe37hrAv2iT9x/
         YrsUclLgwlVLv8jdF735DS4VKeTrLnf9E0zl5tNCQyQdL3Cmc1CDu1mjn2RyjPl3X0b6
         1URD8kBpPlxB692uV79KR8jVVOa40Zw+4oOPrJwg2oHPXHRPLguL83lmmLsSkfoQxhUv
         yvqz5tv559tptU23Z8RrsRf8OTrD5ew+yW8DZ4XkHQllPUYlOVadH/032d20sTn/XWDO
         j3Z1++kmzcQ66dUPXk9fvEvcfTyy/fs/kkgciBUofxfS1JOkEcXbcnqUdTg/uHxx2ErY
         +uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290659; x=1775895459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OB5z5FGO7HAe2Yk+IBBuPNkY5p8wo0CfJYzjPRUQkDw=;
        b=PFVEEkyuPwIKC8ihZ6vL9dCWtxDX+/UEzbdBVbkN5w9hq81T04mYgUFz2NAeq69g4y
         MUnBkJfZ//TbWprapEjgp1f01Dlj2NQwlR4Hlg5d4ae/iVPKKlRSnz/ecaQfyXhCr5UO
         IEkBNkZD8doKJk5q+Le2ttvCFrCwEVZQwGaEn1zGFOsx0+5hMKzzeiFcTs9eR9904WwU
         RmpdmUx760raduoyZSREtiEkrsSUjscGsuAMJEQ8NAXwTb61Z7rfBuOCjd6jxmSsCoFT
         n/2GAuvmMB5UQhV5+7wU4XaHbU7fGwPYV+LTY9XampK1xM3Ec4mDnvzxkIWkaRgnoIO5
         ubxA==
X-Gm-Message-State: AOJu0YxIl8j0gSi5WUafodDrH2ICSRKCfCXRKuVSO8OP0jT7Ln3VzxHH
	Vvf687NY9yFtfgrBYdhIL3UCVrQ1k07La+mIIreSFGKB0IvKpKX9Nl5ZskWC8xEon2q2y3hz4+D
	JJEdPWhTmDUk3XE3Wxg4KGCjAn9hq+ca266u4xQ2BjyqVRuqvm17k2x4hwLGjUpw=
X-Gm-Gg: AeBDiesz8zNNbad7cHDAr7KnK5MUc9+pLsliHGzaBklbOnsO3dcQWudFfdSBdOhN603
	5BrS1Urszarvs2+7j/Us4+1Y77WyM/VREEXCnlH+mC2bPrCN81IrQGxBFZrE//rx6CyYlmdSur1
	1a11qCd1eSwu5Xf4iURFHGB3Xg/VUI2sK7a9HSdtqeqO2bIpLW5cjIv8ZXEPG+5iNsAmtOHRk/f
	Ro0kqWeB9V+AnxM5Lf08nIhSdemfKcEDZ4kVW75wOQF0Zt+zxynayNl5NDs3tugKILNyFkMFCki
	h46S/BdchuN3aXyE2NPeS70bdswUde0ePW7L3XrFAu6gU7xSe4YgMvXZsyh7zZkK7+13yCacArT
	x0TeXvSPpVeNGBDKVBEsYuJYUqyc+biowO/ARAEaS7S9U+tlapOUHjB71
X-Received: by 2002:a05:6a20:1587:b0:39b:fbb2:5e46 with SMTP id adf61e73a8af0-39f2f0968d0mr6019726637.40.1775290659021;
        Sat, 04 Apr 2026 01:17:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:1587:b0:39b:fbb2:5e46 with SMTP id adf61e73a8af0-39f2f0968d0mr6019707637.40.1775290658531;
        Sat, 04 Apr 2026 01:17:38 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm6786408a12.24.2026.04.04.01.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:17:38 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 04 Apr 2026 13:47:20 +0530
Subject: [PATCH v4 3/3] PCI: qcom: Program T_POWER_ON
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-t_power_on_fux-v4-3-2891391177f4@oss.qualcomm.com>
References: <20260404-t_power_on_fux-v4-0-2891391177f4@oss.qualcomm.com>
In-Reply-To: <20260404-t_power_on_fux-v4-0-2891391177f4@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775290642; l=2508;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=eLlhRSUUKQzMD4xw0eb0Pj6hBFVgOdEaGYz5rmdOD0w=;
 b=FoSqAxwrZC+d2vwgX0vXTnnO4tPPZUWaJ/+SnJjtKhp10P54ksl61uq7Bio4H4ZaPODY184qU
 uXcFi/zk+gtBjD3aKb7GyEFrr9nbEPEMfcr8roD85aBqaFVuZML5aIg
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=ari/yCZV c=1 sm=1 tr=0 ts=69d0c924 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wXczfBY3881IDOTkNB0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: UqZnf952IXLo4HqTNgr7X3J7zrYbW2Cz
X-Proofpoint-GUID: UqZnf952IXLo4HqTNgr7X3J7zrYbW2Cz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA3MiBTYWx0ZWRfXynaIHlhzdAKe
 8fenJAZYeI1fy8B5EV5s1V8W9h4+7fHKAoCEC86zk8eXbWraLri9witK8NQ3/Za7czL34Y6siGf
 vhd/0kSSmzGVWm1z7o1s29TzaPsgpP0HxJjAmz2/UhCdJXPbTk1edgH0n5/QA3C2p5bTi7yGNTM
 fuwxzPkT1pd4TE/Esuf74aK1hrFMJc89Y2mv44uTxrTfibILUId0ofiAFmXuSvHpltdfi06BdmF
 KbG9KRaOmWuhwmedbGjhmOuzOO9bzD/VyqTxlY4oolThLAf228iLp/ox96pCzTQz/4Vk0q2r/oo
 qMSi47QQ7ZoYxFQx77huy10e/fFWaBUpCD2xTZDWJZobCiqQsXYu54cqKaIjD9+FZE1BacicYPI
 AkANNPxMjRSNnmDcnoXm5Cbo1PJpOGg0B+6QmCGZcgWulCL6lnv+m+5ci5aF10kAJNprg5k+2KB
 k2+pEYbpmJj7xbxVXFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040072

Some platforms have incorrect T_POWER_ON value programmed in hardware.
Generally these will be corrected by bootloaders, but not all targets
support bootloaders to program correct values due to that
LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
can result in improper L1.2 exit behavior and if AER happens to be
supported and enabled, the error may be *reported* via AER.

Parse "t-power-on-us" property from each root port node and program them
as part of host initialization using dw_pcie_program_t_power_on() before
link training.

This property in added to the dtschema here[1].

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Link[1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
---
 drivers/pci/controller/dwc/pcie-qcom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 67a16af69ddc75fca1b123e70715e692a91a9135..a8f82f860c08fe2eabad2c0eed541b8dd121215e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -269,6 +269,7 @@ struct qcom_pcie_perst {
 struct qcom_pcie_port {
 	struct list_head list;
 	struct phy *phy;
+	u32 l1ss_t_power_on;
 	struct list_head perst;
 };
 
@@ -1283,6 +1284,14 @@ static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port;
+
+	list_for_each_entry(port, &pcie->ports, list)
+		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1317,6 +1326,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
 	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
 
+	qcom_pcie_configure_ports(pcie);
+
 	qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
@@ -1759,6 +1770,9 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
+	/* TODO: Need to move to dwc once multi root port support is added.  */
+	of_property_read_u32(node, "t-power-on-us", &port->l1ss_t_power_on);
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);

-- 
2.34.1

