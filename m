Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7B477995
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629000; cv=none; b=IyPkSV9NsMbYqiEY4kWkuKLXXZZrS4PEeGaPgbu6sepDuGLlNICekKVSmY/uRAlz6qOtPeXR09CsZ4pBYbq2ZOWwGgybSPp2FOVKLCMsNIDwLGoLsF5ltTXxurBaT7WclleStAtdiucFayqYiuxAHBDt6gbIz/R+ej70QiFggzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629000; c=relaxed/simple;
	bh=8HAwIx60lq6f9wImWJyhO8vMqYMs22LS/TDwJHQ7E1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ao6ZYznV0a5gh3jGHzkHTgXkY+0eLF84I0nJFC1vp+hSj4XdQpVPPaiV1pacXpV2x2C2pEEr14vykDb8Wb+7RhJRAm/vTAODzIkjcG4EsL72HiRSP5mPXz50fqQh/TOn70/y0MPPaMJeT+Vue9vG5UMhCRWR/aPTvAtMbLoQUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTPbtfJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTPbtfJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399931F000E9;
	Tue, 16 Jun 2026 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628999;
	bh=CF3pW/AbR1lepgDpm4qFpq2nRZLIoogEkQKqSTBsJPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTPbtfJzrDU3fpG2NOtm4QILKeY5LajRaX+EQC9dYe2SNHWOHrHyzfqPw+h6opMuR
	 dKs7qUMUVeb23yXo9DHinKLuDQpYzRXufmOP6PndOJ9w5CRnzBdyVzCdVaNMqGGrfw
	 9Pqw+kqCWB+y/CVutuaAnBH33gAe+zL7fuhEWQS4GfL023/2Lk404xZfKOVQQ8r1uQ
	 RVf+WHrQ+VnxSbyHrw/u5ljoVmejeWV6onFCFxi2FPg8MzkbQvFLbdQtjbnoDytPTy
	 diHrOPgtzG9q9SlLGqHglV3SP3XwcesWSKCeDWlwUyEUuL5TmO6yAm2qC13rPLVwf3
	 qBrWLzs0SBVmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: fix building against host-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616164049.3656435-1-arnd@kernel.org>
References: <20260616164049.3656435-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:56:38 +0000
Message-Id: <20260616165639.399931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When CONFIG_PCI_HOST_COMMON is set to =3Dm, the i.MX6 PCIe driver
> fails to link. This can happen when only i.MX endpoint mode is
> enabled but not host mode, which would indirectly enable the
> host-common driver itself.
>=20
> ld.lld: error: undefined symbol: pci_host_common_parse_ports
> >>> referenced by pci-imx6.c
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_in=
it) in archive vmlinux.a
>=20
> ld.lld: error: undefined symbol: pci_host_common_delete_ports
> >>> referenced by pci-imx6.c
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_in=
it) in archive vmlinux.a
> >>> referenced by pci-imx6.c
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_in=
it) in archive vmlinux.a
>=20
> Select the common module from the endpoint support directly.
>=20
> Fixes: 250eea5c06f5 ("PCI: imx6: Parse 'reset-gpios' in Root Port nodes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616164049.3656=
435-1-arnd@kernel.org?part=3D1

