Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792F37C91E
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408960; cv=none; b=TsNEKaV5BERo7iGsfskp0KUVyYpGPCXF0yOGQgbkqcuuYx+n3jNEBCOgsEsrXcRwVIdbDCXe2O2lUcdc2nFzeLZWcgVzRibf//AfTrMv+FZ6uINg8uJKLmq1IO75xL6bpGn6qC+bWiuskA1Ik2kcj8xFrzmkccCJ9F0hEOIl0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408960; c=relaxed/simple;
	bh=ArtE5f7yivnyFsML6l+VDuhKU3He5DcOw8RtF2cQkm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZ+CKZ4cQgXqx4MpXkTO27HDvivp5U+riZh50NDw2YYJiFCW88Bqgt1YbJXKQb560QXEU1vVdp0vcHw54f8Cc+bEcflXgsNq7qFG93rqSqpcXl0ac6P9+3W3nIQQY2kqBf2BlMoOmVMx6Kah9ugRlpr1pAxamklx+6dvX4aVKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwy/rMFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwy/rMFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465B61F000E9;
	Thu,  3 Sep 2026 04:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788408958;
	bh=ArtE5f7yivnyFsML6l+VDuhKU3He5DcOw8RtF2cQkm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lwy/rMFEuKi0Be5FRlFi5sJ822zzOfo9R91QAEF4iN6BCHQnaj44+ljzVglhuPL2T
	 CZQbBsNlcB1dpNB+2pl5HzzJjGNPUPojwwYzEEmwXrG8Csm7m+e7AP3p2m9/OzHHfn
	 ec6+m47Kb+pl+d8cVUCLomwxot5c7KaXII5WFbTRRYEMImEq1/91ITooG0MfAphSpC
	 n2QhvcJBlm8TlctyTqzD61Ud9TjH+VdEE+qwskwceStaCjtWDe3wmGbQFK/GkYfj/j
	 gmVC3zjyFuVyxyvlUAsU4njNXTCK9kzqxvEJLb3kuyj5VbKI69J39gUhQsh9TNf9Az
	 1qkv+TQuSUpcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB439377D9DE029526BDF897BBDCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439377D9DE029526BDF897BBDCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:15:57 +0000
Message-Id: <20260903041558.465B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Callers of pci_dev_str_match() manually checked for the ';' or ','
> delimiter and advanced the parameter pointer past it. Move this common
> logic into pci_dev_str_match() so callers no longer need to duplicate it.
>=20
> As a side effect of this consolidation, pci_dev_str_match() now enforces
> stricter boundary checks on successful matches. Previously, if a user
> provided a malformed parameter with garbage characters appended to a
> valid BDF (e.g., "pci=3Dconfig_acs=3D110x@0000:04:00.0foo"), the callers
> would silently accept the prefix match and ignore the trailing garbage.
> Now, pci_dev_str_match() strictly verifies that the matched token is
> immediately followed by a valid delimiter (';', ',') or the null
> terminator ('\0'), returning -EINVAL if it encounters invalid trailing
> characters.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB4393F337A7=
92CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D3

