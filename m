Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A93CFF46
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660907; cv=none; b=fySMBwEyjk0HpR0dZCAy4rlBu6xhm6bphpM8Fl6p7P6tFIol5eBhaIp7lXa1RQGDJIC6giWMb+Z38drwApia557UWnZvTtcwUtzR8m88aUXuyJhvWSkM5lLT6/btPzsrc/+sT4tuv7FA/+raYfk3CKth+4Go/wz0Sm8eeLPF0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660907; c=relaxed/simple;
	bh=gBOT0wJHuVN9YdNgpXXTUaipSZNOJzI/wRh6aXL5zmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IuUFLEwExM65xEx8JSmUqNgM0+kgVhO4zj+v1uc+PWrujMKWe9sbrdzGOGcGYmcPZY7bB7L0gsAG2XGotGmLI20gVMioOfNnsO6OHKirAY49HAeYU1J5QA6Y8EgBNYyFEMg7sdIHDcwnZIvr5pTT/p9RaoeKUwRlO3dQBUIvkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB+GJ/Am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB+GJ/Am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009B01F00A3A;
	Thu, 13 Aug 2026 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660906;
	bh=ACnNw1EQ+OXTtiNsggw4lteDDSyWTciiC9kfzSft/aA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MB+GJ/AmvX7YivjEfeYcPVFlib5XTdaVW2aoq87TVFUOXjcrkOHUckGH/XD6oCDzF
	 0SfwzSh3Masj6otrjcE8SI6XHavzlFF8EQi6A5na4ML6O3U5kxi9N3OD7t6CI4Wn5g
	 TzzWUSTl4/Vl6AlgCUtkIClIWMVC+5t57e6e1zWE3iys0p+NZsCdBTvp1YvH3MwGRn
	 qGEQIQK1LsTzWVQz7PY8x5y2sR5qWNN7WWiUioCe1hDwsItGZs+9FrdWDuhYJMS3Uj
	 sC9liYY86FleyPVI+Lx796Xi3tNhnX8ygLdmanSGJlEU6T4xXHTPvBhCTfNHvDOPOs
	 T+0Ig7MKkEgAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/14] PCI: tegra194: Allow system suspend when the
 Endpoint link is not up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260324190755.1094879-10-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-10-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:41:45 +0000
Message-Id: <20260813224146.009B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PM callbacks are asymmetric, missing a `.resume` callback, which l=
eaves `pex_rst_irq` permanently disabled if the system suspend process is a=
borted.
- [High] Time-of-check to time-of-use (TOCTOU) race in `tegra_pcie_dw_suspe=
nd()` allows the system to suspend while the Endpoint link is active.
--

--- Patch [9]: [PATCH v8 09/14] PCI: tegra194: Allow system suspend when th=
e Endpoint link is not up ---
commit 9f02485e505b10cc3b88208af0183e49b85c7e80
Author: Vidya Sagar <vidyas@nvidia.com>

PCI: tegra194: Allow system suspend when the Endpoint link is not up

Host software initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index f1985fca988ee..f66a93f0cf658 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2270,16 +2270,28 @@ static void tegra_pcie_dw_remove(struct platform_=
device *pdev)
>  		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
>  }
> =20
> -static int tegra_pcie_dw_suspend_late(struct device *dev)
> +static int tegra_pcie_dw_suspend(struct device *dev)
>  {
>  	struct tegra_pcie_dw *pcie =3D dev_get_drvdata(dev);
> -	u32 val;
> =20
>  	if (pcie->of_data->mode =3D=3D DW_PCIE_EP_TYPE) {
> -		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
> -		return -EPERM;
> +		if (pcie->ep_state =3D=3D EP_STATE_ENABLED) {
> +			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
> +			return -EPERM;
> +		}
> +
> +		disable_irq(pcie->pex_rst_irq);

[Severity: High]
Is there a race condition between checking the endpoint state and disabling
the IRQ here?

If the host deasserts PERST# just after ep_state is checked but before
disable_irq() executes, the tegra_pcie_ep_pex_rst_irq threaded IRQ handler
could run concurrently.

This would allow the endpoint state to change to EP_STATE_ENABLED,
bypassing the safety check and allowing the system to suspend while the
link is active.

Could the IRQ be disabled prior to checking ep_state, and re-enabled on
the error path if suspend is not permitted?

> +		return 0;
>  	}
> =20
> +	return 0;
> +}
> +

[ ... ]

> @@ -2345,8 +2363,8 @@ static int tegra_pcie_dw_resume_early(struct device=
 *dev)
>  	u32 val;
> =20
>  	if (pcie->of_data->mode =3D=3D DW_PCIE_EP_TYPE) {
> -		dev_err(dev, "Suspend is not supported in EP mode");
> -		return -ENOTSUPP;
> +		enable_irq(pcie->pex_rst_irq);
> +		return 0;
>  	}
> =20
>  	if (!pcie->link_state)

[ ... ]

> @@ -2451,6 +2469,7 @@ static const struct of_device_id tegra_pcie_dw_of_m=
atch[] =3D {
>  };
> =20
>  static const struct dev_pm_ops tegra_pcie_dw_pm_ops =3D {
> +	.suspend =3D tegra_pcie_dw_suspend,
>  	.suspend_late =3D tegra_pcie_dw_suspend_late,
>  	.suspend_noirq =3D tegra_pcie_dw_suspend_noirq,
>  	.resume_noirq =3D tegra_pcie_dw_resume_noirq,

[Severity: High]
Does this introduce an asymmetry in the PM callbacks by placing disable_irq=
()
in .suspend but enable_irq() in .resume_early?

If a system suspend is aborted due to a failure in another device's suspend
callback, the PM core rolls back by calling .resume on successfully
suspended devices. The .resume_early phase would be skipped entirely.

Because there is no .resume callback defined here to pair with .suspend,
pex_rst_irq would remain permanently disabled after a failed suspend,
breaking the PCIe endpoint PERST# reset functionality.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324190755.1094=
879-1-mmaddireddy@nvidia.com?part=3D9
