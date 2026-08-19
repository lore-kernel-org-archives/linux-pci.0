Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEB455161
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138279; cv=none; b=EEb7HSfKmglxPaOAg2QZLxEKOMZaLF9cRajp7NMwETpP0tsf+pw4+VVu1vXeO99lTGKQ1OYoOn3QH13/DIFwdwFBf4SmnH4wAYs4skScQV5S2IedqyPWiEbfZKSZHpIvFXo7ipc8HgmpXVyujsihbdJnhpLNl/6CYzBsKS1W+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138279; c=relaxed/simple;
	bh=ucjy//HoZntAAGFnymcESoCkMnNsYwApDTUK12UCKPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EjwoWE2EBu7N0Dahat0dCkp43lnzeTduwugDYRU4Bqe/q24M3QIBgDGjYBwmbVvCbjdBHG7BJiYIv1qEDubqFtJrJO90ewC52Bfvl4QKC16M2v23IimGzkit/ZPLVnEqM7Kqz0kcZS+TGClIy0IaCkrpAyD+BCj3lhsNQgF+EqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6CsfDLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6CsfDLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649891F000E9;
	Wed, 19 Aug 2026 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138276;
	bh=/1DVeGOAORf/B4ZlJUx+ck4B059IWGSCTv2B91sHdLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6CsfDLxDcc1cY18MdRvwuc3sn6sJ2eeuZJYF+AT+3xuSAw9QvYkm1KMpgUGB8lex
	 ohRf8rU4ZP0Po4ClY6FMWbvU9lV0n/M8iAfyDNFQBOvdP3wfjE3J9mHSYzNx5yW7Pw
	 lBKWzelbsLvoRarfEuFqWvUUA7enQ9W1A74g1IefrH3u9QweOGAiLAq37tnHZN02d7
	 KdDwN0nt7OYZ7c3Evx4P/IqNxjw6FDn/QsxDI7iCCOxhB4EHQwBAhlucQb4E4SxxZN
	 VuBof9B9KPppXXep3HmTR9xCF7QONa5JmiEQNgtDnHFK8lKAhuycBChNfds3nwXLJE
	 7f+PB4l3JQEZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/16] rust: io: register: reimplement as proc macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:17:56 +0000
Message-Id: <20260819111756.649891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing parentheses around `#idx` in the generated register offset=
 expression causes operator precedence inversion.
--

--- Patch [1]: [PATCH v3 01/16] rust: io: register: reimplement as proc mac=
ro ---
commit e2035dd40ab99d9c728dbbe1a208159d8a85be92
Author: Gary Guo <gary@garyguo.net>
rust: io: register: reimplement as proc macro

This commit reimplements the existing declarative macro for register alloca=
tion
as a proc macro. This change provides more helpful diagnostics for syntax
errors and allows more flexible syntax without follow-set restrictions.

> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> new file mode 100644
> index 0000000000000..61d076ab570a0
> --- /dev/null
> +++ b/rust/macros/io/register.rs

[ ... ]

> +        let offset =3D match offset {
> +            RegOffset::Fixed { offset } =3D> quote!(#offset),
> +            RegOffset::Alias { alias } =3D> {
> +                quote_spanned!(alias.span().resolved_at(span) =3D>
> +                    <#alias as ::kernel::io::register::Register>::OFFSET
> +                )
> +            }
> +            RegOffset::ElementAlias { alias, idx } =3D> {
> +                outputs.extend(quote_spanned!(idx.span().resolved_at(spa=
n) =3D>
> +                    ::kernel::build_assert::static_assert!(
> +                        #idx < <#alias as ::kernel::io::register::Regist=
erArray>::SIZE
> +                    );
> +                ));
> +                quote_spanned!(alias.span().resolved_at(span) =3D>
> +                    <#alias as ::kernel::io::register::Register>::OFFSET
> +                        + #idx * <#alias as ::kernel::io::register::Regi=
sterArray>::STRIDE

[Severity: High]
Will this cause operator precedence issues if the parsed index expression
contains addition or subtraction?

Because idx is parsed as an Expr and inserted directly into the quote block
without parentheses, complex expressions will be emitted verbatim. If a
developer uses an expression like A + B for the array index, the generated
code would expand to:

OFFSET + A + B * STRIDE

Because multiplication has higher precedence, this calculates
OFFSET + A + (B * STRIDE) instead of the intended OFFSET + ((A + B) * STRID=
E).
This could result in calculating incorrect I/O memory offsets and writing to
the wrong device registers.

Could idx be wrapped in parentheses here?

> +                )
> +            }
> +        };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D1
