Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182954;
	b=M4WYcwA//t6SDqifhC2qqv/BiZoP1F6yOzpCHWLdwwXkwKExfIJClqmL05MLy5kQIsiF
	 0dp929Jhz0Y2QAwXOt1K1K2FznmBWThBuGwI9Rm2Plae9OMr5b5ytwGz/nB50MbRwfOK8
	 Ct9JPEhAWoeCl4uel02cVTWz9Bm4eiCk9/DAEvIjf6DA2stmTR0q8ibwZ8n2ITIgNhx1h
	 QHUqvU/fMHA++zoBeuW48O9kB5dJsftDe4saOO1QlJq89NDStudkJbhAtNV9KhtYMOSCF
	 XMF+xPdml66zWt65Hlu+PM0teykdzWuCqjYjZn1wORNTxUO+m9xLAgSGZG1CUcguplw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YWhE3FNuwdcYT/d/eCc2AsPgg/oHFa8prv0+Pxpi8g0=;
	b=dvvoxnNcTXbYKQsbs+Q1tmIK9ayqgUekHiPSM2M7ZK2yHlAT0Y3GW3XcZbga+AKrQoXw
	 NBt+mT83ZMh1ZnJ5lq/NBSd8wlixWlxyvd9iu5ppY80UbZo8o1ZOUgedDqKKRUABfuzqR
	 VWISIz7q3IGo/76QcqSVzcJ+80x5X6Ao6JEPJeqR2YId7QhFYVA/8CfV7NebAH9Jj4TtG
	 ow7ObpmaMSHpyIJn837OsImstDOwtF8wQK+IVGp+FJ+oF5ITE/RNnjLQ4tplI8TGnkChU
	 iiE9pZkWRsi972CkDAktAsi5BIJlRzh6jIjRxqrhM3SKnF3zoHI5bkLsX3puH+KVmhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfbwfA7s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD4606A325
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfbwfA7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E8A1F000E1;
	Fri, 20 Nov 2026 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182954;
	bh=YWhE3FNuwdcYT/d/eCc2AsPgg/oHFa8prv0+Pxpi8g0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TfbwfA7sKYhOuDT0U9O3X6CZjcaW0k0/lHsqWNK/t7RmIg1luIjZ1QJQY32ybieij
	 q+5GGf3ymOByMUr+L+ToqzGmicGB5Hr7Porxf+ORRgLEbGByK2ziVevDkyA3n15hAU
	 A2ZyT15TT3edt9thXGZZz7+KRiMH6qIziH+Ezon9v2ApunW1xDI/+FjZt2XP0DtgVS
	 TIa4EY03HQF7ArlmqsVeqbr7XG052+ZJv5ol7wOpjGia/22lPhI7LVIEe4Q3x1O3Y0
	 UrUhH17ECO8JF/+7JPkBKxn0HHUjkMY7NAwTZOmnhG6KXUG/p/5kVtxn8u417az9TT
	 DwwS0LToxYNnA==
Message-ID: <sashiko-outbox-225299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/16] alpha/PCI: Convert to
 pci_bus_size_and_assign_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-3-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:55:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> To serialize bridge window sizing and resource assignment, PCI core
> needs to hold locks across both phases. Alpha nautilus PCI code calls
> pci_bus_size_bridges() and pci_bus_assign_resources() separately
> because it needs to do special resource alignment and setup after the
> window sizes have been calculated. At least the former would seem to
> belong to some existing __weak pcibios_*() hook but the latter might
> need yet another pcibios_*() hook just for this single use.
>=20
> The nautilus code runs during init, so nothing is likely to race with
> it. Converting it is mainly about consolidating the sizing and
> assignment entrypoints of PCI core, which eventually allows removing
> pci_bus_assign_resources().
>=20
> Instead of trying to do a complex rework of the code, which is risky
> without the ability to test on the hardware, simply convert
> pci_bus_assign_resources() to pci_bus_size_and_assign_resources(). This
> adds a small bit of extra work by performing the sizing step again. The
> Irongate PCI memory window is a host bridge window and not a device
> resource, so the resource assignment algorithm does not move or release
> it, and sizing does not change it either once it has been registered.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

