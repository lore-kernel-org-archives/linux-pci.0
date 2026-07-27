Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1D32E72F
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138091; cv=none; b=tYd8cIdR0K7nkXPQPR/SseKrRg1/c7ESWdVX5lWYH4OUIw5RQH3D43Ec5s5+36L9Y7BXc4E1IFULw45q0MJeig36Fm2+3KwZEhYyUwCyQzGEjh36gxg3LKYDVMzgJTcO5Tw5qKOpElys7WaVlh3/TxdQ0nURX4bmsy6iadY+zU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138091; c=relaxed/simple;
	bh=or8DXtzSgTxFPGGbkCxtHeV8USNzsTpw7CPMeiUgHfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DncqzMxbEgtnYhsRatrkHlYUCWik/gkxS9PqZFJvEuB2+SFU14n81ZP7utdi3dW7Vxq672gr/g7iuVshib5eBNrrY0dqdAvoWr2aq2lQH4586vG0Q+JPkqgo0mReeBh0w97ukhjguaNJ3rJlO4nkO+DYIq4UhwTvsdDIZO/tnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNeR1Vw4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNeR1Vw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1E51F000E9;
	Mon, 27 Jul 2026 07:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138089;
	bh=vdhWAnu28DrkkVVCnJqgsktjZRsPqLfi5nhVoLfOHXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNeR1Vw4OPq4Nen+ZWd2ll4jS5YijS4vSMaRAfZQTbYO0JFx9ohHu0YF+58nGxIWe
	 KFNzfzSS3B8EzjIucxG69tDPDKYKYaR5Z93rYxoRiR9B9FEPMK1Ouwiome57z305OT
	 oQfovuhI4NsGSN72lKDFuQQfOkhnIpYgd8YhkpYgcubr0EXIpdp8vUo/O9rzugP4jf
	 AUSZcYKpxzIQf8Uxx72c3Yl8tReWW/TKUzIPqPUj6HxFFXDJpbB4hqYlPLS+b/2zck
	 hSZMpbOq/O0dumPkh3jYQ/CJRwzUYHQs09me9CE+26DPx02kyKGzSyy2ogXVbjg9Pt
	 EISo3YlwqoDaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs
 show/store callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727072915.3954329-1-zhaojinming@uniontech.com>
References: <20260727072915.3954329-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 07:41:28 +0000
Message-Id: <20260727074129.4F1E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Inconsistent Return Code in sysfs show callbacks

Pre-existing issues:
- [High] Use-After-Free (TOCTOU Race) due to lockless fetch of pcie_link_st=
ate
--

--- Patch [1]: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs s=
how/store callbacks ---
commit 123c7550e88a60508484ee2915e5a520ce8e1364
Author: ZhaoJinming <zhaojinming@uniontech.com>

PCI/ASPM: Add missing NULL check for link in sysfs show/store callbacks

This commit adds NULL checks for the return value of pcie_aspm_get_link() in
the ASPM and clkpm sysfs show and store callbacks. It aims to prevent NULL
pointer dereferences when the device is not PCIe or the link state has not
been initialized.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 172783e7f519a..108d151a786e7 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1654,6 +1654,9 @@ static ssize_t aspm_attr_show_common(struct device =
*dev,
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> =20
> +	if (!link)
> +		return 0;
> +

[Severity: Low]
Does returning 0 here mean a successful read of 0 bytes, presenting an empty
file to userspace instead of an error? Should this return -ENODEV similar
to the corresponding store callback?

>  	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
>  }
> =20
> @@ -1665,6 +1668,9 @@ static ssize_t aspm_attr_store_common(struct device=
 *dev,
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
>  	bool state_enable;
> =20
> +	if (!link)
> +		return -ENODEV;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does fetching the link
locklessly here introduce a use-after-free race?

If a concurrent device hot-unplug of a sibling function occurs,
pcie_aspm_exit_link_state() could acquire the aspm_lock, free the shared li=
nk
structure, and set the parent's link_state to NULL.

Because this sysfs callback fetches the link before acquiring the lock, cou=
ld
it hold a dangling pointer, which is then dereferenced later in this functi=
on
when the lock is acquired?

aspm_attr_store_common()
...
	down_read(&pci_bus_sem);
	mutex_lock(&aspm_lock);
...
	link->aspm_disable &=3D ~state;

Does this same lockless fetch race also exist in clkpm_store(),
aspm_attr_show_common(), and clkpm_show()?

[ ... ]

> @@ -1713,6 +1719,9 @@ static ssize_t clkpm_show(struct device *dev,
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> =20
> +	if (!link)
> +		return 0;
> +

[Severity: Low]
Does returning 0 here mean a successful read of 0 bytes, presenting an empty
file to userspace instead of an error? Should this return -ENODEV similar
to the clkpm_store() callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727072915.3954=
329-1-zhaojinming@uniontech.com?part=3D1
