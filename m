Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254251;
	b=inCxh5cLE15dEBSnqEKhe5rbkPK1245INXH321Dr7+Bk0LhPkmY2Jm0gnkg9duM1PuLJ
	 uxLmLhuzMOroxJL63fknx7cxTcQ9EPNRoEg0C7W6DbURv70MMiuZtgptPiE3QWPB6FCqY
	 KQgwtf0vFb5XkarrdozikzZeOEgm4cB+qpeBjalr5Ildbw9CipuDFHni6/jKYejOQYO+h
	 7hbnGGmf93YKhzkoMI1abVX8tO6+IODnbk8Gg3i6ASY/yS5zaZt0LORbolCeaFGPtWbxr
	 XYpFmkjgLTnSiz5/b6/lJse528nzb8wYNE1tJtdNOOUHtFT+FLaQmyTgNVvCG/bXHPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VyK9v7BIQIUgn5FwyNENWCRWZneiieaKP064jjyjGUU=;
	b=pTLYbwOek0VS2pVQsZO7cQ/COHuh01AiR18sLi0zgSkVydyAE5M2Ypqg7GHHIkmJ1qAV
	 9cxJpqNFt5oID5McCDaOhEMxqaDRZH37J0Hj2ny6E45VRXH0elr+1u9QruT0qrfD3ij8f
	 NrCytq43aiLrPd0lKogNgsJYBksoDSM6DMbvuFHvI7/Em5L6HTC880A0ZiHrUm7flUlpC
	 PP93Qat2n5rZ7UIZhd0BfGFJaM/h6WJPTguBuR5eQpDj1UaGOIRQYOtJOjPu98C9bxEH8
	 E0xGti35LHEY45uhmi0T6B5XfVE9yjnt4qQBxD3U8VZxKSaSs9xhR83RKSSN7OhTNhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="LbY/wECG";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hz7VUGyy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19074606A31F
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 06:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19074606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LbY/wECG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hz7VUGyy
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5GomP3341043
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 06:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyK9v7BIQIUgn5FwyNENWCRWZneiieaKP064jjyjGUU=; b=LbY/wECGN1KdvcIi
	nOYfp4s9bizNGS9J8YYIPp3wLTVAK7e4pr4qQlovNW266Kzyh6hnUE0+4B2zmZXK
	4pirrCJLei4UsZP7fBj8r/AjiNioL5Rz+yD5x3mOGo1fTfHvUrwU/l8AaPzepwr8
	3D7Vr17MKc45so0DqI8Du2/FAFXSIRDyKPLflyIMZ2fV4NwyvealP1fITW5liNn5
	NeGtYm3HFL4UcQEIegs9IFTuZBEzPGaTqI71CZRv1KiyYMbT7Arr7whc5hBKjPa7
	PbO79QoUJAuKESXOfKZ7SYbMAthmUNxra0jnD+4mDGTP1GedC2ZmA/YurZGQV2PV
	3zH7DA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3gy9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 06:10:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so3598888eec.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 23:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793254250; x=1793859050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VyK9v7BIQIUgn5FwyNENWCRWZneiieaKP064jjyjGUU=;
        b=hz7VUGyyvyXqlFxX9wMnDWWThD38tUAEQ4Tn66zocGOkiJ4yqnEZ2ZfyKbfbvsmHoZ
         C1PsU47rAOhdD8tr6+buJxg8BzXEECeAL8Saacq3weGiupxPbLlHVwzyAPyOAGJMgqde
         khIdAEAKYGoAZz8ZlgGAhhAcqfDMKtLsX9VwiLWnDOp9V6rAI7GO7TCoHPyVflUAIpeN
         gGyF3mgFIgQgecxQJMvGtqxFvsBdSfKXPs0wtfH3KI16f0vpeaYpg/+XWO7TEGw9LXRH
         t/YwbZkkzmoMsAL4nnEebbzv8UipeC85Jxngqk2zKHXDh//ZTOAPjSn6v3Y1UQyJ5Rnh
         rMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254250; x=1793859050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyK9v7BIQIUgn5FwyNENWCRWZneiieaKP064jjyjGUU=;
        b=G7HiV02gEmqTmnQyu+Y++pZNh0kbutd5tfFO6P0ctBY/SnAyb793sPrckujVVMCuon
         PW21vZgq7lqXrxG7P+ziC4h/wXgIS8YQLbjhpIgn3MS1zNOEtAFTfAL/gZxLTMfS9ZZv
         EvaSrJG40XwYKiNGJqTvx1Ic4VQnHMJLqlmdNFAZDgxOhHw33dNVosOw0wkpUzIcZ+Bw
         BNky+kLLGHr3TusrIXdEbLGf4RarL2td/JWPqrNbmUTRvgRIAa/33hUQNZeJKk1MvRyu
         PhqFO510mz/6WKe6WmmqNXT9CFnanGRScXSiFIRQYS1BApbfixetkOAW7f0dVi5EBZcg
         JidQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsrYz9L/ZBmRHm2alI2Xf5QIoIYl35xY8z0KnShuHVwwq33jmKsZushFR32mFmR8b5CLFpIEvcxWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKPFQs5+a5m934b7i2p/CqWN14kYz3u7+pLKzzujTf3VtqIhmx
	uZfC2+KEIOiIn5Q3xoVeEaOoxJdwBJ0TviUMEq/WBjxaCpdSmNZI+SbmRs2EnZq/xBwjFq9uTZQ
	UPvG4IiOBE84h5ekR9CMXGl3ddHSPSQfMHtGxnqej2hIYtDLm+Q8glbF/asuSPqc=
X-Gm-Gg: AYBFou0XREoLydq059SfAFzhQOape5SXFSjdX2uIwZz4ULewxP4KC7sVuO6zHR/3hDx
	fc7IfQntOQlnKlSDjQA6LjaV38J3U1/YQbBNYMtdb0BKWLIw23PTF/k4hQSFszkpypUm4KCu64G
	0SyJqXpdtoyVyQA8Wp8w3JBQ0gs/zbl1zx/SM13MNlFAYKfiGduDyphHLXBzoyk1LVr5clzNhPk
	DatVkyA3xcgMBE1vWEtZ3Zz5/0xAMcCU2J0Le7ifcXcRxJl+s3KjltcuRNDI3sldumMTwojRaz2
	1eKlEVpy8bLK7Cy5UbX2L8RS8IJhygBjOnOVBxc5dLzcYEvZG0JugXrso76oUDQn7a50yyI5Ge0
	Gr253uHRB+gJNjV3qvo+zikrck3gWEfPSTFgintmkPZ19PIbjxUaAxtniNDkOSuCutnUrnQfphe
	RxX6uE2w0=
X-Received: by 2002:a05:7301:1a08:b0:36a:dbb:2607 with SMTP id 5a478bee46e88-36a203ba789mr5853260eec.23.1793254249673;
        Wed, 28 Oct 2026 23:10:49 -0700 (PDT)
X-Received: by 2002:a05:7301:1a08:b0:36a:dbb:2607 with SMTP id 5a478bee46e88-36a203ba789mr5853211eec.23.1793254248817;
        Wed, 28 Oct 2026 23:10:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239a2e29sm14038935eec.26.2026.10.28.23.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:10:48 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:40:16 +0530
Subject: [PATCH v5 1/2] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
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
Message-Id: <20261029-nord-v5-1-1a13c214e89d@oss.qualcomm.com>
References: <20261029-nord-v5-0-1a13c214e89d@oss.qualcomm.com>
In-Reply-To: <20261029-nord-v5-0-1a13c214e89d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793254236; l=1074;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5BpZafnsEX7T5i/WZquEyzAEe3ckLbNCfbpYPY2ev+A=;
 b=9/mtuPRHFjU9hftDlwFyl98mTojHjainBfGm9kDBYc3t+dgIKw/cai9hgOJEcUbaRVe05SckT
 /rPArPfRimAB4bsDcsiBYz8BUs5ieEvmn7qezfChXhAgp3aj7cTw/tm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMyBTYWx0ZWRfX8s0Gz/W1E4Oe
 qAHww/yzuKfPqDAalac2cy92ixzem6+5J78fF3N3SRsrpn09uUfw7d0r49oR6QQw1nv78c+12OW
 iN90H2q9Xt3ZaDOGu93wouwHepU5qn8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMyBTYWx0ZWRfX5wWDOhLX8FGi
 3Q7qkLDES5ozI1kkwKjO++BcLGNXqbKM+S/xHXiiwPq4+lIeqvl3Fc5RxwTidlwiSh8IhgjSh0l
 Tn8bW5VIS8M7lLQWdDMJMy2qtAJPZ9JtXs93YPnAEYeDS0b/nKhxHjoLiNSMZtm79kVMq7TAnk9
 q/fNcmaCKl1Z6coul9VKLSawmnsi9LOFwRWrGl69he5EIU8jEfpX0JAejIQpv+KYHfP0gTYlmwp
 /Yty0rwVb3ajJiOoGLcx2uRMF5MmqcQEsUiewdY4FJF1+vuhE8v456D2R4yb1KEB2/xmEbU4GPK
 lKmIli2+83mkRyMESnfrXRmamx7vqAq80fwK1REAYli2aKWgFZSaumGXXVPb5YIysMeTIxLT6TI
 a+Bkw/T+p3/ikzbEnhzh/24q0FWE8jyZmsQnnEP3PibMxWRgjoqlo4RA4mvions4naotTb7lIIC
 gMeV2FZCZVLoA38OJ9Q==
X-Proofpoint-ORIG-GUID: qt7Fnj2mWS3x2Xql_oaFFIGBSBobp0rc
X-Proofpoint-GUID: qt7Fnj2mWS3x2Xql_oaFFIGBSBobp0rc
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae2e36a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=AUvBg9Asf6StguVY0UIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290023

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

