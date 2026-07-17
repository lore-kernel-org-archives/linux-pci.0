Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98855390C81;
	Fri, 17 Jul 2026 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328202; cv=none; b=u/4IvLQ892/l4YyaXbnPomoUoUAdyf/oQ/DBHcL5wUqnKwTx4w82k/ra/iAG1RJIeH30HbwnRzgxrz+7nHdliQLxpRNOA42N7DtX9rx2BZzJ8HF5shhedL/+o/Tq4/8LWlrlCGog7WERFZTT3U+KOAetLRKjuIF6w6TfjEvKKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328202; c=relaxed/simple;
	bh=LP1cmgylChfLeH+hzSQjao/+HApzN4A6laF+6cHHqH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VTxEeQuNL1MSeOqXHMZ+96tFw2biBf3Ja4u70cVvsLr1bCQFaFkMqb4cwMUp3JWbguhfJ8I6q3GdcAD8OxIFvJy3jWofnrWMJ9M7u5MZV0MGXyPa0GzZ21ET95FaPNAlLwp22cgt7MqXd9PomLp4iWm1rexhfkgZG2KaEYXdbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6dGDCFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6dGDCFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB411F000E9;
	Fri, 17 Jul 2026 22:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328201;
	bh=fEeCHcvf19CXLglBDf4SYFTIKpPaaa0NRU+pT9kgz04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6dGDCFNoep7cf6w8Mz3gkYjuaEILFBikH2HRU/5pLTalNptL5L2SvgautAJsUKt5
	 qIpOVmTNIqy0X29SLPKfSWgCh+MkKglmR9hsXUrNH9VHJ6n9c0jUFwCgyWoHUccQ0Z
	 dUYdZvlTdistdFa9vOb3hntI9pTfm8MSKkdmp/mdeh5YBd4QlsmvIRgBotPhNat/KM
	 f27GSsysutDs2qj3UWQrYBKwRbpiz1UBgRyUVhlbDB43rVuZlGrDTTq3EyjHWGuvib
	 xaj+yyZBhz6f5GUauFULsy4D5KaiYNig+fGy81T1cTJQnmmN+rQ3e1jDAYYqJhGf7y
	 9wZXw0WvDJzpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-8-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:43:20 +0000
Message-Id: <20260717224321.1BB411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Removal of explicit PCI error handler forwarding for RCH devices l=
eaves RCDs bound after a fatal PCI error.

Pre-existing issues:
- [High] Preexisting lockless dereference of `dport` returned by `cxl_pci_f=
ind_port()` and `cxl_mem_find_port()` leading to Use-After-Free.
--

--- Patch [7]: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers -=
--
commit 6a99c70b18865d01d350aa367342e701ebe6dde2
Author: Terry Bowman <terry.bowman@amd.com>

PCI/CXL: Add RCH support to CXL handlers

Restricted CXL Host (RCH) error handling is folded into the new CXL Port
error handling flow. RCH protocol errors are forwarded through the AER-CXL
kfifo, and the manual CXL.mem error handler invocation is removed.

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capab=
ility_regs *aer_regs,
>  	return false;
>  }
> =20
> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  {
> -	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
>  	struct cxl_dport *dport;
>  	int severity;
> =20
> -	struct cxl_port *port __free(put_cxl_port) =3D
> -		cxl_pci_find_port(pdev, &dport);
> +	struct cxl_port *port __free(put_cxl_port) =3D cxl_pci_find_port(pdev, =
NULL);
>  	if (!port)
>  		return;
> =20
> +	guard(device)(&port->dev);
> +	dport =3D cxl_find_dport_by_dev(port, pdev->dev.parent);

[Severity: High]
This is a pre-existing issue, but while this change correctly closes a
lockless Use-After-Free window for dport here, does the same vulnerability
still exist in cxl_pci_setup_regs() and rcd_pcie_cap_emit()?

In cxl_pci_setup_regs(), cxl_rcrb_get_comp_regs() dereferences the dport
returned by cxl_pci_find_port() before any lock is taken.

Similarly, in rcd_pcie_cap_emit(), dport->regs.rcd_pcie_cap is dereferenced
entirely locklessly, and then the function takes guard(device)(root_dev)
instead of the required &root->dev lock.

Since rcd_pcie_cap_emit() is reachable via sysfs attributes, could an
unprivileged local user trigger a Use-After-Free by reading sysfs during a
concurrent device hot-unplug?

[ ... ]

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rc=
h.c
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  	return (pcie_ports_native || host->native_aer);
>  }
> =20
> +struct cxl_rch_error_ctx {
> +	struct aer_err_info *info;
> +	bool enqueued;
> +};
> +
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
> -	struct aer_err_info *info =3D (struct aer_err_info *)data;
> -	const struct pci_error_handlers *err_handler;
> +	struct cxl_rch_error_ctx *ctx =3D data;
> =20
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
> =20
> -	guard(device)(&dev->dev);
> -
> -	err_handler =3D dev->driver ? dev->driver->err_handler : NULL;
> -	if (!err_handler)
> -		return 0;
> -
> -	if (info->severity =3D=3D AER_CORRECTABLE) {
> -		if (err_handler->cor_error_detected)
> -			err_handler->cor_error_detected(dev);
> -	} else if (err_handler->error_detected) {
> -		if (info->severity =3D=3D AER_NONFATAL)
> -			err_handler->error_detected(dev, pci_channel_io_normal);
> -		else if (info->severity =3D=3D AER_FATAL)
> -			err_handler->error_detected(dev, pci_channel_io_frozen);
> -	}
> +	if (cxl_forward_error(dev, ctx->info))
> +		ctx->enqueued =3D true;

[Severity: High]
Does removing the explicit invocation of the err_handler leave RCDs bound
after a fatal PCI error?

The standard pcie_do_recovery() on an RCEC does not iterate over its
associated RC_END (RCD) devices, so this manual invocation used to handle t=
he
CXL.mem driver fallback. Now that errors are routed solely through the CXL
protocol error work queue (__cxl_proto_err_work_fn()), the work queue only
panics on uncorrectable cachemem errors.

Does the work queue replicate the PCI recovery state machine's fallback
behavior, such as calling device_release_driver() to unbind the CXL.mem
driver on frozen channel states?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D7
