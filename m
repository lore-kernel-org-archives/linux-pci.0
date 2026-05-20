Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4D3E0C4D
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280453; cv=none; b=YrGXUnCL8xCQNq5PRufcAWb6V4WcViucCt7pMK3MamEofBG/rAtnJ1qHpcWH6l9rxPs8nR1EMfM5lpolsSCd9dRA3Pzq1IFen0QMyzppCstl4Cm7kRX+I+m2ua4YW8rmWEpwdAh5HdWeCz2jqvd3JB1l5UxYJA72Qy+9qmYeFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280453; c=relaxed/simple;
	bh=FaiYDWv5ktpOfI7FbTjcTMjQgLuV8H8NQfFgpojEVP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPGcdEQMUXgiu5XNm+dKfLG0kjPtJXS73jsWkItfu3gi39b8EXN4tcXIAReU+9SlyfmX0QsPa44UwjZJoMnhNpdbdESk55gI3Nf3Crw24sVvmNmXg87Gmd1RnD3ao0vCN6pTA0jFMQbqn+KYtnktnuwYfvkq+72BmtmTUE7d0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTA9WPbK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G0cDtx5i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTA9WPbK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0cDtx5i"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7IT9U1954131
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 12:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sWlv1f+/kOxg4LIib9PaORtM
	K1pM/yQ62L4lr83A1ew=; b=pTA9WPbKFHaJ3i5vjoo097EkuO7KP9Oh+yMGs95k
	Yj6c2GeGk2jdInRXdfIk1M1pUTzFVfWSY9TH0JdwXh7FXM3Xy5TMUyJVF9AZj3X4
	yfm8H9/bg7Y6BgfQHTlNuIVWx5YkoVccRHLCj6gwk1p6G6e2x745Soeyo9/wOw0G
	fiWmYTwat2dhHEhxf1Pu58zLbcha+qDThXU3gZYw2HtGTq5O0rXvFxKXikZMJSZ+
	TLqM+AyVDhPR379c1B+QfdIzfghf/DxAFo9qzjSgMx3ZJCGlSVMUFd/M80NCZCDN
	qd+BY7HB7F3JbcU5TSSTdPsVmLAcHVM+1bHpsuWrFpwaZQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xvqvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 12:34:11 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95d25cc8f5bso7842180241.3
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779280450; x=1779885250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWlv1f+/kOxg4LIib9PaORtMK1pM/yQ62L4lr83A1ew=;
        b=G0cDtx5iI3KnjVgA01m6VqRWWFKElZTxwCWNfbABluSUXgvIHkTfnULG9XhzBC992G
         /DEvzXQ2jWxq7rhB+t0A9uLw301HJM5Hdt539MOGGeNbL9io8cSfGx3TJMt/tMREGwXJ
         reRe+vh915KXxV7S45iT50YAAlKG25v0WT7ugTnKIM3eoRmcQkkH/YEsMa33VStGqMeG
         /JYKbSGy8EH0ywTF7msh08VCLbB93Gl+53mdWjb2vRgJk/vL6xNWDpWzRMhvzm5gid8e
         qDAchk3O+CDOy2uwdJNP2XcOL7kSxI9qQhnXViOI7FfNKfxOsZPAtJT9mHxKEN+9RHHw
         XM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280450; x=1779885250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWlv1f+/kOxg4LIib9PaORtMK1pM/yQ62L4lr83A1ew=;
        b=nG/WOdzlDiph9STJ2iHujz5hIMmpThNBgZHe107QBF+0YST7LfW/P5NdaB2IE3/KAe
         DVyJ39b18rRRWIyVu4MfWXeQ0CGlJXqAOMdUj0srtCc2fqJQScgmzgS/6ffFy656QgYg
         RinPcM9YDDUL1LO2hgr9jbBpyld1KUr3yVc9OXwRemblyxV7GVdcBlEOaK3GCWfZmRAq
         8aOKf9ymjHKZ9bH0YkGLaZKObkPxFql9X0x2DBKhKls049aJqw1dQGd77dtXk5sNu5Ok
         5g7w6PQgeHRV878PPOPYosMFeRp0xw6dAFv/+VjhTXIlT7+AQHTpDUlvh6LxHDlxSZ5j
         eBXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8p1tzDM3nBAkTCZxflNIk5GYyVKN7lhQaIL53mLZqHUxYtgq4wwC+vURjvDRKlyvFEuYyx2/wbuS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCsE1fJONQp4FuaWw1XQAEFfws5gXf8jNyEjFS6ZAeO4XQocN
	ZBf9b281EeuPOgtOh/cmNqQtq7rHU4BOvqxu8SvJ/OubvFJmMbTKyTrp1Sp/It6Mp1D2WmjYI5W
	wT+UrLKdxH15YBTy7QGX7sDUctJ+NOfQADwexBCLhAA7z9+/I0vX8qZh5+e3jGN0=
X-Gm-Gg: Acq92OHKhz3KqNJn3jUirEQ8fAgb4kDwh64no2aW2uw7CbfLDTnutyeT/BpPmf5aFWq
	PPkgcAnbV2rzrNssJYzaG9XNJnnUVA2jEAo+HDaB5I1zjgPyo0q4P5djBIdFGGmAnF6xAsv5KT0
	o3reLHg8wADwafP3FAD+xsT3a5Vl4opqAC6kxVyoUL851kuHCZPSo9jwX3j1gHIHUUNZfRMawL9
	AxhUOxS97F1g5s2HnWuKC/34/megxY0Ag64ppB9ga7Y5gZTOlPROVq4xZKY4vemVZrq7ZlDJbeB
	tsDY6Ut1nyqAvkvEN7tt++bcDxu9WUHYYidhIdt77O0aSXFVfsdRlf/E+oOMAiMrX22XQBwLB60
	72u4qH8QMZjC5w5HISJ2vTcKhTFZ34ZMtm3ZMhFTL5glgy2clhnnIiEUjFbT4ePUMGHNw4taPXz
	pwzDXI6Pkfl8TU7awImCxzbwFLXqB41DOyw3E=
X-Received: by 2002:a05:6102:50a9:b0:631:2624:e5ec with SMTP id ada2fe7eead31-63a3eb8bb94mr12999000137.16.1779280445405;
        Wed, 20 May 2026 05:34:05 -0700 (PDT)
X-Received: by 2002:a05:6102:50a9:b0:631:2624:e5ec with SMTP id ada2fe7eead31-63a3eb8bb94mr12998977137.16.1779280444859;
        Wed, 20 May 2026 05:34:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c4fasm4905823e87.5.2026.05.20.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:34:03 -0700 (PDT)
Date: Wed, 20 May 2026 15:34:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Message-ID: <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0daa43 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=STQ2a8oQ04ts6E9hehUA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: CV0CRhKGfsTxr53cm3BdOKsCNA4C3Sab
X-Proofpoint-ORIG-GUID: CV0CRhKGfsTxr53cm3BdOKsCNA4C3Sab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMSBTYWx0ZWRfX7amiHYbQkBOD
 SahCCL7AlCKG4Afj6V8oOvcQzlZ0ZSG2jeyLRIC2Kcxlr9OJKuCYqP8lM7bca2XUEy32ScRk5d/
 fRPg1Vp8j1IFM+2DcV345H//NShIlDmAGNWl7I/K8EA8v8r/hP7yS8BqjGdVjTMrgFk9r2DwjzW
 c1llEA3sxmfrXIV80S000dc/mJevtvDeTN0WoV5mIsgiaDo+2IRMrTOBc7js62+EV3H45BhGhwc
 guj9zXSXqSqAfIEw2vc8PNkexghW59RNyk/tTpZd/z1IluK5ogIejz0pYzhq9hZqoFftHo5vyBZ
 aDEWkQDAHyokyqlL9MBniw7C0k/JHBeWWzGw0TkIQ6cbKPUPI2VAUkKLBz/IO48Mv8yqqAvXQ5F
 YwAID/XXi8DRVHxfQXFcUypzcLmoAKL43q/o3gAaAf4t92zeVPK6VKBtWMHPkNNG6Qjl20zuG9b
 CFkut1hrRp4i+9V9ixQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200121

On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
> 
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
> 
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
> 
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
>  		enable-active-high;
>  		startup-delay-us = <20000>;
>  	};
> +
> +	wireless-lga-connector {
> +		compatible = "pcie-m2-e-connector";

I think it was discussed that LGA can't be an actual M.2 E-key
connector.

> +		vpcie3v3-supply = <&vdc_3v3>;
> +		vpcie1v8-supply = <&vdc_1v8>;
> +		w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&nfa725b_default_state>;
> +		pinctrl-names = "default";
> +

-- 
With best wishes
Dmitry
