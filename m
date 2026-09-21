Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454F356771
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969075; cv=none; b=FH2SA2lS8Z9KG89NDm4i27HfMjw8kJYFGMe34IVftIL4U2vd7IdIQoTY0EEM8QLe7L+hHm7+saP8PVUTEbOvrW4nLsxB6vkbKqn24fLRVO0u+eIltpyk4NGhMq66lRDPBp02CsB7QgwKkD+T+uGO2hf1ZPuCn7Dcall3fCDHvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969075; c=relaxed/simple;
	bh=B9hSgf5LIgHsicFYYXgD8Nn7K6/yMMHhWd+3lvIHSVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3wgg6gnPNoN+yvdRZRISvZ8XwjB0bsR3so8feMfRRk+hsucao1ygBxoBXbSDlASrZ3WeouLbwSzUSPKCWPjRlL6p99PTORYphL48q+I/cRY6Es/B41+F0po/zEzBb9u0hc1hChX8GW9h3P+vXCF2C6LkmyX2NMhM552/b6GvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ekF0aMg+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H1Xms0FI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ekF0aMg+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H1Xms0FI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3Z1Q43679940
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Av0TFBF20NWmzoMNcaMLBPBsgOdZZrINkSuTUnz9OI=; b=ekF0aMg+zkvnvdMG
	OwXqHasoRqPjxKm61luu/3R+F2dYUCazTLkfq8N11gS3FciWOxTGTMgKMGO/4s5J
	baOKB7olL4B5ZpkH2zPqllLecLq82srrCY7d/0z6xydrpT1nBB08CgU99VIjcD8L
	0mvB3SrYBlIZ5WFp92FzHfXRzRMoKhTB4lBj+WzM7tmBUdxNABOrKFpm47c2LoVH
	asPlxQ3qBf2DC/EDdlR9Ae5LcKwD3+G34dgYjubrw97dcGBI+dAy1fmpgSiVH6X3
	lu+2nAeAOOsd6poDdNyQ0JDmq+jlZc02UtXTg0TvO4XLDx3yXqtj7bvEyoVEYiUK
	32PhlA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsk5emrxp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39af92138f9so3934050a91.0
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 22:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789969072; x=1790573872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Av0TFBF20NWmzoMNcaMLBPBsgOdZZrINkSuTUnz9OI=;
        b=H1Xms0FIiZo8rEZSvkUXZ660X//0e2liOLgeUDpZuuyqxfs9wRkOaKrvh4jFYGKfQm
         nuz/zr0mhiB5UV6haovWyXhqF+CPMWjCT6uJDHZTCm+zhUmRqCKXaC717Ox5lKcW501K
         gsXH09p0WPzTD2c+NosatQazlQu0tubFpeRR62oIvRa5W5l6Kx4DXRt8pf9vTepdRiFm
         I4PZ9aDQXfjJAJEGDMo58wb126bNwSaapDGcpaGu3lezQuAkxnXELVJtPH7fZJixgbWK
         SFQmT8XcLSeCERPRfGhDIwHY1g8YcgkpIDarVZ1pFzOTWfx1bVh2LKGE2HnMQH80aPUy
         Ouhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969072; x=1790573872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Av0TFBF20NWmzoMNcaMLBPBsgOdZZrINkSuTUnz9OI=;
        b=YsrbVdXkIDWhhbiBffZy7b17HIZDAJ7j+LPLWFWUeyH0C2YCVAxq9MQiVLvf1Zc90B
         1sI7CEZUYGlPM58Njybdguv4h1tWpgou9xtrSekkpyrmBEaJfR5HmJ9wm1rEkBVODUur
         T+4IjDqlpHCarVDHqOEi1vmnIc9tVid5Wm3BipfaAsLaXGbdHGBC1Yb4sAbumsxY0V0k
         92dGdeYzk21ZUrYhBdDyLBfYla/o9Hw9PTnCV9o0ZEEK1PRvUbH2BjbeDuzD5d8Jw1f+
         UERfBzvbTvnc3gNzUzO98/TY4YUPQGhM2AoTl6ejh4hfmk+WJZibSfqqbYkt88Do15bx
         PrMg==
X-Forwarded-Encrypted: i=1; AKwUvBy0+uD1G+Wu9E+T3EjFewAAUY2Sw94JpttPjxDE1n5S1tHmHf7sCbUL9vreeRfKtcPEOMjepNtd8yY=@vger.kernel.org
X-Gm-Message-State: AFuF++l9fDdw5bajKiqCxDur6ED5PtxdVhotQWAG3XOsisZsyYA8QZtj
	ftzx08kCZdGPkxh6gT9sfUgtY/3yiOpQ15desPh5HqisF1pQedan3wQE5F5Ft3jxDF3GtXdiUuV
	vedP0Gv+qFiB0LK7beMLysgF6JCqM7airtsIsn3w0RLQ0wLpwn14X7W1BZhW0cyU=
X-Gm-Gg: AYBFou00Yt6/JCI5vQUK5tTmlSu9mU0FNJD71/w1AedzlxE7hHOn8ZUXdzGGWAmUHgg
	PFpoyg+2AW48cPItDbbGQUNc5fypM1RJfOZRzJoFcq1wTiFSYsueRNw+bLlrqN07am7hh6dOdk4
	m1RzUTbyhTu7Usb19MPREK1QxuVtum0PvtW1jDpfWXfWTOXSgKz2y22IytMQcEh79KRSSN7xe5p
	5JIgfe/vzfUsQgoLeM1f/9aUOcH8d052dNgoM3IwZBlFsyxXQoRt6j7dI9e+V5dmAFeBCVGTLj5
	RWz5CANIPVhCUZNzwSjHQd+98QWVSxe6ZNJcmgQis+63FyhLnat4kaewgc9+DJXjHsRHEAwPfD0
	XNC21CDgR+spoj75kMFwpuMfgYcLWdII/pw==
X-Received: by 2002:a17:90b:58e4:b0:39e:4c97:ce05 with SMTP id 98e67ed59e1d1-39e4c97ced5mr13018208a91.38.1789969072410;
        Sun, 20 Sep 2026 22:37:52 -0700 (PDT)
X-Received: by 2002:a17:90b:58e4:b0:39e:4c97:ce05 with SMTP id 98e67ed59e1d1-39e4c97ced5mr13018190a91.38.1789969071980;
        Sun, 20 Sep 2026 22:37:51 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55d45a6sm15054568c88.9.2026.09.20.22.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:37:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:07:13 +0530
Subject: [PATCH v4 5/6] phy: qcom: qmp-pcie: Refactor common multiphy
 handling
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-nord-v4-5-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
In-Reply-To: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
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
        shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789969033; l=8020;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=B9hSgf5LIgHsicFYYXgD8Nn7K6/yMMHhWd+3lvIHSVI=;
 b=C4kgjcWkc3+ruopFUBvV9013Coya1P2YdFDKm2MJSBLEJ1iD/O+izbSqmrevGKOKGFW5n684M
 ASB8keqZ0SmBk7k4yzbdxUVjjhyWDpnl+SsbboEShPX4whlV3j4d5Rl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 4EY754I17RfvPtKhhr5vmSj1cK71_BmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfXyygGwvtVk18z
 b8nfeO5sFfiof3nDn7N/79BrE7OtYAnK8qsR1py6o0TCkv3fN4ZXkttFTmQ9dF+XfDMLy0uG5ov
 MKrogN3I2aC11F+LKFuGN6Nw4xWXnLnFSkgfGP9dtBz2KlMrGb8JuWSRAJe0WoFdAmhymRu3s4Y
 +XCK+G5mDjuJjnbjumWqRdT+2cn+cz6t+Riyy0M3j9ZPUFBDEbwaMW9ctmCQovhsTNm7b8CcUPT
 gvu/PtMw//sRp/pF1zZiYgctOhV/wiwCCnXAaCvyCaZPvGb9rsR5VCigdJ4E/a1FJDirPfOFc9p
 T2IB69XGkQtyza64iythREYJlxToHsTiWjuxUYUovu9TwkQFWs/A2bK8L8YmrTZg3ibYjBKHTG9
 i+8hLjNHNAcuNGg7gGcXSJEp/jXSCIuuFdWCqAhTVTgBllfMSXcbYGU0ffvKrNIUwlU7zhdqMkc
 VsnFoziPfKztFvYZCFg==
X-Authority-Analysis: v=2.4 cv=f8Ddl+yM c=1 sm=1 tr=0 ts=6ab0c2b1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xSDsCvtJ24Ukv9SpSl0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfX+RJYz9kZhNeP
 URRt6G7LUV2MLTXj8M6mvQP+QMYI73jV3wAwHNkWKBowry8XM6bRuKPcZ/PFhEuv+QkM/L736um
 ZCX3Of6Dn1V5ibin4GX9jqOVf++F5lI=
X-Proofpoint-ORIG-GUID: 4EY754I17RfvPtKhhr5vmSj1cK71_BmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210078

Reuse the existing port resource arrays for Glymur register regions,
power domains, and NOCSR resets instead of maintaining duplicate
Glymur-specific lists.

Attach each PHY instance's power domains to the device created for that
PHY. This ensures that the associated GDSCs are managed with the
lifetime of the individual PHY device rather than the parent multiphy
platform device.

Validate the clock-output-names property before using its count for
allocation, and use a generic module description.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c | 102 ++++++++++------------
 1 file changed, 44 insertions(+), 58 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
index e93cba4369fb..befca9b78ce9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
@@ -113,31 +113,19 @@ static const char * const glymur_vreg_l[] = {
 	"vdda-phy", "vdda-pll", "vdda-refgen0p9", "vdda-refgen1p2",
 };
 
-static const char * const glymur_pciephy_a_reg_l[] = {
+static const char * const pciephy_port_a_reg_l[] = {
 	"port_a",
 };
 
-static const char * const glymur_pciephy_b_reg_l[] = {
+static const char * const pciephy_port_b_reg_l[] = {
 	"port_b",
 };
 
-static const char * const glymur_pciephy_reg_l[] = {
+static const char * const pciephy_port_ab_reg_l[] = {
 	"port_a", "port_b",
 };
 
-static const char * const glymur_pciephy_a_pd_l[] = {
-	"port_a",
-};
-
-static const char * const glymur_pciephy_b_pd_l[] = {
-	"port_b",
-};
-
-static const char * const glymur_pciephy_pd_l[] = {
-	"port_a", "port_b",
-};
-
-static const char * const glymur_pciephy_a_nocsr_reset_l[] = {
+static const char * const pciephy_port_a_nocsr_reset_l[] = {
 	"port_a_nocsr",
 };
 
@@ -145,7 +133,7 @@ static const char * const glymur_pciephy_nocsr_reset_l[] = {
 	"port_a_nocsr", "port_b_nocsr",
 };
 
-static const char * const glymur_pciephy_b_nocsr_reset_l[] = {
+static const char * const pciephy_port_b_nocsr_reset_l[] = {
 	"port_b_nocsr",
 };
 
@@ -155,12 +143,12 @@ static const struct qmp_pcie_offsets glymur_pcie_offsets_v8_50 = {
 
 static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_a_cfg = {
 	.offsets		= &glymur_pcie_offsets_v8_50,
-	.reg_names		= glymur_pciephy_a_reg_l,
-	.num_regs		= ARRAY_SIZE(glymur_pciephy_a_reg_l),
-	.pd_names		= glymur_pciephy_a_pd_l,
-	.num_pds		= ARRAY_SIZE(glymur_pciephy_a_pd_l),
-	.nocsr_reset_list	= glymur_pciephy_a_nocsr_reset_l,
-	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_a_nocsr_reset_l),
+	.reg_names		= pciephy_port_a_reg_l,
+	.num_regs		= ARRAY_SIZE(pciephy_port_a_reg_l),
+	.pd_names		= pciephy_port_a_reg_l,
+	.num_pds		= ARRAY_SIZE(pciephy_port_a_reg_l),
+	.nocsr_reset_list	= pciephy_port_a_nocsr_reset_l,
+	.num_nocsr_resets	= ARRAY_SIZE(pciephy_port_a_nocsr_reset_l),
 	.vreg_list		= glymur_vreg_l,
 	.num_vregs		= ARRAY_SIZE(glymur_vreg_l),
 	.regs			= pciephy_v8_50_regs_layout,
@@ -173,12 +161,12 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_a_cfg = {
 
 static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_b_cfg = {
 	.offsets		= &glymur_pcie_offsets_v8_50,
-	.reg_names		= glymur_pciephy_b_reg_l,
-	.num_regs		= ARRAY_SIZE(glymur_pciephy_b_reg_l),
-	.pd_names		= glymur_pciephy_b_pd_l,
-	.num_pds		= ARRAY_SIZE(glymur_pciephy_b_pd_l),
-	.nocsr_reset_list	= glymur_pciephy_b_nocsr_reset_l,
-	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_b_nocsr_reset_l),
+	.reg_names		= pciephy_port_b_reg_l,
+	.num_regs		= ARRAY_SIZE(pciephy_port_b_reg_l),
+	.pd_names		= pciephy_port_b_reg_l,
+	.num_pds		= ARRAY_SIZE(pciephy_port_b_reg_l),
+	.nocsr_reset_list	= pciephy_port_b_nocsr_reset_l,
+	.num_nocsr_resets	= ARRAY_SIZE(pciephy_port_b_nocsr_reset_l),
 	.vreg_list		= glymur_vreg_l,
 	.num_vregs		= ARRAY_SIZE(glymur_vreg_l),
 	.regs			= pciephy_v8_50_regs_layout,
@@ -191,10 +179,10 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_b_cfg = {
 
 static const struct qmp_phy_cfg glymur_qmp_gen5x8_pciephy_cfg = {
 	.offsets		= &glymur_pcie_offsets_v8_50,
-	.reg_names		= glymur_pciephy_reg_l,
-	.num_regs		= ARRAY_SIZE(glymur_pciephy_reg_l),
-	.pd_names		= glymur_pciephy_pd_l,
-	.num_pds		= ARRAY_SIZE(glymur_pciephy_pd_l),
+	.reg_names		= pciephy_port_ab_reg_l,
+	.num_regs		= ARRAY_SIZE(pciephy_port_ab_reg_l),
+	.pd_names		= pciephy_port_ab_reg_l,
+	.num_pds		= ARRAY_SIZE(pciephy_port_ab_reg_l),
 	.nocsr_reset_list	= glymur_pciephy_nocsr_reset_l,
 	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_nocsr_reset_l),
 	.vreg_list		= glymur_vreg_l,
@@ -398,45 +386,39 @@ static const struct phy_ops qmp_pcie_phy_ops = {
 static void qmp_pcie_pd_detach(void *data)
 {
 	struct qmp_pcie *qmp = data;
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int i;
 
-	for (i = 0; i < cfg->num_pds; i++) {
+	for (i = 0; i < qmp->cfg->num_pds; i++) {
 		if (!IS_ERR_OR_NULL(qmp->pd_devs[i]))
 			dev_pm_domain_detach(qmp->pd_devs[i], true);
 	}
 }
 
-static int qmp_pcie_pd_init(struct qmp_pcie *qmp)
+static int qmp_pcie_pd_init(struct qmp_pcie *qmp, struct phy *phy)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	struct device *dev = qmp->dev;
+	struct device *pd_dev = &phy->dev;
 	int i, ret;
 
 	if (!cfg->num_pds)
 		return 0;
 
-	qmp->pd_devs = devm_kcalloc(dev, cfg->num_pds, sizeof(*qmp->pd_devs),
+	qmp->pd_devs = devm_kcalloc(pd_dev, cfg->num_pds, sizeof(*qmp->pd_devs),
 				    GFP_KERNEL);
 	if (!qmp->pd_devs)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(pd_dev, qmp_pcie_pd_detach, qmp);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < cfg->num_pds; i++) {
-		qmp->pd_devs[i] = dev_pm_domain_attach_by_name(dev,
-							       cfg->pd_names[i]);
-		if (IS_ERR_OR_NULL(qmp->pd_devs[i])) {
-			ret = PTR_ERR(qmp->pd_devs[i]) ? : -ENODATA;
-			goto err_detach;
-		}
+		qmp->pd_devs[i] = dev_pm_domain_attach_by_name(pd_dev, cfg->pd_names[i]);
+		if (IS_ERR_OR_NULL(qmp->pd_devs[i]))
+			return PTR_ERR_OR_ZERO(qmp->pd_devs[i]) ? : -ENODATA;
 	}
 
-	return devm_add_action_or_reset(dev, qmp_pcie_pd_detach, qmp);
-
-err_detach:
-	while (--i >= 0)
-		dev_pm_domain_detach(qmp->pd_devs[i], false);
-
-	return ret;
+	return 0;
 }
 
 static int qmp_pcie_vreg_init(struct qmp_pcie *qmp)
@@ -555,6 +537,8 @@ static int qmp_pcie_multiphy_register_clocks(struct device *dev,
 	int i, ret;
 
 	num_pipe_outputs = of_property_count_strings(np, "clock-output-names");
+	if (num_pipe_outputs < 0)
+		return num_pipe_outputs;
 
 	qmp_data->num_pipe_outputs = num_pipe_outputs;
 	qmp_data->pipe_out_clks = devm_kcalloc(dev, num_pipe_outputs,
@@ -630,6 +614,7 @@ static struct phy *qmp_pcie_multiphy_xlate(struct device *dev,
 static int qmp_pcie_probe_phy(struct qmp_pcie *qmp, struct device_node *np,
 			      struct phy **out_phy)
 {
+	struct phy *phy;
 	int ret;
 
 	ret = qmp_pcie_get_mmio(qmp);
@@ -648,15 +633,16 @@ static int qmp_pcie_probe_phy(struct qmp_pcie *qmp, struct device_node *np,
 	if (ret)
 		return ret;
 
-	ret = qmp_pcie_pd_init(qmp);
+	phy = devm_phy_create(qmp->dev, np, &qmp_pcie_phy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	ret = qmp_pcie_pd_init(qmp, phy);
 	if (ret)
 		return ret;
 
-	*out_phy = devm_phy_create(qmp->dev, np, &qmp_pcie_phy_ops);
-	if (IS_ERR(*out_phy))
-		return PTR_ERR(*out_phy);
-
-	phy_set_drvdata(*out_phy, qmp);
+	phy_set_drvdata(phy, qmp);
+	*out_phy = phy;
 
 	return 0;
 }
@@ -739,5 +725,5 @@ static struct platform_driver qmp_pcie_multiphy_driver = {
 module_platform_driver(qmp_pcie_multiphy_driver);
 
 MODULE_AUTHOR("Qiang Yu <qiang.yu@oss.qualcomm.com>");
-MODULE_DESCRIPTION("Qualcomm QMP PCIe Multi-PHY driver for Glymur");
+MODULE_DESCRIPTION("Qualcomm QMP PCIe Multi-PHY driver");
 MODULE_LICENSE("GPL");

-- 
2.34.1

