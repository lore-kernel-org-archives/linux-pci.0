Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBD3BCD23
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726524; cv=none; b=IiyaMuSLg8YHpn30xL9BWwsXhygXKgUL00ww3MElXkSXp/+cn38g7FlWNqk6A97VY4qpPClP2pUQ8LiWuM8qY3dsoZZnH0EtMFs4zNq3eaeQ6587188rG77QDKUFbwnF9th/wFrX5vDxAT7XKuex0bdK2QSmhBZZBkNtmi8tjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726524; c=relaxed/simple;
	bh=U2Fi0fUXcyr4ajuyQ+1SJVPQMJSslUm4IcWpXw2vM+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqNlAeZxNynhNL+LgWgd+uCjG4y8qwy7enIABbF5p15gO21EZVeRr38xznMLGoq0M4PqYfFPKfUw6JvPkIOKIeGdc5JMwyzW7uV9vNTEyd3BDuhFkbTyIhwwvMxETh/bvqSEcyW6NCYQzRG9ugdJCyrwOKG80ElardHNHahoVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=n99Aqgl+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="n99Aqgl+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52b4e988c77so8906691cf.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786726520; x=1787331320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fUO4WpkJvelzuWRr/Cxlr530ZgjlNYPQtPN5heFg2w=;
        b=n99Aqgl+p+y3yxZxfbkQejFqpz948hLFD2Q7GjG0I0s/7Oer1RccjzZOjnswgNnMId
         QSjpi0EiIeZ6YWa/I1VnFe1O/UJplBv3NQrTihzUKbi9ckjwcYlQsT9E7lWVlquSCgin
         OQ8c65ysASAhon5RDVJX0LerrmUktaVTOaheWtypgd0kPYNSBAsj095oyBqMHaPVRiEz
         OqWrZBuok71Jx5iBg2riM6kM16b3XvTkcd2jg3shSQk00Brg/sPk7eN5tZwJT+9h0yKO
         3kbifpBvbJ0/py9M36EEliEIC2xlvFhL9e2/PBMOd2w4WwofBjidcA/kDdGJ2KMawae3
         YVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726520; x=1787331320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fUO4WpkJvelzuWRr/Cxlr530ZgjlNYPQtPN5heFg2w=;
        b=lRbhe7EKU8npSsCR+KHJjBHtpgcFHofosfJzQkernA0GdgJU3qNlYEUUFUpeGyATLc
         OdmkEkyHEhriQd2MYaGZikyfNQ9Cn4Av6W3c6uaqWd/4XyLW4pBIwysPVVERfQ4EPd+K
         TshtI/FV+PSt6vYfUV0/BxjXH+4GjP6QLGwLQBaSFqMwl8Xal/XLTne6ZNjkUMJQZ3/c
         4EQny1g6xygYsTpSFFkIU/pNLLJj2YqmKqQwz00FeuuDatMu/wK9eHj6xQYrh61gFigl
         w1HL2Brq7x1vZ2bcDG58g+o5QmyuHhVAZHBOWkPLUKuCYIsU3jjgKk447Uy9X3SrWWG9
         Ca/g==
X-Forwarded-Encrypted: i=1; AHgh+Rp+As7Ph/ClFd1HHGA0Wx7/8oMLE3bPq2D1BS/5e8PdrYvsTihGwLKMYpmS4DR5N6bo4zrbNyWnka0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5ssTgYLWswyh585TkOt9YCj8O6OLiY3QS03yFQHBq7AwQnQq
	gIVIF2t5biIR3qV3OUS/gsE61/PACf/A7QWF16lccUGkaaKdVQrPwU7cwzkkbsy94ks=
X-Gm-Gg: AR+sD11FxbyUdC9jIfqcEsYq4xJ1tGKjxJUzm1deViQQYOSlq7Ukj1RyxjIt/Gyc8NF
	PQ/ZacaTsXpqSmpsW8YSqpdeLPCXPjSKQfFlSWsgNVKhZdhm6Rz7ARqYulpjjZDIcU4rTOdNKSH
	TV6HsmN8MR8vW3aFACMiOQo1pXuPxiEMQ31qIloDyOwpoUfIUxbsvS8inIFICexbwUoQgdyXBGu
	SgSECTZ18ypkzNi9pv1X+KMCEwZfzWKABFzbawyiQUPVtyhq2cnRWyeDz2zRh84p+20f/A9aRUl
	PsL5bSf6Mxcwl9YhYgXZ3lMWoJ/8UhLibPW3s+FAwvGNxxqelau9erxOatwj9muxofbjO7AXEYx
	9jcxWfSGWusAJn8QMSXjq64q/ru3UAPuc1ugIzoTFq6L8KelHv9jQIsFqBCO/nGlNYn8dMr5p9K
	YbJdmhUhuLtYOAqfrFblwt0LKbM/JUQfsEajAVf0umVfYHMYNf7xxJexhdE2DH
X-Received: by 2002:a05:622a:15c5:b0:51c:2022:cef5 with SMTP id d75a77b69052e-52d855014bamr78999821cf.26.1786726519769;
        Fri, 14 Aug 2026 09:55:19 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84071799sm24476161cf.20.2026.08.14.09.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:55:19 -0700 (PDT)
Message-ID: <000a3672-3b93-4d62-8193-04ca6bbbd6f0@riscstar.com>
Date: Fri, 14 Aug 2026 11:55:18 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
 <20260814015923.8E7E21F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260814015923.8E7E21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/26 8:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing PCI IRQ vector allocation prevents MSI/MSI-X usage for high-speed child devices.
> --
> 
> --- Patch [2]: [PATCH 2/2] misc: tc9564: introduce base PCI driver ---
> commit e66bfe4041c21f48829a22eb54cde73756806870
> Author: Alex Elder <elder@riscstar.com>
> misc: tc9564: introduce base PCI driver
> 
> This commit introduces a base PCI driver for the Toshiba TC9564 SoC which
> implements a PCIe switch and Ethernet AVB/TSN bridge. The driver binds to the
> embedded PCI endpoint functions, performs basic PCI initialization, and uses
> devicetree to populate any endpoint bus children.
> 
> [ ... ]
> 
>> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
>> new file mode 100644
>> index 0000000000000..d3ffcac1c522f
>> --- /dev/null
>> +++ b/drivers/misc/tc9564-pci.c
> 
> [ ... ]
> 
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
>> +
>> +	ret = pcim_enable_device(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pci_set_master(pdev);
>> +
>> +	/* Scan for pci-ep-bus nodes and probe their sub-devices */
> 
> [Severity: High]
> Does this setup sequence omit PCI IRQ vector allocation?
> 
> Without calling pci_alloc_irq_vectors() in tc9564_function_probe() before
> populating the child devices, the Linux PCI core won't configure the device's
> MSI/MSI-X capabilities with host addresses and data payloads.

I will investigate this.  I don't have a good answer at the moment.

					-Alex

> Since child platform drivers cannot safely allocate PCI IRQ vectors on behalf
> of their parent PCI device, will the high-speed child devices (like the 10Gbps
> Ethernet XGMACs) be forced to share a single legacy INTx interrupt, or fail
> entirely if the host platform does not support legacy PCI interrupts?
> 
>> +	ret = of_platform_default_populate(np, NULL, dev);
>> +	if (ret)
>> +		goto err_clear_master;
>> +
>> +	return 0;
>> +
>> +err_clear_master:
>> +	pci_clear_master(pdev);
>> +
>> +	return dev_err_probe(dev, ret, "failed to populate platform bus\n");
>> +}
> 
> [ ... ]
> 

