Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48D47A0A9
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246332; cv=none; b=PhPCFv2y4XSbynXW6sg2aXg/o+oTmwlf2Kzpv5L23uEfcmoApUJEOHX+JHOULm2noDzk6XkZ9rb81/MGbodWamk6I01MMEOkdyVCBLjo1W9ZA5TaRbCnFNufRbarutCLsCe/JUz6QydXyJrH7s3O8SP398vIHt5cO2UPvVTnOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246332; c=relaxed/simple;
	bh=iNJqeMqjI6DJobrOGzMqO8mZoPkJe4sD2dN06To6hCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NW2wouer7vQS7mSqCXyI6yD8/KCkJzsgYtL6C9xq3dgOCEoFOs5+EcblccD679LbM3oYKN7JcGHY59WmqedolfVqTtJvzBK1vEjO5RyIXBUTTUmyWAfJLc/3tRQsSjd54HGQB+aSeWrfFcpXFMv/CPSlJRYPAsIEAoaHmD6Ep7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=N22PgAYO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="N22PgAYO"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ed19f4d60so1355085a.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787246329; x=1787851129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eCCdoQqiaW1nj8J5UXUMFmTcHTDmPsmHtrU7WPub7gI=;
        b=N22PgAYO6psqJ0oK842Ey3x81cCZxmIY03IvyLTyHl0J467qLbZW4o28yOnUFap0rF
         O96VQp/dwch4ZJgbCz91L56nPrvIM5LEWesZEoWHShZO/KJeXwsRiMBQnQ9cLCKKV5MH
         TH5/M2ly32yl93a2gL9fP4wcq5n5vfOqWtgs0Q7xazJhGhbQmaK7/iP/97XYOX3WHGRE
         8lAacBSrsK6RGbi+4JsjQGxk4DY8+QtNvASlbZwI/wkiFPUC6sHPhpj6LB35xYhAXqZz
         GNPb6HmKdYuOGmmI8Ark/y8y2zhiYkIhGRlJdeuhaqBtEjYK28jwi+HP7CIuSNnUTYXG
         zK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246329; x=1787851129;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCCdoQqiaW1nj8J5UXUMFmTcHTDmPsmHtrU7WPub7gI=;
        b=a8XGSAREKUJNK7THK2DEm7ezyYKHvaFZPb+PQsmwse9CWysUVM/rIzp42aZhzMv80f
         S8ijRV+He6CcpObczt0q3iHiRzr7/DUHocmQrUisOZ7hPuN6s8FreScZ3UJeZrs/b2Dh
         VgaqdRkgVJnieJeGCKZdW8q3nKvzH5l29WkYCEuJ8ypqVshtyOIoKv1jZeFIPMmyRNeN
         e9DmbXmrmUPqgc/+vyZXSjml8TjIrR23FZYqysnpIDodnTfab24QagbV2qH+4C9lRe60
         QSWZAc4McQkclw23EQlwFjP9+MNDbNF4T1KAZXUf6hd7520A9w3cLtZiC0c3jek3/d9L
         B4Og==
X-Forwarded-Encrypted: i=1; AHgh+RpMxk/dXHUQs/q/sP76pQzc0YMdeIGjGOrQ8k7HWNrFk9jgrMNpqpyRVbV3O1IVs2YiKZtNtwY4JGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaae8MJc7+ucM3KH0T8ziOkzrgCQOZHWeuJPGHBXafa6ve9MK/
	8Rj0ewwpJedMDGwT21OHTYd9/NoX2l4xZWInaaYMfRZIgFQDvgh3NOt+/PCSARLxPME=
X-Gm-Gg: AR+sD12+fMZ7xqO7WXq1UffUpTtYSoAICDOEZLqMou1iaDs27xDf8R35P6gwYth4EbP
	cq9EEBJcuP1LracqeP99DVqwspHvoWXtE67kodzKYPs/qf77nlnS/AWAX1BaqN4McYHKMZgH1++
	6wTmy6qoc4YT2fF5iDESV1hTDuZRq84Y5gA8ZQSkD9cSmss5FV+70TPb6E4gG9nkig+WkeOzlGW
	FHLh9MSsZtdyBSFVFglXwwKlvrBBaJyCxuVbPDjwsg10lrjt4tHbM6Mk6VfwomRxh4PU9K5NyK3
	09xpjrpHrpzirU3uaJN+Loe9q1ftvbWU5HfuEoSAhv6tQxuc5W364dAww4/eqFTq+/nSRvp/nsS
	XoL24E9/2BQXJ9Y9/G1q0Mz0dMU2fe122O4YtAMTgrpUrrO9P9SoVjOmJ1wZMGII5ofCft96Be4
	VcQCX1cJHwCaUfo6bmh4kYkSyo61S7vONwnjM9xQo+U9uhyAG35ma7yEs21Q+lqtE/HaTIhtQ=
X-Received: by 2002:a05:620a:294d:b0:936:a184:3cf3 with SMTP id af79cd13be357-9372840f584mr862546985a.10.1787246327788;
        Thu, 20 Aug 2026 10:18:47 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937204a91b0sm418891185a.15.2026.08.20.10.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:18:47 -0700 (PDT)
Message-ID: <e98e8996-1ae8-47be-8854-55a004530c85@riscstar.com>
Date: Thu, 20 Aug 2026 12:18:45 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, linux-pci@vger.kernel.org,
 mohdayaa@qti.qualcomm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 daniel@riscstar.com, krzk+dt@kernel.org, arnd@arndb.de,
 lbiancon@qti.qualcomm.com
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
 <178682676059.2183315.4478974489132403040.robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <178682676059.2183315.4478974489132403040.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/26 3:46 PM, Rob Herring (Arm) wrote:
> 
> On Thu, 13 Aug 2026 17:29:41 -0500, Alex Elder wrote:
>> Define the binding for the Toshiba TC9564 PCI endpoint function device.
>> The third downstream PCIe switch port within this chip has an embedded
>> PCIe controller, and that implements two of these PCIe functions.
>>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
>>   MAINTAINERS                                   |   6 +
>>   2 files changed, 156 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:

I don't see these errors, so I'm probably running an old version
of something?  I'll try to sort it out.  Sorry about that.

					-Alex



> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@0:compatible: ['simple-bus'] does not contain items matching the given schema
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@0: 'reg' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@4:compatible: ['simple-bus'] does not contain items matching the given schema
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): pci-ep-bus@4: 'reg' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): ranges: 'oneOf' conditional failed, one must be fixed:
> 	[[0, 0, 0, 2197815296, 0, 0, 0, 16384], [2, 0, 0, 2197815296, 0, 0, 0, 524288], [4, 0, 0, 2197815296, 0, 0, 0, 2097152]] is not of type 'boolean'
> 	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
> 	2 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
> 	4 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,0 (pci1179,0220): 'device_type' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): pci-ep-bus@4:compatible: ['simple-bus'] does not contain items matching the given schema
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): pci-ep-bus@4: 'reg' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): ranges: 'oneOf' conditional failed, one must be fixed:
> 	[[0, 0, 0, 2197815552, 0, 0, 0, 16384], [2, 0, 0, 2197815552, 0, 0, 0, 524288], [4, 0, 0, 2197815552, 0, 0, 0, 2097152]] is not of type 'boolean'
> 	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
> 	2 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
> 	4 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> Documentation/devicetree/bindings/misc/pci1179,0220.example.dtb: pci@0,1 (pci1179,0220): 'device_type' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260813222943.1655453-2-elder@riscstar.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

