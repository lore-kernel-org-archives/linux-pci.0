Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854402D836D
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783258; cv=none; b=mElL3RXFAGyg0CQfbZ3jv74PITZuyZJ1RtiAMl+D1UEdWMhnoO1Hfg28mWb0k8vMAWKDZZpbq4CjcKyQH2w7Bo7NxUBrB/fv+0ED0A5K3Pdqq8dXZSTwNJeIrut5c1cDqMdheWZ+oI+GOWWHX+vyk1tPJe+ghBFfdVOTIJ79GQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783258; c=relaxed/simple;
	bh=aVw1OWGbmIDbHVY3BwLts2n5HpVXMHPTRJSvQJGBYAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMAB0IUL0PgZ2wFNyeEpWslaSuhgWEthDkA5T/IeYO3N1+SITKrLvkQBQ31Jp25TmvyxJODK9S+A1RMqADY3+UdQeG1gw9QYWXgQpgMXWAl6fvCWAM88C+u3fE15HIhMUxrEEcLd2FQxtBaUDWA+x5xOCOvgMJXKEiqyrjOprbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NlvwFhUX; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlvwFhUX"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1335cb20406so419068c88.0
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778783256; x=1779388056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hg6IMrnQ8rIdunh62Bq5pOIvEVv9aCeOeb/XYHKMD4Q=;
        b=NlvwFhUXvDffAFrg7hKwyMtr7FnZj/7wZaozXd5FSEGmXEscBfh6J92v6sgjl4PMTT
         Ys4tc0urHRIr1jYTy6mRDmCGpDLsI2X7/vOaiixd+6myCkFLFQfWszrGqAhFO65DFEnY
         ISJ10DauWKPdf8+e6q3lgl85QBTP86sLg1OhRhW+fXVKzZ/qnHlW2G6qXwCbbn/jYH9r
         MzhtQLrwyvHfrorCgYf764SPdOtBJ/v9YBCVwz5rfcmIdUgCbxJeLAZQ8d1m/Dhhjoy4
         oEnvxTTJhgAXUkqhhTF85DVfFrTEQsmrgTLLeKSHMpPPh5Vfg4afMTUZ6Zt2DJ7PnsDo
         asWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783256; x=1779388056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hg6IMrnQ8rIdunh62Bq5pOIvEVv9aCeOeb/XYHKMD4Q=;
        b=X7i1QrJ9gVq22s0+Q9+6/ezv5Phd4pnBi14JmEolylynGeaVFzMutyG58T0puYBUi3
         Q332fP2ldhY/oVxgaop82S/W1DSV0zTTImD8B9qmD4r8XJVK3iuhuwTltLLWxR+SRGQf
         EMP9kg85/4MCQ/mW+lpZFUolfl8WgrDem5cLSUgqOZSWH+EoNT7iLoV+0ZEqHyogwusV
         EV+Y34bZZQc9C1u5NRAkuLL7cPMtO8D9JeadJqvuRIGH9CiqmHTv39qSC7R+HSgbzLLJ
         4Rtx1ptekXwYtw7Ypyzp91BugunrCZuIlZZFY9SDMQ2C7hIlTplUd7q2nvEsmX0664iG
         rMCg==
X-Gm-Message-State: AOJu0YwZ1Cfdq/jYcOtaYi9b/DeSmEPUBk6lXkcXtLb2P/8hyENL/J+L
	tdStid6I+wGlWaiy4/9Fnm/6HsU7RYzD10QuPvkmp6S+MgQMq8DyB04IX+dEytjiIyO9fcjfc3H
	5AGibQw==
X-Gm-Gg: Acq92OEIxl6fkWAAcTLxJEkMUrpmm4mwQpYBTt2eOl6n+nH1kln/MIYjEMaegxQh9Ed
	fRyhZpS4JU7kkbvl3KQkAImpoogJA5D9hZk+9r1mY/KAWpXPUJq/2l2AjZNFLI/VkHW7cXYxOYt
	rctRIM+BFwXNVzNdSSfPfNjAKhznoq+y6Gh6IPGr9K1ufI/N/BaFHn0lhqpw2EMfgqRSizYy++p
	31Qeh/usLIya04zMlrGwjq6kKxokY7ufE/ASVJV/i7maet1rhOFKmt+1KgHbuZIpl69UUn5fTUn
	luYAVBe3XrHKb95KrGjANjznjk0abfWRuDtpQUkpUZlqIoXVkvp/NjhZetMWAVRt2mGWBrWZOaJ
	NpZX/hYy2/w7TGkUD55iNTngezs8dEUS5sInCJGT5QWaIw15SRwQBl4LuA93QYgxCMfteWiE44U
	6dYDyd0CBMPh1UBC6vLbWWQLQfAUF2e7itgt9bF0GHPr0Ea+TQc2ehhczU5JcimLfL09GuntQcR
	CfioW23pCQ=
X-Received: by 2002:a05:7022:41a7:b0:134:def6:e70b with SMTP id a92af1059eb24-1350451e322mr126140c88.6.1778783254874;
        Thu, 14 May 2026 11:27:34 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cf44668asm4587270c88.6.2026.05.14.11.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:27:34 -0700 (PDT)
Date: Thu, 14 May 2026 18:27:30 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 03/11] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <agYUEtoSFyvJewNg@google.com>
References: <20260512184846.119396-4-dmatlack@google.com>
 <20260514010518.B0B41C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514010518.B0B41C19425@smtp.kernel.org>

On 2026-05-14 01:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] Integer truncation in `pci_ser_xa_key()` drops the upper 16 bits of the PCI domain.
> - [High] Memory leak of KHO-preserved physical pages in the error path of `pci_flb_retrieve()`.
> - [High] Subsystem guide violation: `pci_flb_preserve()` calls a KHO serialization API without checking `kho_is_enabled()`.
> - [High] Data corruption in `pci_liveupdate_unpreserve()` due to decrementing `ser->nr_devices` without compacting the array.
> - [High] Use-after-free risk because `pci_flb_unpreserve()` leaves dangling pointers in `dev->liveupdate.outgoing`.
> - [High] `pci_liveupdate_finish()` calls `pci_liveupdate_flb_put_incoming()` under a write lock, risking a sleep-in-atomic bug.
> --
> 
> commit 46fdddc110c525ef02301643989348b7f03a10c0
> Author: David Matlack <dmatlack@google.com>
> 
> PCI: liveupdate: Track incoming preserved PCI devices
> 
> This commit adds support for tracking pci devices preserved across a kexec
> via live update. It introduces setup and cleanup hooks for the pci core to
> manage the incoming live update state of these devices.
> 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 9c4582ecd55cc..f14396dd14773 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -85,6 +101,21 @@ struct pci_flb_outgoing {
> >  	struct mutex lock;
> >  };
> >  
> > +/**
> > + * struct pci_flb_incoming - Incoming PCI FLB object
> > + * @ser: The incoming struct pci_ser from the previous kernel.
> > + * @xa: Xarray used to quickly lookup devices in @ser.
> > + */
> > +struct pci_flb_incoming {
> > +	struct pci_ser *ser;
> > +	struct xarray xa;
> > +};
> > +
> > +static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
> > +{
> > +	return domain << 16 | bdf;
> > +}
> 
> Can this integer shift truncate the upper 16 bits of the pci domain?
> 
> Because domain is a u32, the shift expression evaluates as a 32-bit integer.
> This discards the upper 16 bits before the result is promoted to the 64-bit
> unsigned long return type.
> 
> If devices are in domains >= 0x10000, this will produce colliding keys,
> causing them to overwrite each other in the xarray.
> 
> Could this be cast before the shift, such as
> ((unsigned long)domain << 16) | bdf?

Ah I thought I had fixed that in v5. Will fix in v6.

> > +
> >  static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> >  {
> >  	struct pci_flb_outgoing *outgoing;
> 
> Does this function need to check kho_is_enabled() before proceeding?
> 
> According to the kho subsystem guidelines, all callers of serialization-side
> kho APIs (like kho_alloc_preserve() used later in this function) must
> gate their usage on kho_is_enabled().
> 
> Failing to check the enabled state can cause null pointer dereferences or
> silently add useless tracking state that will never be used.
> 
> [ ... ]
> 
> > @@ -140,13 +171,44 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> 
> Can pci_flb_unpreserve() cause a use-after-free risk by leaving dangling
> pointers?
> 
> When an outgoing live update is aborted, this function frees the outgoing->ser
> memory via kho_unpreserve_free(). However, it does not clear the
> dev->liveupdate.outgoing pointers in the pci devices that were already
> preserved.
> 
> If a new live update is initiated and pci_liveupdate_unpreserve() is called
> on those devices, it will execute memset(dev_ser, 0, ...) on the dangling
> dev->liveupdate.outgoing pointer, corrupting memory.

This was addressed in the patch 2 thread.

> 
> >  
> >  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> >  {
> > -	args->obj = phys_to_virt(args->data);
> > +	struct pci_flb_incoming *incoming;
> > +	int i, ret;
> > +
> > +	incoming = kmalloc_obj(*incoming);
> > +	if (!incoming)
> > +		return -ENOMEM;
> > +
> > +	incoming->ser = phys_to_virt(args->data);
> > +
> > +	xa_init(&incoming->xa);
> > +
> > +	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
> > +		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
> > +		unsigned long key;
> > +
> > +		if (!dev_ser->refcount)
> > +			continue;
> > +
> > +		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> > +		ret = xa_err(xa_store(&incoming->xa, key, dev_ser, GFP_KERNEL));
> > +		if (ret) {
> > +			xa_destroy(&incoming->xa);
> > +			kfree(incoming);
> > +			return ret;
> > +		}
> 
> Does this error path leak the preserved physical pages?
> 
> If xa_store() fails, this returns an error code without calling
> kho_restore_free(incoming->ser). Because the function returns an error and
> does not populate args->obj, the live update core will not call the .finish
> callback to clean up the memory.

Yes if retrieve fails then the preserved struct pci_ser gets leaked. The
user is likely going to reboot the system anyway since the preserved
devices will not able to be retrieved, so I don't think leaking is a
problem in practice. But I also don't see any reason why we have to leak
it. I will free it in v6.

> 
> [ ... ]
> 
> > @@ -268,6 +330,163 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> 
> Can pci_liveupdate_unpreserve() corrupt the live update tracking state by
> leaving holes in the array?
> 
> Looking at the body of pci_liveupdate_unpreserve():
> 
> drivers/pci/liveupdate.c:pci_liveupdate_unpreserve() {
>     ...
>     ser->nr_devices--;
>     memset(dev_ser, 0, sizeof(*dev_ser));
>     ...
> }
> 
> If a device other than the most recently preserved one is unpreserved, this
> leaves a hole in the array and moves the allocation cursor backward.
> Subsequent device preservations will overwrite currently preserved, valid
> devices at that index.

Leaving a hole in the array is the intention. ser->nr_devices is not a
cursor, it is the number of valid (non-hole) elements of the devices
array. pci_liveupdate_preserve() specifically walks through the entire
array to find the first non-hole to use for the next device.

> [ ... ]
> 
> > +void pci_liveupdate_finish(struct pci_dev *dev)
> > +{
> > +	guard(write_lock)(&dev->liveupdate.lock);
> > +
> > +	if (!dev->liveupdate.incoming) {
> > +		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> > +		return;
> > +	}
> > +
> > +	pci_info(dev, "Device is finished participating in Live Update\n");
> > +
> > +	/*
> > +	 * Drop the refcount so this device does not get treated as an incoming
> > +	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> > +	 * again because the device is hot-plugged.
> > +	 */
> > +	dev->liveupdate.incoming->refcount = 0;
> > +	dev->liveupdate.incoming = NULL;
> > +
> > +	/* Drop this device's reference on the incoming FLB. */
> > +	pci_liveupdate_flb_put_incoming();
> > +}
> 
> Can calling pci_liveupdate_flb_put_incoming() under a write lock cause a
> sleep-in-atomic bug?
> 
> This function calls pci_liveupdate_flb_put_incoming() while holding
> dev->liveupdate.lock (an rwlock) for writing. If the put function acquires a
> sleepable lock internally, calling it from atomic context will trigger a bug.
> 
> This contrasts with pci_liveupdate_cleanup_device() which drops the lock
> first using scoped_guard().

Ah I fixed this in a later patch in the series but forgot to also
address it in this intermediate state. Will fix in v6.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260512184846.119396-1-dmatlack@google.com?part=3
