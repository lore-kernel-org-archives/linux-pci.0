Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD734F96B4
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747355; cv=none; b=smtGzUEEx1PDkIi0v8sDlnYKQRCkLDASCauGdd14Vma8dJQJfgtby8nz6Cz0GP3mBz5jjLJuYn863b2/WorjL9/BfkE71Hz3AtkcmHP+jDoFISbdILMhVrCZFm5wo1ZL26LZphEJXdFe8qlXZV95GmSKRfUiHVoa2jlUHNgdr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747355; c=relaxed/simple;
	bh=ku4iBMP7GjjCjtOQ2BCljXzZcT3llCc8TZkAx0mwSsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tur0BTJX9GA/5lyGnKFarK2luIXkxaXVP16gemgFv3qnDgHlkID6jCjL/yAFYY14OexFzKoSnWMb2QbUbO9Ypf7GiTtN32YzD/51LRijgFP0HF54etjLv66XdztZvV3u6KDyZOMubVSX4MITJzLi9DltSmvNCnEOA2Dd0zDsDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=cSrRAaEy; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="cSrRAaEy"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ad20d4so102393485a.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789747352; x=1790352152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eVbXMCDUQbHUQM6+WwRJ+hjMCQbS6dliJooLhO6lxA=;
        b=cSrRAaEySIsGq8UJ6smPRJAeXqP+/RHDUh30mb5ayLsF3VTtkir9hzPgb7OLctla5y
         2jXyFzEiAasvhWFflw0qlui9V/rPXitVkzly1qEcUeV6fILTAcLzJ9v12U2/LDFVAjz6
         uXxe6VZogbPifcjLXz1SKKEK/8L/gYqcmLmeYHnA0YME4R+HH7a/fDieDQjdVecqoY8p
         pjwW3UZsITmxjMmJ0mycsBWF1H3dncfwQbUmSpuOEdCjwAB1j8X9KbU4ZX4UrcvOu+IT
         HTNdz6y8FfxrB2eviOQHxbAzIDGd1RvVcNmIjSISezbqgdtf0Ct031P/wbLv0ue6h8oT
         Y84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789747352; x=1790352152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7eVbXMCDUQbHUQM6+WwRJ+hjMCQbS6dliJooLhO6lxA=;
        b=dXC8Tt1Y47zE/dwwYv7lJrhkqNz68G5FrSAKvBLuUTryqF3HaJyr+WQ/Uy13aEE0Zb
         /qechS9WJ9zwbRjqnND0eIAmE6iYHSFqKw96uLVoFu69EsQjhLnxpYnqVpaLRVVqXzCt
         y7stdSH+0jMhlXtSyrqlb9UXhxFxsN1AGMzMBqKSr/x/SJEdItfYgiY72KnMbEtLmbFd
         S6N/aRhRrgnBOY3K30AXYnjyRa3GkxLyMaYt61RXtIIV5bcygiuFewsKPiqXv8ML7R8V
         MtyWh1mRh5ZOfVykXp0U39qvH+OfMMcGBDygiV8+hZJMb6oD0gU8bEy2cObn26PTyngC
         M3Zw==
X-Gm-Message-State: AFuF++mOhti3LFzSYo7Lp1b898Gj+XAQXKVN7X3qqUalW2O9fiGCwq3h
	De+nrMMh60r4vKSOq5NUkWzF71qGZwrpryMkqx2yFnKUf2gd01baKxaAwlpJugJiW3PGpUugtJ8
	maX7HXoc=
X-Gm-Gg: AYBFou0Wm/0g0I+fPSZoKtCSTSqzbj+RElUWH0u63QHlVtNWOaoj3+ENce2uD4OEpOt
	4LLLSGx0p0mXuXRsKUQARXve+OkTwOekgz+1yOisOdMlXsgBlcpbiXc+gfIphE4hCiZQNTRP1Dy
	YuaO5xax8M+KNpJEgB96b34GuBqYawiso1cpA3/LR0G3A55QblNyM2PxaOVNQMZBUpUZqYerfxE
	Uf1pux6j6ilnKkt1Y8WxP/pBudK5HUtt8tgFQIytfEgdNfOLPvVLUHGwGo3Enhmleu+Pa5Vl7kW
	FXkOfj5Dew1vL1FcqUh7fivcB/Lp0EXszZ93wBkw37Sy9yLgfnWATogeNu6+p+sOjZumvEvrons
	GUUfR/l3OhUK+VSpZFotVv28nRbIYpicb26aVTduXmKaiO1gGehLwxU9pw9H7p/ZEKwZLm59tBk
	2oalH7Af0DkvfPGew0j6197PUscKE9LTLONcXsiLF6E1fLZshm4cIJxl9A+e9S8klgMmEsJIg=
X-Received: by 2002:a05:620a:2a09:b0:932:df7e:b31d with SMTP id af79cd13be357-93bdc6d43femr428844085a.12.1789747351794;
        Fri, 18 Sep 2026 09:02:31 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e9ead7sm169853585a.23.2026.09.18.09.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 09:02:31 -0700 (PDT)
Message-ID: <0762c249-ceed-4b06-8a39-990d92a97ebf@riscstar.com>
Date: Fri, 18 Sep 2026 11:02:30 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] misc: tc9564: introduce base PCI driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-3-elder@riscstar.com>
 <20260918154230.E8C2B1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260918154230.E8C2B1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 10:42 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] pci: of_pci_make_dev_node quirk fails to update ranges of existing DT node

This series depends on another series that affects the
code that is the subject of the above report.
  
https://lore.kernel.org/sashiko-reviews/ed783639-05ed-4ad9-b881-d1689a8b2418@riscstar.com/

> - [Medium] kconfig: TC9564_PCI selects PCI_DYNAMIC_OF_NODES without inheriting OF_IRQ dependency
I attempted to include this but wound up with a report of a circular
dependency when configuring the kernel.

A bit more below.

> --
> 
> commit d693efad7a099f6326c4b836ade779f0f07366be
> Author: Alex Elder <elder@riscstar.com>
> 
> misc: tc9564: introduce base PCI driver
> 
> The Toshiba TC9564 is small and highly-specialized SoC that implements
> a PCIe switch as well as an Ethernet AVB/TSN bridge. Create a new PCI
> driver under drivers/misc that binds with the embedded PCI endpoint
> functions within the TC9564 SoC. Use the PCI quirks mechanism to update
> endpoint device nodes dynamically.
> 
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 7364931dad3a1..9c5b1e9d672e8 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
> 
> [ ... ]
> 
>> @@ -568,6 +568,21 @@ config MCHP_LAN966X_PCI
>>   	    - lan966x-miim (MDIO_MSCC_MIIM)
>>   	    - lan966x-switch (LAN966X_SWITCH)
>>   
>> +config TC9564_PCI
>> +	tristate "Toshiba TC9564 PCI function support"
>> +	depends on OF
>> +	depends on PCI
>> +	select PCI_DYNAMIC_OF_NODES
> 
> [Severity: Medium]
> Can this cause a Kconfig unmet direct dependency warning?
> 
> PCI_DYNAMIC_OF_NODES explicitly defines 'depends on OF_IRQ' in
> drivers/pci/Kconfig. Selecting it here without inheriting its dependencies
> could cause unmet direct dependency warnings and potential build failures on
> architectures lacking OF_IRQ support.

I attempted to include "depends on OF_IRQ", but that led to
a circular dependency, so I simply left it out.

> 
>> +	select PCI_QUIRKS
>> +	default m
>> +	help
> 
> [ ... ]
> 
>> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
>> index 0000000000000..e4d00dfecfca9 100644
>> --- /dev/null
>> +++ b/drivers/misc/tc9564-pci.c
> 
> [ ... ]
> 
>> +	/* Scan for pci-ep-bus (simple-bus) nodes and probe their sub-devices */
>> +	ret = of_platform_default_populate(np, NULL, dev);
> 
> [ ... ]
> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index de9bbccda21fd..54e310c4153df 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6391,6 +6391,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
> 
> [Severity: High]
> Will this quirk successfully update the ranges property of the existing
> devicetree node?
> 
> Because the tc9564 device has a static device tree node, pci_set_of_node()
> attaches the static node to pdev->dev.of_node before this fixup runs.
> 
> Inside of_pci_make_dev_node(), the early check for an existing node:
> 
>      if (pci_device_to_OF_node(pdev))
>          return;
> 
> evaluates to true, causing it to return immediately. Consequently,
> of_pci_prop_ranges() is never executed.

The series mentioned above changes this exact code so that instead
of returning immediately, it first checks to see if a non-bridge node
has a pci-ep-bus sub-node.  If it does, it generates a new ranges
property for the endpoint and updates the devicetree to use it.

					-Alex

> 
> This means endpoint platform devices populated by of_platform_default_populate()
> in tc9564_function_probe() will fail to map their MMIO addresses correctly,
> translating addresses using the placeholder static 'ranges' property rather
> than dynamically assigned PCI BAR addresses.
> 

