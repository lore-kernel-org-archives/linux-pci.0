Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5442E8F8
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509302; cv=none; b=t6+2TINsUwzv68UppVxXtwpdaLK+j3GRZ+e1ICxtndFrVT2RkBor1kLWezNx50UQp8a861pPV4iLkTqV9Rocr/ny+wwcght6ZgUhbSP3ZKvfpbtj3/VBI3MUjt4urku4M00jITqw3ET/WsHIdIEnbM8+vKO4J2sMl1mpBzxnbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509302; c=relaxed/simple;
	bh=7HQEZsOlKVsHUcXR0CkTKsFAkwWBvpZRVOVqYNUlxsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TECIX8d+DM6EzMUSL7Qv4kRx0mCQuvtnj9SBn0qtKf1uxeHnrhwsKPBb6AfnklqZ7iBpeorqhkOqTRD9u3c+iROwf9+N/MQCWpdp8ZgFQk6nCBSg5zov6HqvZDSeSBdA7Va+QV4KCMf3g4BaGwCWBLYKr7Pqwo07ChRSzDc31mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBnjN8sw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i56e9jCQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBnjN8sw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i56e9jCQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBd4fW3370921
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 14:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q/Zio3QWGmnJick6iHRgb9kHOYoqIHzuKlZBC+YA5SE=; b=pBnjN8sw8Y/Y1Oq7
	BPQ6o1Rtn1Z1foPn4XKR6mgF3Qo5M7ArmpbLaogC0OzEf79FlP7RgSrmBxaQPI7x
	BLpeATtwEheE/nw+a22ahga3dzE6qLlITTjexa9tFEyD7fq8ikOPQU+iYSXafHbF
	HSC6GZSPLMlpNlLBbHKrK6rctbJgbS0AXh1WjT25Iu+xntqD5X577zqj3k1i0ODm
	blUJoju2cemfDd8VUtz2ce1NaAoUPNCU6NMQaURClIgIwSmGM6pin7qdJU4eOKj9
	4Syqz6lCIn9PGuCoK0Kon1Rk4KDsXmcMP/2xhM16k8VPprlppx/1iOL+dVlCYH/+
	5mULIQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru0y0sn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 14:48:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f08560ea44so13071616d6.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785509299; x=1786114099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/Zio3QWGmnJick6iHRgb9kHOYoqIHzuKlZBC+YA5SE=;
        b=i56e9jCQ3aOPcdSCFMBuCQZQ6Vy62z0GjW7LumIwVlk/S/bGeDffetLe5Q3xKHFL76
         u+kZjFSH7FHcU31V6QQjlbzRo+QnbEB2N+jR7UIi08y2YCOWaG7qpR5VEZD2lghB7wuG
         jDhrVBCoOZcMdfl4+BtHIfgQ+UUozHTOujRNemF81qsptSX+Y+mSC8vJwhGzh8ljB+/w
         1ThlaYjpYMTjsfIh7FhEY91pvbIcbpO/SzfNAxegfl+LL+RIz9HcgkELY1fjTpJBo1ET
         dMIm1RIlH7YofOT5K/8sFG7F6HZ1d+JCD3q+pKHITa/6TCzPSkDmRP/TcpaCC3vUzsfK
         D6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785509299; x=1786114099;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/Zio3QWGmnJick6iHRgb9kHOYoqIHzuKlZBC+YA5SE=;
        b=jU4g4n3zg29wxfR1OVXY8O6KJmu8zFe/BvAMzBJcHiHg+2+Dounu+SrEl8F+8mUegi
         p1AJkrWW4yJ/oItJxl2PR2EMi53Edp0Rarr4JSeqVQ/mzQU1gCGIsWltuL/fYpGI8cup
         Be47cJySP73Gtp1T0QT0a6H7NToiH2s0jjMZ7M79wNHbuPLwlPnVnwbXUJAQ+Np6GYf4
         B0lqEzkvoXBv5ECg7A/sVNmroMgusmv0ENHmxhUGoNILoszDt+qpvPf14RsSXfdVdJyQ
         Sl3YV6hlcHKlERGyg97MF4+ZA9SJhwrQavB+tlIz1hP2TJZnC1nYwV+F6ItoK91hkcNR
         gZEg==
X-Forwarded-Encrypted: i=1; AHgh+RqGXqhvsR3jZ1YMRK5mr1BBeDkh4VwF84YOr/SJSJhSVb/L2qA2fBl96vVFr/axeq6MKKhJ/A0wSO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPP57k4dD8YcMebyamsPB82Tp1jVmWiG9TArndpzM9lf+Y8A/m
	D2o+3iJLePsYs4xRKcdvxgGqU/CGOSw0HAmRA9HNG4ctJLJNFW00Yf+VA2pbwG/6ve7/SygLvhD
	gX9MFeYa3erSmSraKqUc5s+j8oDSdrX9KYj7uHt+++0HwjPk1MzkDdyPUzXa0VcY=
X-Gm-Gg: AR+sD12fC0b9cwJxWVGt4n9PbKBHk1nkqGyXPa0hfyT9lb5E0NFajFKorUjOSzHhrhX
	gSwssp7oOgeEfP8Qsybj33x+7BJrBDUETqS36wfYlYIGvEMTFLoibA3ZuWT8ZDMqLrhnrfV/hMj
	JUIgeaTfXhe3nt9h4PQdNhsB8Pt6n6ofRilgCfRFli/sQaphfYUgjae7a0jYNkWGE9tm/ysPsUc
	omcXDXKUmlJhS1LGdLe+EmobXrt379p0HlMTtVIAgeFImf0VX/MSniokkYrvuEc4vGvwFEkp0JY
	XAy0pnmJUzjEQDZZ80Ywklt+oSnKeGW1ULLxJifC+dOD3bAEenj/wacYixu7kX1BzUGJ7uZGaMv
	fd71crnJ5JWNNXM+lJ9UW9J5LFbpt9ZSW
X-Received: by 2002:a05:6214:449f:b0:8f3:e97:59b8 with SMTP id 6a1803df08f44-908496af620mr580606d6.29.1785509299358;
        Fri, 31 Jul 2026 07:48:19 -0700 (PDT)
X-Received: by 2002:a05:6214:449f:b0:8f3:e97:59b8 with SMTP id 6a1803df08f44-908496af620mr579456d6.29.1785509298665;
        Fri, 31 Jul 2026 07:48:18 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908432a0cdasm11912986d6.3.2026.07.31.07.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:48:18 -0700 (PDT)
Message-ID: <b47345f1-1c7b-4424-9c6b-3dd02c0f4ab6@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 20:18:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <6d61d749-440f-40ad-82e5-e1e909afad06@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfX+IhLE8+hl9l0
 wJLBuwwroDJ0y0KimCHoBV/66AsNriOIkhQWoxfTSqwGQ2voanVem5ZWtxZ8+0LxH2go8ONo4l6
 BY8LlTvbxOwRuimThtR6whDHaWzU+Bs=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a6cb5b4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OkEJUsIZQkPH8Uu3lZgA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfXwpbAmi0/kuH8
 ObcfxVxidZFzGyFwkfMr15+MB6u0TDCWokO3RtZbscRN9DiKbdX38Pdn7EmBU/A+L1tesVnX8i4
 BN9GXABlwG48uG4klqPaTkjb4dGr8iah6ofZqUlcobduArqJTXwZaydfJZ652gLhsnDGbVIxEv5
 KZNKhmxk+eIFiHHWOrNTmOeYD1xoN8wUM0zhH8eY/n91kcus0zVXVM/MXzlNmR5z4ZYbmhGaHPw
 6aiP11eBB5tuhl9upw/wF7SAHtU4lHc7ObVuRN5stRm/CKG3WLjKiWOFDJ5hjPb7XY0zDdgb1Hw
 c6XSI1CORcoQwVkGiUdJt+sPtO9PgZ9io9uqRu5DKmgTEkMWNSJwDrd8E6U1jSVq+s5tU3NPINA
 go92yQV7pvSNOgAlLmDo8ghvtyzhbKTKurOxRBv/0SJnJj8vPDedgwgVkk65b2FyBsbEpzc1pwv
 K2GQKSYMcMCUcQt98yg==
X-Proofpoint-ORIG-GUID: u4UUq6vfEmuxV9p4bE4r-0i8LyR6oq8R
X-Proofpoint-GUID: u4UUq6vfEmuxV9p4bE4r-0i8LyR6oq8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310113



On 31-07-2026 18:20, Konrad Dybcio wrote:
> On 7/31/26 8:53 AM, Rahul Samana wrote:
>>
>>
>> On 29-07-2026 18:01, Konrad Dybcio wrote:
>>> On 7/27/26 5:45 PM, Rahul Samana wrote:
>>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>>>> instead of the default Bluetooth-over-USB path.
>>>>
>>>> Build this variant by applying the common Industrial mezzanine overlay
>>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>>>> connector graph endpoints for PCIe and UART, and disables the on-board
>>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>>>> used instead.
>>>
>>> So is the onboard module disabled? Can we not just use two in parallel?
>>>
>>
>> The Industrial mezzanine variants do not support the on-board WCN6750
>> wireless path. The common Industrial mezzanine overlay already disables
>> the on-board Wi-Fi node.
> 
> What does 'do not support' it mean here? They are physically present
> as part of the SoM, so unless the lanes are somehow diverted away,
> why is it not?
> 
> Konrad

Hi Konrad,

The WCN6750 module is physically present on the SoM. What I meant is that
the current Industrial mezzanine devicetree already disables the on-board
Wi-Fi path, and this BT UART variant followed the same board-level policy
for the on-board Bluetooth UART/PMU path.

For the endpoint labels, I can move the UART endpoint to the SoC DTSI,
kodiak.dtsi, as uart4_ep.

For the PCIe endpoint, the PCIe path to the M.2 QCC2072 device is not the
PCIe0 root port in kodiak.dtsi. In the composed devicetree, it is
behind the Industrial mezzanine PCIe switch, under:

    /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0


So placing pcie0_port0_ep in kodiak.dtsi would not describe the actual
topology.

I tried adding a generic label/endpoint to that downstream port in the
Industrial mezzanine overlay and referencing it from the BT UART overlay.
However, when the overlays are compiled separately and then composed, that
label is not available while applying the BT UART overlay, so the composed
DTB build fails with FDT_ERR_NOTFOUND.

Could you please suggest how you would prefer the PCIe endpoint to be
modelled for this case?

Regards,
Rahul

