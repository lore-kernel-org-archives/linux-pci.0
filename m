Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8C3CFF44
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726520; cv=none; b=uwxW5+MbcFwWT77ECTrBDe7jVkrE18KD3Ii9RLb36gkXXxlzhEnBnIiAVEJ9G40YJdh1JV1Bdk/PjHXN/g1omr9chp3akmOnhUeifc8BxPhj33BK+NdC6Qms5Ml48BtIoF+uo97YtX7chhU+GZkoY+ArQJWaWHSL6gwK+azPEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726520; c=relaxed/simple;
	bh=RBwYjF3auxfgNTDdTufyuoqTSozXax3hznWOixXop/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hd0h0OO5y1Lh6ToQK2bvbxcWmzIj5GnRKaR08drdMk7ssP+/K0U4+FKyl0cBZYpKZNtb2C4nOzmQMkPZkilREUC15JS/na91P8ux33iA7Zdlro1MjDMElkSBnBcjAlxPjC4t7g59eKoBnI3yDaIovENPG5C5k9vJnhwoHnbHPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=eYzrlpuU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="eYzrlpuU"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2a449c57so7673191cf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786726516; x=1787331316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aL8pP85i8EaCb3lxYohsqsu8B10B2NEcVQY+xjMxthI=;
        b=eYzrlpuUQpkZgPS2VLQBqOBK2vOP0GMMl70BR7lw++xDQQ2Zb6n2685EBD43CMC//T
         7BZmdU0juWp1QvDJE2JBZQp9yai4qJjRbbSmoLCDAgH86jKa1yaWYHKwvF/VbhEDcx9P
         3iMRhzlGhXX0Sz0E1+dRD5bYHEnXdSVSFeOqqh95Td1YOgPh3JxYO371wcixQH02qXfv
         1dmUWK3aCAXA9NgMR4yXpfVjEHF56/4UrG/FjhHLjZ+DDi7gQ9JUkStIcNK7IQ7vyEHb
         vjL3CqLqcLUa1p7Xzp8K09RN9taSoK3qPagvjyLx7P1jlinpsgyr/TECyRldTzPKftS/
         43Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726516; x=1787331316;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aL8pP85i8EaCb3lxYohsqsu8B10B2NEcVQY+xjMxthI=;
        b=dVG9kr+OcD3O7Jrzollw+DZgWMdZZsPUFaPIxA33gk4KjGhgoGurlLAOnpS4M8IhkJ
         jTbCyfOGR2GKequ6F5jbODTOMvw4YpWtSrhLqFqDcP6KgUHGutOPmoo/ubffjeFi3nPX
         UPgxJLLhjS/0u7GcuTEYLhyP9hbRzS80gvTGgjttyyHpJEMU1MyaEmOflaxn/0yuzQYF
         JxUY+z/jJwm4NKEz77upFEw3ri9Iru8gegR5X9a1ZrQUTcs+BRhTWIUfDN752aj6z1Lc
         d55Emd+7NJP2eWXJBhhsuAiRC0xCwzSDS6CZbrToBRIwBgfju8rrAldUkqHvQ515k37c
         6Haw==
X-Gm-Message-State: AOJu0Yyb/jUOROeQvd+VGxe0Fa+QiKHttY1zAyQ8gw7YMywlW1P2wnOU
	HS+Angk3Pd+NF0YH2o+js/DmjIi/UBWJWGWhEUnT4SF20vasOpd0lnkvyJSatwjAAe6aVtOpzdT
	K2cSeHEw=
X-Gm-Gg: AR+sD13KHq6sLFzq8ZVmjI4KU03eDfVvb7CXTzb9UyfbfZG8bcAOM+qqdxN50xdGk4l
	CcOyI7WYjjVFLRZfk0+gNHec60Lq9BRfp2CirvBSv/ZzN88suWN+INiE724xmz4SWjaDiWXv2BT
	yo/9RiHDBZdgoV798pLkpaYCwYdzsJYXyRjgc3yflSrpdcZabkQpW/kDjSHWzP9oUtN4ypMP2fI
	HSf7IQ7g/Z7UOX6efHt85C8eSJOeRakfzYkV5d7yt4TZVWFWan3CvC67X/dvR7MgD4jmJhiMrGi
	86KiNdA9nvGsTN7isiaIcPv61a9LUsCtwazNly5J9x/Bo0evby5rw75cFFm/omZKxwU3gz2nX/7
	Qd3HRygk7Yk5pyARPxwKlPmBXaGJ8COriZo9l2vtIaq071uKdSA0L32EVRyYFeQGmE2OpqmTTks
	fxCZx2dWTQHzK/Ns2V3Qz2HNZ8Gq6T5pq8sFRednzLxwEwpmTFQm81zgtLOlJF5A==
X-Received: by 2002:ac8:6104:0:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-52d854ce987mr83660721cf.26.1786726516287;
        Fri, 14 Aug 2026 09:55:16 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84071799sm24476161cf.20.2026.08.14.09.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:55:15 -0700 (PDT)
Message-ID: <29e363b0-baa0-40e6-b347-5083c4f2c682@riscstar.com>
Date: Fri, 14 Aug 2026 11:55:14 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
 <20260814014513.5CF1A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260814014513.5CF1A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/26 8:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The example DT nodes map multiple PCI BARs to the exact same parent physical address, and define unused BARs that contradict the hardware diagram.
> - [Low] Typographical error in the compatible string comment.
> --
> 
> --- Patch [1]: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml ---
> commit ee5f64080011b047dd81e1bbdc568f784c09b77f
> Author: Alex Elder <elder@riscstar.com>
> 
> dt-bindings: misc: introduce pci1179,0220.yaml
> 
> Define the binding for the Toshiba TC9564 PCI endpoint function device.
> The third downstream PCIe switch port within this chip has an embedded
> PCIe controller, and that implements two of these PCIe functions.
> 
>> diff --git a/Documentation/devicetree/bindings/misc/pci1179,0220.yaml b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>> new file mode 100644
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> [ ... ]
>> +properties:
>> +  compatible:
>> +    const: pci1179,0220 # Toshiba TC96564 (a.k.a. Qualcomm QPS615)
> 
> [Severity: Low]
> This isn't a bug, but there's a typo in this comment. It says TC96564 instead
> of TC9564.

I will fix this in the next version.

> [ ... ]
>> +        pci@0,0 {
>> +            compatible = "pci1179,0220";
>> +            reg = <0x0 0x0 0x0 0x0 0x0>;
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            /* Ranges will be updated dynamically */
>> +            ranges = <0x0 0x0 0x0  0x83000000 0x0 0x0  0x0 0x4000>,
>> +                     <0x2 0x0 0x0  0x83000000 0x0 0x0  0x0 0x80000>,
>> +                     <0x4 0x0 0x0  0x83000000 0x0 0x0  0x0 0x200000>;
> 
> [Severity: Low]
> Are these example ranges accurate for the hardware? The mappings configure
> BAR 0, BAR 2, and BAR 4 to use the identical parent physical address
> (0x83000000), which would result in overlapping memory regions.

Yes, and I could put something else in there, but this is related
to another issue about the dynamic nature of assigned BAR base
addresses.  I sent out another series to propose a fix for that.

   https://lore.kernel.org/lkml/20260813220717.1394644-1-elder@riscstar.com/

I'm interested to know if anyone has another suggestion for how
best to represent this.

> Additionally, the hardware diagram in the binding description indicates
> BAR 2 is not present, but it is configured in this example.

I find it very impressive that Sashiko interprets the ASCII
art diagram this well...

The reality is that--at least when the ranges property is dynamically
created--all BARs will have a range value defined in the ranges
property, even if one or more is not used.

I chose this way of specifying this so that the relationship
between the endpoint ranges property and the pci-ep-bus ranges
properties were clear (indicating the BAR number in the first
cell).

The remaining questions below have the same basic answers as I
have already provided.

					-Alex

> 
> [ ... ]
>> +        pci@0,1 {
>> +            compatible = "pci1179,0220";
>> +            reg = <0x100 0x0 0x0 0x0 0x0>;
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            /* Ranges will be updated dynamically */
>> +            ranges = <0x0 0x0 0x0  0x83000100 0x0 0x0  0x0 0x4000>,
>> +                     <0x2 0x0 0x0  0x83000100 0x0 0x0  0x0 0x80000>,
>> +                     <0x4 0x0 0x0  0x83000100 0x0 0x0  0x0 0x200000>;
> 
> [Severity: Low]
> Do these ranges match the hardware design for Function 1? The example maps
> BAR 0 and BAR 2 here, but the hardware diagram indicates Function 1 only
> uses BAR 4.
> 
> These mappings also map to the same parent physical address (0x83000100),
> causing overlapping memory regions similar to the previous node.
> 

