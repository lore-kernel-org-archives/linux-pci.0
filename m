Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574B41A551
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422033; cv=none; b=dm0TQv47oAPMG/Uu0EeZsTkg30uTXtwpGLeSF6aIPdoL0Sp+9XQELBxEby16N+mbiJOgoqf5Er4J+CcFKRPXbpqpB3vJmvP2K70YRsdVq17E4wmUJgcAPbvZkADGkAtHRJciLbFes5JJIKBq4Nuo7PxnEGxXtOiBi6x3MwdrbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422033; c=relaxed/simple;
	bh=at32knaWNCI4MK+ZgXm4viSmUtWJZmXLxN5xEjZMDrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRd0/48NQlX2ZpnMbvEiPmYW9DILp6lP3NLUN77qftEsH25UArfgbiDXSN1bzhL2Cnqa15OcPYefPRaGgTu4hBrgyVqRilJnUJp/CCmZs2t7JWFMw8eQPX13Y2JiqocbZ8RVDtEK7bIQeOxEUX+ndv/u04kDNjtIxIcmJvg9hYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAkQ9M/q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E+ldrj9J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAkQ9M/q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+ldrj9J"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835leEq3176916
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 07:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wibuWzN+1YhKv9Jd4E2FJsvoSQMxMG2ONq6pDF3AqKk=; b=RAkQ9M/qq2IXHG3+
	2KZzDBRG3DZkXBdKPgxqERg+lz12EkQewnCTwTCbRmezsMYATCNKELiM81WKCLvY
	jJ35JldVfdPpSEy1yXhsO4JPu3wfEiWY4h2JkQQMjFlpQ7FvSP9s4Riz9cJz8sLl
	33dwyRyzQwBXsKTOxRlKLISlE5+yoGLfckys5bCOG2kUREE2TZa7KMtkdeqwT4ic
	EP7zSCB3d+FOdXv1aL+5sjDEnva/SvXlJ+0l2l4vA2kVXCrf+riNKPvtsFMVLBWn
	tVIBxs6E+A/y9/t7vFKrQFxwsSRkANsit6ePbyIyHV5P767z5HDOP2p53jEk7JRq
	2y9Chg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4v5hr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:53:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939281526e1so108144185a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788422030; x=1789026830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wibuWzN+1YhKv9Jd4E2FJsvoSQMxMG2ONq6pDF3AqKk=;
        b=E+ldrj9JlaA2lkATL/8lOT/yfntBWRlrhbaqn2R8pMm9oUpEJeaLjpq8gJm6/sDjHa
         TZIJ2LiV2qr4wU8ukhKFTbN1kCqz1iu1f7/5Khc606rHn3yoZu8dXBWLtNGs9+NdqZ8i
         NdUYP2yexbbgEzrkbYzYrZ07dMwIkTLC3EjO2/lQrKSDTNLgWZ5OGGt2d9n9gt1PF2KR
         dEiIwV8k4nENwZ0Sg7uzPy+tuwFCrRTEe0gR7QYU7FQjN7tlYRIMjanvsTR1Pb+1XTU0
         3aETSLi/UdVhGXKgWTsQkCY3eHRSLHIbUqAUX4tEw/StuWNjapv9uYOsGk7JfGoGS4XW
         fc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422030; x=1789026830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wibuWzN+1YhKv9Jd4E2FJsvoSQMxMG2ONq6pDF3AqKk=;
        b=MhBFgZaTqsok5QVDKadm6GxlT3RHoyd1PrMhVjFqNYaOhSkfSzQ973Hse5ATEM1jJq
         lUJ/yqNEui4a2tMkNwZfd9oQC7ETZFEKf7iiyid6SROd1OcphCgcblDZ9FQpwkUR6vYI
         +4N4evhjHY4hCkl8QeRajKSs7Zl91bR9mBrYrhzGhc+K4sFU/fqH3j5e3hyUh9j2xuaX
         HqvYeeHP5RRF2sBO8fQnpXmSWhYQOW7r/BNwrUQmJqB0WjmI5R81E4ZwMMh8YDZp6KoM
         8bcbk2WOlpanplO7jhBJs9q60zZs+X8uxJnU2MjiWDkRetw52ZwcuqUsqyAPkT0Sf85b
         WzGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKGoZ9tDauavOhwkhmB9G3YLWbdVyQdaSa+ptcO1EnCdd7Ae6uCegqR07WBACE+g7r/0XO2KF/iWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kXOBnA6OmDVeNGbH4RGhQPi8ms98c/7Ib4Wk2uQxKmHZLtjR6s
	A6tiijbWhiK3Xo89BYTFX+OHnhSO7A9JFfhXEc3zm1Cm3BjYBYK2sl0OzLO8K9ytSCrHh8z7J+V
	Ah6eqofd0cJWgm2wJXaU9NUuRS7/XYkOW8Uuu5Q3J9GvtlhFHI4ieqN9p1MnslKk=
X-Gm-Gg: AYBFou1SVpBKPcZyFF7V+kxhfQy1/YwpuCmDbd9N2fmiupgSWDs3NyqdP5rn9oesznf
	GvequatoB8rgqGnPivHeUBh8xlRsuN5r3UhUXm1MMCZA0AZbmcU+STl+UmNynqPX8jIHksXTqM8
	Ky8OQ7dcdQd8VNWfswbjtFjy5XurWz3uQL5BQiNkFCoyNL0QfoWv2e+4U+fY+5KF9yMHyyxoxQy
	drTfFZzbPPJ1c49bTdDrGkY87j2JuPg3sp1pYmEB+s08K8atbE4YGyA+HDoEXpYLm3lDZjORLp/
	LoUst+AOd11ygXI9XgdAiXYlr4wPMWwnQYt3XW9xgy+VYuh8sq7PrbAHaBK5tWS7RNFylaVAzAY
	KbpLaGbM+lVqthA==
X-Received: by 2002:a05:620a:45:b0:939:2d77:d6a8 with SMTP id af79cd13be357-93960f88048mr1029253885a.34.1788422029733;
        Thu, 03 Sep 2026 00:53:49 -0700 (PDT)
X-Received: by 2002:a05:620a:45:b0:939:2d77:d6a8 with SMTP id af79cd13be357-93960f88048mr1029235785a.34.1788422024450;
        Thu, 03 Sep 2026 00:53:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm13415622f8f.14.2026.09.03.00.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:53:43 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 09:53:01 +0200
Subject: [PATCH v2 5/5] arm64: dts: qcom: qcs6490-rb3gen2: enable TC9563
 embedded GPIO controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-pci-tc9563-aux-v2-5-34c625b542c1@oss.qualcomm.com>
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
In-Reply-To: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX4LNgvaWHAwIi
 iFqDoL7Bv4m7jDREqP59dSkNO+WNBhy3HKyLz/h52oFjeU72RpxFep5YPcV2w+yf2pnAyhCwv4c
 +pNkwzd6AJHmF/NA/mO0tsRXZcHkiZUVYbt2hErgPHIx33B/m4jBFvfk8EEKMMJLg63GxT4ChJS
 Kk0ApT6t51QSi01uC7QfJHXIMyf0b4C50gjrXboyHe9BcbH2IImOvFBZMHU/bO3e3o4udcgJ+LV
 pvC9K3zqBaCVuqqjGm/rWC/Lu/mCeMBxZzh9MbNwsTIurVr37nf9Cmqm0rO8IpaSeByXMbLFGef
 y/nsix05jGn2jMmnZi8NrnhI1IEuAR9THXZqC0Ln4g6ry8mWItbH3z4h2pxU1tSQdw9Flpc8fOJ
 irTesoMRnW3MsgkI0nmUN6dgIJhubPAJ58+8I1ditbyH65QIxIn6Ip8/4CLMb0sYBz+QpMuu2Pa
 W7Rg6+n2YScQ6buML+A==
X-Proofpoint-ORIG-GUID: 6byKGlMm6mC9QmeSbPyj1nRMKZyiTNU_
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a99278e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=eJG0Ch9LUBsamovDncMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 6byKGlMm6mC9QmeSbPyj1nRMKZyiTNU_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfXyvFgQEciTbJx
 Fg9XnbHVUG2Rbr4ZyuhZkwt6BS29QLNxKNrVdtqieOS665HG1nNHlgl98Rls3maggg3w8ehZNWN
 kOnafbJyioxSIIoZBdYY9a/I54fQkvE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030069

The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
lines.
The controller is registered as an auxiliary device by the TC9563 power
controller and accessed through the same i2c device.
Describe the controller as a "gpio" child node of the switch and use it
to control the PERST# reset lines of the two external downstream ports
(pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
switching to the GPIO descriptor API for per-port resets.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index a13315bf0fb0..8670c4243b10 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -891,6 +891,11 @@ pcie@0,0 {
 		pinctrl-0 = <&tc9563_resx_n>;
 		pinctrl-names = "default";
 
+		tc9563_gpio0: gpio {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		pcie1_switch0_dsp1: pcie@1,0 {
 			reg = <0x20800 0x0 0x0 0x0 0x0>;
 			#address-cells = <3>;
@@ -899,6 +904,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
 			device_type = "pci";
 			ranges;
 			bus-range = <0x3 0xff>;
+			reset-gpios = <&tc9563_gpio0 2 GPIO_ACTIVE_LOW>;
 		};
 
 		pcie@2,0 {
@@ -909,6 +915,7 @@ pcie@2,0 {
 			device_type = "pci";
 			ranges;
 			bus-range = <0x4 0xff>;
+			reset-gpios = <&tc9563_gpio0 3 GPIO_ACTIVE_LOW>;
 
 			/* Renesas μPD720201 PCIe USB3.0 Host Controller */
 			usb-controller@0,0 {

-- 
2.55.0

