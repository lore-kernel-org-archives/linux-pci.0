Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B6472559
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665525; cv=none; b=VYcc73Zbf8nPJJ0T0buc8Q5UXVaP40zmKZ04TczvZsD/X01mw+5mxwNm3/DchvCC2ZOJH64nWowRSdHrMgzLVcSqVGLqZs17hb6Vue5JCrQ3uvIa+l9hFWu1Hfyy1s1gnWbMZHkg3hB7mLk/hFNmZmS0sM/CBjoXdER3eAU3/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665525; c=relaxed/simple;
	bh=JWkoXRoccFwTy/vIl+0vMHedc09XwWgCov7XLX16Gus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0y45XVqmFPqhThmfGWxPetfkkEZyuuezw59c+gqM+lTEa6finQGcSQNwAhHK/45nOiUKiuRJGKgiYuhmgwEFNqm+12IFvwl6hS4dJXZSD9fJkW/MkWWXO8b+0l+CFsLDTpRCR00B12jpgMBltqil3VHRGkSalUZyUqLqEVZsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nF/+WVfh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nF/+WVfh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caf228a910so93423705ad.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784665523; x=1785270323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbz1iYT6k9l+H6Z3FTtCF6cLZIfTcAcJKlDT5dYK2AI=;
        b=nF/+WVfhWA6n+4V2wrxKruKWtTOwHpOZ5w68k+wDMvwoKyRy1v1SUNf1uo1DZOtjiM
         MMkJ8TKn7KruEol3fupXsyokvmnmoBch0rS8XMCrvB0cPkP0KEVTSgHFTHwlydKfnZ4/
         CqbVmyzMGKnxJLCSgxVZ7EegZi4qus36LYXISy16RV8opixRPZqBor5TUSJMwjzhbGg3
         ggFZDCy6yJcD58g5qpRHwvjB5giQVG75Xs6Amsrin0u5I52gq9dOYsWQQYxiCLwA6YAO
         WmqlqXeRq+YX2QEEE81PF3y+/lHpL26yrX3KwyqDbxqlmp3PbkBrIHxAjL19rQPrhq+m
         uDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784665523; x=1785270323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vbz1iYT6k9l+H6Z3FTtCF6cLZIfTcAcJKlDT5dYK2AI=;
        b=Iveh7Htqqhz8gM92GAkGATFAhxDJ0jFbPQPDUlt4f3voA36dL6QDt/NF36xNXThCig
         CMVhGcKQK3gsag6cLZdhw5a0lVmKJ9XgSTlr2AUCnw+CSrGzpKNchDNeAZ7isEp7nUyE
         Bmsm7B38snaIulAO3v37wnHJ2QqitTOdWk8eyewJ7ZL39G8WJTiH8TSPD2yg038Lsy1R
         X+omBWm2iKMn7ZYaEYmW5ahjrkABmx/t3GYX/2v5gKXHEjplh8QtUZwD3HxApm3dGNcm
         dBi9nClXhRfyhabx10bmvhffc2gnBH5gzQJH3ZCCu6BQsO/6OVkF0kNYM0it0aAA1jnP
         Bn+g==
X-Forwarded-Encrypted: i=1; AHgh+RrHuO2l6LXVOY/AG8ORYS7Q8tzlDKCxbbQWkG1LQP6t81NrBvj3BCshPg6ZHfdNHiagOslqeqEpXng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6p07Tbxjh4Jco3XKCW39ezxzWzYMv9jmUDaB4hH8XGXnyEs2b
	0evIZUUNR6y5mYOuBnyqag9EFSUkcgQazNUZVcDzHz++nyXwM1C4fNuBWKwjVWFtFg==
X-Gm-Gg: AR+sD12CTgsHdkxRGZUUtaVGjiAISsiHVVmpQ0wEI3KOPCueL0Gue7Vo4gXAKGs4qkN
	1AfJTVofzk8vBqSKmShESEW3HvJUKnY8SGj0zgwX1R94ROMTZkEpvwbO+rFplxCJ4r2YjoPZ6F5
	N/a+qkTzmjByhwSusRz2yU33ERMlpTvotpmo438bB5bKbjbgZo6NZCZhZ8yNGfYIoOwgnr39FJu
	fHE88zcrAb959mCQ+UUszG2bom1XKskTeohKVQm1fWwnraVB2J7mVm/2SD3URxMhE2hGA1sGggF
	OiLVLtgwGthS5u1BpTlZFoHzjKCzYTjQFlE1NTK3zqR5io1rlWAIo3SRxL+Jn4N+gUPM0Gqkvky
	ShmzwKLboZobHybv1Wdbv3XefDymJuBMoJXvBnfIP4yj6MwRq/uTD/hDW3se7HlcXQxez6TnpK/
	Hl95IZrHmJsXo3BeWb/Qckd5iGMVmjQqZcR0GawZLI
X-Received: by 2002:a17:903:b08:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2cf34835859mr235453285ad.8.1784665522497;
        Tue, 21 Jul 2026 13:25:22 -0700 (PDT)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3b7c9dsm2391865ad.83.2026.07.21.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:25:21 -0700 (PDT)
Date: Tue, 21 Jul 2026 20:25:18 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <al_VrpvPE-RLCF5X@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <178458744511.332171.13770778781241262180.b4-reply@b4>
 <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
 <178465652971.412167.17838319728990505256.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178465652971.412167.17838319728990505256.b4-reply@b4>

On 2026-07-21 05:55 PM, Pasha Tatashin wrote:
> On 2026-07-20 16:07:47-07:00, David Matlack wrote:
> > On Mon, Jul 20, 2026 at 3:44 PM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > 
> > > On 2026-07-20 14:54:51-07:00, David Matlack wrote:
> > >
> > > Thanks for the explanation. As I understand, the most straightforward
> > > way to avoid holding the permanent reference is indeed to delete
> > > dev->liveupdate.incoming entirely and perform an xarray lookup on every
> > > access, like this:
> > >
> > > bool pci_liveupdate_is_incoming(struct pci_dev *dev)
> > > {
> > >         ...
> > >         incoming = pci_liveupdate_flb_get_incoming();
> > >         ...
> > >         dev_ser = xa_load(&incoming->xa, key);
> > >         ...
> > >         pci_liveupdate_flb_put_incoming();
> > >         return dev_ser && dev_ser->refcount > 0;
> > > }
> > >
> > > However, as you note, this is inefficient because it affects every
> > > single device and adds lookup overhead to every access (not sure about
> > > the actual cost though, xarray access is pretty fast!).
> > >
> > > We can, however, still avoid tinkering with the lifecycle of the FLB,
> > > and instead treat dev->liveupdate.incoming as a "hint" that we validate
> > > on access with a fast, liveness check:
> > 
> > Can you tell me more about your concern about FLB lifetime?
> > 
> > The lifetime of the FLB will not be affected by this reference unless
> > there is a bug in the driver where it fails to call
> > pci_liveupdate_finish() during it's file handler finish callback.
> 
> From a design perspective, liveupdate_flb_get/put_incoming() is a 
> logical read-lock/unlock pair on the FLB data. We use a refcount for 
> optimization and sharing, but holding a get over a long asynchronous gap 
> (from boot-time device setup to driver probe) is essentially holding an 
> unbound lock.
> 
> Unbound locks make it difficult to trace refcount leaks or debug 
> lifecycle issues.

It's very standard for refcounts to be held for a long time, e.g. file
refcounts and device refcounts. LUO FLBs themselves already have
long-lived refcounts taken by each file that depends on themm, which
aren't released until that file handler's finish callback runs. The PCI
core is just doing the same thing.

> 
> > 
> > > 1. At Setup: In pci_liveupdate_setup_device(), we do the xarray lookup
> > > once, cache the pointer in dev->liveupdate.incoming, and immediately
> > > call pci_liveupdate_flb_put_incoming(). We do not hold a permanent
> > > reference.
> > >
> > > 2. On Access: When an accessor runs, instead of doing a full xarray
> > > lookup, it just validates the cached pointer's liveness by temporarily
> > > securing the FLB:
> > >
> > > static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
> > > {
> > >         struct pci_flb_incoming *incoming;
> > >
> > >         incoming = pci_liveupdate_flb_get_incoming();
> > >         if (!incoming)
> > >                 return NULL;
> > >
> > >         if (dev->liveupdate.incoming)
> > >                 return incoming;
> > >
> > >         pci_liveupdate_flb_put_incoming();
> > >         return NULL;
> > > }
> > >
> > > * If get_incoming() returns NULL (the FLB has already finished/freed),
> > >   the hint is invalid and the device is no longer incoming.
> > 
> > This avoids the xarray lookup but still requires taking the incoming
> > FLB mutex twice (once for get and once for put) on every access. And
> > if there's no incoming PCI FLB, the LUO will iterate over all incoming
> > FLBs under the mutex to find it.
> 
> Can we do a fast-path check first?
> 
> static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
> {
> 	struct pci_flb_incoming *incoming;
> 
> 	/* Fast-path to avoid unnecessary FLB querying */
> 	if (!dev->liveupdate.incoming)
> 		return NULL;
> 
> 	incoming = pci_liveupdate_flb_get_incoming();
> 	if (!incoming)
> 		return NULL;
> 
> 	/* Check again, now that FLB is acquired */
> 	if (dev->liveupdate.incoming)
> 		return incoming;
> 
> 	pci_liveupdate_flb_put_incoming();
> 	return NULL;
> }
> 
> This seems to gives us the best of both worlds: robust refcount hygiene 
> and a sane fast path.
> 
> What do you think?

It still seems like an overall worse approach to me.

 * From a performance perspective, the PCI core would still have to
   acquire the FLB mutex twice every time it needs to use the device's
   serialized state (once to acquire a new reference and once to release
   it).

 * From a locking perspective, the refcount doesn't actually protect
   against the device itself going through finish. So we still need the
   pci_liveupdate.rwsem.

 * From a hygiene perspective, each reference is held for less time yes,
   but there will more places in the code that need to acquire and
   release a refcount.  That is more room for bugs to leak a refcount.
   So I'm not sure taking more small refcounts is an improvement.

With the current approach there is just one refcount with a very clear
lifetime (that aligns with the device file's refcount) and no extra LUO
mutexes required to use the device's serialized state during device
enumeration & setup.
