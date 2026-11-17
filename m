Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925388;
	b=p2Y7RoWHlpxXlX3WBbG7vqCAeD0MAlaQpV0DbWDP2pqOq8eFEIYxze03cy8wLCa2DgfP
	 6qvxAHsWu+cXsxSYmiJ95re5T4mfy/OUEAODY8KF0m9SWkzljduU2DkenOSU9hfjT4yOO
	 rlVZ2CzQlJMpnDQOKwQlbFke7oSa+hf1LOUUEqZC6RF1fSJ2ydWwZz2MVEy7zc7+vZNCd
	 H4rE69IfK5bamB1emhfZHZ5JnUnmyCR3STdHCWM3VwhAzuQQmwas/hYg3S4WI/RU3H29l
	 Rh35jJC8bPqRKhmcaxDgXiynlhETEeP9QIQmVL0QUfsBEc6BPe6Jd/s2pehf4K8oqJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1v3XDaIPsn+JJltQ44/B7GYW4pMWHo/jyhLjp2tXhpU=;
	b=XgBSune5qx+FqD7jV34CtdJ0OLWiBigTvEJIRXGTDTggFzFrQFb/g7kB39lRYf3KheSA
	 ZjQvefTaKkYEP52p6ThV7Q+sbw0jlWyOw4XGsi8vMvXWNmAysooH4rn5Leh7uY5uzIFhb
	 Yhonoys0YlQz2ETn7rk8rBSTjhtKRVlX/csYLktwPHysOmgIArf2Fbg4ddfv9YHNDnwYm
	 hWhWfeldVdCMDVxDaU9nFENuOAu9GlJG7E2WgrDDPHzwkU9AMeF0ghs1K0qFaABSnHTiP
	 NSr41QwWINfwMJmsDFREkTr5Qq3/ZPc7Gq87sw/gosiRKUc3Ohkai+hQlp9oO4WUw6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ms4TEX+3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F0606A334;
	Tue, 17 Nov 2026 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ms4TEX+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E9B1F000C8;
	Tue, 17 Nov 2026 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794925388;
	bh=1v3XDaIPsn+JJltQ44/B7GYW4pMWHo/jyhLjp2tXhpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ms4TEX+35GlVZDWxtFrKHXCEGtiwtf31X5SUg8Rgxfe9VPX1jDQW0/Og//0X0wDmk
	 I9MBNEYvG3eyERN88hZmPsTUdvizD6YaKHRnRh7ce3+vpkmakqbx2/k1M3K8WPtlAM
	 d55iB8zUE+ZCUuKf409Cqx9uTzXVD3rBgWL9o9jOCKYNH1qZ/qpDDYdJj8vzeVUGfN
	 8rjbHYLe1Ak0daACyU18m/Cqw+KrkKBXBwPxXxcFQfKm5jRz6fmZ5nHp5wqFQaVNF5
	 ZNohBWGVtYRBmBA1kLVGKZhNDZPJTdLoDa4ocqQt5LtsXYH1lLrakqxKTEFzfSRGG5
	 vTlyhXL4TjQ+A==
Message-ID: <sashiko-outbox-218957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 5/5] rust: Add `OwnableIntoShared` and
 `OwnableTryFromShared`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Christian Brauner" <brauner@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan
 Kara" <jack@suse.cz>, "Igor Korotin" <igor.korotin@linux.dev>, "Viresh
 Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Michal Wilczynski" <m.wilczynski@samsung.com>, "Ira
 Weiny" <iweiny@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>, "Johan
 Hovold" <johan@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "Markus Probst" <markus.probst@posteo.de>
Cc: "Philipp Stanner" <phasta@kernel.org>, linux-mm@kvack.org, linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, "Oliver
 Mangold" <oliver.mangold@pm.me>, media-ci@linuxtv.org
In-Reply-To: <20261116-unique-ref-v22-5-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
 <20261116-unique-ref-v22-5-12029383206d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:23:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rust: separate use blocks instead of single vertical import
  block
--

commit eb9ded53e4184ea08932194e99ba6dc1bce8d3eb
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add `OwnableIntoShared` and `OwnableTryFromShared`

This commit introduces the OwnableIntoShared and OwnableTryFromShared
traits to support converting between Owned<T> and ARef<T>.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index bfc52bc7f6451..5b71d264477ef 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
> @@ -14,6 +14,10 @@
>      pin::Pin,
>      ptr::NonNull, //
>  };
> +use kernel::{
> +    sync::aref::ARef,
> +    types::RefCounted, //
> +};
> =20
>  use kernel::types::ForeignOwnable;

[ ... ]

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 6bc58aae38ed9..8a029d124fa31 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -23,6 +23,10 @@
>      ops::Deref,
>      ptr::NonNull, //
>  };
> +use kernel::types::{
> +    OwnableIntoShared,
> +    Owned, //
> +};
> =20
>  use crate::{
>      prelude::*,

[Severity: Low]
This isn't a bug, but both files add a separate use block instead of
merging the new imports into the existing kernel/crate vertical import
blocks (grouping ForeignOwnable with RefCounted in owned.rs, and
OwnableIntoShared and Owned under crate::types in aref.rs).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-unique-ref=
-v22-0-12029383206d@kernel.org?part=3D5
