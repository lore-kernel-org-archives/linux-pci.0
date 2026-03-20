Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0130AD10
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773970832; cv=none; b=hJdmYLXtw6amj/BYFYTloNHm717JZJ9bJQ9iigS6/l2jmki/6dOvcOHF9DPojCfs/uzAsVaCs8MT7Ut23UtgOKrcA2yBoSfnwknEp46r+uJtUP2J38gTYVSUBdp7ewXO2EESSNN2S3IFQZaGj+iYc6OYfxdoU26FqqkSY6jT3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773970832; c=relaxed/simple;
	bh=EmF4+PIkkPw29/w3CtTjt4RBSz9+WNqzJX1jd/3J/uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptc/YlK12JeGvjsdGo53GsvUntkE0tX2Dz2ewiqFrB45bjUX6mH60xecGx1qviwLsuYge2pWFa93M2ZTv6FWr779b2pWBTfAq3Y1Jio59XyuHDFTT/LBCdOpYiC3ytRlGdR7HKVOwDIfYVy4ENgFtPXp4hzWwLKZhn2cFZsiAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B63qgP/S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cXqdoed+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B63qgP/S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cXqdoed+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JNV68C3648193
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 01:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0v/eVwvU+bDCzPfj8Olb6vFjTl5BLngWw4b7/4Nn43c=; b=B63qgP/SVzIHrbK8
	1Xom4BQXVmqlzJ3AHRwR82GrEHfXVoTp+6kFoUIAnf+mED9yDdNHzfjNAkDtgAqV
	A2sY2gG6K1iaCSlAD0vYoA95Z7e8lyFXqCpJmJPeXxxK+IXeV+V2n88QUKGOeoil
	OHeO3DaoYYYufcRiwQnx1/u0bZ2kf4AAhFLsnGzWr3PZO/Qrt2QfM+38UMYmpxMU
	Ghg795xgeUcGzPgyC/Gj2AAnLRsulPrqpMrKCrOamsVI93XdKp7823+C9xG/3yWd
	mffKT3z68AlC4Zk55+jEsXwUK2CZof1qefyf+UPqfr71ACmpxpZgA4hQ9b7S+1iP
	v5WjTg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0v9vna-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 01:40:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-359812e4fefso1988362a91.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 18:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773970826; x=1774575626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0v/eVwvU+bDCzPfj8Olb6vFjTl5BLngWw4b7/4Nn43c=;
        b=cXqdoed+m4m6axmnMSD9HuOE3hzHPXHqmbTlPEwp/Ump2mIhcxD2at/H1YZxJl1ExI
         ChNVozccKTqNEB3iRGTGXgryEIBuTUk8kf7EIc/fCrHsDvZIVGbEzIHgqmpfC829SFCb
         /UmwPhjUoLflaMbTE0/nsidJRXJCewtcpx+SZpstIj14sWAwsFFr0FHDjJJdIalyA3VF
         gM7njcCSaWfpEHwI6sa+F1c/9NRH7YuzlGauG27WojfIuYThqGZE+/Hw0litGo4SfCGA
         dPdKzC1ZglHzaDqNeB55mw2/2TTwqCbXzY7+WQ47zKXyOo7th9gTHz7ahVPryChVKzsN
         Ultg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773970826; x=1774575626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v/eVwvU+bDCzPfj8Olb6vFjTl5BLngWw4b7/4Nn43c=;
        b=kwAVBJ7WV8HDcqj4pN4dLTIgIwwWd/4m3vq9O7y+VeSwzv3IViPDyzN2TL9KvPQnzE
         U/ttXmCgacosUlkV7brHL08tVGUN4a/M2jnsVpGbfVUz8EBpeBTFw12ziur8IjgvXCBW
         9b4JryHLEA+WaubqZftiDuEIA1Z2vvgsI5NxpmJZQ3n9gWsLkIq0K16IRnHiXWop7hnp
         AQfIDVVrjUnvhWxa0IIhhZ1Y18XR11EWTYuGUf9s8O5t0CONfYozRCNOzJyW4pgjlKf6
         S/d6zLBQbmKs4XMOsnFOKFmPq9REdJ6z8fjh9pwJb3KCrbMpsuG8JwSHSCsR35F8BfHd
         9tUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOEt8ts5GWwWmK1jLNHLLrwCulQVnAd1yBA7rakdDL77YvE8EiWyxHN29SZMQdaRhypopjkb/BWqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJTkfZWLsuMESDjY9i+2kqpx0b7IIXzurJ5IgcXxI0+38Elzr
	9yOrG/Nnb3ByKMZWcebFdtxWgQv+0+shT0gfEStuHhyBpYwJnsSjs2Cz1M0D9UUR6FJhic1Tvpe
	bXA4Gpogs6hfDKffx5c//ICBnMzf5J1i68NCM8jGu3UgPd+0VH7Ejm/li5B3ypTs=
X-Gm-Gg: ATEYQzzur7K+URprkr1uX7R2CS0rIbPUf893oXALZgkPs60XBQ6lluqJiuqnvvPD5E6
	n2QXYf77Dz626GRB9af1NOKqXb7ClQ5psN7NxAkXR1pc/BJLDWeHJgVuwvR8g66GHd2XyziJ6HW
	OfdvN9DjnFxvcg9DdtFI3qILkFXrJSwiKYxZ5p2/N3NdeDsNUiROUGjSfCCmwY7Nk3slaAEarWy
	AOwxP5RWVY03WAS3YyEkKJHnnJ3hwA5e3r161kjNoSrJ/78V3pTPWsOhR4RfMmzg3fOvcH+MWLE
	IC+veplWxfakHKdcrzIbS1fnKa25evT9ig2YdnjeKMhmyX4sq9sAVJL6WdssiQG0Y1bsMi/ekFN
	uCi8K4qt1l3ccC8Kexrs4earbjN/f41EOc+kJRiT1/r7iYxbCAPVRYXU=
X-Received: by 2002:a05:6a20:3ca8:b0:398:ab2c:a5bd with SMTP id adf61e73a8af0-39bcf249a8emr1097356637.21.1773970825996;
        Thu, 19 Mar 2026 18:40:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca8:b0:398:ab2c:a5bd with SMTP id adf61e73a8af0-39bcf249a8emr1097332637.21.1773970825514;
        Thu, 19 Mar 2026 18:40:25 -0700 (PDT)
Received: from [192.168.29.63] ([49.43.228.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm468106b3a.37.2026.03.19.18.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 18:40:25 -0700 (PDT)
Message-ID: <4649cbd8-7128-4c24-8d8d-c12bfd2a677c@oss.qualcomm.com>
Date: Fri, 20 Mar 2026 07:10:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
 <t66kmmr22z5anjhhez3mwfbmy64pz5246e4oepvpwf5j5l3u5o@i3gsh22x4dst>
 <015d00db-9ed5-45a7-83f8-1b10bc2ee457@oss.qualcomm.com>
 <e94f9da7-3daf-4393-9455-6707cb963e0c@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <e94f9da7-3daf-4393-9455-6707cb963e0c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NJ6C3UprH0FNDHtSJ2uI7e7T3ten8XHM
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bca58b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=B7CTsV8aGTFndON/lcHZzA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=p95sTTYnDXT8MWe50-wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: NJ6C3UprH0FNDHtSJ2uI7e7T3ten8XHM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAxMSBTYWx0ZWRfX8R9Lx606YUJT
 03r+kMm6Xd3jcYZe7+B0pNstRmiZhtY+okYAqy38Tldx6XAFKDt9ImQGH6KmFFs4HHr+vyaW0gQ
 Z1xmHOAsPlWnLav3tGR7P6ydCkL13vB8jkCjP7T1vyaAr1TtUuU/CgW9lrecKaIKhwAntChPsx/
 WAdheZRtbHcrGU5ymOCntXA2aPVAbIr6SmdajZjuU0JVrZbU4t0E0vqQIg3UlyRux2dWzt5aElW
 VAyVPFeaJeNBNhmXJ39DAyB1FN/AaBQqJGXa+ph2Chj1+/er5Yy7cwm+mGT7YG1Z4RZeKKrVbGh
 2vj0VHu6XJRkxGCeb2lEoZIZKCNXl87rKAA5rHbgcLzKJPI9GBplQNXueIHdSee4s1NVqnPsWIo
 XtVr8VLWL79ECAvLWAOReZfRjajZg0B72kRAAHMhxfHi4avRR+yOREMWx3Qrv1eLW4pnljIbMrP
 v7STt6VbomZoq+XNrFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200011



On 3/19/2026 4:29 PM, Konrad Dybcio wrote:
> On 3/16/26 1:22 PM, Krishna Chaitanya Chundru wrote:
>>
>> On 3/15/2026 3:39 PM, Manivannan Sadhasivam wrote:
>>> On Sat, Mar 14, 2026 at 07:26:34AM +0530, Krishna Chaitanya Chundru wrote:
>>>> QCOM PCIe controller advertise hotplug capability in hardware but do not
>>>> support hotplug command completion. As a result, the PCI core registers
>>>> the pciehp service and issues hotplug commands that never gets completions,
>>>> leading to repeated timeout warnings and multi-second delays during boot
>>>> and suspend/resume.
>>>>
>>>> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
>>>> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
>>>> Capability bit entirely, which also disabled all hotplug functionality.
>>>>
>>> Just some background: I added commit a54db86ddc153 to disable hotplug for Qcom
>>> PCIe Root Ports since we were seeing completion timeouts for hotplug commands
>>> and also the PRSNT# signal was not exposed on any of our SoCs. After checking
>>> with some internal folks I learned that hotplug functionality was not exercised
>>> in Linux. So these facts made me believe that hotplug was not suppored at all.
>>>
>>> But it turned out that the Qcom Root Ports support "Data Link Layer State
>>> Changed Events" such as DL_Up/Down events.
>>>
>>>> Instead of disabling hotplug, mark these controllers as not supporting
>>>> command completion by setting the No Command Completed Support (NCCS) bit
>>>> in the Slot Capabilities register. This prevents the PCI hotplug driver
>>>> from waiting for commands completion while still allowing hotplug-related
>>>> functionality such as Data Link Layer state change events.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 67a16af69ddc75fca1b123e70715e692a91a9135..a2924610f3625f2456a491473c135840e31bafb9 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -358,7 +358,7 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>>>        dw_pcie_dbi_ro_wr_en(pci);
>>>>          val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>>> -    val &= ~PCI_EXP_SLTCAP_HPC;
>>>> +    val |= PCI_EXP_SLTCAP_NCCS;
>>> Are you sure that this is the only non-supported capability? What about
>>> Attention, Presence, Power Fault, MRL etc...?
>> Even though there no signals required for attention, presence etc in the hardware
>> there is a way to generate these MSI's with these bits set through parf, so technically
>> so other co-processor in the system can trigger interrupts.
> Are you saying that the RC itself will not generate them based on what
> happens on the bus, but they can be triggered artificially?
Yes there are parf registers through which msi's can be triggered 
artificially.

- Krishna Chaitanya.
>
> Konrad

