Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE8238D54
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 05:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216572; cv=none; b=JIzxyiDagKaDW3Of3Po9iVNMGXCdnafHPOxRqRIRcbxGt2MGpIzuihJwJNEeFdPpLMn2zOs6jepuQFQqHHOj7MlS+OyoxAkYRKuV7ooKimrsCOg0bWiduXyGhtTWV1EyK647s1fJR/YjgQgFjaPfWjv8sRf+CJOvUfdbQHEDsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216572; c=relaxed/simple;
	bh=NnkMsema/WsgIBcmX2fF8fr3R3ZVdsk2qonYwi9NOR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pflfMhTR7iYh73gw3x6dkArjB/SyRJAEuwS4u7pgWIpZNkAUTsRLfARO8XKqlGJL5S3whnrQ/HWm5BgdLn3xZ+U/4uxXST3Mr9u+4ae3JCTbiXuX5cr+K+t4loeu7PP/0OJZtU0CuHmyB/z0ikS6zpNPXSQwzynWri5x8yMmapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrDHB0g+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrDHB0g+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FD4C2BCB0;
	Fri,  8 May 2026 05:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778216571;
	bh=NnkMsema/WsgIBcmX2fF8fr3R3ZVdsk2qonYwi9NOR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rrDHB0g+fvbJ0hQk2aD6id8An5HP483dgEsB2BCjwo7c9SL+SJ7GCfx/4x+X92HtK
	 1vK0vb3f9yCgTEFtBBbqYwMv6do0rODZhaTC3X8AqzerHJRY/9Yt4XeYCVlwIdTFda
	 k2+NZhCvcYxCjU+gWab+xaXLCzV2CMl30Dr03po9qdE/AY2o9PkDaiLP5TG8FOh+QD
	 qQOh3JM64cBx1FwFs93GiHoyM/raQcmPT9H2aPn188HiARwyd1NB8yu9KPMV7eIiaQ
	 qC9wIoCKw4YLVsNjbOO3r9rsfLVlWEPeToN+HqpB3w8Z5e53U6FhHGSfV2LhZTbnE1
	 8IsOw5Wk1kudw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/18] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-10-alistair.francis@wdc.com>
References: <20260508031710.514574-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 05:02:50 +0000
Message-Id: <20260508050251.88FD4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] PCI_CMA unconditionally selects RSPDM, bypassing Rust architectura=
l dependencies.
- [High] `pci_cma_tsm_probe()` manually initializes the TSM context and inc=
orrectly sets `dsm_dev =3D pdev`, causing a guaranteed NULL pointer derefer=
ence for Virtual Functions (VFs).
- [High] Missing `bind`, `unbind`, and `guest_req` callbacks in `pci_cma_ts=
m_ops` lead to NULL function pointer dereferences in core TSM APIs.
- [High] Missing `pm_runtime_get_sync()` before accessing the DOE mailbox i=
n `pci_cma_tsm_connect()`.
- [Low] The struct `pci_cma_devsec` is defined but never used.
--

commit e57964ed86001a515a5baf89472dd183655e1af8
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/CMA: Add a PCI TSM CMA driver using SPDM

This commit adds support for component measurement and authentication=20
(CMA-SPDM) per PCIe r6.2 sec 6.31. It introduces a TSM driver that uses=20
a PCI DOE mailbox as a transport for SPDM-based authentication.

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 33c88432b7287..dcf4170381f24 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -124,6 +124,20 @@ config PCI_ATS
>  config PCI_IDE
>  	bool
> =20
> +config PCI_CMA
> +	bool "Component Measurement and Authentication (CMA-SPDM)"
> +	select CRYPTO_ECDSA
> +	select CRYPTO_RSA
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select PCI_DOE
> +	select PCI_TSM
> +	select RSPDM

Does selecting RSPDM here bypass Rust architectural dependencies?

Since RSPDM selects RUST, using select here forces RUST on regardless of
its dependencies like HAVE_RUST and RUST_IS_AVAILABLE.

Can this cause unmet dependency warnings and build failures due to missing
compiler toolchains on architectures without Rust support?

> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> new file mode 100644
> index 0000000000000..998fde6366fb8
> --- /dev/null
> +++ b/drivers/pci/cma.c

[ ... ]

> +/**
> + * struct pci_cma_devsec - CMA SPDM devsec TSM context
> + * @spdm: SPDM session for this device
> + */
> +struct pci_cma_devsec {
> +	struct spdm_state *spdm;
> +};

This isn't a bug, but struct pci_cma_devsec appears to be defined but
never used anywhere in the driver.

> +static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
> +				      struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe;
> +	struct pci_cma_tsm *cma;
> +
> +	doe =3D pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +				   PCI_DOE_FEATURE_CMA);
> +	if (!doe)
> +		return NULL;
> +
> +	cma =3D kzalloc(sizeof(*cma), GFP_KERNEL);
> +	if (!cma)
> +		return NULL;
> +
> +	mutex_init(&cma->pf0.lock);
> +	cma->pf0.doe_mb =3D doe;
> +	cma->pf0.base_tsm.pdev =3D pdev;
> +	cma->pf0.base_tsm.dsm_dev =3D pdev;

Is it safe to bypass pci_tsm_pf0_constructor() and manually set
dsm_dev =3D pdev here?

During pci_tsm_connect(), the framework walks all dependent functions,
meaning pdev can be a Virtual Function (VF).

Later, when the core TSM subsystem calls to_pci_tsm_pf0(), it validates
the DSM device with is_pci_tsm_pf0(), which returns false for VFs.

This causes the helper to return NULL, leading to a NULL pointer dereference
when the core framework attempts to acquire the lock.

> +	cma->pf0.base_tsm.tsm_dev =3D tsm_dev;
> +
> +	cma->spdm =3D spdm_create(&pdev->dev, pci_doe_transport, doe,
> +				PCI_DOE_MAX_PAYLOAD, NULL);

[ ... ]

> +static int pci_cma_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_cma_tsm *cma =3D cma_tsm_from_tsm(pdev->tsm);
> +	int rc;
> +
> +	rc =3D spdm_authenticate(cma->spdm);

Does this sequence need a pm_runtime_get_sync() before attempting
authentication?

Since this is triggered via the sysfs connect attribute, it does not
automatically wake the device.

If the device is in a low-power state like D3hot, accessing its DOE mailbox
registers here could result in PCI aborts or return ~0.

> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}

[ ... ]

> +static const struct pci_tsm_ops pci_cma_tsm_ops =3D {
> +	.link_ops =3D {
> +		.probe		=3D pci_cma_tsm_probe,
> +		.remove		=3D pci_cma_tsm_remove,
> +		.connect	=3D pci_cma_tsm_connect,
> +		.disconnect	=3D pci_cma_tsm_disconnect,
> +	},
> +};

Are the missing bind, unbind, and guest_req callbacks intentional?

The core TSM framework APIs like pci_tsm_bind() and pci_tsm_unbind()
unconditionally call these function pointers without verifying if they
exist.

Could this cause an immediate kernel panic if userspace or VFIO attempts
to bind a CMA-authenticated device as a TDI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D9
