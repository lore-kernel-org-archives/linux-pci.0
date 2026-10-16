Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C43B42CD
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147653; cv=none; b=BWdyeuPT3ZfKO2vwZNellkuspei3MtBp+0lbPD2zYH+n/Qs+IOus99fo5uH9TdpahdNIod5tQNalTFIDX5P3TQMp7rQoY6vv13uxgn9l+jbJDpNYmeUTj0UCKM3xU82TBPHlJNMf7Qtt15R+zbK+oI29/wGsyCZiHyFHNR3xpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147653; c=relaxed/simple;
	bh=bPnl0Yf71e8vcUsCIuKIgbXK1yIVIeaibryeX5c0yuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuHWBug5CLtGWrv7r0BJwvToKfle+Pwe9N+z/W6mq4/s+kEKIszPo+Z+sbQexED0FPLatc7a2cmB+ePtLpWC8ZzAmlojvj/tzZdPbC0s4jip78NTBn3PzNJMZBWpJ1NlK5Xrga25k/hR/VF3ccoudkPtUkgOZ1v3p5T1p/043cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJe2x5yF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VtKQ7+8J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJe2x5yF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VtKQ7+8J"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAANcP2998674
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 10:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KsBGE5Y7oiOcGfZZJwFv4NGQn3UVu3xR1FcpZACoj8c=; b=cJe2x5yFzIQ+Rhyd
	SdV6xuc79AWvLhM666s5jDCaCbOo1rp4OpbXSghFupkfLhYXsJ6GciSMMe3Q2fpz
	E9S9OaaTRZtv18Np6DZ85G8o5pM0YEhmxjcPiuAmpCe8Jtd+V+2WtSFqhiMYLLqv
	eTFycHeo8rmgQVZaiFii9vDWIq+6tkqE4ZobrJR8gAuLHhiQ7cnMluVU3Y8U6L6D
	g7y8C5cyOKviVou9jV7eOeke2n02odrCkfdyvH0IFg56R8vuz2B8PGYDvCIMaBAi
	FCLkFne0HaCaNl7n7h9jzbZHPjCTJ8uoFecRXWQAUyLxDjOsU5m2THv8R3svp/tR
	q4Fp0w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r126j2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 10:47:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ea8a9cfe6so115270685a.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792147645; x=1792752445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsBGE5Y7oiOcGfZZJwFv4NGQn3UVu3xR1FcpZACoj8c=;
        b=VtKQ7+8J/RVZ2LpARYYsLV7FM+l8A/NbCjYm+uAHmvplnspbc1aV9tVolg+14qu7OI
         OlH5vsstN8px3uPKelSVkx+OyOxTJDG8YuAMgtVmAw0UV2V3rEtgZLJ6tYZls19XjPoM
         UqtmasbNv2L+I3Yjo0HZxwxaoP+59ic1WRuNSmAc1t8uaPWQ50/3xrJSk3DMqSV4LjCv
         cNk47g/aFZjkAOitL65tEPinDWLpEaTn8buxQ+Sx9/j8yagtZkAl934MJWVzyphu++vX
         y9lbsos6lXB5fM5CyflLYCFvrz5okbGOD81Ph7XhM8mJnXzaT2lfAa+W+EC15sdkOsuJ
         +wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792147645; x=1792752445;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsBGE5Y7oiOcGfZZJwFv4NGQn3UVu3xR1FcpZACoj8c=;
        b=I5X15IohTLy0c0aotP+mMGpzl0z/QFkXjzBmXz/hzwaiJNj13zGMfFpgpl79jolxnk
         trEg/X+/XwBx/1bmcMfAZwlTwtvNusAxUH8sS6kzgkSTxcjHdKm+nueJVxqHqLn6R+x4
         G5LGVMf4wq0g9EvysrFsMjNbj0/WDrz4GeD5/Gd9kxS5pFkz69jUHQOS/hbXo8WWh97R
         soKLfn30WkHgQURyHHsD7OJGtgapuZfSQrIPtfvKOQ1L3vBIpqgZgZET7Jm/7MwysM6k
         uno2i9SD5WERD76WVFebNqPRpEui1Xm06DXyo0VQaMtASISWCfydeZHswPdIwv1dG0as
         /BvA==
X-Forwarded-Encrypted: i=1; AKwUvBwx3/TkvKhRykrcbXXU/6mYiRn7EhBd6dRbBZuplkV0oNSYOdpG7XlpJo2uKg1QIQwB6hVCNlcn1p8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIXWxn8sRICZ+YdQcOnXMRwcaTqFUxzsYetdf/MBCQYuhYeqlY
	QwS/7+k94+xu2VJseHHnRrp7nlqeInSpItdk0xxAhwG8b8gvllj9mRMgdmZgvUwK4J8fPlR6xSU
	YBEqZjDsfKxQ+UteCBL9IAR2IghCqQP2RgNrT3jaus5OLbk9tFbUwEozl1x/+uTI=
X-Gm-Gg: AYBFou32kvktU7TSazBNZwXKe7JqjJDfIJ6iOscS+D5MFND6deDjCJrvg2+UMfrkAEr
	Tu7a47KmrVD8iSZIxl2X71qWYT3hvLAwr0LBlkhdkX/GiVU/ubtXtQiVou5TnpZvuVtX0YSi7dZ
	T8DdnGc/z0l0Ff0Ty3chaf9zcKtWVxkde1c8icv+metoEX3LJdqd+lUxOHlcOEEK7yftnp8vKA3
	/454P9aunSM9kJCqdpPu5LO7AJ0+VT6IJy9oKOnwZCM/nJxETDsKVqTJ0dzTF2gHO6wSX/I4uPY
	q2TFZiQTLEm+jy30DupdsydA6OL6XIXjoKL22f3cuplql8MRtszJfXff+jA4Xna3hAQYWfeQRov
	Yy4q8AP0aaXYld0BMJzSarA==
X-Received: by 2002:a05:620a:6506:b0:93e:508b:7800 with SMTP id af79cd13be357-93ebcd29970mr3706656085a.0.1792147644842;
        Fri, 16 Oct 2026 03:47:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6506:b0:93e:508b:7800 with SMTP id af79cd13be357-93ebcd29970mr3706652485a.0.1792147644333;
        Fri, 16 Oct 2026 03:47:24 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a132d45sm752855a12.4.2026.10.16.03.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:47:22 -0700 (PDT)
Message-ID: <04d85ecc-60fc-4923-9073-6e00eeca5f43@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:47:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
 <d709693e-b9ad-4d53-a368-67fbb0cbd601@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d709693e-b9ad-4d53-a368-67fbb0cbd601@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fwdk1PsVRhqbyspofoKgthwMVC0od-Op
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX2syD3cbd9NDf
 QMNqqykW9TCT/rBz0A7E9Qym+1iWwpVIBvWbpoiI2hMUJlJepO6PMGxWzSvEBUeP+cwxbMeoRbI
 pMUkTAyyoMMj2aytkB9OYRrX/OCbHxg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfXxoeatUjUvy5/
 tKILLYgStMQBFmlDab9W44OzsHLIEy6FqCswSi+cthecUSnCinp/w2/1TAoEMLOA10XUzu+ljit
 PyCSVX+LcEIuuhi5g8GgL68/c4TaWxAqXaZHFli0rjJ+o40FNHFaEr2KWphouSJJKRJ4HBPjy94
 RXOIRVc62Hf7i013QhvmTbBOb3A23Qmh3yy8DguntfMEyZ3Lzvbjmt4o+4wIsw+ZOxtcxqwqT+P
 BCxIx1OlcXbO+q+3ulteBP9F6SQeLGxTVgbLb/vq7eMBnqZ13gUASXhyPbgv9dooeKo4Fp9YWO7
 IpbNXGOlHYF/AUi7LBgvW3mmNOb+GAW3+BbYt1mbnBO3hpJhYCnRGcctCG1315dHjymQrygNOzn
 4akXvYTB07rtuJ7q36VLb/EI21QleOm7FzN1eYPapCdnDs618y+PCvhEoESV0xHNURlRt6+ZOsr
 VM25hJyD1uWM0vAjkgA==
X-Proofpoint-GUID: fwdk1PsVRhqbyspofoKgthwMVC0od-Op
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad200c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=srXNNXimyGuFi33gXwEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160042

On 10/16/26 12:24 PM, Neil Armstrong wrote:
> Hi,
> 
> On 3/14/26 02:56, Krishna Chaitanya Chundru wrote:
>> QCOM PCIe controller advertise hotplug capability in hardware but do not
>> support hotplug command completion. As a result, the PCI core registers
>> the pciehp service and issues hotplug commands that never gets completions,
>> leading to repeated timeout warnings and multi-second delays during boot
>> and suspend/resume.
>>
>> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
>> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
>> Capability bit entirely, which also disabled all hotplug functionality.
>>
>> Instead of disabling hotplug, mark these controllers as not supporting
>> command completion by setting the No Command Completed Support (NCCS) bit
>> in the Slot Capabilities register. This prevents the PCI hotplug driver
>> from waiting for commands completion while still allowing hotplug-related
>> functionality such as Data Link Layer state change events.
> 
> I'm a little late to the party, but marking the RC as Hotplus means the bridge
> is marked as is_pciehp and pci_bridge_d3_possible() returns false.
> 
> This means this breaks D3Cold support completely since in __pci_host_common_d3cold_possible()
> we now check all PCI devices, including bridges, and the RC is not set in D3Hot anymore.
> 
> The only way to enable D3Cold is to pass pcie_port_pm=force to allow D3 on all
> Hotplug bridges. Which may be wrong on TB bridges.

At a glance, may it be that we should advertise pciehp_is_native=true?
(it's currently only a thing in ACPI world)

Konrad
