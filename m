Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF856383981
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329937; cv=none; b=M1nneBitCLcJ41WijqeQpMbyzw33hYwsTL5xx2vJ7uvlsXbKhVWVplTMjGpz7H1ZvMnfbEmOi+Uf9qNNnMpp2l1QrKUazIDjT/Pf+vc3sqDeHMfz+FoxTVj/Bm7Zy9ZVRJAtFWssmXSCossjqlFpOuBbQNAmJjSWpqt4AmRMzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329937; c=relaxed/simple;
	bh=/i3F8aVlRB09Jw0j8WKE0aoMUU83ZBv8ZxgBmJ4bEUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIg7cm22RNZXR7cZYFx40oZbHiiePqUWj/URuk5Q0+k5h8LhP+JoGZ806UYIjDcYfyzjEKQaqHZnJZ1dx1O0PCUvXWK+L2AdXwqEUMA6ARV52mzaSzH3gqivbNBmIBJ/lIp9fZ8/UM+12FFLJuxBV7ZT0di/r/k8Ie2ByZWvk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsooBkNM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsooBkNM"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso9379065e9.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782329934; x=1782934734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JvYdpn4YzE4MVNRAOjv5r8auqSp+Gt6NQ8Tln1OeLY=;
        b=gsooBkNMWS6LIhYN7RKhBboYGy16S0qKS18gkeqlAE3xlB2ANvgI9C9OCJ3cOsKSU5
         ggUbYVm29e5HRjm42hrUu3jZHq7ZiHcBt7wJ2XvLhtnguqrDa6OL2UNCEZ8IJXqY/VHj
         /0WJ5B+yPkKwehdWqrGdJenKAeOM1XhhuTGmgFre3JwTFjc4AP1A+nBh3e326DjjxePH
         Z8LafAy8tym9LjL5R47xHj0D1T1muEsVmyW64o8BEttl9Aza3sLCJfnxNg4kLgKCkPAV
         S49c6s1UWrIJsXvdN/GxFB9LvvnzKmaJE2UgaJVyOCqbSxKVOG75dfUa34o2HqDOmiX7
         dZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782329934; x=1782934734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JvYdpn4YzE4MVNRAOjv5r8auqSp+Gt6NQ8Tln1OeLY=;
        b=AgjbHeLbD7WsebRBr7VJQFL8YOnQW4KOuiec4X1yeTA5V3EyhV1/twbc5AEFTbDwJw
         sl8DjnjxaoSHuX/fu1N1n38rNRpHa3zIEAB25LHvi+FGREJ2+ao14kb57XAuEzz7PjOe
         qYqnOslrXw9I6YkOSl55BNzn03dEPZIP2madBHcYvvavTTdf/sY0UhkWGntDI5GrHmyh
         xQjKp/lF7wpXDcOPIxuP/bBzjLmIWoytOhdrC2K0YrRkx+MnX3uBTKFND+IarcuEtVKZ
         9gkSaOO+T0lUNOn1TE9G6bEm6tKoZDrgPnDcNrwR3eJ/SF0ANIUldnoQA5j1zUXeevZA
         Sp+A==
X-Forwarded-Encrypted: i=1; AFNElJ8c2fhxeeWboPuiR06Z+Y0/lGrdHmWRkxEaIJNpS/mPnMvrocEwFektUjzbbseIVhfZCligkUAWGWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Wwolo4K4T0rEgrNBnjmISSJ1skUav3KZxD9ZGEI9o2qBwhkl
	UE/ldN83ZM3iEgifHZHN4dY3WDDI7BMkiO1UZIHWms1JwzsfJcc9FkBV
X-Gm-Gg: AfdE7cljOozYaTFUS3nSqcFWPWkkaGOvQL8eihZwzumIwrUtwDtFIiBRWVSsXGCJ64D
	gZ2jJgSEvtfprxP4gSbxbWmedHYG/Py8cbjQjBiW1R1i97FXqv4H91EFlOgKLwKH7eK6uq1zXpZ
	bO03RXNOV22QIXV2xByTilO3Pj/A6TXPqdVZvas4z/OGUwFX89mG2N0UfwMTfVkoJv1i8CgmaFz
	RmsWRjlAPMmO7FJJLg7cw8sskafkevVWEYiII3tBRBMCtguPJtdfh7+Rseq6F7I3JxomPwQmApj
	p/Mburc5WnQxkNJ/7eIaWUvBp5Yz+CZG0w5t/mA7HRoP3SMTRo4+spJu+ZFFnPFAXsUtHLDAhM/
	B1LPpw0GIc7RagFgh3SIC2MJlrCFOZbCVySTHyyQb+++bI50cs4OvUSfIO+x6NXjhDAkyZGG3YO
	9qVZBu+TdBSnlq9vP5IvSBsl4SJ1E9i1eXZ0wmrZIdluJaHAAwfQ==
X-Received: by 2002:a05:600c:4ecb:b0:492:433a:53af with SMTP id 5b1f17b1804b1-49260858030mr72253305e9.16.1782329934022;
        Wed, 24 Jun 2026 12:38:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926494f129sm5853685e9.0.2026.06.24.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:38:53 -0700 (PDT)
Date: Wed, 24 Jun 2026 20:38:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <dakr@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <joelagnelf@nvidia.com>, <apopple@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] PCI/IOV: Return u16 from
 pci_sriov_get_totalvfs()
Message-ID: <20260624203851.7f6c7be4@pumpkin>
In-Reply-To: <DJHDAQZ1AASK.14ATT70HTI450@nvidia.com>
References: <20260622194353.1308872-1-zhiw@nvidia.com>
	<20260622194353.1308872-2-zhiw@nvidia.com>
	<DJHAC9W05615.19MHKPF67OG2T@nvidia.com>
	<20260624143937.50499c29@pumpkin>
	<DJHDAQZ1AASK.14ATT70HTI450@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 23:59:56 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Wed Jun 24, 2026 at 10:39 PM JST, David Laight wrote:
> > On Wed, 24 Jun 2026 21:40:52 +0900
> > "Alexandre Courbot" <acourbot@nvidia.com> wrote:
> >  
> >> On Tue Jun 23, 2026 at 4:43 AM JST, Zhi Wang wrote:  
> >> > pci_sriov_get_totalvfs() reports a VF count, not an errno-style
> >> > status. It returns 0 when SR-IOV is unavailable or the device is not a
> >> > PF, and otherwise returns the PF's driver_max_VFs value.
> >> >
> >> > driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
> >> > from the SR-IOV TotalVFs field or from a driver-provided limit, so the
> >> > implementation cannot return a negative value.
> >> >
> >> > Change the declaration, CONFIG_PCI_IOV stub, and implementation to
> >> > return u16. Update callers to store the result in u16 variables, remove
> >> > obsolete negative-value checks, and use unsigned format specifiers where
> >> > needed.
> >> >
> >> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> > Cc: linux-pci@vger.kernel.org
> >> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>    
> >> 
> >> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> >> Link: https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.com/
> >>   
> >> > ---
> >> >  drivers/crypto/hisilicon/qm.c                   | 8 +++++---
> >> >  drivers/crypto/intel/qat/qat_common/adf_sriov.c | 6 +++---
> >> >  drivers/gpu/drm/xe/xe_sriov_pf.c                | 6 ++----
> >> >  drivers/misc/genwqe/card_base.c                 | 6 ++----
> >> >  drivers/net/ethernet/cavium/thunder/nic_main.c  | 2 +-
> >> >  drivers/net/ethernet/emulex/benet/be_main.c     | 3 ++-
> >> >  drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 ++-
> >> >  drivers/net/ethernet/sfc/ef10_sriov.c           | 2 +-    
> >> 
> >> I believe that you can avoid converting all these drivers in this patch.
> >> The implicit `u16 -> int` conversion done by C should result in the
> >> expected behavior, and it will be fewer Acked-by to collect.  
> >
> > The generated code is also likely to be slightly better if the function
> > return value is a 32bit value.
> >
> > Similarly you don't really want to do any kind of maths on local variables
> > that aren't 32bit (or 64bit on 64bit builds).
> >
> > The fact that the domain of a value fits in 16 bits doesn't mean that
> > it is better to use u16 - it is usually worse.
> > Pretty much the only place u16 should be used is to reduce the size
> > of structures.
> >
> > So it is probably correct to change the return type to unsigned int and
> > remove the error return checks, but nothing else.  
> 
> For C, I agree that unsigned int is the safest type.
> 
> Rust otoh does not do implicit integer promotion, and making it return a
> `u16` carries useful range information. I wonder if we could have a
> private `__pci_sriov_get_totalvfs` that returns a `u16`, make
> `pci_sriov_get_totalvfs` promote it to an `unsigned int` and return it,
> while the Rust bindings would invoke `__pci_sriov_get_totalvfs` so they
> can expose a `u16`?

That is getting silly, something will end up doing the masking to police
the 16bit value - it isn't just the C rules, the ABI pass/return u16 in
in 32bit registers (even on x86) so one side (or both) has to mask the
value.

Your rust code has the same problem. Add 1 to a u16 variable and code has
to be added to mask the result to 16 bits.
You won't see it on x86 because it has 16bit alu operations, about the
only other cpu eoth them is m68k (I'm not sure about s390 - it is based
on a very old instructions set).

	David
