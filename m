Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756335AC01
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273214; cv=none; b=bYleiRxDOx0wyDJ84riDDpcV7GcGE5pjA+xZiz7/50vOTvgjp5OdwBvRZsbhyNzhay4JfBU3+xl7L15Kkm9W8v/RhtebTPEFlpRyoyL2qvxKIy0sz4Jb1nKK90lzOsu37bQM0YCM62dclF2I1wRFBmm6lunq5AsMSgT5R9Db8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273214; c=relaxed/simple;
	bh=SwGiKEfKroqIggk9fVheRXzU+cSwwRWydHc5j+s/kCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CWYiPWSpcJtMYIy6KFKXeYecXCATZg8l1I4t4aWM6Sb6cFca+p9LrOiKEYfGkeHo1lTHb1A23vI1Ry+slMXWG4NO4RZ1uOOsCOo6f4EfVsJ/lbjl1xiDw739zb2lq35cj3Sk1mawc6w3U6iwKjjIkxr2PLCxtTmSFxBIvF+KG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6BbsElJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6BbsElJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A71C2BCF4;
	Fri,  8 May 2026 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273213;
	bh=SwGiKEfKroqIggk9fVheRXzU+cSwwRWydHc5j+s/kCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=E6BbsElJSsC8v3Agg3KTgrMbntHjhror5HYFkXY5zoxe+dwv8VGFsJMI3TXXPNd9N
	 CgyYLHClJpY7/g3OicqMf+cwRDJcEvN/URx492771Axl0KwkBYONQ+Br3NcNmDXMdi
	 IxIfYXle77AaRVpU7r6XMFB3/NSgB5Or2ZWsPSGKPp6eCrPhXgMopARrGnFeKFvjoa
	 qsUHxWbMQVmRQz7CGil9/6ENDLM/Jk5GSqznJ5RjCSSx/8Y6rAPk+xCKdmfuau2lGu
	 AYNCdO79uQmhqN4IVYzfJT/HQprInkR+mGsC0FAizg8/1lNTtgPG724Q4t6haaQ3A1
	 2Oq4WVthj+42A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/7] vfio/pci: Add PCIe TPH enable/disable support
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508064053.37529-6-fengchengwen@huawei.com>
References: <20260508064053.37529-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:46:52 +0000
Message-Id: <20260508204652.F0A71C2BCF4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] TPH operations access the device's PCI configuration space without=
 ensuring the device is in the D0 power state, risking accesses while suspe=
nded (D3).
- [High] `vdev->igate` is insufficient to prevent bitfield tearing on `pdev=
->tph_enabled` against other PCI subsystems.
--

commit e6a89cf03d6c51144466205cce4a3bf38731b5db
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH enable/disable support

This patch adds support for enabling and disabling the TPH function via
mode selection. It also disables TPH when ownership is taken or when
userspace closes the device FD.

> Serialize all TPH operations under vdev->igate mutex using scope-based
> automatic locking to prevent hardware control and bitfield races.

If pdev->tph_enabled is a bitfield inside struct pci_dev that shares a
memory word with other core PCI bitfields (like state_saved or
is_busmaster), will vdev->igate prevent bitfield tearing?

Since other kernel subsystems modify these neighboring bitfields without
holding the VFIO-private igate mutex (such as the PCI PM core modifying
state_saved during runtime suspend), concurrent updates could result in
data races and lost state updates.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 0e97b128fd637..bfc7e87d190f4 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -738,6 +738,9 @@ void vfio_pci_core_close_device(struct vfio_device *c=
ore_vdev)
>  #endif
>  	vfio_pci_dma_buf_cleanup(vdev);
> =20
> +	/* Disable TPH when userspace closes the device FD */
> +	pcie_disable_tph(vdev->pdev);
> +
>  	vfio_pci_core_disable(vdev);

Is it safe to access the device's PCI configuration space here?

Since vfio_pci_core_disable() is explicitly responsible for waking up the
device via pm_runtime_resume(), pcie_disable_tph() is being called before
the device is ensured to be in the D0 power state.=20

Accessing the config space of a suspended device could cause PCIe errors
like Unsupported Requests.

[ ... ]

>  	switch (op.op) {
>  	case VFIO_PCI_TPH_GET_CAP:
>  		return vfio_pci_tph_get_cap(vdev, &op, uarg + minsz);
> +	case VFIO_PCI_TPH_ENABLE:
> +		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
> +	case VFIO_PCI_TPH_DISABLE:
> +		return vfio_pci_tph_disable(vdev);

Are these TPH capability accesses safe without a pm_runtime_resume_and_get()
and pm_runtime_put() wrapper?

Userspace could potentially access the config space while the device is idle
and runtime suspended.

[ ... ]

> @@ -2257,6 +2302,9 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
>  	if (!disable_idle_d3)
>  		pm_runtime_put(dev);
> =20
> +	/* Disable TPH when taking over ownership of the device */
> +	pcie_disable_tph(pdev);
> +

Could this pcie_disable_tph() execute while the device is suspending?

It is called after pm_runtime_put(), meaning the PM core may have already
started asynchronously suspending the device, potentially leading to config
space accesses while the device is in D3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508064053.3752=
9-1-fengchengwen@huawei.com?part=3D5
