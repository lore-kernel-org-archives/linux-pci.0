Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605A34389D
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846232; cv=none; b=lPkFpuE6pT2mUhpjdhroYHUeQnVv+e6YKwqmYzLqoLFhp3cEyTNkw6QqdJPqKgrCyUn8sDpv1kMQLbQHZahDIsitz2KqU+SqbRwM3FUbr56+LIle7lVC/3NyXHtMMvivMYCnCnE2YLQLLOUfL0BWCwwu8pY326svTIr3WdkPeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846232; c=relaxed/simple;
	bh=aTj5KtOb2vKiTmwN7SGIUjWosWnCNz+9xpIGl5k0Q6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+nEaU/E0wUbh7092px4ccRMuLNrvPtOmj0QvbYAzd0fc4jTliYg3xibRJWCAAwHWZ+sY+Vbrzsv2NJCxsXe2OBMMYN5nrANCO475jup94wJEK5rcm+21cm5NeBi7VrwGil27quUh8EGFZNpSLiaxO98EgTsec0sH9L+XoLQKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGTg82i4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fMXC/CMj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGTg82i4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMXC/CMj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UItoj32897505
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHuJUjEsLPE8+q1YHV5zzKgadJG0CI5d9no3OMB8tgI=; b=DGTg82i4kwkz9Z2i
	i0dKZ2W5DizOcMxQq07RwhEMSkzS+eQZ2a2lMQz9leo6Rlb7Bv/3qqdP2pgLwc59
	gV5yArcplxVTnOs89rFgBw77fnnD2UpYk7JmbbRK28SNPEMZ7AS0SKQz65cNUL5D
	4D2aNOxEhGjhtBbpa/BUwWdBi9rU0tXkTDL4GjkTRJViCelTGqUgDjK615AS7O6F
	coIgnuw6rLqtVupywP5lszLueu6u/wxiggsEIrjiWb58iiUIkYadRoXsaH1ciNpa
	+sy6oQqLr2RGl+qUqSKaKbG0rjAN0Loc2mhm03Nisjd6D4enl0K6bCvL8saw2+0M
	69PT2A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw01se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ed53abff8so2507552eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782846230; x=1783451030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHuJUjEsLPE8+q1YHV5zzKgadJG0CI5d9no3OMB8tgI=;
        b=fMXC/CMjXsy/2STGgGK0O4zUFkiu8ni3H2LqZ+yN7eqhxptIjMxtKHG69rBBn2OxjQ
         ZS9WjP3mU12CooLBcOnGETycXExBWRzCl5427ILQfOzVNtjOeaavPF7q3uXPV/vwOGnZ
         jdQuiSSAVkO7V+XMjS8a7deFsQ7fWbeQXF+aUBDwF1duMaKencWTSo4qF1m5l4WeZH7J
         UQRYURaWBYnXfEXU5ZDHRemoCYWmEZpgp8YES6TwDHamwGvXhMOdW875zC5Znbz8dLkt
         qRGDP1VkRtzWy+30D6z3l567cqaxWPau8nSyMv8cb7vETgZQlt0938s2LDhoA9V3Ifjx
         bwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846230; x=1783451030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHuJUjEsLPE8+q1YHV5zzKgadJG0CI5d9no3OMB8tgI=;
        b=eQHOcrY/baNTZk3+7jaRuz93qF5FUGKv0cYEXxrNDn7gHMcKhsoNOmvzb6qKa6i24u
         3vzfdQKHBPNFTDKR0ob4yjahJKAJ+/cA9q2Cd5QSioiY+a06LQYCyzq4nEHmPEUNfwaJ
         42YQGcF3TOG5q0PylLWo6MRAVC+//q5liC7qPRWRf+iqCLf5aBv6jrgnlbypPeNcSWG/
         0NTkw9lvYs/G4wYReU5JkDg6Mflva9bkfdKv7xNZq4LATPljrXdicqmr+6mZ/q2V1eDs
         CuOF+30tIskkaRYKrJ1CuKnjQQppf5UcMy5+FQVC3VutAhdm/DnWe1tqt9aFPNZUIs3A
         zUig==
X-Forwarded-Encrypted: i=1; AHgh+RpFtNiZEqyEjHSG9E4QMSZ0GCJRm3qJ3qxZhBzKkD3WtIJTW891Y8RWPQKMhR68nqndqiLsAlHEJJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJt98Hl7fbY67gdmfZAinjMFFswjCppoix+73tgaL/atGDkyXI
	uNcw02pdzm7bV3ltVmMrnFd+T4czEm0ADnsV42IPP+9Q4TzB6Ris3Q9XqCz8PdWhUAqpDFOa/+h
	Y4AvGT9zxRK1qctYINxTEZ9Zt89y+7eVzHW1sGUhTVZkmEYUGdkseEaMf9dkd9mc=
X-Gm-Gg: AfdE7ckd5emfD1PEiy8LMpEGNOb+iWhn+rSEXuZTLAMJJNr5CNJ51NN+nYcmHcfIzXv
	ZdWsKyLUOcq29zPjkzhA+JB85s/NPBsIjmNk+7qULaQEF40F2CZTtod+MHuCWBnERNgPnjXpVIz
	Ko3Bdq3p0k5K4jrdCY6Z8attxh/dCJr52p+ZcjvcpW5LdeBJXaDdnLPYQyWt/e8vmTzkJ9WZO8i
	c3ARvTSaWwEKBZJaKtuoPs0FRfEO4ldWyhXoWtfA5f9gPPorurzJ0xTe0veNwvLvHgRFG8rRmtr
	6j++q35CIzF1TE1y8Kvhc6m5DxHykDs/XjiNt5OcyjAToc9qzJ4xwfkxCr/3IQY8SGUbXKj2Oe3
	uwlBABEBoC0iUd29kn/xhfdICVNGqwyB2c22fGUE708WL24A=
X-Received: by 2002:a05:693c:3b09:b0:30a:e531:3153 with SMTP id 5a478bee46e88-30ee1364aa7mr3098944eec.14.1782846229942;
        Tue, 30 Jun 2026 12:03:49 -0700 (PDT)
X-Received: by 2002:a05:693c:3b09:b0:30a:e531:3153 with SMTP id 5a478bee46e88-30ee1364aa7mr3098927eec.14.1782846229412;
        Tue, 30 Jun 2026 12:03:49 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm14963815eec.15.2026.06.30.12.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:03:49 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 00:32:47 +0530
Subject: [PATCH 5/9] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Shikra
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-shikra-upstream-v1-5-e1a721eb8943@oss.qualcomm.com>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782846191; l=4605;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=aTj5KtOb2vKiTmwN7SGIUjWosWnCNz+9xpIGl5k0Q6c=;
 b=ER7t5GpY8BCdpCJ5MWHClaDuV0E+hdJ/MSN/uvgkbK96tWDinblCHwJUS1wdTjtMfsTTnJaf6
 UydD3evw4f7DPopz5l5nKvZyaMOWwnzLerA4xCDfFwGdp2jHWv5xZVS
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a441316 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=iLgwJ6eFgLmkID89yw0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: kixhMZMdCWpsTgRThj-5pDYYkDGlHOy8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MyBTYWx0ZWRfX7l8hKnm4pRhr
 VJ5tvrgmINu3VwueQjWNZtEUdGIgUxKp1pfQMCLmU11MjbNejgm4JpQmIKmkQhVuK/H28m5dvbI
 UP2m2ta5bnJdqOZzjtCha1N9V8AGess=
X-Proofpoint-GUID: kixhMZMdCWpsTgRThj-5pDYYkDGlHOy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MyBTYWx0ZWRfX4kBhYGSYoUeI
 w3WrKvwG0P5K+/LYMG0zRJbzsbrEuWUxg8IshAZM1kXqCW2lC7u4ek3LF+zvEKIxS0++4eCWdTg
 zYuO+nLUMrsl/OEpsKXmhm1RjogVbXy4ak3M9vQGpROkz/aBDPqAstYOK6b0+9wHIN9/NPzFHwk
 7bec4U/YLR4XuiwxTjtNLDvQk9+sxkuGLkLGfp3xMtfMRNHpzGphBvo6/mkrw8WQ5v+KD61BSTw
 iH02InzNZI54cFlmcL9A2knX0KuEe/Zdu668L9YIvhqJkZLAXsmCJW9odn8nH6sTrD11Fcj3+9m
 QCL7f+wTBdJddnMczlLHKSjXTygCeiGJpHfk+Ar8I90BFsI/+7JgId6VMhNeXDYbHZP7cBYrniO
 COeDbKX/C6HSs8GUbH/WCsz23wazWYgxNvU9div3u2ZvD02ltORH2ieON3YcsJZh/+icOrlmion
 gFBRgJ/xh89gDiEmpiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300183

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

