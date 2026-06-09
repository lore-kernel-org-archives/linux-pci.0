Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5035F19A
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000155; cv=none; b=Nz3ObFXXuRJ7yLuouBVMAgHGywNN3Tm04s5BeLSkclahNFbrT9P74KW8W2haRtkIx0WpRMtvrHbNMR7X0oq3UymfUEMQgQmoOKAX5NlnIWCPkUvUAZgErb7jXK5w48+GAHpqVYh1KNlz1D3/0sroyQ1x1RToud0l4gu0QWQHJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000155; c=relaxed/simple;
	bh=tKOEfb0f3EYV39QeYGWacQ8MlJbTnGcxpnYC4LV+O78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U98wJ+727/tVa+9em0fdAdMXTVqptacISviRr4e0Rli7wO4YN01Nd3+T6mW+cZYft8jx70S8AXkpdPqfsLscAWQPPOi8SGBUb2Ra9Tk1UeB+9q+iYi/93n3d2ILfupXX3r9Dwk4VY4AWDJcQAangwdh5l+pBXwmT1HG+FTX3emY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvY1WTsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvY1WTsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D4B1F00893;
	Tue,  9 Jun 2026 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000154;
	bh=FdM+QMbd6X7YjAv6g7Tjjy9Ajj9mzxfk15kqvlP5Kvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hvY1WTsnh4BXNgab7iZG8wpxsQhGFcaZ3b5D9iUWrKaLElvfilqpSWSj6Qn1/gV/u
	 JIlb5P5vPybDZ4Y1gDj2yi7CtUnzkRGct4cB8WufwuHKFQF3FCYg8zLUdAUaIUhapC
	 O3KP+0mo/ij+Sh/AbdTNF1XUGAa19Z76ZTfEuzhsHaeeEK+tUFG54U02XRsKWxN2lV
	 skL1l0n/mZM1nJ5ZTtmcGJgJvzVNXi10Vf/hQlX2hJ50XrbVNJOMxO0019Mtioebf/
	 GP7N0QDTeCFKkykKK58oRrOJpn5raJ/a9IIZU+SHlEajCgyiSvKF18CaiMsD4itAaM
	 q4P78noEFXVew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: fix refcount leak in qcom_pcie_ep_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260609100747.230521-1-vulab@iscas.ac.cn>
References: <20260609100747.230521-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:15:53 +0000
Message-Id: <20260609101554.36D4B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Calling `pm_runtime_disable()` manually in the error path after us=
ing `devm_pm_runtime_enable()` causes a double-disable, permanently breakin=
g runtime PM.
- [High] The error path for a failed `pm_runtime_put_sync()` falls through =
to `err_rpm_put`, leading to a double decrement of the runtime PM usage_cou=
nt.

Pre-existing issues:
- [High] Failing the entire probe function if `pm_runtime_put_sync()` retur=
ns an error is incorrect and brittle.
--

commit 2adeb10c2dada5b5e65aed93fd2d269f6cd5a790
Author: Wentao Liang <vulab@iscas.ac.cn>

PCI: qcom-ep: fix refcount leak in qcom_pcie_ep_probe()

This commit attempts to fix a runtime PM reference leak in the error paths
of qcom_pcie_ep_probe() by introducing a new error label. The new label
calls pm_runtime_put_noidle() and pm_runtime_disable() to properly release
the reference before returning the error.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 257c2bcb5f76f..c01d4d3b49520 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
[ ... ]
> @@ -932,6 +932,10 @@ static int qcom_pcie_ep_probe(struct platform_device=
 *pdev)
>  err_ep_deinit:
>  	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
> =20
> +err_rpm_put:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);

[Severity: High]
Does calling pm_runtime_disable() here in qcom_pcie_ep_probe() cause a
double-disable of runtime PM?

Earlier in the probe function, the code uses devm_pm_runtime_enable(dev).
This registers a devres cleanup action that will automatically call
pm_runtime_disable() upon probe failure or device removal.

If we explicitly call pm_runtime_disable() here in the error path, it
appears it will be executed twice (once explicitly, and once via the devres
unwind). Because __pm_runtime_disable() unconditionally increments the
device's disable_depth counter, could this leave the counter permanently
elevated to 2 and break runtime PM for any subsequent probe attempts?

[Severity: High]
Will this new error label result in a double decrement of the usage_count
if the probe fails during pm_runtime_put_sync()?

Later in qcom_pcie_ep_probe(), if pm_runtime_put_sync() fails, the
function jumps to err_disable_irqs:

    ret =3D pm_runtime_put_sync(dev);
    if (ret < 0) {
        dev_err(dev, "Failed to suspend device: %d\n", ret);
        goto err_disable_irqs;
    }

The err_disable_irqs path then falls through to this new err_rpm_put label.
Because pm_runtime_put_sync() maps to __pm_runtime_idle() with the
RPM_GET_PUT flag, the usage_count is decremented first before the idle
check even begins.

If it returns an error like -EAGAIN, the usage_count has already been
successfully dropped. Falling through to call pm_runtime_put_noidle()
again will attempt to drop the usage_count a second time. Could this
wrongfully steal a concurrent thread's reference and lead to an eventual
counter underflow?

[Severity: High]
This isn't a bug introduced by this patch, but is it correct to treat a
negative return from pm_runtime_put_sync() as a fatal probe failure?

Looking at the same code block referenced above in qcom_pcie_ep_probe(),
a return value like -EAGAIN simply means the device cannot be synchronously
suspended at this exact moment (for example, if another thread concurrently
incremented the usage counter).

Since this is a valid runtime PM state and not a hardware or initialization
failure, does tearing down the fully working device and failing the probe
cause spurious device initialization failures?

> +
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609100747.2305=
21-1-vulab@iscas.ac.cn?part=3D1
