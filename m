Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E533A9ED;
	Thu, 19 Feb 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771492437; cv=none; b=rjDjtdHL5ieDsmllRIGj3DXJ9nCFE2vqxBBnGR+xTTqWE81yTTRIwpLMuy5PWeWRRpqSH3Ls8x0VJSs3QWq8ZC+bFC4OzmlERLriQbHKUBv+p4IDilGTbbkXEzdO39DnoqdDlprX6nmJLJXjNlXgbpG0htH/l73Jz0kE/bXSzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771492437; c=relaxed/simple;
	bh=gh8WIMy4GOJKBZ0m6I6h9UqYVLePX6Dtn1gEFMYmy+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDpF/Jwn2YZvF9tuYnbz8I7Im5OMTL28qx59n5Hv9x7v7K3JB+mbMSYAUsas3CH0C9MpSR4ZQsUSAUG/CU8GLxXYB7H4s8qmzVRAlamukER0PkEBW32HSMTtggAahrUx5TITdS9GdjuEyaFnjugxORkJKqBW6tDE7WnNp0KOILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5CFBF2021BF3;
	Thu, 19 Feb 2026 10:13:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 38B094AAE6; Thu, 19 Feb 2026 10:13:47 +0100 (CET)
Date: Thu, 19 Feb 2026 10:13:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: dan.j.williams@intel.com
Cc: Alistair Francis <alistair23@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com,
	a.hindborg@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com,
	aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aZbUS31_lsLr72Uq@wunner.de>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>

On Wed, Feb 18, 2026 at 03:40:10PM -0800, dan.j.williams@intel.com wrote:
> However, I notice that Aneesh needs x509 certificate parsing for his TSM
> driver [1], I think TDX would benefit from the same to offload needing
> to specify the wall-clock time to the module [2] for cert verification,
> and SEV-TIO (already upstream) is currently missing any facility for the
> host to attest the device.
> 
> [1]: http://lore.kernel.org/20250728135216.48084-17-aneesh.kumar@kernel.org

There's a newer version:

https://lore.kernel.org/all/20251027095602.1154418-1-aneesh.kumar@kernel.org/

This would allow upstreaming at least the three X.509 patches at the
beginning of my CMA series (and Alistair's rSPDM series) and thus
reduce the patch count a little bit.

However I don't know how far along Aneesh's CCA work is.

Note that David Howells' introduction of ML-DSA in v7.0 moves around
a lot of the X.509 code so the three X.509 patches for CMA will no longer
apply cleanly:

https://lore.kernel.org/all/2977832.1770384806@warthog.procyon.org.uk/

I'll rebase my development branch after v7.0-rc1 is out and Aneesh can
then pick up the latest version from it:

https://github.com/l1k/linux/commits/doe

Thanks,

Lukas
