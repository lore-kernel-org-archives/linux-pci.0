Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5B3A63F1;
	Tue, 24 Feb 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948459; cv=none; b=NN5AB6NLl8y9oB5O+yy2k433lIaPYcAGGalQsybUM/Rqrwp/t9vn8YTQdlM3CbQB50nZzX04FD1OVx4wJPZWi3V8n3FvB/ZRsSeCD7wcsl87ozXfWjBBu2DNDbQLV5ptVZRATPk5mXGQzmy/Lk8XzosR9C9o/Vor8Pj0uVIZ4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948459; c=relaxed/simple;
	bh=Udque7qFhbJQNTo354i/fLu2ZbGrFtgGZcB9KkMEpkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqGd1CNDivdmdIoQy+Lqy1Ny4Eg6W7x3c6yypeLAkk/J8Gc51fXuwi0sEwqgeFlL3UeF0nOV9BQBxkI9XkoRI9ExVqQPk18cAQ3Awc2s6TPSrjTgxlm8k+O4cPiG9n9KSyFR6dLWj4gAlH802kQ9tcYGcqZqmPBqIeBxUUNJNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5DFEC20326E8;
	Tue, 24 Feb 2026 16:54:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 288FD30008; Tue, 24 Feb 2026 16:54:15 +0100 (CET)
Date: Tue, 24 Feb 2026 16:54:15 +0100
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
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aZ3Jp-8ZjYwgfq0Z@wunner.de>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
 <aZ2yqpdf8cBGG4Gs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ2yqpdf8cBGG4Gs@nvidia.com>

On Tue, Feb 24, 2026 at 10:16:10AM -0400, Jason Gunthorpe wrote:
> This is why I'm insistent the starting point for resmue is a very
> strong same-device check that prevents attackers from replacing the
> device with something that wouldn't pass remote verification.
> 
> If you don't do this and instead try to revalidate the certificate
> chains the kernel can be tricked into accepting a different device on
> resume and that will completely destroy the entire security model.

Finding a different device on resume is par for the course for hotplug.

> As Dan and I keep saying you should focus on enabling userspace
> verifier as the very first modest step and then come with proposals to
> add additional things like resume and perhaps a kernel-internal
> verifier.

There is nothing to "add".  Seamless re-verification on resume and
error recovery is already implemented in my patches.  I don't see
the point of throwing that out the window and start from scratch
just because you think it doesn't have priority.

> I don't see a role for a cma keyring outside a kernel-internel
> verifier

That sounds like we have minimal consensus.

I'm coming from a very different direction, I want this to seamlessly
integrate with all the infrastructure we already have in the PCI core
(hotplug, suspend/resume, error recovery, ...), so I made sure it does.

I don't share the view that CMA is merely a building block for TDISP.
It's useful on its own.

I also believe that the vast majority of users will simply need this
to ensure the devices they attach to their chromebooks, phones etc
are authentic (seems important given the reports of counterfeit
hard drives).  A .cma keyring is good enough for Grandma's chromebook,
no need for a user space verifier.

Thanks,

Lukas
