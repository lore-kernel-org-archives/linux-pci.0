Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136490;
	b=PY/huTC2ecW/kYxXL0XIbC2J/1GP1HAQ8NVpD1yV257n8HS8cHTxw6Y5t23KfMCdqPY1
	 mRxREHRdr8kNR6xd/ivkGRrQsetgT0BXd7J7zeqRYCiP71CMRyuKKggQcRs93605wHNXk
	 CbYkMwq6HovouMM7PW0PmZShxgl6BLneiiLKRcr08/COBnVkUWTa7gmTPxTnnpBoMKhyX
	 VhJ0aUAX4cVznM7c2eFFAXWckgGIrV/abKAv/aYf8C93qbcBvzomCEhdMkkLlQNlRJJUp
	 1JhashX5K3fLiAysZRq7gE8puR+m0OiwR0H+AYDi32ycpgG5WO6AulCN1hIotfdFVTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136490;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YTdcCuB9JWlIyTeyv1TrVOf8M4O/B+x6kvbL17vKCAg=;
	b=dfbzmWUrlIn5AuMw7MkdGvYXHHsbwOrn9FuTlt1hAD1vQpd5ZfjFNrXJaW50EQQ1RkJ3
	 p+spQQEGG/1Lcdk6GWSHP7KdD7vDpcD5JWfc8rWycwtYA50YftmIMI/90EowCKV6pj4zD
	 v9uJRsj0knGpmW1ibM5KOl1tB3SFFFHm2Ktco5xSZVGvo10nqAM/mwBzi0haBw716/ZHA
	 OOvVlrJX+N2Z7ZGUQOHSzkKGCD5UAHjU8lCGzEiVWRqXb9mMXqEAJf4W9FYPhOp8OE7qx
	 5zs8zAQY1WaXEUYSHptxyvs5nMCrKwdcQUnW0lJ/+w/UiPWLHKFaO5vtrjUi7a+o9BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLyiyQ2d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA68606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLyiyQ2d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C81F0089F;
	Sun,  8 Nov 2026 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136489;
	bh=YTdcCuB9JWlIyTeyv1TrVOf8M4O/B+x6kvbL17vKCAg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DLyiyQ2duDQ6Vnf81WOLexvtsFQcTBVS8ZRpNmkNujiFtDkqxmcYOBunCI41+2zg1
	 KbNWhRGhRWB9J6g5WhU5uHy7Ft81TiPNVWgc3Ufv4aTbctMtZeX0G6wY3CiDd1jDli
	 TGerfyP3SdhQNJIYN0/JKTBnaleOf9U/EwrKXw0f6+yEklb4pfIDyloGoAhvLD+e7y
	 K/LMYg87KgDbizByTt3vR0rat/aXu8oBR6QRC1GAMIgWubrF1ixaagwF9D+ruwDl2a
	 nn7E0yWgL7dm4Yp7lvfs8krWkWVmqVIRV5DtPwjilPRq/4mv7QEJuD1lajVnwAKsRY
	 2RI0XV6jT1wJA==
Message-ID: <sashiko-outbox-203690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: apple: Fix ECAM config window use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xu" <getshell@seu.edu.cn>, linux-pci@vger.kernel.org
In-Reply-To: <20261108105640.875-2-getshell@seu.edu.cn>
References: <20261108105640.875-1-getshell@seu.edu.cn>
 <20261108105640.875-2-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 11:14:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI: apple: incomplete IRQ and domain teardown in
  pci_host_common_remove()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] PCI: apple: MSI irq_domain leak and use-after-free in
  apple_pcie_probe() [1]
--

commit 6595d3b06ad4c1310264ede81b930782370102fe
Author: Hongyan Xu <getshell@seu.edu.cn>

PCI: apple: Fix ECAM config window use-after-free

This commit wires pci_host_common_remove() as the platform driver remove
callback so the PCI root bus is removed before devres frees the ECAM
configuration window.

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index c2cffc0659f44..a1e8a3a0ef1dc 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -886,6 +886,7 @@ MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
> =20
>  static struct platform_driver apple_pcie_driver =3D {
>  	.probe	=3D apple_pcie_probe,

[Severity: Critical]
This problem wasn't introduced by this patch, but does apple_pcie_probe()
leak the MSI parent irq_domain [1] if pci_host_common_init() fails?

apple_msi_init() creates an unmanaged IRQ domain via
msi_create_parent_irq_domain() with host_data set to the devm-allocated
struct apple_pcie before calling pci_host_common_init():

drivers/pci/controller/pcie-apple.c:apple_pcie_probe() {
	...
	ret =3D apple_msi_init(pcie);
	if (ret)
		return ret;

	return pci_host_common_init(pdev, bridge, &apple_pcie_cfg_ecam_ops);
}

If pci_host_common_init() fails or defers (for example when
apple_pcie_setup_port() defers on GPIO or reset acquisition), devres frees
bridge and pcie->bitmap while the MSI irq_domain stays on irq_domain_list
with a dangling host_data pointer, causing a use-after-free on subsequent
domain lookups or probe retries.

> +	.remove	=3D pci_host_common_remove,

[Severity: High]
Does wiring pci_host_common_remove() alone leave the unmanaged IRQ
domains, port interrupts, and chained handlers active after rmmod?

During probe, apple_msi_init() registers an unmanaged MSI parent domain
via msi_create_parent_irq_domain(), and for each port
apple_pcie_setup_port() takes an OF node reference via of_node_get(),
creates a linear IRQ domain via irq_domain_create_linear(), sets
apple_port_irq_handler() via irq_set_chained_handler_and_data(), and
requests link up/down virqs via request_irq().

pci_host_common_remove() only removes the PCI root bus.  When rmmod
runs, devres frees struct apple_pcie and struct apple_pcie_port and unmaps
MMIO, and free_module() unmaps the module text and rodata while those IRQ
domains and handlers remain registered.  Reading /proc/interrupts or
receiving a port interrupt then faults on unmapped module memory and
freed port state.  Should this driver either use builtin_platform_driver()
(matching .suppress_bind_attrs =3D true) or provide a remove callback that
masks port interrupts and tears down the requested IRQs, chained handlers,
IRQ domains, and OF node references?

[1] https://sashiko.dev/#/bug/linux-93248aea-1b69-486f-9e9f-a90f7de2b348

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108105640.875-=
1-getshell@seu.edu.cn?part=3D1
