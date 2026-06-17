Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180973DE45A
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693192; cv=none; b=dRA59wfykCtbAVTJKCxXKIq/+LMKQKeV+/5oikLxYSn6FuVPuxswJ7HIjvLeMQmafRg3yq5sj5oMfBFD8VxhAJ1IJJd9rE6JWvTIO7JC7vw7eYp9ubzyl6JiphfSy1BwRap9jLh0IXgci0JFNuhFWRCmkrwt8um+Ltqs2dCx7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693192; c=relaxed/simple;
	bh=tkAEUA5OxX3j3Lit/V6dTiJdu6f/BbYFwiY/RkMX5zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muQw5SwVZ1qfaVQgIjSEOhVSYJy9sM5Phr7MS5F6mVtLtkKboDunnS3X01q3O2YHM1FE7WuX/sILevLXbwJZrN8wBQz0p+4I11kUKyKjUhNtRNMkSz7h+ImaAdVKzfHANRXcfc5Sx9KIay55ijMTZofQ4I+iCPPyV+xJmLb84Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTFUW6Sy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j5THNKr/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTFUW6Sy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j5THNKr/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UUvL3273551
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=; b=NTFUW6SyPyQlqpM0
	eRxetGpx0Bey2F8789sepoc5vGnzV3R7Dx7+FLDnTuOdjBPHhnNsgZB+7JD1TEu8
	GJlwJZN60NLoam4a7RpEGEE3ZgNyvQdrVnDvtkQ/rLidMlK4BctBb205w1lES0w/
	d4dtfR49OdnB4Qrljw66h+jbl8dPlP2vF7+gAiaJ5uNrucDP5YAVbouxWcOcmEKc
	GUKQmtHrZe0TC3bbL1QxAA/+ZlZ5V7ydPoqgzL4AyHu3WcWbEXSM9u+S0HYm7S/8
	EolR3DNKQU13xdeYJaupj0N9vZ+PzsyZQixtsJZQgqfuMJaqEZGtfpg295t97tXr
	ZvG+Ew==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euefbtq6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 10:46:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517741bcc53so13699621cf.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781693189; x=1782297989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=;
        b=j5THNKr/wpOMaBJpNdFHoIbp8FoL8NXXaLN9mNfkOSUbw9ZWWoEwoVb0E8yS6+K0CC
         kLbny9kdieYkp434bKmssmr4sqY8YTkrjrCF6hDXO1CEiUtQuicgu43dNpmC1MO4Qvq4
         PSaTpkylN6ooXTEJ+Co6EmhQsxsDLD3/KphpNm4GiOSJENxT2N4sxyyz7cwVV7IwWTmz
         xwXBSUfylcOKW6HyPFHESKUy4b6ummFMaPqskoXrv+FmWOOo+5C+grEEAz+ab+IIrF6v
         WUZbaiKjk1oif2Znq+SdwSto4JwUDxn8Jin7x+PoAV5rPBAJFxbM1OejBeATdnfDh49E
         3DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693189; x=1782297989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNrGdDE5wIcEcKZAB2cOApd88y9gCStNjjCMJgqaBk4=;
        b=rera7sVgWlDXH3Id1BvmPL1DVsjYe6VVj8oEvFP1406VwJ+syhXSTave8gzUV4Vazw
         6oQdsQh5fFQbEgsm+8jMlgB+bAQZuivHOkqFR7tdBWzesMdobDbWvlpU00k9LqhO5vtL
         2uH8U9zjws548kNbgU2MCakDi8R437dSkVMeatQSh3ZhUnvrtn6SmnBAs20u5ViMrTvf
         jvuhgcwtSTpkc+yS652oxRkwbh9BSbSWpVynlZ00Dr5fSnHErQi3xIzwzFlfqiIxTcBN
         QpoohRSt/A9rVjp4hQbK76cdiNrlRIlSllij9YY0yFCWK+0aWf/eh6lbK/o9+wq3J4is
         +KEA==
X-Forwarded-Encrypted: i=1; AFNElJ93EZ3QnJOCacEQPGQKNiu2bf7vl7JgBdwNN19gwlCgbufQ5BZznIByGGOoKDM+2MlX/QPAvRMfnl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywocl6V64MAZ4aazZyFgq74guR1AReUWxvTxYcg/7xE8byYahf/
	QkrmPkOAo1zCYwkslSIlWVXqttlod//Nwl1ZESsVCHVtmUrTvZI1QI03qvEW0OYMcfzuiPJXFjO
	ZwZCHUFp3yy/4V4P5n70Ev4XfWDmeavcYCeCk7Xdnvfs7BvGaUZ7tJlyxd8iyN+0=
X-Gm-Gg: Acq92OEz/gYynvrHVsy/Irvcu+HcEL6DodxuiA95a3BOPzW5mjpefZzXj7cuKOn6Pgy
	Bee9DPbSGfhjM/j44gurTqKP4omqYX2WqENP2V+5NdQb2sVSzXyWz/KO38CzDpeyjQGe2yWe//t
	Z304/xMqK1R3UaDd91tmrRFbI9yQPLngIK90ACH+hya1JzC6qaMVdOAfwD9vd7DwK/8hrIkQ8Rz
	C6zBBuFKg0TgbfacVIvRl/2XRKtCesGLpWL0oKLfVBFHE2aJkNqnVNGRpSBHgZgmqulsiZBRQG7
	3Uupbqy67UAtVgzbQp//AYFyYqQaHudptlCNb67pL+52upM3BmUCJ3NLK00aYDXHbcCxYH2Na9s
	AHY1DMOd1E5yPeWHHsAQ69r25qyosuZV69zs=
X-Received: by 2002:a05:620a:c4d:b0:916:10f6:765e with SMTP id af79cd13be357-91dbc5298c0mr258842785a.6.1781693189449;
        Wed, 17 Jun 2026 03:46:29 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:916:10f6:765e with SMTP id af79cd13be357-91dbc5298c0mr258839885a.6.1781693189023;
        Wed, 17 Jun 2026 03:46:29 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937948ddfcsm6244840a12.21.2026.06.17.03.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:46:28 -0700 (PDT)
Message-ID: <7b5c713c-e00c-410c-968e-56b9f487211b@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:46:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
 <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
 <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HHKd8F1Vq3LVqyiXmnfIM8X8A9ziH_DT
X-Authority-Analysis: v=2.4 cv=IeC3n2qa c=1 sm=1 tr=0 ts=6a327b06 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KWhx9lE1SZ_w_DgzBjgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMCBTYWx0ZWRfX/+60hRIAcVfu
 kAD0bswLOznSG7gtjpu/sITk/M1QQVCvuepU2nP+0QvFXVq8NSD8COYWr8wSrzcpRJyWPLvoXNM
 dsDzK38MycmoSki80GROJieBd+AubDM=
X-Proofpoint-ORIG-GUID: HHKd8F1Vq3LVqyiXmnfIM8X8A9ziH_DT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMCBTYWx0ZWRfX52sjpPeq7D7D
 u5YQU6L5fIZSP7hvkyGD+Hcrlp2wymkj2aFC/5faZOlR9Il65iBILwEL6yZC3TrDdr4pbAuk8aC
 SAHHCyEttcVm31kGQQhJym8a0woLnJIQ0IctXcIjstHPFaB4GQzpF4y35HiJetsSugvK2kon+8t
 aE11x9Szu35S/uDRRcLAqO6UpUogAkFS2RHsHY10yYgoJvkRGyjaykTOYqXVs/XWFFfHOEk0tSu
 kOqd6sO/NIKmBgrzAlriqbpKE2vhrisjJABqbxYutF6oLZMrfAySWCPLeW1B8t+BNGJ63V8NGzM
 Se9T5wbDSTaYBNi1BBXy4lcXJDrQIJpDwBFUlFOdSs8fm+Ar4pDJpko/YmP2j0ClKhShXOngJsI
 JZzVpNnBXLXUU+bK8E8EKhcciq9EW5vsEpl+IGVrHTmuFIEpSkh10R/YASI3hJK4aVaym2tG1WG
 T4ffkJAJBczP9lUXKZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170100

On 6/11/26 9:44 PM, Dmitry Baryshkov wrote:
> On Thu, Jun 11, 2026 at 02:09:27PM +0200, Konrad Dybcio wrote:
>> On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
>>> The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
>>> version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
>>> parts of the device.
>>
>> [...]
>>
>>> +	wcn6855-pmu {
>>> +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
>>> +
>>> +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
>>> +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
>>> +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		vddio-supply = <&vreg_s10b_1p8>;
>>> +		vddaon-supply = <&vreg_s11b_0p95>;
>>> +		vddpmu-supply = <&vreg_s11b_0p95>;
>>> +		vddpmumx-supply = <&vreg_s2e_0p85>;
>>> +		vddpmucx-supply = <&vreg_s11b_0p95>;
>>> +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
>>> +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
>>> +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
>>> +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
>>> +		vddpcie1p9-supply = <&vreg_s1c_1p86>;
>>
>> [...]
>>
>>> @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
>>>  			regulator-name = "vreg_l7e_2p8";
>>>  			regulator-min-microvolt = <2800000>;
>>>  			regulator-max-microvolt = <2800000>;
>>> +
>>> +			/*
>>> +			 * This is used by the RF front-end for which there is
>>> +			 * no way to represent it in DT (yet?).
>>> +			 */
>>> +			regulator-boot-on;
>>> +			regulator-always-on;
>>
>> msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
>> perhaps?) - what is its actual use?
> 
> WiFI/BT RF front-end, a separate chip containing amplifiers, couplers,
> etc.
> 
> It is a separate chip (or a module), it is not powered on by the PMU,
> etc.

Ah, that thing.. yeah I don't really know. Although it'd be a shame to
keep it powered forever, so maybe one day someone will revisit this

Konrad
