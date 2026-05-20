Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492B35AC0C
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309653; cv=none; b=SdI5ljqjGEFFdLlmiOrXAJHSDxFAIKlt6VgdBCipaT3pjNy8OrZAc+0JPMH4kl8LZdtk+HjJP/ZpPDnFSb3Rp01hwslmm9x4XrwXFmR+bb4aiHcz1M2QsmADTY1TDgBkiYdt4xIDRS+Xgq3Rufl7Imsz4MAa9p/Kj7rW8FcaTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309653; c=relaxed/simple;
	bh=GQ9lD4Z8COIVohiZyqddpFVD8t2ZI7KUX7W5ypxCo6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QdD1pbk5uygJDL1h1pnXC3ZoqMugEQ0W2pOOr9JsQsJJr2N4yxUmGRbO2yzGLpRVNbyqSJ9+Y63e+XSFuDFI5ZIJb4PSmsm6QWRedD59kRXGDhQ7RRo0383ZSQg2tW2XD8gSzYmvBrTZk/pF68ozzX1Bx3O5hILU+YGxm0MUO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCqObgbm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCqObgbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB9E1F000E9;
	Wed, 20 May 2026 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779309651;
	bh=jtvN79ozd4DMfw5Ov9rGq4dcPQpE+Kvf4WS+WgmtCSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCqObgbmcV64uVChFONEh2sWCXFhoJBVIth29kuoA6zUg0vS1vSXzjHA2s8wkElFC
	 gcVOOu0kB8TKjUfn/1MdHidjO//LntMxZGb+0mtwsK/yr6g5k8bqELP5ehkBGJVChd
	 SZF3wa2BpZRSNmuo0EREQjcL591dsYJtBBGHWUrHBnlEumnpPGaV3EHK5J3xlMoUJt
	 VcobJAmHFnlfpXkCuTZcoEvz/jLCas/w782siVH8MCRJDb0LsVgtZ1Lv6ZOY2li8nP
	 knVKuQRveTLfgAxErU4WJkDKl7Cwq7/GhHjYdgzgITC0H/wE5icHlZb4nEZAfK1u0u
	 HeL5fYj0zT2wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 6/7] vfio/pci: Add a reset_done callback for
 vfio-pci driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260520171113.1111-7-alifm@linux.ibm.com>
References: <20260520171113.1111-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 20:40:51 +0000
Message-Id: <20260520204051.BAB9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Use-After-Free (UAF) due to lockless Time-of-Check to Time-of-=
Use (TOCTOU) race on vdev->pci_saved_state
- [High] Hardware state modification via pci_restore_state() without acquir=
ing vdev->memory_lock
- [Medium] Missing error check on pci_load_saved_state() leads to potential=
 data corruption
--

commit 23e4483480775e0803e490cec805fe1688f9a753
Author: Farhan Ali <alifm@linux.ibm.com>

vfio/pci: Add a reset_done callback for vfio-pci driver

This commit adds a reset_done callback to the vfio-pci driver's error
handlers to restore the PCI device state to its initial saved state upon
error recovery.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index f47a49ca67fae..6358b59fab2b1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -2255,6 +2255,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(st=
ruct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
> =20
> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
> +
> +	if (!vdev->pci_saved_state)

[Severity: Critical]
Is there a race condition here if userspace closes the VFIO device file
descriptor concurrently?

This callback checks vdev->pci_saved_state without holding any VFIO-specific
locks. If vfio_pci_core_disable() is called concurrently, it can free the
state using pci_load_and_free_saved_state(&vdev->pci_saved_state).

If the memory is freed right after this check passes, will
pci_load_saved_state() dereference a freed pointer?

> +		return;
> +
> +	pci_load_saved_state(pdev, vdev->pci_saved_state);

[Severity: Medium]
Should we check the return value of pci_load_saved_state() here?

If the saved PCI capabilities do not match the current hardware capabilitie=
s,
pci_load_saved_state() can fail and return a negative error code like
-EINVAL.

When this fails, it sets pdev->state_saved =3D false and leaves
pdev->saved_config_space and pdev->saved_cap_space in an incomplete or
partially updated state. Since this code unconditionally calls
pci_restore_state() next, could it restore a corrupted or incomplete
configuration state to the physical hardware device?

> +	pci_restore_state(pdev);

[Severity: High]
Does this hardware state modification require vdev->memory_lock?

pci_restore_state() modifies fundamental hardware state like the PCI COMMAND
register and BARs. In the vfio-pci driver, operations that modify or reset
the device's memory decode bits typically require the vdev->memory_lock
read-write semaphore to protect against concurrent userspace memory-mapped =
I/O
faults and configuration accesses.

Because this lock is not held, can concurrent userspace accesses interleave
with the hardware state restoration, potentially leading to memory corrupti=
on
or unisolated memory access?

However, simply adding down_write(&vdev->memory_lock) here might cause a
recursive deadlock during VFIO_DEVICE_RESET, which already holds memory_lock
before triggering the reset sequence that calls this callback. Is there a w=
ay
to safely serialize this hardware state modification?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520171113.1111=
-1-alifm@linux.ibm.com?part=3D6
