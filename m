Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E312135B8
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383282; cv=none; b=oo3tAHsWFJBK4VXMTCIktPKlpJqCLh5jGfhrSH6FgC5qFdzhqugH10gb3u/dGl9z1XWKNxmIiZhCeKESGYfHYtEIfL81z+LWSZ6CLMMalAgV4Dmi8thgpCrrBf12Rof2g0MATpBUGHr6WK7fazMOOZ81UffUopCQcQHeEwmFOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383282; c=relaxed/simple;
	bh=alcN8BrdhmH66z+yHrXfqUwideZzeigpoJJ2iuY0+A4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SGxLEoRKyu04lg3YX2fyptwQh2/c8n3GEi+itlX4TsSZOFoqevIksn0++MzCHDiiIFC88K2Pr8VrfewJS5EAl7Csu3OlgsCzBE4xiTGjXrYiBHY+oD+hY4Hfj4mKvuHq0VRoS6aQriCSXTL2/lsptlYmHbmm/SztjzGbxgERQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4EOUmhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4EOUmhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C3B1F00A3A;
	Thu, 25 Jun 2026 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782383281;
	bh=Se1i/efxHDqMxUzl5H2oEaiBwA8yDR/7EEA+2RmhhYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D4EOUmhZTb5RkQ7lpIa46aFFZxnk9656p0i2q1Y4Z8J+id6QjtQD1SI2LGflalnIK
	 TMGmmO2LMopZmJ3TGx6YsDUw0zBH/oQ53gFW4gPHu08kG4G3UYQfWIPreV8f2vK1a2
	 xe1eN1g2MeKHu+pPvx4/yD1mMY0GZzo+0546IJU6w/HX+Wyr67U2/cjA+EtCIhbI8n
	 z29lF8MfinrciRbYVgfnjcg7a7tfNmdRSJC5GvfvnyE014eVVpKr9IOB2QhSryrQr7
	 1fCN2jdzUypVsgo6sH9kIpWa+/2SnTigusvbyMm9od6Y/cLzs7wHeQxDYT9bcUoaCp
	 sqnorWTYeUakw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 5/8] rust: rename `AlwaysRefCounted` to
 `RefCounted`.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-unique-ref-v18-5-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-5-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:28:00 +0000
Message-Id: <20260625102800.B4C3B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete Refactoring / Trait Bound Violation for workqueue ite=
ms
- [Medium] Stale and misleading documentation for `ARef` usage
--

commit 46d36a47415ab0722d334e8010242374e8bba94c
Author: Oliver Mangold <oliver.mangold@pm.me>

    rust: rename AlwaysRefCounted to RefCounted.

This commit splits the AlwaysRefCounted trait into RefCounted (for actual
reference counting logic) and a new AlwaysRefCounted marker trait. This cha=
nge
allows types that can be both reference-counted and owned to safely use
ARef<T> conversions without violating ownership constraints.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 3bd5eb8a1a526..fb7466a362741 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs

[Severity: Medium]
In the module documentation which isn't included in this diff, it states:

//! To make use of [`ARef<MyType>`], `MyType` needs to implement
//! [`AlwaysRefCounted`].

Should this documentation be updated to reference RefCounted instead?

Leaving this as AlwaysRefCounted might mislead developers into implementing=
 the
marker trait for new types, which could violate the safety contract if their
type is also Ownable.

> @@ -24,11 +24,9 @@
>      ptr::NonNull, //
>  };
> =20
> -/// Types that are _always_ reference counted.
> +/// Types that are internally reference counted.
>  ///
>  /// It allows such types to define their own custom ref increment and de=
crement functions.
> -/// Additionally, it allows users to convert from a shared reference `&T=
` to an owned reference
> -/// [`ARef<T>`].

[ ... ]

> @@ -45,9 +43,8 @@
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
>      /// Increments the reference count on the object.
>      fn inc_ref(&self);

[Severity: Medium]
Since this patch renames AlwaysRefCounted to RefCounted and re-adds
AlwaysRefCounted as a marker trait, does rust/kernel/workqueue.rs need to be
updated to use the new bound?

Currently, rust/kernel/workqueue.rs enforces T: AlwaysRefCounted for work
items using ARef<T>:

rust/kernel/workqueue.rs:
    unsafe impl<T, const ID: u64> WorkItemPointer<ID> for ARef<T>
    where
        T: AlwaysRefCounted,

The same bound is used for RawWorkItem and RawDelayedWorkItem.

Does keeping this bound unnecessarily prevent purely RefCounted types from
being scheduled as work items via ARef<T>? It appears this might defeat the
goal of the trait split for workqueue users.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D5
