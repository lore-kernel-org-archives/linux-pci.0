Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777B241CB7;
	Mon, 13 Jul 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910752; cv=none; b=J4t9HBZbvSWM8okFAsfIgfT1fVSfizVLIv4K5d9XZGASgtJd7Su3/61oA1dS4njBPwBudnBOhz2KIWe2rM0F5taBezvaD6xcpfbhSbqK6hV6bdnOmHHS6hIKZQ4PhF3Yn1o37iCmGcs1eE6GYKBDdmtdxc4ipm0VI/4RK/cRb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910752; c=relaxed/simple;
	bh=oJkrTq9AktOEedVhVoQ6CSiYgb98OoAzTiYTc+2AB9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B62DYwTMacG2KAwRk1fBkE1lr1oiGgmkl0bmbJpDjnRm0kyE7Rj9f0UAsz9pmDoIChwJMSsa32LXpcaLqmrEstSbivKUraUpZM0Ped15rnI5k3n58V8SmqZ5+1SxD06kHXJt9GLXxeQyCDOtdpZzG/QsxmpCEyiStXWMqtbG4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvoQFMbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvoQFMbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C61F000E9;
	Mon, 13 Jul 2026 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910750;
	bh=Kiqb5G19ULFtghyMZbx1g+TqnvvfEdVW7jtvsSm06yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvoQFMbeZKWaiU3pY3Do9i6YTZ20XeZa+PsSByEqtjI1zX4krbDxXaUs8YTc6uIu1
	 y2VCmwQ8NAOriTM8iLGNQvXbyKcN2V9XNcc2iSN65iVGgx4gjS9BqUnUTgO1LDTlQK
	 ngaMZtW5y+G+M0ycDK48WjpgrijaaVIaoPbL8EEjIwz6LiJJwJ0RD1wljhQciPZjti
	 vSqrpKjqw7SIcWMlmqiwg3IMG89PfW5u1fOk9wFB0OKwuL2x/LDG47qHZqAxK3CyAZ
	 CUEgFKhv0cJbonGWmCrRlMvMNvIf9Bcp+uS78v6Iey4u4+IPgiNnS6F75zSt9pkR4r
	 dziHfdwG5Cxug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260713023435.235765-3-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
 <20260713023435.235765-3-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:45:49 +0000
Message-Id: <20260713024550.6C2C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware initialization failure is ignored in `imx_add_pcie_ep()`,=
 likely leading to a system crash.
--

--- Patch [2]: [PATCH V6 2/4] PCI: imx6: Add skip_pwrctrl_off flag support =
---
commit 6bc8a94c274f464b53bad3ac0ac1a464c280f05e
Author: Sherry Sun <sherry.sun@nxp.com>

PCI: imx6: Add skip_pwrctrl_off flag support

Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
suspend to preserve wakeup capability of the devices and also not to
power on the devices in the init path.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 92f8e4a299e88..afcf3b6bf3cd7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1382,10 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *=
pp)
>  		}
>  	}
> =20
> -	ret =3D pci_pwrctrl_power_on_devices(dev);
> -	if (ret) {
> -		dev_err(dev, "failed to power on pwrctrl devices\n");
> -		goto err_reg_disable;
> +	if (!pp->skip_pwrctrl_off) {
> +		ret =3D pci_pwrctrl_power_on_devices(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to power on pwrctrl devices\n");
> +			goto err_reg_disable;
> +		}
>  	}
> =20
>  	ret =3D imx_pcie_clk_enable(imx_pcie);

[Severity: High]
This is a pre-existing issue, but since this patch modifies
imx_pcie_host_init(), I noticed an issue with how its return value is handl=
ed.

Looking at imx_add_pcie_ep() which calls this function:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
	...
	imx_pcie_host_init(pp);
	ep =3D &pci->ep;
	ep->ops =3D &pcie_ep_ops;
	...
}

The return value of imx_pcie_host_init() is entirely ignored here. If hardw=
are
initialization fails (e.g., clocks fail to enable or PHY fails to power on),
imx_pcie_host_init() returns a negative error code but leaves the hardware
unclocked or unpowered.

The code then proceeds to call dw_pcie_ep_init_registers(), which accesses
unclocked DBI memory-mapped registers (e.g., PCI_HEADER_TYPE).

Can this lead to a synchronous external abort and kernel panic when accessi=
ng
these unclocked peripheral registers?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713023435.2357=
65-1-sherry.sun@oss.nxp.com?part=3D2
