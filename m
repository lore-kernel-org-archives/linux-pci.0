Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F43AFAF0
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079406; cv=none; b=EU4DEUycGGXSFmkob6RzN0pLGpNNedc6DGAUs5QyXbREGWz8tBDLSici4bdbDZtXV7c7r4w1xgvNz8GCf1QMYRevueghjpQAn3vhuLHWaTql0Sqm7gZk1/I6aJaf2BLlywkdtLCNn2v0BCwdIjFWW9rS/z8rGpLwKFECkGQxVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079406; c=relaxed/simple;
	bh=G+AqHwaCl5jcih9e0Nx4e7nBUXSMYN+iEtDeZKDZtw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CnFNiWIRyeSb8qoATs2ytucSORoxPYrKcEhuEA/VR4HEdAooYesk2CbSNIxz6f8eAMgbHTET8VJncGfJ5rLJL7ieUf9RiEQAeYZmVdMnFsPPW3EtSCCYgNX6xafREKu9FuH+q+Op9IeRfTDQ5AlYymIcXMUr2PWLhZey1EYSAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdvS0sOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdvS0sOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984FA1F000FF;
	Thu, 10 Sep 2026 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079404;
	bh=u6DQRFubm7jEjUtQQ+1VNwEh75KnMI1fqijRn9W3JGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VdvS0sOkYVsDan9ytfSqjBejhutpnlZg4I7BsygIWWXO//0cHvRg3PFdCWlyVN4m6
	 8hRRgk3z78GuGJsrodHdMKCAqyXKediYyTyAXgEvx5DLzfFOi+tXVtIBvndrRh5mW+
	 rWJR5gVeAhKodLMJEbxrjX8un/XWqmtAF1JrkFQjbGVXIuzWgbxcOgL28QplD+fMxp
	 usKB7W9JzZMwDrePmAclA+pRT3xLe9vx1+fLKgwV1dL8f69YO3b1x33DMB10zDxC8n
	 U5c/ocU0vSoyAR5NL/lcj4Whb/PntoE0lOMmXOnEziLOzHDjq2YDxk6gpzKEd/R3pp
	 xgu0DTOwxraqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: aardvark: Disable PHY on probe failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910221725.91980-1-mhun512@gmail.com>
References: <20260910221725.91980-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 22:30:04 +0000
Message-Id: <20260910223004.984FA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in probe error path due to missing hardware interru=
pt teardown.
- [High] Initialization race allows IRQ handler to execute before IRQ domai=
ns are created, leading to NULL pointer dereference or routing failures.
--

commit c3281f5a40eba7b88be1baec66979e22e39980ca
Author: Myeonghun Pak <mhun512@gmail.com>

    PCI: aardvark: Disable PHY on probe failures
   =20
    advk_pcie_setup_phy() initializes and powers on the PHY before the
    emulated bridge and IRQ domains are created.  If any of those later
    initialization steps or pci_host_probe() fails, probe returns without
    powering off or exiting the PHY.

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index ecb81ac730199..2bbdb73cfb45b 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1864,28 +1864,25 @@ static int advk_pcie_probe(struct platform_device=
 *pdev)
>  	ret =3D advk_sw_pci_bridge_init(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed to register emulated root PCI bridge\n");
> -		return ret;
> +		goto err_disable_phy;
>  	}
> =20
>  	ret =3D advk_pcie_init_irq_domain(pcie);

[Severity: High]
This isn't a bug introduced by this patch, but does the current sequence
create an initialization race?

Earlier in advk_pcie_probe(), the driver registers advk_pcie_irq_handler
with IRQF_SHARED:

	ret =3D devm_request_irq(dev, irq, advk_pcie_irq_handler,
			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
			       pcie);

It then unmasks hardware interrupts in advk_pcie_setup_hw().

If a shared interrupt fires, or if the hardware asserts an interrupt right
after advk_pcie_setup_hw(), the handler will execute before this software I=
RQ
domain is allocated. Could this cause generic_handle_domain_irq() to execute
with uninitialized (NULL) domain pointers?

>  	if (ret) {
>  		dev_err(dev, "Failed to initialize irq\n");
> -		return ret;
> +		goto err_cleanup_bridge;
>  	}

[ ... ]

> +err_remove_rp_irq_domain:
> +	advk_pcie_remove_rp_irq_domain(pcie);
> +err_remove_msi_irq_domain:
> +	advk_pcie_remove_msi_irq_domain(pcie);
> +err_remove_irq_domain:
> +	advk_pcie_remove_irq_domain(pcie);
> +err_cleanup_bridge:
> +	pci_bridge_emul_cleanup(&pcie->bridge);
> +err_disable_phy:
> +	advk_pcie_disable_phy(pcie);
> +	return ret;

[Severity: High]
This is a pre-existing issue, but does this error path leave a window
for a use-after-free?

The software IRQ domains are freed here, but hardware interrupts are not
explicitly masked (unlike in advk_pcie_remove()).

Because advk_pcie_irq_handler is registered with devm_request_irq(), it
remains active until after advk_pcie_probe() returns.

If a hardware or shared interrupt fires during this window, will the handler
execute and call generic_handle_domain_irq() with the freed domain pointers?

>  }
> =20
>  static void advk_pcie_remove(struct platform_device *pdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910221725.9198=
0-1-mhun512@gmail.com?part=3D1
