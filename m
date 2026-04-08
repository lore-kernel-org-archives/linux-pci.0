Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038837AA98
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641607; cv=none; b=otPBpes2vKnQ4lvBjC66gezmJ/0uKUwXaU6UoIYl6Mti1LHcizSxoa5quvj4pqmACPJMNtF44+/9Z/NHnnhoGnpKdJ93vvsyZ0BaXsKpD/ounzOP1jEsAlK1NdJmlB+dwIaA9qv27D8WZDRljaFzMQImyvS/Z4fBOIjl7H/1IZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641607; c=relaxed/simple;
	bh=W5Xo8W3fyVACxXUnhF50ZmrJHQgpX0btgvP4dinNck8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8c52Ph3kObcxtrEOyFSl0bObyGIdwmEy1qAPxNsF/pqyZ2J/Gy3odqtTznSxEfuyRv7LOl9su2pYeXm3wyWSjqGpQ8PBIdXHGJVxkDy5gU6vqs8TvCM9rargEO7aSnZPJEg8W2wXS0aknW4SfjZLreYmMQvNlb0S41CBiuMyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lwpfe4XF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XyXUa+Zu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lwpfe4XF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XyXUa+Zu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63865lfP1314539
	for <linux-pci@vger.kernel.org>; Wed, 8 Apr 2026 09:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LUI+RvbCB86eOi4yeTjEgeLXdznpeFNN1CvP4DNLB7s=; b=Lwpfe4XF0juBXT9b
	ljKmthqlWV/iOHC8r+SaFeawbJc0dHnWa1t6+DOL7jdonzSCQWvrb1Kyb5S8CeVt
	KGKJl9ILuO2B6LTGetr/ffnByHpHKmhnVfM9FyAUV7DKSVKTruY3JSGwS/JpNfkF
	n5X1Nznr+fBxwgjrhdtxiP3nFnHBETRFr0QVY07fFJTfHhhxtVplph+Lhm37JkjE
	MAjV+AeFh7BwaswwGswKZVny9s8u5jwCMXzUG+lmLWTjdCfi+TRIPUCyz+CJKZ1x
	XA7o8g+UTSY44pcAqNg8XEFT3QbLnWpH6AhyMUMcO61sqinGcV/EUenVX60/fDE/
	13fWTA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6jjmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2026 09:46:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c89d4ce16so3986164b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2026 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775641592; x=1776246392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUI+RvbCB86eOi4yeTjEgeLXdznpeFNN1CvP4DNLB7s=;
        b=XyXUa+ZuZv9bk6Ve6V/Y2JKVgGkLvwFIAwhjJy7RIXQ2OUw4QmoNTRil/OBBjeliN3
         dW5cvHIML4o98YgWHLkJ8Lx2ZZ9LxInFsbaMFqQO6egzbw7ES3Fr3gtcRS4UoABVn/TJ
         SUBXk7zXSGpJ5AiaRiqETPd3nCF8FBGI8Bu64LB+dq+mUtkTg3VfMVzfUpuG2tBcHjQq
         8iNUWvyeDYh+ItbkCmmGaEPbK8bP9sSHrH3vmP3VT0S3DBFXMzbBV8bq5ATqPK8pTXLV
         zat7Mtm3gCLRpLRak7Hkb6dFXepKYtO3j0B0D4YaBDqdbhKuFNVQEi7WUuvuc12vD4YH
         y2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775641592; x=1776246392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUI+RvbCB86eOi4yeTjEgeLXdznpeFNN1CvP4DNLB7s=;
        b=YwadvG1ZpXedCHBDe4ti8BVLoGgJfflaD1yxhldQ0U/PvrQjbD2D5qqbPaZwMYmW9X
         wFDcoNst+e26qWOkbxWsU4scBdzr7Z/bWILIpLpOf9nXpX9XxH0z5Q3ssK7x7SaTw3ne
         OwK0YTF9rHZNjKvv3Z2L8wH4MoHqM6Fkv6yIEnf6txGoUrVDvbCdR+eBfjUfgQb3ygqq
         Z3RWu2TPn5Kxzllo+NjoIA2+VpjjvXf/2eCwM8sX47y772fRJDwTsID3Ds2xpIMYi0w2
         lIhZNYouOUGzgDc6uk/R7yGM/k7MdJQxWfmgTCoEgf8aAwj2fLkqBGwAArv8U5f2wxjD
         fVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrTkdIk6e7YlKrk6qs/Zhw0DV1XslRT79lihEVv5pht8pe/cdhmvdPBD5GjFmY9x2Xf55tyh10hGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznLPjuOf861X8iHAvYmD1Y44F0SeKJJpIXhBOiNzqGxNisLF8a
	9UKNws5dofELeqL2CaIv6ky98dv5/EVCKo2WY+MXGgLHVfJAJSPOhZRwKQHvIGwgIn/MCnobh6N
	0rbu0e7eN2Oc9NSVRqn6UjFYdiDT9J0fMN1lMazjNwk29gzQ/eKv6sq7zKdbYOvQ=
X-Gm-Gg: AeBDievgg9ZZXhNdQSKG0YbgAfcfVDe9AZ2guSnn2FZsiVt5y9CY9yhwqvyzP/ubxW7
	V7JitZStFWi/m1cZgKrtXwGYnZKL3RYArAsYP/pgkDjL5hZkB22uXdV+MB5J50ytBPMMSErVfW1
	TX9ZtfuCbnrsnoh1JCCPUal6nDJ2fUXAZzit2Xcs9TDPHoxUYJjmtXpLNsDWAZAaeAKaaGMqxbZ
	2bhxOhgY9Kr3u4nOo0KlIAn+UQ1r/zo4AoJihEodlPYdt7kAxr8RjDEedwXFXnji6kUEihUxaLv
	bwq6R4Xr9LT5Uk1Jjb0SwtkyxYWx+9N4/KzOXPdtEPTOd4DVcWF0XHrBYw0O/oIBHbLu2bF/ytm
	faVhqIS9AY0MUGJIXRSJZmOQpHU4K2NY0McRpOpzGGQ6RSRKrhTc5tw==
X-Received: by 2002:a05:6a00:909a:b0:7f1:7b2a:ab5b with SMTP id d2e1a72fcca58-82d0db6c3femr20317930b3a.27.1775641592045;
        Wed, 08 Apr 2026 02:46:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:909a:b0:7f1:7b2a:ab5b with SMTP id d2e1a72fcca58-82d0db6c3femr20317903b3a.27.1775641591519;
        Wed, 08 Apr 2026 02:46:31 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c71e62sm19137187b3a.44.2026.04.08.02.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 02:46:31 -0700 (PDT)
Message-ID: <89dda312-92ff-4957-bf67-dd0b60f681b8@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 15:16:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Fix NULL pointer access in
 pci_store_saved_state()
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        manivannan.sadhasivam@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
 <20260404-fix_pci_access-v1-2-416f32c6f7ec@oss.qualcomm.com>
 <adIXJvrV1VRunFOu@wunner.de>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <adIXJvrV1VRunFOu@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZasS_V4_SBLHOzLof-2oRVMzhzOYyqMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4OSBTYWx0ZWRfX/Gf5WVHcNiWI
 q/8AK0rTqW1EQy5m9RYI2Ts6m5bPPLokx/MXnb+lVBaNhqJQiqGXWveJUjmp1JdG/S5Gf9Khnhh
 GDq7OVS/lffkWMeL4SIR59DgiNIyGdTMTLFKUuIaHqMyssy6uxLafNPuDuuD8jSurAOl+j0tyYf
 YRMo90mL5VexxflX9g1ePmh1A3nC2+LU3Cfzh5NoPY9rSv1yNXxM9V5X2/YHxbUmfCg4VLK/jRw
 YkxAgpyW29AMCVIbG3seYh4LTNEhEFnPJ9xqfTcjlBhnUTMM9R4c/clEEERD6LwDBbt30gPDDDx
 agep9t9g979Bl1EswEdaBwXv1G3dWpA86x35S3sHehtwfgj0r+g+Qa/MuRvyMlPojxy/QLkrhs3
 ZyW4q4E5L/2YND0Mh8P2c/F92xAZ4DazwcO9cpMrFU8aPjh93sFeg1UcfWWY3PaYe3aZV1thP7b
 qnM51/03VwnVLlDj2Pw==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d623f8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=BUsG3ihsmTx_MtZ67SEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: ZasS_V4_SBLHOzLof-2oRVMzhzOYyqMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080089



On 4/5/2026 1:32 PM, Lukas Wunner wrote:
> On Sat, Apr 04, 2026 at 02:23:00PM +0530, Krishna Chaitanya Chundru wrote:
>> If the PCIe link goes down while pci_save_state() is in progress, reads
>> from the device configuration space may return invalid values(all 0xF's).
> That should be harmless.  If the link goes down, the device should
> subsequently be de-enumerated by the hotplug driver.  If we save
> some bogus data before de-enumerating it, so be it.
>
> If the port above is not hotplug-capable, manual intervention is
> required for remove/rescan, but that's orthogonal to this problem.
we are seeing this issue in non hotplug-capable device.
>> One example is, while saving VC extended capability save path
>> (pci_save_vc_state() / pci_vc_do_save_buffer()) then interprets all-1s
>> capability fields as valid and ends up writing far beyond the allocated
>> pci_cap_saved_state buffer, corrupting the pci_dev->saved_cap_space list.
> I'm not familiar with drivers/pci/vc.c, but it seems it takes a size
> read from config space and uses it to write to a particular memory
> area?  That feels totally wrong, at the very least there should be
> a check for PCI_POSSIBLE_ERROR().
>
>> The link state check here is racy since the link may transition at any
>> time. This is a best-effort attempt to avoid saving PCI state when the
>> link is already down.
> No, please validate values read from config space with
> PCI_POSSIBLE_ERROR() before using them to access memory at
> a location that may be out-of-bounds.  Or cache the size on
> enumeration and avoid re-reading it upon pci_save_state().
This issue is coming as part of the probe, we are checking if the link is up first
and then trying to do pci_save_state() and when the execution is in the middle
save state we see there is a  linkdown and pci_save_state is actually storing
some all F's.  we are hitting the issue in pci_store_saved_state() which is
due wrong data saved as part of pci_save_state(). pci_save_state() has many
config reading having check for each read is not ideal way, that is why we are
tring to keep check so that it will not crash. - Krishna Chaitanya.
>
>> +	/*
>> +	 * The link state check here is racy since the link may transition at
>> +	 * any time. This is a best-effort attempt to avoid saving PCI state
>> +	 * when the link is already down.
>> +	 */
>> +	if (!pcie_link_is_active(dev)) {
>> +		dev->state_saved = false;
>> +		return NULL;
>> +	}
> The state_saved flag is only used by PM code to determine whether
> the driver called pci_save_state().  If it didn't, the PCI core
> will make up for it by calling pci_save_state().
>
> The state_saved flag is *not* an indication whether the saved state
> is usable and code outside power management has no business changing
> the flag's value.
ack.
> Thanks,
>
> Lukas

