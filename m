Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664D0393DDC
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149382; cv=none; b=CLyeKugNrkZW4wupTulmihqj0MYnymewvCXOmDMbc1SSdKCjyzlE6z+3DxvZB/N3wVfPeYz5SU9mqvR5oFfnB/vFN7WJp69BZJSvqc8gFHAj82UKBPMUm1KPyN/QMYS4LbCtRn2ypSXOgMC0a+Wa0jt4WnGxPpN1thspwDe5R/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149382; c=relaxed/simple;
	bh=zSJ3qe6MfqwTDB5Ny+9r3dtGb/8CyXgUlrO6FMHp+Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QC76CsUB5mxxQN1ZFQHEjNWE26Wfxxm6aV29Qk4WKdc7HQuov/upBwZdZHEvPJYWYvItLjytD5xhQDGYLD+Ivgtk1hJyLjmBIwM7BPXlqL6s7u93mU5p7HKBKji91OFHw+LQlTRGTIWtLeahqEG4rx1Nko2+DRq+mpSFMzKU+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=disA0tUR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="disA0tUR"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c214321dc32so196095066b.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787149378; x=1787754178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hHVz4sDUf9h8i4EPmkVnkkj+IR1W+HagsJirTGs4yA=;
        b=disA0tUR6gBPLa0NpvCieCmQCHjXFZpXCO9ufInlfNDRj83hwX6VfQRBndG/NAP/pe
         kxy9RcFlnpJq0zMCZpssQQrYQ2WzmtMgn5Y3SNy1TfvmPSwF96E8G6VumakplAmLi+12
         5OwTw39nCMG7u4o6OQONSSy3gWF2lGBVqDr2o5YcgFmnqgK8QLSnYORMSS6pRwD2qFW5
         crD9oBb3Kt024QlREZclezucdx34G4nrCHQ4VABZfP3Fgh4EdJocWwHlS0pbR82wpsQX
         nlOWulteLRzRjvYtDZotWc6PpOHuzzk91eDXZn9t4LclQCEtTsKGZMir8Q8steWbt85R
         s5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149378; x=1787754178;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hHVz4sDUf9h8i4EPmkVnkkj+IR1W+HagsJirTGs4yA=;
        b=S7U2DAQDODIN54CKIY4gcnfaYH6ERc4fFZxhZOYOYixIMMx3BUJ3hTnSOkgao/ssn2
         JqDdKiGUDJn12rOw14YPo7P4i7UmIJ2TmiUR1r8vL2np2PWu852RihHqhtNNn4JHhSNs
         O+TFIPtIRKErC1nOTNVUVdiAAuZ6OVrbrz1Rt+Nz19Ub2CySMQ4yqPnBWMcN5GRPQwyD
         7EAHz/m36LqCxFY6OYVJspB5LwgTvrMIcaSXaZnUATIsvCnIWJ03NtVeaa1M3o6rjUoA
         zX9vdlmzyORUNsBloWmwHwe3bbMskCdd//ohaiRyGdfz2nvFyh6Nhh8tQULbsmPtjQ9T
         /HRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvE6eYHUhrJMGGg4EgM4GQp1DuSSEv98tU02I3IY9ZjZhDCJL+b3lAet+HhTxgUDO+13zCtQLdR0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zUAMs0Rfc8bQH0MUZ5WBlNYk7PkdsJHB9V1MF1TAqDSUO5+B
	K/Oi4Le5rL2kh85LKLPQ51sd4Etqd44fjKOjPPVZ02FYk13mrYGXu2XXNC8J+Sgpd0Q=
X-Gm-Gg: AR+sD10K1McKxTFoWXrwMTCIuNh/xa07Pw/RBa1U5HBAwOnRBaozp+JF7cLniSwkjS1
	wFZ73Ps0fwMMIXBXC4uKnm5qfb2qrF5bmq1eZXQ+7CuwcwR41Lr0vECG5a9YRCXUcE1cT/s+dUC
	DF+qW+K8uxnshjgBK68zB9pepc05toWYQ1s6q3sA3JXWzXsc5hNi3ULSIXNU7uqC1pDMRZMSFVf
	w34pznQoz9WmQkZ9XLav8JDKgefndWzGj49UBPqroUaN4xQECzAvsAwZ+ecpWApHjxEswWkYq0i
	pAgx7EZJJuSJNdNO/2db3JM31f6JlUrdpzgaMjTq2fJECSmJLvwJIxl09OH692HLKInxC6byTRw
	rQHvfqnL/SfEFOnOnz2tnlrDvq89XK2Mpl9iu2XJcj0mM+O0hYRK82zvL5S79YFwqW5H3JgFNoO
	8lKMVJNAZw7/UbzFaME/y33QbMBnRM4DZqF0BJaqQksCjFzhHVRu2tscgRribf
X-Received: by 2002:a17:907:c709:b0:c20:2165:d74f with SMTP id a640c23a62f3a-c242e3b5bb0mr335229966b.22.1787149378491;
        Wed, 19 Aug 2026 07:22:58 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c7d7c42sm87398266b.6.2026.08.19.07.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 07:22:57 -0700 (PDT)
Message-ID: <abeaacbc-95eb-4465-85ef-4d88095138b4@riscstar.com>
Date: Wed, 19 Aug 2026 09:22:54 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PCI: of: make a flags argument optional
To: Herve Codina <herve.codina@bootlin.com>
Cc: bhelgaas@google.com, robh@kernel.org, daniel@riscstar.com,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260812172247.276554-1-elder@riscstar.com>
 <20260812172247.276554-4-elder@riscstar.com>
 <20260819122247.6ccfc7ff@bootlin.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260819122247.6ccfc7ff@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/26 5:22 AM, Herve Codina wrote:
> Hi Alex,
> 
> On Wed, 12 Aug 2026 12:22:46 -0500
> Alex Elder <elder@riscstar.com> wrote:
> 
>> The address of a u32 object is passed to of_pci_get_addr_flags() so
>> it can be filled with the computed flags value.
>>
>> Allow a null pointer to be passed, so that the validity of the
>> resource's flags can be checked without filling in the flags value.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/pci/of_property.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
> 
> Ok but nothing in the series call of_pci_get_addr_flags() with a NULL flags
> argument.

You're right.  This is needed for the dynamic range update series.
   https://lore.kernel.org/lkml/20260813220717.1394644-1-elder@riscstar.com/

I'll move it out of this series and into that one.

					-Alex

> 
> Is this modification really needed in this series?
> 
> Best regards
> Hervé
> 

