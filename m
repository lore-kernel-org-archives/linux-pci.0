Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC93A4535;
	Wed,  9 Sep 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941554; cv=none; b=bn81/dWPtQxSPaMG6H53Ca09U+R3uPxRBhgVBGqRYm4qHLkrKr8o1IYoRlLQS37vcbQEVJ8crlP7aSE6nhUYpP9fdS3cpOwEqp/UYJaYvnsAgjL2zAmBbzTPbA4ySJ09NnxlfMxoEI2mtFQ3NzXB8sG4URSvQTGwgHrAiNQL+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941554; c=relaxed/simple;
	bh=5tS32XK+wnm0lKLxh3WmOWq+GZ6XJFwHVrppeqUFtqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kKpj5X7rcSvz+qnWPN3FCzZihbtiodeuXFVHkL08h0Bj2Uc4UDOBuPhmE5aGUyamxda1GQY1Oyxfpoe7GdCRRVghJYEIqML/7cl4tqaZjkgJvaZWDaHB0UHrPYyoLCxEDP1iEiMYEdkp/GvF1vYrETM9IXg9DVWCB8drpfL5oXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0PRpPYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0PRpPYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E823B1F00A3A;
	Wed,  9 Sep 2026 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941552;
	bh=R3ACSNmBVgaJUX8X51XDYeuRZ/nbn4d9vXkS1j2A+uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H0PRpPYLipyY9s8iuRCQNU6nDFOIhaUAz6JajlI/bvzFJJwoVA6/cEmJR7ZEAuaIT
	 1vWxY6wouCf4bncJ7c7rR23wcn+D8HGg3/cDNyCvFm+2q8do0VmuqZ2phrvGCA6hO8
	 i/sAQ2VzCx7Dcd0qHVMZBSjoFQyb5XsEvkyw3g5OkgJ5CqQAekh7cc6bfQAXZOBkKe
	 Mk6fmapUrddT6vN9PSr3I1PA7AJGdhu5cUumRvAUmPnOWgSb6q/nLyb9OvYilipKD5
	 6tHG8kjtxwq+jjw2O1hw/z2c29Thw0vfacZlSikn9UBm1RoxuRHSuxffXplVbhye13
	 vgnMKdQbp3ZZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/10] PCI: of: Clear fwnode->dev during root bridge
 node removal and error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260909080114.591938-8-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:12:31 +0000
Message-Id: <20260909081231.E823B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the of_pci_make_host_bridge_node() call, an OF node is created
> dynamically and its fwnode device (fwnode->dev) is set to the PCI root
> bridge device using the fw_devlink_set_device(&np->fwnode, &bridge->dev)
> call.
>=20
> On removal, of_pci_remove_host_bridge_node() is called and calls
> device_remove_of_node() which in turn set to NULL the related
> dev->fwnode.
>=20
> Later in the removal sequence, device_del() is called and runs its
> cleanup logic:
>=20
>     if (dev->fwnode && dev->fwnode->dev =3D=3D dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
>=20
> [ ... ]
> error path.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D7

