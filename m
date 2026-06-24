Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCEA30C179
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309890; cv=none; b=au/AxHMVN1oWeOblRGyw3pTA+H0udl2sLP/i7w6/fqSQG7UIfXZsswuvUfTZjpLynx47jSziS2eqy+8x7DSFef6DZb8IS0v5ko1tqHC+tkJBntiN18r0qSXoMp/O2ddWE0HO8KKWGvgbLnUGCG3B2NkRomZWEiOmYPbtA4JJICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309890; c=relaxed/simple;
	bh=coVOnLljfvJZH+2H7Q5x0OcJvYY2eK9FZ+22+iplQXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bROZn+azzNzgL8edp/VXmac+qUMLK4ghI4rT88kmwGcVxMEKS/22RZTE3KGKgWtkT7VX4kfKjs4mHJr8pajEpXtcq4ngz6fCENmQTuNKwwdbqCMAG147yp6r5xtNUor66e0L/SSNghST0gZ9ZWVe8Vx2UExxA+BVtvapHXQVXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoHKJcfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoHKJcfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588961F00A3A;
	Wed, 24 Jun 2026 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782309888;
	bh=6I2u4AXpZDRd8Fbz3Ig1e1EAXouMnPNd3HkQLmf0YaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BoHKJcfZ03rsfkHKhxhg98svyZh/C9c8Tw96oZAPKYKIW1LMq72UYpE3EVmTskaft
	 Eaw14Ad8SPpNrR7vb+vB4gAxmMKRJY6kFJtL9E6uzmnrcElJdPp5huhXm6MWNUWYx/
	 itkYQdxzD7Zj6XG8LfpHH/Iv0JF056ecCYLIU2i8rVThOhQ6gGqOCh6TJK/AeaOROi
	 2lmZFBRhFsAl5Nog2UcQzuPzKxCN9JBoGblg0TOF8s1tJsxEjmxbTkw4RcAmwzQj02
	 9JoL2DAu7GiEW6Z+0GpGiOVHONZHFMF4AVadt7L53wMI1boagsYCbEelLGQspT+5Ok
	 4i0BOPiAam9JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: qcom-ep: Fix runtime PM reference leak in probe
 error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260624134932.44357-1-vulab@iscas.ac.cn>
References: <20260624134932.44357-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:04:47 +0000
Message-Id: <20260624140448.588961F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a manual `pm_runtime_disable()` call on the `=
devm_pm_runtime_enable()` error path, which causes a double-disable and per=
manently breaks runtime PM for the device.

Pre-existing issues:
- [High] `qcom_pcie_ep_remove()` does not call `dw_pcie_ep_deinit()`, causi=
ng permanent memory leaks of EPC memory structures and MSI address allocati=
ons on driver unbind.
- [High] `qcom_pcie_disable_resources()` uses the asynchronous `pm_runtime_=
put()` instead of synchronous `pm_runtime_put_sync()`, causing the pending =
suspend to be cancelled during device removal.
- [High] The global IRQ handler accesses hardware registers without acquiri=
ng a runtime PM reference, risking unclocked access and kernel panics if th=
e IRQ fires while the device is suspended.
--

commit bfc2657160a90bca55dc8326794de5109d7591fc
Author: Wentao Liang <vulab@iscas.ac.cn>
Subject: PCI: qcom-ep: Fix runtime PM reference leak in probe error paths

The commit modifies qcom_pcie_ep_probe() to properly release the runtime
PM reference obtained via pm_runtime_get_noresume() on error paths. It
introduces differentiated error handling to avoid double-puts or
double-disables depending on whether devm_pm_runtime_enable() succeeded.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 257c2bcb5f76f..aa3b7cdd513cd 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -892,16 +892,16 @@ static int qcom_pcie_ep_probe(struct platform_devic=
e *pdev)
>  	pm_runtime_set_active(dev);
>  	ret =3D devm_pm_runtime_enable(dev);
>  	if (ret)
> -		return ret;
> +		goto err_manual_cleanup;

[Severity: High]
If devm_pm_runtime_enable() fails, does this cause a double-disable of
runtime PM?=20

When devm_pm_runtime_enable() encounters an error (like devres memory
allocation failure), it automatically calls pm_runtime_disable() to roll
back. By jumping to err_manual_cleanup, we call pm_runtime_disable() a
second time. This would increment the device's power.disable_depth to 2,
permanently preventing runtime PM enablement on subsequent probe attempts.

[ ... ]

> +err_manual_cleanup:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does qcom_pcie_ep_remove() fail to clean =
up
the EPC memory?

Looking at qcom_pcie_ep_remove() in drivers/pci/controller/dwc/pcie-qcom-ep=
.c,
it appears to omit the dw_pcie_ep_deinit() call. During probe,
dw_pcie_ep_init() allocates the EPC address space using kzalloc() and MSI
memory via ioremap(), which are not devres-managed. Could omitting the dein=
it
function permanently leak these memory regions and eventually exhaust system
memory on driver unbind?

[Severity: High]
This is a pre-existing issue, but should qcom_pcie_disable_resources() use
pm_runtime_put_sync() instead of pm_runtime_put()?

In drivers/pci/controller/dwc/pcie-qcom-ep.c:qcom_pcie_disable_resources(),
pm_runtime_put(dev) queues an asynchronous suspend. Immediately after remov=
al,
the devres cleanup invokes pm_runtime_disable(), which calls
__pm_runtime_barrier() to synchronously cancel any pending async requests.
Does this leave the device permanently powered on and active?

[Severity: High]
This is a pre-existing issue, but is it possible for the global IRQ handler
to access unpowered hardware registers?

If the global_irq fires (e.g., a spurious interrupt) after the device is
runtime suspended, qcom_pcie_ep_global_irq_thread() accesses the PARF
registers without calling pm_runtime_get_if_active().=20

drivers/pci/controller/dwc/pcie-qcom-ep.c:qcom_pcie_ep_global_irq_thread() {
    ...
    u32 status =3D readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
    ...
}

Since pm_runtime_put_sync() at the end of probe drops the PM reference, Gen=
PD
may power down the domain. Would accessing unpowered registers here cause a
synchronous external abort and crash the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624134932.4435=
7-1-vulab@iscas.ac.cn?part=3D1
