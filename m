Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46D486BB0
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726511; cv=none; b=PTx0jfDZ4kIoZr3bQH36NRCfOZwrMF4MPGX0cKt3xG38AiY8bKuMNtrHIeHYcloB/pavJjfHaZBpkoNAmej9bpOVkQ3R6A8+kC7RJTnp+ksXIO2OXPe9datbgz9ei/Drv/3dalxuY0IkntlZ2/V59F/zqZ3vbjS+8AC3yZH3o+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726511; c=relaxed/simple;
	bh=i2QQU7JdAC+aaX/P9rI47R8LByKLDiPOAciQZkCTTRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGka8PkQuOgFyIUOL9qvyi9SNtUJ0S/fsGuPsPBfcE7X9NQetRnlnAt7LQ5unU4EDXA3U5RQ4CBNbAqpqf4qPFBuktxbZF245YFWo16i8zvbLyhIrINVfzRSorco2KdvRkjacUBTzdpeh+fyFkYJKD3vcUW8AaLeQwuV2uqqRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=wc+ltNmu; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wc+ltNmu"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-936c02e58dfso83510285a.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786726507; x=1787331307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ClQeFE8grv4Zo5HkAwOcQ2W3r0In4+kVu5lGLxtEbvg=;
        b=wc+ltNmuSp0ZzaqstqnlydqTIKCrfrFh7AFAiz2I/+NiHfwZSP5OlfN7mWhuIBpyF/
         bf45MkYeaU0Y8s4CYU/nwqq8BP1mwmKaVgwLnv68F5nYCvWL1eJljz0/IXfNQAi7FJ7/
         2LhVwhZdhbAmaMz2MUSuUd2ZEcq40qKp9mKIBWIyBQbFCNPBqTY2mRkdatFQWvj0MdJE
         qwIN0YwDy0T+E4tKCBkRPaPFYLohK8DVdizq+vfBn/HnwHWdBZAWJUZH9fMNyL0D/RVd
         IHoE5j2WZWOim9vCkgEWfn6QQ/gByzR5YXHrhpa37aWV85BtcSX95K2UPK2yAtuZUJtI
         wxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726507; x=1787331307;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ClQeFE8grv4Zo5HkAwOcQ2W3r0In4+kVu5lGLxtEbvg=;
        b=HRn7WIg7NGR+px1mpzhTdG0c+/rygcvLrKISAw38yJ755WYIfUrKMGhxZfThEtdebr
         TSTaQIQNZy7FZYYUvPTVAR3ALS145sxDYGE1YLkpPLuYFbgYucXf+RZ0YSLHEB8srWro
         7uleOnlxn7CASmGMWhvGDk/0Kq8DVvAd+ASQ/LB7kOXBBNM1vMdhFTY4w2li02W7uaKM
         euXdcTAmMrxYd9ReruOX8nXkg1RzGOFojiIA37Tf0Wl3qAdD/BFbqMbUnq7Yh8aGujRi
         SCLCpRLxjpp0iZPTKDwBDje21bIpfzcIfY5raYspeXle94Z1djGCvoPnbL9HzqtxKPnM
         3o3w==
X-Forwarded-Encrypted: i=1; AHgh+RpSxCTRZl2mZTIrQll6BxCiqwK3EyK28s4fO5o7WoIIiYCCxwWFTi9w/Yus9DEdqR13IdxDB/l0Frc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBDjV9TTz3Z5WvHoYDJDP2Ee6zV4C+OBE/iCP1Ps1AqIP8Jgr
	ohI1iwylRRs7nwQ64NRPflbAriD6+Wo8OWHutaj7bbxGCKp+eAIUKkSkMSDEtzN6x14=
X-Gm-Gg: AR+sD11egAZLnV5XVk0UODYxdtjD+ICS9II7nhrITQZf29K+pNftRuNCUATnI8RCawn
	+hW0EeNyHBiVZxleQVmyQnEojU7sH9jgQJ2c6DjQJuKKbq1NUmBWRHIVPLhtN+/n0ESnAcDXOiu
	sO6ukB8IEM6ZRmdwtdUr8aM4dCrAxHLawQtoRAVXNcscGLpexrL8Pz/0F7F8IpMuWNHw306cYT4
	kti90Gzv7QauCZtzqA3/GsvGeOfHjh1skrQ+nguAP97IQrvg9SoPjR9fq8yaiST4PEAogyRNAL9
	TDwLX56jwB/Dmjag6XU1r/L+J49ySpZDZPreSoxN+3BnRD0JEzeeH0Pf05M+Ss5RCC/p2oMpRu6
	midwufm+gHXTjNcJ0Kh9lgliBVIAbb1eS2XzbxL+L3kZyIf/NG+pVTSz4Zbzmq5Wv3qC5ArEwM1
	LflshdjSHpq83EDWhbtX0x8TzAwEI7rxvKfmVDN+TtIyPGa4zVlT+2BhJHPl14
X-Received: by 2002:a05:620a:408c:b0:933:ada:c3b2 with SMTP id af79cd13be357-936d2382749mr772663685a.34.1786726506665;
        Fri, 14 Aug 2026 09:55:06 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce0b3b13sm314967485a.19.2026.08.14.09.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:55:06 -0700 (PDT)
Message-ID: <d61b2a72-aa24-4119-bf5f-8a2456f6c9b5@riscstar.com>
Date: Fri, 14 Aug 2026 11:55:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
 bhelgaas@google.com, daniel@riscstar.com, mohdayaa@qti.qualcomm.com,
 lbiancon@qti.qualcomm.com, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
 <2026081455-eternity-douche-900b@gregkh>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <2026081455-eternity-douche-900b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/26 8:11 PM, Greg KH wrote:
> On Thu, Aug 13, 2026 at 05:29:42PM -0500, Alex Elder wrote:
>> +#define DRIVER_NAME "tc9564-pci"
> 
> What about just using KBUILD_MODNAME?

Yes, I'll use that.  The underscore versus dash doesn't
matter...
> 
>> +static int
>> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
> But wow, this is a tiny driver, feels odd to have it in misc/ but ok, if
> you think it should be here...

I put it in misc/ because lan966xc_pci.c, which also uses
a pci-ep-bus, is located there.  That driver also calls
of_platform_default_populate(), though it also loads a
DT overlay which isn't needed here.

It is indeed tiny, and your comment makes me think it
could easily become a generic driver (along the lines
of "simple-mfd-i2c.c").  That way other similar future
SoCs could just add their compatible string.

So two questions (for anyone):
- Would that be preferred--rename this to target a generic
   situation?  For example, "static-pci-ep-bus.c"?
- Where should such a driver be located?  For example,
   drivers/misc/, drivers/pci/controller/, or something else?

					-Alex

> thanks,
> 
> greg k-h

