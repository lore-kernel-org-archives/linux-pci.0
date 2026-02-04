Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574C41B37C;
	Wed,  4 Feb 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218710; cv=pass; b=tAsbz9Hhgye4bp0uxKOo2pG7djOSWM2orRlJ+QFcC5GnInkGYfW+2jMPO0FyRSZIlVWBBJXZpE5CCnmLsrh1kXdEJVVWnLHvYY9+MeK5o5MFsvYvd5D2aEluoXWfJ9+EVztoiEV6is4EOoS6HSuUzuZv4Gr+CZWLKbswJIh4TMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218710; c=relaxed/simple;
	bh=RPqYTK/y2ujPnoPeUSzfPjt+gosXp2N7lUWfg4PlWj8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bOA6WTWKi2HF5IPaMN00ByPiZvirUt7Sj7RowTLPbjboGnIc4lJjLktnNmbOtoOpwbgkY4O6+2JU1CUT500W1tqpS6bMKtLIhGvY+9bYwd1EN2xuwUd8wYKqZdD4QO9RkxbRbv6+r82MMMyPBrKLC6sE2AJnQay/jMMvIzlkhWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aaohjDiu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aaohjDiu"
ARC-Seal: i=1; a=rsa-sha256; t=1770218691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UlJbbTl+XgSvU1U4ck1IeBhJo9fUj7k44Ecf6mObl6D7X+iaF+Czznz9pxgSpjtzCnc6dQ8NXRLsI02l7ZXBhusLiEzVVq9iMM03mypoDJxuMHWu5SMKRMKoV2zcCRQGvToLF9OtiS0HnEJSeCxjO6XkQDeEfXJIPLBANo6Y7V4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770218691; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B4qfH/T4q4e9+r5e5ubWLPqS87SXP+L7lfrd2Hlwlqk=; 
	b=RaKHvcyUSZFNEjcezUflsD9a1P64nfz53pvPRrNNHfCk77jVCv/y1s1BEJ57wcTH1ZwDuSGYqW4jlNXOHzls8z+s7kN9zhubUjxoxMALp49C/rd7lNoXg+oPKSUGG3KjaSYP9B6/dZIZKvJizosdyrBei+SJs0Aq1D7E1MmXRbk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770218691;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=B4qfH/T4q4e9+r5e5ubWLPqS87SXP+L7lfrd2Hlwlqk=;
	b=aaohjDiutJx0kWR++KbIBUxypK+ZHgl2MELmoTZuvtDkph1Rm0LpBXelGWRgNPNE
	1uNfSk2RjIHWnXRxYtr4PQ4ws8jxUiq3/6jC99iHY5DHJODxpVWXaP7uAfHFTARvsbk
	qXOx8dCpHWagYQgqiglwagKiPXM8rKuwR+ZvpXuM=
Received: by mx.zohomail.com with SMTPS id 1770218690792659.1519027180708;
	Wed, 4 Feb 2026 07:24:50 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 5/6] rust: pci: io: remove overloaded Io methods of
 ConfigSpace
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260202-io-v1-5-9bb2177d23be@nvidia.com>
Date: Wed, 4 Feb 2026 12:24:34 -0300
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
Message-Id: <919702DB-9992-476C-882B-94443C97C0F0@collabora.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-5-9bb2177d23be@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 2 Feb 2026, at 05:13, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> Since `ConfigSpace` now has the relevant implementations of =
`IoCapable`,
> the default methods of `Io` can be used in place of the overloaded =
ones.
> Remove them as well as the macros generating them.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> rust/kernel/io.rs     |  3 ---
> rust/kernel/pci/io.rs | 70 =
---------------------------------------------------
> 2 files changed, 73 deletions(-)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index e1094a237ff7..0e8031dfe0f0 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -226,8 +226,6 @@ macro_rules! define_read {
>         }
>     };
> }
> -pub(crate) use define_read;
> -
> macro_rules! define_write {
>     (infallible, $(#[$attr:meta])* $vis:vis $name:ident, =
$call_macro:ident($c_fn:ident) <-
>      $type_name:ty) =3D> {
> @@ -259,7 +257,6 @@ macro_rules! define_write {
>         }
>     };
> }
> -pub(crate) use define_write;
>=20
> /// Checks whether an access of type `U` at the given `offset`
> /// is valid within this region.
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 8c8aab2e3f22..ae78676c927f 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -8,8 +8,6 @@
>     device,
>     devres::Devres,
>     io::{
> -        define_read,
> -        define_write,
>         Io,
>         IoCapable,
>         IoKnownSize,
> @@ -85,63 +83,6 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind =3D =
Extended> {
>     _marker: PhantomData<S>,
> }
>=20
> -/// Internal helper macros used to invoke C PCI configuration space =
read functions.
> -///
> -/// This macro is intended to be used by higher-level PCI =
configuration space access macros
> -/// (define_read) and provides a unified expansion for infallible vs. =
fallible read semantics. It
> -/// emits a direct call into the corresponding C helper and performs =
the required cast to the Rust
> -/// return type.
> -///
> -/// # Parameters
> -///
> -/// * `$c_fn` =E2=80=93 The C function performing the PCI =
configuration space write.
> -/// * `$self` =E2=80=93 The I/O backend object.
> -/// * `$ty` =E2=80=93 The type of the value to read.
> -/// * `$addr` =E2=80=93 The PCI configuration space offset to read.
> -///
> -/// This macro does not perform any validation; all invariants must =
be upheld by the higher-level
> -/// abstraction invoking it.
> -macro_rules! call_config_read {
> -    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) =3D> =
{{
> -        let mut val: $ty =3D 0;
> -        // SAFETY: By the type invariant `$self.pdev` is a valid =
address.
> -        // CAST: The offset is cast to `i32` because the C functions =
expect a 32-bit signed offset
> -        // parameter. PCI configuration space size is at most 4096 =
bytes, so the value always fits
> -        // within `i32` without truncation or sign change.
> -        // Return value from C function is ignored in infallible =
accessors.
> -        let _ret =3D unsafe { bindings::$c_fn($self.pdev.as_raw(), =
$addr as i32, &mut val) };
> -        val
> -    }};
> -}
> -
> -/// Internal helper macros used to invoke C PCI configuration space =
write functions.
> -///
> -/// This macro is intended to be used by higher-level PCI =
configuration space access macros
> -/// (define_write) and provides a unified expansion for infallible =
vs. fallible read semantics. It
> -/// emits a direct call into the corresponding C helper and performs =
the required cast to the Rust
> -/// return type.
> -///
> -/// # Parameters
> -///
> -/// * `$c_fn` =E2=80=93 The C function performing the PCI =
configuration space write.
> -/// * `$self` =E2=80=93 The I/O backend object.
> -/// * `$ty` =E2=80=93 The type of the written value.
> -/// * `$addr` =E2=80=93 The configuration space offset to write.
> -/// * `$value` =E2=80=93 The value to write.
> -///
> -/// This macro does not perform any validation; all invariants must =
be upheld by the higher-level
> -/// abstraction invoking it.
> -macro_rules! call_config_write {
> -    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, =
$value:expr) =3D> {
> -        // SAFETY: By the type invariant `$self.pdev` is a valid =
address.
> -        // CAST: The offset is cast to `i32` because the C functions =
expect a 32-bit signed offset
> -        // parameter. PCI configuration space size is at most 4096 =
bytes, so the value always fits
> -        // within `i32` without truncation or sign change.
> -        // Return value from C function is ignored in infallible =
accessors.
> -        let _ret =3D unsafe { bindings::$c_fn($self.pdev.as_raw(), =
$addr as i32, $value) };
> -    };
> -}
> -
> /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using =
`$read_fn` and `$write_fn`.
> macro_rules! impl_config_space_io_capable {
>     ($ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> @@ -190,17 +131,6 @@ fn addr(&self) -> usize {
>     fn maxsize(&self) -> usize {
>         self.pdev.cfg_size().into_raw()
>     }
> -
> -    // PCI configuration space does not support fallible operations.
> -    // The default implementations from the Io trait are not used.
> -
> -    define_read!(infallible, read8, =
call_config_read(pci_read_config_byte) -> u8);
> -    define_read!(infallible, read16, =
call_config_read(pci_read_config_word) -> u16);
> -    define_read!(infallible, read32, =
call_config_read(pci_read_config_dword) -> u32);
> -
> -    define_write!(infallible, write8, =
call_config_write(pci_write_config_byte) <- u8);
> -    define_write!(infallible, write16, =
call_config_write(pci_write_config_word) <- u16);
> -    define_write!(infallible, write32, =
call_config_write(pci_write_config_dword) <- u32);
> }
>=20
> impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
>=20
> --=20
> 2.52.0
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
