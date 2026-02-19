Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094B1AA1F4;
	Thu, 19 Feb 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510539; cv=none; b=mzPX5VbfzMs6gAQq5IlOZhgpTiAVEv7Cp4N+c6nJ26/AXDWKSLSRlDxiKK1v225wKdReov1dj2wbkrWI2l7pn4fUlqMSyPEqnGNGgh7cnHdPStTJSsDS66aYCUVeg3ANwJPMlSbLzbJ89l8LxIUrn7D4dhf3SQsidgNG2t+aSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510539; c=relaxed/simple;
	bh=YgJ3m1ERZod0UHaaHi4tbBT0nLInatR5Medvj0ySv3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VyzSeaqeQe1ZapKgrDNOdSgM3FQK0vkKibDVz0Ghsd3DzJ6jHmx9oRjVfzJOD59v78ldC7QF70EFSRHfsKFKFWvgvpH9htEHC/CqBpaJuqb2VYIYM0UceLitaoCG7Hbc+Ob0VMt4OkW/dUM736j6uL+wWUWeI87Aql6emswA4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id E18E920202F9;
	Thu, 19 Feb 2026 15:15:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C702126687; Thu, 19 Feb 2026 15:15:34 +0100 (CET)
Date: Thu, 19 Feb 2026 15:15:34 +0100
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
Message-ID: <aZcbBt7OmNeH3oA0@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>

On Thu, Feb 19, 2026 at 08:41:19AM -0400, Jason Gunthorpe wrote:
> Kernel auto acceptance is not desirable for the same reasons it is not
> desirable in a TVM.
> 
> If we do some automatic re-accept for RAS/resume it should be strongly
> tied to some target pre-set by the userspace acceptance process - ie
> "the device must present exactly this specific cert chain and nothing
> else", and probably more too since we may want to exclude swapping out
> device FW versions or similar.

The way this works in my series (and I presume Alistair's) is that
trusted root certificates for devices need to be added to the .cma
keyring.

This can be done from user space using keyctl(1) or some other utility
that can talk to the kernel's existing keyctl ABI.

It is also possible to link the .builtin_trusted_keys or .platform
keyrings into the .cma keyring and thereby declare anything trusted
that is used for UEFI Secure Boot.  Likewise blacklisted certificates
added to the .blacklisted keyring are rejected for SPDM device
authentication.  These are existing, well-established roots of trust
in the kernel that CMA simply inherits.  I think it is reasonable
to base auto-acceptance on these existing mechanisms.  No need to
reinvent the wheel.

If you want to trust exactly one specific End Entity certificate,
you could provision an SPDM slot with that certificate, add it to
the .cma keyring and clean out all the other 7 SPDM certificate slots
on the device.

> > It has turned out to be super convenient to expose the 8 slots with
> > certificate chains in sysfs for direct examination with openssl and
> > similar tools, without having to go through netlink.
> 
> Honestly, I'm reluctant to add permanent sysfs uAPI just for temporary
> debugging. Put it in debugfs.

Exposure of the certificates in the SPDM slots is not for debugging,
it's just super convenient for day-to-day use.

> Having to find/remember some baroque openssl command line with a
> million options is not reasonable for a production kind of
> environment.

Personally I find something like the following neither baroque nor
unreasonable:

  # What's the certificate chain in slot0?
  openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0

  # Fingerprint of root cert in slot0, does it match what vendor claims?
  openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0

  # Looks good, let's trust it:
  keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0

> There should be a tool suite that runs on top of this stuff and
> presents a sensible user experiance, with man pages and so on.

Device authentication is currently trickling down from server to
client to embedded/edge devices and you don't want to require users
to install a tool suite on space-constrained embedded devices where
busybox + openssl is otherwise enough, doubly so with skyrocketing
eMMC prices.

Thanks,

Lukas
