Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64A3C81B9
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397357; cv=none; b=dkt/r/ECmxgMRcmvZmdboMki/ozH2uSocVCJMIluoni+mmUNd/cBl474gd172Pcw3lbUSOamcsi0UT75TZuqL3307Ao0tv8t+w6tOQazEXShzcJ+8zzKloJfqtz9giR5hp6Z+adZf33kdj9H09wkAf08Dwp6wB9TQwn85Qg015c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397357; c=relaxed/simple;
	bh=28ZLWM/pIAuHM+vAC8WI2Vv9H2XW6bKXry8d3aIER/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/OlxZ54QEzTYVIIUk7ZAzeMH69F1n6ppK+HNHZHCb/bFX6DxjFevV8QCSfYDFB8/Vp9ImZ7wLIW7KiintWxahTGUAGB1vBopEGB7SI4WpZ6tENU/ELclXGDaenIOT8heiPx+Ipcsb7eu/IYqF7VB/ryAOgL4jYEx00xoy7wx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMpM2Llx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vjb/y4ah; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMpM2Llx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vjb/y4ah"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U7AcQr4168609
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 07:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8hNYcnTlO2sEp+wOOaNROgXRLuhpC/AD2RNYMOE4VU=; b=cMpM2Llx/3TaRzEk
	5n/xZ4RN8j/H7gFGCXJEZ8I49KPSnIb++JFW5DNcuJJT2p+ucWozOi4sAAKoVWHQ
	vvFCVdgYc7c7rTa19I3axMmNWGn/xJ7i+DnDiQSPcTWlUNvm8t+dPxHCJGKTsmdi
	5DzJxzl77JdCQrGkiYEI3FtxD/WQBGmBNQ3Rx0idWXJdv3d2I71Rc6gHnYM6JRtm
	xNz9e33mHuNIEISjNAR2JOvJqtfQvDVTU/mnQxywqYtEXyIt+wCv3aClpvcyRQmC
	LSlvFvnGXOAxFJ9bWYN+C9EqG4glFT/Lpu7myP3dcvoU+v86WnA4O8va/01RgL2N
	uxmTpQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr2080498-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 07:42:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52b1c695f02so2351671cf.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785397354; x=1786002154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8hNYcnTlO2sEp+wOOaNROgXRLuhpC/AD2RNYMOE4VU=;
        b=Vjb/y4ahmXKxpafbYC6+1yMAG8hM1+SvYOGsnZdOzARbZLPe/AoM5cSx6wtJYNE8pP
         6B9JgEtprXg8KWCTc8zD+Wj8JCdEypzSRr7S0D7EJHnZy89QzGuCwiFPTCbt32nbp6iq
         VWefYidUvHbG8KTCpFzXr16zeDdmROOiPy6buD8ICx4vzz/evxH8c6G0nr2NtIftM1OP
         MWJ2gRD067bZSFzAaD8AsKSpnrGKB9xj932+RekS4Btaml3fvDFrDVy+L9aGaDm9ayxb
         lh+7nuC9uFbqxsUecwNkk9ldGFJb6naNOOspHsnaDiea0sAlRTtVsJRDy7YtCGPpDRtw
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785397354; x=1786002154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o8hNYcnTlO2sEp+wOOaNROgXRLuhpC/AD2RNYMOE4VU=;
        b=h06RYBPlFJLrmlQqwoJIya4klLn3ryJMrWtM2qM6Yvj+HI/c/s8JNjPXHdfbBUXWsn
         WwowdfjvQCxHpgjb7KrURAKh7tEQU5zzyW/L5YAqniRR44OHxtgpsNl4lx8usHZZ6Oo4
         TcZ0v6h6KuJclDCseBg1TfZXYN4V54/Xl4vSGg+gYi/8JPHN9mmut6kK+YBTwuqH29JJ
         osIseXdh6SRJQPmfeevl3RTzE+Es8i9O2DrpdIMW6f2vyWZb1ZbT1Lmy6NL6Mqc79dml
         5wCeBoWd/eE2hr+kGYaJiXp+hR8vdZHaI1/h2rswTxOpMo6jM0inTbfua08PwvpUUspx
         K4fw==
X-Forwarded-Encrypted: i=1; AHgh+RpBGp3mTq96DKKF8Z9DdNz4Xd6QismjHI8vXGPDwy1ToYMdvBF8F4p1qcarDBoSquBL1JUmqGtF568=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz21HfdL8sLeBwiOCIJf9F5P5KWmFfv2SXJLeM//fluvhjAzAF
	/7re5SV46nnCtHLS/uqAG0jb3i5pK6lUnCseP1pwZPA093j30KLLMs4W0rKTDf4Mc/Z2bUtKXDW
	fgm5R2lw29JfPLIQvggSCcBuCWWsZUIBDFJmj1HhjEgyRNO0JS67TVGdMNSjj9JA=
X-Gm-Gg: AR+sD11Q70uNGmVkEw+3KHyEUN7Vmp0G8lM5w/6GGsbKhzoCBT3RsPOYy4KDdJH4fAm
	eMNXuCj6DTQJxO0hJT3NJGvUI6cJ7ogbq5BxLItW7V9Dp7ezokLOwZiSmxzoCbL9tRGSmH1buMf
	N+A/j15AS8QSSdjIqjL9My5KLvGTwoKaOxKhR4LVEAbdnqH4pR6+y8iuOcGrrRlk5AOJ68AK0N0
	UhhnrrJCRy0AZaAbftL3wDycaXa7jkLxvYdFC59zT5SEyTVFK1kmtjq4ftmXs5MJe3E7y6J0Xbq
	NS6RapbKbqrRQh4JKsG3vTIzvkYIIEteQsWY4XiavB9aM8CY+3KvSnwIYwRjn8p8ee3uAgpudnO
	W76f5nRLi2Skkn+lSl7moR2Tv
X-Received: by 2002:a05:620a:a21a:b0:931:23a:83ca with SMTP id af79cd13be357-93486f06b41mr187325285a.4.1785397353688;
        Thu, 30 Jul 2026 00:42:33 -0700 (PDT)
X-Received: by 2002:a05:620a:a21a:b0:931:23a:83ca with SMTP id af79cd13be357-93486f06b41mr187322385a.4.1785397353313;
        Thu, 30 Jul 2026 00:42:33 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa851b322sm34493866b.7.2026.07.30.00.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 00:42:32 -0700 (PDT)
Message-ID: <9a042817-3a3d-4637-8df7-466ffa380403@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 09:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>
 <ofkvwrvfpyhjflrmbyi43gd4mltrqdmf3pzdvxwitrqshtttvo@r3xpfq3m42ha>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ofkvwrvfpyhjflrmbyi43gd4mltrqdmf3pzdvxwitrqshtttvo@r3xpfq3m42ha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JIgLdcKb c=1 sm=1 tr=0 ts=6a6b006a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=FQzAjSPMhRWCFvqDWQYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1NCBTYWx0ZWRfX/xOz4u0SN4a7
 xUKXQ1fOWQ/pMQe3gGzoC4oIa1JrbPYCuhNtDjq+lrJfS6oRosL7o79i9ZGDGeDvresBY9wUsI+
 iajwjRi3hwzFIvfXCHxXprDL3HT4EKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1NCBTYWx0ZWRfX8/GSs/xFaGeK
 pRbw86XMsArdXcW4WzCEOduE7OWhaacgV2s6+2uAgkWjJ9KLB06ku6kEeiLfIhwaKJCaIXzZSAY
 qdfHRxJv6x16+RdKuUsxP7Q6SLPrsYMpNmJL9GfVBZjOQ07Gen4WDZfMbBUUJmkS9J/qM7jVMXE
 1FPMdcJGu6HgwbzALMWbI2lihPuG61CVi9nXuGzN+lTYBSen6X9X/ts5aVrK9npxQYfXOzbohkI
 P+PTUvUg+5i9zFwhYKwauWkOWf2z1F4fJla1F7uH/rTcgmux7GFyjR6fO+H/WtTTQh4rLj7tAyX
 AWB8X49mwJuK2R9ba5Ij306Wzv6Nva86CMiI5b//3m5usWP/lIpdZFQnBBS7DjWQSieUiENyy47
 xXOZpVerQZCPfWfm1wg2U9l3EkaGteP/lkvRTvdtpiZ5otOtc3ZWZnOilPlDnLgg40u2Kartsoj
 zu1jLfIa1N0xgW1UkbQ==
X-Proofpoint-GUID: TXT8IOD9ElYkVutwuNwKewoXLXs_8K5b
X-Proofpoint-ORIG-GUID: TXT8IOD9ElYkVutwuNwKewoXLXs_8K5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300054

On 7/30/26 7:25 AM, Manivannan Sadhasivam wrote:
> On Thu, Jul 30, 2026 at 10:18:55AM +0530, Krishna Chaitanya Chundru wrote:
>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>
>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.

[...]

>> +		pcie@3,0 {
>> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x5 0xff>;
>> +
>> +			pcie@0,0 {
>> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
> 
> Sashiko pointed out that you are using bridge specific properties in EP node:
> https://lore.kernel.org/linux-pci/20260730051031.20D8E1F000E9@smtp.kernel.org

Can we harden the bindings here?

Konrad
