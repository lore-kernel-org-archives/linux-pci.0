Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26284F7987
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792753; cv=none; b=EQ+R39/tiWEsaUhRhIc4EWi2dEkM6+A7x6Y/RevvskXb3jeFQ81yij8xwIRBQoP9eRz4ByP0PFru+9HVPcwMOzuVFaAOCtrQmIYlKvBSUYi+zAf7rRigKylmXvoPreakFDI7yNj32Wpx86aoITSr31w7djNzYtDB04gHxZyNAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792753; c=relaxed/simple;
	bh=/S2OeMB+pVw0IsnX1n74+dfcpu2Keflp/VCkHim9+Cc=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=AXHpN9D54OJ+d0dzvT0ySALizIPM+wAiAGQRLLce0lAXFCMic1yQ/JDQmM6rUTVQVq5T203NbnKSEJiw6oajOQ4ow3lRejQQxrO/TextHhHbAQvcQK6fgxnHFT+9ctxK5MNo6cmHezUMVSOew2uAOJe3eKeG1JG/5ESlQMDsGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnh5wxRU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnh5wxRU"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-87ab6e5f91eso5348907b3.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792738; x=1789397538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=anfs5eR69uR3hgprcQRCB5kZHsZd0+SXQ4tCOJCunJw=;
        b=fnh5wxRUz3J1D8yRKvAOLlUD0kH2Dy25Nrqgl5ga0JBg+aXaMh7EtOyz1WdVRAy+IE
         CAg4426+d/Iw1GGUDsQXC6YQzR1WPwPLVvJcHEN+uXic6ee3Gt+l2s7iQAzcUInCMyrK
         BnNKmabG8zQkzo5H33W/w4b9tXXceBdZrMvxonOqRtS/z4za5x3U/pXB9niNSntKppNl
         1WB6AXK28fVz7gZLtt5rQmeB5gbNxcWSYcxizngu0ab3VuQ8ePOgsAvYwtnNS/qMGo3o
         2IP+wdyOCVTdrVYdIBRTZVzLfsT58TIl6909+qgTuEiZuAtd66ryblusT9YiZECWjlwt
         etnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792738; x=1789397538;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anfs5eR69uR3hgprcQRCB5kZHsZd0+SXQ4tCOJCunJw=;
        b=kAVu29jcL1LjsKbnXzucoTdwiWPmD9nHGVKjL5mSsA4gAyRoeURjforVqwrFDvB3ft
         JhChP1J9G7JobqIptNETvqu9qUpb6N5eVw3ziLl0bFhW8f1H2BcEWBfY3hsEJmogP3Lu
         kFLSd+W+OV6yV+fdWegK4sNZnSFPH7vAZy7a4HDsJaMft11Uw63JEryjK3hExNbLipao
         7tOWL9WQXxKlpRnp6BrEITLT2SpdPFSBRavLYyfhMzCS1raHs4EwtMFgVnKKmZB1xf2C
         dXPA/riRTiQZqEglSfvIn7A7f+Y9k4Etg8tjHCQ3fu/yp5Tl7L1GMyF5Zc6o4ZuN5fWS
         AoYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6Pjglh6bvWlgp2VUxGBH5RzdIpguS5Ril2/qS5Kiy6UwOVIfn39XVsMbqe6GunnZBEL95ParvcIc=@vger.kernel.org
X-Gm-Message-State: AFuF++mpa12mkOilvc5P5J3ag1OvOalfxbAiDw9b9F1VZKH0X9eoxJQO
	cQT75B9b7P0YCafzSP4khRRseQOGxCNHTCvcSY710ZnsVO9J96J8LuCfveQ6oBi3KDoOJg==
X-Gm-Gg: AYBFou1BGkBvqgGoA5OASSfqVHktavqPexIzvkrwucqO1wvgLEdBxL4fifpJcbbZLxq
	KEbGXx/iuJnMdwuElhKdUfm6w42DERPxMt7oiFIBY4TzoXKiYGkW8ILeT1z6T5DsJNfBTUyGdVv
	hTU7GQ5HFKcdqmSfHc8/Pr9kPoaQwYppkHVaD/MKeKcHjIJx5/0xlPZptBgSjs70lseFKd0LPSZ
	kbUZmZ4pZE7cWJDglkJwMG4LDmyeMy9bbyOaSLTRhJ+Ki521fwIZ1kjGT7WlFOH+7RjoTQYJVsm
	1gi+QUu7qXykzuhVhop3Q0Nhu63DD6N5X2wYNzDCuBKzfz7QsBYKNshX1P4t5YCH3A2y6ai/oTP
	ttjVcPazhJ8UJN1VNrSlQCFkVXM825U6qHvYTKtq+SU7tMm36LrOtLqEghsgl6CAxjhLg2KqcYE
	B3RCMgoHUFwYF+KmA8+1Cz16CBYlVKEkIRy72rt8606ZiDuoMfDKiJ6xwDLevDl3s4o9TLmxjyd
	EjDUW8ZJ8eRC10Usdq6TuFtNiRY
X-Received: by 2002:a05:690c:c00f:b0:836:ec4d:bb29 with SMTP id 00721157ae682-87128cc54d5mr72607087b3.34.1788792738337;
        Mon, 07 Sep 2026 07:52:18 -0700 (PDT)
Received: from ?IPV6:2806:10be:d:e8df:57b9:51e0:e022:41c0? ([2806:10be:d:e8df:57b9:51e0:e022:41c0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149315162sm72634707b3.12.2026.09.07.07.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 07:52:17 -0700 (PDT)
Message-ID: <f9b29422-5389-4522-83e8-538e5306b3fb@gmail.com>
Date: Mon, 7 Sep 2026 09:52:15 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-3-terry.bowman@amd.com> <anijY3eTVWSqHLxh@wunner.de>
 <apkxP_fydVjpULaT@wunner.de>
Content-Language: en-US
To: lukas@wunner.de, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Terry Bowman <ktbowman@gmail.com>
In-Reply-To: <apkxP_fydVjpULaT@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/26 03:35, Lukas Wunner wrote:
> Hi Terry,
> 
> You've submitted v20 of this series, but the following
> questions haven't been addressed yet AFAICS.  I'd be
> grateful if you could take a look:
> 
> On Sun, Aug 09, 2026 at 05:57:23PM +0200, Lukas Wunner wrote:
>> Am I missing something?  Is a scenario ever conceivable where the RCEC
>> receives a message with different severity than what is inferred from
>> the registers by cxl_rch_get_aer_severity()?
> [...]
>> These so-called Advisory Non-Fatal Errors set one bit in the Correctable
>> Error Status Register (Advisory Non-Fatal Error Status, bit 13) and
>> additionally one or more bits in the Uncorrectable Error Status Register
>> (see the commit for details).
>>
>> cxl_rch_get_aer_severity() is not able to cope with such errors and
>> will incorrectly infer that the severity is AER_NONFATAL.
>>
>> Now I *think* this is not a problem because Advisory Non-Fatal Errors
>> are masked by default and the commit only unmasks them on regular PCI
>> devices, not in the RCRB of a CXL device.  Only once bit 13 in the
>> Correctable Error Mask Register is cleared in the RCRB will
>> cxl_rch_get_aer_severity() fail.  Right?
> 
> Thanks,
> 
> Lukas

Hi Lukas,

I’m sorry for missing your August 9 reply. Also, I am currently on PTO 
this week and don’t have my work laptop, so I am responding from my 
personal email account. I’ll be back in the office Wednesday.

Thanks for pointing out the issue with CE and UCE errors reported
simultaneously. I agree this is a problem and have addressed it in v20.

In v20 I remove the unused `cxl_rch_get_aer_severity()` helper, take a
snapshot of the AER registers before calling `pci_print_aer()`, and now
handle the CE and UCE parts in separate blocks. The UCE status is logged
unconditionally, which prevents a fatal record from being lost under the
advisory‑non‑fatal path. These changes directly address the scenario you
raised for v19 and also cover any other situation where a CE and a UCE
are co‑logged. The patch ishere: <https://lkml.org/lkml/2026/9/2/1629>
(v20 3/9).

Please let me know if you see any remaining concerns or corner cases
that are not yet covered. Thanks again for your review and for pointing
out the issue.

- Terry

