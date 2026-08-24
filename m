Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B863EF0A6
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570683; cv=none; b=UmfDpb7raTBtOFhKXWK9dq6RGtCGg9jONu9/m4QtnD0sLk8RjxZVfv67IOE5Xq5bHRg662cUveegMgk2xBYDRQ30vdiKyS72ZxMluvueKZtTeKMidUgoLLs+yBnAfnklLPQavOpTfqGG45Av3Nvq54KLGwUZFE/TXpELarSgeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570683; c=relaxed/simple;
	bh=ApXPb53SPml/F9aldGqG+kjpgDpkMTNiPlSkzATJirk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZEYZ5jjRE+lq/0ODm/cwmha3XHzIboyNS2G6ez+E5vjUkCy1+Mel98yt/rPw8sCd1TSG9rwCRxrID59F69QaoKuu+Rud7FxDgqkz7/RdhRZW1XFYffcivrs8qDhhsPunl5/S8wAyjGcjmHkjACIvBhovoo/hDXSS0NRx4FkLCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4HfeApY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4HfeApY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21341F000E9;
	Mon, 24 Aug 2026 11:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570681;
	bh=ApXPb53SPml/F9aldGqG+kjpgDpkMTNiPlSkzATJirk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4HfeApYfUlWKXwMCGZfDagkLDrlAtyd8i01oFmS54X8YKCbOVUWn9Qyy8851Fsku
	 iZOcm7kLcA8slNnmtMnYt4Gl3sth1MvEneMuFiqibjH670Z62SANlnaiA7kC6KJgwU
	 Q7+kY4AYpSVsxRI/uYG6WevvL6zkjET3NLaIMjL2HdUcJ5FHz7eih/gfzW6OEkxzWZ
	 JwUtjhpfmWVurIjb00a/vnYdnaHqGqSnSxj63ojeZE15p6YO4jW5ZRlqtsqdB+VV8H
	 tPor6YVr4ZaPUJmNItXKPOaqcueR6ic7pNVCON6gDdvgrM6v4yGCg51bJYr5oSRhTN
	 2n0xbR+8iVZxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/8] rust: implement `ForeignOwnable` for `Owned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-3-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-3-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:24:40 +0000
Message-Id: <20260824112440.C21341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>=20
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D3

