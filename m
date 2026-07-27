Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFF3B0AF8
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167889; cv=none; b=fG3TVVr1ZpYjpTp7oGjYJcACfO8CkY+kc2WQ4uCosu8UDuA2Xg0EIXh2V9qA7H4y3a6NcYWXfHpSFC+1PuijeIDEKgfGoESlOJttUi7TCk+NuHNSqfYjiCdh1DCxN37bxpB1mY0YXYch3R7NOnMqsGXWUtzwXh30SHvMBKwkp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167889; c=relaxed/simple;
	bh=0qgXgsgKz+Wf+EBl6K98gB4VaUU8bIC1KbXt+cAj0ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuEg9VgVEo84D8SBHyUxZcoIQs3DzUE69aMjuCS8xI3tYCmTOqlxyncQMHl9yfc1ul+1vmzuPZpO4cKSO4dzYE/jrtsLNgy+XhBkAkAqHGYUU8OeQnwrHrPjxq/pDq6PaXTTbywUXzIDdBxCS3gA53dR+z60rLM+sx+ilzV+6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxUsxFlS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bG01MU3X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxUsxFlS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bG01MU3X"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RFu1og179412
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4LVfiUpXLe7IIhGQGDrjXg5r0Ni0HjutTb9UTyNs+C8=; b=SxUsxFlS/7d6Yns0
	iUZrDoVICIZA0MNpDx5vj3JI5tbW9KFxdauO75yWPAJwBcaC0b3A1gxD79xJZGaM
	SVGY7izUUeF6kve/xBE/m9hBEiBj/UEInLukdoYu1LhZsscHNYiQrDW7JR56DwCD
	hbCPgAnO2ArR+A9P2LxAlNsxtT8r2uL+y928lXAacKN/aGBkcdGVJLfPzN+4+8W8
	ieW/AMWBdjsmSCQjJcYei2lwHyQubbGYPqP6VJu85lG04U5SJVMoz384xZWxmXfd
	xnZcdyXFGbhRG4gofi1LHuS859bb3vmDDy9bf5vxGA2cBsRon4oc9WHMmHCvmcth
	qtgOrA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkg0e5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:58:06 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-80ee3cb097eso72108097b3.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167886; x=1785772686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4LVfiUpXLe7IIhGQGDrjXg5r0Ni0HjutTb9UTyNs+C8=;
        b=bG01MU3XKNk+N3TIPHOI2d6+P1NxGGs9OoYSF/Lcm83YZ0VgjSaK4uINXg+MLbX4lF
         cqO81kpkLUUMEOnHK69QCdpnVcJk5zFwIwbTLTdRyL9HL6vk6WJrsS7J3zF60Ua5qAHO
         +K2DXvs6ePYaQSedTTY6vbOMwlY/JBtR4MrlKzs18FtjTWjmdFkOntIYzsN3VfI/39+3
         wvBKXcubFj9DzdAHZ+WxOF1/K+gn2ZnMlspgukahdODTJJxHmC2qU54x8lM6m97e9Eyk
         AMFwheiPL3MniR6pcdHx7s2098lE0W/HZw2vnaoiH0JuT+JlOAIziupqhWmqpLiwRQvO
         Z+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167886; x=1785772686;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LVfiUpXLe7IIhGQGDrjXg5r0Ni0HjutTb9UTyNs+C8=;
        b=jtzOCBxLasAr1GD0ML43xh/rxB3oH3DEU8PfqMsDez2gLexfZkegOAK1ozgpN7FXzC
         bUqcxTJztzxI1cBWHVBt2h6H34FMO4Ok2+gvM/uq/Wl3wsrQou/ipwjZx0W4L+/0+IdJ
         2abCMPhXPth4k3Zh8+2pQosXjNOKcpBoxxA4u6SdRZQx4jX26u/GAMFviv+v5srxyHam
         6xXcGIkpZw8ztNlxc9Zv8F5r8tXi1zQDjIDuVLg9YqlZWumYs1mK32xZWSgwvKQE9pgS
         34DgqGECpSFzjj10cR9yaKRPGTkrEi0UNulcyj1sLQiuQdaeK5pdQkGg4/TvoqjuFhmj
         wARg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0DGriuoCbZUvIOmktVlz2lHIPmaryjCViaxibtzIasJUt1fE6h1ryaVCX8pFvcJJ8okw4/rJO2tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DT/lPS0MIYuXJrcqs/P7CdV0NF1eZVYNk2PGrFI8Lrqhl/V+
	OaguoiiExO+j6Wxq/Tq9J7t6U/zoB+S+sn30NwRha4ol6tBt0nUbyZN7EFwKsQVb7FcNSKprAWz
	xB34cCBGQBpLpBzF5XLOzOJbF4VGf1fywzkcLzJ2cjXBLtKoE2JT47I5cc58fUxQ=
X-Gm-Gg: AR+sD13JJLsBb+g/2n0xWL+cvfIa7xtvTPYJG3lZRQda2K+cQ+3+UYtUjescxHwj+lV
	nYkz3RnEWRf9XCLfxJTDf7FVolsjxCQtp/dAFgbhX65mnvT6oI4rFuSKrFk3pxal9odMBI1mUfU
	Fb0ZpXokfDWNdevFjmYWzFHMe1IXpf6LWPLUcMFQnX+hiiaGrJtlgPvucgYiKnDH7IZnfq7zZP8
	p+GsAZJWgM0FcbuZOvwTfcL0tP9SPI5uaSNNF1KlVYot/F0W9PW9nTB4mE5rpBqnuJdrPABJaXb
	sU1kjeKqke4KHrOzXLEKkyV5py04my1C7OW/2O+2zBa9IwzG8m6GEPgfVA+tkdtTcrl8RJWZPZ6
	vDfA2htNmaUSyXtQdT03jjuxMbxz+2i7T
X-Received: by 2002:a05:690c:e3cd:b0:81e:ddfc:3d6c with SMTP id 00721157ae682-81f93aa9ec6mr370277b3.56.1785167885959;
        Mon, 27 Jul 2026 08:58:05 -0700 (PDT)
X-Received: by 2002:a05:690c:e3cd:b0:81e:ddfc:3d6c with SMTP id 00721157ae682-81f93aa9ec6mr370047b3.56.1785167885432;
        Mon, 27 Jul 2026 08:58:05 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.243.103])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm34165037b3.13.2026.07.27.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:58:05 -0700 (PDT)
Message-ID: <7b8d823b-8721-4dcf-8615-ba32e34c8e65@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:27:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: t_5Xq3GQAczKYDns2J6PBw3bv4G6YB4l
X-Proofpoint-GUID: t_5Xq3GQAczKYDns2J6PBw3bv4G6YB4l
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a67800e cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=EvQFEFD3jZIngB+Plrtaxg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WbzeOWjvF3M0CV0e1dwA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXzYEsj7qtlybr
 feKoC7tuDGT6E9RLoOr0BIY5FpNzPnDCknlEyEQh2+bmieNiPe4VXVfhkJ9CswqNV47+a36LFCg
 evgpbShw/Ilsjr4fGI5zz33Gv9rc3D3sw1wgB3FJUpVvDv9SMm4ZZanvclzhsCD0781S1tYDO4z
 5NapI3QNsItr4igc3Fi51Bp/HYhryagYssK3WFQqp3Fa5De4DS+EkSCzgQTH0CXZjfrBfvYkAN6
 475oh93C9yKyt7LC1JQffuCetL/Er3z1yl7B+W/zO9n/wGEVIukbTl4Hqkh+PQIfz0ey/ArXbGF
 Dd8dxYyHZbI5nCaeHKztMruGwpwWwcyBe9nsOzWY0Y6ARlTMYkSiE6D3aMHZPmT2sicYZhNFCt/
 4b8wCGMtQ6StQdLKvQ/MNJVM4cDVLirQLs9bVt71vrRu4t5X7C/4JPTMOA98m8S/NbDQ9uxvYlO
 I42sUxD+KXkkZ2C6elw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX/l5M8VsSA1kq
 970jKbpauXJcekw42f/CeQl7RsSg7KD63cBilQQMAi+3c1Fg6tr+MBAKUOJTE7leKlrxLQNE64+
 wMLg4ZEMK7MCd9XqWv9R+zdElrFmenw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148

Hi Konrad,

Sorry, I missed carrying your Reviewed-by tag from v1 for this patch:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

If the patch is otherwise okay, please feel free to apply it with the tag
added. I will also include it if another revision is needed.

Thanks,
Rahul


On 27-07-2026 21:15, Rahul Samana wrote:
> The PCI core needs to associate the DT node below the QCS6490 PCIe host
> bridge with the enumerated PCI-to-PCI bridge device before child nodes can
> be matched against the PCI topology.
> 
> Add compatible = "pciclass,0604" to pcie0_port so child nodes below the
> bridge can be matched by the PCI device class.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index fa540d8c2615..12594967d2c2 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -2296,6 +2296,7 @@ pcie0: pcie@1c00000 {
>  			status = "disabled";
>  
>  			pcie0_port: pcie@0 {
> +				compatible = "pciclass,0604";
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> 

