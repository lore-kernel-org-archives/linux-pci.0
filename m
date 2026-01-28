Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4371346FA4
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599500; cv=none; b=lZPZXEQ5j0T+9Fg+PSf1R5C6EFytGnZQxiKQQnNppoV8gdaA9g4LxthXV6zjREanU1QBPLtKmsXPy3kvni7uMnYgc45zTHYZ1HliuY+EQRPBBhj7PTx9ERkeJRIxgaWGNjpdKyDBda1UGjuSo4PmL2+9sILlWCrF/qMREq9rWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599500; c=relaxed/simple;
	bh=dVaaZ/ts/oUQNOwdJUlK/CE2cyjwYip+mrbrgffsmDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4qwd7MSAkzZlqz/VIPn+0Tw4hqogitlnWxOgN4oC0Hm7Ch1qneRo9P63we9x6ynPM2uIazrufvi9KVhA+JRvY+d5aEG6GqlktCSiFaEmzmXci20zpI+uC38tVa6ez5H3knRvI/Den/B53J02KpyI+cKkDB3yKDOOTkGCDZ594Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eSBO5EHk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Za3fglJs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSBO5EHk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Za3fglJs"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92cd0041993
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dhRsJ3EzuUj/2l9fOKYhc3V/t6syCqgQiffXBGPgzVU=; b=eSBO5EHkrk1kKvol
	or1hol6Sg/aspr2AtDwhhY13UR1eIqD9bG3gYLci7B0wSHjWtftBFSGdsPtlBcS0
	gmfF/12HMueS+9JgpEynVntlJQAX3IZHmC53Aw62zLMDKnaEOnZ5sOrLi1eHtUyH
	Ykvt1VM16nyeOAutu3YgEv8lwDvluq2erwKlrDXCusZtEpLw37JoP3mc/2JX5+9p
	urgyjMvOKOHg4uhwcNbnSSajZOeeZu7KmpeWa0lSs7nz3B+icVeL/OM02E68eTo5
	p6Qs6gzBK5OXPo3155SKE3LEKWsu7WxvCuzhwDXeCwO2tQzofTi0SOyubeXWeJYV
	fVl0Mg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by355ttqa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:24:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-502aca58e75so2654161cf.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 03:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769599497; x=1770204297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhRsJ3EzuUj/2l9fOKYhc3V/t6syCqgQiffXBGPgzVU=;
        b=Za3fglJsnNFRQ7a9wwKI1JoJvIB0xrC9PE1O6btR01k9ewhn3pQsM6JNuG5yFYBwxs
         4GkqhoBxCHsjCwYjFebPAZxbUDofYT74n1CCeNJ54OS02skyBZI/XHDxnD/yDpqbg6BD
         pHp+OiNapQs91XX+ltq4mlMtA8Plfg6QmvYIfTSogUWXTApFEmAvASdATJu+1PINJUd4
         Juq9S5NDAIacHWq6A4IpAaz49aweNNvq8Xds1wF1tbLPH9R5XxWzKWEoDf4T/zdyThT4
         Ba1IzXQdF7t/fbtH89fiVytb+LGvrw2hnDwgj9hdBBEaEBs9gr3vCLigcUk0eFaxLnDz
         RDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599497; x=1770204297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhRsJ3EzuUj/2l9fOKYhc3V/t6syCqgQiffXBGPgzVU=;
        b=XNd7H8xwT92C7pXbj6u7ReyjxUy/NMmww4oPyG4qyJ3b9gNbgBEKYs9YFCbIxUVd7e
         QRl9y2rtGo9koMhK8sN2Lb1fWyDkG9QLDszEDSeu245kYc/Xa2X04gdqMZiMEcx9gsLc
         lZmvp7uiEU+rL/ligLRxFmHLO+yL3g5xaIK9sbEheCY22aB/NT9S0O4cttUTxZI7Ukpf
         23h18IKhcrQLVnm2qKVbiJ5XHmcgD8TKkzhg/zKGeXQf49egdzSlLOG6IKkrPJZI4I72
         CVfDcJ3bXNYQPG7E3L+tS6toC6lwMcYDffcmoW1qtYIvivUYXDDgTl+RXgsIgfslscQY
         Tcmg==
X-Forwarded-Encrypted: i=1; AJvYcCWIRPEOH4tctmNIAf9A83bKskJ280u0TpFKQ5E6BSyzOT0/j8x0kzqLphQ3YyrgVEC4y2RNGZNdyQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzxdTCoDfpX4fkeQBTVoiAtonFt9G42CuhEX46C3Xr1Le8w52
	NMiTUPqYOQqH0Bpm8oQmdnRKwgXALDvm7Owh1oTqQLr8zTomtnNbJKrDcenOgbs0MHnFRVl0MUS
	BjBr0TyMT+GQkK0QhDGWDJz3fFCbQVtM03I8D+hzFpclxkWqrRor3OXnv4qC3pJI=
X-Gm-Gg: AZuq6aKdiH3Iegdj1PLH/Il54sgeOJqdC8+RmaCpGhG73yWPubdVsw3vfUclFD/bsNR
	0t9ETcZfmAfumW8HR9Sk7gihuLG/9tBex2do0umDrzVddBQgtvKd2XBArEccdsN7xA/ZCKydv1X
	4SnwGZuQuynb7AEQ5qbFkgknP/eOfReyEaIRDE+GDF9xW2F/WrCasBHcYo9J9BeXk6jFpmm9s6f
	aCpfKZ7AYfmviGMrUam2BX5rlgeHUBgtLWNaICP5wzOk/GLJC07QQX49nqBgv3+E+0ZtJthBuay
	pnlQRX+bigMf2PwO1Ekn6GmRxx3Yn+FEhhEWpivQTWbwu113YZWwrddwL0xP1lBrBVw8XBpYHVt
	aXKyHeHM1u2p25gb7CSl26/K3Jaj5AsesI+P6LvOcd/BitS8K9OLNMJOqovH+eTIPxhY=
X-Received: by 2002:a05:620a:2904:b0:8c6:d3a7:3d1e with SMTP id af79cd13be357-8c714a67607mr122192085a.0.1769599496949;
        Wed, 28 Jan 2026 03:24:56 -0800 (PST)
X-Received: by 2002:a05:620a:2904:b0:8c6:d3a7:3d1e with SMTP id af79cd13be357-8c714a67607mr122190085a.0.1769599496363;
        Wed, 28 Jan 2026 03:24:56 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1847f9sm117534166b.42.2026.01.28.03.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 03:24:55 -0800 (PST)
Message-ID: <de10c91b-f6bf-4594-8df2-71395ecaa893@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 12:24:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: add basic devicetree for Ayaneo
 Pocket S2 gaming console
To: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        KancyJoe <kancy2333@outlook.com>
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-7-c55ec1b5d8bf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-7-c55ec1b5d8bf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=6979f209 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=rO7Yge3HHgQ4wEOnkrQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DwdEGZNobomxji7nhtolzWO2u4hFq3a-
X-Proofpoint-GUID: DwdEGZNobomxji7nhtolzWO2u4hFq3a-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5MyBTYWx0ZWRfX1fvVOf/tXsVr
 N5rZstob4ZWSO/8K4VDJdfoE/mFLsKh+Dq5Nk0pK7lezLOuJQMfxElRrH5RlBEUNsAWwBNc6Xct
 aYTsamcPkoNZ2wKXswMn12YjnhWkiMFMVm91fd5omgMs6Y26rahF/opHgChYyLI8FJlkiQmNH3J
 0w9s70vFpKZ6rPU/BfCRY/OuQwCG+mKBCMFCk4a/HzYYEhhmyMBfR+o/iMokcgb1jZqbpKd5QoQ
 6t10j6B96n50OuUdEn6d/qIobUeBBQ+vpwuUwZTeDE6LqCZQLWcEhh05pHApsu05myHCBZ01+Im
 50jamNl3e4QDDIR39shiMXbW+mdGCYf2SRrdwOefsY3yb10MBt0pjwdLRruk0TH8pFJzk9I7TJl
 kyreZHT0XsSTxnuirrqQPRHMOfsppqbcs3NINav1g6t+9QvQeAExalwV2BLIEVfSSk3vEIsoL+S
 HcEjO1xRoGN++fwmQ0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280093

On 1/27/26 10:57 AM, Neil Armstrong wrote:
> From: KancyJoe <kancy2333@outlook.com>
> 
> Add initial Device Tree for the Ayaneo Pocket S2 gaming console based
> on the Qualcomm Snapdragon 8 Gen 3 platform.
> 
> The design is similar to a phone without the modem, the game control
> is handled via a standalone controller connected to a PCIe USB
> controller.
> 
> Display panel support will be added in a second time.
> 
> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +		va-dai-link {
> +			link-name = "VA Capture";
> +
> +			codec {
> +				sound-dai = <&lpass_vamacro 0>;
> +			};
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		dp-dai-link {

'd'p-dai-link < 'v'a-dai-link

[...]

> +&pm8550_gpios {
> +	volume_up_n: volume-up-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		bias-pull-up;
> +		input-enable;
> +		power-source = <1>;
> +	};
> +
> +	pwm_fan_ctrl_active: pwm-fan-ctrl-active-state {
> +		pins = "gpio9";
> +		function = "func1";
> +		output-low;
> +		bias-disable;
> +		power-source = <0>;
> +		qcom,drive-strength = <3>; /* PMIC_GPIO_STRENGTH_LOW */

This is defined in include/dt-bindings/pinctrl/qcom,pmic-gpio.h,
you can just use it

[...]

> +	upd720201_avdd33: upd720201-avdd33-state {
> +		pins = "gpio123";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;

You should be able to drop all the output-low/high properties
since the device driver that references these GPIOs already asserts
that

otherwise lgtm

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
