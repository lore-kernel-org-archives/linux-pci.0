Received: from sender4-pp-e106.zoho.com (sender4-pp-e106.zoho.com [136.143.188.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEF285404;
	Wed,  4 Feb 2026 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217262; cv=pass; b=R4N8ibu1A9NHTmVVhO3NAD5MyKARl58sz30kJQpm948D1rRsaqBgH3p69V0WYvEuSFZ52ZX/AoHqLcE+BoatG42CT2967gxEiy7NszLixV0y9v8pf+4S7N/kjUpZoHqLrMwwNHdYBVLqSJwhY3ZaLvrCct5jHALGzrramUn2TGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217262; c=relaxed/simple;
	bh=SuL6GDe9u99Pic+D6yF6G+7xbdRs0e7NhtkVcVixgZg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RcjQrQIC9BwAcSSjT8aTpOtZ6gIQOAcXYAZp82vZnYRWkZ/IKI2VIVC22Fd0Q4nYXD9+FnsnWpMA53B8BM8bgMbBc37Fgrah4csYfcYEPXSlHbHBfTEIN4NoJ6E0nIdWqBzDuCOLu/KFyKtIAYKJ3r1MT8I3xFY+qlJ4M+imrCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AE3xhG4J; arc=pass smtp.client-ip=136.143.188.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AE3xhG4J"
ARC-Seal: i=1; a=rsa-sha256; t=1770217234; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lpBz/qTbF8vKosrFDbiN75V13G0IO6+hQX38EiKODMjmKjBNXKTPIOHS0iAAy8fz9k7pRYU1lY0MtpdPPc8X/b+SdcoiIRFRAuDDKOHpFyn4YCfoK297Vy5WC4vJXCsdVxlhjyDQX8HSGj1v5CtFuaJX5mlMizslX3hupOSjUgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770217234; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pweZ7QgQzfYiYd/GcOGqcHQ4SaTbilLC6NRVhQTWwJA=; 
	b=GukGS8YRFCSt4M8Grf1ZIqmjO8cv9KIfAPAUpqQo8dt5U3TPfCdAb57x8uoXqVs4J4SxF2e7jXFPPDil/O3on9txC5kVXTQmLrvfHiWwMn6QAG11sO7ZKEXSKcNq/gYlum8yFp7CIBaL5dd0nM51h76dz/LuFqLBtaXcqHnS66U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770217234;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=pweZ7QgQzfYiYd/GcOGqcHQ4SaTbilLC6NRVhQTWwJA=;
	b=AE3xhG4JfU6AjG6KT4GReBxtIiBQJA7gMn/1p+yrWKeF3VQKNVUt1ugsY6c/DJsX
	K7og0dFQwAaw/19LgwHXX1YAHoqgH2IpE3RQaApYGTv++NjcupTl5K+W/uk7Qr8ykBj
	IYPt6kB5Bo35MGkb9+mKXJuOG71bGU6ZxvzszagM=
Received: by mx.zohomail.com with SMTPS id 1770217233327908.9116052510911;
	Wed, 4 Feb 2026 07:00:33 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/6] rust: io: mem: use non-relaxed I/O ops in examples
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260202-io-v1-2-9bb2177d23be@nvidia.com>
Date: Wed, 4 Feb 2026 12:00:17 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Zhi Wang <zhiw@nvidia.com>,
 Lyude Paul <lyude@redhat.com>,
 Eliot Courtney <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B50EAE3F-A424-4DC9-A2B0-7D9A8529B496@collabora.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-2-9bb2177d23be@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 2 Feb 2026, at 05:13, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> The `_relaxed` I/O variant methods are about to be replaced by a =
wrapper
> type exposing this access pattern with the regular methods of the `Io`
> trait. Thus replace the examples to use the regular I/O methods.
>=20
> Since these are examples, we want them to use the most standard ops
> anyway, and the relaxed variants were but an addition that was
> MMIO-specific.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> rust/kernel/io/mem.rs | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 620022cff401..7dc78d547f7a 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
> @@ -54,6 +54,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, =
resource: &'a Resource) -> S
>     /// use kernel::{
>     ///     bindings,
>     ///     device::Core,
> +    ///     io::Io,
>     ///     of,
>     ///     platform,
>     /// };
> @@ -78,9 +79,9 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, =
resource: &'a Resource) -> S
>     ///       let io =3D iomem.access(pdev.as_ref())?;
>     ///
>     ///       // Read and write a 32-bit value at `offset`.
> -    ///       let data =3D io.read32_relaxed(offset);
> +    ///       let data =3D io.read32(offset);
>     ///
> -    ///       io.write32_relaxed(data, offset);
> +    ///       io.write32(data, offset);
>     ///
>     ///       # Ok(SampleDriver)
>     ///     }
> @@ -117,6 +118,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
>     /// use kernel::{
>     ///     bindings,
>     ///     device::Core,
> +    ///     io::Io,
>     ///     of,
>     ///     platform,
>     /// };
> @@ -141,9 +143,9 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
>     ///
>     ///       let io =3D iomem.access(pdev.as_ref())?;
>     ///
> -    ///       let data =3D io.try_read32_relaxed(offset)?;
> +    ///       let data =3D io.try_read32(offset)?;
>     ///
> -    ///       io.try_write32_relaxed(data, offset)?;
> +    ///       io.try_write32(data, offset)?;
>     ///
>     ///       # Ok(SampleDriver)
>     ///     }
>=20
> --=20
> 2.52.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

