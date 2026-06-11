Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE844963D8
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199321; cv=none; b=KkXIn3BpF6EjrzfhttcL6um5cTvztTwbwEQvEb9AezJSYWzwZef/FjGFhUracZ9kF52T+PFuH/ivKr3fhcMNErVtMwEZI9gcS6DLAEj2XHThsgSBRCSpIYTFv15CtfBdReKLg2Kl0AqZ4da9pR3ftHpgl/XmgZaAwrhemR7g5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199321; c=relaxed/simple;
	bh=BKTKQhFatu0wguRSX2FIy2NatyX9N2ZduuzPt61hgvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vgh/Wur2+eTizLIKPF6DZSe/V51+rqgVv6kZi7lhDwuQ7wglJPRDny9bamo+yon66r0QtXXS3EXdK0gTalaNBRXRI8vR0IdkyexCoedrj6cZUg8H9rOjiCWoXLwAlLXEu+sa7ERDLdw1VLqUcqvTpAeeXUu5ctf/DXMhKvA4EMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAtG6uNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAtG6uNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D071B1F00893;
	Thu, 11 Jun 2026 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199320;
	bh=6pxUbXEzZX/gUPFisIaV9nKAw/P5duOyHIKX3j1alag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAtG6uNLr5GZKRpYTidJ4mZTbzqEjLYFr6it8WTwkMMVK3hmKbAnWlrgz5p661rrR
	 zMZ2d6ImcZlZft9609PoECjEO87Tghi3XMst01Bd35RYfL/h4RbKQIt+FV9LiPqGbv
	 EWesl8E1MagMMsXl+w+/kfrSQ+lr0bFI8Cuhb32uZ0AZOcofuhotUaFhGjcLBJUiPg
	 /SVR0zD2eyv5Ts7mJ4GZYKstHu3eK63C2mC42ucZo5+PhO2gwgLyR+ynggoCNntn86
	 79hj4JXa9bRpXKMiAoenIpMYW0qQhVxiH3Oy8AAQTAg3ZViN88CUpKJ5rNej0mVYEG
	 3QwDGmjtWYMkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM
 status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260611165933.20071-4-18255117159@163.com>
References: <20260611165933.20071-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:35:19 +0000
Message-Id: <20260611173519.D071B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid pointer derivation via `to_pci_epc()` in `cdns_pcie_ep_dis=
able()` leading to a wild pointer dereference.
- [High] The `pcie-cadence-plat.c` driver incorrectly returns 0 on probe fa=
ilure and lacks a `.remove` callback, leading to silent probe failures and =
severe use-after-free bugs on unbind.
--

commit b49dbfe29c305b407944a72dcdee68320ac08c7c
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add LGA IP debugfs for LTSSM status

This commit extends debugfs support to LGA-based Cadence PCIe controllers.
The 'ltssm_status' file now supports both HPA and LGA IP by selecting the
appropriate register access based on the 'is_hpa' flag.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/p=
ci/controller/cadence/pcie-cadence-ep.c
> index c0e1194a936b3..370b19f4d38fb 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -655,6 +655,7 @@ void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
>  	struct device *dev =3D ep->pcie.dev;
>  	struct pci_epc *epc =3D to_pci_epc(dev);

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to a wild poin=
ter
dereference?

In cdns_pcie_ep_setup(), the epc object is allocated separately using
devm_pci_epc_create(), which embeds its own struct device (epc->dev).

Here in cdns_pcie_ep_disable(), the code attempts to recover the epc pointer
by passing the parent platform device (ep->pcie.dev) to to_pci_epc().

Because to_pci_epc() is a container_of macro, subtracting the offset of the
dev member from the platform device pointer will yield an invalid pointer.

Will dereferencing this pointer in downstream functions like
pci_epc_deinit_notify() cause memory corruption or a kernel panic during
driver unbind?

> =20
> +	cdns_pcie_debugfs_deinit(&ep->pcie);
>  	pci_epc_deinit_notify(epc);
>  	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
>  			      SZ_128K);

[ ... ]

I also noticed a pre-existing issue in drivers/pci/controller/cadence/pcie-=
cadence-plat.c:

drivers/pci/controller/cadence/pcie-cadence-plat.c:cdns_plat_pcie_probe() {
    ...
 err_init:
 err_get_sync:
	pm_runtime_put_sync(dev);
	pm_runtime_disable(dev);
	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
	phy_count =3D cdns_plat_pcie->pcie->phy_count;
	while (phy_count--)
		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);

	return 0;
}

[Severity: High]
This isn't a bug introduced by this patch, but does returning 0 here silent=
ly
mask probe failures from the driver core?

Also, the platform driver lacks a .remove callback:

static struct platform_driver cdns_plat_pcie_driver =3D {
	.driver =3D {
		.name =3D "cdns-pcie",
		.of_match_table =3D cdns_plat_pcie_of_match,
		.pm	=3D &cdns_pcie_pm_ops,
	},
	.probe =3D cdns_plat_pcie_probe,
	.shutdown =3D cdns_plat_pcie_shutdown,
};

Does the lack of a .remove callback mean no driver-specific teardown runs
on unbind?

Without it, devres will free the controller memory while leaving the active
PCI root bus and debugfs nodes with dangling pointers.  Could this result in
use-after-free bugs when those pointers are accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611165933.2007=
1-1-18255117159@163.com?part=3D3
