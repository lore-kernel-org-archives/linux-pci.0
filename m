Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCC3093B8
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604663; cv=none; b=c/nVkNeevFKfeiEjZnO+KsiK0m3T0X1tzbOAB6CSztIcMqtrM0Tx37x256bdBhQDWQyqfSBFt41ZQbtH+bomE7djGE41NXrX/7oAV/s7mVxWTIRcsEdxLwNdC6EZVbTzfw6LBfdDaiDZD4Svybi53I/+016gqc2NzY+rbZjR9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604663; c=relaxed/simple;
	bh=dEOoxXB0r1h7tUxH+wMjt938pkIeivRUlRMUFQF0O+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GfkrztnVZzVBzd98rezlWRnhdaBTaj8Q8eM/7rXjdAoA1LntRcM1zQN3dTjQXzyG8OZRbnsDPYiuxPtLcrOn2bVWRfa0LY9OYsHJvpeY4lc3izmd8gk7gfBjF50kyz1TIZl8nXYmWznHn7yC5EQmVB0K0ZzDoAJwEno5IWf+6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6BoWS1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6BoWS1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340981F00893;
	Thu,  4 Jun 2026 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604661;
	bh=QfSrwsy4h63k8R1NgFs9hzn4oHFV07X8TtyVzxw2KTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X6BoWS1o4mT0r190+r2uWTZ/95EYf6GAnWsVhrdixre1zk0nMpH9UV3/8ARQIdWOB
	 U3O866K33wrzPwY/ADRrxFGzWCthkf/p03IlgMQ1f7tlbqGx7nrV/uGu+2/rFYyLgd
	 yF+AvCvE871mX3P29HSlLOFbfN8GMhdwIN69HI/RMwAeoS5zAW0kcwws9EU81w5Tpn
	 zrXr0QRUVfxIAmGzAfeQxCkOFbFTvPdS3JF56/JXNDcnP8GoR9OYPFmusACXAfUgN/
	 d7uGnoHUMKZ1slaRS1QzctDwMlquB6v5SdSj0LE6P11Ys1FhjH6Q5A1PObt4MTgrAn
	 xces+0+SStjEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/10] rust: rename `AlwaysRefCounted` to
 `RefCounted`.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604-unique-ref-v17-6-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-6-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:24:20 +0000
Message-Id: <20260604202421.340981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch misses updating `rust/kernel/pwm.rs` for the `AlwaysRefCo=
unted` trait split, resulting in a compilation failure.
- [Low] Lingering `AlwaysRefCounted` trait bounds in `aref.rs` and `workque=
ue.rs` artificially restrict `ARef<T>` functionality for types that only im=
plement `RefCounted`.
--

commit 821007fa381542ee45e7b6c5b8f66ecf2e17afcd
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: rename AlwaysRefCounted to RefCounted.

This commit splits the AlwaysRefCounted trait into RefCounted (which holds
inc_ref and dec_ref) and an empty marker trait AlwaysRefCounted. It updates
various implementers across the kernel to use the new traits.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 4ee5fac0e0b67..2d656f672b97c 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -40,9 +38,8 @@
>  /// at least until matching decrements are performed.
>  ///
>  /// Implementers must also ensure that all instances are reference-count=
ed. (Otherwise they
> -/// won't be able to honour the requirement that [`AlwaysRefCounted::inc=
_ref`] keep the object
> -/// alive.)
> -pub unsafe trait AlwaysRefCounted {
> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`]=
 keep the object alive.)
> +pub unsafe trait RefCounted {

[Severity: Low]
Does rust/kernel/pwm.rs need to be updated for this trait split? It appears
Chip<T> still implements AlwaysRefCounted and attempts to define inc_ref and
dec_ref within that block, which are no longer part of the trait and will c=
ause
a compilation failure:

unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
    #[inline]
    fn inc_ref(&self) {

[ ... ]

> @@ -70,7 +83,7 @@ pub unsafe trait AlwaysRefCounted {
>  ///
>  /// The pointer stored in `ptr` is non-null and valid for the lifetime o=
f the [`ARef`] instance. In
>  /// particular, the [`ARef`] instance owns an increment on the underlyin=
g object's reference count.
> -pub struct ARef<T: AlwaysRefCounted> {
> +pub struct ARef<T: RefCounted> {
>      ptr: NonNull<T>,
>      _p: PhantomData<T>,
>  }

[Severity: Low]
Since ARef now only requires T: RefCounted, should we also relax the trait
bounds for ARef in rust/kernel/sync/aref.rs for PartialEq and Eq? They still
explicitly bind T: AlwaysRefCounted, which prevents equality checks on ARef
wrappers of types that are only RefCounted:

impl<T: AlwaysRefCounted + PartialEq<U>, U: AlwaysRefCounted> PartialEq<ARe=
f<U>> for ARef<T> {

Similarly, should the trait bounds in rust/kernel/workqueue.rs for
WorkItemPointer, RawWorkItem, and RawDelayedWorkItem be relaxed? They curre=
ntly
enforce the old bound, which prevents workqueue scheduling via ARef for typ=
es
that are only RefCounted:

unsafe impl<T, ID> WorkItemPointer<ID> for ARef<T>
where
    T: AlwaysRefCounted,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D6
