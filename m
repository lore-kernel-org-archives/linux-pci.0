Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F846AA65
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247977; cv=none; b=QPV7LhLC+/vC8Iy7YBQ7YMeeajJBGBseXFemmmj4J7/799PZQ/ALIVkYlcGQR57lUgytrIcTp0TiRkdaOZI9vntYjv5CIxwjXsW+tVNUNYb2CrWfeHiCjUg/Tj2wdsbsqmjV5eoc0s/xXEFDk76iDPDOvb/dXm+uZNrZw/a/s/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247977; c=relaxed/simple;
	bh=W4u3a4FUSbj0gjLb9g5X7Z1ty0H8/k88ORY3ExKR9XI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VsCusGKVXwXY8nBXlW7V3ww9OWHMMxnbq/flMLwla/SYY37By9WuqxMyRecCVN+/FgpMZqNx10slKXXNCPI6dk+8LGVnQ0akeP9RsgMxb4+wURRQgPkARcNWO0EAjdK5H/mfAqSW3afE+byLBcdUhvgEr2xbozj47ZEBtBa1+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn+SSBiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn+SSBiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228F41F000E9;
	Tue,  1 Sep 2026 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247976;
	bh=W4u3a4FUSbj0gjLb9g5X7Z1ty0H8/k88ORY3ExKR9XI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bn+SSBiVLIwmivGj0tKQSK/X2pZeqFGaXAUwjk1V15GLd8GPKCCw3tRq1NCsZ/Vsw
	 CFW2eNG9Jfrhgok2lTkiRAxKb5xDMY/ta1wcnGlPOXbazf7HdWPyhLp4Qu2U23N9PR
	 4feGO5uqC0yTOsNKmXsk8nd8mcYkZH5AXhkgMiuPAm7NXpK4SY/YGXmRv4jlPU7Qdb
	 RlqEShL6xqXWaEHLjiOTxkq+tJWGaT972scWF5oKDmK5dDWIYnkLc9zZPJk39mLg4e
	 CtZrb8SAWJbwzXHEbL+y8TjM46l8TFA29b4Uv7/GgJV/trJVeooOEFDqLebz2PuMVn
	 6yvy2+Pv16KzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] x86/hygon: Map CPU NodeIds to DF nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lin Wang" <wanglin@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260901071700.3255382-4-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-4-wanglin@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:32:55 +0000
Message-Id: <20260901073256.228F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On bare-metal Hygon systems, CPUID 0x8000001E ECX[7:0] encodes a
> CPU's socket and local CDD ordinal. The value is sparse across sockets
> and cannot be used as an index into the dense DF node cache.
>=20
> Translate the CPUID value through the CDDs sorted by socket and DFID.
> The NodeId reported by CPUID in a guest may not describe the physical
> DF topology. Return -ENODEV in guests or when the NodeId does not
> identify an enumerated CDD.
>=20
> Signed-off-by: Lin Wang <wanglin@open-hieco.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901071700.3255=
382-1-wanglin@open-hieco.net?part=3D3

