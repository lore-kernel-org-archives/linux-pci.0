Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C831E492D;
	Tue,  7 Jul 2026 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449689; cv=pass; b=Z5TgJARRGzy1rwo6wdkv/Oz4xhpcN3LuJ6DuhyHPJGfBxta9vndLDtNHB2f2ov184LmXnoJYOZJMSvKBX7hLGIfB/qJxmwd2vgmid5s6PBOcnP4aJWB/XJn/UXgKsxevINfjvjaOu2UnEku+OS9hFz5VzWgqVJAiT/DEZmqnMHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449689; c=relaxed/simple;
	bh=xTdEZPpx+cPYau6P/oapdph062qqJWYr/H3uSN27G/Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CjZ6aoI7B+wOJ8uZtcGq+GdXYZifRyeUaObS/zRtXNPn5j0+1Y9op9gqO/H9TUAkDRwj006YB8XqqbH+5/aqLi/7R/HGXS+K8821fX5lfqTOc3XxwPr3nuhb3yereEf++3Ov4s6JONb0WEJCdFFc8wzn6pAQv690w99jGHTQVoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=M9oei2BL; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="M9oei2BL"
ARC-Seal: i=1; a=rsa-sha256; t=1783449658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cdp4bG/XEl8J+bSYrJEMFweg2cZt6HBV2/55PeAKnvuxERQYQtMBdtS/kZH9HDq3nDad8j1/vAGViubPGZWnlQOBfueZLaGr1Z0oeXU5DnE+g3r2Jrbp+lcm7zdPuJ791tuc8M2p8+0P16J+7tZ9SRZm862eWg6INjk80hLwpiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783449658; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EDwlnOs4YCj2t7wvoltJ8iZPFDsHdK8fCnqAW/cA7WU=; 
	b=cc8yUUsX/6Q4GKfSl6KX1RsrLQv2wthHwFoD/i65KU0YuAPSNoV+3e2Loach0y6TZUKh4OjZwyBzUHqlbsvAbzACpyBMnoktqaieJwCBL0RXYCsaZYSlUbhper3toYuJ/zsjdj4scXuaSrQRfDUBNoH9AqVnFYoHgndZGeyeyxM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783449658;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=EDwlnOs4YCj2t7wvoltJ8iZPFDsHdK8fCnqAW/cA7WU=;
	b=M9oei2BLcjSRlwwu9LV2XG59pBQwPM1FvrsBjc4V+DCYAVZh+22SCt6I4FXxVpYH
	m3jYja78NKSBtMrqu8CaIjPr0T1h1mafD5fc3kQwvY/CmXpjyAmBEgPyfG19FUSDpFA
	Y8Bzm7lW5xBIav5I4ilNBOwr863p1D2CayxmLgv4=
Received: by mx.zohomail.com with SMTPS id 1783449656904757.8597891704945;
	Tue, 7 Jul 2026 11:40:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
Date: Tue, 7 Jul 2026 15:40:36 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <20770F1B-133E-42B1-A204-BF3CB70758BA@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> The current safety comment on `io_read`/`io_write` does not cover the =
topic
> about alignment. Add it so it can be relied on by implementor of
> `IoCapable`.
>=20
> Expand the check performed by `Io` by taking `self.addr()` into
> consideration when checking if `offset` is aligned. For the =
compile-time
> `io_addr_assert` check, check using the known minimum alignment of
> `Io::Target` and the accessed type.
>=20
> While at it, fix the alignment check to use `align_of` instead of
> `size_of`. The values match for all primitives (including u64, given =
that
> we do not provide u64 accessor on 32-bit platforms), but are not
> necessarily true for custom types.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d1c5f0121994..d821ee48ed31 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -195,13 +195,14 @@ pub fn maxsize(&self) -> usize {
> #[repr(transparent)]
> pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
>=20
> -/// Checks whether an access of type `U` at the given `offset`
> +/// Checks whether an access of type `U` at the given `base` and the =
given `offset`
> /// is valid within this region.
> +///
> +/// The `base` is used for alignment checking only. This can be set =
to 0 to skip the check.
> #[inline]
> -const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> -    let type_size =3D core::mem::size_of::<U>();
> -    if let Some(end) =3D offset.checked_add(type_size) {
> -        end <=3D size && offset % type_size =3D=3D 0
> +const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> =
bool {
> +    if let Some(end) =3D offset.checked_add(size_of::<U>()) {
> +        end <=3D size && (base.wrapping_add(offset) % align_of::<U>() =
=3D=3D 0)
>     } else {
>         false
>     }
> @@ -220,14 +221,16 @@ pub trait IoCapable<T> {
>     ///
>     /// # Safety
>     ///
> -    /// The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - `address` must be aligned.
>     unsafe fn io_read(&self, address: usize) -> T;
>=20
>     /// Performs an I/O write of `value` at `address`.
>     ///
>     /// # Safety
>     ///
> -    /// The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - `address` must be aligned.
>     unsafe fn io_write(&self, value: T, address: usize);
> }
>=20
> @@ -309,7 +312,11 @@ pub trait Io {
>     // Always inline to optimize out error path of `build_assert`.
>     #[inline(always)]
>     fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(offset_valid::<U>(offset, =
Self::Target::MIN_SIZE));
> +        // We cannot check alignment with `offset_valid` using =
`self.addr()`. So set 0 for it and
> +        // ensure alignment by checking that the alignment of `U` is =
smaller or equal to the
> +        // alignment of `Self::Target`.
> +        const_assert!(Alignment::of::<U>().as_usize() <=3D =
Self::Target::MIN_ALIGN.as_usize());
> +        build_assert!(offset_valid::<U>(0, offset, =
Self::Target::MIN_SIZE));
>=20
>         self.addr() + offset
>     }
> @@ -318,7 +325,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> =
usize {
>     /// performing runtime bound checks.
>     #[inline]
>     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> -        if !offset_valid::<U>(offset, self.maxsize()) {
> +        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
>             return Err(EINVAL);
>         }
>=20
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

