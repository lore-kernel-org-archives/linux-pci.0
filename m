Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316209;
	b=Yt68W6WJmyyRNMd9eLHFjiV6MQZlJiP5f8vfj0hIAluMH9o1lcwFBFvktGpWThouiIRH
	 nUf8pz4Ec4AIjdU3iLzJswE7w3VaPZgiz4TdJYOKEkUat102bXzNoSmqj9FC8+PoTyNXn
	 2PRUPaj6p7nA7IlxUUu989kqAIxx8Sc2AhTjj8oJJ2b9i4I+MDGWg34ai00E1urkK9oEk
	 iRAAckduBX35qMrRbhhi5jEvzOnEw6HCG3P27SvSUCNud4qTtEErVHuQSguvwkjnFwr9g
	 RNmJtYt/VZDRfD0SNKOuwaaZ2hHftKXXhGRIqhUEmvrVt5kpHj6Vyi85y0yRNiO/40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316209;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1clNjBa8Zrj0xBBvYuEZ7pZMKBdACxhX6qQy1sXV/YA=;
	b=hKcR1BFX3ljUyTnEtvpJ86tKMo8jbEeI53LCnHgjEQyPGwAp5jmOHoQdgH/FrEu+YQ1c
	 MOfhWSsWjaOBwu21ypKyLtLFksc+Vgx40Gb9qedBo9KxbzIl7MITl8mK0dyTfE48Zb134
	 S/Ikk8TqMD47q3+QPHXluaAEeD+VBiAWferjiZO4eZNVkI8CW99k8VSzuJnecsHDRW24e
	 n+cGQDUZ/L0U+JZXOSpVJsNHhgUp4gAZeBsbw3AjDcvdLhEtbRY6XPjK7hYTk9N7tl+/V
	 y9LBlk4s252bnUeZOdbfE8LVGNjgufdbYV4wXH4ZGMKj5GHUKxFfhCkoG4CkH6U8kDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QAQ3Ynh9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SOavA6NM;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1E606A32A
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E1E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QAQ3Ynh9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SOavA6NM
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM1rJuC2220081
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1clNjBa8Zrj0xBBvYuEZ7pZMKBdACxhX6qQy1sXV/YA=; b=QAQ3Ynh9suMLRRUw
	6CDW4cxFy91GGPGeuB7l3KRUkrtuW+FaEc2t5yxjo++y8DamGXFCVVb+C3htk1gx
	KM45X34DvG9ejTgP7KcKYBumpnUPiGvH+6Xa6FdQpsMmsGkACnCoYgIUEJ7i1NFr
	Bo/EvNmKyOGWTP/14K3tO7OBOoHti+bKhHHoHFjviW70xZzFE10NyYqJAWbaCMH5
	GRMOggSCd6AXnwx0F00Nd5kHWscFTZA7xSPDDTvmo02l3u6CZhULB8MnmSjnhWg2
	SMCqSf4VH66SrFDwB0C8zESSCSHmyid4LoEgWM9Ee9iZNs4lzN2kHzJK/n7aI+z+
	LqaCtA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33cu2j44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-38531c1a566so5772245eec.1
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 18:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795316206; x=1795921006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1clNjBa8Zrj0xBBvYuEZ7pZMKBdACxhX6qQy1sXV/YA=;
        b=SOavA6NMx+TaptkMJP7CHmg2g3F2bL72vNrmybw+gZZ2b4ZnQOQVvoqwPt8uZRr6Yp
         108ewQ2I04kq9kSSwD4TivvV2+F3+KqbD2H3yaLQJlaASQqSOTdiabqcgcwephJBil0D
         LE5NbGmwlunV3vo7Yh1n0PMpX1q8UprlFvxn7x5v/Pkad9ZW77oABTfqeVKbf3t/w7jg
         r1MYv2UECXlIq/ODiJT/7kcFmZTy0KN9opTbZvTgzjdSutvjbJBuhO8C1ozK3foy1LUR
         15mE18XlkiGyZxRRMyefWvHx+38MCJCtGihjZQngJns36I7RjKaL+4cxeciBixngaPlC
         HyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316206; x=1795921006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1clNjBa8Zrj0xBBvYuEZ7pZMKBdACxhX6qQy1sXV/YA=;
        b=ihgBFWegLXHgcShaMRTPYdOBZScO3EIoQeLjMccGOWC7AV32tgmaCDUQjJfUvYSFVW
         SuVMHoDYUl/nUl//VOzihXt5PjFepmcRs5XLP6L026EnVY9sTBYsDQNcpBx7+768TdBJ
         +5Cz6P/FZZHEG+fPJl4oUNm3pyhNgTFZDQYuP9R2q+v3KzBs5DPdkdyOhrYMqYo6JInx
         DrM0eiQun6FzKF3fbvZn6smKJrMnddg5hkxOEOaCHD3ydzNYhMF2tIDQJbKDv/Gq+oEQ
         rncnAINoRg8nPrfhGi7IVHz5Ulheg8RVJgWV3LGbWoCF4rjeZPxfohTZwibYhpTef/lo
         E8eA==
X-Forwarded-Encrypted: i=1; AL+hErGx9WTFM6LQYRs+mafeHmd2GsnXuDcyCsBYI7S9Ucof6Z2xWxTvz7rN2tgFd9FdnLQ1oKrRCl2XCVc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZC26ikffO3F8mAlLW3SMeg8Mg0pTnOz0XSiIExpvkdMWZi/KF
	XAi0CP8BBN/5mNSH87jwbamE/nbEmuQzkL13Ol4JbyGm76eIR64muTBFxJFQqsKy2UYHhPaN7Zw
	+iw13sRQ29ChfSQgmGdHNAVPwg9XjXqr41nQyw/LYNLxkeqRs6jPraZPmwheGUqY=
X-Gm-Gg: AZFdTZcNPt2yusGgZvdnpYHhKXjESiHUn3XMJ5WOyIN2EAWLNZrL9/j/Q0+CnbLUzyS
	CMh3Ch9acfMHL9h1ADOaqkNIf5xDZMGurPc5wy2HEPAYwF56ZlW/ssGL8of4161YZx+YjeCS0eQ
	xKMHXORpxp4iNd1SDcKeECePF0omYcLyG3Qd9zaTGCRzj18508iSfmL1HxMEW48bcMN1bjEeYPt
	O45p8oBa9taOhHnWzWdD/Tp2w0tA1sz1VJEcai45Pm3eG9cm8tuQQTkCc+aIraeajjVDSvQCcu3
	EqEpWX6nfVwofCCtSVXMUjh+7IN4FE6XdOnTSNkPWmwYmUGpMNvOpfHJRcUh3LVBZowWPk6Hayv
	FWurjhfgQ5dIsnRPyR8q133A5vEzu4WIRl/xlJBZeiiu+IuapTrQBaLvvOq8W7s+yGLa1IAYDYy
	7PjLxbqoAW
X-Received: by 2002:a05:7300:50e9:b0:386:9a77:b390 with SMTP id 5a478bee46e88-3869a77c55bmr4571694eec.12.1795316205964;
        Sat, 21 Nov 2026 18:56:45 -0800 (PST)
X-Received: by 2002:a05:7300:50e9:b0:386:9a77:b390 with SMTP id 5a478bee46e88-3869a77c55bmr4571671eec.12.1795316205494;
        Sat, 21 Nov 2026 18:56:45 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm312044eec.18.2026.11.21.18.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:56:44 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 08:26:15 +0530
Subject: [PATCH 02/11] PCI: qcom-ep: Add MSI-X support
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
Message-Id: <20261122-nord_ep-v1-2-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
In-Reply-To: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Anvita T <anvita.t@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795316183; l=2569;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=mps0dQPLSI1oXXnodqvs4lyheOQWjr7tO9t5zayQPrc=;
 b=MWK9vdASLE0qflk/gtdRDSZdWQXZFXtbdL9B1Q8QY3V+hGuk3FWi/Rrs489ZWn45aX7b+aoCW
 L19aKtF4695AxOdfTdqcsrkRHJ5v3R8Rts4pFIJ8JWUFHK+SGyTZEKU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: qFwYOb6Y7qYrFxPs3dh7i7jsftWUHztN
X-Proofpoint-ORIG-GUID: qFwYOb6Y7qYrFxPs3dh7i7jsftWUHztN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfXzIlTTMD/jRz6
 tPCnxgyh5+MuBlgDwo1HZm+MdBIM1/Ps0ECNXks82RJOJFCdMqnx8m8AUbf3bd0xqcohin49Rl2
 +VbKWSNdu6NUdDRxs9gsY3dXnttSbdSvwXCA83rDRZSnccee11+JQU3o6V7/XRrhndX6ryeQwoA
 u9XcHiu49oM4ki2CMfQQ0JE5AEpolARmWToNWD7YVNpMmNGkKLRG10y03YC81sQlcxveLXVtCKw
 wThj/f2xD98LDSFosIRwHwLCiLTNqSxwStFSvQxD61hh4qICk62eyKG7ldIaxrxoNcjGFiZexbx
 83PZTkGBzayqkxtrEhZPwtgzIQXGezmqIufjubjP1cUFnBjIa+7AQnxkuflwvtS1ZHcBrp46Rt2
 NMt3l38h0qTlvIwoqc0yfKyRkL0DKn+tQBrWOM8EApX1Jdinm/bdIHiyKwhrMgsBEyNuMNHj0+c
 ib3CxrFtwtpZmNL8BSQ==
X-Authority-Analysis: v=2.4 cv=MM71C8Zl c=1 sm=1 tr=0 ts=6b0259ee cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EKRowzD1bsybSWocKwUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX/W7HR9FnlXHS
 8yc3E2kGWWAp4Ur2NXlFoazqCt7ygJ8fTrtddAcBubXkiMbrDl6y6/Ayhwm0A7tEv7mT1KJdKOh
 mG/W/XMH7AmbWKLzbQI5PwFo9oQ0Cn4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220011

From: Anvita T <anvita.t@oss.qualcomm.com>

The controller can signal interrupts using MSI-X in addition to MSI.
Add an epc_features variant that advertises msix_capable and select it
from ->get_features() for SoC configs that set the new msix_capable
flag. Route PCI_IRQ_MSIX requests in ->raise_irq() to
dw_pcie_ep_raise_msix_irq_doorbell().

No functional change for existing SoCs, which leave msix_capable unset.

Signed-off-by: Anvita T <anvita.t@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2d7ddf8d173f..c794a2207df2 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -170,12 +170,14 @@ enum qcom_pcie_ep_link_status {
  * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
  * @disable_mhi_ram_parity_check: Disable MHI RAM data parity error check
  * @firmware_managed: Set if the controller is firmware managed
+ * @msix_capable: Set if the controller supports MSI-X
  */
 struct qcom_pcie_ep_cfg {
 	bool hdma_support;
 	bool override_no_snoop;
 	bool disable_mhi_ram_parity_check;
 	bool firmware_managed;
+	bool msix_capable;
 };
 
 /**
@@ -806,6 +808,8 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return dw_pcie_ep_raise_intx_irq(ep, func_no);
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	case PCI_IRQ_MSIX:
+		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "Unknown IRQ type\n");
 		return -EINVAL;
@@ -852,9 +856,25 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.bar[BAR_2] = { .only_64bit = true, },
 };
 
+static const struct pci_epc_features qcom_pcie_epc_features_msix = {
+	DWC_EPC_COMMON_FEATURES,
+	.linkup_notifier = true,
+	.msi_capable = true,
+	.msix_capable = true,
+	.align = SZ_4K,
+	.bar[BAR_0] = { .only_64bit = true, },
+	.bar[BAR_2] = { .only_64bit = true, },
+};
+
 static const struct pci_epc_features *
 qcom_pcie_epc_get_features(struct dw_pcie_ep *pci_ep)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_ep(pci_ep);
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+
+	if (pcie_ep->cfg && pcie_ep->cfg->msix_capable)
+		return &qcom_pcie_epc_features_msix;
+
 	return &qcom_pcie_epc_features;
 }
 

-- 
2.34.1

