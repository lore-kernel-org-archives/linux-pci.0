Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5292526AB9
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954517; cv=none; b=PXud20+TFDJ3iucZL08CE7xEATWT7UJYcXwSwR1OlsX7qfM9Clg6KV2ktEFw0SdBMAxXgY0ihdz75w81mgBG7coDf/ZqJwfEp2JV+gaj9Ql598ho9Xzxo3PZqUCEKIPpMzddf4DBXoT9bHlbcbHndrUh3KsDcg8A1iLWu7s0jUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954517; c=relaxed/simple;
	bh=QOH9VKcTjY4fR2PU9QKFwEi3IrUNdtI6tTSaKUmMsSE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HMG0TX3yiv7liFeKw+WCKuIYtxZEVHJFEqFXYEpa1LUkxKbDJYAnY6FPnDXidYqA6cLQ3htWhVn9u3q2fIDmxACVKUNnmwtY0mkWK7vdnII4YQwuQgdCp3UUG5HaezcplKyD/WTVE6xZ6VgLFW3sBPZUwrcpNWKJLKQ3s34kVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c28PXU+9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zp2mu7zt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c28PXU+9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zp2mu7zt"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU6sg599754
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 11:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Mquv4bvtnPno64YDX0x59O
	34H98rzwKzFq0G//K2ahY=; b=c28PXU+9BHslQ80MzI50lJD6r16ZlkoABtsPeC
	7btrNYS4ihawUS2vMZpNXjg3CYrrICdbyFt5n2dAt2LIoE/3gy+cdFcCPcGrkbEF
	RNV6qMILYQI2Bk9OUD90SS2uXDMzOBo/5oUxikt+0jLv3Kgji+O+u7bxxvTjk6ZI
	vjis3Uotyvfk3lsUtpe4hdFwVhdEsPFpsjB4iR8fgXTAunPNMTCRLOwsx+WHm5Sn
	qxVSLp9C/h6KA/HzhzsBrANuzAHPner+eEfEy40cZSuc7QvbBplLnjI7xIgZt3A3
	utMAYcmXJxKrsuSOSBr4Ej+zFDn7aZTRQPFyK+g/zuU4H/lA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjywr1sav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 11:48:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39906175917so6918837a91.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788954514; x=1789559314; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mquv4bvtnPno64YDX0x59O34H98rzwKzFq0G//K2ahY=;
        b=Zp2mu7ztCeBQp9X2oP5KsU8kn0n5DXpjtkqcbuXNBzmh6ePrrZ/Lb/JG7xtPHPXjlE
         rrbSauVhr/Huav0vhZ2jSL+SbDMWtr6eoCkM2WLHz+M7T2ms9JBLwzMewnjB1yHkUQEv
         OSJvycC+CKyJYi7ScutujS0aIPac/ukuLl2WeOQdxnfwQv7O5pkMM2Hzbec6t5VfalU+
         q8iGRHmldsWYQA6UVNNAPp9x0JBGj/DKbl0Dl/BaN/XYEXYWgOpgV/on39YryWN191wv
         NQlRd2TIZ2afOHn0WOBteS3BGy7j17rkxjQzCBSNUoxVbP/8SZ2VNddxQHJHV+j0pXNe
         Pzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954514; x=1789559314;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mquv4bvtnPno64YDX0x59O34H98rzwKzFq0G//K2ahY=;
        b=kml3f4iLZ8sNZ1Z+mdfAyBnPLuq0s1Yjourar/Xn0YuxlV4unMJVI4tGTJV8vJCdz+
         1OU79sgnTqdOxnzonJlVvhwmwzjIj9PrrKLIJc3ztULNfGnNrheP3lmT7WIaT+Po2L5Y
         I0bA8W+4H4euZqe0h3mgAbFukBT2A4tGeRoIXXUtWQ/OiOrkSmTNzPFDfGhWNmnQi2dm
         BYbcj80iQeanUF84Y0bJoQD8yWx3g7BXmn43hpmPg9av7Ro2moNGNktYAKQZ+KatEh+U
         d6vD+Y1iXizqGngcNbtO9s2DJOaUjSGyRlyS5enFNjZSx9Y32MV3xi1hrse//4CL4JR+
         dd7w==
X-Forwarded-Encrypted: i=1; AKwUvBxh2tsO7H4xvFx214rGCrcb4r+DLrg3celaigITVnckpKoK9DrUGf2vRkLBk9kglT807X9bkRY0MS0=@vger.kernel.org
X-Gm-Message-State: AFuF++mDZXpsantiO9a5LBvUmHf8g05YtMcVfbwIDKvzzkWmZl48rJtc
	/VXdcHEwyIAxF8KAmJtvm1ygSZkvIMUKjR43FLb++oSwgCGqPl68LAgMdLfb99N0gCreyx5Jcpb
	UV7nwSZErLXrvQ+M4+FHZn0n/scR6Sh4R2sE4kngsArcysWW46ovPc0B41V7UcEA=
X-Gm-Gg: AYBFou0nbtR7Gq2I+XNN7AEHC2HmE/gvZKn+i2r0Usmo/rvuIpswNkIxGuG0vz9mySc
	GIVGzVdU17tGLlMFvWahvks2yJKZqGojXF1f7AbrGb9th7QPxxTFr1eI/06F7w9gQCefhAfLG0m
	ya8BkhuT5mwO3gFcBEYrcqk7psOXl9ld4FEAmhZo7zmtFbzvD/8p5vA2DL1mIg6p+R24JRpSV7Y
	M7VS9HeNpVf6naYhk7OrGAUaEX2F34xWWWi0/rn8/GimExIk2aPB0fgZI71y1WZxOccYVSRiJH1
	uLMALiELUO9mU2yv4cMc0dJ2FXeEBK1UvtA9eXqH5/CiSPLC1c/wZoOXymzgBFUrKzQudSLBEpM
	K3wH5yM69xWDA89Jot1uPsVupae1fPOjimOA=
X-Received: by 2002:a17:90b:2d07:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-39b262abd26mr51142932a91.25.1788954514267;
        Wed, 09 Sep 2026 04:48:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2d07:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-39b262abd26mr51142876a91.25.1788954513683;
        Wed, 09 Sep 2026 04:48:33 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm50156857eec.21.2026.09.09.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:48:33 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/5] Add PCIe support for Qualcomm Nord platform
Date: Wed, 09 Sep 2026 17:18:15 +0530
Message-Id: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH9HoWoC/22OSw6CMBRFt0I6tqQt0I8j92EcUNpKjVJtgWgIe
 7cFBiQ6eclN7jn3TSBob3UAx2wCXo82WNfFUBwy0LR1d9XQqpgBQYQijhHsnFewpJgjYbCqag1
 i9em1se9Fc76sOQzypps+sanR2tA7/1l2Rpx6m5KUq3LEEEFBhSwYk4gVxcmFkL+G+t64xyOPJ
 2k2ptoxrEHEEMkZrepfJn0zkv0e31gSWcylqYTCQlHzh53n+QsrnqtZIQEAAA==
X-Change-ID: 20260810-nord-461809f1d5ae
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
        linux-pci@vger.kernel.org, shengchao.guo@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788954507; l=4014;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=QOH9VKcTjY4fR2PU9QKFwEi3IrUNdtI6tTSaKUmMsSE=;
 b=auKGTwrVv5IN7itNtVlGJ1e8h5srMRxNRaR4A0lEnaQrxsFjIB3M/XkPmP3CFE1mOItWGseV9
 LouQTPgNx61AkZAiSmXHVZ/ulkKoCvm/xdTjk0yknOiZrgOO3xhEO+K
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=a4YAM0SF c=1 sm=1 tr=0 ts=6aa14793 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=1XWaLZrsAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=_HC7VgZuvUK4spJUPywA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX4VugE3kjWqfS
 k7iZGoQPyOC+YWSOcZWWtd/haDINl0R0hJ4aWWVH4jGNa/EcP7SOZU+BHMc4x5ZU6hJiq/Gk8q1
 fq5b1KnYS4Rg8Y3pUIWMMPonFVQDmf5mTkJUoCYyBc6ZQAFIy8ViMMnjN/s4doM1lemjR2eoSho
 MRmNwgjbbXDcKbXMPPcErU9uc/9akrzBq/mB+nDiPz/j8DBBRB8nrnk/cRNVXw/sXAW2I3rdqA/
 g3cWm8OmLHxSrToiOdhgvPYXXDH59pp1neFies86e2/Mb+KNljpSUhCtXYXWbl5yzVz+3naRbPT
 T7ArJhYOk0pi4xESYGG7oahYtrOWRdyFKqv4dFdrnbBgHrG8rSzVNYkzsieCw7g6mVq2N9+WJKu
 jvcrI0pE89a/xwQkCIidTezcd7SfnNegcuR9EvL8Qs9ozeSP2oL17O+FrXVZLSt9c8SFy8BN544
 CXUZfLOApMO5c3ai7fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX65ZoGRF6uHmz
 pH+Eowyq3RXBM1ORkgwUiYIp9xp6j4khpZSmxTyvO95FUogD7j4KDAYFh9EhIKZgb36xBLkP2aV
 xi8jfjlwXfVjvoSuICnrPcUu+afiQH4=
X-Proofpoint-ORIG-GUID: xubqC-wyn2OQszJ9HVdLfwL59UvpZmTw
X-Proofpoint-GUID: xubqC-wyn2OQszJ9HVdLfwL59UvpZmTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090131

This series adds PCIe support for the Qualcomm Nord (SA8797P) platform.

Nord has a single Gen5-capable QMP PCIe PHY block split into four
independently-clocked and independently-resettable ports (A/B/C/D).
Firmware selects the active lane topology at boot via a TCSR
configuration register, and the same PHY block can appear as a single
x16 port, x8+x8, x8+x4+x4, or x8+x4+x2+x2 depending on that mode. This
is similar in spirit to the Glymur multi-PHY support already posted,
except Nord's PHY registers are programmed by Linux rather than by
firmware, so this series adds the PLL, TXRXZ, PCS and PCS-lane init
tables along with the power-up/power-down/soft-reset sequencing needed
to bring each port up.

The series also documents and wires up the qcom,nord-pcie compatible
(reusing the existing SA8775P PCIe controller binding), and adds a
CORE_CLK_CGC_DIS/AUX_PWR_DET workaround required to avoid a timing
convergence issue in the PCIe power domain.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
To: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: shengchao.guo@oss.qualcomm.com

---
Changes in v3:
- change the name to quadfurcated phy (Konrad).
- remove min items and change clocks order (Krzysztof).
- Factor out the common config and create overlays & try to use common
  symbols for glymur and nord (Konrad).
- create  qphy_setbit and qphy_clrbit (Qiang Yu).
- and in qmp_pcie_exit() apply settings only when nocsr is present (Qiang Yu).
- Link to v2: https://patch.msgid.link/20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com

Changes in v2:
- Fix dtbinding errors (Krzysztof)
- Link to v1: https://patch.msgid.link/20260825-nord-v1-0-7c02f2b8765a@oss.qualcomm.com

---
Krishna Chaitanya Chundru (5):
      dt-bindings: phy: qcom: add Nord QMP PCIe PHY binding
      dt-bindings: pci: qcom: add Nord PCIe controller compatible
      PCI: qcom: Add CGC disable workaround for Nord PCIe
      phy: qcom: qmp: Move qphy_setbits/clrbits/checkbits to common header
      phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe multi-PHY support

 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml |   1 +
 .../phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml        | 272 ++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |  16 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  24 -
 drivers/phy/qualcomm/phy-qcom-qmp-common.h         |  32 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   |  24 -
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 938 +++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  32 -
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h |  56 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h      |  14 +
 .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |  94 +++
 .../phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h        | 194 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |  24 -
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  24 -
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           |  24 -
 15 files changed, 1543 insertions(+), 226 deletions(-)
---
base-commit: 1550287484d29e68055ae4acf52d9324835ef9c1
change-id: 20260810-nord-461809f1d5ae

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

