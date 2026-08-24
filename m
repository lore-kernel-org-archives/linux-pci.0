Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1163346BE;
	Mon, 24 Aug 2026 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613565; cv=none; b=f25mif39pMv9hXEPWBe9/Af5bSHBQuj4LBjts6rW9P5vE0Xbm8NzhicqaiwdXbWz39eZBiQxm0K/2XXHWTXCojhkafLaWDtBv9rorWD38lBJyjothkJ1ndwPInOWijcA86FjV8mctObkYBHNZLsPbT8Y5oMxSuxTwe7YUasM6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613565; c=relaxed/simple;
	bh=3KjR2pnJKugy1vij2/6NhaTAOdF6GBncJrWt9nGWOS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=igJhVuKSdfpVWCnyWXjvYt0LLLFmnVgr30pZ2JDkepOMW4LXOTY9Va9ssFwmVcCXtrbSIXMjgesjpFJbcpYxjkUas4jNXUHixpcWCTQjyEo+gWy25mJjgZao/e1KXmg9tGP04wqxn7f1CZt/Vs7zIglTcD8iHjawy6EvhtwDlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBX0LjKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBX0LjKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D288A1F000E9;
	Mon, 24 Aug 2026 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787613564;
	bh=9lkrD2Qn/Ma5Q21jSH5885FWqE7FNgym9z+w/Qd9ljM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBX0LjKu1KEHdNJMLMm1qnHnRHSqkR6I60FqXfOavMyB1mHfNwyIKUh3eHgDDNbgv
	 M+3SpXD35PilmKxD5KqyzooluySkMbYf9YvSJOWnELDI/0JOAvQzgOcJvzrhGnek9m
	 H2qpDNLJIErMeDplTiEMz5+BovK1UD+cW4JRdLYjltSVzDRS0eORH+qPxQeJDULGDw
	 oM3p2la/hmOoHswel4DDW+teaNLEba9RGGfhlasI0bqXurc3oIi6SpA234yFDYY2P0
	 5oB24J93vUd+/lIuPIrlTyiuI5/FpV3zNIkzYhJiyLa4pdzlKLLIxXfuo0JDXTw6Qe
	 IIVpsIaLcOh2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: fix endpoint init error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260824230427.3649829-1-hanzhijian1991@gmail.com>
References: <20260824230427.3649829-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 23:19:23 +0000
Message-Id: <20260824231923.D288A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Manual hardware power-off races with devres unregistration, riskin=
g a synchronous external abort.

Pre-existing issues:
- [High] A preexisting error path bug causes dw_pcie_edma_remove() to be ca=
lled twice when dw_pcie_ep_init_registers() fails.
--

--- Patch [1]: [PATCH] PCI: imx6: fix endpoint init error handling ---
commit 4bb2b4d6db6396f6e99b53eb9afa966615f05042
Author: Zhijian Han <hanzhijian1991@gmail.com>

PCI: imx6: fix endpoint init error handling

imx_add_pcie_ep() ignores the return value of imx_pcie_host_init(), so
a failure to enable the clocks, regulators, or PHY during endpoint
initialization goes unnoticed and the driver proceeds to initialize the
endpoint against unpowered hardware.

Link: https://lore.kernel.org/all/20260824152857.DB9771F00A3D@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..1dad93e9dd97c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
[ ... ]
> @@ -1654,12 +1657,16 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_p=
cie,
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
>  		dw_pcie_ep_deinit(ep);

[Severity: High]
This is a pre-existing issue, but won't this trigger a double-free on the
error path?

If dw_pcie_ep_init_registers() fails, it cleans up EDMA internally:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_init_registers()=
 {
    ...
err_remove_edma:
    dw_pcie_edma_remove(pci);
    return ret;
}

Then this caller in imx_add_pcie_ep() unconditionally calls
dw_pcie_ep_deinit(), which eventually calls dw_pcie_ep_cleanup() and tries =
to
remove EDMA again:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_cleanup() {
    ...
    dw_pcie_edma_remove(pci);
}

Since dw_edma_remove() in drivers/dma/dw-edma/dw-edma-core.c does not nulli=
fy
internal pointers after freeing resources, will executing it twice lead to =
list
corruption and kernel panics?

> -		return ret;
> +		goto err_host_exit;
>  	}
> =20
>  	pci_epc_init_notify(ep->epc);
> =20
>  	return 0;
> +
> +err_host_exit:
> +	imx_pcie_host_exit(pp);

[Severity: High]
Can calling imx_pcie_host_exit() directly here cause a synchronous external
abort?

By invoking this function on the error path, clocks and power are severed
while the EPC device might still be registered in sysfs via devres. If
userspace accesses the device while the hardware is powered off, it could
crash.

Should this cleanup be deferred via devm_add_action_or_reset() instead, to
ensure devres handles unregistration before the power and clocks are remove=
d?

> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824230427.3649=
829-1-hanzhijian1991@gmail.com?part=3D1
