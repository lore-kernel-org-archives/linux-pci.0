Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434637AA92
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948674; cv=none; b=Lo7pEyCRvb+B0RVhac0mgapS3PXDK9SNZUCiwHhraD5gfnaM9xgy6ji9/VoD4XmMBRbd2ZTHzPsta0wfThano1/+EvxNxUyrPWp5JI2FZIQlkTz+0zJoavOoCDW1w7ycEas9cljvQTZ3ZMfxSdpfioYzPJeD4Ms//pfS8n/LtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948674; c=relaxed/simple;
	bh=B18Z85AwEk7ieXnEbNQ3ACD5iwth4eZ47nxViY+8MrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NamuVQANTQAEf8frHpYSTi0wJKjiNhBYrcickdlGk0fuhRWnKZac+PGBYtqpmxmNEYcTzi4DhUhMWp2C4zxLNy+vtSyWD0K6NaXkaDVSkCRHWr+JYIm7e1GtYbKLS2FZxnM/amyfTPEtCYAMB60wByWOGCGRMD8EM7XUWOxRQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1RTxSih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1RTxSih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB7A1F000E9;
	Wed,  5 Aug 2026 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948671;
	bh=iKC88PlcMQAy72Vp4zYxUh+UBhe4tddg7eRlo0Qvf/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1RTxSihuVi8C9O/cfFnLvaC1QV2+byc2NyH9Fekj8rpivMVn7hkBuJVAzraxJ1Hj
	 AEo+QiYjhIX2tHt6V0ghEun7yeqrgRzNherRjhjnlYIODmvBPr1gsyc/swIyZuWhK+
	 H79TMnfaJzY5xR2oqbfhF2JTNJ7U/nFX4KMyC3lPtxpArCshHAR1gSgjy6acvfTu/I
	 mjIvjQDgucd/tqiePTi3F+tnu3/3jqUqrNQK0Hcq5rxf7tFA0RgbfadA5fCkVFDdUi
	 9NwgIyRBUtbMUrzJPLKCtvSvvSk4n0TJDoCgUzEhAU1kaIK8h5dqOukremrD+NwwFF
	 8Wei4ujpsoynQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/16] rust: io: register: unify handling of register
 with/without bitfields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:51:10 +0000
Message-Id: <20260805165111.8CB7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documentation comment for `FixedIoLoc::Location` references `[`=
FixedIoLoc::location`]`, which does not exist.
--

--- Patch [16]: [PATCH v2 16/16] rust: io: register: unify handling of regi=
ster with/without bitfields ---
commit eee244bc141adb8220a5c6420bc3a94addf8572c
Author: Gary Guo <gary@garyguo.net>

rust: io: register: unify handling of register with/without bitfields

This commit unifies the handling of registers with and without bitfields by=
 making the fixed location a property of the type. It replaces FixedRegiste=
r with a new FixedIoLoc trait to indicate if a type's I/O location is uniqu=
e for a specific base.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index fe0e6763a600e..80282c423868a 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs

[ ... ]

> @@ -265,6 +224,17 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Sel=
f>>
>      }
>  }
> =20
> +/// Trait implemented by types that indicate there is a fixed I/O locati=
on for this given type.
> +///
> +/// Implementors can be used with [`Io::write_reg`](super::Io::write_reg=
).
> +pub trait FixedIoLoc<Base: ?Sized>: Sized {
> +    /// Type of [`FixedIoLoc::location`].

[Severity: Low]
This isn't a bug, but does this intra-doc link point to a non-existent item?
The trait defines a Location type and a LOCATION constant, but no location
method or field, which will likely result in a broken rustdoc link.

> +    type Location: IoLoc<Base, Self>;
> +
> +    /// Location of this type within given base.
> +    const LOCATION: Self::Location;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D16
