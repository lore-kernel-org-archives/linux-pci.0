Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B203F0776;
	Tue, 28 Apr 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373619; cv=none; b=Tp5I9MUcxz3FEvd2VcP46UHxi2vcg5rqEwsRZIiSTYSjpQf2w4xrQoGLXobLSdwrHSkBn717X1p33BcVp2H+++DC7+W9pzypGB9C1Yb0QAzZJM5vmA9QWvQRhQd72Y6azErf0iXjHL4r+V3fG1hcxlIvCgKVhw5mXY+45pqyd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373619; c=relaxed/simple;
	bh=nli8iL0UDuKMNz0EFiwRnRD7S6+egKizQtirZgiozV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uvg11XvmobGkok9gnKlATAsthLJGS67xIBkvO3IqmdKsXMAXVBhjPPJvTqqYd5BClnMs+TkQGIyl7x1+ECBXP5+Nr7Garr9Qcf9wxQO1iKcaevLNsgr9yDEQ3y5wcm2p4tEIQmLeNMN8A13jKMfsp1PepXGh28H5SplucBAlLcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS9hRR2M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS9hRR2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3101C2BCAF;
	Tue, 28 Apr 2026 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373619;
	bh=nli8iL0UDuKMNz0EFiwRnRD7S6+egKizQtirZgiozV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oS9hRR2MY804BzfIchS3H290u1GhLRVebtOaPvj2AoKEK9SsiZK1hBt3R06g85rZa
	 kPHNtylqx4TcVZhKJmpPpF0BloBFJ/Nyq9wsA//5dTcuEm+S9xIBxMdB8buhH28TCs
	 /5ntXci365UEi5tFG7yOyLihiTmUIrJfj5/CUNdHMlW7LENk/CntVVjbeedCdC9Ei6
	 yJxjOsflRj64ElaTEjTGDqucPB05E4nAEt/gpP+1mWXiDfQIVaOYdVz9N9u/5GnYWJ
	 83XYZTPwiR7UoQusZc431NsSZDCuHcv7glukVjVEw2toCIsWFq4o3jh1FwgQWjwj1V
	 HuAn5MXSjHj2Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Abdiel
 Janulgue
 <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 06/11] rust: io: add view type
In-Reply-To: <20260421-io_projection-v2-6-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-6-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 12:53:18 +0200
Message-ID: <87zf2npd9d.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> The view may be created statically via I/O projection using `io_project!()`
> macro to perform compile-time checks, or created by type-casting an
> existing view type with `try_cast()` function, where the size and alignment
> checks are performed at runtime.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index a13be8c5fd2d..869071d47a13 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -7,7 +7,11 @@
>  use crate::{
>      bindings,
>      prelude::*,
> -    ptr::KnownSize, //
> +    ptr::KnownSize,
> +    transmute::{
> +        AsBytes,
> +        FromBytes, //
> +    }, //
>  };
>  
>  pub mod mem;
> @@ -297,6 +301,13 @@ pub trait Io {
>      /// Type of this I/O region. For untyped I/O regions, [`Region`] type can be used.
>      type Type: ?Sized + KnownSize;
>  
> +    /// Get a [`View`] covering the entire region.
> +    #[inline]
> +    fn as_view(&self) -> View<'_, Self, Self::Type> {
> +        // SAFETY: This is an empty projection, so it trivially satisfies the invariant.
> +        unsafe { View::new_unchecked(self, self.as_ptr()) }
> +    }
> +

Sorry, I missed your reply on v1. This is better. Should it be "identity
projection" rather than "empty projection", or is "emtpy projection" the
correct term?

However, I don't see why we cannot put:

SAFETY:
 - By existence of `&self`, `self.as_ptr()` is aligned.
 - `self.as_ptr()` has same provenance as `self.as_ptr()`.
 - `self.byte_offset_from(self.as_ptr())` is 0.

I think the verbosity is fine. It makes it easier to check the safety
preconditions when scanning the code.


Best regards,
Andreas Hindborg


