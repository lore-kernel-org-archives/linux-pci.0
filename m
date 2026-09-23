Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44C43A7FF;
	Wed, 23 Sep 2026 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149823; cv=none; b=Rjs3cCVvadJeFhINoMjbzKZmACLQwZEp9Of2I57hU6eWtz/jUl6orxBhNGNJrNkck437oeQBVSC7Xf+3/ikWBPbnl46+kt/UVSKzPKif/MnjGlGd3TAq6jOkTxOImFjaJ/te7lFF6ZfoYGPlT32mkvkl/DWEJjjXEJpkk5p3F0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149823; c=relaxed/simple;
	bh=73aspgkTVNcPYa3eu0SJOyNhgnW7Dtu6BxRuoksHiKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD++XkEk+OzREoCDeawnRGqw1gbLqw3llsjJUgkhkDUKskhR4m+8NhwY2RX8qvt7xWy9wMfvc0VIiM52VHrdK8S7TY1DYQqivqRxE2HI2JpTdifx4tyaVv8XNceJ2UohqVhIJMm3VnaJs3vU9Eq07COKEThVc3JYZ8NsoATJxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2SGr/TM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2SGr/TM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7359B1F000FF;
	Wed, 23 Sep 2026 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149822;
	bh=uFucDySwDoTtrmbjyEHVN57TqjeOGc9HP0V6crfp0tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q2SGr/TM15sstdBGhI5/umNxg6Gsqg7nhTBmA9O0pSGQeuPQsPPiTK9h0+QnTan8G
	 KXE3+SeMZe7K6GGbO/z68I1CUP7mdLVy2s0puUsi7Sr2M5xreZxiDqIL+hgZ07v2Jl
	 N/hA5Hz6oRkdCNBNMGIz2Z/Lfc/c/BdI45jQyXaVHZfv7iX7sqrIQw0GhJj987d0OU
	 aSg7wBeoMWRCOa1drwSBb9JiEXzna8u6BlNfwJlvdDemdzeFfqiWnxqRKwlByEfiUb
	 J/nQXLcgITk5LoTWTnjVg3yAS9u/RBkxpttjUo3rlefStEIbe3XUSQE++u9RHx+8rr
	 GzA+knYD18pNg==
Date: Wed, 23 Sep 2026 08:50:15 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Ira Weiny <iweiny@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: To Lee, Pavel: Re: [PATCH v25 0/4] rust: leds: add led classdev
 abstractions
Message-ID: <20260923075015.GE3438784@google.com>
References: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
 <0b51e27e1b2e16ac5bf5776c7c1704ca90857ec5.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b51e27e1b2e16ac5bf5776c7c1704ca90857ec5.camel@posteo.de>

On Tue, 22 Sep 2026, Markus Probst wrote:

> @Lee, @Pavel:
> 
> Hi,
> 
> This message has already been posted once [1] and no reply has been
> sent. So I added your names to the subject line, so this message will
> hopefully make a difference.
> 
> --- The contents of the original message:
> 
> Regarding the leds rust abstraction patch series.
> 
> Lee already mentioned he will take Rust patches into his tree if
> "quality Rust-specific Reviewed-by" trailers are present [2].
> Will this also apply for any subsequent patches (e.g. bug fixes)?

I'd be happy to either take them in or let you set-up your own
maintainer tree.

> Secondly, there hasn't been a comment on me taking the maintainer role
> for the Rust abstraction yet. If thats fine with you, I kindly ask you
> to ACK the patch adding the MAINTAINERS file entry [3].

Fine by me.

> I was told there have been cases in the past of maintainers leaving the
> kernel directly after code has been merged. To take away any fears that
> might exist, I can assure you I will take care of the Rust code.
> 
> If there is a patch with breaking API changes on the C side, simply add
> me to Cc and I will fix the Rust side.
> 
> The missing ACK on the patch adding the MAINTAINERS file entry [3] and
> the missing Reviewed-By Rust trailers should be the only blockers of
> this patch series.

Those are quite large blockers, but yes.

> Thanks
> - Markus Probst
> 
> [1]
> https://lore.kernel.org/rust-for-linux/6c57e08a5f4aa9096711d14d82ece19fb68c893f.camel@posteo.de/
> 
> [2]
> https://lore.kernel.org/linux-leds/20251110134058.GC1949330@google.com/
> 
> [3]
> https://lore.kernel.org/linux-leds/20260903-rust_leds-v24-4-8d9e4c04db69@posteo.de/



-- 
Lee Jones
