Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D544921A6
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185131; cv=none; b=TuqVwXTQ2AZyocY2RYEQUzZ+mjr8/E53+3Bq8w4BkREaZfBDzvNKauIOGZQp+NJbvFcTzaDBBvBpgGNtUeeutGnRrN2y8O3T7NL9usgkxsS21jfOyMalKqpzGcuVZK88LF2diI2OC9xPdIAj1SfG0jZ0st7AW3Lj3POVVjEF7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185131; c=relaxed/simple;
	bh=J5uFUomoOhL0NAhdea8vzxoVDbVOBWHpwDWrmiLfd6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tOVr0+/m4FB9nlX4609fc2l6V1TbgTBih4T9f/L5qrDshgPIjj5NUQwomB6LSPSdcvuEYiOZpTy29U0Iph/povX87kPv0+IbHoHEzY0Jb8sXFaF82n3UV6+jp8aD8oqWdNEA9oXbXy9fdcXInAOWPAwdktuMDX8mDkJPZ+eLIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3CAaU1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3CAaU1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815DD1F000E9;
	Mon, 31 Aug 2026 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185128;
	bh=QJdP8CsFx6dtEXTqkBJZ9BpE9oit/ecFkn0hEftcvW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3CAaU1xZG6AzbyMduWnAGKMLowg42dP6yA8F3I1xxkmF0uTCgNqWIBMGFDlx7eoz
	 h2bO3G7+yQk/Bd5Z+J4UG8beOXhVS0So9OV7qe2jlEd97jiWdsbfWlRq+o8Mmorh8f
	 Ke5Vrlx1PzfRWZuHuE5QdgjIIITBrw84mVi8CDtcZlQXewv9ghaPpXlpPdCz5vcBsy
	 Peqp70g1F9FPdtGGzUIcnsV4CqMjVDbIIfSnvNS7MXW9uIveYmAcE9KbZwz3og7/vU
	 UUE7diBcL7X29KMD7FrixBb4qeTOfz/zIWbx0mCChXIToLRhTZ0diX23A3tKrdQcAW
	 dDD9VDzKnY85g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: altera: Protect root bus removal
 with rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-58-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-58-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:05:28 +0000
Message-Id: <20260831140528.815DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing cleanup =
of IRQ domain and chained handler in altera_pcie_probe() error paths leads =
to a resource leak and potential Use-After-Free.
--

commit c2931eaed1e42d3e3d53dfa366745c5d1ac05fe3
Author: Hans Zhang <18255117159@163.com>

PCI: altera: Protect root bus removal with rescan lock

Hold the pci_rescan_remove_lock lock while stopping and removing a root bus
to avoid racing with concurrent rescan or hotplug operations triggered via
sysfs. Such races may lead to use-after-free issues or system crashes.

Link: https://patch.msgid.link/20260521161822.132996-4-18255117159@163.com

> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controlle=
r/pcie-altera.c
> index 3dbb7adc421c4..7e1db267ae342 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -1045,8 +1045,10 @@ static void altera_pcie_remove(struct platform_dev=
ice *pdev)
>  	struct altera_pcie *pcie =3D platform_get_drvdata(pdev);
>  	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie);
> =20
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
> +	pci_unlock_rescan_remove();
>  	altera_pcie_irq_teardown(pcie);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does altera_pcie_probe() leak
the IRQ domain and leave a chained IRQ handler pointing to freed memory on
error?

In altera_pcie_probe(), altera_pcie_parse_dt() installs a chained IRQ handl=
er:

drivers/pci/controller/pcie-altera.c:altera_pcie_probe() {
    ...
	ret =3D altera_pcie_parse_dt(pcie);
	if (ret) {
		dev_err(dev, "Parsing DT failed\n");
		return ret;
	}

	ret =3D altera_pcie_init_irq_domain(pcie);
	if (ret) {
		dev_err(dev, "Failed creating IRQ Domain\n");
		return ret;
	}
    ...
}

If altera_pcie_init_irq_domain() fails, it returns directly without clearing
the chained IRQ handler.

Similarly, if pci_host_probe() fails at the end of the function:

drivers/pci/controller/pcie-altera.c:altera_pcie_probe() {
    ...
	return pci_host_probe(bridge);
}

The function returns the error directly, which causes devres to free the
pcie structure. However, the chained IRQ handler is still active and will
now point to freed memory, potentially causing a Use-After-Free crash if a
shared interrupt fires. Also, the irq domain allocated in
altera_pcie_init_irq_domain() is leaked.

Should altera_pcie_probe() use goto error paths to call
altera_pcie_irq_teardown() on these failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-58-sashal@kernel.org?part=3D1
