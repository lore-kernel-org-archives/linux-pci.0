Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DE1EE7D5
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777865862; cv=none; b=Gw2qarpd+AbcwWLNBzHgeV3c7j+q2m/j4/kbKqW7QFQfdeycJtkfFuugOGXiwtuhuSVa1+P/gTFMEH1oPTnqOWUV2Lp+bzAkH9z0rDJJ0lgi+44oF/cIP28EP2qrBLYmEFuJ8l2qQLqFmcunTGZdmlxslGqFZ7m+myr09oPQqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777865862; c=relaxed/simple;
	bh=65H9iGGksz147PfSdMd/HPgB2A0hmOqHXAmhvGjSwVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jb2HwTPS+YuXC+YBkLO3blYrrduWcUgD1dA0ZiHsWktAcSKRnFrzeI4ik792O23JdfUfdiWSa7StVKNPQ40LI/yeWl5iUGhmyG8DWJet8dq2IaH5ZCzMfDhrBjkg2FqAWHLa2ZJcuSO1gsN2oHrMbqV3v9E5Zyu0oUzWvX6Idjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KCS8Y5Sm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dG04g+Ax; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KCS8Y5Sm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dG04g+Ax"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643IufRX2102519
	for <linux-pci@vger.kernel.org>; Mon, 4 May 2026 03:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RiZ8ZehJHOgAnZPUtOhC/yoFNONpm3oh1RebvCBkpKY=; b=KCS8Y5SmYxUC30M1
	aqpNDzduiNY6aSVBKCaoi9O1IfwNdu1iznSJ+9MzyEQIADutO42fRiWjzmC8ynz0
	5yWm54y2bIi4btq4TH3+GYVqv6ioY7HYao6HgzXtpzg+ruBerC6msAELWz8Q6PaG
	qUVAGj318pxH1mF2qNxLa9A7/CK0WHzkHmgYMV5ssGwuWBf2OVUz6SbRdtlt8BzH
	9loQUB0xfAckuTOC6t4qwoWz0+BSPtfFGP0qu9jl6ztHnDR9Fc6dN4QbN0hjPOEh
	hPkGZKNl6IhjPWVNMjjSJjhfkZNrwpASaP6x959cWcWQLgRDBnvA7f0milTPXM9Q
	uFqviw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9g3m4bg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 03:37:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so2932603b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 20:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777865859; x=1778470659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiZ8ZehJHOgAnZPUtOhC/yoFNONpm3oh1RebvCBkpKY=;
        b=dG04g+AxDlrOCrPFA4dWaFgszj4pVc3yYfjJq78+2rNj1CrX1paVbnDJ2lhIZJqJu8
         oRcVGxvGUJpO9+tI5Air28PSeJ/ZrpAE3w88wQtBXaN1Zw7kMmpYWxafsda4JrbC7N47
         lftq/6joV/6Zo1ZbKEvV/ixDAn2n5v9YTHlSzfgTcaw9nQ3sqWQhXwCv0g2/eNlz9y43
         jKCUh547z1GsA2yYYlFBKEdA+t/n5MCqXAN29Cu6/M8+ekHW2nY8b1cMZj8hv0AXrXHu
         oSk/hEHriWMkBQBeC+P3bQUyR6SAi+p7japRlAaPibelFuwJN3r8oTq7fvePsIgdXWue
         vYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777865859; x=1778470659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiZ8ZehJHOgAnZPUtOhC/yoFNONpm3oh1RebvCBkpKY=;
        b=SUN1qcVKD6S9yjR7cU9c9nDg7/dHFfeIR8zmwkvVS5nICM96LBTII4BHLMUpxpoW2u
         aF4bYU14QHap292pg/r5J+aV1Ccd9QkkE3RgivKAPkiFtyQ2JFHb8qZUtxlPf9J8M8sm
         z7Vrbrm9tHGJ2CELyebbMuwr6UnT06VsHhSmArmuIltjGorP2MW6hW2b0G49CrM67PB7
         1/COdaLtbtq27I0t6bZKqYVHDSQ5EAVW26WjePGSbKN/5taozBPad4RkOiVwzZJnJZBr
         itY3I0GwkwjiRoEAIUzPLEi2htHxRcRZ0YEBO5A6Nmz3zgJmCeF8l+ZTdi7aSxK2uCZE
         H1pw==
X-Forwarded-Encrypted: i=1; AFNElJ8kMz0c2R73TLGFQbksuO3y5hgJeFGheBRQl7yBXeHIA2piRgJCFThS46aei1oF4dw6j4EMoiPEYrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLiYik3gGgBgIVz0fZxNblvglqEwG3FCvPi9cAHs0fRn0ggC2Q
	5aENruIcGSOozuzFA1U4Ojd8V62aoOsnGNPgm/AhIyXwk7ZeROTDI3YBrtblZO+xaBfwKGohNNL
	9CeglgXcCdAjrWeo2sr/plBDbBYcxYR/ZpdEJQuBKby8z/Pz8UGC7XFpgdPwekP0=
X-Gm-Gg: AeBDiesOeErw29vxF8PMTKgbdPcyIgEamX0oDdwVe3Gdrt6cX433f8bEg00ewuRLcw2
	i8DWXHo4zDxoB6GjfyqkGdn+w22+ow49V0BB56zUttPaQQ7SMPAMz2f49ao1mfLAtWohP8IdN8y
	DwBllW/SqCwljviaaarK8s7fJ9iudc01dAE5jasjN0NbgozKpRxS47fve2g7vwKKTDCKBnbpsVh
	BJQvQM9XXsiSWmvBdRcy2CrRvmV8GcXyG8Ht5F3soaRq80QmTdbnLlwuhK7QyJ7oaXBWMXHtZAE
	c3Nu1ROyQdzmBWCcWvqTt/Demu3iy3vVOhJGl5I6WnB2IAwfukw1l+88MrvmDD1woCPFbqD5Dhj
	6o0F5FfHTnFhr8FLKF5pOXBpJhjiQm4NnjBHCPBHPHjuOCGkqfAiYS9Tcw/orYhLbVQ==
X-Received: by 2002:a05:6a00:bd84:b0:82f:39df:dd54 with SMTP id d2e1a72fcca58-834fff00167mr13681844b3a.8.1777865859267;
        Sun, 03 May 2026 20:37:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd84:b0:82f:39df:dd54 with SMTP id d2e1a72fcca58-834fff00167mr13681818b3a.8.1777865858697;
        Sun, 03 May 2026 20:37:38 -0700 (PDT)
Received: from [10.92.193.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bcb99sm11045688b3a.25.2026.05.03.20.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 20:37:38 -0700 (PDT)
Message-ID: <dd4dc11e-338a-4d13-9830-095a93187f4c@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:07:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI: qcom: Add D3cold support
To: Steev Klimaszewski <threeway@gmail.com>
Cc: bhelgaas@google.com, bjorn.andersson@oss.qualcomm.com,
        jingoohan1@gmail.com, jonathanh@nvidia.com, kwilczynski@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
        will@kernel.org
References: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
 <20260503203008.287559-1-threeway@gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260503203008.287559-1-threeway@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDAzNCBTYWx0ZWRfXyfCus1loW2IA
 iqZg2z2wu/+XUjU7XaEvq+7cPu1jeDN/qPWX5J+Mox9QIpQxSTL/J0NhHZmqQnjUw+MRmPfbJCa
 9331+5iexMyIGkMD6Hbhns//g3nCu7Kn6xnv4F4IxtO6gfBshKgeKCwX0GDK3H8elZkQJu1/Jhv
 /H1h7AlEAii7G3LTs/wrrmbRhchczqF0uqJxPmkAOuas00HfpPEOh71qmAXFKhr193m8fr7auRZ
 rGDZftpYqeUgX20aitK28HcufoLR7KurGdnv1GcY3mCANJHznXWROUaqUuVJiWU0vayhtiflDeI
 eDyAur4AxF157n3TzjzsJrLZh9NoytSCp/EDT+hqZscSgXQ2PsCgSxax7dwiY4dVsPSVqbF+a26
 Wupwy/4EeiL0r18hDMkEIOC8SoEZ1UMEe6xEImNKmqRT7YC9uR39wvv29pGxVU0TMNDLcXJe6GD
 I0Dw8npmWzVBZHJcyoA==
X-Proofpoint-GUID: J1le94OhKcpDR9kqlfvxRQiA4iywasSj
X-Authority-Analysis: v=2.4 cv=Ge4nWwXL c=1 sm=1 tr=0 ts=69f81484 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wWH99FW7VD-f-Ch3qS4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: J1le94OhKcpDR9kqlfvxRQiA4iywasSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040034



On 5/4/2026 2:00 AM, Steev Klimaszewski wrote:
> Hi Krishna,
>
>> This series adds support for putting Qualcomm PCIe host bridges into D3cold
>> when downstream conditions allow it, and introduces a small common helper
>> to determine D3cold eligibility based on endpoint state.
>> On Qualcomm platforms, PCIe host controllers are currently kept powered
>> even when there are no active endpoints (i.e. all endpoints are already in
>> PCI_D3hot). This prevents the SoC from entering deeper low‑power states
>> such as CXPC.
>> While PCIe D3cold support exists in the PCI core, host controller drivers
>> lack a common mechanism to determine whether it is safe to power off the
>> host bridge without breaking active devices or wakeup functionality.
>> As a result, controllers either avoid entering D3cold or depend on rough,
>> driver‑specific workarounds.
>> This series addresses that gap.
>> 1. Introduces pci_host_common_can_enter_d3cold(), a helper that determines
>>    whether a host bridge may enter D3cold based on downstream PCIe endpoint
>>    state. The helper permits D3cold only when all *active* endpoints are
>>    already in PCI_D3hot, and any wakeup‑enabled endpoint supports PME
>>    from D3cold.
>> 2. Updates the Designware PCIe host driver to use this helper in the
>>    suspend_noirq() path, replacing the existing heuristic that blocked
>>    D3cold whenever L1 ASPM was enabled.
>> 3. Enables D3cold support for Qualcomm PCIe controllers by wiring them into
>>    the DesignWare common suspend/resume flow and explicitly powering down
>>    controller resources when all endpoints are in D3hot.
>> The immediate outcome of this series is that Qualcomm PCIe host bridges can
>> enter D3cold when all endpoints are in D3hot.
>> This is a necessary but not sufficient step toward unblocking CXPC. With
>> this series applied, CXPC can be achieved on systems with no attached NVMe
>> devices. Support for NVMe‑attached systems requires additional changes
>> in NVMe driver, which are being worked on separately.
>> Tested on:
>>   - Qualcomm Lemans EVK, Monaco & sc7280 platforms.
>> Validation steps:
>>   - Boot without NVMe attach:
>>       * PCIe host enters D3cold during suspend
>>       * SoC is able to reach CXPC provided other drivers also remove
>> 	their votes as part of suspend.
> I have been testing this patchset with Mani's patchset that is supposed to be
> related to NVMe on the Thinkpad X13s found at:
>
> https://lore.kernel.org/all/20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com/
>
> v4 of this patchset *boots* along with Mani's patchset, however, v5 does not,
> and unfortunately, the machine does not seem to get to a point where I can even
> get logs from it.  Do you know what I might be missing?  I have *not* attempted
> to remove the nvme drive and boot off USB to test it.
This series, will not have any impact on the boot, this series comes in to the
picture only in case
of suspend and resume. can you share your platform details and kernel you are
booting with.

- Krishna Chaitanya.
>
> -- steev

