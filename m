Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E03AE190
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282086; cv=none; b=aIEamRhWPIJuMqp4IPx1DX7+k0dzM9C09ShlL6T4NDYxIgk7m2rbiwA8wlHw/fHbgOhh3ZVzm6q8BFhEFwNbzPhJkMNn2hkrJnIdrH4Gix/4NlzV4IN/8BL7YikXRjn3CC7fHl1AKpuzj+7NckEevqOd+8uhPM7HaP7Z8/c9CII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282086; c=relaxed/simple;
	bh=KBWwOQEuxmvOX++p55lzuBNqTNFkEMf5d7tR2N04+p0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J+SYvFakpYE4LIvJS7V3/8R02qnERPb6oDZ+VL8GzdVG6mmQFaCuzyU7SCRWCC5RXAcm0mN10HjA/ZG08KnSbk4gx43MO2B9txVipeAlLfeN61wBVsNToI8k6olR7//WyfpDLyotsYhFl0ceqtr+dwQiPvrI3BhYiq3UXrTT6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXz0jgta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXz0jgta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0341F000E9;
	Tue,  1 Sep 2026 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282085;
	bh=B406paQnLSN/UkJ82hmyzBgrzyxY/MPOyV1D/v02jt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jXz0jgtaWnhthPg2cvOdZOkMcA/3k7DBkqpKlPLnxYzUd/+LzpxidGo8JyMwN2xFI
	 Dz7VwbbjBpLjOhj1QdrXsXFkv9wR2K5gB1BgJQSdaS06xKU6uP2JPSnxa9dEiszmTa
	 gDCap73Kf0EUQfpOqwRPxa72UKuBnUB6DKbd9ILpPChoKUhFsJkLI4xatVwlE7mvI6
	 U+I1zRuno+6m+XC6lcAoier2nnCkOyQdOQj3SJXBzna6lSDArdeGOJK3jwOyBhG4Ez
	 WCEb9KmndECFqM0axKUKfYBDa6kfq/0goeefKLLVAgxQWuOlEiAhjk3SgI3/dbDWA2
	 bap9WaeOC/FgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-13-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-13-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:01:24 +0000
Message-Id: <20260901170124.CD0341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Nested imports are not formatted using the kernel vertical import s=
tyle.
--

commit 5f257dd4b3d5392812ee98a7773fef681ee000af
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: convert hshub0 from relative register to projection

This commit converts the hshub0 relative access to use a projection and a
new base register. This brings it in line with the earlier PFALCON and
PFALCON2 conversions.

[ ... ]

> diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/=
regs.rs
> index c27582e376e29..abb48b0955a9e 100644
> --- a/drivers/gpu/nova-core/fb/regs.rs
> +++ b/drivers/gpu/nova-core/fb/regs.rs
> @@ -2,7 +2,8 @@
> =20
>  use kernel::{
>      io::register,
> -    sizes::SizeConstants, //
> +    prelude::*,
> +    sizes::{SizeConstants, SZ_4K}, //

[Severity: Low]
This isn't a bug, but should these nested imports be formatted using the
kernel vertical import style?=20

The Rust coding guidelines generally require breaking nested imports
vertically into multiple lines rather than keeping them grouped on a single
line like sizes::{SizeConstants, SZ_4K} in the imports block of regs.rs.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D13
