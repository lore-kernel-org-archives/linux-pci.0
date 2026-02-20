Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400E10E3;
	Fri, 20 Feb 2026 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573592; cv=none; b=ulfR6BK0s4W2PEG0hpMfEqcqPoHJy3wtqFgYloAOoJBZJfA/dVKehgGUfj+9vrZQrnxiQU5OCISeXloK44A/p+lvdIFqR3m5zwpPS2X3vDsCDTPtjGD6TtpDcWDmay+XCFV8cGSMt+VdZWfBYOM35KfE/PAb3Lbf7pbvLZhEnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573592; c=relaxed/simple;
	bh=Y/IzQgTpxBPwLOZhMZysRqOP8ON7ix3R7tzcKwR77wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgG/cdYBvcC3xluyb3mfuOTVdoCOLuN4+pcvTtsx/PSr4kwpFqhiUzcCnbb4DKbSSb+waeWevxolCp8POQpXT+uFx5kkpTbpr80FqwOhnEr8HhHfaMwFZJiOFH2GoJl+///edklf5K+6cprLZ0RuQ/gRipiEPfv5EWOb7UxS+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 86EB42030031;
	Fri, 20 Feb 2026 08:46:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4C896FECD; Fri, 20 Feb 2026 08:46:21 +0100 (CET)
Date: Fri, 20 Feb 2026 08:46:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, dan.j.williams@intel.com,
	Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com,
	a.hindborg@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com,
	aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aZgRTT0woruvH-AM@wunner.de>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <2026021944-material-hardhat-c508@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026021944-material-hardhat-c508@gregkh>

On Thu, Feb 19, 2026 at 03:40:25PM +0100, Greg KH wrote:
> On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> >   # What's the certificate chain in slot0?
> >   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > 
> >   # Fingerprint of root cert in slot0, does it match what vendor claims?
> >   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > 
> >   # Looks good, let's trust it:
> >   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> 
> As much fun as it is to abuse sysfs, please, let's not do this there.
> You just did something that could have changed the device between
> storing, checking and then trusting it as the device is never guaranteed
> to remain the same across multiple calls to sysfs (i.e. yanked out and
> another added.)

No, the kernel caches the certificate chains read from the SPDM slots
and what is exposed in sysfs is that cached copy.  So all three commands
above pertain to the same certificate chain.

> So let's not design in a security issue from the start please :)

The alleged security issue does not exist.

Thanks,

Lukas
