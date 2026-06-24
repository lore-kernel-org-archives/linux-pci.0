Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D11A9FB0
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309118; cv=none; b=KyXbOaQhfiY9nLgS8KW5eI58mpw0GsGlgS82TjEPArXB/6+qOALP+t/u4BdomB64xk1+Pn87rxnoQG3CwGYUS6E7ngAiL/g6loI8jOj1OszlbChdLH/VTNpMmuJw9EhuFXwvvNvQDSOKb5j4at4XQDs6eCJUxMTK402hqZJskKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309118; c=relaxed/simple;
	bh=fZatyOLzotfEFoUNGr0bCA0EyxIqXiNKbIvuchgDnzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H19ux5ngphGTiCyEUDw0k/mbkn6lIEExEswF6hhyOGDE/I5HHTv1DZKZCzdBIFkbGXx701VTOhlA9cBnfdxyNNgdyk6x6XpJYADoZtpNEDphJJkQ56WQE+I6ru4axzS3FBdbAQU2/oB33GrpU3kLLNiR+iFyBZsoePgt60HTcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvtYtSlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvtYtSlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9994A1F000E9;
	Wed, 24 Jun 2026 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782309116;
	bh=M40qyvlvueG6/iUPT4kAKS3wINE86Js7pzp9dQMm9rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvtYtSlOTascaCvj/gHRaJGmcwdWz9QR+rp9xuny1x+w88e4Z6tnDE57GpQ0v519I
	 0rYBUJDyrgGDweMb7WZ7uH91wgr5by6ztW/t8P4HIxJdrQPcsgFnVGnOj72sUYF+9W
	 SJkdHKJDwieVSMz2zIFZWVx9VHH+nQ9YCrN0vCz+/7Sy/0gd0Vw2cgviM5j9yMyr8C
	 1z/CUhaUnzSILi1KXA22Kx+DmOx9e80+FKaWzag6XAy2NBy0nuVBDL/ftxcTWqf+x1
	 Pd1zbBlQWC+K3eMc+/arWeEK0pxm/nrAfQvUEtKrQ1FhWTvdA93E36oYyycDLbluKB
	 /NufCBZfR1QRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: qcom-ep: Fix runtime PM reference leak in probe
 error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260624133643.42323-1-vulab@iscas.ac.cn>
References: <20260624133643.42323-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:51:56 +0000
Message-Id: <20260624135156.9994A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calling `pm_runtime_disable(dev)` manually after `devm_pm_runtime_=
enable()` fails causes a double-disable, permanently breaking runtime PM fo=
r this device.

Pre-existing issues:
- [High] Using asynchronous `pm_runtime_put()` in the driver teardown path =
races with devres `pm_runtime_disable()`, potentially leaving the device po=
wered on.
- [High] The debugfs interface reads MMIO registers without waking the devi=
ce, leading to a kernel crash if the device is suspended.
- [High] The `global_irq` handler can run before clocks are enabled or when=
 the device is suspended, causing an unclocked register read that crashes t=
he system.
--

commit 61050efde191b200f1eb5274e15779ff5c0d30ba
Author: Wentao Liang <vulab@iscas.ac.cn>
Subject: PCI: qcom-ep: Fix runtime PM reference leak in probe error paths

This commit addresses a runtime PM usage counter leak in the probe error
paths. It uses pm_runtime_put_noidle() and pm_runtime_disable() for early
failures, and pm_runtime_put_sync() for later failures to drop the
reference.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -892,16 +892,16 @@ static int qcom_pcie_ep_probe(struct platform_devic=
e *pdev)
>  	pm_runtime_set_active(dev);
>  	ret =3D devm_pm_runtime_enable(dev);
>  	if (ret)
> -		return ret;
> +		goto err_manual_cleanup;
> =20
>  	ret =3D qcom_pcie_ep_get_resources(pdev, pcie_ep);
>  	if (ret)
> -		return ret;
> +		goto err_put_ref;
> =20
>  	ret =3D dw_pcie_ep_init(&pcie_ep->pci.ep);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
> -		return ret;
> +		goto err_put_ref;
>  	}
> =20
>  	ret =3D qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);

[Severity: High]
This is a pre-existing issue, but global_irq is requested and automatically
enabled before clocks are ready.

In qcom_pcie_ep_enable_irq_resources():
    ret =3D devm_request_threaded_irq(&pdev->dev, pcie_ep->global_irq, NULL,
                                    qcom_pcie_ep_global_irq_thread,
                                    IRQF_ONESHOT,
                                    name, pcie_ep);

If the global_irq is pending from a previous boot or triggers spuriously,
qcom_pcie_ep_global_irq_thread() will run and immediately call
readl_relaxed() on the PARF_INT_ALL_STATUS register.

Since the device's PCIe clocks have not been enabled at this point, could
this cause an unclocked register read and crash the system?

> @@ -915,10 +915,8 @@ static int qcom_pcie_ep_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	ret =3D pm_runtime_put_sync(dev);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_err(dev, "Failed to suspend device: %d\n", ret);
> -		goto err_disable_irqs;
> -	}
> =20
>  	pcie_ep->debugfs =3D debugfs_create_dir(name, NULL);
>  	qcom_pcie_ep_init_debugfs(pcie_ep);

[Severity: High]
This isn't a bug introduced by this patch, but the debugfs interface reads
MMIO registers without waking the device.

In qcom_pcie_ep_link_transition_count():
    seq_printf(s, "L0s transition count: %u\n",
               readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_PM_LINKST_IN_L0=
S));

If a user reads this file while the endpoint is suspended, could this
unclocked register access trigger a synchronous external abort?

> @@ -932,6 +930,13 @@ static int qcom_pcie_ep_probe(struct platform_device=
 *pdev)
>  err_ep_deinit:
>  	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
> =20
> +err_put_ref:
> +	pm_runtime_put_sync(dev);
> +	return ret;
> +
> +err_manual_cleanup:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);

[Severity: High]
If devm_pm_runtime_enable() fails, it executes its cleanup action and
calls pm_runtime_disable() internally.

Does jumping to err_manual_cleanup and calling pm_runtime_disable() a
second time increment dev->power.disable_depth twice, leaving it unbalanced
and permanently breaking runtime PM for this device?

>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but using an asynchronous pm_runtime_put() in
the driver teardown path races with devres pm_runtime_disable().

In qcom_pcie_ep_remove(), the driver cleans up by calling
qcom_pcie_disable_resources(), which invokes:
    pm_runtime_put(dev);

After remove() returns, the devres cleanup executes pm_runtime_disable()
which forces cancellation of pending async idle/suspend work.

Can this abort the asynchronous suspend, leaving the device's PM domain
powered on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624133643.4232=
3-1-vulab@iscas.ac.cn?part=3D1
