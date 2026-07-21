Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE183471245
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656535; cv=none; b=UTHr5j3H5yvKUYaIGluxV1ezsqoDG0D1SkS8fBepjBop9yruzivlOZov0HeBZuwWQKKggFadaq9Lnl7L0ldo23Q9vzMK7Iir2AOZatckB1nzD/fg+f5UAFnFkfY3Y5Nur4oR1Cb8dOMduHwTQiE6toW0i5TN/LBua8+Hct0v7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656535; c=relaxed/simple;
	bh=fzgF3V5HF54yEqsnjagon7PnrwUxx4c7CuxO/Uie8BY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=m8W2n48GOB6RumEVvC41mfqeATt9BKm6XalU7YU8K0b1sntkCsQG3sDG2ktgXEpl0cxdGSIZIiN1XLuAO7rHZYEL+qtrG0alTAjLwcyA0ZI959FIbYLn12+RnBVmfXDGQg9qfQemtTgT+sBTn4hbzeEuqlOJWxQvE4vy70jaV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Fv/GQVrQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Fv/GQVrQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-907ae240ac3so7488306d6.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784656533; x=1785261333; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ea/F6w9Zt+Er+ldXlrQTi7dDqHaImBI68nyXrbPqNKM=;
        b=Fv/GQVrQ7RL3cqdVi7mEB+YpDgdLpQDSSGffsD5OMcz/fXT1L5NpVPdZ0ccTm+Mm/0
         2KGNP5Ux7sttdWB02OjSvltxROI95icearWQaw4aSEaRT7sTXR6da7L2sFqbuIrLVdCg
         RLB2Bs3ICcN8EM/ek+L/9NljM5RhWQ2dLnFe5sqhgufZryNqzQBBuhv5WzNfzTjsi2Vk
         5nADXoYHEKmMo960DaU9sI3IxCU6i0+CYHZmaKOhC4sP3shwDUcfOCUKsssZ2ZIX6lM6
         /tOF/1P1FMa6TfaEp2ohrVz0KY8AntDHsodGs9y7BTtiKbQPaOJ8YFLZHmYJDE6ovJt9
         xL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656533; x=1785261333;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ea/F6w9Zt+Er+ldXlrQTi7dDqHaImBI68nyXrbPqNKM=;
        b=J7FqonqPKgGbtd9ya/rEMZrx2qP/lH6pgRX2wHOvUaVsSgVmDEmGj+GB2esMqqYzS1
         Pkyr/E9zTfR5o/oFbFFCve5CX3+LbpvbJT5qlRe9pt6CxZizCtZtGINSJKcKMPuVdDcZ
         okS+cAVOH/C8zFLHJ5TZPWq8CZH+XQwrWPrMD0WmqRYetv9BFMp6CNESTXWv8eqYu03l
         PpCzPltNBG+8e3nAgOyeuxzusGp/2H3ru8Wn7mrYlzEiPmO/fAOxKePXDNqg5sVvQmzC
         IeFe8FQClPjA33Mhq/+VNbl0XSv65yxNogE7nErfwhErGJ3KwFoqPk49xWKr+w4SUR/j
         qkJQ==
X-Forwarded-Encrypted: i=1; AHgh+RoR9CDKXXCH0NGtuSI9dsjLkJnlPUC6qnUciE3ZqoQqfFB91bYkB12+4+B/WVVr80GY/01Zpw3GPPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3V1F4ZiwIQFzLvKUnOKs1WTPKLDQzHdnrx/UncQBWHFqNMLEn
	IAqPHnGNo9qfaKDiXG6/en2DnE/jJPVkw1cEoLgECdob8ClmwHMVIs+E3rdB9umqHt4=
X-Gm-Gg: AR+sD123+em7W95yZDwOHMgg1IOWmCAskE5DQTmyl2CyRc2UHfs6HMC2FChFTG+uAY0
	bqY1Nb2nfY3wktW0Ghu2gdlAqTPkzXZw5vkfdLFLt8GWt/pQPihSYuibELTfFQnBuaTWzuFb5J2
	rDQP0kPOZlT9GR3K+jRifKopNkDc+R5/uIZVWpYeQmBZZRMkbQa1lq6Jb4F94jdsydvntrvoDm2
	fWJxLkO3sfBpqyifI5DQXoK16Cvz6JfVFnSHjZveFoX0Bp1bK9BPhYfUYZDuKYp6ZnoJ4cnYzcn
	NKLkJfv0Hdonv9eNFauahowWztqrmDCsKODqBNSycJTzuQEArYPtpDHs5/UcOztere3bPXmP6dK
	3NRHA9wJYnaIpD4qHXXSYBdpuZ5rtTXXn0bo9oRB+stinGIr+oaIHzlFsfPlv/1JWUtb3uz6KrX
	RelXns3gY2BB+5tqGWO+GXMejZvJYsVaL7SoQFnz4=
X-Received: by 2002:a05:6214:2269:b0:8f1:8937:5dc7 with SMTP id 6a1803df08f44-907784ddf91mr239817166d6.56.1784656532475;
        Tue, 21 Jul 2026 10:55:32 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8df5d0sm1663826d6.18.2026.07.21.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <178458744511.332171.13770778781241262180.b4-reply@b4>
 <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
Date: Tue, 21 Jul 2026 17:55:29 +0000
Message-Id: <178465652971.412167.17838319728990505256.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=fzgF3V5HF54yEqsnjagon7PnrwUxx4c7CuxO/Uie8BY=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqX7KSG2dHPEQ6Mkut+xegrodYi1A9KSpnUO3pn
 xL+SSaK1qOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCal+ykgAKCRC7dyhM23N6
 3sbLD/9VJw+QusBVAbX9+6asMemVQiDftMc/hr+I22YGh5yCipWq3pZjfM7mP8bljemHy6oIbj+
 eg+gEXv7pWzzQ+8GV3PpuOBYxkjLRkI0gemShPjl4DIrRF1i5QKtbirG+j8HJShkbA0MUFQYF4w
 etoSvEkZ5OowXog4ZxpFFJrtp949gwoLonQntZS2YEdepjeuQ6O5+29aDjXTwrqt8dr3iq97QY7
 PEegM9HW0HVvWmt7PoJ0dx0EEaKZJ0GqMpr9O8W2GdxDoZXl+Sk9BxKiwyOX4J5Jz7rdQAn/o7I
 Ns4QUk/VtBQL/1irI528G9H+z0gGxw4nCxP8fANN7VQW2Y68d+e7tNZOgJEXmtgQe6lh2ihna3W
 AJSXMdazYky84+h1aAgVPom/cLGQhgzwHgZSps6nDG9qMSTLZGGAP5VPvHpjCAt1MsLtajskJ9m
 Pzp1qdozYbecunkANckh7aN32FTvRvmPFrVjU4a/bjB1bsG9O6ocEd2lvY5VLJoI/7EpNjFQENT
 gzqd9ygy3xIcDV9ifvMhU0XWWUteFUjC96g3UGsi04IcPbR5Oe4Fe0S0UiiqqUxgncTyddsTlmF
 IyJ5BW5Xc76J0oYVAhS14CIxQNY+9LXWUbBAgmqx4XEDE427j+I0Ic4eKf2seStQEq8rQZ1xQbi
 o4SPKFvgFZN6Jyg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On 2026-07-20 16:07:47-07:00, David Matlack wrote:
> On Mon, Jul 20, 2026 at 3:44 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> 
> > On 2026-07-20 14:54:51-07:00, David Matlack wrote:
> >
> > Thanks for the explanation. As I understand, the most straightforward
> > way to avoid holding the permanent reference is indeed to delete
> > dev->liveupdate.incoming entirely and perform an xarray lookup on every
> > access, like this:
> >
> > bool pci_liveupdate_is_incoming(struct pci_dev *dev)
> > {
> >         ...
> >         incoming = pci_liveupdate_flb_get_incoming();
> >         ...
> >         dev_ser = xa_load(&incoming->xa, key);
> >         ...
> >         pci_liveupdate_flb_put_incoming();
> >         return dev_ser && dev_ser->refcount > 0;
> > }
> >
> > However, as you note, this is inefficient because it affects every
> > single device and adds lookup overhead to every access (not sure about
> > the actual cost though, xarray access is pretty fast!).
> >
> > We can, however, still avoid tinkering with the lifecycle of the FLB,
> > and instead treat dev->liveupdate.incoming as a "hint" that we validate
> > on access with a fast, liveness check:
> 
> Can you tell me more about your concern about FLB lifetime?
> 
> The lifetime of the FLB will not be affected by this reference unless
> there is a bug in the driver where it fails to call
> pci_liveupdate_finish() during it's file handler finish callback.

From a design perspective, liveupdate_flb_get/put_incoming() is a 
logical read-lock/unlock pair on the FLB data. We use a refcount for 
optimization and sharing, but holding a get over a long asynchronous gap 
(from boot-time device setup to driver probe) is essentially holding an 
unbound lock.

Unbound locks make it difficult to trace refcount leaks or debug 
lifecycle issues.

> 
> > 1. At Setup: In pci_liveupdate_setup_device(), we do the xarray lookup
> > once, cache the pointer in dev->liveupdate.incoming, and immediately
> > call pci_liveupdate_flb_put_incoming(). We do not hold a permanent
> > reference.
> >
> > 2. On Access: When an accessor runs, instead of doing a full xarray
> > lookup, it just validates the cached pointer's liveness by temporarily
> > securing the FLB:
> >
> > static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
> > {
> >         struct pci_flb_incoming *incoming;
> >
> >         incoming = pci_liveupdate_flb_get_incoming();
> >         if (!incoming)
> >                 return NULL;
> >
> >         if (dev->liveupdate.incoming)
> >                 return incoming;
> >
> >         pci_liveupdate_flb_put_incoming();
> >         return NULL;
> > }
> >
> > * If get_incoming() returns NULL (the FLB has already finished/freed),
> >   the hint is invalid and the device is no longer incoming.
> 
> This avoids the xarray lookup but still requires taking the incoming
> FLB mutex twice (once for get and once for put) on every access. And
> if there's no incoming PCI FLB, the LUO will iterate over all incoming
> FLBs under the mutex to find it.

Can we do a fast-path check first?

static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
{
	struct pci_flb_incoming *incoming;

	/* Fast-path to avoid unnecessary FLB querying */
	if (!dev->liveupdate.incoming)
		return NULL;

	incoming = pci_liveupdate_flb_get_incoming();
	if (!incoming)
		return NULL;

	/* Check again, now that FLB is acquired */
	if (dev->liveupdate.incoming)
		return incoming;

	pci_liveupdate_flb_put_incoming();
	return NULL;
}

This seems to gives us the best of both worlds: robust refcount hygiene 
and a sane fast path.

What do you think?

