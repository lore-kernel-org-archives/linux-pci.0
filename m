Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCE3655FA
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784074; cv=none; b=TyZcUwO4mUrfNBj75ho6ZIwomVYnM8OUZoDFFbM1j/3Q9FGxbGNVN+ADnhqZhlKA0w1szvNGzKYIXdPQurUu59xL8nAXUdoIZXNR8RloVhZORIkCw2QUlaZvLFOrViEFjCBMWhGcUW0aGndA7Oq7Ilm20nhIs87PK77OLXE24vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784074; c=relaxed/simple;
	bh=0lKuO/cTqQS7pGsVVjbnHgg88YxPkt0DwiFy+aM6C9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I21wvfDb1qt3HnjM2b91yB9Ve66nYJi9Essq/D/5N8Ufgp9tOI6KsE6/beIjnTIuXK9AjdDCqfK4+i4lwEujbIEQOTkRcXr8PF124ilvmhKeGkTfN58VzFkS5fyKOBndIkwmgl+6MlEAA1V+zQLq/2eSZSusBP8SqRJ7ksGvPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8HvUuOu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8HvUuOu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36622412e97so5505540a91.2
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778784071; x=1779388871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/9wI3EBrzulRZ/UWRjzk7TAc6Cxt2CXG7DkwZbEc8og=;
        b=h8HvUuOuyrH9czhV8tMf02uZ23R75RET8lMcxQnVCGgaq0jJ1qQfqRwaOMrWh0F65+
         QtbvIr5ntIIWPVGh1hEeMzvq5zRz5bzQB8YQJZF4qGG38aHnokOiVxC6otFqjutCmagn
         emqllO/iPlomvdje+qwl5z5qUme9AsC8a9yupwNtjnRrN1oRjcPexaV8A/EGbgYNptEC
         owOf1D98OVK53kpw5URDJ7qB1UxaBO59i/hwLCnDqQqtOanRX+0T4krQJqav0snRqF4S
         i0T18bLGruj6dZOyIvxeQk8jVtT4bFXBakakNXP3O/M7JXdRFuF8XliCNIt2VveOgNKv
         H0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778784071; x=1779388871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9wI3EBrzulRZ/UWRjzk7TAc6Cxt2CXG7DkwZbEc8og=;
        b=ntb+qBhmTpvdwFGxNm/AxCpoIGx8RjVWRjbBKotiyMdOsniIw/CiAgAtTT3jKijHHR
         KKu5AMxuaGjvGns6HxRV+RXR2D2JTwCDJP0/EfKWQgrGfDFg9oTepgiFFjgg8eJ9EmBv
         lgxM5oK6R0AhO6OQ38x1WR3Qk7RogBg+BgKVHQ35frCZYGyyovtgL+W4yNa3S+uzCACQ
         ro1lgtSNeR9QiR+tLl7CRDQPabQYXHEGFCXgoe554sF7QTrSCY4keh7H1JPJHQOSRSIg
         paRhlSwT3CBMX29XJKRa8mRKb5gVBcgbq3woVtae+t0QvwyKpsi6Odubbl+EhTsteYHk
         LtCg==
X-Gm-Message-State: AOJu0Yy1GdtVexAQWlaSShQ+gBEsRwue+/rwcoGDtoJVPEAP+/q8djRk
	BPvLGHrN1B0ke+WeC5xOdoCAN2lNyBSxlGOICWN5lsFBx8sbLLdG/CDMjAhPFOttHA==
X-Gm-Gg: Acq92OEl14LCNWHhqPqA/hUszf+CAffL9k7ysagGezNZNightM0BPnqyGLUj2GT+Dot
	F02TH36GNJEuu8+X5oIXo+Ip0DAviBg/28fPXM4LVn5fhFJjhqY5PYGek8q4zPhq2sI4DuDXgh/
	OOzDCP6nguWfKEDCgzCPI8aDtGjyuPosAS+K0VKZ7uNtQGteifMpw+ZEm+j807p2N2rGw0fzzBS
	sZMouhxxCkcTYRZ4F2AqHwG7d92pDccQ5wF4+yYC0Y/CIj3rO6BJbB4itALSsPXBtmEFyZWxzam
	4v1JLBBoteXJtGWzSzZwx0awWjjvrKpH3OeObaqCD5pRM/Wh8iA7uxdP4TCwGZo2L+bWTgAyjIR
	aC7c5XQ4KHxAlwvKi7lK7zXQNkPGW7FZ+/yLt0US4a7VyJ1fPYTPY4vivYGJmo1WDYPx3o/1hKH
	iX+HqnPwi9hnwj9CuBYJAFylDw8hcCVjkLLjxi0DdhZJe6n/bCR7SKYMzFU5DY6PSKmzjlZketi
	pCg9JCKPMk=
X-Received: by 2002:a17:902:d702:b0:2b7:88f9:9c3d with SMTP id d9443c01a7336-2bd7e7cb191mr6124705ad.12.1778784070937;
        Thu, 14 May 2026 11:41:10 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c263a0fsm33512605ad.37.2026.05.14.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:41:10 -0700 (PDT)
Date: Thu, 14 May 2026 18:41:07 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 06/11] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <agYXQ76N4mSDOqHC@google.com>
References: <20260512184846.119396-7-dmatlack@google.com>
 <20260514020517.DE0DFC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514020517.DE0DFC19425@smtp.kernel.org>

On 2026-05-14 02:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Kernel stack overflow via deep recursion in `pci_liveupdate_preserve_path()`.
> --
> 
> commit 9dcae64241d06ee18edeb26c25b9a7b263aa05a4
> Author: David Matlack <dmatlack@google.com>
> 
> PCI: liveupdate: Auto-preserve upstream bridges across Live Update
> 
> This commit introduces tracking to auto-preserve upstream PCI bridges when a
> device is preserved across a Live Update. It adds functions to preserve,
> unpreserve, and finish the preservation of devices and recursively applies
> these to upstream bridges up to the root port.
> 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 558fbaec8dddd..d8e06afde2c76 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> 
> [ ... ]
> 
> > @@ -363,8 +389,82 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
> 
> [ ... ]
> 
> > +static int pci_liveupdate_preserve_path(struct pci_ser *ser, struct pci_dev *dev)
> > +{
> > +	int ret;
> > +
> > +	if (!dev)
> > +		return 0;
> > +
> > +	ret = pci_liveupdate_preserve_device(ser, dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pci_liveupdate_preserve_path(ser, dev->bus->self);
> 
> Can this recursion cause a kernel stack overflow?
> 
> The PCI specification allows up to 256 nested buses in a single domain, which
> can occur with deep Thunderbolt or USB4 topologies.
> 
> Because the recursive call to pci_liveupdate_preserve_path() is followed by a
> potential call to pci_liveupdate_unpreserve_device(), it cannot be optimized
> as a tail call. This forces a new stack frame for every level of the PCI
> hierarchy, which could overflow the standard kernel stack, especially with
> KASAN enabled, and cause a crash.
> 
> Could this be rewritten to use an iterative approach instead?

I used recursion to simplify the code and based on the pre-existing
examples of using recursion in the PCI core, e.g.
pci_scan_bridge_extend(). But I will take a look at an iterative
approach for v6.

> 
> > +	if (ret) {
> > +		pci_liveupdate_unpreserve_device(ser, dev);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> > +static void pci_liveupdate_unpreserve_path(struct pci_ser *ser, struct pci_dev *dev)
> > +{
> > +	if (!dev)
> > +		return;
> > +
> > +	if (pci_liveupdate_unpreserve_device(ser, dev))
> > +		return;
> > +
> > +	pci_liveupdate_unpreserve_path(ser, dev->bus->self);
> 
> Does this code have the same recursion issue as pci_liveupdate_preserve_path()
> and require an iterative approach?

See above.

> 
> > +}
> 
> [ ... ]
> 
> > @@ -519,28 +656,18 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> 
> [ ... ]
> 
> >  void pci_liveupdate_finish(struct pci_dev *dev)
> >  {
> > -	guard(write_lock)(&dev->liveupdate.lock);
> > -
> > -	if (!dev->liveupdate.incoming) {
> > -		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> > +	if (!dev)
> >  		return;
> > -	}
> > -
> > -	pci_info(dev, "Device is finished participating in Live Update\n");
> >  
> > -	/*
> > -	 * Drop the refcount so this device does not get treated as an incoming
> > -	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> > -	 * again because the device is hot-plugged.
> > -	 */
> > -	dev->liveupdate.incoming->refcount = 0;
> > -	dev->liveupdate.incoming = NULL;
> > +	if (pci_liveupdate_finish_device(dev))
> > +		return;
> >  
> > -	/* Drop this device's reference on the incoming FLB. */
> > -	pci_liveupdate_flb_put_incoming();
> > +	pci_liveupdate_finish(dev->bus->self);
> 
> Does this code also have the same recursion issue?

See above.

> 
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260512184846.119396-1-dmatlack@google.com?part=6
