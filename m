Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F105370D54
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290322; cv=none; b=o6OskCgxUSDn5CKB4ctG5qecZheIIwB+jUqj1KG06qWJRlG5pyIe9Rfc/9EqYeSoFdVLeWtU1XSPj2o7tMmxoYbbPzFBfMws/9RE9InXkop+GDsFuCuXf4CeNs8AdIXonrI1+Bl2mzPCVnYNxJENj3Bb9OHOQ4iutEiPs7RmHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290322; c=relaxed/simple;
	bh=OSo8AFuGa2J47mO9oJS16LqUcMVYYcdVkxd62K2NTcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IVH8k2wTeuk74kqw2Y8KhZC3jMuDSv0D7eSqZygmjj8pYz9d15JUaRERDPzFnLsDK7T9IbLaQxNfRe+KIVUSyvFXWPdOd4XHXCez1J+AR54oKjYR8V+nUpS9HKC5NXFisYzbvgRVzwzsyt1lJ6UmZ+p4lVQUBSsQXxBxAWWzLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1J8mvHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1J8mvHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D458B1F000E9;
	Sun,  5 Jul 2026 22:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290321;
	bh=+D/ymzkBRM3/+ybabGMlpUWuhX9oeKFt1LH646CLrVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1J8mvHmQHJUlUdgiABgSJ1ICHw38zN6klDDmULI6PTbmHdK58ni6XYrTgf3ZP1oT
	 ozZHXjBIQL84JsYPZ5cWWH7+vERpG1jtmJzm9ndSvzLdgPshXbzPPIw4A9bwwchYng
	 7s+Ny/xOPnHeD1LmSy4rxoOQXBV/Q51bV1pPrptpAuYEcu6NSiGICmtsuf9hY4B+EY
	 gSk5ANAD1iCFdwSEgCbEIh47wkTPNfI0Nmkurp3wXLnzUhQpnRLUOaM0iqOmBFafQv
	 3zv4P2XWJwPhBzwm7unQepEXMrW0syEVfLtFnn93p5y9VrRVHSuL9OVwd5E97nAPt/
	 d3pJ3c7C1nLeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] PCI/TSM: Add device interface security LOCKED
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-11-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-11-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:25:20 +0000
Message-Id: <20260705222520.D458B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Sysfs operations `unlock_store` and `disconnect_store` do not veri=
fy the active TSM context type (`pdev->tsm`), allowing userspace to trigger=
 kernel panics by performing operations on the wrong context type.
- [High] `pci_tsm_unlock()` returns early without clearing the TSM context =
if a driver is attached, causing a dangling pointer and Use-After-Free duri=
ng subsystem teardown.

Pre-existing issues:
- [High] A TOCTOU race condition in `tsm_unregister()` allows `lock_store()=
` to attach a PCI device to a TSM that is actively being destroyed.
--

commit 82cae08595d79f2459048e59ff4784f6bfb600ba
Author: Dan Williams <djbw@kernel.org>

PCI/TSM: Add device interface security LOCKED support

This patch implements the LOCK/UNLOCK operations in pci_tsm_ops to allow a =
VM
to manage the security state of assigned devices. It provides the lock and
unlock sysfs attributes to transition the device between TDISP LOCKED and
UNLOCKED states.

> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 220842df42bc5..590e19f6c2b80 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c

[ ... ]

> @@ -531,6 +552,125 @@ static ssize_t dsm_show(struct device *dev, struct =
device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(dsm);
> =20
> +/**
> + * pci_tsm_unlock() - Transition TDI from LOCKED/RUN to UNLOCKED
> + * @pdev: TDI device to unlock
> + *
> + * Returns void, requires all callers to have satisfied dependencies lik=
e making
> + * sure the device is locked and detached from its driver.
> + */
> +static void pci_tsm_unlock(struct pci_dev *pdev)
> +{
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +	device_lock_assert(&pdev->dev);
> +
> +	if (dev_WARN_ONCE(&pdev->dev, pdev->dev.driver,
> +			  "unlock attempted on driver attached device\n"))
> +		return;
> +

[Severity: High]
If pci_tsm_unlock() aborts early here because a driver is attached, pdev->t=
sm
is not cleared.

During subsystem teardown, __pci_tsm_destroy() calls pci_tsm_unlock(). If it
aborts here, does pdev->tsm remain pointing to the context while the TSM
provider unregisters and frees its memory, leaving a dangling pointer?

> +	device_cc_reject(&pdev->dev);
> +	to_pci_tsm_ops(pdev->tsm)->unlock(pdev->tsm);
> +	pdev->tsm =3D NULL;
> +}
> +
> +static int pci_tsm_lock(struct pci_dev *pdev, struct tsm_dev *tsm_dev)

[ ... ]

> +static ssize_t lock_store(struct device *dev, struct device_attribute *a=
ttr,
> +			  const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	int rc, id;
> +
> +	rc =3D sscanf(buf, "tsm%d\n", &id);
> +	if (rc !=3D 1)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (pdev->tsm)
> +		return -EBUSY;
> +
> +	struct tsm_dev *tsm_dev __free(put_tsm_dev) =3D find_tsm_dev(id);
> +	if (!is_devsec_tsm(tsm_dev))
> +		return -ENXIO;
> +
> +	rc =3D pci_tsm_lock(pdev, tsm_dev);

[Severity: High]
This is a pre-existing issue, but can lock_store() attach a PCI device to a
TSM that is actively being destroyed?

In tsm_unregister(), pci_tsm_unregister() sweeps the devices and drops
pci_tsm_rwsem. Before the device is actually unregistered and freed by
device_unregister(), could lock_store() acquire the rwsem, look up the dying
tsm_dev via find_tsm_dev(), and attach it to a PCI device?

This seems like it could lead to a use-after-free when the TSM memory is fr=
eed
shortly after.

> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +

[ ... ]

> +static ssize_t unlock_store(struct device *dev, struct device_attribute =
*attr,
> +			  const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +

[Severity: High]
Does unlock_store() need to verify that pdev->tsm is a devsec context before
proceeding?

A PCI device can hold only one TSM context at a time, but if it has both
capabilities, both sets of sysfs attributes are visible. If a user writes to
unlock when the device has a link context, pci_tsm_unlock() executes and
dereferences ops->unlock(). Since link TSMs do not implement unlock, this
pointer is NULL, potentially causing a kernel panic.

Similarly, does the existing disconnect_store() verify if the context is a
link context? If disconnect is written to when the device has a devsec
context, __pci_tsm_disconnect() attempts to cast via to_pci_tsm_pf0(),
receiving NULL, and then dereferences it via guard(mutex)(&tsm_pf0->lock).

> +	tsm_dev =3D pdev->tsm->tsm_dev;
> +	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
> +		return -EINVAL;
> +
> +	ACQUIRE(device_intr, dev_lock)(&pdev->dev);
> +	if ((rc =3D ACQUIRE_ERR(device_intr, &dev_lock)))
> +		return rc;
> +
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	pci_tsm_unlock(pdev);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(unlock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D10
