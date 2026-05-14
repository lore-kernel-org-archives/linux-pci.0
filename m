Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563334D38B
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784543; cv=none; b=e5VuFdWG3glyRg5KZsKgl3i4Kv/yVJzMWD9U0ogBUfbVR3GAq18T79UvrazYsAOkhJk/xO72SmVDErdY8NX1vnHfFes9/UBo0ADrpNOsjRgo0KmowDQgx2phC9c5cUwBEp+m+AmD8JaClobJsAgiIhg5oK0Cz1t4KeRhhaku7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784543; c=relaxed/simple;
	bh=S+HQA3DBDmaAzjxiWBE3o5kycRdNrVouq6LdlBu+WoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBHLm4syrab0VNuhNAOs+zn+QJixxftLSi+S3tXR5uZr8SAOFLdO4h6gvXKHoRBrMqjp8xRpWeGOaUHE0Hh0bvCZ19h2bSLL4mHKH0yIZq6nUolMDXftnEECZHv6sxFRLf+yyCEWv1KI5tUyz6BkR8txJo3D8UhTLAg58vlon24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksZVlJBt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksZVlJBt"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-366330b6751so5704820a91.1
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778784539; x=1779389339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8yEpAjdQMsKna7KcQWgbLZNAzQyoKwhHcUHxguzEl8=;
        b=ksZVlJBtWe+Clccx3ppCKa4KZMoqb4PLVRm5w58MZc0Q22R7p+zxIjU8W8oRXX198o
         zhGjEy29yc2pkfUFJmbJToIgtWGjqJUyNU3jtwNQBNMleErrv52w+LhZ0gJNqESSn8k/
         hwrE+uZZAb+se3V8CGlpDt4w/dRoN4SPyPX2DhviW7Gm50xCgK8ti4L/C3CFwMGPdm9V
         erPWt8NTEInNhqAH/F/iAoDWW4bNYs/LPMkhGEa66piZcp3O3d5tCmYr5UrT58RF/r3G
         2WpdoP8x+brkxk9qu8pSZRBVl6K4s5wssPqz+B+Sd95LIWqpD0cHVxyKjAi/kmT+VtIZ
         MQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778784539; x=1779389339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8yEpAjdQMsKna7KcQWgbLZNAzQyoKwhHcUHxguzEl8=;
        b=LL8EGK2lSWYa9xfxJ007uuhkzBykxus0h4UKqqGPZfS4cZ2sopwU3helVJg+OoedMj
         JquGWjdYfol0QHdRKBDTIIvzTtJ2QpsrJfot4Z4N08Apx8kmVzgv0D8QVQ4UHlpLQfp9
         zC2OdKeZutCYNWhXyOwF5hCEzSSnUEBkcQF4ade0Mphlx2EhJ1QVqYqLqO5ImF2JmAXR
         MuO05qzc7KUmApMDYrCuvgkNrYjnKz8q0rmHJKorPRoCxqiPaAkiu+NiWUwhkr0gWDjs
         I6Gh9MOP06/O8KmyC9ujuwYAHa2cO2rxtny8Bjk/xTnXjrLdJHEAmQc6wbwLRVZg6OoC
         vy1A==
X-Gm-Message-State: AOJu0YzP0vq37ezgXHfg1CHma7QaMgdMoHF5AGRmMoNXNJcLKXxYr7mT
	x8pluqCobOIx06CTJiSbwF+L5QF5wz/6OeUOMiUA23EAHLdkUaLPeiut4kcHCujFqg==
X-Gm-Gg: Acq92OGcIcOMf8HZro2IYsde9QAidnAvo5R52mrfrAqDxw2icC5v1vkDp3l7OUVN54S
	3mXfzBaLNktckA6ItgsN0bld7l06p6vhAqBO4lnrJz/A4e47VzYd2f2Y4g1Lbpg2MF1AMrs4TTr
	dXBtldQfMKNBJpFWUdbWhuj+m1bFQo194/TI0HuTDnLfD9qRB+wJVh4a+9tsRuz7//EtH0r8ODh
	TypqaO/SZQ4Cg5w4YCFoosXTaDNgU1/nXI2USWMU4eBXj2NdqdPYH9VvbRpv4cg+H/HbiZYrakW
	ZFKZc6+Gl3/F4/BFTuBmo1vt4vvqedHP5a7bePUfAXFs0MYv8FcekHyJRPl2lMXcy9L1f7TEJGI
	6ncLExuMBM/pnw02QOtA0gl4tLr+WRL6olFFXgHlHwD+HcgDjwtgFPJbhX+gYexjZRNu0u8plAJ
	dWNdOkKt8Mb1yQsgVLgq25/hQIrEmCOJunoEOWKf+uHBZAb0M6LCC7mQ5AJGUArPc3rvDoLZYE
X-Received: by 2002:a17:90b:3dc4:b0:365:fca2:8bdd with SMTP id 98e67ed59e1d1-36951778509mr672982a91.0.1778784538661;
        Thu, 14 May 2026 11:48:58 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517a820fsm315498a91.10.2026.05.14.11.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:48:58 -0700 (PDT)
Date: Thu, 14 May 2026 18:48:55 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 09/11] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <agYZF7W-hRtj_IX6@google.com>
References: <20260512184846.119396-10-dmatlack@google.com>
 <20260514031440.483F0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514031440.483F0C19425@smtp.kernel.org>

On 2026-05-14 03:14 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Preservation rollback fails if the device is concurrently frozen, breaking bridge hierarchy invariants.
> - [Low] Syntax error in the !CONFIG_PCI_LIVEUPDATE stub for pci_liveupdate_freeze().
> --
> 
> commit f49768e50767ced554fd83ab7e5016423c3d87a2
> Author: David Matlack <dmatlack@google.com>
> 
> PCI: liveupdate: Freeze preservation status during shutdown
> 
> Freeze a device's outgoing preservation status (preserved or not preserved)
> during shutdown. This enables the PCI core and drivers to safely make
> decisions based on the device's preservation status during shutdown.
> 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 6ab03bd548b37..825166a579130 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -334,6 +334,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_ser *ser, struct pci_dev
> >  
> >  	guard(write_lock)(&dev->liveupdate.lock);
> >  
> > +	if (dev->liveupdate.frozen) {
> > +		pci_WARN(dev, 1, "Cannot unpreserve device after it is frozen!\n");
> > +		return -EINVAL;
> > +	}
> 
> During preservation rollback, can this check leave a child device preserved
> while its parent is not?
> 
> If pci_liveupdate_preserve_path() successfully preserves a child device,
> but fails to preserve the parent bridge, it attempts to roll back by calling
> pci_liveupdate_unpreserve_device() on the child.
> 
> If a concurrent system shutdown calls pci_liveupdate_freeze() on the child
> device before this rollback occurs, this check will return -EINVAL and
> fail the rollback.
> 
> Does this result in a broken topology being passed to the incoming kernel?

Hm yes that race does look possible. Will fix in v6.

> 
> [ ... ]
> 
> > diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> > index fd7693c7ddd21..30deaa673efed 100644
> > --- a/drivers/pci/liveupdate.h
> > +++ b/drivers/pci/liveupdate.h
> [ ... ]
> > @@ -26,6 +27,10 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> >  {
> >  }
> >  
> > +static inline void pci_liveupdate_freeze(struct pci_dev *dev);
> > +{
> > +}
> 
> Does this stray semicolon after the function signature cause a compilation
> error for kernels built without CONFIG_PCI_LIVEUPDATE?

Yup, Mike Rapoport and kernel-test-robot also flagged this off-list.
Will fix in v6.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260512184846.119396-1-dmatlack@google.com?part=9
