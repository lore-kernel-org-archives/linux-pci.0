Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B43911D3;
	Wed, 16 Sep 2026 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524718; cv=none; b=o5FUeQ3I9q6D+3trQ/68dVXdVL0hA7gGfN6KuFa0h7R1dVXBuFf1sNX4IIC0lUDitzRK+COXPUr/GPEkUIoqJXwhZT9c++4Vf0+68Vzv4+BmVkq+/ccXUdLrQ4POM87K5/TVwYNfVhGrGBrbc5Ucjj/LyeX1Z3LB8Hkch/+ovRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524718; c=relaxed/simple;
	bh=uCFZKGnELsOuvKNM600f2yPtF1shycAz4L+aSeqUdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VodVjX9kkZvbk9zEvr8abdtEXC4zni+ZSH0vs4/Oiv9izM1Qt5Xckl56icCvBQb/A8FmiUqUr4bWr5cBJ8eIcDjkTtC7U+mdLLJdmHvFBoIw7sewTt77ZrOxD/mNlW2AlShV6xmr9OaBiH8PjO/zaC04F/ZCFYA+78S49oKAqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb277c0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb277c0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5541C1F000FF;
	Wed, 16 Sep 2026 02:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789524708;
	bh=b8d91GfrJN1CxUWhvlzjJ0CoRKKZjGBuQt69kTjAMbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bb277c0z/yYkw8DIHFxcHZIccTEbZvLVNASBQXE0g+2SlBQK2N3WgvJmdORw86M3W
	 8pz6Pdd7uWMN7UWryfhY2Mc7w3PxQI8250YC2jkdGCRkIBqde6cKOSIOmhagDyVvfp
	 OzEAZZxKf/xkrVaU39rELJtZMjF/Ila9UE+7vCpe66ajDS9mkE7yKi3aIgH0R4k0A5
	 jFJ2L6DKpSeQHh0HazC7pAJyNH6iPpIp/d6MpOyfs49Uq2J2rcTQNs0iwFbDVO6ZMa
	 E0Gmpy3RliiDifpteDeuIqCXB66umIkxItWwzgaA97OpAFaMyna6G6vUOqYeaIOdJl
	 9OolQ95jUyMIA==
Date: Wed, 16 Sep 2026 03:11:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alistair <alistair@alistair23.me>
Cc: alistair23@gmail.com, linux-pci@vger.kernel.org,
 Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, linux-cxl@vger.kernel.org,
 bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 10/21] PCI/TSM: Rename pf0 to host
Message-ID: <20260916031143.4fe2ae49@jic23-hlaptop>
In-Reply-To: <f9b1c0410e622f7ac1e6feacaa3eae98951bcd79.camel@alistair23.me>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-11-alistair.francis@wdc.com>
	<20260909000158.78ffa790@jic23-huawei>
	<f9b1c0410e622f7ac1e6feacaa3eae98951bcd79.camel@alistair23.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2026 15:00:59 +1000
Alistair <alistair@alistair23.me> wrote:

> On Wed, 2026-09-09 at 00:01 +0100, Jonathan Cameron wrote:
> > On Tue,=C2=A0 1 Sep 2026 11:03:36 +1000
> > alistair23@gmail.com=C2=A0wrote:
> >  =20
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >=20
> > > Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and
> > > function
> > > names from pf0 to host) as part of converting pci_tsm_host
> > > to be any device that knows how to speak any of CMA, IDE, or
> > > TDISP. =20
> >=20
> > I'm not against the change, but I would like at least one example of
> > 'what' other type of device you plan to use this for.
> >=20
> > vf or something else? =20
>=20
> It's based on the reply here: https://lkml.org/lkml/2026/6/18/1741
>=20
> I don't know PCIe that well, so honestly I'm not sure.

Yeah, that's about both VFs and other physical functions.
Those can exist on both real EPs and RCiEPs.

>=20
> My use case is a root complex integrated endpoint

Any more info to share on that? Why isn't it attested etc as
part of the host given it's integrated? Or is SPDM a path to
something other than simple attestation here?  Fine to do it this
way, just seems like overkill so I'm curious what the application
is.

Jonathan

