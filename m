Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D6342510;
	Thu, 19 Feb 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513682; cv=none; b=fKVz0qZ4UDcVrdTAQHmqr6QJYdo++N0foxsFClvC+CfYgxnwYfckUFglsS87nDdH+Rp5cEQqzQPpEGpv/b1htJMCTkGzQHvHdojvBkbu2HVYXOcbeQwzqsZls0PpDyTuskzu+fWLZEc0vxIX3NVtyNul4/foJWEvHqqU2uoGT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513682; c=relaxed/simple;
	bh=93+6V8DKCHYMnLeoscUUhe7yyQijSpQ7ZW1uT/5nhIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCgOqs/NTYWJDkIIS2B2bVDyfHo9SLPl4KR6Xq/xCe5om+C+k03Qag/IYCDiXOXsfbtyX21J8+BHdjGg+Qz8E2fjm9Kxw1Bxq/SFQ2dVZYSbu+RaqLCu2z9WmTAbKaBuxoK/74e1feMyfdBIlb2S/5QGCYzU1s89kWvfaOrl1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BA5342042A0A;
	Thu, 19 Feb 2026 16:07:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B50594B763; Thu, 19 Feb 2026 16:07:58 +0100 (CET)
Date: Thu, 19 Feb 2026 16:07:58 +0100
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
Message-ID: <aZcnTnYJ61Kma0yd@wunner.de>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219143129.GF723117@nvidia.com>

On Thu, Feb 19, 2026 at 10:31:29AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> > The way this works in my series (and I presume Alistair's) is that
> > trusted root certificates for devices need to be added to the .cma
> > keyring.
> > 
> > This can be done from user space using keyctl(1) or some other utility
> > that can talk to the kernel's existing keyctl ABI.
> 
> I really don't like this from a verification perspective. We don't
> want the kernel checking signatures, that is the verifier's job.

On resume from system sleep, the device is put into D0 already in the
->resume_noirq() phase and drivers are free to access it already at
that point.  However a verifier in user space cannot be queried
at that point because user space is still frozen.

Likewise after recovery from DPC or AER, the device has been reset
and needs to be reauthenticated, yet user space may be unavailable
because the device that has been reset may contain the root partition
or may be the NIC that you need to query your remote attestation service.

There is no way around some form of in-kernel device authentication
to accommodate such use cases.

> And a general keyring based proeprty is not at all the same as 'this
> device must present exactly the same certification and attesation
> after resume'

Well please be constructive and propose something better.

> > authentication.  These are existing, well-established roots of trust
> > in the kernel that CMA simply inherits.  I think it is reasonable
> > to base auto-acceptance on these existing mechanisms.  No need to
> > reinvent the wheel.
> 
> It depends what you are building. We've been focused on external
> verification so this is not at all desirable.

No problem at all.  The kernel will merely use the .cma keyring for
its own notion of an authenticated device.

However if there is no trusted root cert in the .cma keyring,
the kernel will still multicast the signature received from the
device via netlink, so your user space tool can ask the remote
attestation service and if it responds affirmatively, you trust
the device.

So you can either use the .cma keyring for in-kernel authentication
or you can use your user space utility.

But you can't rely on user space if you want seamless re-authentication
after a system sleep transition or error recovery.

We can discuss a way for user space to force the kernel into
considering a device authenticated.  E.g. writing "force" to
the "authenticated" attribute may tell the kernel that it's
a trustworthy device irrespective of the .cma keyring.
So you'd perform remote attestation and if successful,
tell the kernel to consider the device trusted.

> >   # What's the certificate chain in slot0?
> >   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > 
> >   # Fingerprint of root cert in slot0, does it match what vendor claims?
> >   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > 
> >   # Looks good, let's trust it:
> >   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> 
> That's exactly the baroque I'm talking about, no server admin is going
> to want to grapple with that..

I used to be an admin for 2 decades and my experience is that
openssl usage has just become muscle memory, but YMMV. :)

Thanks,

Lukas
