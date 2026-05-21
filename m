Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304D1386C9
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387984; cv=none; b=GCoEdd1Cp3FxTbgeRcuHJsJhPAAfw98000X8J2ETFrin96CjYHGUB3XkjggKlPS2TV1ngZI/qo7oQIpgGW0TpAZMkWFL9vFYIra/PgLOZUCHp2QmBhuKu2TmRGYz8R9zaTZ/HgvJBnfUR8TwOfN8dc6ZePPpruwkh6kyHRvEXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387984; c=relaxed/simple;
	bh=ObuGx8Dlq4c951WzE4QLKVqwG/Kkc8D9GnbtBzoCBiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pk2mh30o8xpxNAm5h51XdW4hYbw3KgeOw7zRwNAmh2hb7DIVeX1Ww5UuYbYQQSiyyUY93pXVHQk7seHlP04sJp/pqMraswyazw8Xc/hVvDZIN/IFOvqToB2DiGtx5Ao0Sgq9AA6BRJTG0sK9axkaIvNMDAnuV3LFOxhi3JOeGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6gPi73w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6gPi73w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3891F000E9;
	Thu, 21 May 2026 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779387983;
	bh=wmjxfOhgYEgwuby5Jwk4Q4omWTomgGxZM7jenHqor+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6gPi73wG5+SOZO2nFzxRTdk+YxWL3Nc5v3PSSFyU5WuPontuHupXl0Qg5zXkDTNv
	 RInHBHBcR/A5SvnknMbLxPKUaaTmnkGhCvpCmTcfaFq6Ncg2QIpEm+UbwdlI5YANp/
	 x/uHAdQiDPgshzZX+Ul6iES2wjn8uODA9GEt9Hot/GPhqWzY4OghXXQZBGUOi3gVVq
	 NYZtULrFAs3maUgfh3EkBLiaNxtjFBd/c236s+uGCSgqt0pkWjPt43D9YYtJKZSH3F
	 NSg7MA7ukSddws9O0a3dcwh98apxK6cmwb/uUVCNn5X7xUr0Qe3LhQl13WZxa5Jpkh
	 FORUla4Skc7pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: mediatek: Fix IRQ domain leak when port fails
 to enable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521174617.17692-1-mani@kernel.org>
References: <20260521174617.17692-1-mani@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:26:22 +0000
Message-Id: <20260521182622.DC3891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Freeing the `port` structure in `mtk_pcie_resume_noirq()` on failu=
re without IRQ teardown leaves dangling pointers in active IRQ domains and =
chained handlers.
- [High] Probe error paths fail to tear down IRQ domains and chained handle=
rs if an error occurs after a port's IRQs are configured, leading to a Use-=
After-Free.
- [High] `mtk_pcie_resume_noirq()` illegally calls `clk_prepare_enable()`, =
which acquires a sleeping mutex, inside a NOIRQ suspend/resume callback.
- [High] A double powerdown occurs during driver removal if all ports faile=
d to link up during probe.
--

commit 9862107995188d91184cf0a5c63549b0feed587c
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: mediatek: Fix IRQ domain leak when port fails to enable

This commit fixes an IRQ domain leak by refactoring IRQ teardown into a
per-port helper and calling it when mtk_pcie_enable_port() fails.
mtk_pcie_enable_port() is modified to return an error code to distinguish
between probe and resume error paths.

Cc: stable@vger.kernel.org # 5.10
Cc: Caleb James DeLisle <cjd@cjdns.fr>

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 75722524fe744..907ae4285ecb1 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c

[ ... ]

> @@ -1109,8 +1117,13 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  		return err;
> =20
>  	/* enable each port, and then check link status */
> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> -		mtk_pcie_enable_port(port);
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		err =3D mtk_pcie_enable_port(port);
> +		if (err) {
> +			mtk_pcie_irq_teardown_port(port);
> +			mtk_pcie_port_free(port);
> +		}
> +	}

[Severity: High]
This is a pre-existing issue, but do probe error paths fail to tear down
IRQ domains and chained handlers if an error occurs after a port's IRQs are
configured?

Earlier in mtk_pcie_setup(), if mtk_pcie_parse_port() fails for a
subsequent port, or if mtk_pcie_subsys_powerup() fails, the function
returns the error directly.=20

This causes mtk_pcie_probe() to exit without calling mtk_pcie_irq_teardown(=
).
The devm subsystem automatically frees the allocated port structures, but t=
he
IRQ domains and chained handlers initialized for the previously successful
ports are never torn down. Does this leave them active with dangling pointe=
rs
to the freed port memory, leading to a use-after-free on the next interrupt?

>  	/* power down PCIe subsys if slots are all empty (link down) */
>  	if (list_empty(&pcie->ports))

[Severity: High]
This is a pre-existing issue, but does a double powerdown occur during
driver removal if all ports failed to link up during probe?

If all ports fail to link up during mtk_pcie_setup(), the driver calls
mtk_pcie_subsys_powerdown(pcie) but still successfully returns 0 from probe.

Later, if the driver is unbound, mtk_pcie_remove() unconditionally calls
mtk_pcie_put_resources(), which invokes mtk_pcie_subsys_powerdown(pcie)
again. Does this disable the clocks (e.g., free_ck) and call
pm_runtime_put_sync() for a second time, underflowing their respective
reference counts?

[ ... ]

> @@ -1209,14 +1222,18 @@ static int mtk_pcie_resume_noirq(struct device *d=
ev)
>  {
>  	struct mtk_pcie *pcie =3D dev_get_drvdata(dev);
>  	struct mtk_pcie_port *port, *tmp;
> +	int err;
> =20
>  	if (list_empty(&pcie->ports))
>  		return 0;
> =20
>  	clk_prepare_enable(pcie->free_ck);

[Severity: High]
This is a pre-existing issue, but does mtk_pcie_resume_noirq() illegally
call clk_prepare_enable() inside a NOIRQ suspend/resume callback?

The NOIRQ power management callbacks execute in an atomic context with local
hardware interrupts disabled. However, mtk_pcie_resume_noirq() calls
clk_prepare_enable() (both directly for pcie->free_ck and indirectly via
mtk_pcie_enable_port() for sys_ck, ahb_ck, etc.).

Since clk_prepare() inherently acquires a global mutex (prepare_lock), which
sleeps, will this trigger a 'sleeping in atomic context' bug?

> =20
> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> -		mtk_pcie_enable_port(port);
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		err =3D mtk_pcie_enable_port(port);
> +		if (err)
> +			mtk_pcie_port_free(port);
> +	}

[Severity: High]
This is a pre-existing issue, but does freeing the port structure in
mtk_pcie_resume_noirq() on failure without IRQ teardown leave dangling
pointers?

If a port fails to resume, the driver frees the port structure using
mtk_pcie_port_free(). However, because tearing down IRQs requires sleeping
locks, mtk_pcie_irq_teardown_port() is skipped here.

Does this leave active IRQ domains and chained interrupt handlers pointing
to freed memory, causing a use-after-free crash on subsequent hardware
interrupts or interactions with the IRQ domain?

>  	/* In case of EP was removed while system suspend. */
>  	if (list_empty(&pcie->ports))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521174617.1769=
2-1-mani@kernel.org?part=3D1
