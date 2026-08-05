Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC632C94A
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910742; cv=none; b=sCeb2/JgtTwhfxKZVdCnm6eaI1cNFQRBWrkrDjpDyroI8h4C71/71hRLLMf/8dV2UHUF9yXEHb0EOdrBQVjipUOnrd9j3pyCIFsFZSmTVjFzm0xTWbL0KQXoTMCeYUhc8wnMtOs49eVjE+O8x3oJxVDLyJpmHk3G+CW4n1EFXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910742; c=relaxed/simple;
	bh=MbJ4xQgIXo1xsWEFSQw1SlfI9A5LaPiERjRMt5TCJJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLzuOLHxr2lFv3M7Vj9J525ktPFUZ3bDhYRavtKu91zbNjtzp/o6HF0lIpUQS7HoGDVY8MoGWLyYPp7X2xjuLZcCJnsFIYRB1sIPZDI2i2i+9KBmcOCcakb9obATN/3otMpr0xbzGx6yg22zZhG7FTrvJBUybi+8tB3GOT9doMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bGfZgjCP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QbQc9coV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bGfZgjCP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QbQc9coV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755lAhw1951005
	for <linux-pci@vger.kernel.org>; Wed, 5 Aug 2026 06:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IUwwlRJ7oVartoiGymz2Uz94bLku19J9MoLLo0EivII=; b=bGfZgjCPLEsdbuX0
	y2IqEjjJ2DAuvYcFOuXiQ2jfAkP4ncf8ZxNZzpDceIEwJduml2aBH1KlcgDj1NhC
	A3VF4ajOodZhenUEq8Noxsw7AOS/4OK2MXYNziibP9FLpESvSQIOHc99HhhongMQ
	Ew0A61aw+rSeyY9Xh4EJIyYksud7MmEmE7eNiFWybFJNDKq4y8Y4pitEG3bjBNOt
	IaowQvGmK1KOAW5E0b9zqT20soR4+3Uxomit00/5o/ilti6m7JE7QbX+YJLBaI5u
	K5id3rUMiaMuTlbAxyVfJMY69RPSiGw39oaISC6xx5AergGlkB2ZlgE3YwEm0xH8
	2Fb7bw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3ntxbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2026 06:18:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so1373744a91.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 23:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785910737; x=1786515537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUwwlRJ7oVartoiGymz2Uz94bLku19J9MoLLo0EivII=;
        b=QbQc9coVQPRTRH+ro1Vr417S/ouEUO/a3VAuCqx2+OFKHK8J08hFaaF4JJKp5e49+i
         6xWRQAeizLcifnbXsJGGs2vcgFHKGnTqdDHO8rRg9E089UBu4/07+oL7jGpi85J9xcu3
         g8ap1ETeQLRw4oZO27Y6Y5QJif5uJh5yaSMLHYJj6pK/1Y5dX6WtsxNoIWGf0IuWbzkz
         93YRL85TMMgQKZHWtdST//TRiIt4dcJ7Rfk+F7v2WxVCWm2zRvl1VNGnjscM9eQvT4of
         lXwhadkIwa3qy+ECF4/ykG8vXptv1p+KKLtM+Rjj654AkBuRnF5Z50ALPcuKv71e2ge6
         KzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910737; x=1786515537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUwwlRJ7oVartoiGymz2Uz94bLku19J9MoLLo0EivII=;
        b=pKFW6QHbPLXsiwJtxDlh9N+VhvhmB1pev7dPQONxOup8oyOxSqVVZxE3EeaXQWy7cq
         1I4vtnnnQHnwns6+cWQdQNUN5cQ6/YRTAblKBCcI8P9JOZC2yDNy84/Hhqs7kedinvel
         h5hviZ1qJH9Wan74/0+VZEKXrKdtxaBkpNVnHu9AqW928X/ff/FyTELz6yQ0bw/21NYY
         51RYfCN9FeqU46FS9ovnICG7pLYvBEFHLl3JfGrSjpep2Dgs7NWpy8GKGuvsBm0v2FF+
         f+wHzmo7v6U8MmJCNp11j63PcgJ3biBohFEZU4eba2ZYfiDSJk6L8xq/lUiOZN4ybstL
         FNWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVALUhty54AEk+6m9XdpVDcFDFNJRV94uRZlfqQNp8OLMr5+d22rYaYFNO1rEbuTvHKzmrWDHiZYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJifaUPCEtCv16aEYDh/zaAtNHJh96v7UvlmglGBjrDDoGdmJN
	yPg0r9LQ/kMx5qk0tE+/0QF9COkJbCEQPVRAsUXYx6mZJlQ9xikbr9C6IaG35D3pugxZBwP3szl
	aZN3zAhbPspc7eRw2lh+LDGgx9EhuafViwq1rsPy4QsR+eFn+aDCO7VT+O0CXq6s=
X-Gm-Gg: AR+sD10X8swpVaEqnUf3jqH/whOrLvbVn/aq4Amlgdvwfn+zlIECsiJL+RtRWC2Mf22
	DVYFA5M7rwMvdSSG1sNpifuWr3rihZFgGoHtAS7mXhf3s/a0FkiMZzm2fUchTHfjJk4Ab58S4o3
	HjMifdQdVUyaYt0cHQjNVjUSDJKUaxh2h8HSZwVYz3HkwYhIpqlkWcILKs318xQfwMb/+wZQZ+U
	3iXQIuJzuZ6O2kSnxHWtI7dn8FPXtZNrzZoTRil97IGDlb+I/6XSo7XQeWnAd14Wjh0yn9IZ9AT
	v5jRavsYq+OOY5Yk/WmeNB8HJO7pv6N2Deb4ASsGwr2QE3469dDw9qs67oLQSA242lHhZxeITOU
	M75/F37Dpt5zbIgGL8ZXJEY3bEqHdSDI=
X-Received: by 2002:a17:90b:4b87:b0:37f:c2a8:ce45 with SMTP id 98e67ed59e1d1-3903c537d5fmr4245631a91.4.1785910737430;
        Tue, 04 Aug 2026 23:18:57 -0700 (PDT)
X-Received: by 2002:a17:90b:4b87:b0:37f:c2a8:ce45 with SMTP id 98e67ed59e1d1-3903c537d5fmr4245550a91.4.1785910736859;
        Tue, 04 Aug 2026 23:18:56 -0700 (PDT)
Received: from [10.217.252.136] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febe308dbsm3451025a91.0.2026.08.04.23.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 23:18:56 -0700 (PDT)
Message-ID: <a86124c9-a5ff-4265-8a14-68b25f010577@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 11:48:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
 <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
 <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
 <6d61d749-440f-40ad-82e5-e1e909afad06@oss.qualcomm.com>
 <b47345f1-1c7b-4424-9c6b-3dd02c0f4ab6@oss.qualcomm.com>
 <bf7821a2-d813-4f89-b891-9c26d228ae67@oss.qualcomm.com>
 <b5afd21c-4516-4a8c-bc8f-6598ec385d27@oss.qualcomm.com>
 <am6572YrbAULTa88@baldur>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <am6572YrbAULTa88@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfXy/8z8K/rK8bi
 ubI86IRA7Kv8COCf0DG+WPkS0nk7DZe8KUBwQ6d2uM6tJziVpQVVB58ZkBYyr2/X39cQq/qrT6Z
 FmL9nHcnZ5yaTyN5yz/FC5B0F/02zA+vXhJXsrkzkKnqd3IvRYPrDQVYFnMYs0fuz9nSsXqWelk
 +hXxtml1ZRI31MWdxzJCPUAvpnQM3UGVGScTfaO6YtswnyzeLJfDkr9iQngIzd4FGN+Zy4AgXYP
 bqxVodxoZn5ivTExQ10kYr8mhhOkQRhzT/7IFmF3E6L3mLeLlTDh5rPMGVNVqq6eeDSBAldUALV
 mZnVzNfKXOUk3iuEDwLmjt0UY6DDGz8I/DBz4SHJybQ3j27JLHPJHfbAxy1p0hx+N0xXTqBy3Us
 VzLH92O208bl9/1oZt/pcSnowuZ/XbiUGGsA5ErKiiygBSvwRuCm7SanSxPP8+BgGcidn8e2ius
 l+VPRV3WpiiFYJZA3YQ==
X-Authority-Analysis: v=2.4 cv=AZqB2XXG c=1 sm=1 tr=0 ts=6a72d5d2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=kUy7bicM43VmfkegJQAA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PIKoMiikx_sVpCs96lFW3a9Wofzc5iNQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfX6UidqOmP1ABI
 uK3wIzaQiT9i0rXU5oT3Lqlz6KKkYSL8ZD3jrq9CWcSDTKvV+C1lJeyFSCLAtVMNPvlQC3CHE0r
 97l4FwQ890GL8t4AxCWNAudDjmmTfcY=
X-Proofpoint-GUID: PIKoMiikx_sVpCs96lFW3a9Wofzc5iNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050047



On 02-08-2026 09:08, Bjorn Andersson wrote:
> On Fri, Jul 31, 2026 at 11:20:07PM +0530, Rahul Samana wrote:
>>
>>
>> On 31-07-2026 21:19, Konrad Dybcio wrote:
>>> On 7/31/26 4:48 PM, Rahul Samana wrote:
>>>>
>>>>
>>>> On 31-07-2026 18:20, Konrad Dybcio wrote:
>>>>> On 7/31/26 8:53 AM, Rahul Samana wrote:
>>>>>>
>>>>>>
>>>>>> On 29-07-2026 18:01, Konrad Dybcio wrote:
>>>>>>> On 7/27/26 5:45 PM, Rahul Samana wrote:
>>>>>>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>>>>>>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>>>>>>>> instead of the default Bluetooth-over-USB path.
>>>
>>> I only noticed this now - are there 2 variants of the industrial
>>> mezz being sold concurrently? Is the already-in-kernel one some
>>> sort of a prototype SKU? i.e. should we support both?
>>>
>>>>>>>>
>>>>>>>> Build this variant by applying the common Industrial mezzanine overlay
>>>>>>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>>>>>>>> connector graph endpoints for PCIe and UART, and disables the on-board
>>>>>>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>>>>>>>> used instead.
>>>>>>>
>>>>>>> So is the onboard module disabled? Can we not just use two in parallel?
>>>>>>>
>>>>>>
>>>>>> The Industrial mezzanine variants do not support the on-board WCN6750
>>>>>> wireless path. The common Industrial mezzanine overlay already disables
>>>>>> the on-board Wi-Fi node.
>>>>>
>>>>> What does 'do not support' it mean here? They are physically present
>>>>> as part of the SoM, so unless the lanes are somehow diverted away,
>>>>> why is it not?
>>>>>
>>>>> Konrad
>>>>
>>>> Hi Konrad,
>>>>
>>>> The WCN6750 module is physically present on the SoM. What I meant is that
>>>> the current Industrial mezzanine devicetree already disables the on-board
>>>> Wi-Fi path, and this BT UART variant followed the same board-level policy
>>>> for the on-board Bluetooth UART/PMU path.
>>>
>>> Okay, and do we know why that's the case in the first place?
>>>
>>>> For the endpoint labels, I can move the UART endpoint to the SoC DTSI,
>>>> kodiak.dtsi, as uart4_ep.
>>>
>>> Please do
>>>
>>>> For the PCIe endpoint, the PCIe path to the M.2 QCC2072 device is not the
>>>> PCIe0 root port in kodiak.dtsi. In the composed devicetree, it is
>>>> behind the Industrial mezzanine PCIe switch, under:
>>>>
>>>>     /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0
>>>>
>>>>
>>>> So placing pcie0_port0_ep in kodiak.dtsi would not describe the actual
>>>> topology.
>>>
>>> Yes, that was an omission from my side
>>>
>>>
>>>> I tried adding a generic label/endpoint to that downstream port in the
>>>> Industrial mezzanine overlay and referencing it from the BT UART overlay.
>>>> However, when the overlays are compiled separately and then composed, that
>>>> label is not available while applying the BT UART overlay, so the composed
>>>> DTB build fails with FDT_ERR_NOTFOUND.
>>>
>>> I think this generic description is simply not achievable today without
>>> a bigger plan in place
>>>
>>> Konrad
>>
>> Hi Konrad, Dmitry,
>>
>> Yes, both Industrial Kit variants need to be supported.
>>
>> The default Industrial Kit uses the common Industrial mezzanine hardware
>> description and continues to use the existing Bluetooth-over-USB path.
> 
> "Kit uses the common" what do you even mean?! The mezzanine is a
> physical thing, it doesn't _use_ anything! The mezzanine exists and the
> DeviceTree describe what it is.
> 
>> The
>> reworked Industrial Kit variant keeps the rest of the Industrial mezzanine
>> hardware the same, but routes Bluetooth over UART4 instead.
>>
> 
> Does "reworked mezzanine" mean what it usually does? I.e. that you have
> taken the mezzanine and modified it?
> 

Hi Bjorn,

Let me clarify.

There are two physical RB3 Gen 2 Industrial mezzanine variants that need
to be supported:

1. The existing RB3 Gen 2 Industrial mezzanine variant currently
   described in-tree, where the M.2 E-key interface routes Bluetooth over
   USB.

2. A reworked RB3 Gen 2 Industrial mezzanine variant, where the
   mezzanine board was reworked to make the existing M.2 E-key interface
   route Bluetooth over UART4.

The reworked variant is a physical mezzanine board variant, not a
software-only configuration of the same board.

The intent of this overlay is to describe only that board-level
difference while reusing the common Industrial mezzanine description for
the hardware that remains unchanged.

Thanks,
Rahul


> [..]
>>
>> I am open to other suggestions if there is a better way to model this within
>> the current overlay structure.
>>
> 
> I don't think it's possible to give you other suggestions as you haven't
> described what this thing is, you just explaining how you're hacking
> something together and ask us to help adjust your hack without knowing
> what it is you're trying to describe with your DeviceTree.
> 
> Regards,
> Bjorn
> 
>> Thanks,
>> Rahul
>>

