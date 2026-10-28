Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157858;
	b=XmLqevT3LduVf2C3fOPy3mhhzdN/YvvwgX607emdcFjmfe6w/nhXHHcv1ktbgKjbHE7P
	 1FrymJ/nFUSh+uUa3O4sModCEfKmJEoDW1OE1YSX7Hyj+Slr4a5k2nQK36Pmri0mhhTaD
	 ZxBxFewIS9pXu1rL4UMnH2Xc8y7ErwYNGVV5gd3RNLFmUMV73V0aWhz31tSeU0I8bhc25
	 9LL7U+W9PW5N7EiBie3Ed5glr0DkKfyTEDNwn1Alx5bfK75s2iOtDsl9aUjSQKgAglIL0
	 ikl2xukPSlkNW/jCuoP56tgNMuvzGFUU7G2lGT8rks8pyBIr0KbJh0ht/BGcbRiOoUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yR8qZ8SZpHw52Fu3wnStdm935PTS8eQ6L5yFKzzQ3Go=;
	b=g7xgHoaqHdgs6TJ9T4aLYDvVzrJC4Ic1HYsVN/i/5wESVwWQouf0vOSXkfIHbMBh/GTR
	 RmauY0gy4ZjbM95KbkJxJV78PSYFj9yOBvvzkr01PId833VWeUN/iURQcFHFU2wIkR+n9
	 1eA6SilhOp94rXXMLHd7TzsneCwq+1+FQltz/Y8T75wBDzVem9oMySoyltCki0/eR1anX
	 JOAgQfMV1U8I8zN+0saV5SWEC3/+7ZHrirT8bHVj5Bon+CKzF5VpPQjsb/eLkjZAMm1NP
	 mUr0KvaN6N/Y7d2xBLHigs0OdZPdeoA5Z6IuFtV2Tf1KdE0DT0knbmJrVB5m7R06pnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUye5fSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F8606A31E
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUye5fSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA491F01825;
	Wed, 28 Oct 2026 03:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157858;
	bh=yR8qZ8SZpHw52Fu3wnStdm935PTS8eQ6L5yFKzzQ3Go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUye5fSF1rviYC1zGbVgoUucVwXJTawAHwm/uZ/oTcK9Oa6csHz/SLPvcXeWjQS3K
	 ofuqffgz8Zo0Ba0WqX1dF7Ub92kXs5kGEYhuL3ofUz++kv9nnKFd2iHffHqE7ScBo/
	 oHe6r915CcWty8bzQU6edrmyjuIbQ6qxI5DVPcmkxn6J0mKA/G9wMn9RzeC689VsRY
	 odCCKfkKNoy5Z6hO3qVzPc5GZc0XFOjs5hriN9+pprJ4pEl65WRlKeosgdEpX2M1l4
	 7KkZuLU9dhditBU2mLr2/bvu7YCAQrFUgS/ErTiKebTZB8YdTXLkrsVxzobNAgSjek
	 qi+yldP6eyUGQ==
Message-ID: <sashiko-outbox-187418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/16] PCI: dwc: tegra194: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-16-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-16-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:24:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the two dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP)
> calls in tegra_pcie_dw_host_init() and pex_ep_event_pex_rst_deassert()
> with dw_pcie_get_pcie_cap() so that the driver-private pcie_cap_base is
> filled from the same cached value.
>=20
> tegra_pcie_dw_host_init() is called from .start_link, i.e. after the
> controller has been initialized, and the PERST# deassert handler runs
> after the endpoint has been brought out of reset with its clocks and
> power enabled. The helper therefore performs its single DBI read at the
> same point as the open coded search, and the private copy keeps working
> unchanged.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D15

