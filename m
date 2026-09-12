Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184631F9B1
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230465; cv=none; b=CYoQvcmdNseR4ldd8gF4I34PepRAhOj0OtCR1nxeKd4MYCaVgVPpICi8LGNMGn0uTrh6uVcl77eKFex+2srJKhD2sGtNjahxhv3N+DsxCTQIw/0jcVG/bZgzzfmj3ZVlvpJXceItTFFTGE8JRXF0e8RvsW1zySe3NpaevRkfDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230465; c=relaxed/simple;
	bh=QS3UBYt6Dt2mhI7kQe4yNxKGB0EA3pG2YWsluwPiF1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovD7plNL/A0L+viGLZ6otuwSFdRQeEJq+6OXTlDMA8KX2TmqG/2F3b6Izzpd3znVsl3ptE2DA22vZkKuzTGNAvsdW0dazPUOpE/msCB6ibp5usQUev5gfaDNmLY70buOCVbFpe//mW7Ynfdvj98qxGG5VZ/C/vGVAdLqy4Qf3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjrc2SnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjrc2SnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241781F00893;
	Sat, 12 Sep 2026 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230464;
	bh=VYmjKbgcm0+1nse86m66cddIWeqwA/k6dMYbkMRHBa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjrc2SnLZ/K/GCgAn4wWJRNH3omrQS8I3pcg7MhqE5g6drm5ELWnCXo9Mt5F73BGq
	 JmfSJYVkhFxBCMHL4QO4z+BcqvvkH80LguUWrDPxxQHA8eDsaN3kqcJE9hfaRNlEGV
	 w5WbFkss5G2/Z1RJ7lcnsjj53gCpnwaQ3+6Ce4zyvCSIE1qBM5C+5b8g+bBTh1tpLM
	 xKeF3dyBAcHW9nrpLan2QtzCxF/rz/QswuMEjl1vOEW+84Nc3TIkk5hdiY7FfFLTSI
	 tDHn9OvlwvsHUlBzTveEv6Bd7P5iSUI6jacyyRMqtbcEKq+RtkV8OwEdfF56Ki0Ovg
	 EFsXF19516n8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: keystone: Remove device links to PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: vladimir.oltean@nxp.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260912161440.1032188-4-vladimir.oltean@nxp.com>
References: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
 <20260912161440.1032188-4-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 16:27:43 +0000
Message-Id: <20260912162744.241781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous `pm_runtime_put()` immediately followed by `pm_runtim=
e_disable()` risks canceling pending suspend work, leaving hardware in an i=
ncorrect power state.
- [High] Missing cleanup of DWC host and endpoint structures in `ks_pcie_re=
move()` leads to a Use-After-Free vulnerability.
- [High] Hardware registers are unconditionally accessed in a shared IRQ ha=
ndler without checking runtime PM state, risking a kernel panic.
- [High] Early registration of a shared IRQ before state structures are ful=
ly initialized introduces a race condition leading to a NULL pointer derefe=
rence.
--

commit cee8876507fd3272f25089c961cbca85b16e29eb
Author: vladimir.oltean@nxp.com <vladimir.oltean@nxp.com>

PCI: keystone: Remove device links to PHY

This commit partially reverts earlier device link handling to clean up
PHY provider and consumer suspend/resume operations. The PHY core now
handles the device link addition natively, making the local implementation
redundant.

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/cont=
roller/dwc/pci-keystone.c
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c

[ ... ]

> @@ -1338,25 +1322,18 @@ static int ks_pcie_probe(struct platform_device *=
pdev)
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
> =20
> -err_link:
> -	while (--i >=3D 0 && link[i])
> -		device_link_del(link[i]);
> -
> +err:
>  	return ret;
>  }
> =20
>  static void ks_pcie_remove(struct platform_device *pdev)
>  {
>  	struct keystone_pcie *ks_pcie =3D platform_get_drvdata(pdev);
> -	struct device_link **link =3D ks_pcie->link;
> -	int num_lanes =3D ks_pcie->num_lanes;
>  	struct device *dev =3D &pdev->dev;
> =20
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);

[Severity: High]
This is a pre-existing issue, but does using the asynchronous
pm_runtime_put() right before pm_runtime_disable() risk leaving the
hardware active?

According to PM subsystem guidelines, pm_runtime_put() queues asynchronous
suspend work which is immediately flushed and canceled by
pm_runtime_disable(). Should this use the synchronous pm_runtime_put_sync()
instead to ensure the device is properly suspended in both this remove path
and the probe error path?

[Severity: High]
This is also a pre-existing issue, but does ks_pcie_remove() miss the
required DWC core cleanup routines?

It looks like dw_pcie_host_init() or dw_pcie_ep_init() are called during
probe, but there are no symmetrical calls to dw_pcie_host_deinit() or
dw_pcie_ep_deinit() here. Since the struct dw_pcie is allocated with
devm_kzalloc(), wouldn't the active PCI core retain dangling references
after unbinding, leading to a Use-After-Free?

>  	ks_pcie_disable_phy(ks_pcie);
> -	while (num_lanes--)
> -		device_link_del(link[num_lanes]);
>  }

While reviewing the PM handling in this driver, I noticed a couple of
other pre-existing issues regarding the error IRQ handler.

[Severity: High]
This is a pre-existing issue, but could this early IRQ registration lead to
a NULL pointer dereference?

In ks_pcie_probe(), the shared IRQ is requested before ks_pcie->pci is
assigned:

drivers/pci/controller/dwc/pci-keystone.c:ks_pcie_probe() {
	...
	ret =3D devm_request_irq(dev, irq, ks_pcie_err_irq_handler, IRQF_SHARED,
			       "ks-pcie-error-irq", ks_pcie);
	...
	ks_pcie->pci =3D pci;
	...
}

If an interrupt from another device on the same shared line fires
immediately, the handler will run and dereference the uninitialized pointer:

drivers/pci/controller/dwc/pci-keystone.c:ks_pcie_handle_error_irq() {
	struct device *dev =3D ks_pcie->pci->dev;
	...
}

[Severity: High]
This is another pre-existing issue, but can the shared error IRQ handler
safely read hardware registers without checking the runtime PM state?

If another device sharing the IRQ line fires an interrupt while the
keystone controller is suspended and its clocks are gated, will reading
ERR_IRQ_STATUS cause a kernel panic (synchronous external abort) or return
invalid states?

drivers/pci/controller/dwc/pci-keystone.c:ks_pcie_handle_error_irq() {
	...
	reg =3D ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
	...
}

Should this use pm_runtime_get_if_active() to ensure the device is clocked
before accessing hardware registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912161440.1032=
188-1-vladimir.oltean@nxp.com?part=3D3
