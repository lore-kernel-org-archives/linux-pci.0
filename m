Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076A5581E9
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881371; cv=none; b=AM8OMnkM0+4vc849tZmvc37h13Wbv+gJsj8F2REpgfiRHDZoGLTVsjGdyqouCJZmGjmbXASnuKVwwqKmprftxNyL8GdY+Vv/dn1dOJmi73wSdcP9SJ9r5uu4hHavkQnnfZ2tBfPuIdWHDeguO8oMPUd7cM2SAK+xu0mLvMuhnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881371; c=relaxed/simple;
	bh=t6Z5sjaDxX6xGekJGOZPq41x3m5eNArj55TVt7VRYR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZE1aDZ7DCooO4AzUnog4lQWzJ0DmS/s479Vtvnz/k+0Txo8d99PT9+48w/+VhG/j2gJ3L/hTpQJz2zDknNp8ciuny42dwOVCKVq+sddZxcmh3kEywoRnydIP/zrc+WIzelCMkDKIAofxDgDU/drrEUUrHORWciGb5JtwET3mtSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NzNhWrCq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXpkbPF/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NzNhWrCq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXpkbPF/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FOkb02736071
	for <linux-pci@vger.kernel.org>; Tue, 8 Sep 2026 15:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z5SDhJCZBKrKqnQBt/dW/LAOkN1QohwQG3Wjy6HEB+M=; b=NzNhWrCqsxOFWoLX
	nNX6k8ViZ8KTFKXRX1lhbRhdg3YvjaU9KdJJ/VTKBKw3G9+72KvO5CYF0ANt+2pB
	rFbmJNM5VRNvyzD9RSobDxOa86rlgHI98rhaJNAndLXGuPoRVJWZ2y6jmRnW248A
	iSSO2+Rqn1UvqPP58t5vdbu11TMMzSGOZMTGhrVcyNcOIfD/tl3hxWJHFEplktCU
	H8pIPJF6bA3CldvhAWDGBVeYHIfQgER8ZETihjhDg56jnj1JkRcaSePEbuZCVFx3
	aYOcv4pyyHBM233F0zjLDmxGkeFbTqbrkXVdCVBTzd2c0VwLHzDPT0Uy3lz+XUU9
	gwB6JQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvugqmy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 15:29:15 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-73a8aba30a4so3976038137.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788881355; x=1789486155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5SDhJCZBKrKqnQBt/dW/LAOkN1QohwQG3Wjy6HEB+M=;
        b=hXpkbPF/3Avjxe4C5ZoRJLZLI4CNBC1Qff7WI2h2c8gOMqR40B0dikUH/ljw/wXvJ9
         b0+kMjzf1L4yELnUmnlC8TKYv3BVbi/xmW50OCt6QAFRqUEkG+yN1woik4tF71FwBxgX
         isSDPOdAjW7ihtRyQJnh+iPkQD+/lea8kqSoXMIxRkb09rFi9LJWne196I+3zZehjYnU
         /1PILNYx839n8A79pLtcnudbUavJ7+kiv2MqPw8hRQ0sfKen4ReKimBH973SyE+cjMjL
         BROPAXlP4E3IqFg1qf8nvfJ2oOL+SooIGkVd/ZmR2VTSckIQvSkv2Oap98a54P/TqWd8
         DZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881355; x=1789486155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z5SDhJCZBKrKqnQBt/dW/LAOkN1QohwQG3Wjy6HEB+M=;
        b=L99+hyX9dTELbXRDI5CL2nSuO0F6hRp8SqfWUCuxN2G5K0gsbJhF8Im6CMZygi4o9t
         N2Yq7r4UWgCHqMZav0vSlagwexIhtViRiYPTo03Tk6/lHna6pdhAt+UlBd+9MqIbYC3q
         HLeXDpiSQzkwiqPIJ6Dw606OS2BYyirEaOH9UC6SeY2dx/1CLdci3tUQwj2ZsUWOFN1n
         7Ucnu2BX5eapjP8w/kwOn9q5EuR3ifjWSwuXkNQlzfWbgoWVVAtmiyTklJfemthspOCU
         IYZkxw1UTWcIOyk+wgI0TLmtLB52OxPyWN257LZA8TpzCpEYxM7hCMUZzN9CpiJScvNg
         TXfA==
X-Forwarded-Encrypted: i=1; AKwUvBwh9kXRP8I04jC9/TTt35KdkSUrMlJPF/i62H62mNyFexw34TylhyoYoSjM+m/jRhlBt0cOhdqapKw=@vger.kernel.org
X-Gm-Message-State: AFuF++mvZTvix972S6DPLFDmYY8Va6KQr8iMALH73htqfuYuwmpBjtxW
	4vw5D/qdkc/BLZJob24jaj6V6lU8v7sriMprUsQMgYdKRvbn+Vctg1Sv7DIBOimmwK4/y5K6HOe
	Ojko3BUu5BhyTIxWIqaQM8/4pkEMGBpQpwgBJt4pCulVj4d/REcPFFua3i6BXlJQ=
X-Gm-Gg: AYBFou1a0BR2MPxW4DAGtHfQFTnys+P8+FGLYVEm9/XO4p/bFI8mh9vrPA5SP5Va1yG
	Dfucb4IFY4IDealNHqHI66oG998OAXj6UPdKwzv917QI/KQWy1rOHxCC8F7npjF7hg1cc7d6aZx
	cwQwaIT4lHqRoToSJnJMNswd34DQ/0xMF8zbEqx4N2FlJnbj8HKsKQcbaPCqlnBGtGGtC7A9l8f
	t8O/GbQcWvpGCQkNg8ZT3HPOymQ6EYigFW7/ELFFOt4AMPGrgNGYVPioRz6jEioNWo9kn+6Soz5
	pGxD3vcexu3zYu01ATXqib5J7p3BXCVMkoL8s6DyZjUBhGAefcDpgWHOCJZek9typKwQAWP8MBT
	w+jMUsjuL8B2AvA==
X-Received: by 2002:a05:6102:30c6:20b0:780:c9c:bfcd with SMTP id ada2fe7eead31-78a2f00e2a9mr6734445137.17.1788881354969;
        Tue, 08 Sep 2026 08:29:14 -0700 (PDT)
X-Received: by 2002:a05:6102:30c6:20b0:780:c9c:bfcd with SMTP id ada2fe7eead31-78a2f00e2a9mr6734419137.17.1788881354502;
        Tue, 08 Sep 2026 08:29:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce831af89sm338914105e9.1.2026.09.08.08.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:29:13 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 17:28:38 +0200
Subject: [PATCH v4 5/5] arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563
 embedded GPIO controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-pci-tc9563-aux-v4-5-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
In-Reply-To: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: vesiumeRwdeGbXu4HJBSTSeYdTbgl0Qy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX5ckwpXZplwHm
 YavmnALhGDNmx0eOOFACu6x/E1TJ3lRThVJQ+EOBbAbudf0gcg9/6ky00xUBmzkIt5J8wDRIz/4
 RJhbtbn0bNpUsi2ThlPUdjEfQaLKBOf82zurmPNll+5exVF1VhJtpYUqmjNPOviykVYdNSOJTQY
 PGlVaCXrGKdC5O1Rc05VzVTPxOFx4WJ58ik3QN2jh1NrXpOeiXvK2xwegxdri96RnHPUEZvIDg7
 ymoHk+8jyDZ+2GKlaUSqlJcLn/E636ACFK20kLIAf51demg8//VCbqojsPFZJVZk7AIyJJTWOIE
 7XKvD13wWuJ3lMACVxE+sMSaq4BGNaJtdh2DU4d31Ru6QzPlSsfrVTw6PAe1om3RVBUJQEypZoY
 16FhXstKKaSxJDPs/Sv/mXjOzRkjBnY2MlbIy2ncujWbFj4zM5kUarTwgX58C+Q9urazzWJpIs3
 KhFA2ocB1InF1FJ7hPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX3P0Ir9Xtu18y
 rlBlDITddU1brMjHnYxcNNtRPLyrBjPwDPXW6TGKvTdbgtOIHQYG+yd05MqMHN1ORkvyHsLWdj8
 7pf8zfCvztx5ySCMuvk9pV9YY3oZSRk=
X-Proofpoint-ORIG-GUID: vesiumeRwdeGbXu4HJBSTSeYdTbgl0Qy
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa029cb cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=kuerolza6ZzA2jZXMEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080167

The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
lines. The controller is registered as an auxiliary device by the TC9563
power controller driver and accessed through the same i2c device.

Describe the switch node itself as the embedded GPIO controller and us
it to drive the PERST# reset lines of the two external downstream port
(pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
switching to the GPIO descriptor API for per-port resets.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index a13315bf0fb0..4da7342ca90d 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -867,7 +867,7 @@ &pcie1_phy {
 &pcie1_port0 {
 	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
 
-	pcie@0,0 {
+	tc9563: pcie@0,0 {
 		compatible = "pci1179,0623";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		#address-cells = <3>;
@@ -891,6 +891,9 @@ pcie@0,0 {
 		pinctrl-0 = <&tc9563_resx_n>;
 		pinctrl-names = "default";
 
+		gpio-controller;
+		#gpio-cells = <2>;
+
 		pcie1_switch0_dsp1: pcie@1,0 {
 			reg = <0x20800 0x0 0x0 0x0 0x0>;
 			#address-cells = <3>;
@@ -899,6 +902,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
 			device_type = "pci";
 			ranges;
 			bus-range = <0x3 0xff>;
+			reset-gpios = <&tc9563 2 GPIO_ACTIVE_LOW>;
 		};
 
 		pcie@2,0 {
@@ -909,6 +913,7 @@ pcie@2,0 {
 			device_type = "pci";
 			ranges;
 			bus-range = <0x4 0xff>;
+			reset-gpios = <&tc9563 3 GPIO_ACTIVE_LOW>;
 
 			/* Renesas μPD720201 PCIe USB3.0 Host Controller */
 			usb-controller@0,0 {

-- 
2.55.0

