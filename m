Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E0399352
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185093; cv=none; b=Bk3BKx5TdLIKXlOK7th36fBdXXdqXOA7xb+6KuEhpI82uzd5hoqpjAT+k3p3zAwXBmGr3VFRNZeqeH1kIzrmN9Hw1KHNaEz8RCYJLnVrDytNnDIk1FUZITpSyF8TZ38n7XFxWIrjK5OplDaR1RIa5q0Y0MTioUU6keQTiWOA5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185093; c=relaxed/simple;
	bh=PV8TiI+ZqnhWDjeyekJKoYzpujlrMaypXERewLDxWE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OQNuG6uNnbuZwST9PM7XQka5zaMnRL6nLadDc++0WcR9AJXwZmnmCwgVnrjjeXBqih9+F/iDK3lyJOSLgg0Ls+DoRmSFdNwy2r1BVXWi/QInE34L2Kl5DEC6PJQ8IrXXDy3tAH/kD3rlIgFglEuvhBfvD4wEVD0brrMsfEXzyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4IeOdva; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4IeOdva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96967C2BCC6;
	Tue, 19 May 2026 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779185092;
	bh=PV8TiI+ZqnhWDjeyekJKoYzpujlrMaypXERewLDxWE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X4IeOdvaYiAj/s7fQBI5lLWuFFRGpG5v7m5u6oue24OHt75QENaVtUHLBYqJ3Nm4d
	 QWrgqQUzOLm4oHIYbTp35/3CjqTEIy5O65oiZ+1+8HExJbs0gLvdpYle4t2dIGv3/O
	 qFn1Qe/SCzdkiacqfndV/e7NJ0oThNIaLwYwWS5fp2t6oKCz1rBMck6PFjVi49wthb
	 t651zbABhL5nLILvN45B/KPmoeAOv+M6MQ3PDjUPMlkHLj47qtPfXorJXGYKlBTEfa
	 yPh4FN6zAeVDHARO51eGWEn3p0F9Dr9UWHC27Rk2dq1QnE/928AUB96Mm/495h9RKY
	 B/XWABr6+sznw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] power: sequencing: pcie-m2: Create serdev for
 PCI devices present before probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519-pwrseq-m2-bt-v3-4-b39dc2ae3966@oss.qualcomm.com>
References: <20260519-pwrseq-m2-bt-v3-4-b39dc2ae3966@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 10:04:52 +0000
Message-Id: <20260519100452.96967C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Leaked serdev_controller reference on early exit in pwrseq_pcie_m2=
_create_serdev_one()
- [High] Mixing goto-based error handling with scope-based cleanups (__free=
 and scoped_guard) in the same function
--

commit f9e3f8cd7dae54d53f6be50d3fa50b1da0d87fe2
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

power: sequencing: pcie-m2: Create serdev for PCI devices present before pr=
obe

This commit adds support for creating serdevs for PCI devices that are
already present before the driver completes its probe phase. It complements
the existing notifier-based hotplug support to handle existing devices.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 038271207a27e..8164c44289775 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
[ ... ]
> @@ -259,6 +259,14 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrse=
q_pcie_m2_ctx *ctx,
>  		return 0;
>  	}
> =20
> +	/* Bail out if the serdev device was already created for the PCI dev */
> +	scoped_guard(mutex, &ctx->list_lock) {
> +		list_for_each_entry(pci_dev, &ctx->pci_devices, list) {
> +			if (pci_dev->pdev =3D=3D pdev)
> +				return 0;
> +		}
> +	}
> +

Earlier in this function, of_find_serdev_controller_by_node() acquires a
reference to the serdev controller. If the device is found in the list,
the code returns 0 directly from within the scoped_guard block.

Does this early return leak the serdev controller reference by bypassing
the required serdev_controller_put() call at the end of the function?

Additionally, include/linux/cleanup.h notes that mixing goto and cleanup
helpers like guard() in the same function is not expected. This function
still relies on multiple goto labels (e.g., err_put_ctrl, err_free_pci_dev)
for error handling. Could this function be converted fully to scope-based
cleanups to avoid potential LIFO ordering issues?

[ ... ]
> @@ -408,18 +416,56 @@ static int pwrseq_pcie_m2_register_notifier(struct =
pwrseq_pcie_m2_ctx *ctx, stru
[ ... ]
> +static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx)
> +{
> +	struct pci_dev *pdev =3D NULL;
> +	int ret;
> +
> +	if (!pwrseq_pcie_m2_check_remote_node(ctx->dev, 3, 0, "serial") ||
> +	    !pwrseq_pcie_m2_check_remote_node(ctx->dev, 0, 0, "pcie"))
> +		return 0;
> +
> +	struct device_node *pci_parent __free(device_node) =3D
> +				of_graph_get_remote_node(dev_of_node(ctx->dev), 0, 0);
> +	if (!pci_parent)
> +		return 0;
> +
> +	/* Create serdev for existing PCI devices if required */
> +	for_each_pci_dev(pdev) {
> +		if (!pdev->dev.parent || pci_parent !=3D pdev->dev.parent->of_node)
> +			continue;
> +
> +		if (!pci_match_id(pwrseq_m2_pci_ids, pdev))
> +			continue;
> +
> +		ret =3D pwrseq_pcie_m2_create_serdev_one(ctx, pdev);
> +		if (ret) {
> +			dev_err_probe(ctx->dev, ret,
> +				      "Failed to create serdev for PCI device (%s)\n",
> +				      pci_name(pdev));
> +			pci_dev_put(pdev);
> +			goto err_remove_serdev;
> +		}
>  	}
> =20
>  	return 0;
> +
> +err_remove_serdev:
> +	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
> +
> +	return ret;
>  }

Similar to the concern above, this newly introduced function declares
pci_parent using __free(device_node) but also uses goto-based error
handling with the err_remove_serdev label.

Does this mix of goto and __free() violate the subsystem guidelines
recommending against combining both cleanup styles in the same function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-pwrseq-m2-=
bt-v3-0-b39dc2ae3966@oss.qualcomm.com?part=3D4
