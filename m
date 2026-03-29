Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CB292B54
	for <linux-pci@vger.kernel.org>; Sun, 29 Mar 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813753; cv=none; b=Mu7V2azpjOwgnu5jGYoZfOSKd93jFIfQpubiNLFp+MQJKt5SmL0n2cINr91b7z6yMsTjsfAvXSDzFBn29qM0w+0Ctll52SYS8fkYq9joagykLn6ae096dYY8UKyY/FiiAPOaUvGcP/UYQR+f61wcpE2J8zY84HFT3+nlwYx8X8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813753; c=relaxed/simple;
	bh=0KEYkGLqpe9dKH8hCwqvNDucOCURnBBEIofXJEGbIM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+yfgNAjWyNk63UP+gBrRECPbKYWvtzCxH3T1m6Po9TncLKxWvaZs3DMGBO1Rv4pPyWUz7xZyzgPVzZYKpDbGM9LgHzfLOMXH5DSAjyhaKGEDAkz5HQcyK0WV0GuUIVAlmHjXvbz9yjHTjFCBS5ronAf+7/Xc7naaUpyExJ7vuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=XyXH4wLj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="XyXH4wLj"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50bc115f206so9523211cf.3
        for <linux-pci@vger.kernel.org>; Sun, 29 Mar 2026 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1774813749; x=1775418549; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0KEYkGLqpe9dKH8hCwqvNDucOCURnBBEIofXJEGbIM4=;
        b=XyXH4wLjaB4o5tHzRS/NXLQ3OCXTzgKHSA5GAxdjwi3gGJZ3SyDzb/pfYKvvUl7hDI
         hJ6nntb/GRMEpcbj0YS+7AlFo2get+GPDa/LeTAs2HWu8A2iC/0yvhcam5kRxUWxK5qJ
         J0/tig0Lsnu5Xl29R4Ii0WaRwktqZmQu2cI/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774813749; x=1775418549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KEYkGLqpe9dKH8hCwqvNDucOCURnBBEIofXJEGbIM4=;
        b=fiWUT08ahNa6MHyDqXvbwvZJk5bnBbgcInh7mej65Z6JajCI8mhqg2pziBMJaHnSWP
         HnDwWI8EvasbYe4WI/OB5gHJqPomkIch3/aYz937P5lp63cD1gPFI0+VX86G4HWZH+fA
         f7vcNHdA+3HaVpYtuHCFgDLu1JHvBlCmoLbW9lV0zjUv1a6tGc+Sa4oXMVgcGiFibSoA
         2AqrmNxboDzNbxwTgqhDLPc67DAfl6oX/iie9BeKR1joKIhejgedpmg5zSmnSs5L7vJh
         ipRBgQfiMmEFATD4xDkgLPzBzQ2xhtjVU5irgnLHjXEZUrG+QJwpw7N7qfPCkEL8iy20
         06TA==
X-Gm-Message-State: AOJu0Yx+8lX927pHAhkCoRkNRfCcqpbtSpfb1GcPacGCkL9rJyXFWIZs
	X0JHDvw06rqYyV8nNege4mF2T308EwACrpvcCvjX4PgLB2rTTxIieXDCT7phdx60s0dvwJtXW0v
	w9fxy2A==
X-Gm-Gg: ATEYQzyTgRL6KTlBVhjzgMwGY0SkD/uCX89RAfCYvrWr4rqOAkavN5FruhORW7u3KFg
	vYP5tAp9SJYq3kHzP25XEtFcI5OwJ1QhV+yR2n45GHWsUtJkjl8SrnIvUah3KV0GWpB2ysuevta
	sHtd7lO0l4T4UsRRX1ANi987bvJob4tkoADRWVAJBQSaDvm4cdPm/CGpm62hkpNkSVQmGgalmWA
	dUoFsKGVI2p2cnaT/V1SChhknUbnnAKN/fhGJbxWbcsleFtxLMiON6ilCzHz/q1MAg/0qrT0GR3
	+YGYjA7DQ+gnlV52Lp0nk+j7kK8EQ361JXDX4vQvA6ZRjkHT6j5WlPjBfLYquLrMwDEsc/c4xcC
	5qN685kJpjBm+BGp8AVBGUBARTCEEtebYcycfEw0WwwPZiJBIYC7U5mE95nCvHiNgGD3HHH93xZ
	mhGzTPBWpTytUrQsAEiTQexRY=
X-Received: by 2002:a05:622a:4a19:b0:50b:4226:924f with SMTP id d75a77b69052e-50ba37f01e8mr135548781cf.2.1774813748964;
        Sun, 29 Mar 2026 12:49:08 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2dd640dsm53198311cf.19.2026.03.29.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 12:49:08 -0700 (PDT)
Message-ID: <ca6bc981ef3ed980f9301489ebfa3904df9cdaf3.camel@ieee.org>
Subject: Re: ReBAR over Thunderbolt
From: Cristian Cocos <cristi@ieee.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Date: Sun, 29 Mar 2026 15:49:07 -0400
In-Reply-To: <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
	 <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Correction to my previous email: the laptop computer used ("host") in
the Thunderbolt ReBAR hotplug experiment is not Framework Laptop 16
(AMD Ryzen 7 7840HS), but LG Gram (Intel Core i7-1360P). Apologies.

On Fri, 2026-03-27 at 12:15 +0200, Ilpo J=C3=A4rvinen wrote:
> On Thu, 26 Mar 2026, Cristian Cocos wrote:
>=20
> > [This has been previously posted on the linux-hotplug list, though
> > it
> > has been suggested that I post it here as well.]
> >=20
> > The short story is that ReBAR does not work in eGPU hotplug(!)
> > scenarios: hotplugged Thunderbolt eGPUs are forced onto a 256MB BAR
> > regardless of the system's ReBAR capabilities, and this because
> > during
> > hotplug the Linux kernel does not consult the ReBAR capability. As
> > eGPUs are becoming more and more popular, accommodating eGPU
> > hotplug
> > scenarios has become imperative.
> >=20
> > The longer story:
> >=20
> > The current Thunderbolt eGPU *hotplug* sequence of events is this:
> > BAR
> > 2's hardware register powers up at 256 MB =E2=80=94 the default size
> > programmed
> > into the BAR's address decoder by Intel at the factory. The PCIe
> > Resizable BAR capability advertises support for up to 16 GB, but
> > it's
> > passive =E2=80=94 software must explicitly exercise it. When a Thunderb=
olt
> > eGPU
> > is hotplugged at runtime, the kernel's PCI subsystem enumerates the
> > new
> > device, reads the BAR at its 256 MB default, sizes the bridge
> > windows
> > to match, and assigns addresses =E2=80=94 all before any driver loads. =
The
> > ReBAR capability is never consulted(!) during this process.
>=20
> Hi,
>=20
> The intel GPU drivers do attempt to perform the resize at probe time,
> though it's often not successful.
>=20
> You haven't indicated what kernel you run nor provided any logs, but
> there=20
> have been some improvements to this in general in the recent kernels.
> And=20
> then there's also this patch which relates to thunderbolt cases
> (which was=20
> only accepted yesterday):
>=20
> https://lore.kernel.org/linux-pci/20260219153951.68869-1-
> ilpo.jarvinen@linux.intel.com
>=20
> > A workaround is available for cold-plug scenarios only, and is
> > achieved by means of the **thunderbolt.host_reset=3D0** kernel
> > parameter:
> > this preserves the BIOS's PCIe tunnel and BAR assignments from POST
> > (where the BIOS *does* exercise ReBAR). This delivers the full 16
> > GB
> > BAR but, as just mentioned, only works for cold-plug(!) scenarios =E2=
=80=94
> > if
> > the eGPU is power-cycled at runtime, the new tunnel gets the 256 MB
> > default.
> >=20
> > The proper fix would be for the kernel's PCI hotplug resource
> > assignment to *first* check for ReBAR capability during
> > enumeration,
> > resize the BAR to the largest supported size that fits within
> > available
> > bridge headroom, and *then* commit bridge windows and assign
> > addresses.
>=20
> That's being worked on. But it's not as easy as you depict it as
> kernel=20
> needs to be also able to fallback to some intermediate size if the
> largest=20
> supported size fails.
>=20
> Thanks to how size calculations and assignment are done at different=20
> phases of the algorithm, it's not as easy to fallback to something
> else as=20
> you indicate as the secondary failures would still persist from the=20
> attempt with the largest window. So effectively, the entire sizing
> has to=20
> be recalculated.
>=20
> > This is essentially what the BIOS does during POST. It hasn't been
> > implemented yet because eGPU-over-Thunderbolt-with-ReBAR is (was?)
> > a
> > niche use case.
> >=20
> > Seeing as eGPU-over-Thunderbolt is poised to become mainstream,
> > this
> > can no longer be considered a niche use case.
>=20
> We don't consider it unimportant usecase. It's just the resource
> fitting=20
> and assignment algorithm is very complex and hard to improve, because
> something usually breaks when trying to improve it. Thus, the
> progress is=20
> slow and everything has to be done carefully (when things break badly
> in=20
> this area, system doesn't even come up so there's not much room for=20
> error).
