Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D173DD86F
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503977; cv=none; b=nvbcR34PCx2yajxudUiNrLyYcW7Lr7E3FjA/ey2GbqxCYttpDOBAr7T9HhqfgH6cNX9oouqbJXKlFXE4mWH2sMEKDgZ7Hfp3O0u2YpKBuw/mfVDiDaJtzCJhk2Ne+/WOJzvuexibZ0hcWSzQfI3cgDtLHTzTmilcGHqsdO5aXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503977; c=relaxed/simple;
	bh=kxE0cg7dsRxXYuo9sCk29C6tAC2WWHWnKkBxeUSDQw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s2WelsJ1iJhJ2RnMxzmu0qY1ewStbcQavadyImH/84woId4lnBcLKSeZrp45eZMg1op2d3cuUqmWKa5sfiGx0Mwkump6gxkTzLvu4qHtm823n+JpFyXp6+J9DQEX6/GePGhIK2F9AZw3+few0TnM3GQk6hOCO2U1Mn1Rc0jJGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWPRk2iY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWPRk2iY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C664D1F00893;
	Wed,  3 Jun 2026 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503976;
	bh=btNFov1vOR1IuoIjh9G53MBK6EOsFkFTsfPueEmiMVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWPRk2iYEq+S7GE3Uy5RMgcDZTUdrbhYrX/+q2uoyYmotsuXFncOff2fPGDNaLYJx
	 vsUkT59Ov0NCCgP2eSSWiGK1nI91YOrL4RvD3dK7x2Gu7TZ0lOO7ZnA4zvPihDRLxa
	 MjgoMR8ZBKs0yNF/5HwRYl0+CHJymG9S57B6ga687UtAcUmbs5cuxSkOl3PUWz7uvh
	 G/Bqf0sS4KdwBVNTFmKf7wTta9RZYLtKoFgZeBD99CtmQPv8oc1jw4YTqJp6Tmm0lC
	 5a919wTRcbtE6po0uUkBeiYFzYVCFqKKJxVdO+BkePAMFV5+Hc8McZs9dXjbkcyOdK
	 LyLNMDwOLRW1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260603-rust_leds-v19-2-2a71085deae3@posteo.de>
References: <20260603-rust_leds-v19-2-2a71085deae3@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:26:15 +0000
Message-Id: <20260603162615.C664D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation error due to undeclared module 'private'.
--

commit e81e640b175bb4d8e30e9e60973a904d55f53f03
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait

This commit adds the led::Mode trait to allow for other types of led class
devices in led::LedOps.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> index 08913e94e2f1b..61ea7a9e7f2c3 100644
> --- a/rust/kernel/led/normal.rs
> +++ b/rust/kernel/led/normal.rs
> @@ -6,11 +6,19 @@
> =20
>  use super::*;
> =20
> +/// The led mode for the `struct led_classdev`. Leds with this mode can =
only have a fixed color.
> +pub enum Normal {}
> +
> +impl Mode for Normal {
> +    type Device<'bound, T: LedOps<Mode =3D Self> + 'bound> =3D Device<'b=
ound, T>;
> +}
> +impl private::Sealed for Normal {}

[Severity: Low]
Will this compile? The glob import use super::*; only brings public items
from the parent module into scope. Since mod private is private to led.rs,
it seems private::Sealed is not in scope here. Should this explicitly
reference the parent module using impl super::private::Sealed for Normal {}?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rust_leds-=
v19-0-2a71085deae3@posteo.de?part=3D2
