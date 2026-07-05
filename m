Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195F253958
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290088; cv=none; b=So4lTaCvKLNGdyNKug3fkYrUWRt7ju5cUXhr+Zqkq6DJYMiYRaLQYOhbv3yQUnVCXQwfpg0HnlRfblpPQNZvAjX+kWKWjn8LrXnupwHqlqe9n2ZB9Gkqa/mRbQGn02JYMVR6l1e4tkX270GGts1jEn+Sc9Vppn5pr4XaR0HIsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290088; c=relaxed/simple;
	bh=aw5bUmtUWXJEV75KiG7qwJApJ7A1pMISVyd+JWglmFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlL0r9qt+yDaeNzHuJW0FBhMHY8INeyZm2fGqqsn0lFq3AujY15RBtFkyAW5pSFxeESLHMil91HiPz0yz399UqiFPR8piC8HFU+1yfNqv/kWIxJMYw+VyZO2Znv3hmXYvMuKlan8kQJYgkqKIvMHx7m2FwFDFGbIFS1FJmE0ljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHAxF0J3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHAxF0J3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED5C1F000E9;
	Sun,  5 Jul 2026 22:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290087;
	bh=WlTX4+K7UdHWQoUx5ms5bXrwbh8pcI5jZL4CPFcCQik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHAxF0J3rr78WWBAWtk5MTO8wil+KXmCV4YmaD62e2IunQQ+2N2I0MqPGxQReXYrX
	 VmJiWXNVoOQN8/fryDbi0wderw3E8mAXp4htJwbGoxWLmt1L/8LgCiX2tNA7t25lWM
	 9vOH+8kw5GGqwSxiqX4Cy/05eIQ6XCQb2rlgUAsVsO5mSOt95MmvYDUVgQI6ntOhWZ
	 4XkwhugrwHkeORnMAPOkucqfDJrpOwkE6DoBDUXh+wazDsHR8YlMOgCiG3HVrsoSO2
	 wReKov6Am5kENxrDw1qa7W2pRLCt3ooQErFdwPYfpPUz1ax6qThJI3Zet2ZVfVJmLt
	 +wRszBqCzyB9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] PCI/TSM: Add device interface security RUN
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-12-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-12-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:21:26 +0000
Message-Id: <20260705222127.1ED5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] `pci_tsm_accept()` unconditionally invokes the `run` callback with=
out verifying the TSM type or callback presence, leading to a NULL pointer =
dereference.
- [High] The `PCI_TSM_F_ACCEPT` flag is not explicitly cleared, allowing a =
reused context to bypass the TDISP RUN state transition.

Pre-existing issues:
- [High] Missing validation of TSM type in `unlock_store` and `disconnect_s=
tore` can cause NULL pointer dereferences.
- [High] Lock order inversion between `pci_tsm_rwsem` and `device_lock(&pde=
v->dev)` causes an ABBA deadlock.
--

commit dff8c6ed3353a6c7f7bb4d5a991bf30cccd06be9
Author: Dan Williams <djbw@kernel.org>

PCI/TSM: Add device interface security RUN support

This commit introduces a sysfs trigger to transition a device from the TDISP
LOCKED state to the RUN state. It connects the accept trigger to a new run
operation in the pci_tsm_ops structure. The RUN state prepares the device f=
or
private operation by enabling private MMIO access.

> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 590e19f6c2b80..1f09ab4e8d4c5 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c

[ ... ]

> @@ -552,6 +552,89 @@ static ssize_t dsm_show(struct device *dev, struct d=
evice_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(dsm);
> =20
> +/**
> + * pci_tsm_accept() - accept a device for private MMIO operation
> + * @pdev: PCI device to accept
> + *
> + * "Accept" transitions the device interface to the RUN state, it is
> + * only suitable to make that transition from a known idle (no active
> + * DMA / MMIO mappings) state. The "driver detached" state is a coarse
> + * way to assert that requirement.
> + */
> +static int pci_tsm_accept(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	ACQUIRE(device_intr, dev_lock)(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but does acquiring pci_tsm_rwsem and then
device_lock(&pdev->dev) cause an ABBA deadlock?

If a device driver's remove() callback is invoked holding device_lock, and =
it
calls pci_tsm_unbind(), which then attempts to acquire pci_tsm_rwsem, this
could invert the lock ordering.=20

Concurrently, sysfs operations like unlock_store or lock_store acquire
pci_tsm_rwsem before device_lock, which could trigger a deadlock.

> +	if ((rc =3D ACQUIRE_ERR(device_intr, &dev_lock)))
> +		return rc;
> +
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	if (test_bit(PCI_TSM_F_ACCEPT, &pdev->tsm->flags))

[Severity: High]
Can a reused context bypass the TDISP RUN state transition because
PCI_TSM_F_ACCEPT is never explicitly cleared?

When a device is unlocked, the provider's ops->unlock() retains the
struct pci_tsm object in memory. When the device is locked again, the
core constructor pci_tsm_devsec_constructor() initializes the base fields
but does not clear flags.=20

Does this allow a subsequent call to pci_tsm_accept() to observe the leftov=
er
PCI_TSM_F_ACCEPT bit and return success without calling the hardware run
operation?

> +		return 0;
> +
> +	rc =3D to_pci_tsm_ops(pdev->tsm)->run(pdev);

[Severity: High]
Does this code unconditionally invoke the run callback without verifying the
TSM type or callback presence, leading to a NULL pointer dereference?

If a user space process writes to the accept sysfs attribute of a device th=
at
is bound to a link TSM (which does not populate devsec_ops) or a devsec TSM
that omitted the run callback, it seems this would result in a kernel crash.

> +	if (rc)
> +		return rc;
> +
> +	set_bit(PCI_TSM_F_ACCEPT, &pdev->tsm->flags);
> +
> +	return 0;
> +}

[ ... ]

> @@ -568,9 +651,9 @@ static void pci_tsm_unlock(struct pci_dev *pdev)
>  			  "unlock attempted on driver attached device\n"))
>  		return;
> =20
> -	device_cc_reject(&pdev->dev);
>  	to_pci_tsm_ops(pdev->tsm)->unlock(pdev->tsm);

[Severity: High]
This isn't a bug introduced by this patch, but could the lack of TSM type
validation in unlock_store and disconnect_store cause NULL pointer
dereferences?

If a user writes the name of a link TSM to the unlock attribute, or a devsec
TSM to the disconnect attribute, the sysfs handler matches the name.=20

Since it fails to verify the specific type of operations supported by the T=
SM
before calling ops->unlock or ops->disconnect, could this lead to a crash?

>  	pdev->tsm =3D NULL;
> +	/* implicit clear of PCI_TSM_F_ACCEPT */

[Severity: High]
Is this assumption correct that un-assigning the pointer clears the memory
of the provider-managed flags field?

As asked above, if the struct pci_tsm object remains in memory and flags are
not cleared during initialization, it looks like the PCI_TSM_F_ACCEPT flag
could persist across locking cycles.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D11
