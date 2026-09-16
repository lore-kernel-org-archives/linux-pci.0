Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81D3E0C68
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538674; cv=none; b=SFtERlyUVccxiu1JWZ2o5WMJqxkMItS4NILQYITMIQaQgDtbGuiVrxphcydJIq4BujE12SUzezRFAkb3L6aXJgA1vfk83vIcztK63Bbe8+QPyqKIrvAaxEmkQrNDWLmumNdCT8nIPhIOT/CHz8pVIU4sz0suG0rXTMjJCkQL8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538674; c=relaxed/simple;
	bh=h3fngNlkhZEZKpBHI/IT3xTrpcNvbLpoMF3Il2nEqag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmNMh7S2HjAbUF70EbewNlH8P9yCnlPtbz8BVE0Lh/lFDBXhKLk85sGQ7t34tWnuxXpPv0/03Upf3CZBUEy0I+yfVHJKN6EFiLS0BxO+cOlA7BaQ6jxRCMvy5vp0jmRgov32+Z/S0fsuFeu5rGMlWJ13CbTQtBqm9ql8XFSXR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DrPI/RNF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qv2JPx92; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrPI/RNF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qv2JPx92"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G5q5fa079873
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0r6Emu7FRLhYCASNs/iFipri1GH8rilRHLo7RAxtZ8=; b=DrPI/RNFoz8blFdr
	n+qVvkqsS1VYEh86yIzRsJZN7puOVoylwY4abKOPUmLPKa9CU6MbVFp5ahT7yHZ0
	lhQoGgixHkqImskYdGE/boQbKB55ptXnX/YOlAjl+LIaY+HvdVBm35M7Q1Lel3OS
	GQweCfxlvt1JXobZKX21VO8bYceanAx4VuJVkwqtYiA3mtk5LqoMOfU6HRkSeO00
	rhR659cNQ4hZHaFvjfnt0j1e3BcRApaECoGDlY9C/YS/9M9jaPZYW6SnhI5Unx9O
	MCduoo3xrgpWs60zN7Hhfa2F3/ByPaSAm/neVHrXnn1KAmmKf2kBo4UShrWxrehq
	GBRR3A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqagejmt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:04:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd8920c132so14509325ad.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789538668; x=1790143468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0r6Emu7FRLhYCASNs/iFipri1GH8rilRHLo7RAxtZ8=;
        b=Qv2JPx927GHtFD35BwvB3NpI3zpvrxi50dQTF4PT7F2Mm7jg/d9BkKsonEZHtElrnX
         cBf1xrFuG65uDdMA9gmrE1cseTGVbuPwDFQVFp1huweMvh6M8hICewawdE0mx48qkK54
         ZcaFfXDTLAJXmewfq3xjt6JVC+y0JlHyIubO1MP0x+pO8ql0lEGhkSd2+dCpBZDzMZDD
         8EJwlU+WXuJ3LRg6Wrso+YYN7zIGumjdAn0msyCZoPMC9aBXBtN7rkUa+AcJu04leGjA
         gDu6kdg3MMQKGZCzOxLCseZiRfBFTF066NLANr7HwzI8OgUyexPm2neMfbBTINBUpBEw
         qVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538668; x=1790143468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n0r6Emu7FRLhYCASNs/iFipri1GH8rilRHLo7RAxtZ8=;
        b=Cj0qh3tkqjl75ZEfSWv+Dj2YbAJlauJF0OwbQRQwMypui/DMCiUSqdKwT0Qclq22sQ
         MQ7NrBPayiEM2lujp1SU3KI2zTOpIi+GQ13/9XcoeySrIt92KZJaGsW+un4PMXxOnQ/n
         4+ooYyyPYTko8xXRoiwBE4iLj001/3FdfJ+NjiEc/FMGZRPYyrOXLV1mBV+Oy66O4WTA
         hClBuHvrW6kmpSjVuIRrpByx8KhiuCxmpIL6FeNrH4fJM1PMXI9TC4U4C4Yq2zmCT+bV
         Tt6g9/nvPAkJmTPoFhmLVKY3/jUIgU7TJzqwAwTKOf1X/QK4OY1skiNFR7wy/kcx8u++
         r3Ag==
X-Forwarded-Encrypted: i=1; AKwUvByoBUIgm0VNoo4PaGf6R7aE4OGAyDQYzimGo2YF4AkxxIP5Ecn9wsnQBEIJdERphzSbXuTA3DB1Bus=@vger.kernel.org
X-Gm-Message-State: AFuF++k6Q4Xabb0eXYNytBEGdHxaVHuOS2oWZwFpC6R/9PsmIlZxixFq
	epH50HdLKhMe3zi0jm1EMkW2xLVAD3lkNTnhyVRrLYKyni8WAzJQp0XJxsnDnHk9ofGPC+vzQoP
	CINaHmmM6Ucu2FTc1XD4EcESoRDpkY9cgzTBNayrmJrAJHhXOfn8HYT0dHxS7XuU=
X-Gm-Gg: AYBFou18UcVi6IBII7BQ9hVRgyNw/r6iGSVizUxYAwspOQhM+YZzJeDgk/X3TP2Liol
	vIfH+V6BpScyZcJ78fhcrHkNEHvpka1FlVh6tVRBqFCJm0jzIc6NtoXqPoql3DrVzSXIYsRpMbf
	/PNLptxujynr6hmyItqXKu0jbzo4EWw1HHXwSao9qHPDmQ4IxoHats0moD9XbkvJr7BXbMh8rYI
	9a2I9017FbotrcYE8GP4Wjjl1uKjld3sTSggI+gs3z8TT8bo46Iiyo8urfeNkwwgFJ7MgeQG0rF
	EC36Z4vtS5Jn6hykYr/BMohDjOpU7HFR/ylZ6MB+X2/ntc92m7LW3dNZM6luIA1N5y1Deh7uyqA
	a0gW26AsIN1CAdWKSTr2W0zayvUms0QY6E4ByLzfRlfWinFk=
X-Received: by 2002:a17:903:2452:b0:2da:f7ad:cfea with SMTP id d9443c01a7336-2dd8df0a71emr27124975ad.8.1789538668381;
        Tue, 15 Sep 2026 23:04:28 -0700 (PDT)
X-Received: by 2002:a17:903:2452:b0:2da:f7ad:cfea with SMTP id d9443c01a7336-2dd8df0a71emr27124325ad.8.1789538667935;
        Tue, 15 Sep 2026 23:04:27 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bfb19f8cesm4740083eec.2.2026.09.15.23.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:04:27 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 23:04:22 -0700
Subject: [PATCH 2/4] PCI: qcom-ep: Move PHY init and drive PHY reset to
 align with HPG
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-align_pcie_init_sequence_0916-v1-2-0b2195836f30@oss.qualcomm.com>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789538665; l=3449;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=h3fngNlkhZEZKpBHI/IT3xTrpcNvbLpoMF3Il2nEqag=;
 b=eTZfXLMDSIpr2rD0kW+QmRWdp9HNs5rYFTSCCvbAdhqFxpkC15bmD+pT/64Xq3BBABZm7nE6r
 kif1GcsJYCKBDLi+hJrEpTvhL5VVFDqdA8qCq0ZLA5sRh1Fa7EGYA62
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA3NiBTYWx0ZWRfXzf6iTeZF9Pe1
 vq7iJt6p/NGjs+XavGlP14F3U9KeefGfcFVk4gLjAvUSia2kcbjTnCjTbD3Ty+D8o879hlP5ZQy
 ebHmW1AzZwx5jInb7xmGNgyalPtv+Ts=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA3NiBTYWx0ZWRfXyGOxlAZpDVhM
 sRTqM4lR4fi+tXc+/mm363yU4pCwpHNCXgajiqvraTvkss72hnXOrS5ulRpp4speC9NJ8BSvQ+S
 4AcGKpQyybMKobWMF2NXHcxAa4G7PWFJ5C0y+re7HZRQ5k9GuskqhDjUb1BgxTngBDcZO/YwCCQ
 GdlxIoXCIQyX8wlEoL0P4Kyu8w3IjR/vmRIfztYmtYj79qddH+b8ULaELi4sDAIJc/R2r6yMckv
 O626oqteMN4WGg7uHTpJDdBnh0vvPlxgJQnfBnBum5r319O4mPN9nc5W3/9cxec+ElSb708paqd
 mpze1HLiB3BifuNjO0XTJq224rn+MVxDag+BWwTgH05nRJ9+oOoywUMZ47f/rmndJtGGG2crn57
 N2cOXlsSQoebWKEwbYykEDR78f/td+76u5IyvQuKd8ANvlZW+LPw5SmqiilD6yth/0SmHGG8sbe
 fsTjr0nWK2FYYUGp8Wg==
X-Proofpoint-GUID: BYPbkxAaBQQT1mVOTpBLj6LyMSScNgD7
X-Proofpoint-ORIG-GUID: BYPbkxAaBQQT1mVOTpBLj6LyMSScNgD7
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aaa316d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=PV8ZVrNDrE42_2bsUUYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160076

HPG requires the GDSC to be powered up and all PHY/controller clocks
enabled before the controller's core reset and the PHY's reset are toggled
together as one atomic group, with PARF_DEVICE_TYPE set right after that
reset group, same as the RC-mode change.

Move phy_init() ahead of the controller's own clock enable, and fold
phy_reset() into the core reset assert/deassert. phy_power_on() keeps
running afterwards. Also move the PARF_DEVICE_TYPE write out of
qcom_pcie_perst_deassert() to right after the reset group, in
qcom_pcie_enable_resources().

phy_reset() and phy_init are currently a no-op against the PHY this driver
uses, so the init sequence doesn't change yet; it actually changes once
the PHY driver later implements .reset.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 8364696a1b98..cd7725d277c5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -228,7 +228,7 @@ struct qcom_pcie_ep {
 	int perst_irq;
 };
 
-static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
+static int qcom_pcie_ep_phy_core_reset(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
 	struct device *dev = pci->dev;
@@ -242,6 +242,12 @@ static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
 
 	usleep_range(CORE_RESET_TIME_US_MIN, CORE_RESET_TIME_US_MAX);
 
+	ret = phy_reset(pcie_ep->phy);
+	if (ret) {
+		dev_err(dev, "Cannot reset phy\n");
+		return ret;
+	}
+
 	ret = reset_control_deassert(pcie_ep->core_reset);
 	if (ret) {
 		dev_err(dev, "Cannot de-assert core reset\n");
@@ -332,25 +338,25 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	struct dw_pcie *pci = &pcie_ep->pci;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
+	ret = phy_init(pcie_ep->phy);
 	if (ret)
 		return ret;
 
-	ret = qcom_pcie_ep_core_reset(pcie_ep);
+	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
 	if (ret)
-		goto err_disable_clk;
+		goto err_phy_exit;
 
-	ret = phy_init(pcie_ep->phy);
+	ret = qcom_pcie_ep_phy_core_reset(pcie_ep);
 	if (ret)
 		goto err_disable_clk;
 
 	ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_EP);
 	if (ret)
-		goto err_phy_exit;
+		goto err_disable_clk;
 
 	ret = phy_power_on(pcie_ep->phy);
 	if (ret)
-		goto err_phy_exit;
+		goto err_disable_clk;
 
 	/*
 	 * Some Qualcomm platforms require interconnect bandwidth constraints
@@ -370,10 +376,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 
 err_phy_off:
 	phy_power_off(pcie_ep->phy);
-err_phy_exit:
-	phy_exit(pcie_ep->phy);
 err_disable_clk:
 	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+err_phy_exit:
+	phy_exit(pcie_ep->phy);
 
 	return ret;
 }
@@ -390,8 +396,8 @@ static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
 
 	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 	phy_power_off(pcie_ep->phy);
-	phy_exit(pcie_ep->phy);
 	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+	phy_exit(pcie_ep->phy);
 }
 
 static int qcom_pcie_perst_deassert(struct dw_pcie *pci)

-- 
2.34.1

