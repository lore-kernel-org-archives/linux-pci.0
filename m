Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618826;
	b=1bi4sUutwrnaiM1IJZYPe+DbNvIB1HFYkZn79mZtX6Zh746TPnM4tnRbqfngvCfCRdEO
	 wfKyBFZmwvkFCLEaGBysIT7ez+cmBsqvYo7SzYAJPcfuSOAOgNoLJZOOKVHXxT32fOrhx
	 BcSSqNGWZ3dqNvc0sXeKJBJ0bmaxVKRxMkZoYxwv1mwIie4h2UjIY8Sz+S4IdrbXvMpBM
	 cXkOPKvDw31hlbSV3+hR26kPb/wQ+AX0dtdH/Kn+OliHbYwwgZClZzoY5mfeXMnd6LEGb
	 IYr7mvtYww5RENLtOFueZiIMrdUSHGNsMJY8ZKu6AZKRIFTKM6J+UslAqk4dG+YVGEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618826;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=B6QGHTbiKt0tsTxI6/Psf/ZbSXE1UseAZPqz6tlA+5g=;
	b=vt9IJ9B5Ltf7Hun+dmCs2bXhmS5IayKZWa7fUzSfXcmbFGKiGIU6R5g4T1Oemw/LWUOH
	 quvBPEGabVp1+tr+9FVDwLxaBIZuvHLD8ky9TGMFqccd2k97AQE61vvuKD79RNQuQwypc
	 jjTR0ZPBdP4xxh7o/7MNOrxlOddflV/xi1qGKzr7JjF5ay/2b26bSPgbJDzJxFKh1VHJ7
	 7AsMpM5gxt0Ooug8VupHNe2QAztFAWD/PJsQRdpnN9zpvnp4l+HYhhLUNmnYClo4bzBjp
	 bT4DMA7uCdbpovRbbMYwrGtaZdVmxw3KKYxYrm8HoJAoR10t8p2AOq1hbtml9KiD8UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MfRvvy5u;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FvdAK76H;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D73606A8B3
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D73606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MfRvvy5u;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FvdAK76H
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMbBI72193255
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B6QGHTbiKt0tsTxI6/Psf/ZbSXE1UseAZPqz6tlA+5g=; b=MfRvvy5udeIsF5tF
	3WfsknUOJgROwcaqYZ51gTUfVRF83ZzENP1SQTu6QIT9mGbLrkAmwXK6t/NYiio4
	ukkxq1JemCuhMkKbsa/SkdLwZ2BbPI6Zlogo0OmnoU5m9tAES69AxTDHRSGmfMlU
	SFF9p/sNS/pa+CL/p+uGeggwPTBWa2COxe3EwEMsL7B6QFCaherap9tJpou278m7
	1Jz0iyfbWmsJGX1BDDyithUyT7ClYjVnr8p6IPj4akP6sY5o+QAYFdryP1jLTMsd
	ThK4a7PM3uFGQzevfeW39Pm4hf0fMdaNk/yVfgRlnNhyDoiw+ph51o7qSVd7MA05
	qNtSzA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx87ds776-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2292479eec.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794618824; x=1795223624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6QGHTbiKt0tsTxI6/Psf/ZbSXE1UseAZPqz6tlA+5g=;
        b=FvdAK76HKgoeTYLnVt7dx8KPiGUOQHYDP3CtAB068J+VpYo4yG2wMXlYEQ5xgwZayw
         m2Lbmn+99p1ekOtrq9OnVf7+2XlB6ZSSIVujSVXIkHAp+KCERK5/1D6Nsenh6MJBCOU+
         SbmYisF5aEagWZqGAMMGAUEb4vBQ7EsQB9Yh/LUHCO39PTNOXERgAgiOiUaCFl06TZsU
         yYL9OP2evl1nlM/m0tTwNbfLpC/WUH+ZQf4WoGe6wVHjyM4hajb4fgYDGGhM1uuGgsFc
         SNmo9+cY6QBdkvzsKiNt/9gdN1AqVSQ3ESBWQyxUE1bxeBLoQGHC9CIk0OrBqVSy9xVw
         pudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618824; x=1795223624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6QGHTbiKt0tsTxI6/Psf/ZbSXE1UseAZPqz6tlA+5g=;
        b=PYUZh4mtJUlylzvL5m6ea0f5zeFz3T/OIjzEY7vWj0jR3HL8KeFQ4r0zYjYTf8+1sY
         KFBOM+EWgXORJMH+dY6WN9/f72xPSXpEPY+A0Yxc8EJYCIYgy44R0wM2fcOZEy4GxujH
         5LELCFPWRpNsVRZMACNeDh1eY2FoKZChR0JBUBhruMmE7xpZBiNHHCF5kkxdLD3MLckv
         kCqZmJMgcozKslp6yBrrNPrKbqGg1qlYEdCTn997T5wN/mbSwjozAwPDVS7wkqeIs1Jj
         M1QV0MyWSo9Hu5rxMsKh811GRbX5CHe5Mw9LNH9YsNNuiA6q8lAW6Q5VjRD/ZLIy9a3p
         PmcA==
X-Forwarded-Encrypted: i=1; AL+hErF3KoarYyDCguPzgFRjYg8bmc/fTyQZCe2w/pGlCsX3iFxBAFRayKk/gRnoCHhtn1P2CrapvXvTioE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dJG5jHrtE+UESL1gWzhk1jvbVUcVf9hxu2jIF1NF0UHMnV3gu
	ajxtJa2r0lIOsx3pQlOCdPImMIk2fASq6+Q/TzVAIowdAeSnkZXe6ixGnrzbYrJY44dpeFDJjBV
	tb2tYfmqK3QvAkTbua8JzeHQ9tNAUWmKzFdw/CBlcKecUduT/V+NKwMyW2LhmDCoBLD7U7to=
X-Gm-Gg: AYBFou3ML6qqUg+Qe27x17HxT60P9NpInYota121ZIYes148PlTnW/waIuYF4R+tT0V
	bub9Scasr0FZBCeDgrTq7cdKiZrIeB48/fQIRpe8KUQQcTbGRh2R6mh1JlYQ/jeGNXBJN9apFgt
	twgY0PnL/sCMV8+aVhd7n6ZKFfAH2mgFnXo1s56/WG6tyP/DS4APaZWbnYuxrJWWABZZUbSnKNc
	yrIfWO73DUeUFn0IWIonMRtitxAJ9Vd24qqB5jdjbOx1Jr11nBif3snJHDa62qNesdQG2AeYLkR
	T7eUjubVgmH4YeqfvsEaapysVxf44YWBq2xI+Mq7Q64TfR53fjcagPtNA1vAI8v+LIq8wUEOisi
	/vyLXyMumZc429GyxcxKgdzA6fyoNbiX1KwQPNs7IvuMBLKKEiWDCqZt4NYJ403pGs2SOT4IJoJ
	yRxeW+2caD
X-Received: by 2002:a05:7301:d185:b0:36b:fca0:80b3 with SMTP id 5a478bee46e88-37966961040mr4045023eec.22.1794618824288;
        Fri, 13 Nov 2026 17:13:44 -0800 (PST)
X-Received: by 2002:a05:7301:d185:b0:36b:fca0:80b3 with SMTP id 5a478bee46e88-37966961040mr4044989eec.22.1794618823719;
        Fri, 13 Nov 2026 17:13:43 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10952813eec.3.2026.11.13.17.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:13:43 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 06:43:07 +0530
Subject: [PATCH v3 5/6] arm64: qcom: monaco: Fix pcie1_phy compatible to
 list qcs8300 first
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
Message-Id: <20261114-monaco_ep-v3-5-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
In-Reply-To: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794618790; l=1159;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=zxS+46LvOuCqUZH6dROCss3FjAJ8EeURbIsga0w8/po=;
 b=zeu8POxTeEy82lD3VDgyQeiFY8IKN64oRX80O3Y4i+snxRCjKrU/EhOKhbIdETTKyhc7/Pz/V
 eJJ8oasipa7BNp0mxpXuIuLdaxZb7jk+NbLrDWPqjuna8HiTcKgWz4L
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfXwr6hzlvcmmoN
 Yq031ed50BRpFxvWBnHgjxdq4SnI22sTCUHTvnIk0KTF+bZ0TY55MV70I1yUOjOVoeOo3soQCWr
 nAJBx3CkSj7uhM5hlizvP2gGr3lpbLOY4TsxU0f89jfJXWC/z/SwZuAIs3RK0JPFJhf0lB7NF8a
 Rp7qGM8Gh0tN60Gv4lEUQinI+koy5o85lSbrLbUqR9jGNW/sbGXCF+u3S5511L8qp3o5Ay/N89Y
 d5PugPJsxSX2hwC6g9qs0Cxw9w4SfTnOfKDVHkoK4cWnWjRXoVb2m6FP/onA8KlsNaN4XyTPeC/
 fO20nOkArypsgNcl1JjeYlaNKtYuEv2ld7/WduBjkqtL5ogOTLmPgcQrpC5eosJo4Jj7tjVex1h
 ueoYp/qg/nCI+i06IQP2dR92FkUhrlyfzvUUA12R7QqAxMidSWnKDTFUSQbjU87vYOIIQIG7eg7
 5yJLwApKM4MF+kG+NvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX3oPtKFinabNJ
 PpYuahgPUEIDET57gLvnULMsdOyDCoZXoiu8ea4ysE6iY8cN+Z3b+sFI/iAdJasb6QdI/Za0S60
 /W5HESMt+uq/9I/CpghyY4ZmQfHoOXI=
X-Proofpoint-GUID: r4wGpwnL_ji5wigrwXr90UEjYimUHdo_
X-Authority-Analysis: v=2.4 cv=BusIUoX5 c=1 sm=1 tr=0 ts=6af7b5c9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: r4wGpwnL_ji5wigrwXr90UEjYimUHdo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140004

The existing pcie1_phy node only listed qcom,sa8775p-qmp-gen4x4-pcie-phy
compatible, since no QCS8300-specific compatible was documented for this
PHY at the time.

Now that qcom,qcs8300-qmp-gen4x4-pcie-phy is documented, list it first
with qcom,sa8775p-qmp-gen4x4-pcie-phy as its fallback, matching the
order used by the pcie0_ep and pcie1_ep nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 35fbee63d4c6..f27f0953ab9e 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2598,7 +2598,8 @@ pcieport1: pcie@0 {
 		};
 
 		pcie1_phy: phy@1c14000 {
-			compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
+			compatible = "qcom,qcs8300-qmp-gen4x4-pcie-phy",
+				     "qcom,sa8775p-qmp-gen4x4-pcie-phy";
 			reg = <0x0 0x01c14000 0x0 0x4000>;
 
 			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,

-- 
2.34.1

