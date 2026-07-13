Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626F390CB5
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928584; cv=none; b=ACTl4UCp19icpMtln6tn8w9ZxdDODIjT7ykRJXi6BPeZoxUCAiN4LjcU9Ze/p/GEpo7x0YQTgEDUhhrom7e/bBvUh1Iv/5lWBMsCMDi3no3uPqod53UwDXcSFR5rfc4Sa6tN3I/T8+zxF7jR13M+AqWc4l3s6zBi1SqH3U6fSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928584; c=relaxed/simple;
	bh=KGHvR2+JEE8fe51pL4GYOFt+Id/vPIyh/xzYWv60Bh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fi2bcCibx0vRoar9DJj4nnPX+oXAC4ZA9UxGwzhXhf3P1A7y4XNPbFJn6eemFb/NAQbChylu8ClMJdHIv6/H7cWx1V9ufy6fvK/paYCk/Yx71oGzoZuqSsAu25VCjFIbfX27o/tMWhS1MEajldKZeebE49vLBVlCsxobM35Dq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1HExbe2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FsNNPdVW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1HExbe2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FsNNPdVW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6O08B674533
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MbgEqLMqAoeF/SF20KCGOOd7+BYZvWxnSyKnE5SbO3k=; b=I1HExbe2oI6F4tjZ
	yA/YVR2bi71XOqGawPGg2yFEHsImC0o4amhihZehMxPrKiCihtConvCuOV4Vfx4+
	udxB+fIS4J9ZQxIcMBluXf7Kr0sbvmENI/puBFi3PvGVjyzyuu6XlyENRQX6OjlP
	UH8VSqZxgakBC3GSitcA0PELwY/URTr8cMzdFdzRTppJR2kZWG5ytyt60744Y7tu
	Z7rvIeJOq6UGh//b+O3AtrLjEBG0zpXAiV6UuX3MSwdPlk6Sy4/8IfEcTMhmYZPB
	ibzAu0RcPfb06tNZ/PpQFjGVfDv21pW7NnXgLptBmM/KeBvA9CiktZAS7Q6VdE7v
	uD91Dg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgn1v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so4506438a12.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928581; x=1784533381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbgEqLMqAoeF/SF20KCGOOd7+BYZvWxnSyKnE5SbO3k=;
        b=FsNNPdVWTyqwLsDcp40QFeXiwlTlGiLvjJSXFvGD+sNW/S2aKqz4lGCPl1fOVGcbrV
         azb0Qx2Wx7MdDzJq5h6C0lokf0B1DZ/AxQFHzIDSqmCXaRmD8WLeRd6pTgVlOS7U6+/b
         O3sm8CQ6wUSMTbjMslJXScRjEUXu1/sg0CnPwnQX/9FKCwmdmnoxkol9UlyhHV6ddTwg
         jhUm8UnmZ0hvyKjyGYbDwo/EcDiG2M5UlEkBW1NY8iipaCViO+MHcBi9hzuvGV3T0oJs
         5OKEwkSZCSHUA/CUKVM77u8qn1LmYUNqXCZIjAD30Ggl3m+e7Tc6Iz/DqZu4+6TCg16A
         Zjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928581; x=1784533381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbgEqLMqAoeF/SF20KCGOOd7+BYZvWxnSyKnE5SbO3k=;
        b=jxqvcUdpUTlpttWB7C+o2MO4zAu1G4fV9FKGd6P3niuCs/MR3MroZQMYpoSC8yIxJM
         VRG1qWAjAAGOyDQQxge9x1PTHrLOve7GGbFmOffNDO4Sw5OK3xdrRiUYwDyiDiVbUKk5
         fkj7ZvFuNtaCSjI9F/zyNfgOs2H88hGehYED4QDea/fpT1vXiH1RNzb3gbSpus2wwJ85
         CoLmAfXCiyvfsyRZJE+jR7fVcUXfigvoWVm0p2VexFium1dJuuGkekdF43lxuHXaE25+
         QpYjCbO8ClNMl6fyNQoUmmoTuF65tPqzE9foO/olwPfnrlgVegz4kxIpM2MiJrt5x1OD
         EiDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRK3HkY24RgE8RpRXR37hyYtPcx6bnwUPHIFxlVLh+vKcjO5CQ1G0K22wjUWXFXdicHtBefoY0fbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0GYxPvRHz5bD0kp16spSH5bij6YmfeDPyckr8yKCxLFhy7xO
	dhID8K0fnXXMS9gogrEfpP3tUcSB4SUOd3qiBPm9WwMioRLUOTSeUeyLjSg4E8sD+fe9naMXiti
	nlaIzp03IGEfBnArTIld+rrmz8t1kDjNnDRC20hU9Ex3LCbjCwxju0zdrDcpSFiU=
X-Gm-Gg: AfdE7ckamTqa3OTJ45JLxqvKQbhqlVTmHxQBtiEoPmVgkvCZrjHliO4bbZPjkuWSfPX
	Xqh9hC0I3E8jvQkVTLOM/UVeZlF5U+A1jK7Nk3MYV823obEXPsWmW48PvlVsFp/RliXCqbFH9uu
	y2mcMpxAb2asjRVL8QjHr19iqxMI1RvMWUZ2wP1bTVlsdj9uo4UHZTTqasxYHYPxm+m11RghBZ6
	KAG1jtAlY2V5O7dzZQPiTJT3da9cWtAtBYTnDq4D5jtu6NVYRXNB6TpdGvhFdYoc/cqx0mlz6yj
	xZdBYI9AqHytvjoSLnJ+soCY5JPs/fzJwrfiBoY07q+Py9ElUwIKeAolErwLsXrPPmWmxcpqynY
	CLQpjV4OU+irWxuj1+c44F7LIlKGWMIS5elO0Fy+abGxcCy/m3mzJLfDQjg==
X-Received: by 2002:a05:6a21:6497:b0:3bf:64cd:c45e with SMTP id adf61e73a8af0-3c11076511dmr8953115637.4.1783928580675;
        Mon, 13 Jul 2026 00:43:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:6497:b0:3bf:64cd:c45e with SMTP id adf61e73a8af0-3c11076511dmr8953087637.4.1783928580257;
        Mon, 13 Jul 2026 00:43:00 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm61329797c88.13.2026.07.13.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:42:59 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 00:42:50 -0700
Subject: [PATCH v2 1/2] PCI: qcom: Rename qcom_pcie_set_slot_nccs() to
 qcom_pcie_set_slot_cap()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-clear_abp_0713-v2-1-4f0333a98d4e@oss.qualcomm.com>
References: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
In-Reply-To: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783928578; l=2114;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=KGHvR2+JEE8fe51pL4GYOFt+Id/vPIyh/xzYWv60Bh4=;
 b=i5qguIzH2Ol9/nNf4c3t73N3AmgQyAC4822HCYx3Nt5goQl/HCe8AhbzBCfNgB2EDbEIJkFR3
 +7NUGW9l5+pATXjiv9e1t39R0QJxvAbBfPtOnQQ+k+GF57u8/php4Mx
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfX5hEr/ABJsrNB
 wlh3WEH1MDGVnu1X05DVIDVDDKNIa/Zvmi+PH0+H0buM8O80ioQ9qiF2mHxjla2rSHKkXhtY8DC
 oLO9R8ICS0Lh9dzVzuWtJNgzNBpp774=
X-Proofpoint-ORIG-GUID: E48mj3PI5QTwsiV4Bk4K_1NNXi8wAmTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfXx6ZWk10qcFRu
 MV6zyY9z8GdUCV+cRP2O7HcNVATsVKKSIIEsB51dbj8aPPsPcb2f7AM3svc3dbLj5ecvj2csJA7
 FEQn6KLXbBtj5mu2U+ziDNyY4FUryhuKrc54OlJ2czIt4PfpFNQ7UTgoVe+gW0VQs9WhZipZZ9u
 3XL2ObGW2Wj9ai/TPuLBa4kuC+qagfNDXCEi/YC4VHGrdi8fKST//FiORj0W9T6W/7tQloOqPWM
 FI7Vg7e0gryhcUolBnLvd7nqUvpYD6Rzsz925/rmkUG7I1NZjawMA9B3+4hFuWprsnMHfO6Sl9n
 M9d8vmz80L2ZaL7V7DYoLsY2OqCX6uwTv7/D3l2p+hG3+kVO8qVPrqTc4pKzdpZQoR68p/qNzZ8
 GtOWSQvUqva3Gm+cis20IpAwSMLWPIo8dj8CfeMcDV89hu2mPjUo+5179YxzJDieO4+ztrAqy+u
 dNgWDWgEyMneNRkO1YA==
X-Proofpoint-GUID: E48mj3PI5QTwsiV4Bk4K_1NNXi8wAmTR
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a549705 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UWWLHM8_V65xiIckHG4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130079

qcom_pcie_set_slot_nccs() currently only sets the NCCS field in the Slot
Capabilities register. A following patch adds programming of another
field in the same register, so rename the function to
qcom_pcie_set_slot_cap() to reflect that it configures Slot Capabilities
as a whole, not just NCCS.

No functional change intended.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b193c989b2b8..465c940109a7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -358,7 +358,7 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
+static void qcom_pcie_set_slot_cap(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
@@ -580,7 +580,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }
@@ -660,7 +660,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }
@@ -759,7 +759,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }
@@ -1078,7 +1078,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }

-- 
2.34.1

