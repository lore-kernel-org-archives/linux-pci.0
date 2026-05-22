Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483D22157B;
	Fri, 22 May 2026 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422492; cv=none; b=lMUtMc+Bq3poz3z3mgDJlTQyamsLhaPbzpjj4G521/tBwkzlBYPaXRTgKh+fjZDLFfRcjjKOmDzlyqUS6PffRaBYU6mpTCaVYFSTGvSrxu/pCM32kregF4/E+r/aiaV+IuQz0OhDC9QiyieE7qLzC/Y7xUkxWEKgr1wKZbbc8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422492; c=relaxed/simple;
	bh=mbHMInABReGAj2NLjQXB5oscNNzssjOsLsuFGBc/JNA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sWBZfkmShieSjJ+8qsZ1Ra6r4huqSuOGEv9rIBQ94njIcz28dck3OC+Q3S5n0Y/hWJr2ADp70BRJILmDVzcK3u4Uv3yQWOa5sKieDTLMKkVtO9Wb8wSnnqgyY4whaYHL5J342lRitDcby6qtiKLN47lpHWd3XU+uoLOFC9s5Z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic2YBii7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic2YBii7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CC51F000E9;
	Fri, 22 May 2026 04:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779422490;
	bh=FpPfUfMTJnvqt4DzWIIquzo8LPKMhOp91499+HALK8o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ic2YBii7bzIgqC0ecEDX5oYqdt8n5R5pciJlf8Bv/0C+7qZR0bwlFil/rAsyVdWx4
	 9xJVTaQAUys6JdvU/mc5FCehJ+zEuNTO61B/Cz7bEWnwGebQHTtkqd0ErX5/2VELQc
	 J3mdyekZcWGTTYOvp8A7TWviKVF/m0jWwlM9jJZCMgjb/KI76EnVSQhjfWdd6+xw2b
	 k5g/Jm6yotdGxdfQIuM6Sfvd046GpVm3StyJbjBf0gHwyjBmJ0AEFaI9SsvL5jSqGN
	 xXiEz1PdDA3ApIbtqkDXVz6RlNGse4UPQLy3rKWQVqrQlAxsTEnYVD6WvUlBainVkC
	 SIl7TX1078tsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: host-generic: Simplify return value handling
 in pci_host_common_parse_port(s)
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260522034344.1147775-2-sherry.sun@oss.nxp.com>
References: <20260522034344.1147775-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 04:01:28 +0000
Message-Id: <20260522040130.66CC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Changing the return value of `pci_host_common_parse_ports()` to 0 =
instead of `-ENODEV` silently breaks the legacy device tree fallback logic =
in `imx_pcie_host_init()`.
--

commit 8c94bf783e4da5a465164e0d82606c1c5b6786e2
Author: Sherry Sun <sherry.sun@nxp.com>

PCI: host-generic: Simplify return value handling in pci_host_common_parse_=
port(s)

This commit simplifies pci_host_common_parse_port() by removing the
RC-level binding check, leaving it as a policy decision for the caller.
It also changes pci_host_common_parse_ports() to return 0 when no ports
are found, instead of -ENODEV.

> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-host-common.c
> index 67455caaf9e68..7ce5a939e3d94 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
[ ... ]
> @@ -158,13 +141,11 @@ static int pci_host_common_parse_port(struct device=
 *dev,
>   * Iterate through child nodes of the host bridge and parse Root Port
>   * properties (currently only reset GPIOs).
>   *
> - * Return: 0 on success, -ENODEV if no ports found or PERST# found in RC
> - * node (legacy binding should be used), Other negative error codes on
> - * failure.
> + * Return: 0 on success, negative error codes on failure.
>   */
>  int pci_host_common_parse_ports(struct device *dev, struct pci_host_brid=
ge *bridge)
>  {
> -	int ret =3D -ENODEV;
> +	int ret =3D 0;
> =20
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		if (!of_node_is_type(of_port, "pci"))
[ ... ]
> @@ -174,8 +155,8 @@ int pci_host_common_parse_ports(struct device *dev, s=
truct pci_host_bridge *brid
>  			goto err_cleanup;
>  	}
> =20
> -	if (ret)
> -		return ret;
> +	if (list_empty(&bridge->ports))
> +		return 0;

[Severity: High]
Does changing this return value to 0 break the legacy device tree fallback
logic in imx_pcie_host_init()?

Before this patch, pci_host_common_parse_ports() returned -ENODEV if no
ports were found or if a legacy reset-gpios property was detected in the
Root Complex node. The caller imx_pcie_host_init() explicitly relies on
ret =3D=3D -ENODEV to safely fall back to imx_pcie_parse_legacy_binding().

By removing the RC-level check and returning 0 on empty lists,
imx_pcie_host_init() will see success instead of an error, completely
bypassing the legacy binding fallback. This would cause the PERST# GPIO
to never be parsed or requested, leading to device initialization failure
on i.MX6 platforms using older legacy device tree bindings.

I see that this issue is fixed later in the series by a subsequent commit
("PCI: imx6: Add imx_pcie_perst_found() to inspect the parsed result").
However, kernel rules require each intermediate patch to be self-contained
without introducing regressions. Does this intermediate state break
bisectability for i.MX6 platforms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522034344.1147=
775-1-sherry.sun@oss.nxp.com?part=3D1
