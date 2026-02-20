Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0A30DD2F;
	Fri, 20 Feb 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576254; cv=none; b=sLHPKBuzs+c4FZX6ElbsJbWb166XE0Z76phX6XDwR6o5kl2veYQxmed1Aqw83DMt8ck3oigL9xSqLYFRgxhv82u09WljxA9N+ZngkuIl7Nj0tEDz0TNyhHgF+USYJx/0SGT8Zqbb0UfdyAIlyfAFlMdyJqgjxmRramFbd/HH1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576254; c=relaxed/simple;
	bh=azPTQTXySqvoSZocYG4Vg7nNQrEVUFnUuPlpxVGKDxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfrfBny5BJ9tTTWpTuM7cLWOOcqLS4JMPDJ18Ij0uKbA/ON/5sFUoC9G4ctWKyiUi/vciz2//FfuJS9UAe7rVQFhP4jadMnOss6ntQvXw3Xy+mEqX8GzivC+hX4yrdnV6uBWTMQ7IhDagdvUf4RkJSIzjoB52yrmhWf25XC18Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7E5D2203005E;
	Fri, 20 Feb 2026 09:30:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4B08F4BC74; Fri, 20 Feb 2026 09:30:50 +0100 (CET)
Date: Fri, 20 Feb 2026 09:30:50 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: dan.j.williams@intel.com, Alistair Francis <alistair23@gmail.com>,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aZgbukYiIxg44_e7@wunner.de>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219173937.GH723117@nvidia.com>

On Thu, Feb 19, 2026 at 01:39:37PM -0400, Jason Gunthorpe wrote:
> I'm arguing there are two very different steps here that must be kept
> separate. Verification is done when the device is first seen and the
> kernel is told it is OK to use the device.
> 
> A same-device check is performed if an already verified and accepted
> device resumes or RAS's in some way.
[...]
> Hence no keyring should be involved in resume.

No, that doesn't work.  You cannot rely on information that the device
presents.  The information may be spoofed.  The only secure way to
ascertain that the device you're talking to is what it purports to be
is to ask it for a signature and verify that the signature was made
with a device certificate which is signed by a root certificate
that you trust.  And the way to trust that root certificate is to
add it to a keyring.

There is no way around that.  What you have in mind could be achieved
by generating a secret token after first authentication and then using
that secret token after RAS / resume for re-authentication.  But I just
looked through the SPDM spec and it doesn't support that kind of thing.

A userspace verifier is incompatible with authentication after RAS
and resume.  It's a technical limitation that you'll have to live with,
I'm sorry.  If you could come up with, say, an eBPF verifier that
user space loads into the kernel, that might be a workable solution.

> I don't have an objection to an optional, useful for embedded, kernel
> side verifier that uses the cma ring.

Good.  My patches merely aim to be a spec-compliant implementation of
PCIe r7.0 sec 6.31 (Component Measurement and Authentication/SPDM).

That spec section does not talk about user space verifiers.

Moreover PCIe r6.1 page 115 states "CMA requires SPDM Version 1.0 or
above", so the baseline that we need to support for spec compliance
is the oldest spec version with the least features.  So even if a
future spec version introduced a feature to establish a shared secret
on first authentication and use that for subsequent authentication,
we'd still be constrained by the SPDM 1.0 feature set for compliance
with older devices.

> > > >   # What's the certificate chain in slot0?
> > > >   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > > 
> > > >   # Fingerprint of root cert in slot0, does it match what vendor claims?
> > > >   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > > 
> > > >   # Looks good, let's trust it:
> > > >   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> 
> This is also not a very realistic scenario, there is no point to copy
> a certificate from a device into the cma key ring. If you want to
> trust the device as is without any verification then just accept it as
> is with a trivial userspace "verifier".

No, in the above example the device is not trusted "as is without any
verification".  The verification that happens above is a manual
comparison of the fingerprint with one provided by the vendor.

Thanks,

Lukas
