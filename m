Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1153445AE2
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512961; cv=none; b=NQYiA11D6gjYZX5FL2u7CeC8ngFeQXMRyUei4Wp4F+FUd4ujXdX2+8EpwCGlyg3hqLhRZ2udhWgKUdE7Xr6IKMdhncAYP15C8kJTdYxd1fzIxaYn7ZhPAbEgTJvieIVlj29SNm4tQzNQA2LOiFFgH39iDAmZPEG7+OfK6lK1GW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512961; c=relaxed/simple;
	bh=HZaAOxwe4QyhS10RuHhDJoaegy/tHhrBOSj7SpXmDTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoG9DE377a40mgoMb2NdZ6PPC8KJthghBkfVCAuXVu2BFhtTZMWnvkGPGixeWaHmyJDOSn+/HS62N6Pr0aLIJOjNc3Ns9ihN2Jxw5byY1GhbAsjYCX+efxNkHnMlX0QixGyPkWsYA3AbcKDGy7gRkLwc7eL0adj75g/ze0QrS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARcSqjOH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AwOa426j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARcSqjOH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AwOa426j"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOOHq205648
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GOcjZ3U0RmFKdMeop8+F+Smw624ct0apDXeG6oe9Uic=; b=ARcSqjOHh86wjwhh
	+Mxr45oXSYBEbOXDn+NyYgKS0JR1h5975DSE3QcJApeNVxrANkceZL4+XnOwe3D5
	ZZkIUPLhgwHDLdPlt6o+k1nRxpvQeUofvP9+CDEuy2jDD4KY4PZMuDojTg/Dyc38
	p+LiEu8DuwecJOT8YKdLafdcEAbfIgQLdYb9Wl/7Y/mhzehfq43W2nN8UYd9jrEv
	u5nrhWPhF5ezwnFmpkh4ABilASL6hs8owyDdjxILPAqVN1yBTyDBvNxffIDs8LP9
	eZ5Y+9S+o0OJ4/Rdix1uliOQt+P40t7FLGF09KRaeSAPLO2xmVch5eXADIUvA89i
	fuwbug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dh2tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:49:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93105103d06so20090585a.2
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785512955; x=1786117755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOcjZ3U0RmFKdMeop8+F+Smw624ct0apDXeG6oe9Uic=;
        b=AwOa426ju68v4ck/ljMn4SVLVVUgUVfA8DvpYGnEnK34+AjUo3jmfhtSe342n0WwC/
         58UBbZnZs1I2VuTITazb8oImkqzUneJuVwZAAgyqTtBtKa/NSg7+83XqVykjA8ctv4oZ
         3L5Kp1TAb/stUfwZ3AmC6TSOMNmPNCw8jfMjOPukSbF0mw10fZn79tB7tae3NI77Iuad
         YLIsHTIFrlcxusRXYW06P+b2kfJSXGDGTKwYcXlODnq78n5w7Q+VVJGmdrIgoQlFGkIX
         P6Xn+2mebhiPpVcEJinaB5yDymLIWiVS6U+/DgJKXqZdTdOAeNCvCJlT1s85EvCzpp27
         S+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512955; x=1786117755;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOcjZ3U0RmFKdMeop8+F+Smw624ct0apDXeG6oe9Uic=;
        b=PV1c9BXMBO8EjxheM7u1oUwzNYSA9in4MipYvFcDH44yJ5HyRVzqmlH+rnBDij8ycy
         giQpogrdBkN57dxOUSf01QNZu6hTCBvQsPRhSkf6FEVb4DuMSbqqksv4Hwl4pqDdzFhp
         HdEekFx/UnE74AIspbeySX6Bx4jUlAeBnMgU/OdD6DmtWeEs5RdPjBuMoDp6zVPM8UBH
         hPpopZGwUQwyb+Pa2i+wy7TRwPXDEXXvI6RvsUDY1Y7cguYROSZ1zsWP1gmQWvAAmSHf
         inqSgzMg9EwOFCjGJZDQB3oEHd5zym3pdA8mRXW4AtWiuEPEaBKates8w/UXZRyUYXWS
         8z8g==
X-Forwarded-Encrypted: i=1; AHgh+RoxZZNB/S0HDv3AlI5YrugwW6JIFQRk00eT9dV9IcgFl0AscSF1u+nOy2uWZ9Qt8XsOwL9VxyVF4EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzavvitWA1R12sO6xiXW/7mPRV7m1pWG/bIiDx6VABeMFzn3eeP
	0V6ra7Ebp27n8pS3vZhfbm81vbvq95PCaLifFVZgyAFF5X2n4Nx1skvzenAXi2Jth0vh/HrTC5J
	RYxe+ILeJGosAY5iJc+f+O9EwPZiES8XeCO0sQfC4FeNSKepjwBmqFmHHJRSOjzM=
X-Gm-Gg: AR+sD13rig8sTSvaGUd7IZcSbQ6YeCHexUKztv8l/QeFG6afnfoSkvF53wRFvgGmeXY
	4EW/XCkZsOWwkSLj7A0OAtb9Qrahkdu9qAlcUH8c9KLDHlCAg9epuJZTNg+pMYAZv+byX0J/oit
	tM6mawrbbCDozx3aWiogJGiyplMNCHHnqNzFj0hzWE5lRVKpaVJU6/mVUG+4u/t0+f0fL/cgLU0
	3SGlTwXWtesDaQcKGs4I8lay9JR+r7rV7zbx9UDbynmOLrP5Q2fhxggL9GGfN2CIsDJILb/bTsA
	tPuZ9Y7/2SkgrYTGzLlH8UXBIN/TMZG56Pe3P/qKkkxu4y3zz33+Zq62dYiBOQ0/JqpeOd0dXb0
	HyhJNZlDigfEd7Ql0FGmDXv0R
X-Received: by 2002:a05:620a:458e:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-934a0951926mr67451585a.2.1785512955610;
        Fri, 31 Jul 2026 08:49:15 -0700 (PDT)
X-Received: by 2002:a05:620a:458e:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-934a0951926mr67446685a.2.1785512955053;
        Fri, 31 Jul 2026 08:49:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c63dca6sm2157711a12.16.2026.07.31.08.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:49:14 -0700 (PDT)
Message-ID: <bf7821a2-d813-4f89-b891-9c26d228ae67@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 17:49:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Rahul Samana <rahul.samana@oss.qualcomm.com>,
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
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b47345f1-1c7b-4424-9c6b-3dd02c0f4ab6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cWGD8aAxi6kn-VA0GKovAgLFBvuttbeH
X-Proofpoint-GUID: cWGD8aAxi6kn-VA0GKovAgLFBvuttbeH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEyMCBTYWx0ZWRfX/k2RC/bk5dZ8
 EHjO9eGUJULKky695OBccb/o5oTQDNX2bntq3nQ9N/3BFitJHKSSnidgTC9pvQ2ZLQfq5ZumKhr
 rVZ5RVs6AGm3gFuLu1i8S4nJHAFs/s+ZSC2BqaNYsg48EE9UE+3lkPHaMKgsZqTKste0l37Dgmz
 UYhNRF2xvshL7YcJAjJTC0cByKY0ecIWW0uoQuQXGvtfTvqxXSQTBcz+R3QgQjZn5rVyTSETGIt
 sU9IKGMNzWNzpRlTNXltdo79cM7wuY1FKZkY/ZcxLZ01N4YeAQP8pFLAdQi8vXoTslSYbR2vOdQ
 CuIocBZ9jK5JQ/v9aC24uv06nuzOYw6rBRol+56hzrkdn66RiOfXXZgss0FKNtP3x3paQZjmBD/
 5ySCIkwfD0XpI6fd+xysu48fm08+n7sxC9J4Zllwgr3WZlCwFsdku8N1ARu/7QEODlKT0sA5CzG
 Eq6k/eGS5Cbz4LwJz7w==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6cc3fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=0iSonUdn8zqV-Tj254UA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEyMCBTYWx0ZWRfX8F0iaWlEfvQP
 o3ONfXnBBIgr3gAXFFR+Lien74m9OzPtCNrYtrt72Q51RWf0nQ9KfRz6v13ZulWU2V+VPUp8AF3
 QH9YlyHgEgdO4Vs5mnYrHc65QkHColQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310120

On 7/31/26 4:48 PM, Rahul Samana wrote:
> 
> 
> On 31-07-2026 18:20, Konrad Dybcio wrote:
>> On 7/31/26 8:53 AM, Rahul Samana wrote:
>>>
>>>
>>> On 29-07-2026 18:01, Konrad Dybcio wrote:
>>>> On 7/27/26 5:45 PM, Rahul Samana wrote:
>>>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>>>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>>>>> instead of the default Bluetooth-over-USB path.

I only noticed this now - are there 2 variants of the industrial
mezz being sold concurrently? Is the already-in-kernel one some
sort of a prototype SKU? i.e. should we support both?

>>>>>
>>>>> Build this variant by applying the common Industrial mezzanine overlay
>>>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>>>>> connector graph endpoints for PCIe and UART, and disables the on-board
>>>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>>>>> used instead.
>>>>
>>>> So is the onboard module disabled? Can we not just use two in parallel?
>>>>
>>>
>>> The Industrial mezzanine variants do not support the on-board WCN6750
>>> wireless path. The common Industrial mezzanine overlay already disables
>>> the on-board Wi-Fi node.
>>
>> What does 'do not support' it mean here? They are physically present
>> as part of the SoM, so unless the lanes are somehow diverted away,
>> why is it not?
>>
>> Konrad
> 
> Hi Konrad,
> 
> The WCN6750 module is physically present on the SoM. What I meant is that
> the current Industrial mezzanine devicetree already disables the on-board
> Wi-Fi path, and this BT UART variant followed the same board-level policy
> for the on-board Bluetooth UART/PMU path.

Okay, and do we know why that's the case in the first place?

> For the endpoint labels, I can move the UART endpoint to the SoC DTSI,
> kodiak.dtsi, as uart4_ep.

Please do

> For the PCIe endpoint, the PCIe path to the M.2 QCC2072 device is not the
> PCIe0 root port in kodiak.dtsi. In the composed devicetree, it is
> behind the Industrial mezzanine PCIe switch, under:
> 
>     /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0
> 
> 
> So placing pcie0_port0_ep in kodiak.dtsi would not describe the actual
> topology.

Yes, that was an omission from my side


> I tried adding a generic label/endpoint to that downstream port in the
> Industrial mezzanine overlay and referencing it from the BT UART overlay.
> However, when the overlays are compiled separately and then composed, that
> label is not available while applying the BT UART overlay, so the composed
> DTB build fails with FDT_ERR_NOTFOUND.

I think this generic description is simply not achievable today without
a bigger plan in place

Konrad
