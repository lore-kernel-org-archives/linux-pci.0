Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C525B094
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802858; cv=none; b=LwggL9WdkuGGMtjGw3gFsydflZGVNySqfXqxXjcTWzdd+MVmp84gVCFJFfQZqUx9H15/CvyaagKz+WBYl/6D1CwyhzN2CsaZJxcptWXHfest0khoyHUX/F9iR3/YPQfmyx01vaH4zmY8e8EIkpi4VM9f6JBOvBclKmFYzM8MU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802858; c=relaxed/simple;
	bh=p0iMVr5QVckOlPgRzh0RiVMNdLhdT7gcmOI8WZD6zHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kDVCiQWd4fIETgFfcYWV0eiixGYVe3/WvFz1EdnhlLeXLCe6uNk/azhBgHib4mWKLjTWI6xjL79Q8XQ3g/88WeqE3AP6K6h7b72s48uKcYqVzFZfPkOW9rZNha054oTKajTDkOMnNs9HBH7LSlnB5FSl3j7R/gmUpgEoq4FQEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LliiaeRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LliiaeRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D992C2BCB3;
	Thu, 14 May 2026 23:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778802858;
	bh=p0iMVr5QVckOlPgRzh0RiVMNdLhdT7gcmOI8WZD6zHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LliiaeRSm1KjfjjYKvPw3d/aphrUirbG0GpUyg7dNAfK9QJfMW0D+rMO7T0IA1tZT
	 MzTeSgpxSwXueypGM2+PjHF6BWPulUuLRgwtAoScJM2/AVGs4u3gltSVd/yTGDJiR0
	 7/L2dt4ON2HWBRu89uHk4rBTjgu9fYpuFXorUhmO7dTUibh6DavBJgUWrQ7LYpSyAQ
	 5IVlW5rPO/mIkFESf2aGvYkUzZX4u+oSyWtWEHK9bmcVUYb92JIPn6qlFYn4ilO5yw
	 ENReiwD6kucraoG+DwSoRePkzmqRyOo7rSUHjgvyqEcbqecPrYXbkKhiVXPIfRwSaA
	 s7vprH/yNUKZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 6/7] vfio/pci: Add a reset_done callback for
 vfio-pci driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514180059.1553-7-alifm@linux.ibm.com>
References: <20260514180059.1553-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 23:54:16 +0000
Message-Id: <20260514235417.7D992C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Concurrent execution of `vfio_pci_core_aer_reset_done` and `vf=
io_pci_core_disable` causes a Use-After-Free and data race on saved state.
- [High] UAPI breakage and runtime state corruption due to `reset_done` unc=
onditionally restoring initialization state.
- [Medium] The error return value of `pci_load_saved_state()` is ignored, l=
eading to potentially corrupted state restoration.
--

commit 50de5d9e39c609551f40181c5b1916513f9d200a
Author: Farhan Ali <alifm@linux.ibm.com>

vfio/pci: Add a reset_done callback for vfio-pci driver

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
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

Since pci_error_handlers->reset_done can be invoked by the PCI core at the
end of any device reset, including those initiated by userspace via the
VFIO_DEVICE_RESET ioctl, could this unconditionally overwrite the runtime
userspace configurations with the initial host state?

> +	if (!vdev->pci_saved_state)
> +		return;

Is there a potential use-after-free race on vdev->pci_saved_state here if a
user concurrently closes the VFIO file descriptor?

In vfio_pci_core_disable(), vdev->pci_saved_state can be freed via
pci_load_and_free_saved_state() before acquiring the PCI device lock. Since
this callback does not synchronize with the VFIO teardown path, could the
AER thread see vdev->pci_saved_state as valid, but then pass a dangling
pointer to pci_load_saved_state() after it is freed?

> +
> +	pci_load_saved_state(pdev, vdev->pci_saved_state);

Should the return value of pci_load_saved_state() be checked here?

If it returns an error due to mismatched capability sizes, the partial
memcpy into pdev->saved_config_space is kept. Proceeding to call
pci_restore_state() might then push an inconsistent state to the hardware.

> +	pci_restore_state(pdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514180059.1553=
-1-alifm@linux.ibm.com?part=3D6
