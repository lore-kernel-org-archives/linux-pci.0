Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4662F1FDE
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591045; cv=none; b=Z2+BdT59i3ynpD1iPEhI9o7v8dWGzp7QNMyVxp+yb66Yh3DtysMrkCsvugYaYvP5lQOVZPzv8cqTuzxTEI1/w1lE1881lUoqZ3BEsjwo0xCuBPNFTKD3G2T0xDrcEZaGGjFT9jse4Z0MzOgdOhnJ+g4OwAxavACNmQVhUY7xE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591045; c=relaxed/simple;
	bh=/V79yRBFl33Ows8uO6p6Sgn2BwSAZpa4GTd2RLO1AyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gni12HXG0xcRsh0Z4Lkq3uhw8mwnGWKIt+ctJNfTHYqSK0T7N/oq4p7rxVKz4HCpG6dSWIJeNNNaF6fMxTgGEp9Ze0H664HxzrCv/Lc0ZKLYBd41Hri2jCX1UfuJr1rdONA9R+Ipqhb+ZOc8F0MaczXf9batASabYotS5N9b75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwX7YmlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwX7YmlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221E71F000E9;
	Mon, 24 Aug 2026 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591044;
	bh=mTISctD+1BC+oiF3XW2nMDFY4qNwlb9QQcVYs1fvFe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwX7YmlNWypuSkT5z5kA5sTmeDHrlfqS0xy2q+m160mBIzbsF6CrsEKbnJfnTmJe7
	 e5hVciPY/jihqpgSbZ2DFExcOxTzZipe54XnEx5pHMEAgKmZqeHvXRpx/ths5PV9dC
	 XxjvDNTZTDqL9MZjZC7NfSZT5LcdmFq5iNKCZySaqoveAmNRp8ZRUjT3kFLURexYNw
	 D281Sj7dwRX4ygxgIZevWuh5Qu6uxNmsru9zBaQtXTuPOzRwZ/qyaAl1S7LvSp5001
	 5yBDLGNF567IwKtoRj+q3/O3rM3dMeJ8CVVCXOc3+jEauEIGOEbU8zd403G7tV+R1a
	 Mj4aPzqsuX4dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: quirks: Drop unassignable 32 GiB BAR 4 on
 Tenstorrent Blackhole
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260824-blackhole_quirk-v1-2-fc004672cdbd@oss.tenstorrent.com>
References: <20260824-blackhole_quirk-v1-0-fc004672cdbd@oss.tenstorrent.com>
 <20260824-blackhole_quirk-v1-2-fc004672cdbd@oss.tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 17:04:03 +0000
Message-Id: <20260824170404.221E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Tenstorrent Blackhole cards expose a 32 GiB BAR 4 that is unused by most
> software talking to the card. This BAR cannot be assigned on hosts whose
> PCI aperture is smaller than 32 GiB (e.g some ARM/RISC-V systems). This
> failure also results in BAR 0 (256 MiB) and 2 (2 MiB) being unassigned
> because bridge windows are sized as the sum of all enabled child BARs.
> This makes the card completely unusable on such systems.
>=20
>     spacemit-k1-pcie 80000000.pcie: PCI host bridge to bus 0000:00
>     pci_bus 0000:00: root bus resource [bus 00-ff]
>     pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus addre=
ss [0x10000-0x10ffff])
>     pci_bus 0000:00: root bus resource [mem 0x1100110000-0x117fffffff] (b=
us address [0x00110000-0x7fffffff])
>     pci_bus 0000:00: root bus resource [mem 0x1800000000-0x18ffffffff pre=
f]
>=20
>     <snip>
>=20
> [ ... ]
> bridge window then sizes to BARs 0/2 and succeeds. This was tested on a
> Spacemit-K3 RISC-V board that has only 4GiB of BAR space. tt-smi and
> tt-bh-linux are able to run on the card.
>=20
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-blackhole_=
quirk-v1-0-fc004672cdbd@oss.tenstorrent.com?part=3D2

