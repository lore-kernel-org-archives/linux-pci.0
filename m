Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605214;
	b=A+y4np1lii6lF/sJikeMpC+DFwQIgc9nwCdr+N/JElaBq809CD4jSeETU/pvQflhiIPq
	 YjbfDswRyKmolX1M3yWMLcDkIPNW0k+64iR/jpqv+AybhOqmw3WHo6RtyXCVi55Gnw4zN
	 d58H/B6L9plM+Z+ySK7rUfq5yAWR+mEMt8r4EHppp/o8pUHoZk8O9g+p1H2gscCScg/TL
	 vmqDVSlhw3bhLS81FTzo9rEl4t54EGaQ4qnKNIRLBrVdtouoErkzXgIC3UZV7+k5rTG5E
	 inVnExVrihkEsKszRj2iyLTG3/9RyVp5NSsUwJvagkJiImsk964wv/OzUh9LZEe343w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605214;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=;
	b=anR823e7kA0OszjvXSfyISNuB6IU1nCDbw3qjAKyKvEAbJy/CP4/B6rAhJM1f+YJepiT
	 kWZu7lrWOUBo7tuX+KbiQ3YjOUDT3vsR/kaVssH9jMGuCNOIeckZSIQ2/UivYpnii+Gdo
	 lDAgeibFsxlsigV0APlwRmxIav/2/eohVXo48D6Ki9fR2n65i41oC/LJyaEKeng+z4mKN
	 d6YD5/1NkagbLKgvxlVn/GtU9y0CL2IMMbsqRrlo7CzPfQdi1gknZPLaXdGObQVkFcrjr
	 fwyeaARxy9NWqgNa5EtlKD1DcTrOsMi5BfUF0lRaY2fv7zVXKVdlEiKN8s8mLQopA9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o9MBqwBO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h6ZbwCHi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFED606A326
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 11:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FFED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o9MBqwBO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h6ZbwCHi
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nlFc1505248
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 11:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=; b=o9MBqwBOu3LAk3Ql
	kluDjP24AD5Fne6UqAfHIGo4aXZyOPqqNhGWSMuLNOSzZjicR5UqeSWaXbzQRXpC
	3S3swPaoOA2/2pfeLK9d2q60YA6NW3o3k2M7kqjahCRwHEdXGu2VXsKVK1N3XgsZ
	GksJF0GKZyCRJ4lZx4U1z6Z1+Ow8Q527VpGzEaa9uz5cHC3dp/nR+xbu2dNLJlY5
	FCGD5GihpERpZoM47wKRHcbqGFn2tMDIVhD9Sx1KWJROBzqzDOxGvGsuq+J6CfMk
	o0mkvgLk1sjDO6DsCgr3DhlD4tNBN24Fob5Y9fb9gNq6l5d4gdTozjxZ5YTltUDq
	VexuVg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa29wst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 11:13:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53657d237ddso8539381cf.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795605212; x=1796210012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=;
        b=h6ZbwCHibim5dZLdQTk/KVIK7DHkQFXs5f9wRPTh96Muk4tbeCJJqgCHL7Z/e0Jedc
         TekoU1O25P/yI1+9qVgzPaqcMKSHASm1kZZu2T7j/Eno9s7aaumrfCs5aEv+nXoVygI8
         adNWrRp3i1xX2Gi62yz1ksyqUkOeeVkOrpfy98JV5lh/Fd4MU9rbRy3KkykFP6uYnXJI
         6fEThBtu4ZqXOlvdhyYeoPD/xjATetEUqCMjMfECyvva6EeGe8SfOH5/qF/zCFrmrcP/
         cjhgLkvK79I/HsPFV2tvbY9i2USI+TIP7h0hNlEJ44lBZc5aBvGuUNybglgNFByMPiRD
         5/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605212; x=1796210012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=;
        b=DI9cVfUMeSy/UBZIwXk8WezHj1TVM0CHqEjMNN4U4yZ+i4SYuWP6RUr5ceDPord6EL
         DfT2W+UCNMN0n9Gtr18bF4UrZ5K0nhNZrJsdaP3nIouGetk8CleBDNre2nkGOAJwl2UA
         /1otSbS+9efGXrHYOsnOCCCAsfRNoL25GGmBx+uR62Z4tdW07rfehW6sW71k0QQCH9Aw
         BuEeNFWV4WqkTqzAh+a+vwLn+TtTbHbLn6FWzxe5iumgbjk8PUudpRpcQZrax44i5eHK
         oHwr7y+wG3KU/CMS2fui1Ig2dbo5YyAI1Zk0PpHwReXatcR4KTLOIswKP0d3uLmXxdF5
         OIDA==
X-Forwarded-Encrypted: i=1; AL+hErH2gSEEhaAHLcQpxNii99dkgKmpkMvS2Ztkxx+s0w3JaIaGGMxWleQZJb326ykmfXBtJCp3UFXMvO0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iqB846I8C73SFVz+9kaoTuo1pcZJwdnXH8YDeLwCZxcO0P11K
	xPk46aZ9j5JVhXiQkznJNi/0DOXl2npqGOMlFvnj4GbSfP5rHJOV07kdADclWMT3ldqGe7aBgP2
	COEl+fyrxw17GMfXdrmJdpImz4ubhlAFv9+WvmOfUQl6PKmSF52CkRW712+BPoOU=
X-Gm-Gg: AZFdTZcE0QBxM1ADQObkwvxttQZnS6Cor7SgjIV7DMAjuFKlg5r/hqetH4o7bT41ajb
	kLluikKw8iYEHHcWpekUz+fCli+28+bfh4N+EktU1/JGl6pL7c+rssQ6n7WVO2pjggFxhAtfx+r
	sfjrEJB2sbnVs09xtCV+E3gl5yJk1KGsrtrkYjo8hMiWdB3krYqBRxS+kOgnYzkZ1E9ZzycoBJu
	oG9aaCtptXZjK5nrvHp5pmk8IAIZn5D9x8QY8ZZdT/wRSuc8V7Ue1VnE4kaox7whfAQ5xS2C2F3
	TimAn6vDX8RxjaI5s37N69kJDpWfKP/eq1w+zWYPTEtzzoCEpr3huX3Yt1oOxfWfLi4pN+KrtZ5
	LPdHlZd4YECG4hKwouyvTihLGnXGbjVdExnzyHhcVolyZ8nLwRpOdYOI8/DCsk9OXPwMjmwo=
X-Received: by 2002:a05:622b:57:10b0:536:61d4:cc80 with SMTP id d75a77b69052e-55d76a6b28dmr296719701cf.5.1795605211560;
        Wed, 25 Nov 2026 03:13:31 -0800 (PST)
X-Received: by 2002:a05:622b:57:10b0:536:61d4:cc80 with SMTP id d75a77b69052e-55d76a6b28dmr296719371cf.5.1795605211141;
        Wed, 25 Nov 2026 03:13:31 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35641sm8146988a12.1.2026.11.25.03.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:13:30 -0800 (PST)
Message-ID: <e3add71f-8624-457b-a304-d5791015bae1@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 12:13:26 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: glymur-crd: Describe the PCIe
 M.2 Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, alchark@flipper.net,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
 <20261122-pcie6_fix-v2-3-2e0fe615d90b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-3-2e0fe615d90b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: syqXXpYf0EjJM_QBmHk8jUq9eRXvunTA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfXyCfKeSEFJ8Zw
 j5xqGvvDP85S5ZZmPgs9jFoG/zgmZglnuKO9XdViWu+k1nEQScbYJVu3vXUeL+lP6lVVu/Gf05W
 XWxr32ulRBngeqXyZDcHV86Q1CGV6Mw=
X-Proofpoint-GUID: syqXXpYf0EjJM_QBmHk8jUq9eRXvunTA
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b06c2dc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=fmVD6mvdgdatrdQPAe4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfXyjaDS5kqnOs7
 QnI7xAMkSMNY5lS7oL+SvQAfGtmA4Y6MBqtxTQvCFjl4GF1QIo7QWekJjq36e6z7jE8EWFsVdTv
 kaRIm2z3KTPf3NGapmEB8LBHn36q120Gnq96MsmHFiDmyW0m9nCZjohNPCNEOsIgUWHGIlfWxn8
 eXqhl+9Ava5bwjfEVxm/QBgO4GZ8+8RqYze+e/ygBrYmPMIjpaYRHDAmrLCzGp/r2ewvlXLUDB8
 rFsAJAaUr5nXr5rIxSgs5ifJNODLjbMiOJLyp/JURAl8D5cv9up8YJiMvvZf6ck2UXKV5TK7n/G
 MbKkLGVOxZQ9d7Mygi3a7vWTwoWHrMRj4wtAllQIkLjn69OWjlmRpW+mzDhrTNpvxfKj+XMO9WQ
 gCr32LUp7S0BqOxLYtPxQgDYHEqgM5XXFgjkkPhm6OozbXYfQpHQq+PpiB9UOpNHoc+JNvbTiN8
 ZyDLL/0RG+Y+ftcSSZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250044

On 11/22/26 7:45 AM, Krishna Chaitanya Chundru wrote:
> The Glymur CRD has a WWAN M.2 slot connected to PCIe6, whose vreg_wwan
> supply is described on the PCIe6 Root Port. Describe the slot as a PCIe
> M.2 Mechanical Key B connector that owns the supply, so that the slot
> power is controlled through the pwrseq-pcie-m2 driver and the PCI
> pwrctrl framework, like the other M.2 connectors on this platform.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> index 3a9cd5f3ec2b..a66ba8c0ac8c 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> @@ -230,6 +230,27 @@ vreg_wwan: regulator-wwan {
>  		pinctrl-names = "default";
>  	};
>  
> +	wwan-connector {
> +		compatible = "pcie-m2-b-connector";
> +		vpcie3v3-supply = <&vreg_wwan>;

On the schematic I have, it also routes FULL_CARD_POWER_OFF_N,
DISABLE_N, GPS_DISABLE_N, 2 UART ports (one muxed down the line),
and a USB port (also muxed down the line), plus of course the
m.2 config pins

Konrad
