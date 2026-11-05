Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907837;
	b=htLZ5bwwngfJKefmyvm0fZfADnbQWzkqbtyd6qrDJJg8gLqcCBs5Am5esKhexmGCpXny
	 b2qPAOk4pIMOJ+cnzKVB4YCwK/HK3sNUPZoQ+O/9osdSTHAqfmFrlmyKSA07QJRx4D3Ax
	 xKf2pcrc7oUmUi4kREXZ4BXZLstRJHjvXZEdstwzCPAtVuVA9GFpmkM/zwzXBiyCYRhdx
	 jPdL5fodlgKQpmlVgMort5J1E7m4I2jDqtbIjrjO0jivICExTDkDs/JRBVsHv2ODqCkz4
	 FMs8aQrAWSyQ97BtFge81StX8E5YLnA+6jCkklqxmOnS5M/f2cK5rTXPjqPlQ2vnfcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907837;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ycGhrGBU6IRvzXDJelxC4AAAmZtRL7Tsx3OukQzY7VI=;
	b=svZDKIUHo4FGttwwMKJPxRW32VubbGG0KhwLBwg3vbQ5/FDdYc76mJ9HzNwFbZc9/gD5
	 RN9iNialY/b8CEr2OQuX25Brd/ju3wthSkm85f14deXCe24DypKxMtwerPwltWbg/jDUG
	 djAMm6iMy7YLBCIdfKY1fhbOfMd6THBtCB9ZkJ3a3f4QrVqE2/4XXgiZltnjeUbzXpcfI
	 2dScfzVeQ+lk7NOAc/SAtt1yMPGRe6Zn3EIuoqwEWirT0mm+MGHU6S7S9AC4e3L5SRqAQ
	 wEhXGj1jStBGoq1H3010bmv6tO/jujxCxqg4mVsLg1ntRY3AUxVdafZL2pthxf2erPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCQlnOtS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96C606EA70;
	Thu,  5 Nov 2026 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCQlnOtS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4E61F008A4;
	Thu,  5 Nov 2026 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907837;
	bh=ycGhrGBU6IRvzXDJelxC4AAAmZtRL7Tsx3OukQzY7VI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oCQlnOtSG6MAKpN+ZCJDLNN4gpuXVXCcCuKs6bZs3Gn8Z7HYG8mLjQiDWeQZKuXjc
	 FTQIJtcs/d9WKYWU3QzqVKYYNnvfiUNRNlgh2ufBmemFU96fLcfIe43xdxZDIUnM1w
	 6+/dA87xyTNnkRPlf2whEKyrtIwIzClFJeDCz/oP/qp3AAlf+tbUmI90XIQMzgk/Qk
	 zv3V81uFrmps23UoO4CL8OmXUGQ8SX8Ml7Du+jOpfA/1dSLiOYhQR5mwIrcl+T2eO/
	 U1BLmwC4fVC5+J9X0EJguNENwswsGOi56QixjNR2P5/+FRuLf9ArTYaahxkw9KMj99
	 P8FtkCPSK7iJA==
Message-ID: <sashiko-outbox-199972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 17/19] PCI/CXL: Restore CXL state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-18-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-18-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:43:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: __free(kfree) variable declared as NULL in cxl_reset_bus_funct=
ion()
--

commit 293a1729e6b1792018354518fc69bc55b2adb408
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Restore CXL state after CXL bus reset

This commit restores cached HDM decoder programming and CXL Device DVSEC
control state after a CXL bus reset, refreshing decoder settings under
region quiesce and re-enabling bus mastering only after IOMMU translation
is restored.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 426b5ee38d04f..1d4ba90a69762 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5014,8 +5014,10 @@ static int pci_reset_bus_function(struct pci_dev *=
dev, bool probe)
> =20
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct cxl_hdm_info *snapshot __free(kfree) =3D NULL;
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
> +	u16 command;
>  	int rc;
> =20
>  	/*
> @@ -5040,6 +5042,10 @@ static int cxl_reset_bus_function(struct pci_dev *=
dev, bool probe)
>  	if (rc)
>  		return -ENOTTY;
> =20
> +	snapshot =3D pci_cxl_reset_prepare(dev);
> +	if (IS_ERR(snapshot))
> +		return PTR_ERR(snapshot);

[Severity: Low]
This isn't a bug, but in cxl_reset_bus_function(), snapshot is declared
with __free(kfree) =3D NULL at the top of the function and only assigned
after the early return paths:

	struct cxl_hdm_info *snapshot __free(kfree) =3D NULL;
	...
	snapshot =3D pci_cxl_reset_prepare(dev);

Following the cleanup helper conventions in include/linux/cleanup.h, could
snapshot be defined and initialized in a single statement where
pci_cxl_reset_prepare() is called?

	struct cxl_hdm_info *snapshot __free(kfree) =3D
		pci_cxl_reset_prepare(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D17
