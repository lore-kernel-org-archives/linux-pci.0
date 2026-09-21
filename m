Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BE2BEC5F
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969059; cv=none; b=sjVaR1+K6gyDQccS38XgfSmRrIfmBM4OoCXPvEJK4VesudADeOdi7wc8a6WTy8WZ8YYG/9OLzCSz1C9mBIrq73Hjza0EblwfL72egWBxYIEB+kZ4ejnGkBm+ZvaGkcBgpbB9ckiYmR3nwl9ihbOt5yiE13Hu3yRTBl14zTsDLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969059; c=relaxed/simple;
	bh=5BpZafnsEX7T5i/WZquEyzAEe3ckLbNCfbpYPY2ev+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+qlVl8ZKebJsdqpNMNQdeecwh77RUKjMH44zTqFXr48/alcXuuuNJgWl9rJ8Vi2Iyz9mcwCmepSlgA5nnK5G3zkaXGNXzQGTtnbPPf2ruUb6DiTxEhv9RYsNd22OuRThFT5UHto0f4/Klr/psx/j/XcEqVMq+7GuSmGzf6yiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aeurDXbn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ISf+BSRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aeurDXbn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ISf+BSRI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L4JioX002401
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyK9v7BIQIUgn5FwyNENWCRWZneiieaKP064jjyjGUU=; b=aeurDXbn/MsKIUKG
	x+nG9cEN0ZgZobOkB6vuCeShjXipCEBH1vPWSq0ivDZ/xJ9KPenoHJJ/ICEFKMBG
	IySns310qB+bTCbdDXdkI4FiIqQVGp9FUq3Pu2hrAdBmeGow1Hz9wNKe4HFjZ1Ey
	/Qmulusbd6X+4s8STAHipPsV7bpJLmD+2E4PTxdMuOipYos1SAQUsJuxqLUjk9dt
	gVi3f+HNGyaRVs5sfeif3kglnX/V+VORTWVovlPtD/N3O5hKI+Vo4RdDV1cLHH5s
	x1TPpXK6qBuHt4RpfGOfmqngIJpjERY7uYXBCIqx75zZ51hTjyb99/dQ3b+7xvQG
	Q2AyOQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5g77k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc52c77089bso3938548a12.3
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 22:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789969053; x=1790573853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VyK9v7BIQIUgn5FwyNENWCRWZneiieaKP064jjyjGUU=;
        b=ISf+BSRItVRC66ijWKexQLogOgi+dWbUCWNiK2HkO8Ut4LLB5U++76pM4EclBlZ0TK
         o59aEf617Ho+C02ZtaByTDQ38LaAX/5i5S2Iuz2z/Tki6xszOmZBjIbinMTnOFUZWOMH
         h5XLNJQfmIWz2HKZgN6lyzXf3V4JEDqW8i0aDg5640oKMYbNJtKfpbBEmGe/KUu7qk/s
         z0/jMe3GoPiB4J/bduQ+2g2SDgZTMZfm4R4XE/l+IG4JtsE5j3UA9Hx0VDJWtTYySeG9
         JdzMl0pUv6VDtjxxzLD/XXU/nmQ18jBvkHEKjK8TNyS7j9LH4WaSZybPy7gkQ4Os8Kmd
         ouRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969053; x=1790573853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyK9v7BIQIUgn5FwyNENWCRWZneiieaKP064jjyjGUU=;
        b=1Oorxxi38bRBhxD0C8nbWSrEMiK9+/WfqUHpPjbPgcPp+NxKsXQb6jXCrVXKaZnDpY
         CZK93P8njpn8TrVM+SBbfSzaWox1/NloL3Y9CGuLFR07NPHr+Fc5mmzz3jBdS3kqxR0s
         ebFyhKr1I2DvMAt7TfIVDr2tifg6m8Z0SNOEAYPAg6WEPQQpaEK9ogAPw+Ltiq2QJGmD
         SEG+pOuYcbsMVUv//qkfAMU2CrrhLmI8QwSqW1zhF7jlVNm4AsbjfVgwHgc9SvoiC00X
         DAFcxin9kbcg8JaaDc8cwny6pOBUT2Qn2YVp/v5+VAaMqJV+Pe0tfOTTkMPwN3x0eKma
         aEvw==
X-Forwarded-Encrypted: i=1; AKwUvBwyFBlhcGiT6k2KM4ox5gZuLCeCymxyhK28tJ11zb+hLfQU3Zuwb9tuVmfLk93T6Ksj4+8QRHqV4Zg=@vger.kernel.org
X-Gm-Message-State: AFuF++lJIPFliL+xYUZat01kBApQt7FUhO+3lL+xxhelX5jtaCH4raKX
	0VPT/uRZOrHLIqo+7HVCpIbpVsg5vOXkIvC0P8xSMIdCuD33qrkcQojEd6nvhFLnoOwJ6fl2t2A
	sXVg0YVTUzLPaaVCq4J1XctU7FX5c0igLcfbwLFiVkluJFTajnHUfH+vWZYxh+1M=
X-Gm-Gg: AYBFou2ke9XF6VzdKK7uXiaNODTL+mxZZfq1F4+QB4mk5+qZXRUQbbu+DZsDBQC66eF
	DwFh/616ihtcr5uazBKoPvwWVUyZ4Dp2n3ELwJPR04uMSHtXXrBohkD7wipSesfxdKXEj7zhgTK
	ufHdyvxMPFebhAhDBCMQ3d6o/rdWKkMtLJaPrEOCCChTOCYmQqSXDB2OZkNwDwHh+oaYgmBzksU
	5stg6cnVzhFJq3kCkGcHuatH4XF6P6IMYp6lNzagbqfwzzJdPg9ij/KdD0CF2+PM9dBLzEv3W5j
	6o+u1eeoYaGSRP278fGXKW6GF4VQmrp0PPqWqShohkIIz1hX6mxsuvp77raAu7v+TT+5rP2mu/v
	Zrv06NC41tyl3CQkP8ylbqGegosadaBmLvQ==
X-Received: by 2002:a05:6a21:1f87:b0:3dd:a196:5397 with SMTP id adf61e73a8af0-3dda196546fmr10465699637.57.1789969053463;
        Sun, 20 Sep 2026 22:37:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f87:b0:3dd:a196:5397 with SMTP id adf61e73a8af0-3dda196546fmr10465682637.57.1789969053073;
        Sun, 20 Sep 2026 22:37:33 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55d45a6sm15054568c88.9.2026.09.20.22.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:37:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:07:10 +0530
Subject: [PATCH v4 2/6] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-nord-v4-2-ed05c6e09240@oss.qualcomm.com>
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
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789969033; l=1074;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5BpZafnsEX7T5i/WZquEyzAEe3ckLbNCfbpYPY2ev+A=;
 b=qPQQ33Qv1h2OpSHMvPj2DQlR2892pCG40LT8YpKZkA7jH2hgQunN5ZStmTproBsQ5lzbExt7N
 UP7aAnruBYRB7EelY2nyoVDQj4AKvIzAZKmTugIXGNa1KMKo9dwBH4h
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab0c2a0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=AUvBg9Asf6StguVY0UIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: FQ7aUPlNF9bHdxAyRu3WIOXiAOA27HrP
X-Proofpoint-ORIG-GUID: FQ7aUPlNF9bHdxAyRu3WIOXiAOA27HrP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfX788EB38iGkvp
 nRpnCMIy/bLsBLumaak/AWK7EMnsHfcDK09adEYXSfTQj+6eOTatRYS4+8VY2nh7vDfVahDe4As
 0eZMNMZvy7VlkTqXZMz+QGXkiwVgJ+Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfXySQvwVgzBGmx
 lkLmdLHNjUk5f0Lxw2X3LReGol8xyA/mtmWpn/jn3l6MAvV3Fq63B81EJPNzOS8eEVpzTNXLMi4
 aK7rA9wc8s65DYeDfpEpi/7E7LTRHpncYbV7dscst9dYIuSk58AksStV+IZCI6n9Uan5YKZBlgZ
 7svwsRa/5dUbtQn7ZNWGCEQwPN/4Syvs5PtKmCeY3KDXWoCduID17VGk8VFR0a4i8h8sRvi3xsv
 +gUHQ54KRs286lnZtwPshZEniD+Id3/nsxfixirqwQXFkIT1UNKGA8g8mwo66SOiV3a1l/FPznK
 ruRmJiYs6gaRzX/t3S23Gx80kFd2F5Xb+P0V+t4jsP32/YMRJRXUeXg+EIYS5SPDIGq9J49ncbT
 omgptna0Uzd0wYQN0R4TL8+PNZJfjJpClcNnLLJcgHG+AyG5bT2FRJB4tHfVi57smC+YbjxdlXG
 3FhjR+PONCP61loM52Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210078

Add the qcom,nord-pcie compatible string to the Qualcomm PCIe
controller binding.

The Nord PCIe controller is compatible with the SA8775P PCIe
controller implementation and reuses the same binding definition.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index 63630a814f28..b8ba2c4449b7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -20,6 +20,7 @@ properties:
       - const: qcom,pcie-sa8775p
       - items:
           - enum:
+              - qcom,nord-pcie
               - qcom,pcie-qcs8300
           - const: qcom,pcie-sa8775p
 

-- 
2.34.1

