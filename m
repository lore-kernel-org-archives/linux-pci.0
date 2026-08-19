Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E535F161
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138189; cv=none; b=PsRQfCYN+2+VSP6LBJcYHtHdWCDs7M57cCyzwbWRxlOtktq+Dl+abkwCU28OBIxUOYW+c+imag2yxDKjEc0XlPOywMDhOZvA6mVGm/YjGRzVw976N9p97/NWeVRlGmPO37RgSsIPIG+I0wzyPSJgBtomKW/DRiXDZ9Osov6ZSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138189; c=relaxed/simple;
	bh=4gFEkjgdtbDlOcoq9ICfYCDlv3RSVGhnztjb90jeqaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rb1Kfj1qss/lvhstbqWpL9rypzQLja0zQpLDZRl2hSuYLwP+012y/25zMtDl4KSlActjm7D61Sz1zxhWPwr3jgn8gsQZYWcPXPjSi7DJjNuvh+ZVjFvBNLD5XVFCxZxrGXJo/jWeD0wpTV2PLv/7ym8H+FIEZusEAS71DgiRovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eixcbf1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eixcbf1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2EC1F000E9;
	Wed, 19 Aug 2026 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138188;
	bh=4gFEkjgdtbDlOcoq9ICfYCDlv3RSVGhnztjb90jeqaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eixcbf1sIjwigjDG3lLxHIoCF2p7l5eAluSRshPYZeIr/VOcf/j/byPvaDJG/TQK+
	 ek9WVN6Jw5cSoFJ6w0t7wADzKm4hMchYmJsKzIslLYKwIOPi2blqS7XkXS8R4z9QCT
	 ZLBSMN5tUvlpkG4Ii4VPCuqf8kBY7lIA1hsH3LyCmRkLOR43/LvkDT+FJIAcNTpVza
	 W8w+Xpz9oRGaSTTvo5+ziViJ5X9BfuFbKDT33EAUFHcMSQpmRxKZRY7bfGwqZeamiu
	 Wqs881n+WFTDDS6hmbxaMchtn0EF+XI1Gmmmn1p4rZsaWky8raPZh89WHYRYJj0XVl
	 YWo2+CwGu9kdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/16] rust: io: support register projections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260819-typed_register-v3-5-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-5-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:16:27 +0000
Message-Id: <20260819111627.EA2EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `IoLoc`s themselves just describe a projection from a region to a concrete
> register. Thus, support it in `io_project` macro too. Also, update methods
> that operate on `IoLoc` to use I/O projection.
>=20
> Documentation of `io_project!` is not expanded yet as the example works
> better when `register!` type can specify base type. `io_read!` and
> `io_write!` gains the ability to operate on registers as corollary of the
> capability of `io_project!`. Examples are not added because `read` and
> `write` is still preferrably used instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D5

