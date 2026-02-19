Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290DB38FA3;
	Thu, 19 Feb 2026 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496392; cv=none; b=G/IEyXchVlfNQdQ8eL426UwPgJoo2Wcni4I3kT4JFjAscnlwDHI14HhaVwDgWQ/7vucIkYqfz6k8AngxQR93i4PAntnThdAe4LGDLv8uTKEh5VOU9HqFmzCFcRgOMPMHD2XyhdTlJ+aBJ2CTCFApX7JwsEQD1WYnFjmXtVwxCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496392; c=relaxed/simple;
	bh=v7nRuBhs/efhlLKH96QuC8e1U8C49z270WZ13oY6b9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd5bsKHWX94JQ6GxxLuV5HP23T9RZ3POSQgc8sMh2uRuE7eB0xU24HYByLzAKqmBksiTM3GagBCLN9CJwaqk+D9ju1M6PmjqjwFUrBYQLB7QD4CHIfeBzSCQvoXvmMWQZSarRzujGW6herqNwgJFzXpEs9NMlZOGwSEetwi6G04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 078222021BE5;
	Thu, 19 Feb 2026 11:19:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E87F54BBEE; Thu, 19 Feb 2026 11:19:47 +0100 (CET)
Date: Thu, 19 Feb 2026 11:19:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: alistair23@gmail.com
Cc: bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 27/27] rspdm: Multicast received signatures via netlink
Message-ID: <aZbjw48-tcYkH4vK@wunner.de>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-28-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211032935.2705841-28-alistair.francis@wdc.com>

On Wed, Feb 11, 2026 at 01:29:34PM +1000, alistair23@gmail.com wrote:
> This is based on Lukas's patch from [1]. This exposes all of the SPDM
> information to userspace via netlink. This includes the certificate
> chain and communication transcript.
> 
> 1: https://github.com/l1k/linux/commit/fe90b5700ee9bc595a21c030192eac4060eaeae1

Just a heads-up, the above-linked commit is from Dec 11, but I spent
the calm days around Christmas and New Year testing and improving the
SPDM netlink code.  I ended up squashing quite a few bugs and refactoring
things for clarity.  Latest version is on my development branch:

https://github.com/l1k/linux/commits/doe

The branch contains a separate commit introducing a nla_put_blob()
helper to add a zero-copy blob attribute to an skb.  And the SPDM
netlink code uses that helper instead of open coding its contents.

The SPDM netlink code can be tested with:

tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/spdm.yaml \
     --subscribe sig  --sleep 10

Just reauthenticate the device and the signature with ancillary
data gets dumped via netlink.

The commit message and kernel-doc of the SPDM netlink commit is
still a WIP because right after the calm of the holidays I got
swamped (again) with AER work that my employeer prioritizes.
But the code is now well-tested.

Thanks,

Lukas
