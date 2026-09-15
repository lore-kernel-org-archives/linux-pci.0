Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F524C4F52
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497743; cv=none; b=REzJMC9mOSaHo3qMK3rAh7Rq8wT8JNB8POiQMV5JknMOpiBwmq6R5LI0XK5FwND68LUMOH85hyn/DGWK+OAMGXnOJx4s8KbJP34OQ+1IOFwatF57geFBd5KEHKuxAfW84RW9meMAk4f8sV8A43zwPFfbWouFF52f583QfHmgp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497743; c=relaxed/simple;
	bh=CnLgCa/Xd5S3wMdf/P9+9GT4r29J78Vb6SjfqEB8nTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZWGphbaliyrJ6VPbsCZy8+GD9gsYzNJu+vpvOZbSIeR+cfpkpbzW2NvevUBxSYJGf4BFdhchhocIZLIpdZO4Ccf1yHcpq7ut/DLVupanl8NcD3QYr4XRyeCwo6EsRetJ3SYbWkADNSBEY7/s3Mp2zrIa/P0e6SM0z+o+XMnC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=dLI2BKeU; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="dLI2BKeU"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6ebso859916d6.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789497741; x=1790102541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDC4r0VHOK5n3tc4+Odi0PfXGfsyQf0AidjB47fhMwU=;
        b=dLI2BKeUr+zOKdFTIYxUVfpsFlhfiHkqSTL+vVpeIUasZWeBrKKqAf6JbPrQ+8P5sM
         1Ure5nn1lIpC7nhfqjSwgGBtU5NdxC+LUz2rxi63c8V2UNtKreHhui+RyBipUBZRQVPu
         QCI6HVon5gXYUqY01kkK+6NNFvUBCCpcSRsqsKNqhTrzh2OyxVTyTuRBauOnycamLsCG
         hABkJYtrNsfqB+uTAzXsb5bARARCPv7YVNR70RTqNHuYRQMc/99smPy+KSRJXgmT1/nS
         kBPhjNKZ7zdpMUtOgxjQvpYv7HuqaTfGvMBp0uRiVRJMWaIPklBBd+UtCScg1HsjbpHc
         a+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789497741; x=1790102541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDC4r0VHOK5n3tc4+Odi0PfXGfsyQf0AidjB47fhMwU=;
        b=hVJkO1nGgtY3ghr8umnmpk33eRR6+3LjkLs3DFchkRLn8sLdHObyFjeD5TCFD8pnl9
         Db/6xvLE3IDz0uf6KAi8bQCk2TlB6R4K0JBCcLxcJMYTYhhsKWzyR0gf6wagtGPWu/rJ
         TcnN/GK4ZSBMWcpmUDwIPEZo3hZSmo9qUHL5XgIWUJ1TwdNYV7W22TZ8JUKplaFoKrXf
         uU2PKfrghPF4zsLRl5S8cupiiL9be5wb70QxkhwuXI1ZLH4wGsW7jNXRUpBl9e+uXORb
         XoHWN5dHkAEVtCe4SJ36h9IcrOrjrTh+lHveKCX06SW6AyVfVJu9jNtik5Q66BBj4/Wl
         TWuA==
X-Gm-Message-State: AFuF++lDGw7QZ6BXzU5OHph7nS3tCLznGN2ql4lAmMiUYyoCqr/6EuvT
	lJ6knK8yCBIs4FWlZb45EVz6Lgsk5z2cc/NoxV1akBkyevMnPk33cCDMVFjnrTHo6h8=
X-Gm-Gg: AYBFou1phlUjpSNsj6SlrGlW6xAxRkPZvTyrNnDPq4wrcx7kckkJoS9xuUzKo9WozsD
	KRC8qr3hU6Py98Jr+zldRg+Qq8k4bhcHmAxuXhoA8Es/OsSNoBXKGIcdMjrDhDWe4U4GeLASNuv
	uu2kG/rr4VDCFtyN0zxggd7QeKvp36rWrRE8bXPlkAozYKXeowfItslJMoPgSiXQDHnRh5w542Z
	AR/fqxLtPxNC7sOd1aDfANkq5iNXikowPgpuQCcxaKP8nzQCazM3AIaCPwJgCgexAZgzB5apSbf
	rOOZ2Fp+ViOiBQm51JrLgQO9zplltGQ6I/rkMwUQ+TU9hPXihojeuUlUNZTXFhbw0Nga0mBMoh5
	GAe3VT4FLRHKBoGDIBEH3xS2iVt7QtLLYNadi370ffG31QjDmgVR9GdecKPYz/UJb1gJgp8LOm6
	kYp6WZYINQFnbdCqqgMqubCxDofSf9tgbi/PRZeCADu6/YADeTyMKs+/teISEGpF//Lc7i+gE=
X-Received: by 2002:a05:6214:29ca:b0:912:1a8a:31cf with SMTP id 6a1803df08f44-9122e55ceb9mr136951946d6.22.1789497740684;
        Tue, 15 Sep 2026 11:42:20 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7c43bsm5457256d6.23.2026.09.15.11.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 11:42:20 -0700 (PDT)
Message-ID: <54d53803-507d-42a5-a680-36cc0f0f062d@riscstar.com>
Date: Tue, 15 Sep 2026 13:42:19 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] misc: tc9564: introduce base PCI driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org
References: <20260915181003.1633543-1-elder@riscstar.com>
 <20260915181003.1633543-3-elder@riscstar.com>
 <20260915182227.A53281F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260915182227.A53281F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 1:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] tc9564: missing Kconfig dependencies on OF and PCI_DYNAMIC_OF_NODES
> --
> 
> commit e821d4f3b3a6f26cf2df684fa3788ceb3794a058
> Author: Alex Elder <elder@riscstar.com>
> Subject: misc: tc9564: introduce base PCI driver
> 
> This commit introduces a base PCI driver for the Toshiba TC9564 SoC. It binds
> with embedded PCIe endpoint functions within the chip to perform basic PCI
> initialization. The driver then uses Open Firmware APIs to populate and probe
> endpoint bus children.
> 
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -568,6 +568,15 @@ config MCHP_LAN966X_PCI
>>   	    - lan966x-miim (MDIO_MSCC_MIIM)
>>   	    - lan966x-switch (LAN966X_SWITCH)
>>   
>> +config TC9564_PCI
>> +	tristate "Toshiba TC9564 PCI function support"
>> +	depends on PCI
> 
> [Severity: Medium]
> Should this configuration also depend on OF and PCI_DYNAMIC_OF_NODES?

I thought about this but intentionally omitted it, because
*this* driver doesn't depend on PCI_DYNAMIC_OF_NODES (at
least, not at compile time).
> Because the driver relies entirely on Open Firmware to function, compiling
> it without CONFIG_OF or CONFIG_PCI_DYNAMIC_OF_NODES will result in a
> successful build but an unconditional runtime probe failure.

I don't mind adding the dependency.  Even if not having
it is technically OK, for the driver to actually function
as desired those things must be defined.

If anyone feels strongly that adding "depends on OF" and
"depends on PCI_DYNAMIC_OF_NODES" to the TC9564_PCI Kconfig
option should *not* be there, please say so.

I'm not going to post a new version of this series for
at least a few days, but without objection I'll add
these changes when I do.

					-Alex

> [ ... ]
> 
>> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
>> --- /dev/null
>> +++ b/drivers/misc/tc9564-pci.c
>> @@ -0,0 +1,84 @@
> [ ... ]
>> +static int
>> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	/* Despite being a PCI device, we require devicetree */
>> +	np = dev_of_node(dev);
>> +	if (!np)
>> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
> 
> [Severity: Medium]
> Will this probe fail unconditionally if the required dependencies are missing?
> 
> If CONFIG_OF is disabled, dev_of_node() will always return NULL, causing
> dev_err_probe() to trigger here.>
> Similarly, this commit relies on of_pci_make_dev_node() via a PCI quirk to
> dynamically create the devicetree node for the PCIe function. If
> CONFIG_PCI_DYNAMIC_OF_NODES is disabled, of_pci_make_dev_node() compiles
> to an empty stub, meaning the node is never created.
> 

