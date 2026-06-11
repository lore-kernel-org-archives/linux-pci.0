Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA333CB2D4
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179774; cv=none; b=OWlzUjyUbSFyw98Dc90G5etA8HZmbKU1KosYL9CecOY4Nv3oHQ/kkKdZue5xLNONAWJGAQ1gZ/AGpS/GIB86yKP1qwSEm2zqhAC4yuLzdlT39IQDEmVRMEKA7SqnWaeNIyqQZfp8O6IFyPl+e/ByBRY3noUPBiRGvQ5QUdIo0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179774; c=relaxed/simple;
	bh=PvuQ0Mdk6NxDmi0CVM4MzXjDM2sWs1KzMrzzbVZ/HAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mob2Qyk37PTx7bBgBRQNh5MFXoLecE3CejqmRrev3NiDJjiVj1Bnr+YbpkdE3VWjrm34Qn8fka0GEfTH+s59ZKiYO6hc24k+yb+OK/gFTiqloj7xAJibxU2gDzVsOqrEN557QmI4R6ETS0/gt45XhewC+YEfyGcEjeFLki/utI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fX+52gJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G1QFzKHO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fX+52gJa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1QFzKHO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA03jO318913
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 12:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=; b=fX+52gJamw398GVK
	gyubigFeKdi3+9/GX+7kBBj6HY42+3HdRKhPsu9mXy5dbUXS90EJqjsSHDC3G8CC
	ujFt7Rt0wqppB+I402QBxcq3vY6l3hU4eZmp4tlXDqXI3o46pazyIElutRHRxWLJ
	aEgj3/0kX0o5BsLwO/PzMC5X2dBUcJhBZI3XcbFvhnMqDvi5OELS82WE6F5sH6hI
	hYNgSUlZlUqqSTneeKkl00PR+tpsBSZNrbtsjmaeyjjYMC7MqNVdmDXHOXFSbqgD
	///S7kA36MeheAERQvf+Mhsvk4jn96lMD7qFNpb2p9Ce9BLpMN2HwqV1Y3COO66A
	0wy0GQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6skbar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 12:09:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517647fbff1so26066661cf.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179772; x=1781784572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=;
        b=G1QFzKHO+FbmtnEAl3cgJ0RO5AAC8b4riE04qiEmvuCy5IpV7zXK0ZRH1B6XG7pW9p
         9nguGU+sAwb6S6Y++D77HeQ1TX9QZQ9l325y4Q8dw+gg76TVEnKku4csMaVGGbGLWG3z
         f9RVhD7CHTy3UmgVnhfR9uwru76L8d7IGXM/6uvKB8CvsUZOn1h1KWX4v42fKyXD/hja
         XWXpj48cVsJfpQBx4sSbQ4HGcyWAV6cJoYb3QRHYBJ3dAR7fIlih4CNZiZkF69hBgqZH
         m7r3SyqbdKwN28l7gQDNfP6vWl71VvQccVcMGjOuxrOfMRJE/HSI9pWkvHGxDYt50sBP
         s4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179772; x=1781784572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=;
        b=NMeU+0t2qYYFsOW/HKqsFQuGlHSVZsRAAaJg/FYBW+vMFHlbOTjmaDCY0z+ZUMUqN9
         iIPvhUNaO3bLLr6/kZ2qySxsa1syriqD+8dJg/Zq3vYe1FQeIMShxx/eJv2DvnGg8uvt
         gGR8PQ68kKY5HqaRiaFWR8+x6qw7vQlgEOjwjIx9ckVQjkTG6qm8eAPzJu+VpSWLNBio
         cFBSevnBTYpWXrUwilhDCG99zdlRHd8U7xeH6a3HleR2HdQZgg4IoUw/3CwbHydWQG7t
         atHGdL5RBFegQOFqkgriuGIH1V1roCIqakRxmVvCt6xazaK5wfPB+zzimw3ljaFrU/KH
         gccg==
X-Forwarded-Encrypted: i=1; AFNElJ93aBt2YPC9ADCimdVhCiTigKRZd0+/7cuTuVdRc9h7/SNSTTS9MDY5VqHJQ5vxrA6QRSZLgbTkbwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuofcGw0WHEkh9y1hWbCf4uw8TYOJnNlsuwZ9ViorwosiAY7zY
	pNfso7RSuxwBNxvKAmG3DUP1eLc6n4UNAj8U92HTd1asgRzlIvATChwNd8OyVvEDKC4U05rIhL7
	/HyB2m3tmXARhIYiYtiEjVyMz4ZpKNEDs8xlY5zLSDYZu+UF4lRfXfJ/qSDUXQF8=
X-Gm-Gg: Acq92OFH3GGRjT92D7iylL9en0h02GSrrG+GVVNRYWp/hon5o8duEJ0SX76UiourMKs
	AZCIpjWpncG7nXDZplR0pDYm/w6uviHhS58T/cRPWSiHR4hwQkAsC9i/bgx4rM9odH3vzNC95mJ
	nfe4gpPLL6NIGoPuwkOjMvH/eIEV05EdssVgoqE9bzACBqY9yP/PZPWwvj2K5BhkNAbglZt3tf/
	TH3pUnG1kKqXvS/wMm+xFQPE66YENm5uLu/AzVfrsy4m/sREHVCcl1wb+xq91I/ldOli68sTfmF
	hKx3jeTK3NQ2QH+8pFpdpmg5mnX5F0Q4D/hlhT6yZThzbse1vJIdp7MO2bS3nv9/h/+zAbA6PVw
	duEhRAMT9s1WvzkFpPIHhg2nMXXa4Kj2n7ZzuGaZ3fsjyioOTP799rQvT
X-Received: by 2002:a05:622a:1449:b0:517:8999:6c4b with SMTP id d75a77b69052e-517ee262f43mr23989051cf.7.1781179771926;
        Thu, 11 Jun 2026 05:09:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1449:b0:517:8999:6c4b with SMTP id d75a77b69052e-517ee262f43mr23988691cf.7.1781179771522;
        Thu, 11 Jun 2026 05:09:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb60ae379sm56540366b.50.2026.06.11.05.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:09:30 -0700 (PDT)
Message-ID: <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
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
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YI1ZBNAKO3hFqBcNW16LgHY6FWDVUiJX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMiBTYWx0ZWRfX5rNNMMD7q9lF
 +ShmnwGs0TNtmekjz0HDqmhyCGbzuWy6wH6RXdtQ6dQBw1TPFYYdwFgnidsW21ysmOif/NnsXED
 M79KKZ3MB/4B9mvPN2GFPNGIatiC9OI=
X-Proofpoint-ORIG-GUID: YI1ZBNAKO3hFqBcNW16LgHY6FWDVUiJX
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a2aa57c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VQxyErZXnhhA2ehoMNgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMiBTYWx0ZWRfX7Me3B2YlCW/H
 Vue+LvKa4Dxvd4HsTHGh+xq8pf/A1Sd/UuZSYl5+QwuTZdd/+ghurTovjt3WvlgtHY5AdDOU8nX
 QomalWCBKaPmzCqwt2AxlOIFtk+2Bdm0iCMcg5lqh22ZYBCqN/oNmKs/q5i4Vf9pVsnY7JQnbln
 V2Rs+sLYKY3j2Ji02LX5F5+TfcXB8tfBoeKun1T1mrtfiL0MPxj5NkF1uJD/dw5iG+njbMI4x8f
 EPGHGhUmq4bwVWl30cn+hUmXIdY1DrmSxs4mOWxfDwhVsr/6CQcRD09oylmtzcI+BveEEWhRvH+
 qb5ZthCsmSrAwkCNcDkMIzDSuhZRpM6yrxSzwdfaxtLEWeEJeSCfsma8O0lf9f+dL9ZbWIUMy+e
 MBMTGtjBedKUjMo7vbOzwc2lkQqxDviypbJ4nXPgX2US0oiUODJA6Ru7afcJ2gUEStTZBBWHQYb
 8wz5cHVGlwstqH5NTyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110122

On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
> version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
> parts of the device.

[...]

> +	wcn6855-pmu {
> +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
> +
> +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
> +		pinctrl-names = "default";
> +
> +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
> +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
> +
> +		vddio-supply = <&vreg_s10b_1p8>;
> +		vddaon-supply = <&vreg_s11b_0p95>;
> +		vddpmu-supply = <&vreg_s11b_0p95>;
> +		vddpmumx-supply = <&vreg_s2e_0p85>;
> +		vddpmucx-supply = <&vreg_s11b_0p95>;
> +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
> +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
> +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
> +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
> +		vddpcie1p9-supply = <&vreg_s1c_1p86>;

[...]

> @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
>  			regulator-name = "vreg_l7e_2p8";
>  			regulator-min-microvolt = <2800000>;
>  			regulator-max-microvolt = <2800000>;
> +
> +			/*
> +			 * This is used by the RF front-end for which there is
> +			 * no way to represent it in DT (yet?).
> +			 */
> +			regulator-boot-on;
> +			regulator-always-on;

msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
perhaps?) - what is its actual use?

Konrad
