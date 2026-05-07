Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88D2D7DC6
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198092; cv=none; b=W9LwuKN+YinVFxEZgKnJ66SPpBjiuf2aoA/iejcc6fMKnfiut639BLFhlzV8QzDMwrUFJSP4z3rJKm4JMNJq0ivgBdwKP+Ca/WELJEZBUuOlxQEHr52O95SA/GLzjQ62qrJtpv6nIysHbuaN5o+JpXy/1ObxWQwl5IiF1aad0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198092; c=relaxed/simple;
	bh=dtOKTYYJ9j88H2/nOddlp1kMeMLnsK3AFr3cPg0d+mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=toOGyU0KWyR5okMTIqkgvMaWtf6i3kwscOoMmstuVXtGkkwkDeeTHwAJy+B7qsI2um5t5ZDpZUkhAME28i690qsr8xT3hNmvKVpQNzqUr+RnzPQw4FqVneVUD4gqNmp1ryrrIFcnQaYWzenA72DNCwTvxFnu5ohIeFuMsjODHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8vzjxSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8vzjxSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C62C2BCB2;
	Thu,  7 May 2026 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778198092;
	bh=dtOKTYYJ9j88H2/nOddlp1kMeMLnsK3AFr3cPg0d+mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=l8vzjxSyBbWSpxCFAJArnhMCK8t2ipyk+iI+XKwoop1BwaNf9ocq/T5ZYJMSKOxR+
	 Ude2kqu7OZkyuQ3qf7jGgU2cl+PbpWQWS6AVr3cLV0d4F41YYlDvxF93LXW/rP30nx
	 3yUPFzlR7FiLYkReMAItBOUlD30R4QdWmBneppM8WsypoE5FZqk4tHOIDyf0V5wj82
	 iWTvrYTmpcQiKiF9w67X5iIMyazLA3cSl0+4ilpikD6uD/mcebShEyB/+npbfwjmn1
	 5ApwwpED3Uw5velPcCzVPgQ86WoupGvfeXc6CdqfHcjnn0a6P6mZrihZABWNk99/Zy
	 ufX4VuIgodaXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] power: sequencing: pcie-m2: Create serdev for
 PCI devices present before probe
Reply-To: sashiko@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507-pwrseq-m2-bt-v2-4-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-4-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:54:51 +0000
Message-Id: <20260507235452.10C62C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Reference leak of 'serdev_ctrl' on early return in '__pwrseq_pcie_=
m2_create_serdev()'.
- [High] Potential NULL pointer dereference in 'pwrseq_pcie_m2_notify()' wh=
en accessing 'pdev->dev.parent->of_node'.
- [Medium] Subsystem guidelines violation: mixing 'goto' error handling wit=
h '__free()' cleanup helpers.
--

commit 1d901a33bb02968191e0403afce66cf3ae8ed0f3
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

power: sequencing: pcie-m2: Create serdev for PCI devices present before pr=
obe

This commit adds support to create serdev devices for PCI devices that
are already present before the driver's probe function registers the
PCI notifier.

> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -236,7 +236,7 @@ static int pwrseq_pcie_m2_create_bt_node(struct pwrse=
q_pcie_m2_ctx *ctx,
>  	return ret;
>  }
> =20
> -static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx,
> +static int __pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx,
>  					struct pci_dev *pdev)
>  {
>  	struct serdev_controller *serdev_ctrl;
[ ... ]
>  	/* Bail out if the device was already attached to this controller */
>  	if (serdev_ctrl->serdev) {
>  		serdev_controller_put(serdev_ctrl);
>  		return 0;
>  	}
> =20
> +	/* Bail out if the serdev device was already created for the PCI dev */
> +	mutex_lock(&ctx->list_lock);
> +	list_for_each_entry(pci_dev, &ctx->pci_devices, list) {
> +		if (pci_dev->pdev =3D=3D pdev) {
> +			mutex_unlock(&ctx->list_lock);
> +			return 0;

Does this early return path leak the reference to serdev_ctrl?

The of_find_serdev_controller_by_node() call earlier in the function acquir=
es
a reference, and the previous bailout path correctly calls
serdev_controller_put(serdev_ctrl), but this new path appears to return
without releasing the reference.

Also, looking at the rest of __pwrseq_pcie_m2_create_serdev() in the source,
it declares serdev_parent using the __free(device_node) macro while also
using goto labels for error paths like err_put_ctrl. Does this mix of goto
and __free() cleanup helpers violate the subsystem guidelines?

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

It is good to see the defensive !pdev->dev.parent check here to prevent a
null pointer dereference.

However, the existing pwrseq_pcie_m2_notify() function performs a similar
check without validating the parent:

	if (!pci_parent || (pci_parent !=3D pdev->dev.parent->of_node))

Could a PCI device without a parent triggering a BUS_NOTIFY_ADD_DEVICE
event cause a crash in pwrseq_pcie_m2_notify() because it is missing the
same defensive check?

[ ... ]
> +		ret =3D __pwrseq_pcie_m2_create_serdev(ctx, pdev);
> +		if (ret) {
> +			dev_err_probe(ctx->dev, ret,
> +				      "Failed to create serdev for PCI device (%s)\n",
> +				      pci_name(pdev));
> +			pci_dev_put(pdev);
> +			goto err_remove_serdev;
>  		}
>  	}
> =20
>  	return 0;
> +
> +err_remove_serdev:
> +	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
> +
> +	return ret;
>  }

Similar to the function above, this newly added function mixes the
__free(device_node) cleanup helper for pci_parent with the err_remove_serdev
goto label. Should all resources here be converted to scope-based cleanup to
avoid ownership confusion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-pwrseq-m2-=
bt-v2-0-1740bd478539@oss.qualcomm.com?part=3D4
