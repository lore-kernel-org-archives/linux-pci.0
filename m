Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB83E022A
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784389784; cv=none; b=aL4CzUkiRf25UVvtu9VH8sC3ZUhPKFDZ9Cui90yVQFj+GQAnsew8098DMRuMupBSDb/kcwMnXOEa8QzC8cmC7FSD14B8anCKvNVAHwQeWmXGkr2YochuHBAL4FXgpSSQcx4dQxpyx+wWk10/jERYHpCnI1QUGCBdsl49K0gJNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784389784; c=relaxed/simple;
	bh=hnI6h+7GPgq3GBz7CZ1Hb1L+QkcYVYX7UnNOd15NV+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TgaQdd+r77LmLTHEtLbITqjq3N2aok+phkbTpZjbtg6j/YM+AgdlZ7+8xL8GkGwK/uqyvLRDbTNiZQdQ1hUSLST7LlVGhoqlgiyuIETFnwaSLBAiSChAJUD9KvzSx5kRE4saceJiY18DViGTiPB4YIqb5jXv3j6IcDKN29juv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCOd0nO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCOd0nO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C38A1F000E9;
	Sat, 18 Jul 2026 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784389775;
	bh=QAi4t8U8JykULRif8S3umfAB8OxpxH0cgBJiSRi52fU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCOd0nO54SP2Y4RK/qP6zcyTjTd9DmDvxvDalluMFoL8g78y0rKaaFjYO/WKSCUwU
	 Y3VqY92AL1m7mZiJFxINemuVTDO+zpwqiLDq/XI5bY57Qu+VfSlLF80wlrVPAey/iy
	 6qPqGfpsNTZL1s+uLjuCdQkz9IlmL7jcM70DePOWQRy3fWOBzX2m1AaveV0KaakgE/
	 31vnmou95McHazqfDop5YjaUnRlWHux6o9SqM0Bn3uhhs5lOAZDJvR6Tn65GzPofd0
	 u06BkX6n0p2uayluv9m5UTGju3MWAg/UonCJ/0GPkdsiQR5VhOhWtnaFSerYPsl9Ep
	 a6G4nVS+SmVNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: starfive: Fix unchecked pm_runtime_get_sync()
 in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260718153352.661930-1-alitariq45892@gmail.com>
References: <20260712175427.232234-1-alitariq45892@gmail.com>
 <20260718153352.661930-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 15:49:34 +0000
Message-Id: <20260718154935.4C38A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Runtime PM is disabled asynchronously and prematurely during drive=
r removal, leading to an incorrect power state and violating PM guidelines.
- [High] IRQ domains are destroyed during host deinit while their associate=
d interrupts are still mapped and active.
--

--- Patch [1]: [PATCH v2] PCI: starfive: Fix unchecked pm_runtime_get_sync(=
) in probe ---
commit e9cae95ac8bfa924ebc45ae6433e2c2961f70890
Author: Ali Tariq <alitariq45892@gmail.com>

    PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe

    pm_runtime_get_sync() is called in starfive_pcie_probe() without
    checking its return value. If runtime resume fails, the driver
    proceeds to configure PCIe hardware through regmap_update_bits(),
    enable clocks and resets, and power on the PHY, even though the
    device may not actually be powered.

> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/co=
ntroller/plda/pcie-starfive.c
> index 298036c3e7f94..e9a472985b8ac 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -410,7 +410,11 @@ static int starfive_pcie_probe(struct platform_devic=
e *pdev)
>  		return ret;
> =20
>  	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_get_sync(&pdev->dev);
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0) {
> +		pm_runtime_disable(&pdev->dev);
> +		return dev_err_probe(dev, ret, "failed to resume device\n");
> +	}
> =20
>  	plda->host_ops =3D &sf_host_ops;
>  	plda->num_events =3D PLDA_MAX_EVENT_NUM;

While reviewing this patch, I noticed a couple of pre-existing issues in
related code:

> static void starfive_pcie_remove(struct platform_device *pdev)
> {
> 	struct starfive_jh7110_pcie *pcie =3D platform_get_drvdata(pdev);
>=20
> 	pm_runtime_put(&pdev->dev);
> 	pm_runtime_disable(&pdev->dev);
> 	plda_pcie_host_deinit(&pcie->plda);
> 	platform_set_drvdata(pdev, NULL);
> }

[Severity: High]
This isn't a bug introduced by this patch, but should this use=20
pm_runtime_put_sync() instead?

In starfive_pcie_remove(), pm_runtime_put() queues an asynchronous idle
request, but pm_runtime_disable() is called immediately after. This cancels
the pending request, leaving the device in an active power state indefinite=
ly.

Additionally, this teardown happens before plda_pcie_host_deinit(). If
pm_runtime_put_sync() were used, the hardware would drop power immediately,
causing plda_pcie_host_deinit() to access unpowered registers and potential=
ly
crash the system.

Should the host bridge be torn down first, and only then synchronously power
off the device?


Also in drivers/pci/controller/plda/pcie-plda-host.c:

> static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
> {
> 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> 	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
> 	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
>=20
> 	irq_domain_remove(pcie->msi.dev_domain);
>=20
> 	irq_domain_remove(pcie->intx_domain);
> 	irq_domain_remove(pcie->event_domain);
> }

[Severity: High]
This is a pre-existing issue, but are we destroying the IRQ domains while
their associated interrupts are still mapped and active?

During driver removal, starfive_pcie_remove() calls plda_pcie_host_deinit(),
which synchronously removes the event and INTx IRQ domains via
plda_pcie_irq_domain_deinit().

However, the interrupts mapped from these domains are never unmapped via
irq_dispose_mapping(). The actual interrupt handlers requested via
devm_request_irq() in plda_init_interrupts() haven't been freed yet, because
devm teardown occurs strictly after the driver remove() callback returns.

Is it safe to destroy these domains with active mappings and bound interrup=
ts,
or could this lead to issues during subsequent devm teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718153352.6619=
30-1-alitariq45892@gmail.com?part=3D1
