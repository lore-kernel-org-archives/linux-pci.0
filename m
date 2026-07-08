Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F094407CC7
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501272; cv=none; b=Y5ZG7lYp4MyrTqZiNDZmlSBSEpn48YRePCQP3xKSndTiF1P/m6zl93qu2+fzpstFxN9v4ITPqATmtQ0JAinO+ffBfE+NJjIg+EoQ26b2xwk8J9kURoYTc1ZKNVoOxY/xSQyh9aAFxGDWmEhOF6Lo2rN33EzZgyDg4s+NbftE6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501272; c=relaxed/simple;
	bh=Q0jfOYzUjkRWPrnzLML0G2QzZjy8JmHYXf5upYjx+n0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ad4oeNDsvSj4aRqcRX2NCJZoAIP7xnqriqyP97k67wLyuNUeTFJi7yGlL7Lf1Pnke2F2mfcm9BdIgBn4FvrLJsWvAgeKxBTUwRel15qXGjnVpzO5JmDSM8RykNdNi/fP39RnlM47wa7VqQK9cExkjYYqilbf8c1dVYJ9FQZnA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgvGiI61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgvGiI61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20D91F00A3E;
	Wed,  8 Jul 2026 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783501269;
	bh=yT5jH41EAPYvkLowDNb2Yu7SZLO5nQ9/9rkPmmIqayk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgvGiI61jiHV6W6pVz1MlzzSi2b5geMF/kSFiYTHl52ONqwuMXFQuHy12wAXADxkq
	 wU1TydPX7CUPWnXnifboKMtguXxuPmmp4Z5g5b3hhZDIr2mobjL8aoZc/bIz0dX7uM
	 ln/TNjUJB5aqED2xdNzr9Km9w5TmUDDrrnTy6hYXTvN+rLWn0QK08c+hQenU4+D/tL
	 ulr7xRv3TuK24+B+LfPcn/oIHqly9RWOf3LA/fV8PBZ7godEHgYTDEI5zcwJc+s17N
	 dPxI0PAN4Xosr0U1Ud2cNaZW49zyOjQf5nlQPmOTTK8A27yDWtqcqY9CXnGQk+JbnQ
	 3eRCpcsaugaDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drivers/perf: Fix the condition where the root
 port is runtime suspended
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708084507.98242-5-yang.yicong@picoheart.com>
References: <20260708084507.98242-1-yang.yicong@picoheart.com>
 <20260708084507.98242-5-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:01:09 +0000
Message-Id: <20260708090109.B20D91F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Ignored return value of runtime PM resume leading to potential har=
dware access while in D3cold
- [High] System-wide PCI device wake-up during module initialization
- [High] Use-After-Free of PCI device structure due to mixing goto with gua=
rd() cleanup
--

--- Patch [4]: [PATCH v3 4/4] drivers/perf: Fix the condition where the roo=
t port is runtime suspended ---
commit 366af2eb4d6dbafe5fed360f0136d4ac3c45f174
Author: Yicong Yang <yang.yicong@picoheart.com>

drivers/perf: Fix the condition where the root port is runtime suspended

The patch adds runtime PM get/put when initializing and destroying PMU
events to ensure the PCIe root port is not suspended during VSEC capability
access. It also adds runtime PM guards during probe and system-wide
initialization.

Link: https://lore.kernel.org/linux-pci/20260629094234.F25E71F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 7b4ee71b966b0..aea387d0d0fe3 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c

[ ... ]

> @@ -776,6 +794,7 @@ static int dwc_pcie_pmu_probe(struct faux_device *fde=
v)
>  	if (!name)
>  		return -ENOMEM;
> =20
> +	guard(pm_runtime_active_auto)(&pdev->dev);

[Severity: High]
The guard macro will resume the device, but its return value is ignored.

If the device fails to resume, could we end up reading the PCI
configuration space of a suspended device in dwc_pcie_des_cap() right
after this?

>  	vsec =3D dwc_pcie_des_cap(pdev);
>  	if (!vsec)
>  		return -ENODEV;

[ ... ]

> @@ -909,6 +928,8 @@ static int __init dwc_pcie_pmu_init(void)
>  	dwc_pcie_pmu_hp_state =3D ret;
> =20
>  	for_each_pci_dev(pdev) {
> +		guard(pm_runtime_active_auto)(&pdev->dev);
> +

[Severity: High]
Because this loop iterates over every PCI device in the system, does this
guard force every suspended PCI device to synchronously wake up before
we can check if it is actually the target device type?

Does this also share the same ignored return value issue as
dwc_pcie_pmu_probe(), where a failed resume goes unchecked?

Additionally, could this guard cause a use-after-free on the error path
later in the loop?

In dwc_pcie_pmu_init(), if dwc_pcie_register_dev() fails, we drop the
device reference and jump out of the block:

	ret =3D dwc_pcie_register_dev(pdev);
	if (ret) {
		pci_dev_put(pdev);
		goto err_cleanup;
	}

Since goto jumps out of the loop block, the compiler runs the cleanup
function for the guard (pm_runtime_put_autosuspend) after the manual
pci_dev_put() call.

If the manual put drops the last reference, does the cleanup function
dereference a freed pointer?

>  		if (!dwc_pcie_des_cap(pdev))
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708084507.9824=
2-1-yang.yicong@picoheart.com?part=3D4
