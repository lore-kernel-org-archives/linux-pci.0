Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2E49552B
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353657; cv=none; b=Mi/rpWMR4jF+U7I9qpTVt9vaCmrit2w72mc1AM0AZvxdGeLkgOpgWlMzAo5KUY8sv9iOZ8R9AvqhOfNQ61jsSzDCkoG0Hazld0QZGlFcd4wvhENE5SNTnDdkEj224hK1Fijv+sf/TT5fEtYOPgg8sPP9Wkc2n+RS+qBDbSjqKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353657; c=relaxed/simple;
	bh=cfHF43Ine7qBJQ4yGW2dx3QI/BoEj5Uk/rG08tzXK7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxJTM5mfg6UErbM4F+2MdIKxEa9xRmevbBRSlj6x/hXy5SrBa2RWrt2zGAA3s1J56pd8evNvV3OZSioZhLzPCHvcPaUsgvC/YpmCmkOP257wHA3Hrgbbnv/NeDthjqAN34fm0yPmv4bRA+cK1gkTAaavVPer69HmhEjyYytaEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ENVbtIVB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ENVbtIVB"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9384cb251fbso66095085a.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788353654; x=1788958454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1b2V5MXPsa5bsC9pz5bMRlVxqIlX3QBRBOS64r/eMF4=;
        b=ENVbtIVBUmesY4QhKmqdgGGSJhUQia90DxTc6Akc+eWGcqlbK6nas+whMXWwzWTqWG
         UH3VQ3ivQHebkiD0DOsJAYuGKzWVd770s3vlwJxypepbZfTUgFyjgbVyoi8Zl7qwy9zN
         M3ui+HcyAFTBcuAaYrPny7Y8VVt6DM/cWq/YQ4DnxcMiU/4KyTLsG7d/QFJY1stO+M0Z
         PKWdFMY95CYH6AM8a04XcPZY6kX17vs3SZak8rwBGGJKRXtsgdjNt0jcH9gjYN/3orI/
         UAjjwx8JRnGOb4f+3i0GnJtigD0idJvW61KkX7Qrc/2uFy7kR/eDl6nOetXTN+ma792T
         xgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353654; x=1788958454;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1b2V5MXPsa5bsC9pz5bMRlVxqIlX3QBRBOS64r/eMF4=;
        b=sjFOgzeqPiTDcov1EYYSEZmLeWrvCz7CHhsCFeaL/nX4YEf0sU0WLTqbTdIJEaHrYT
         jXzwaiyN5ZoS5LPaiXa7yP1aXt4sI4KzucnBZlBge9S+5IasX7B0MDj6bKEAdRQugv+G
         xcHvgeCYpXKaEfG4Ov6bA+CJuWO2yYgE0uKjv1yW347HIpROtmSJdclPu9jiUQHSFHjM
         pcOZ+J8FZ1JeF3+VQb52XaxALhxUakrdAoWj/b5lfNdlK4C2e2trRSjBjkkonX1zV2rd
         bJoXLayUnsupIBph20Os3p5hb+aNNozdSmfhO/ClQ1YALZiPTl2ZpEAxRETPtU5aA3Lk
         e/uw==
X-Forwarded-Encrypted: i=1; AHgh+RoV686jutqKa77eCzLOZ3u1KJD+8eSUPxgHvD+sMEcI/tffEQ9izuDoqPZkoQRz6UNSHrJ0uz0wbGk=@vger.kernel.org
X-Gm-Message-State: AFuF++njvAYRdrqB3GDDqY7urRE0y+QhHsNmM3OymiN/+/qG1QT0PWR5
	lAESwqQ+VbwuA+PcICv3wYSBjiV9Q7mhB6U0qhdzEcdtSTr2RNE5Z/3Pg3nlH1sx9oMAYfSR9Vz
	Iga9z668=
X-Gm-Gg: AR+sD12m7SA89LRp3bZ3i9V6X/IrMKJeOvzf7Vh+smLp3Qv4bCToB9c1gT6KycxPsDx
	nAGnyfNKGucxllH7GxDt36Vq768Q6vv4ejFR8AlCSVD+AEIrkctv0ayLpe24ueAgyKj+AMycWSm
	+SHG3uuDDJzYGGV96AuX6gStyeRM1BBwR4R4Vn1QmPAHmDaKPrSydpY4KD+NZWBJwe8Vpe0Xl9h
	taukCrCOj1vV/GGLATSrsuEKDmxoLQrCT7k/S3WHec8QBlaWvFQ1s6AnYPYwRWraz6JVzqgLmK9
	9JItSySQBD0wbWDQvpbE1Vys/pc/tyPLeYW+FKxlcfScyF2nWwqSfeVD22rGEFP9HO2kgAC3jEm
	IUA0l8zSyBw7K1eqCPbLUabtUhJ63iQsUNf8T+djm6W8FWQh0UGesVZiwXRtblR1PzmTk6YhqnY
	zvr7sl1NqVlxzg9wPpIwGED3v2lWubsjqZY6XFMy5I18aWF0tp1B3V6YuPElYb
X-Received: by 2002:a05:620a:371c:b0:937:6772:d8d with SMTP id af79cd13be357-93960f1811emr528224985a.20.1788353653772;
        Wed, 02 Sep 2026 05:54:13 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f359ffbsm196501485a.28.2026.09.02.05.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:54:13 -0700 (PDT)
Message-ID: <58452803-d22b-4e9a-8716-db46798d6403@riscstar.com>
Date: Wed, 2 Sep 2026 07:54:12 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI: of: introduce of_pci_verify_node()
To: Rob Herring <robh@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-4-elder@riscstar.com>
 <20260901012128.2AC6E1F000E9@smtp.kernel.org>
 <cde3da8f-933a-41ef-b7b8-f78317ca2d67@riscstar.com>
 <20260901173239.GD1244140-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260901173239.GD1244140-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/26 12:32 PM, Rob Herring wrote:
> On Mon, Aug 31, 2026 at 09:42:46PM -0500, Alex Elder wrote:
>> On 8/31/26 8:21 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Medium] The check in of_pci_verify_node() falsely flags compliant CardBus and PowerPC PCIe bridges as having an invalid device_type.
>>
>> I was unfortunately not considering those types of bridges,
>> and don't have experience with (or access to) either.
>>
>> In the devicetree code, of_bus_pci_match() does check for
>> device_type "pciex" but does not handle "cardbus" (at least,
>> not explicitly--the "default-flags" bus type might do the
>> right thing).
>>
>> I would love to get some pointers from others on how to
>> do this correctly, but in any case I'll do a little more
>> research on this before I post version 4.
> 
> I'm willing to wait and see if anyone cares about cardbus. I doubt it.
> Maybe there's some old PowerBooks with cardbus?

I'll give it another few days before posting v4.

> "pciex" should probably be handled.

I'll add that.  I'll also try to find what the range
of "compliant" device types is; I presume it's in the
devicetree spec.

Thanks a lot.

					-Alex>
> Rob

