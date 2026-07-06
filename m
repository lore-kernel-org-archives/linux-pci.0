Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150C3E0C76
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326512; cv=none; b=kgGXMUWqytPcwpODOC1APfjP3K52WLGmBwXHtJfXAQViv3dP+GI5fQUEQ5EOyMENPUYw690bsDIyZVtG61KlzkrsJ9SamXiFWYdStZwQD3zjJH6LYpGUJ4ofRgcexsraWrXFTCgqVzNZ0LPOJ/gVmaqWelT77w/TxWojmrgNTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326512; c=relaxed/simple;
	bh=mPKd+dOcaM/hRkXKnBke5UZDJ3qEGEfIyRISqg7wB6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7vX6/Jwqy3CNpOI0tL89EGs0O4mE/z998goj9co6Kmaa6mR8xRz7aOQKQULknxrzTikNZdIIN8kUghLhvtp8NduCfwdQ8O5kS/h8GTy0ybg3nLtDtAbzZN5q7L9gdqiEzmtctLh2jbR+hb74yLGrWywGcieAGjpNd9t4FTJ/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gErI7nHo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j2cBb8l8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gErI7nHo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j2cBb8l8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641fr43470549
	for <linux-pci@vger.kernel.org>; Mon, 6 Jul 2026 08:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mob80sObnBOQjmZYIt894rRAtWKr1ikClaLVZFEtMLI=; b=gErI7nHoDO647b4z
	r4DSFtCfSOrX8VUQsx5UNXnI1yQMl/ork4gmWNq7JYH+rWCXna3v5WTSdvmIDfiq
	tOWOyEO1jhVgIK2yUaVMkbTj6Sl6artmPe3PPsi04a7s1y9JQ05t5AKvwHd5nyRW
	JpD7NyTS0UlvTpzgf0Z0YXGBJuTi0Fpba1KgtNuv6poQA028vk0rvtdBsYqUBVJJ
	w38cza6GxWVqB9DjPYewvDafo0x58LNzM96Uji4fePH2YmUF8Sgv/lb9iJz2hXwx
	Vob4P6z7MUE6PlwTzxuHnWaY0Pgy+wNhxw76uDg+FpZaH2/Um/OGQLQHJFycZ8Hy
	jlA0ug==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txen5e0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 08:28:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e59d97df1so10315385a.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783326499; x=1783931299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mob80sObnBOQjmZYIt894rRAtWKr1ikClaLVZFEtMLI=;
        b=j2cBb8l8AugnQosH+Mx1y81sODjHSRsB//MofBUWrfchPEAVYLZ5WHlxRc4AS0Y+z8
         8+d6Dcqcjsy6QVXC50Tbfh7iCH+PJbepaNgnwimjLhPToNoPHx/t2WlzuddKhnnW+3KW
         BrCAYe410UQ3YIdGekehxCRvVGZVxUlFdLkWU8qL/NfRBDvXCouWBY11Zzyae3vgSaNZ
         ykBe87MT/tlTko//9qdzgXgOTfKmeZiWade/f3mKQrixe5lShmG/f7E/ixTmzWy2Ddwd
         x42WV+vtonA2AO0X8BCiLgjTN7Tj2xYv9CPPjMVXj7Mvp66t3yKUuQfFFWpFzPaBnHO3
         L+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326499; x=1783931299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mob80sObnBOQjmZYIt894rRAtWKr1ikClaLVZFEtMLI=;
        b=k9B9M04oZ+9p2S3/WUEeylWlXpITHDTOCwi9+sWVrJJQzgFXLF3eEXAQct1aDhE7IK
         Ras+o79gPnpyLzNQFI47rEJj/HkQO/gX6EqHn8mj/n4IaZaR7W9FNB0+3QVcZT7zzY3d
         r2g2jrHtWB2DovJBriH9Aqu8PZ2obNpyjKCxKOZuD15z+EZ+fp9yePnp4nn6b/YE32MC
         HhSviH/mISuHO+Rrt6orH4xqersqxUIfRr66GYqrtE/nWNiYX6+SyO/mfANpkn83V7KU
         8oXFENQY1T4d6QF3oZcNRpKXhu7oVlymsAj3srK5ObKispxzc78Y70lbOqfK8NcJtwQR
         8iaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rprj/pKTyFQ/47nkLMZZwcmqmRKcg0bRHKFhiMtyBrHfJWha68Pc98WjwfqBh0YXYuY79A1MoCf4bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4ymHXFpec+Nm/pwTky8y4NzZ21yC033jJmB6yLcLqOXw8nop
	NM2btJQ6RkvnuPnrnAUA7pqIRLlPY/WTMeKH/jhtFBLFEnTUFt/77aGu1ujfd5n8rkBRiq/kp9Y
	D73fyE2ywpZWqFIKUji8Q5W+QpvTK985934suhli5Bv0KQeNIMkLErfEPGYboBak=
X-Gm-Gg: AfdE7ckyn+eGZAUlshS3U19YsZ0KGShn5o4vyAHS6AEixyS68PGZlzhIHpFuUnVrJ1O
	vyjJ4Em/i+mYOVjwfJzkfrRgxg8Laji6boAuQN3ASfm0HJugvT6QE7i1FVguy+eDvK6T9UV8hoI
	vS5lE+kiQZgRF6TROVvn3wHXioMJLKl5XgZS3RptbSsPxaZDzQdQwhqIf3S+LIaf7xCswQJCVKc
	HeoGL8iIwV1QjWdsUmMDV2kq7EEVJCL62UMicfWY45LEVlgLtyktR6zeKBTNqCrAZipvJq8pawp
	s/5EdXb5toyS1MC+gDezvmlzu5YWXe257OD1XjMGvlZsX1U/6vZH8bmmjpnWE6AyPJKZzJMZThJ
	Gym8xx/RkCW06Rw1QsOAbcb+8xAp1+MoKafw=
X-Received: by 2002:a05:620a:2983:b0:92e:5ef1:9072 with SMTP id af79cd13be357-92e99f6b749mr838790885a.2.1783326499477;
        Mon, 06 Jul 2026 01:28:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2983:b0:92e:5ef1:9072 with SMTP id af79cd13be357-92e99f6b749mr838789085a.2.1783326498940;
        Mon, 06 Jul 2026 01:28:18 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60575c4sm692575666b.9.2026.07.06.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:28:17 -0700 (PDT)
Message-ID: <d67703cb-83e0-4598-88a7-29a69c17a2eb@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
 <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
 <7ce4844c-8025-48e5-a1fc-4d1cf9f7917d@oss.qualcomm.com>
 <b5a6a0a4-4c7e-4fcd-96eb-54041c29ccba@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b5a6a0a4-4c7e-4fcd-96eb-54041c29ccba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXxaMOQqptaiY5
 v+v2Z9mhPvsTCfUPhfj7TGAHXtBWsShEcoSKPqbq4Vo+MotSYbHd3swoVN1WpLnBV+PTJgoTfSw
 smCQ22pok/UvWAi8V5RVqjMlrpuX4Gg=
X-Proofpoint-GUID: Lg6V_Qa0SW-Z5jeNHPqyv45ovEhv_mcJ
X-Proofpoint-ORIG-GUID: Lg6V_Qa0SW-Z5jeNHPqyv45ovEhv_mcJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX/44QYbfUWekj
 1J3PBCXBFPXmSoiy8lrVMY0CPJ1J54ueabekuNl2lrsS8Uq9e4h9LzWJKy/F+V1uN49LfToGo1t
 9H9yLX65/Nbt3WKB1RScrSHtn2klz8CoFjqqlIQhfTqW+fWF+DPytsNQvT6bDziF95L4nm2f2th
 nk8XIeWdJdUuPDjVgNn5LlF5+N47x3fMR1wIi4VHS+0aFby8K/hBB+cWibS50LDgc8fIy9DG83k
 6ErE3ZTEk7EAzxgeNFcs3RUwXw26/V3PvjrkEHLu/UJakGwQRnxgceYUuMAbOL4RHbdaBDCHQwq
 Qjw8DjAd1zy/pDx67KJf0OjyDjAOaxT1N411t/AxEDVMOAInVoNcsOd//0LkYhgwtcgxCQFMdRi
 irmO5tHXQXkK051yC6Y2Bu0A0byobx7UmuhjNxXQx916qkEZ+fh9VEjeKV4rFSfrBM9uiSxt5N9
 PrCJrySyIUWC2HDqdQg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b6724 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=M7nLEK1OKNC5V3jzK1UA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083

On 7/6/26 7:22 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/3/2026 8:39 PM, Konrad Dybcio wrote:
>> On 7/3/26 2:38 PM, Krishna Chaitanya Chundru wrote:
>>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>>
>>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>>
>>> Override the base iommu-map with the expanded set covering all the
>>> switch's downstream ports (0x1400-0x1408 SID range).
>>>
>>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>>> from the PCIe controller.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>> [...]
>>
>>> +&pcie1 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pcie1_default_state>;
>> flipped order
>>
>> [...]
>>
>>> +&pcie1port0 {
>> This port should also get the compatible
> for pcie1 it is not required, only for m.2 connector we need the compatible.

It will be required once someone else makes a board where this
PCIe slot is routed

Replying back and forth took more time than fixing the issue

Konrad
