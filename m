Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65878559CA7
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958943; cv=none; b=F7rqiqkB7sl3MTjqkq8bpdK440lCbQpbgFzjxGhEwISfreRcEWW+PCCw0A1295/E5xJ1Larsi6ymbukRUfhuVNOt1p6Zt4P46teo1wLa0qn3kXROdxjL1mjuR2sb1dNB46+IocWgQCsS5Vp+ofbUBBsVnnj/myffghownDzyJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958943; c=relaxed/simple;
	bh=j9Pi+ZLX4OZ+1G9Ee1d8lNIg/X9OdRMm+shG3FZAY0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1fDGmedqfmvuWjHKrgJzyRM7k+U9enJL34tK2JhXm7i81fH01FDGyV216hOc0powAPIKbeogazlZHqqwxYTvD5A1Sy0rYFjuuHy0wtlelWaGiNWtGBfZVoY/nBN+cvST35ikfN+3GKzoafU5ddcTAD3I/8Yhiwxq9QMVB40Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=TteGEv3r; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="TteGEv3r"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b5e907853eso6057011e87.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788958939; x=1789563739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUgF/CrYctElW8HYQdRdPRn47TT9mqidw6R7aTL1YFk=;
        b=TteGEv3rw5PRh3xCi7RSZmo/XfTpdNoLKT3o7Fox3/2GC4IHNB2ykOR0AM75XfsnlN
         46dFl78auB0XQtZup01uxByqtQ7sSuSS6ec3O7ekCli/4CLYgSCTSYfLF1coBs9CQCpp
         p2OWw9XgjF3oDIFNe4l04YyTOijfe5GIJqxfKMU9zdMJPuVeC9b9HWPDnrhRrjmuX9P2
         6uQfctIbZR1dGp3kJ75cHE2qr5ydQvEtm9rJqfS2dIJMTN7a/6uienhtR6TxUcTVHL0F
         QvDbTMHMtVOIIWM9COzpy3bJThgzkHzEjV9jX47Xovlai/hdpszrhdZi4zzTAN1cvi/a
         Q6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958939; x=1789563739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUgF/CrYctElW8HYQdRdPRn47TT9mqidw6R7aTL1YFk=;
        b=h+q8YgBkmyOVVIzHkSJRQ+e0ht9OylFlLqN+0jU+jS05LxopiGWAN02lfbvofF3E2H
         paAEivIhlW/KyHKfRJljJLeC4mpek4KpQx3H/f7zhtH99iyQY5F8bIdnvWxdnU0JPt+Z
         AMynNbK1aDDLkKnIi1k7WvFS0v3gJ991Y6DcgJcaM+EiLLO8LczlA0BIVt7DvXVh7Noj
         oJu/YbGoL2ifLggVLaQ/zNWXgcTiWu2Y6d5tmInmmNeaPx7QyYav94wVtCHpZMOPlafc
         bELfRF7sMaRRYV0k4JX+A1A8ytorL871BSfEf5WCalKP1szTVDxOpIR3m8TYN+qwJoZT
         /nBg==
X-Forwarded-Encrypted: i=1; AKwUvBwbHhzS++jViRJqqF8x60LEkUe278ug/eqjaHXCU2cHp4O184V5VU/yOfay771kYat2MVaUSzsUH7A=@vger.kernel.org
X-Gm-Message-State: AFuF++m/NvG9xcSgXPQ/44srz4OyTvXZzPCAgfu13KUs44q4d5ZZR860
	58tKl4yoN/o/8YdzTcAPKfdrnsGjMf8vg7qTOOV8Wq5xCEw7Z/TFP4fpaeu9yC1N+IU=
X-Gm-Gg: AYBFou2QgjUhVJS0K2XChzok64/m95ArjcfoprEIX1PEWyeJ6CZlcGfv3LnEDcvJAKT
	CH1rmsZdD3LA7ogpEjlPGoDGnQZ52h8cD/QUAuSuyU92aHHPBbw2h638iZ/nqU1FKhZRK4rGQ4E
	ZGJH1C1zZ2ja1PWpI8BkRo4QTgtQChPFJ4BcAnjz5FnXSjB6V3ZMXUjqkYCVHfdBBcBvpx3AI6Z
	2rKMzzo6PwoEbP1C3HJ1P5yC2mHS/yNBM8J0GmgotxKIu5ncj8mKrtQBRuya7B8Kmj526nLNLpb
	7DMas947BEiN/cctlWO3k53jPOLKcDJWBwEfWB7oHf4BWT7Nu3oAE/8HADOtkJuiZ+5MVf4De6n
	87mWrkSsoNIHC9XOr+OKCqA8iPZqu4YnEv3avfRFOPOkR5ILf1Z7yXehjoVBE7aGiNmXKs/ZjUb
	CLcns2v0p4pL6aDKUq9f5cLFrmGbtJr6Q3XbgM2jYFHZetAR8j/mTDa9SZgVSHe1Xerl3xKFI=
X-Received: by 2002:a05:6512:3f16:b0:5b6:1a7c:59e6 with SMTP id 2adb3069b0e04-5b61a7c5b4amr5179834e87.64.1788958938948;
        Wed, 09 Sep 2026 06:02:18 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166f6ca3sm3792717e87.32.2026.09.09.06.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 06:02:17 -0700 (PDT)
Message-ID: <9131cd8e-240d-4991-a248-a497f490474f@riscstar.com>
Date: Wed, 9 Sep 2026 08:02:13 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260908213459.2519059-1-elder@riscstar.com>
 <20260908213459.2519059-3-elder@riscstar.com>
 <20260908214601.7716D1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260908214601.7716D1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 4:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Leaked OF node reference counts in of_pci_prop_intr_map()
> --
> 
> commit b3af32f45eed6da355a4a96246bdedb364fe0855
> Author: Alex Elder <elder@riscstar.com>
> 
> PCI: of: drop the reg_num argument to of_pci_set_address()
> 
> The reg_num argument passed to of_pci_set_address() is always zero,
> so get rid of it.
> 
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> 
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> index d66c702218081..1caabbd4c18b5 100644
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but does this code leak device node reference
> counts in of_pci_prop_intr_map()?

Given of_pci_add_properties() is the only caller, it makes sense
that this would be found (again).

This was reported last month, and at that time I said I would
investigate and fix this.

https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-834622054cdf@riscstar.com/

I fixed the other problem reported there (possible null pointer
dereference).

I still intend to fix this, and will attempt to get to it soon.

					-Alex
  > When of_irq_parse_raw() successfully parses an interrupt, it acquires a
> device node reference and stores it in out_irq[i].np:
> 
> drivers/pci/of_property.c:of_pci_prop_intr_map() {
>      ...
> 		ret = of_irq_parse_raw(laddr, &out_irq[i]);
> 		if (ret) {
> 			out_irq[i].np = NULL;
> 			pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
> 			continue;
> 		}
>      ...
> 
> However, the function returns without calling of_node_put() on the
> successfully parsed nodes in the out_irq array. This leak occurs on all
> return paths, such as when map_sz is zero or when kcalloc() fails:
> 
>      ...
> 	if (!map_sz)
> 		return 0;
> 
> 	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
> 	if (!int_map)
> 		return -ENOMEM;
>      ...
> 
> Are we missing calls to of_node_put() for these references before
> returning?
> 

