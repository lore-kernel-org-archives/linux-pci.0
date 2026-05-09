Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4B7478
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778285545; cv=none; b=CYA7iDwudaLxoU5/Tg9UH/n6mXpGEFROsIQTNfnQ7bq/4iGoMkUTS+XFb5f8fU84WAtXcHBU9zg3jvWXOpRkBAqA6LAolzWsFhZpaH6rHeO5ws70CaCSxjMn6pxekzrooQKf8n9wtixAe5QhOmzM6g4yiX3VCC1hU09jbXXSfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778285545; c=relaxed/simple;
	bh=Cy7rshjd8p6YCEq83eNoVKZRQF6Dcg4yV7x7i4ezH3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8TI1qdUS5ImKlLvUB3Ea1xcXFP6BnLjl73VckwmxHzl4jcvwNllZDLxhXe7tuzjo4qsLh1xK6Bzk6dD2W6MZxJOSp6OhpQmbUxOIaRpi9fgC2mxcVmQO4IXA+3f5js5CdJVhiyCpNPB7Tq+rtFyIygzcRw/Bjfvbjyid5fOZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XITF74+1; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XITF74+1"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4781439eec.0
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 17:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778285543; x=1778890343; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1MnanzWx/jcShdplf1MiPPMpO2mdcB+yybqSDTBHJrM=;
        b=XITF74+1vrZ+uGxGKcu+mamsC+qZdnVpPZScxyHe4Gyj93jS7ndIohjGzCV/bp4QZj
         lW83vQTkvnEjbCfFJy/f9mA68DBmGIog8FuQRok37dYoL3EiyUkleqRG4Xi7oaBu0j75
         Se77kBJYghed5Dv5YBiOxEZa4oJVgP5BC/KFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778285543; x=1778890343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MnanzWx/jcShdplf1MiPPMpO2mdcB+yybqSDTBHJrM=;
        b=nyCzWWqs1NracuaCOfVA9cnxbZt7aMPasaLoXfdy3T9S7DD95vBiyg2H8IsmnvOGK4
         lvpU2uS9w3meFUf8JEVqGkhn0zKWyhOFoqaeXcxd0J4ZwuUuyt5vrMmPRFzJZf0WqBd2
         EuysmqCAxmJiYfG49d6BOKTLx5JIBOzcIH7v+qKnhuCKO9kOdMWmKjV7BXiN09/NEeRr
         Bb94XIzW2I+FpA4OO0r98za+nZQdnIpmQ/D8N6eLbB51h64Ivb9c8z3gnycd4YBeoA3l
         DbgumqfmY2gvoF33Xb+lVmcJUkMI1J1cIL6hkuYtYUlB8u7ErA3b6Y/zhH5sB4EP7lKH
         4Qrw==
X-Gm-Message-State: AOJu0Ywumv9HtBQ3DN5z1NW9SffmPTLDFPuZjHcxVOWs2RHpVNnK2z5R
	f1TH5iDnvTj9u/qy0ky0Wdn8VLx60PeKFcSm/acvZ13ttmWyfZx7nDBaihxikb1J8Q==
X-Gm-Gg: Acq92OGQJSUWgSMcuMQS6k8zOU9Iu9ID/qte1ukj3+N7KCoDXxZabLD8WVfWtinDQY1
	RY8GoGNcBRa/57EQyy2q9O38jBJvH99BBsF33oxvzN75NH47EaWBFKANGUYr24yyU9Dlj+YPzXx
	EaXoqY/hInN6YOUk2Utc7YCIswpurd4jqprtRYNQanvZZX+g90j9AjRCWN8uOqka38ptIBYc6wt
	lG4gvno3uo4f9iZst/DcXXhoJIlG6aG5KWPw2f2zu7NExvXHCbxpyS8CGIMMyGaGmZmXANgmrmh
	Abb1Fj/sllfvLLBhaC8O7G1Ew2MuZBKswqIH2ogLABQuvVjn/29FpsTOM4f1drhZGcQqibxKmYR
	F1Ry/nhU7fcQi4focckVGwIYNqHwiVhzmW73h49Dt/42MYEb1amGuZo9MK31yRvwNPoUhZGQHPp
	j8k4y35J67h9WAKjgLxr7O3MPcZQ6pYJEroTo=
X-Received: by 2002:a05:693c:2c01:b0:2de:c5ca:c1e8 with SMTP id 5a478bee46e88-2f54d696d50mr6840495eec.4.1778285542959;
        Fri, 08 May 2026 17:12:22 -0700 (PDT)
Received: from localhost ([100.119.51.253])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2f8862d43b4sm4285662eec.11.2026.05.08.17.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 17:12:22 -0700 (PDT)
Date: Fri, 8 May 2026 17:12:19 -0700
From: Brian Norris <briannorris@chromium.org>
To: sashiko@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/portdrv: Allow probing even without child services
Message-ID: <af574zaysKnXjx15@google.com>
References: <20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
 <20260508233022.D20A8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508233022.D20A8C2BCB0@smtp.kernel.org>

Hi sashiko-bot and Bjorn,

On Fri, May 08, 2026 at 11:30:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Moving `pci_set_master()` after child device registration causes child drivers to probe with Bus Mastering disabled, risking permanently lost MSI/MSI-X interrupts.
> --
> 
> commit 9b851bf8faf271ab0b2daad51bfd51f89a1e87d4
> Author: Brian Norris <briannorris@chromium.org>
> 
> PCI/portdrv: Allow probing even without child services
> 
> This commit modifies the PCIe port driver to allow probe to succeed even
> if no child services are available. This ensures the port can still be
> configured for runtime PM and low power modes on systems that only have
> certain port services available or lack legacy INTx interrupts.
> 
> Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> 
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -343,7 +343,6 @@ static int pcie_port_device_register(struct pci_dev *dev)
> >  	if (!capabilities)
> >  		return 0;
> >  
> > -	pci_set_master(dev);
> >  	/*
> >  	 * Initialize service irqs. Don't use service devices that
> >  	 * require interrupts if there is no way to generate them.
> 
> [ ... ]
> 
> >  	/* Allocate child services if any */
> > -	status = -ENODEV;
> > -	nr_service = 0;
> >  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> >  		int service = 1 << i;
> >  		if (!(capabilities & service))
> >  			continue;
> > -		if (!pcie_device_init(dev, service, irqs[i]))
> > -			nr_service++;
> > +		pcie_device_init(dev, service, irqs[i]);
> >  	}
> > -	if (!nr_service)
> > -		goto error_cleanup_irqs;
> >  
> > -	return 0;
> > +	pci_set_master(dev);
> 
> Does moving pci_set_master() after the pcie_device_init() loop risk dropping
> MSI/MSI-X interrupts during child driver probes?
> 
> The pcie_device_init() function calls device_register(), which synchronously
> invokes the probe routines of child service drivers like pciehp or aer.
> During probe, these child drivers configure the hardware and enable their
> interrupts.
> 
> Because PCIe MSI and MSI-X interrupts are memory write transactions, they
> require the Bus Master Enable (BME) bit to be set in the PCI Command Register.
> 
> If a hardware event occurs immediately after the child driver unmasks the
> interrupt but before pci_set_master(dev) is called, will the hardware attempt
> to send an MSI and drop the memory write because BME is 0?
> 
> Since PCIe interrupts are edge-triggered messages, could these dropped
> interrupts result in permanently missed hotplug events or cause hardware error
> handling regressions?

Ha, that's funny. It's all a great question I think, and that's pretty
much what I asked Bjorn here when he suggested moving this:

https://lore.kernel.org/all/aZfIfn9viQRj4uy4@google.com/

He seems to think it's not a problem:

https://lore.kernel.org/all/20260220164046.GA3528004@bhelgaas/

but I'm frankly not very convinced. I think it's perfectly possible that
a child service will try to enable MSI, the device will try to write,
and those writes will be dropped, producing a missing interrupt.

Bjorn, what do you think? Personally, I'd go back to something closer to
v2, where we enable mastering before initializing children. But maybe
you know better than this bot and me.

Frankly, this is all a distraction from the actual goal of my patch, so
I'd rather not make arbitrary changes to the ordering if we're not sure.

Brian

> > -error_cleanup_irqs:
> > -	pci_free_irq_vectors(dev);
> > -error_disable:
> > -	pci_disable_device(dev);
> > -	return status;
> > +	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid?part=1
