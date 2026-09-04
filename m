Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984F4A207A
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529520; cv=none; b=lqmz+V5qR86BW32RX1e2lTbOL4/qV/peK3eWiy2oLmnME12ZhhbQtyDQVaWOYZZN5hb4JropqmwN/RhdCLGa8G/Pf3NQG7hFQ2b+DAFsNVl/TLA8jVvBDhaF2OPwLMvcIv5fP8vf7LtFJgttNZT+Eca+4kKwipLr41jsKZmAJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529520; c=relaxed/simple;
	bh=AwKvfY0C3A+YddLSh+lZO9CKA3+wQcEcUbOlJU3gnz4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GbyaU3ByDZVZ1S8eDoBi3dZRfI69b5zgv5kyWZoggFrrK5X5YhWseSYQTr21gSehEIbfmkDTWEYi7Dsu2prZBTfFx0reiHLbNmE0ouSZhigY/3uQFpSRgqy+kswPW5sXQ8KJbRWZkRRCZxZd9klBGOk2MX+xfY0om8mDVndRbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=tyko/5Le; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="tyko/5Le"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53016020b2fso18572351cf.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788529518; x=1789134318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+308zQ7FQ1vvQnZ8ir3t08GSlPc01nU8aftORTt4WI=;
        b=tyko/5LewQOTWCVsisbnlLpa4ZaPz0cDnn+OMuZaSLesf4IcjxORuflYkTKcd610j3
         efTqLrLLK6KiyWuoFXilz8padK4WIZgqs1PWFXtQBmY1GFh3KxiqpeQ+IZ1icQOQg1Of
         Sy+MyhvBWg7bQ9xsmO3LgqYLJx4zTYZ3c7fHsRCsyZNQjmzHYLJJhMSxMyzQXFkzsf9i
         FjvL/x4S/hnB5UXsE9sIsPoRMFMo/iFlJj9u+jE/ZPwU7tzKHTC+zG0daDhkjNFKXGZA
         564EpWu4Cg+emkOpZP/PmKSl8ETuTUoCUqIgXQsbdPJBdciahPgvDb5+U20kidYeg0xX
         VDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529518; x=1789134318;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+308zQ7FQ1vvQnZ8ir3t08GSlPc01nU8aftORTt4WI=;
        b=WcXUi9amwXGUjNT2n+WZQHZkDdtnT3SVBktW9st0SPkIiqj0fzoBb7dyMM2mjuBpSC
         58yaI4VF12bxN/CsqyksoIPqWa4BLaMOwxwaaNY5iQZ4O51TTjABJErih+L3jEZkInoj
         BB80sWEjnkkjdvRTkv+VNRdad4qMUnUc9cPiAtFUX6j1UJUiq9k85FOZTAjkOno3D87a
         KsGvY/UjWcAhZJvIVoSPVK0ExH92BRNrEhPD2JtTBlJRldFghRm3yUjl+WP23j5iybvB
         yh9MURr62jrXdIn9yuBuhBs2f8i4TNYY7YPksPIHDXeWRAhYgjX/+cS12Jr8je7nAAp7
         f47w==
X-Forwarded-Encrypted: i=1; AKwUvBzSFdjM3gwgviWCE1TgYwlSOznkSljl5RB1Ov7HXzEQ8iN5zKzywayJfE9bRFkdQwRRViXK6ZwQ968=@vger.kernel.org
X-Gm-Message-State: AFuF++lSxmfArCaPaHM4bcOrNzQwisf2eZFJqH9vmaORr7MdBw85KSep
	kbW/gZzwZFh2eDDWrQp4xZyH3+niSoJGoofYG+1SjV9BGskZOIYTvmYebhBVJRlwaWk=
X-Gm-Gg: AYBFou1Injxv9+sM71089eoY9xXFYx8P+QwfZiTx4a4y6xlM6STckU2+tvZ4QEdKm1b
	XSTQjYkmQr5Am2oqYJ0+BkHeNtx6i3QiD7GZXa2VbtqWtOwkMkLoGnk9qOARPTGE1Se87yPpsA6
	whCPhnrAfO+Eyjy17LDV6WcXHfAoaEUkBY9YV+87S6HyBW+nn3aSnxxU6lRLpxy2QGjal0niLaO
	OjR+IComu1Y5jh/6+qldAFLtpa/+i//Z1guVHCJtR8Qutkw697rURNWIbHURxVKW4r/OkM7rMad
	nAOb8gq1f5PVBREuvzdvQX8HS/fom7vP8Rr0eH08m7aweoHY9YzP7uG48o8IsjstD6qE4RVju8L
	qTDcWf8LBipFUz+gKEprqBo1tcvhiU4RPQGxQv1cPYCo8nGLItxVbfODzEoUfOZJtV3AonAfm41
	sIgx0ikLddEKURn2VAgeVEgJX0Kktcihvnsm72lFmTwmM8fc7uELkhSIO2FsoS
X-Received: by 2002:a05:622a:102:b0:530:42e4:f001 with SMTP id d75a77b69052e-530549b8baemr59653771cf.46.1788529517504;
        Fri, 04 Sep 2026 06:45:17 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53054116c54sm20866381cf.5.2026.09.04.06.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:45:17 -0700 (PDT)
Message-ID: <453211e7-7ca4-424b-b1a4-745f0f8624dc@riscstar.com>
Date: Fri, 4 Sep 2026 08:45:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI: of: introduce of_pci_verify_node()
From: Alex Elder <elder@riscstar.com>
To: Rob Herring <robh@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-4-elder@riscstar.com>
 <20260901012128.2AC6E1F000E9@smtp.kernel.org>
 <cde3da8f-933a-41ef-b7b8-f78317ca2d67@riscstar.com>
 <20260901173239.GD1244140-robh@kernel.org>
 <58452803-d22b-4e9a-8716-db46798d6403@riscstar.com>
Content-Language: en-US
In-Reply-To: <58452803-d22b-4e9a-8716-db46798d6403@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/26 7:54 AM, Alex Elder wrote:
>>> I would love to get some pointers from others on how to
>>> do this correctly, but in any case I'll do a little more
>>> research on this before I post version 4.
>>
>> I'm willing to wait and see if anyone cares about cardbus. I doubt it.
>> Maybe there's some old PowerBooks with cardbus?
> 
> I'll give it another few days before posting v4.
> 
>> "pciex" should probably be handled.
> 
> I'll add that.  I'll also try to find what the range
> of "compliant" device types is; I presume it's in the
> devicetree spec.

I'm about to send v4 of this series.  Here is some information on
this suggestion:
- "cardbus" is referenced in two places (two very similar functions,
   one for PowerPC and one for SPARC.
     of_create_pci_dev() in "arch/powerpc/kernel/pci_of_scan.c"
     of_create_pci_dev() in "arch/sparc/kernel/pci.c"
   Based on the tone of your earlier comment, I'll ignore "cardbus".
- "pciex" is checked in 6 places, one of which is generic (the other
   five are related to the above two architectures).  The generic
   one is in of_bus_pci_match(), mentioned earlier.

Sashiko's suggestion only mentioned those two device_type values.
I'll just add a test for "pciex" as you suggested.

Herve, I will retain your "reviewed-by" tag; if you disagree with
this minor change say so and I'll remove it in v5.

					-Alex


