Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5270383C94
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401725; cv=none; b=Y0P/dCGOEV330Ygh5KfHEducjg5ze/1/otJS4PABYScdyUWy33OBPKFmFeQvyyNc7/EkpV++WNs5DaEsFwFVu+Qr9ncTEWBOJ76JpSfXJUbaZOsuKw74HUAflkchw1iQBsij6+YucDmn4i8WnUky7dv+KhgMz5SGI8N0Mr9yigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401725; c=relaxed/simple;
	bh=igCjqyVueqcQVBzSD05IH+bj6BH6zn4cjWjr648E5zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY3CYAtUWf99VlSLnC0pSd6j3chdidqpxpXYAyNlXEYOVJgFe3/TC2hjZF8sWGRP+aO4ctESjTZhdNiKnQTxmdBI41KAmHXC60DVT42A+8CI9Gn/EkqHgBcXtCNINRIGGtIUPtul2kohtxWx6VuMoqcHbeK/JzAr7wWVC1FZeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRKT/rEP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H8TNwlKz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRKT/rEP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H8TNwlKz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748lHA2674810
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YHMOr/irSJL3Cd18may6yQFNWy3Xdxd56KJP7bnvH+U=; b=hRKT/rEP9u86dT/i
	ijdu0P4uFQxuA/Qo9poXS81ZM6MLlseB1png9F1GVTArtrsBJp8su80VAAuyD9te
	cDRgKnQWk+nkwQ241tG85PaZwgvByTG5t2Dm41581cg30McPAtiT9RvtsVCpsASl
	dfsP6u2QdSHRcz144FXLuqpzNF5xWW3lwXWeq+j9Ira+XvrjZyAU89XLkzHx7nrW
	QFgtL2/XTnLxgIRmA7ThcTNVnNZuwiGrd/vsm06dmBR1mQoy/nfmOBxLJ9SZR5ne
	lPmVNdwYvcZ3rxIsd6IF1x/cN7dNrP9kj6HRuda1KjeqeSXVejmXjDCpqYjD/MI7
	geYNpQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj78q1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:22:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-380b630c505so362523a91.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783401722; x=1784006522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHMOr/irSJL3Cd18may6yQFNWy3Xdxd56KJP7bnvH+U=;
        b=H8TNwlKzQ/ox5wu79I9XbldEa1TvJGyLg67Jo1NBqb2/ILN7GTgAdoyg0XILi/sxJk
         G7w/TyemK/X77b8UN2SxR4OXkHZUUjAnt/y9PEPTp9VyALe6RYcLPiIuqfjdvrE5mboV
         SZPxlieZtoBC6iX8c1X2anFsYVLgRMV3RynBwO6PBPgZwSGq0mi5c7CEdVCrsiuUoJbs
         oRc68jaaUrLW5XG3iCTK8JWAeGryalPKracGvvuxYmvFhNZQR/15H2yCdJImsidFMXp1
         7+T7FKNrR7a696GI0fCEuk2gaxP4FCzNYnW0q/77f+W33V6+r7ULr9spTzh1qdxBk3ml
         yNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401722; x=1784006522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHMOr/irSJL3Cd18may6yQFNWy3Xdxd56KJP7bnvH+U=;
        b=XJ/K3gTMFik5rAgwUWGRBjQc2biYuR8zdVQrDpELUCC9bdSoMdbHr8UxrC78SLeoYF
         WKcpcp1Z2svwUzvhNKe03srRTJV3q2Dao6PWkZNyTw/INHv6bvUrRFy5mFeYd8fAPZnq
         pqJSVuAUAhsIz3FeayXgkS2eb0sVWfgp5B4WXIJdnohiw3QJVCQF0sznbPqJiP6r9aIy
         9wvb0jW9CoGctyj20CMtt23IzZ4i6r2VaZa+3DWQfIiqUW5F9M3sasejvNogPXF8qrIR
         wkgq+r3m3annEbfhXSXPqRlrC/gd420pKQ76129rPe0Zt0+n3Ke43ztcR3G7RGHGBS3T
         h06Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr+/1PP7tn/HgahQwQw6jhyV59hxcgO0Oz/U/Lc0aW/LPLOSYu4+htVpUrDS1TFeRpmcKHwLfCBVhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdamT6nUM+2uHKMQvZcZaDRs5Jli2m0wsF5L0hc4lMsFqjwMRK
	+FnO1EhIwaZvXR4wsaQIb6YZDUVy8dP642TMK1ny60jQtXTwyYfpEVMcl9gsvJkGiznkvRBm5HJ
	/Ll7E/A30rqetCoa20nQi9K9HPXegbejy5cj5GJXiyQqpHtbasM55I2zvXYorSd0=
X-Gm-Gg: AfdE7ckFYKKNrScrEW3UluweVVPzvkJPkqcgOIVxAyrp+JCo2VUiavFu1syqdfP0v9Q
	i5ZiCpQOxPpR/td2PD7JxMEsd0AKAwdRF8p4TGkOLRs6D9ZJw8hALZj9Am/jMNd9Gxor1/ywqym
	VFtHb566jBowC7ICnTrJz+mw/2vLK/lb4LmYt1on6FXIRWmZMbKLNUedvPW/zh9MC5Z9K4FzVbj
	n5FD7GsC/S8mHGWqZTkQ3p+9HznMEu3VbQJH5PEujiA25iKbATkQLmz/+vT1CZw6uI4x1FjVRm8
	+B3kwzuOfnEFHJyUjBeIGpWm4o/Qq/EzbvBiDPz2/BktJ9dkjOluWaE1bDvXOY2by2mc3rruk9K
	fvz0JYoFqyp2Ejq5wRD40a1V4xoBMSsmDqFybQ4arhrlLaPgaZJLZIE0JR0v0pH/wbWJlLRm2aV
	tw2x5O
X-Received: by 2002:a17:90b:5291:b0:37e:1c8f:3dff with SMTP id 98e67ed59e1d1-38755a562ffmr4010415a91.11.1783401721681;
        Mon, 06 Jul 2026 22:22:01 -0700 (PDT)
X-Received: by 2002:a17:90b:5291:b0:37e:1c8f:3dff with SMTP id 98e67ed59e1d1-38755a562ffmr4010383a91.11.1783401721206;
        Mon, 06 Jul 2026 22:22:01 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387ceb724b0sm427245a91.0.2026.07.06.22.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:22:00 -0700 (PDT)
Message-ID: <c48910ae-76e1-47b8-8e08-6383b3bb6e0d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:51:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: qcom: shikra-(cqm/cqs/iqs)-evk: Enable
 PCIe PHY node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-9-e1a721eb8943@oss.qualcomm.com>
 <6e42bc67-9a2f-4e64-bb49-30fd845263a2@oss.qualcomm.com>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <6e42bc67-9a2f-4e64-bb49-30fd845263a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rtUtOVz2NGam4s71fJWinOb4vqPrSP78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfX/kB1zNwDx60n
 JpkfgkLax5mwhDk1Z/qJsKkNHTtNu/9ljnWkQl456JdDUOM5BEORkm0FWQGGGcBPeR6bkKbiHki
 pMXGGuz2TsBrOZhQY6r6jslEDZ0k/Hg3r7NToZUpk+uWS3Hx97x6QR7ZaarEB5uTZ8afR9HXlIe
 YyE342Lq+V+I+IsV/8qVIcyj3kyaC7zMWflqkNBNaIyNtrmAfl3+oh/oDR3tU7fsI0txJVqTlfZ
 tJqGkLGBb0/F9H1MfxJQtjmNm9zo/kxSnscsDz35GJWGcyoBQ5e32V6Sbz1fVx+nIKn4hBeGfPi
 htAWlcr2L594/6zVA3ZllNA9+yDbt7OAl/mrbA0f5uFC0NqOmw+HoXianDdnuFz/AMmo9KboZsi
 cO1qS0ARx8tB5LCEjtPb5yFaO95D93FUmpkTLQ467pxwa/t/1NBriwnusKIPrGCl/HeKkTrvoVl
 b+hdYJQ5NcoGH2r8ozA==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4c8cfa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=aEzKkH0P_WG9QAzetnEA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfXwHL9TmWKbw0t
 90SfzBLCorUV6g3IIM8uDYB/ys4b1ozeKtaDzfBGS2o4hxajSWYojzejSe5ygvHIu/dt1PTmzyj
 zWgPQgzMKbcIPug/Na1pdGeFV458/oY=
X-Proofpoint-GUID: rtUtOVz2NGam4s71fJWinOb4vqPrSP78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070048


On 7/1/2026 4:06 PM, Konrad Dybcio wrote:
> On 6/30/26 9:02 PM, Sushrut Shree Trivedi wrote:
>> Enable the PCIe PHY for the single PCIe intance on the Shikra
>> CQS, CQM and the IQS platforms.
>>
>> IQS platform uses a different powergrid than CQS/CQM which explain
>> the different PHY supplies for IQS variant.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 7 +++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 7 +++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 7 +++++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index 683b5245923b..06ad32041546 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -60,6 +60,13 @@ vreg_pmu_ch1: ldo4 {
>>   	};
>>   };
>>   
>> +&pcie_phy {
>> +	vdda-phy-supply = <&pm4125_l13>;
>> +	vdda-pll-supply = <&pm4125_l9>;
>> +
>> +	status = "okay";
>> +};
> I think it makes sense to push the status=okay to the evk file
> (because we already describe the PCIe switch there) and only keep
> the supplies here (because they differ)
>
> Konrad

ACK'd.

Sushrut

