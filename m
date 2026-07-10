Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891A253B58
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691454; cv=none; b=Vo45cLGPcMcGmPtaEesA8E+K4LDNU8kS5/jk1UyPlZSDUmuNy9Kmd4L55xlTs21GOKbFB+UtzyXlIdNhLN7OsjeutrodI0zGMvruxtxDas68xVwseLfI0FlvRYI+Jx++B8btfHzfDhvEIo8atxg0mNmz5z7jfKRkazsdgsdujqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691454; c=relaxed/simple;
	bh=xH1xh39y8K/9voN/rwyDLcQiZ84Qo7t4SMNVdhnEKJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rr+xa6OKvsem02NHfqh0jUdEzuB69PVkYQz4TyMc5BM9u9PxHFXNVvyXo2iWJOQFjCxNEObNJxR12AxNL/RyHO/X8Fq8PWqIFHzmijpgD2zU+Oi6HHNzndYM4+jVU5+dNiuDs5Iz/CHUVfc95ECvFVo6TD7O093XkPFpPRBzEsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMh3ys41; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hWfgvpZa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMh3ys41";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hWfgvpZa"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6keU823892
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6AIQxvcRx21RioxQhZDbiYJ1VNsBCw2h40lSC03Og18=; b=TMh3ys41KU3gbhm/
	vr+T7ySZQJvD7YOYzs+Bb5Sz9GUZPEo6JmxpQc09aLvo0+qi/kg6wgGHizmkStZM
	W6e7R2Mw7Vkd459x9ll99zW1qxDLZu3sXYRPJXV7XBz/uvMQ3nnZBRmS0D+e+I2u
	Mi72rS3Psl4VGTAC7/Qvpv6/J5B974DSuVlxrejFr2uvVc89wKUq+sbDkmYJTAqW
	iTxwITLqCQFRbmIhUgK9l1eGyQnH4Z3l9KGCpX4ZM5fzGDxQmekXg3nw6iNOSDL7
	rB/risaTQu8Tsq3e0KRAwqlKCEhFWeE42QrRk+REEL8aKlUxjYnV0/RuWIkISFyK
	GI5PwA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjcxr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:50:50 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97168e329a8so10299241.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783691450; x=1784296250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AIQxvcRx21RioxQhZDbiYJ1VNsBCw2h40lSC03Og18=;
        b=hWfgvpZaEwcd2gJE3dTYwt/dcDxQXGE/8ras/yVAkvnQaEYCuQsKDfiFEQmIzczytL
         mMGfZZp1wGZc1RZcQ8fFE6bDcvVB42phVH+9QTzEvMSxGzq0HJ34k4bCQrDXxGb2k7ca
         J43AhOMVeYd3xXIsJwo395EDzXI8/HOllIE9Mymzd0MjDhqxv/L6Y/x73U2u3Wh6aL2t
         TTb9fjM2Noh7sw2fFzfvFS5Q1sjW8Ae+9yRggI3bo7cwKdodGjXZI9OkWbcqyo3NTDlZ
         M+Bb490mFfqH/StILY6Tfbit0z4LUdfUF1l6B9azMBup2P7cAqV3X/BSKG6K/5nd+Y07
         qmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691450; x=1784296250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AIQxvcRx21RioxQhZDbiYJ1VNsBCw2h40lSC03Og18=;
        b=IfjLPk9eCOXEFGZeKAoGRAAtIk4IhXmv7fXWMM1GN8wdGok/0btDTRQvCNl0q/o5mh
         DJOV2HeB8RaCCEhadb6i0Lc/BSIHj6adeq+sNfJ2r8+9p3RHyyLThmFEn2gTm+gdDcA/
         tdFGpUzWZ9DfpliSvXxxk9p8aJSLZyJFUgNQl4L6WQWefeDqvUwCi7Q6n3dC0N0RvkKn
         JBJxdvYoEii2gHJ1eb27LumruBdYpni9I7doltlhSItj0poj5dZBzVbUBC3q0imM4EKz
         NNRl6hOGd/KanI4RCct3wjknTTg5sE8kAe4VrnApiPSrZ9/BfmOzz089aiUYl2262mt6
         +PfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrgugfr8ITX4KOeu1JxNbik4HQykAu9v261ddg7KeaILhgw/0//xfFGCW5xbn0SvsDwEpy85SlOWvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURoHT0rbZbMWiZYabaqwyByl7rJlHoIa3Vd8330lcxqsMdOX9
	76wTbf0YTgnyJ/0x9029QWOGaNN0vv02Zw5rAkm3vSfs5LLX/C0zhzlOSG1hzvKG9vuSSF9gTdI
	Ie+Ty75PIpjLQmsCsUzFLExeJFh3Y8tVdtJHaZ1hsiF2TLliBdcUFIiS6gpdfH8Q=
X-Gm-Gg: AfdE7cnBvwckdYJh5QdTjQCEyF1fbhrveh3baXQ2aCyhOY9I4WzYK2EE/EaxhBHHOs2
	3dwqrdTyU2IO9tr67/GydayqJn79+Y3097TmaxQejOpRafWeBSXhMr+KfdqWr8X3AeKTZEF6dsq
	Q+L0zWYm9B9SbCEb9cwRPyWslAY+sBym7HNSjR8elX10hw9R51zQDIR7uIW1YD7ZuPpj8QImQSa
	BHA/sX7+O5JrvAZwvzV/rafSug9o+w/W8icd/khPbdd3QN0OG9jZ8TSLveBJS/f9xLBhOt8wRLU
	/ZvOBgeeIwWJp++lLQ0W5lVv2HMIEMHXBFldLfQa5whMRWULxNupG86R0AR2hiS3yRVUKe2qc2M
	vsAd7vp2QIMmVHvp/AqYjiWQKhEpjDpgJFQg=
X-Received: by 2002:a05:6102:a4f:b0:73a:322d:1bb3 with SMTP id ada2fe7eead31-744f0ab5277mr2225545137.3.1783691445227;
        Fri, 10 Jul 2026 06:50:45 -0700 (PDT)
X-Received: by 2002:a05:6102:a4f:b0:73a:322d:1bb3 with SMTP id ada2fe7eead31-744f0ab5277mr2225535137.3.1783691444637;
        Fri, 10 Jul 2026 06:50:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca54e25sm615052e87.30.2026.07.10.06.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 06:50:43 -0700 (PDT)
Message-ID: <63643fc3-3a3b-4aef-96b4-de42498cf47b@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe
 M.2 Key E connector
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, mengshi.wu@oss.qualcomm.com
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNyBTYWx0ZWRfX3D9hsNZLqi4u
 gg3xV7dQa+g7HYtG0ZFFcQtaw97L4dhe+/4HbJ9dLodNYC3pY+G9kncPx+g1ltOyrdazP94ZDFa
 ytm7916A56oi3aMRjSkB9k4a8U0To3ZIMT1/Effx/4Auc4HsKjjkFZJAGj/quYma69yVXS8B6IM
 zVUezCk0q1Xq/bWfGmY6zmOskkckkcpeCkU1LYNyE6PwUrj6ItsN6es3pbubSLSPJFrbj5lYVId
 mgqHImlx+mFF+YDVLZg3XFVZec2oTq3TFmDXo0td4hoRGRvcZQ+FzDOOH95sXc/hHhoJR4vHzbi
 so3rjLTIK6UPf3oQg0X9YUGAzr37Lf8Mxt8T6cciUQ8DuaLwrnYOXSGuKgxExm2T43GNdBT2+Yy
 1oP6KTUlrwu3LzotSlavipv8yyXCpW+m+g1cyjqB2Mdfi2pkTAJEp3BJOmvaeharGBjdg1ZxnLb
 Hq9LbOZYyYSdA8Xi52Q==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50f8ba cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MVNNC7U5w37-LmZrIMoA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: wGIFSXJEFI6jhHmVlIKlY1BNyTaxYEpW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNyBTYWx0ZWRfX5wXvHUJMGPne
 hbc3+UdL/UZiEwFpOkNLdq9AR22bP3j01Tq390/ftpM+Z4CIGJbV1vt+BxJArjpAdMKHSJfCP8F
 4/xbLTWG0q5IzU3Es3MpJ+ldUWwBlLo=
X-Proofpoint-ORIG-GUID: wGIFSXJEFI6jhHmVlIKlY1BNyTaxYEpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100137

On 7/9/26 9:29 AM, Wei Deng wrote:
> The hamoa IoT EVK has the PCIe M.2 Mechanical Key E connector to
> connect wireless connectivity cards over PCIe and UART interfaces.
> Hence, describe the connector node, link it with the PCIe 4 Root Port
> node and replace the static BT serdev under UART14 and the
> chip-specific wifi@0 child node with graph port/endpoints, allowing
> the pwrseq-pcie-m2 driver to power the card and dynamically create
> the BT serdev device.
> 
> The M.2 Key E connector is powered by vreg_wcn_3p3. WLAN enable is
> controlled via W_DISABLE1# (GPIO117) and BT enable via W_DISABLE2#
> (GPIO116), both described as active-low GPIOs on the connector node.
> 
> Remove the chip-specific wcn7850-pmu node as the M.2 connector
> approach replaces the WCN7850-specific power sequencing with a
> chip-agnostic one managed by the pwrseq-pcie-m2 driver.
> 
> Also add 'compatible = "pciclass,0604"' to pcie4_port0 in hamoa.dtsi
> to allow the PCI subsystem to associate the DT node with the
> PCI-to-PCI bridge device.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---

[...]

> @@ -1025,19 +1004,10 @@ &pcie4_port0 {
>  	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
>  
> -	wifi@0 {
> -		compatible = "pci17cb,1107";
> -		reg = <0x10000 0x0 0x0 0x0 0x0>;
> -
> -		vddaon-supply = <&vreg_pmu_aon_0p59>;
> -		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> -		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> -		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> -		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> -		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> -		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
> -		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> -		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> +	port {
> +		pcie4port0_ep: endpoint {

"pcie4_port0_ep", please

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
