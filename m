Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314E3B5F48
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161200; cv=none; b=rIbqbmpC75EwE6gZpDSKAibOMYPhiUayegEGTA/ylHd6H+Ee9S6Qv43MiDRfLeMWoteIUI2ojMn2ELlMowQbKsvXnJT2g9AjUQ81h9ipEd+nINTqPwTV26H+1EVGXIM51C914HZiOxdsT0SMZ2AyC+SpB8Q0vC8XLeloFH17D/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161200; c=relaxed/simple;
	bh=aTj5KtOb2vKiTmwN7SGIUjWosWnCNz+9xpIGl5k0Q6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OoXQgu9xAyu/MfvGSjGqAlbXJ+e4Hfx6pZSNmBLXgwAJeQ0Umed1S5tFvdiwPjQMIujQvMQfjOvZjdXkYo3teZj2TmwFMc8YwwGNb/G+tHWjI6ErH1f78JCQZOFr+2Pf1SlUOVtLiFtazioecuiIwBVvdnkp+d8dSwFQKsffV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=am1YGbgn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kHOVyL5k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="am1YGbgn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHOVyL5k"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52IX51933542
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHuJUjEsLPE8+q1YHV5zzKgadJG0CI5d9no3OMB8tgI=; b=am1YGbgnbiuAwlKv
	MugkxV8S4vci4keiIgzknG/WrJwYqCZkTtoDthBWr11YrBNTdbUaLmD/UTz7pMkv
	qPbxFuiGn4p6V0y/4L+PUUi7nCNRRK/USIwZEZ6KqbqN/CLOCbTiVZzvsezdwdsC
	EThn0iPdyLoqnXd8igTno52uzeAW6UgdR9bPy6R1GkN4T9accGXSPN7i9Ql2pr/w
	enXNNFjjQb3OR77PMMIgrdK/N+nmD4PROmBsqpSqxzh2nNvFYJeG16MDULFBwUKa
	l76X/q09+NeAStFZxHcwvB2M15u13pCnsYiGYPyMFI+HxVg7/DA7akWkxCxY003J
	AfFIzA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq850bb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfa55c9430so26480595ad.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788161197; x=1788765997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHuJUjEsLPE8+q1YHV5zzKgadJG0CI5d9no3OMB8tgI=;
        b=kHOVyL5kdXgh9BarKTp3LY2mUZIqVjJ3cox0Cnw73bDp/yM/5UrKBHF080+x9MBvtw
         RVpFXtVgtfqArOeVHv49VPIB8PrZT68hjPbXvMcqSs/Lrw+QeoijNMzKf2h7MO2krS4H
         yw7grjS4cqGTGNAI4MVyPgkYvfJjOP9ayrrYqii78lD+eT8ijukBSD1ZqZ2aMeL56dEw
         MUv0nUXii+soO9MpZntkVhJbP0CTsvEL+WaEheIpO2sJt8A+hfBcJM3TCUVq93uvT7r0
         JQLbPFt2xETUjJSYGG/K7F4sXDiQpTOfCw9bK7zejJqzBbH8GH2ipIeQzQ6pRJtmJ2mW
         +06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161197; x=1788765997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHuJUjEsLPE8+q1YHV5zzKgadJG0CI5d9no3OMB8tgI=;
        b=QgycG8eLgG28meK5/yd9S7wCDKfvN79M0xZdAaOIuaRsMkoHflOjvYXDnav+jrxzjc
         A8wsMYskuOO9OSSU6W3Jir5RdfwyEArQptDkAYHlffqSC5gEqf0v9jyM5NtgJ9rwdVVg
         1dGMSY6bzVhYGJKW9aZrJ2cMjCmbxUlxHNyGy0W68DubtRA+9J74P1Hw0RiIyC6VD8jH
         iEXHQsxWxbJ0kaXIy4qJHts2v8WtSCzMS2vvafwKAEs+Fx2PlbAORuMe/lYxRuvHdy9H
         N4XQpT1UXR4DjV1zi2ZhkkzVnCQ/QIFFHrt1oqkDsPPYmBc3s4JwYxp8VfSFfBmIPVkk
         8ZIw==
X-Forwarded-Encrypted: i=1; AKwUvBxLrQU/QzN+JrRDCCpZ7PUskQ8+s4ShXcbzcCt6IbZLOzJGQlP8rU8YBa02NUOthHZ9kzcJp8yBdCM=@vger.kernel.org
X-Gm-Message-State: AFuF++n0H4MdN7DwL7sDjFhczYO5arR37mXiuw1K7Ej51uwWowVz/NH8
	sUchX+Q7lW58AT/PK1r/7HEmz8RDSPGCH7ar1NmCcNUe9TAXvOmFzEnTQmsLj9aqEz0CSNU61e/
	JdRhcrqsx7Ieb1oTFhO71WMnDPBZ6mKP2LfZJNSSaY+Mp1+5Wy6/7CQ3QmfV6VFk=
X-Gm-Gg: AYBFou3Wk+pvw+KMyvxjKqrp1RuKSJS2KYvWmJW2xCbHsvjTNtuA85MN14wNjn99myl
	9Ir8a2+s2wNEu4oU8GlXJg4WkysBruDWfy6xmw9n5lzAyAEQ6XOxWjU1UGo1weHXtlYH6qDYOiz
	KHkErkVaKxCVNWSNFPl2i7CPcEYa9dLVFBgBScnVMN7g/9KJqx0FKClQWTNDjHgLZrP7yr3QxiX
	3j6v03OHvQuzRoVxAIXXLdFUC7MEw1dLqMYHNWy+Ui9TsPsYMx9GexP9lZoHhvHB0LmYj/iV9Ne
	kAoaXO5unSLfAPg7QieO9HTbcMIUuusnMBFi/jSF+rQqFtVb7R2KanO4iTuP9A3lRE1B7Q55YDW
	LartkyUoyLrSXwjANFoU1yl/jqGg/nYQlCaae
X-Received: by 2002:a17:903:3b88:b0:2d8:df44:a5c2 with SMTP id d9443c01a7336-2d8df44b118mr230672735ad.20.1788161196965;
        Mon, 31 Aug 2026 00:26:36 -0700 (PDT)
X-Received: by 2002:a17:903:3b88:b0:2d8:df44:a5c2 with SMTP id d9443c01a7336-2d8df44b118mr230671785ad.20.1788161196378;
        Mon, 31 Aug 2026 00:26:36 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm31327059eec.14.2026.08.31.00.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 00:26:35 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:56:04 +0530
Subject: [PATCH v2 4/5] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Shikra
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-shikra-upstream-v2-4-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
In-Reply-To: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788161164; l=4605;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=aTj5KtOb2vKiTmwN7SGIUjWosWnCNz+9xpIGl5k0Q6c=;
 b=PjB8STXozdOt3bZU83GyYBS/uO+OuIbWwQDKA7PhE07yCX+a6lnCt7IJ6sy5kjsbjFqaMzWYu
 VgwOi6BrBLZCgrxK/Zo4fFAJbRi0ApsytXvmD/vEz+NtgZ0EcgfJdtC
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-GUID: T4uu_1vgfF7V0T2MaceM1galmkaPeXZ7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MyBTYWx0ZWRfX1plG6SS1Tt7/
 XqJbBhW3Qe1NlpCcy68nqeZAIsaHKn2+x20lIgJ/mi4LqIY1iFF5VmSlauM67Nu53wTPtiS4Qud
 fDGe87zdnvtQEQ5WdbofrrsDwzlKOrc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MyBTYWx0ZWRfX8FEY1uy52Rms
 2ZAE+GVL16BtFfhM3hvLq9YxBTAU1MZqb9sQ5jEurmCQAvSTNBWtu00C95xs0E1HYlNIU9FmheQ
 9xa1/+VQJ9dFpTSRFjupDIeeMFuR7YxSIgtNALST6pXOVkXAfQiR7X2epLBIS10/odXNFC0r6zK
 AM38HKqO2ButVfxXdv0jLzgGkQCm0Bg3fz/7IrHqaZjpzms7aG82IG9sAiA4XZqWnxuduWMZfnw
 EQyFV+HYcUJt9ap+ta3rodENI6EyXvAOtiWqDSFMEF5YNFSGYaUATkw/Or3EetK2nBPa2pcRZ7I
 PRDg3Cmuq6bGCvSAZ9+E9yiJ3GZQB9UsFDJTZ6wbGPYTYxn5+zMTnkY7yJ34irtQzghQsV+1RxN
 6mvZOl6lj24tPgP7As6Jd0paXc24hhQ74bzTrt/e5rKPLdmymliNV8R5DtxVqFH2nFaPRrv2G0W
 qCuA55KtPHBmtrbxIlQ==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a952cad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=iLgwJ6eFgLmkID89yw0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: T4uu_1vgfF7V0T2MaceM1galmkaPeXZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310063

Add QMP PCIe PHY Gen2x1 support.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d3effad7a074..e0995e4d5f2d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2172,6 +2172,50 @@ static const struct qmp_phy_init_tbl sdx65_qmp_pcie_pcs_lane1_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
 };
 
+static const struct qmp_phy_init_tbl shikra_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CLK_ENABLE1, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TRIM, 0xf),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP_EN, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_MAP, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_TIMER1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_TIMER2, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CMN_CONFIG, 0x6),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_IVCO, 0xf),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_HSCLK_SEL, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SVS_MODE_CLK_SEL, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORECLK_DIV, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TIMER, 0x9),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYSCLK_EN_SEL, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START3_MODE0, 0x3),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP3_MODE0, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP2_MODE0, 0xd),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CLK_SELECT, 0x35),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYS_CLK_CTRL, 0x2),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYSCLK_BUF_ENABLE, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CP_CTRL_MODE0, 0x4),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_CCTRL_MODE0, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE0, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BIAS_EN_CTRL_BY_PSM, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TIMER, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_EN_CENTER, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER2, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER1, 0x2),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER2, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE1, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE2, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CLK_EP_DIV, 0x19),
+};
+
 static const struct qmp_phy_init_tbl sm8450_qmp_gen3_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
@@ -3911,6 +3955,32 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 };
 
+static const struct qmp_phy_cfg shikra_pciephy_cfg = {
+	.lanes			= 1,
+
+	.offsets		= &qmp_pcie_offsets_v2,
+
+	.tbls = {
+		.serdes		= shikra_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(shikra_pcie_serdes_tbl),
+		.tx		= qcs615_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(qcs615_pcie_tx_tbl),
+		.rx		= qcs615_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(qcs615_pcie_rx_tbl),
+		.pcs		= qcs615_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(qcs615_pcie_pcs_tbl),
+	},
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_v2_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
+
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -5603,6 +5673,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy",
 		.data = &sdx65_qmp_pciephy_cfg,
+	}, {
+		.compatible = "qcom,shikra-qmp-gen2x1-pcie-phy",
+		.data = &shikra_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sm8150-qmp-gen3x1-pcie-phy",
 		.data = &sm8250_qmp_gen3x1_pciephy_cfg,

-- 
2.43.0

