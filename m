Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A1397321
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307225; cv=none; b=Ql2yLdZ3NUvHppuzHBFfZIhmwInYzFRr+LsGCVAUID4hPRDHHgqjFpczAHy4I3Jq5TIhH4tZARCwOEQimmfDVm9AzukDxDTQou/OdeKWvYUfvgcO7CNgjgixmHwEnA3Wo/D7J6gH7urzvFERXUVzWA0rEYAwTj4HHHmCGqYtGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307225; c=relaxed/simple;
	bh=h4yLRvqGyQTl6OR0GngMd/YRroUj4EhJo0XPHba7d0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUXBWfXe7fDHHwLesRGSvQlSb7cfH4APYC1k6EEf/pU6kmChRYJCWQzQERa/ZElYg+EXRPG9B+r4G4TtbMHvsL4Iyo5/Zs/ogMwMfwxrQwhE3S7vFasNhV4PZU8NqSnDzeHErxddkTLM3fCpWXU7Fc1b61nYAsH9kAjh0gvIC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DbacN/i3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YGi8AQME; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DbacN/i3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YGi8AQME"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6517TA4j086275
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 09:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=; b=DbacN/i32nHCv76p
	CcTtvGE5WRiPZvdQsMnzBqqyBcIes7Y785awJiz/7bkY1JRbZByFoGS9X/NaCkeD
	RDarenEiOYz+t0oIZ1eohicKGtRHTA62Wp0FfS8UlRLwoAWSIBLATFDS2EmABKyy
	5Qys48JivQRqIDKHh3gVhYByFbkAeqV3VMVc5rcmQQUch4ox/MQuloM98rRbguKv
	eBgkwKe21gm1mN0scSh7gLCfOhz1znqCIxi8UilJyeUgLdkz+0GPR+tudehQjv+x
	ZoiO8eVQghC0E+pcBIAJHp6D73GN6vSViYchXXJhI8PG2jcQjhobQVV1MKj7GZtN
	EVuBkw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyuxyxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:46:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51758177935so17447761cf.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307216; x=1780912016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=;
        b=YGi8AQMEOe12uqwKC6ocED5Ofd9Eqim4Pxei+/i4cUIZbWKf+JuFR1i0gnFP6+kJzA
         zGoRqMYUcUgFO+WucTO5exQajLNlyN1IhE1AgEw4B8qthSHA661ixcQ8lnZiXUI9xvDe
         43J3vWAA77mwfm3ws+218FFYbI2/3+OCrjueanuXbZ4riNTtMgtdd43BA7c6LEMfqY/k
         4Vg+knnXYLq5aLgipb/TYAlNNtzINYGtcB6ZhrV8Oe0l8aDHLgvOISnwn3jTI/v5bDQG
         wTWQHKC/18zLBUvUjEbJ59ZtN/yuw03iUIoBqYVs1+Ok53V+fjNz5VOxetATPcTcghqx
         l6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307216; x=1780912016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=;
        b=W42nhPFp1zMy8C8R/aKKxIMT1L1wctAlwpaPDbJMAWHOmjtEXFLdfLHaaMoooowNrC
         mxbFsRI0bF+3jEwlHScvCStSDgX29MpgUASCmxV+++OS63xoYLie5+M64AuXTkRoGR1P
         qf6PYYFa6Zh1h4u76431iJOiMPXEKM1fBlD0k1AfCWotTGPVMFmUIQSJ6BCIImjclBS7
         VPq1bKduAzRIFv4hoYjICZBYfi7Ku5lmTpExtuerEpG9zSIsWJ6WwVppOIwtaj/SL63n
         fAi8fnhWDWkl4NQc/7g/niMgngdECGiFlWBJ/+I5D0pI86HQT3LNh9/09M1F7ff3POvs
         8vdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+20J5JMPVF+Yh1bano/1Vb5WzdSGuBNZISW2r0HXMWeynbinvI/udOoes6M86qXkQDtIWxHal9CWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAWHKV/c2Bb6cE49nhqHAoz3B1Ovut2drcai1UnzkaVBwn+tC
	8RakMwZVcnBu2e6ONUpjzpz58V2FUrIZieULUG4WZ0eql6LUk35ev9/GTnYpTJFQW5NODesb8Cn
	c66A+caGh7lwE8SHrdBhQRKyPXxMFnkQkvfHBtGoi0ERsKWswmH5Vt3EhgZ4+P4M=
X-Gm-Gg: Acq92OGY9BpmpnNLsZokX+VAnb9thIioWSwGCTTJADxrtFSdWiwghfA5tJMljnhU1l3
	qzvzhporJ4IijM2m3QPGQ5Ikci5RKRqm77KeXTizoHRRr+15xRUUdKQkqABVc7GEHShnzqGLbi3
	0sLZgAyVWIkJNRvlmQiY5CKcWinMz40/ZGpOVkhTkCpHP7EstxhVPyI7uWOlGDlNTVdKTVwqWvJ
	JJkj7ZDzSqNsTT6H8LRlD8AgBYxFuBiT0RgBcX9qwK0Q19YeAGAkTUNHUiYf0dqq09zGkqNQyNS
	HkQTVvbm0mpnXBtlU59/7mxiqfzjC2kT3sHePZRnkeWHnTAr1gmlAue3OGmH+CD/9gCpSxtfMSh
	oAcbod1Ouhe4wz7acww0VmpdJ3eF+r4ZH7KEt5sjYaW49QKL6QKUhlpDcmReQOOnAurNYUv9TPA
	qoPTTGhbIQmbblLLVTEpa60Jbuxe9FqBuZOG0wk/3ld0fehg==
X-Received: by 2002:a05:622a:8d09:b0:516:d678:5337 with SMTP id d75a77b69052e-5173a821e2bmr134236501cf.28.1780307216114;
        Mon, 01 Jun 2026 02:46:56 -0700 (PDT)
X-Received: by 2002:a05:622a:8d09:b0:516:d678:5337 with SMTP id d75a77b69052e-5173a821e2bmr134236281cf.28.1780307215680;
        Mon, 01 Jun 2026 02:46:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:46:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:49 +0300
Subject: [PATCH 1/7] PCI: qcom: fix parsing of PERST# in the legacy case
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-1-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=h4yLRvqGyQTl6OR0GngMd/YRroUj4EhJo0XPHba7d0Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVUKNC5BVKIlAxG4zUjN1XbSLdxsoCvWpGVK0
 0z1FLVXEJSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCgAKCRCLPIo+Aiko
 1W2gB/9Lau9+SFtTwoD1zoNdYwiTI7GJ0lR+ax0a5pUBEy7TmQ0zNhZbFGW7c9a4fX+LSd+hFwh
 8CQaB+kBl00XV7DyiCrsIx+EEJCh+n5cAepVIzn5Bm04TGrvR23SQfvZMtM61bSLX8Vi6LRO2Nd
 pnTfPqkPaeTKKJgXg3niJAfs42itlwqbsRppDov4fZBOuV//WQ4Dx+YJlORsNBNZVgo0aeOB7U2
 hpmAgna2xqgW15xKGR1B6dJpRFQI8fbO9Ptccp15mmy8Ymgyb823NdcqqCaFPx+zM0XYUrJRPvi
 TFwJfZyqnkXRSiofCiNz4Ho3rsc6VC/Ysc0ymEXwjTgxuwmR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX8ccXQTLrCGFG
 FpPEb7jKdDZplmXo1Y5DJyUckg+4ayqDe259r+YI0Qwg8S2mTI8xQRkIz5WXX721RKZdA7wV8LR
 HNMgwirYVxMxR9qQlfvEQnIEH2IPjBMO/uCTsPweN4/5L4j95WIPd+XIbOjbcFW46GcoCuqcSU2
 tNOC1VGXUNaJAF1uwGkuoInsQ82lTnKwvaNItuyt2k9aZ8Zi0/Ye4YtFY/lfJ8zrd143Ia4RkTu
 xSIvLYUTXMFUK08sEa/LyvNkJhj37h773co/C5z0P9tKYmRAXAnPHNFK9jMxA1LjEGvgyKml/ES
 NRDsUIBEtMZJXQcMlCjiY4AUORz4+E4sviyDBq5qHhcbU+u9p1tI3E71QgovgoCtGn8eIa+azv9
 k0BCC6nsXOs6Yog3mw8fQWO7RpgHvzvMJrSdILqd+mXk+z0Ak3VbwVweBkNCRhAMKi0MX7Wj3sr
 PoJcqXxyBrHq2/CZmnA==
X-Proofpoint-ORIG-GUID: ZTfyu1PvBAjE_Gp0Jee2zS7Toq3KeZKz
X-Proofpoint-GUID: ZTfyu1PvBAjE_Gp0Jee2zS7Toq3KeZKz
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1d5510 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=A_p6hzaB3oH8elZwPmwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098

Commit deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT
configuration") fixed support for the "mixed" platforms which declare
PERST# pin the RC node and the PHY in the RP node, however it also broke
support for a majority of existing platforms, which declare both PERST#
and PHY in the RC node, because now PERST# is first acquired in
qcom_pcie_parse_ports(), which then returns -ENODEV (as there are no
PHYs in the RP nodes). Later qcom_pcie_parse_legacy_binding() tries to
acquire the PERST# GPIO again and fails with -EBUSY (as the GPIO has
already been requested).

Move parsing of RC's perst-gpios to qcom_pcie_probe(), making it obvious
that it's shared for both cases and skip parsing it in both functions.

Fixes: deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT configuration")
Closes: https://lore.kernel.org/r/gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11fc60489892..7664c7c28c0e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1907,15 +1907,6 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	int ret = -ENODEV;
 
-	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
-		pcie->reset = devm_gpiod_get_optional(dev, "perst",
-						      GPIOD_OUT_HIGH);
-		if (IS_ERR(pcie->reset))
-			return PTR_ERR(pcie->reset);
-
-		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
-	}
-
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		if (!of_node_is_type(of_port, "pci"))
 			continue;
@@ -1942,7 +1933,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
-	struct gpio_desc *reset;
 	struct phy *phy;
 	int ret;
 
@@ -1950,10 +1940,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(reset))
-		return PTR_ERR(reset);
-
 	ret = phy_init(phy);
 	if (ret)
 		return ret;
@@ -1970,7 +1956,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
 
-	perst->desc = reset;
+	perst->desc = pcie->reset;
 	INIT_LIST_HEAD(&port->perst);
 	INIT_LIST_HEAD(&perst->list);
 	list_add_tail(&perst->list, &port->perst);
@@ -2107,6 +2093,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pp->ops = &qcom_pcie_dw_ops;
 
+	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
+		pcie->reset = devm_gpiod_get_optional(dev, "perst",
+						      GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->reset))
+			return PTR_ERR(pcie->reset);
+
+		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be updated!\n");
+	}
+
 	ret = qcom_pcie_parse_ports(pcie);
 	if (ret) {
 		if (ret != -ENODEV) {

-- 
2.47.3

