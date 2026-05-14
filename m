Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810F38BF9A
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782590; cv=none; b=G++27pdTuUN27RjiEAIsIfTQCOz6RFvWl7M7qsldRQY/ZjOFMcgzz2dnRJG4ocx+5czS87uOe/yPhy6UxtQDLSln6mYhDpjH0UeseM/ougXrLLB1P+XXh7KcWCHOp9+ZqSUDrkc2ASWgMsg+Wnn2zBoqP30sS+M3pjc8bxIwBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782590; c=relaxed/simple;
	bh=LlKBPVfZt6k55SzB3EeP58F5fOxBhXQRYxzjH7+tFVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/uK6ZbpNUbokxLPV4LhzTqC3yWEflLGT5zI/LYn3HAuTfedNGQWJ/YJIKCaQtMVYhmyw9AJYlPn3AWdK9it/HmLYIATO39xfkdIhB/soKD0+wQRY07ls2UppIBf0jIyFIznPEeP3KR4ycNmJa0VnmFfo02XcRHtsKwGUbhgDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJ/GZfDg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJ/GZfDg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba856db1c0so56452855ad.3
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778782588; x=1779387388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cC7g+W3PbRFAIT/5EGy8Wrg/Kml67wts/KuJpeskYOY=;
        b=rJ/GZfDgfcAmw1vrvcJc+HRb+nNtYLtBwyaLyb3o8inqT1ptgURMkrhRoq473A7Id/
         b2ShMof7HqiRD/yvI1xSgbxCRF5Odbu2Pjadxi49O6cq7rQaBCZUM2dcy8lbC4EKiEt5
         HLb7hQ7810fd8lRPbzVjdO+76jWGkXjFJmeTnGtRcDFXf80jLEC+5d1heSoUSCCfcLw6
         jXV3Dy6Iai3ouaX9iVcRBfHzxZHiu/4CnAQwUzHU3s9ubdqGv+xFJ+OCFTomfTUOI59r
         LV4QqhrNnGG2gcmmbrJC0VwHtDTByZ3cy9yyAUhwXQW7UeTSteqJe6G0UKJTUD5P6aEL
         Vs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778782588; x=1779387388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC7g+W3PbRFAIT/5EGy8Wrg/Kml67wts/KuJpeskYOY=;
        b=HThcGSZfXG4vpohSOfMFe25BqsSTWDv45R8EcQjkeVKCDhyEXf8YqjdVtr2QiR9Sp2
         oNQk5dx8Fl0XIDqPJkawlTJJpf+cRMERAOvnVuZBcFh9fIWdTjSTYEBQ+iojkAbTQHTh
         0OdB33A0Kj/ljZxfNX+HAtanzGGd9YNjf0/giotksnlmp5g266pGLt3RZpws7k6RSQ/q
         kLPWi0Zx7ADRMdD70qICXR3cu/DSvo3FeMlRFMC4uqGEwnTbtSMbbV/xV/YaHDiKaVVV
         3ABDuZ8Odxf4WMrhJ7s6YO8a8WaX6lmqnGFhTqY0mK6BIsN04hclkF48TTOaPGzNqqjo
         rCNg==
X-Gm-Message-State: AOJu0YxdkwFpU5dTVhZu2Ugymf99zO984enc3iLvWkQ433yLsGIUZUdY
	kRlAKZvFH9y40Ru4DR121hNSx/UyzBzTolozHAzQcTITckf0TD8otu/uCvIK/LNjDQ==
X-Gm-Gg: Acq92OHRaUU2AAdO4/wfWSX+4jMUOEPzgxbse4Cd/OQI0782goorHCKYpfUKdJb6WbZ
	k66SGwnXQUcrvHKB5+DGauGWM/BtprWfn/QKAJbbkfyCge6axag54c+2LP0hhpTgN/zaSr/jRbP
	Igqg20iW1k09+aRSbvJFmN80apJchyB5Uat7GLw+17bAKVkJNXggq3H6DEpZ6Jzvf5GdbA2GUT1
	Wzl++UsCVWglx7ul3xOBW5sgBfFpFvFwcZjblhwegqSUpU9ks552SkgZSrXYVXP4L8We0UML71S
	smqHPtOqj/I4ibmldAullD/i6wVqOR0R+a2nBeVr18FqAT2V3l2PyrDZqcx5HG9cdTXf46TeID+
	eXn5ME2x+OSZyKhz59317JPiFFigslx477GL7plpCl53XnrJOubHiSkxACsh5+gBlmM8cKdUxFz
	6P25XnlQV7crvYEtFtGyAMccnP2Zpijys+XNR0WdcQwZR0RLlsJrk3+tUnP+ce26qEH+xhjq3j
X-Received: by 2002:a17:903:22cc:b0:2b2:6b58:9317 with SMTP id d9443c01a7336-2bd7e91e3a2mr6066215ad.39.1778782587583;
        Thu, 14 May 2026 11:16:27 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c263a0fsm33093835ad.37.2026.05.14.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:16:27 -0700 (PDT)
Date: Thu, 14 May 2026 18:16:23 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <agYRd0xQs0r8OOKA@google.com>
References: <20260512184846.119396-3-dmatlack@google.com>
 <20260514003111.4F10AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514003111.4F10AC19425@smtp.kernel.org>

On 2026-05-14 12:31 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Dangling pointer in dev->liveupdate.outgoing causes Use-After-Free memory corruption and state leaks if a device is not properly unpreserved.
> - [High] Missing `kho_is_enabled()` check in `pci_flb_preserve()` violates KHO subsystem guidelines.
> --
> 
> commit f946f5d8b0614325899345e29b5315ff6d5139e9
> Author: David Matlack <dmatlack@google.com>
> 
> PCI: liveupdate: Track outgoing preserved PCI devices
> 
> This patch adds APIs to allow drivers to notify the PCI core of which devices
> are being preserved across a Live Update. It allocates a struct pci_ser via
> the KHO subsystem to track the outgoing preserved devices.
> 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> 
> [ ... ]
> 
> > @@ -74,27 +110,30 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> >  
> >  	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
> >  
> > -	ser = kho_alloc_preserve(size);
> > -	if (IS_ERR(ser))
> > -		return PTR_ERR(ser);
> > +	outgoing->ser = kho_alloc_preserve(size);
> 
> Does this allocation need to be gated by kho_is_enabled()?

No, if kho_is_enabled() is false then liveupdate_register_flb() would
have returned -EOPNOTSUPP and thus this callback would never be run.

> 
> If KHO is disabled, kho_alloc_preserve() will silently add tracking state
> that will never be used.
> 
> > +	if (IS_ERR(outgoing->ser)) {
> > +		kfree(outgoing);
> > +		return PTR_ERR(outgoing->ser);
> > +	}
> >  
> >  	pr_debug("Preserved struct pci_ser with room for %u devices\n",
> >  		 max_nr_devices);
> 
> [ ... ]
> 
> >  static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> >  {
> > -	struct pci_ser *ser = args->obj;
> > +	struct pci_flb_outgoing *outgoing = args->obj;
> >  
> > -	WARN_ON_ONCE(ser->nr_devices);
> > -	kho_unpreserve_free(ser);
> > +	WARN_ON_ONCE(outgoing->ser->nr_devices);
> > +	kho_unpreserve_free(outgoing->ser);
> > +	kfree(outgoing);
> 
> If a driver fails to unpreserve a device before the FLB is torn down, this
> WARN_ON_ONCE triggers, but the memory is still freed.
> 
> Does this leave dev->liveupdate.outgoing pointing to freed memory?

Yes, if a driver unpreserves a device without notifying the PCI core
then that would lead to the PCI core having a pointer to freed memory.

I can make this code more robust against buggy drivers in v6.

> 
> >  
> >  	pr_debug("Unpreserved struct pci_ser\n");
> >  }
> 
> [ ... ]
> 
> > +void pci_liveupdate_unpreserve(struct pci_dev *dev)
> > +{
> > +	struct pci_flb_outgoing *outgoing = NULL;
> > +	struct pci_dev_ser *dev_ser;
> > +	struct pci_ser *ser;
> > +	int ret;
> > +
> > +	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
> > +
> > +	if (ret || !outgoing) {
> > +		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
> > +		return;
> > +	}
> > +
> > +	guard(mutex)(&outgoing->lock);
> > +	ser = outgoing->ser;
> > +
> > +	guard(write_lock)(&dev->liveupdate.lock);
> > +
> > +	dev_ser = dev->liveupdate.outgoing;
> > +	if (!dev_ser) {
> > +		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> > +		return;
> > +	}
> > +
> > +	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
> > +	ser->nr_devices--;
> > +	memset(dev_ser, 0, sizeof(*dev_ser));
> 
> If dev->liveupdate.outgoing was left dangling from a previous torn-down
> session, can this corrupt memory?
> 
> If a new Live Update session starts, pci_liveupdate_unpreserve() would
> fetch the new outgoing FLB but operate on the old dangling
> dev->liveupdate.outgoing pointer.
> 
> Does this code cause a use-after-free in the memset() here, as well as
> corrupt the new session's counter when decrementing ser->nr_devices?

I will clean up any dangling pointers during pci_flb_unpreserve() in v6
to protect the PCI core against buggy drivers.

> 
> > +	dev->liveupdate.outgoing = NULL;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260512184846.119396-1-dmatlack@google.com?part=2
