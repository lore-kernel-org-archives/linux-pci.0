Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAFD356770
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948462; cv=none; b=Rprf7fZ2PGsYH8hoYyDnfIMG9syj5hIrQgR0dbfZP9xrTlCDxpH3tmbiuOO/fic96/tx57TCqYge/yHPGloSaVAEzLo574St+QCoQL+OBJDKfoKq1wkCQaDqq+4pm2fONCP/YAA2awpDfKvCPRDzQBmnvc7FZPKWnDVmNwilwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948462; c=relaxed/simple;
	bh=TXcyU0ZwYpmkNlfYLumGB8zo3v57+vUUxWt5TBqL+yo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LXBYjNij6+rwunH9ZGj21jCOFqNvTOs3yhIMefhsthg8Q5NFzumOtAy7GWeswGIpFrW0nioUgzkxcHrmtQhnPpZJ1QwMO+5STJ/g1Lo4tNp3EVrcoFhxp7kQRs6aARUIdaRAF7a8kSujr5RVT4dUml0VV4o/oi60p3WxNJ1+WNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqs/3ApA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqs/3ApA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD741F000E9;
	Wed,  5 Aug 2026 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948461;
	bh=OnPGKR/J4KGycTQcjXUUyXyreKYv2S6DrlkClx14ODQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nqs/3ApAdR0cMFYRi1zOG5/9bcJElrm+qAGxSMBhsBwUjG31wsR7TuN3hT6UahsvR
	 d1SOgO7ti63EIiY/NMAOZcAquQQVTjbIUBSOXCpSHAqLIt7m+c454pGNqvGtkse2dS
	 VNkgW7y5wrQuCUdJZsr1S/FXSmiCbr+iPyPi9A6kY3HJDiB8WdDKFylKj6JoTW8fAg
	 JX+HTeve9wyN38gtOxIM9ITyF/m6lo8dk/ZJR0e4gcS2bo87AqqvUHy3HQzeq8YvrU
	 cYOrqXoJ2Z+kqIKPhEgk8Vt43k0POw5r89nbaq4x55DS1cp/qNuFj3P6JSji+5373b
	 nf+HF5kIfWlUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/16] drm/tyr: specify base type for registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-8-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-8-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:47:39 +0000
Message-Id: <20260805164740.EAD741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete application of base parameter in register! macro invo=
cations.
--

--- Patch [8]: [PATCH v2 08/16] drm/tyr: specify base type for registers ---
commit 53a6ffbf27038a15b41db145d107fac75047c4d1
Author: Gary Guo <gary@garyguo.net>

drm/tyr: specify base type for registers

This commit updates all register definitions to explicitly use the TyrRegis=
ters
base type in the register! macro invocations.

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index a62724378ced2..3e6edae6e27f7 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs

[ ... ]

> @@ -1353,6 +1384,8 @@ fn from(cmd: MmuCommand) -> Self {
>          }
> =20
>          register! {
> +            base: TyrRegisters;
> +
>              /// MMU command register for each address space. Write only.
>              pub(crate) COMMAND(u32)[MAX_AS, stride =3D STRIDE] @ 0x2418 {
>                  7:0     command ?=3D> MmuCommand;

[Severity: Medium]
The commit message states that all registers are updated to use the new base
type, but it looks like a few register! invocations were missed during the
conversion.

For instance, earlier in this same file (drivers/gpu/drm/tyr/regs.rs), the
LOCKADDR register block doesn't have the new base parameter:

        register! {
            /// Lock region address for each address space.
            pub(crate) LOCKADDR(u64)[MAX_AS, stride =3D STRIDE] @ 0x2410 {
                /// Lock region size.
                5:0     size;

Additionally, the SectionFlags register in drivers/gpu/drm/tyr/fw.rs was al=
so
missed by this patch:

    register! {
         #[allow(non_upper_case_globals)]
        pub(super) SectionFlags(u32) @ 0x0 {
            0:0 read =3D> bool;

Were these intentionally left with the default base type, or were they=20
overlooked during the refactoring?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D8
