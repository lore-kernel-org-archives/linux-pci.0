Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88323ABB9
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208984; cv=none; b=ZEqTu5OKYoPOdmdMX94utn0jNq4pE/eXfc/2q2Dj+3Eqb0/nKm1CQF8S/l/YSAfDYRhFP7O0ESZOkMFBVjDKeBzuwcObJBeHxD8vjelwI9xYSgGOzz3QoCYI75C2DB0UMIYhBt81ABCtqAk4XN7wIB0HD0wSK4biIe16IL1ca90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208984; c=relaxed/simple;
	bh=QAz+01pBqj0G9k5/7aHpKN53mISj2mmPYKyO+lWd3ao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UanC6Ec/9rYiW+m74e3moyEJb+Kd7/F4OoQAIMr4SlPCgg39gPjD4H84bDXfGZRY+A08wW4w4JB7rmDpi9UdLwKPz0jCmy6qSpOrOCcAATYMGYaySv20FHHVCriba8RmqR7TZxHqWwA4u4r8C8sIcnFK+na6EVqW+Jn1MSnLP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcQIn6VM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcQIn6VM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2011F1F000E9;
	Thu, 11 Jun 2026 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208983;
	bh=D9Ire8jOazNWoKvjPv5YCj8HJPUuoO1ZcGx/94lv+Ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JcQIn6VM6p+ZBj6+hmI4MYgIOHLNWpIad1FZIG+Q4kBMLQ1c2bU+DH+z6ZWHA27al
	 I+i38s42uuEZfaLllI5O52xhdVL2TLCG9coeOOd5L8UoqzaNtb3oKBtNRrz5EGYsmP
	 nbn9LC0kVqwQqRqHqBcF1UibqaoE1qr3hJm2NXRtgWJNaBtaPWwOR3sh5/y0Pb1QSO
	 0KQelQlqA0W/FXdhAXvddj8Kjwtwk8LzKP3ZnpnTFUumduWHZtfBH3k8ghyIFWwx+3
	 +SqBWgGLwrXkt7KCD8v5sAh6JtpWXgdDzQ/JBXIknwPjEosJhToXLO80OLDlVzB80+
	 9WgWYdUYqzmwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] PCI: rockchip: drive at 2.5 GT/s, error other
 speeds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <4ac5cd7d2271df375ed6307f5c394247721395d9.1781207474.git.geraldogabriel@gmail.com>
References: <4ac5cd7d2271df375ed6307f5c394247721395d9.1781207474.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:16:22 +0000
Message-Id: <20260611201623.2011F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Omitting the optional `max-link-speed` device tree property caus=
es a spurious "invalid max-link-speed" warning on every boot.
- [Low] The warning "5.0 GT/s may cause data loss or worse" in `rockchip_pc=
ie_init_port()` is unreachable dead code.
--

commit af559876a98865f8e79209df2d4604f56fef03fd
Author: Geraldo Nascimento <geraldogabriel@gmail.com>

PCI: rockchip: drive at 2.5 GT/s, error other speeds

Configure the core to be driven at 2.5 GT/s Link Speed and ignore any
other speed with a warning. Also drop the 5.0 GT/s Link Speed defines
from Rockchip PCIe header.

Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock=
-chips.com/

> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/control=
ler/pcie-rockchip.c
> index 0f88da3788054..5a2876d7c8547 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockc=
hip)
>  	}
> =20
>  	rockchip->link_gen =3D of_pci_get_max_link_speed(node);
> -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> -		rockchip->link_gen =3D 2;
> +	if (rockchip->link_gen < 0 || rockchip->link_gen >=3D 2) {
> +		rockchip->link_gen =3D 1;
> +		dev_warn(dev, "invalid max-link-speed, limited to 2.5 GT/s\n");
> +	}

[Severity: Medium]
Will this cause a spurious warning on every boot if the optional
"max-link-speed" device tree property is omitted?

If the property is not present, of_pci_get_max_link_speed() returns
-EINVAL, which is less than 0. This condition catches that negative return
value and triggers the "invalid max-link-speed" warning, even though omitti=
ng
an optional property is a standard configuration.

[ ... ]

> @@ -147,12 +149,12 @@ int rockchip_pcie_init_port(struct rockchip_pcie *r=
ockchip)
>  		goto err_exit_phy;
>  	}
> =20
> +	/* 5.0 GT/s may cause catastrophic failure for this core */
>  	if (rockchip->link_gen =3D=3D 2)
> -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
> -				    PCIE_CLIENT_CONFIG);
> -	else
> -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> -				    PCIE_CLIENT_CONFIG);
> +		dev_warn(dev, "5.0 GT/s may cause data loss or worse\n");

[Severity: Low]
Is this warning unreachable dead code?

In rockchip_pcie_parse_dt() executed earlier during probe,
rockchip->link_gen is explicitly capped to 1 if it is >=3D 2.
Therefore, when this check in rockchip_pcie_init_port() evaluates
whether rockchip->link_gen =3D=3D 2, it appears it will always be false.

> +
> +	rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> +			    PCIE_CLIENT_CONFIG);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781207474.gi=
t.geraldogabriel@gmail.com?part=3D3
