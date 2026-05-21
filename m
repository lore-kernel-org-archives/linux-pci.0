Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008E3E7BBF
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389489; cv=none; b=Z8sQd6U9rRBVOcc/yS2/0XQNcPD6GPvsmyIWqYjMt81t8eXRk5z+3bLnKqHn+4TV07boXufdGo65QOLP7iQS8xQz6hSmQKAq06uKtiRoTTn09fJyrITIQDo0jZ7uxL0UiDatOK/wMCjlxbKhBbB9FN848wt9G2XaW2LVgdCLHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389489; c=relaxed/simple;
	bh=MRxdSX7RPmE/nnonKuhSE51P0soGp/Y5PkVeytTCmk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDBE5ZDZ/6zpU/rLO7Q5BCe+Idyr3eeGJyHggSDil+3c93Ut2x98gaB8BSRxmxYhSNnTQ62/Ot+SUs03n9+XNrEsGUDq5qLbs7k+twYp32BvnWbqBYn4RAZFP+i9pinT3j9BR3xMtjbkix1+qZy/CedF5g+HXROVxzd+N4yOuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIc6BAFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIc6BAFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508391F000E9;
	Thu, 21 May 2026 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779389487;
	bh=xw4cpmRnhiw+eqnGpFvXIpQe/VZwElSmXD0YpMDIc4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIc6BAFLj9yOxoQE37V9QGFH3GcZBdDPY8Vua8MFqUeqh7xBnQi9L4LHmkrYU19u1
	 UBfyTmMNgZG5O6sQM1NQ2H8M5EO9eXBf1shWhslLjGXBxap8xf73lcQyZg2eL5WbYG
	 xqnjoqXhVGIg+hY3H3TyeyCbKDoK0kWCux+qxljfEYsEgPk1lhFbLV+idyIvhRyRU4
	 5ywqnKXrn4zxbrANP8DGJ4OA0eM5/Ua+0/Ejs2qKEC7Z3OiClDizeqQmPaBVz3gxDx
	 alWNKS/TfEA+r6Ouii4cOGRU3jn+RC66+o6hHPhnw542yOsnikufLbsGg/KiMFpQGp
	 J45jN4MuzfOHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] PCI: altera: Protect root bus removal with rescan
 lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521161822.132996-4-18255117159@163.com>
References: <20260521161822.132996-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:51:26 +0000
Message-Id: <20260521185127.508391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of chained IRQ handler and IRQ domain on probe fai=
lure paths in `altera_pcie_probe()`.
- [Medium] The driver does not disable hardware interrupt generation during=
 device removal.
- [Medium] The driver erroneously calls `irq_dispose_mapping()` on the pare=
nt platform IRQ in `altera_pcie_irq_teardown()`.
--

commit c918986379b1a0013bed56503edcc992be2805fa
Author: Hans Zhang <18255117159@163.com>

PCI: altera: Protect root bus removal with rescan lock

This commit wraps pci_stop_root_bus() and pci_remove_root_bus() with
the rescan locks to avoid potential races with sysfs-triggered rescans
during device removal.

> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controlle=
r/pcie-altera.c
> index 3dbb7adc421c4..7e1db267ae342 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -1045,8 +1045,10 @@ static void altera_pcie_remove(struct platform_dev=
ice *pdev)
>  	struct altera_pcie *pcie =3D platform_get_drvdata(pdev);
>  	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie);

[Severity: Medium]
This isn't a bug introduced by this patch, but does the driver need to
disable hardware interrupt generation during device removal?

The driver enables hardware interrupts by writing to device registers during
probe, but tears down the driver here without masking or disabling those
hardware interrupts.

Even though the chained handler is unregistered below, if the device still
asserts the interrupt line, could the CPU receive an interrupt with no
registered handler and cause the spurious interrupt detector to permanently
disable the IRQ line?

> =20
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
> +	pci_unlock_rescan_remove();
>  	altera_pcie_irq_teardown(pcie);

[Severity: Medium]
This is a pre-existing issue, but does altera_pcie_irq_teardown()
incorrectly dispose of the platform IRQ mapping?

The teardown function executes irq_dispose_mapping(pcie->irq). However,
pcie->irq is retrieved via platform_get_irq(), meaning the mapping was
created and is owned by the platform subsystem.

Device drivers usually shouldn't destroy IRQ mappings they did not
explicitly allocate. Could disposing of this mapping break the lifecycle
management of the platform IRQ if the driver is rebound?

[Severity: High]
This is also a pre-existing issue not introduced here, but I noticed a
potential use-after-free in the probe error paths.

The probe function successfully registers a chained IRQ handler via
irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr,
pcie). If a subsequent step like altera_pcie_init_irq_domain() or
pci_host_probe() fails, the function returns an error without unregistering
the chained handler.

Since the pcie structure is managed by devres, it is freed upon probe
failure. If the hardware asserts the interrupt line, could the core IRQ code
invoke the chained handler and dereference the freed pcie pointer?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521161822.1329=
96-1-18255117159@163.com?part=3D3
