Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D142D6E5A;
	Tue,  1 Sep 2026 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225948; cv=none; b=s+MWB5L0uoHmdish1n1dyihCDnXyz6SQyZ00SiWj7cc1ClV81EhpoeEvOL7UiACS3CvS/Z55OmzDljFJ7mCuH4VYACzFBX9Sq5OB2k2YFou0Jbocq6f6MHNtjYB1hY0VyRf8/FbXbJp3qtpimtLwIzGx4NutmaqkvA+jOuCIbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225948; c=relaxed/simple;
	bh=/A93uRc4pPm9AyLBXmuYe435LNIlYa7jsonJGwGw47I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K4FqbtRQhlUVS9pl6McjWQIzj9YOU/aSml/6Fi5JGB6l1mQosgIfVFT72f1zfa2dY1Xoy5rdEC6gB8jv+DbG1TTX1A2eu3tfSJDyns4rTtF0Ae7g+pnx/c20dLjEdT8FzxGu063iQ03BaHUbF7iWCtrcY3RB8PPdb108y/7HB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmcvfKzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmcvfKzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071881F000E9;
	Tue,  1 Sep 2026 01:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225946;
	bh=nH++/+rZWu3P0DdwIetv4FxYFtO0LyVzUR2dE0dwtKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lmcvfKzmHNXvKhMdTxcX5VdrFXAbIPYMGFvjDuDSgupdzEeL+/BTH1WNDdUEqVH4I
	 PBFdBjRw9S+fHPg1p+LvD716AYtxs16IPVXdfhQ/2LV6pt7qi6XQozlsfzCd+7OV9g
	 arpa7znMWYiXLfCq622kCJk//vu2HkUFaUWe7U+QrUAxioOzIJI64GFAgnl8rt2pMo
	 box1fKtq76/Zd9eShcDHXIQa7bl3TRHIIo54/8gxLVzuQW1qERRCUIFu1veUu8xr9a
	 Uh8jQ78QwOAI24oB7FSe/5V04AESp418EGbL8R9+d6e5n2Ch2mbTBWDicud+eQqZPu
	 NqABKDrQQxVMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/21] PCI/TSM: Support connecting to PCIe CMA
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-12-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-12-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:25:45 +0000
Message-Id: <20260901012546.071881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditional overwrite of `pdev->tsm` in `probe_fn()` causes memo=
ry leak and state corruption for independent sibling CMA hosts.
- [High] Expanding `is_pci_tsm_host()` to return true for dependent functio=
ns with CMA breaks DSM resolution, causing type confusion and preventing co=
ntext cleanup.

Pre-existing issues:
- [High] AB-BA lock inversion between `pci_bus_sem` and `tsm_host->lock` in=
 `__pci_tsm_disconnect` for upstream switch ports.
--

commit 1f366330a43aef4dbb8b7e338fe088b357fa13a0
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/TSM: Support connecting to PCIe CMA devices

This patch adds support for connecting to PCIe CMA devices by modifying
is_pci_tsm_host() to allow CMA capable devices. It caches the CMA support
in struct pci_dev to avoid repeated mailbox lookups.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 10c9c6696624d..440f818ac5699 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c

[ ... ]

> @@ -456,7 +475,7 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
>  	 * teardown
>  	 */
>  	guard(mutex)(&tsm_host->lock);
> -	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
> +	pci_tsm_walk_fns_reverse(pdev, remove_fn, pdev);

[Severity: High]
This is a pre-existing issue, but does __pci_tsm_disconnect() create an
AB-BA lock inversion between pci_bus_sem and tsm_host->lock?

First, pci_tsm_unbind_all() calls pci_tsm_walk_fns_reverse(). For upstream
switch ports, this invokes pci_walk_bus_reverse(), acquiring pci_bus_sem
for read. Inside the walk, the callback __pci_tsm_unbind() acquires
tsm_host->lock, establishing a pci_bus_sem -> tsm_host->lock ordering.

Immediately after, __pci_tsm_disconnect() explicitly acquires tsm_host->lock
via guard(mutex), and then calls pci_tsm_walk_fns_reverse() (which invokes
pci_walk_bus_reverse()), attempting to acquire pci_bus_sem for read.

This reverses the acquisition order to tsm_host->lock -> pci_bus_sem, which
could lead to a deadlock when racing with bus modifications.

>  	ops->disconnect(pdev);
>  }

> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 950e2c36a4cae..f504fa6803157 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h

[ ... ]

> @@ -142,6 +143,15 @@ static inline bool is_pci_tsm_host(struct pci_dev *p=
dev)
>  	if (pdev->is_virtfn)
>  		return false;
> =20
> +	/*
> +	 * Report capable if CMA is supported, which can be supported on any PC=
Ie
> +	 * device.
> +	 */
> +#ifdef CONFIG_PCI_DOE
> +	if (pdev->doe_cma)
> +		return true;
> +#endif
> +

[Severity: High]
Does expanding is_pci_tsm_host() to return true for dependent functions with
CMA introduce a memory leak and state corruption?

If userspace connects a dependent function (like PF1) as a CMA host first,
pci_tsm_connect() allocates PF1->tsm. If userspace subsequently connects a
TEE host (DSM) on the same device (e.g. PF0), pci_tsm_connect(PF0) walks
dependent functions and calls probe_fn(PF1, PF0).

In drivers/pci/tsm.c:probe_fn(), it unconditionally overwrites pdev->tsm:

	pdev->tsm =3D ops->probe(dsm_dev->tsm->tsm_dev, pdev);

Could this overwrite the existing CMA TSM context without checking or freei=
ng
it, leaking the memory and corrupting the state?

[Severity: High]
Additionally, does returning true for dependent functions with CMA break
DSM resolution in find_dsm_dev()?

When the parent TEE DSM (PF0) calls probe_fn(PF1), the allocation path
calls find_dsm_dev(PF1). Since is_pci_tsm_host(PF1) now evaluates to true,
find_dsm_dev() incorrectly returns PF1 instead of the actual DSM (PF0).

This causes PF1 to self-identify as its own host, meaning
PF1->tsm->dsm_dev =3D=3D PF1.

Later, when the parent DSM (PF0) is disconnected, remove_fn() has:

	if (!pdev->tsm || pdev->tsm->dsm_dev !=3D host)
		return 0;

This will skip PF1 because its dsm_dev no longer matches the host, causing
the TEE context to leak. Furthermore, upon device removal,
__pci_tsm_destroy(PF1) would incorrectly treat PF1 as a host and execute the
host-only teardown path (pci_tsm_disconnect), causing type confusion.

>  	/*
>  	 * Allow for a Device Security Manager (DSM) associated with function0
>  	 * of an Endpoint to coordinate TDISP requests for other functions

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D11
