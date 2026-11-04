Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793114;
	b=XvS/fHqE4ugYg6+ob+wWrKf3ynJFu+Qr4RoTvyBBxnrd8G2nHcw0q919Ka6+uK/gxZZn
	 tgN6iiOOE5/Wm83t26CaQXmCSgLQKp1QlatVc7p5pg1WQcPLOrl99Upk1vJaDUHBSfMj/
	 jSUDIIbpHc23RJaFWca8DMEDRtTI2QE2+7JJwRsUE05y3sKLvp8cvP6uDN58KQwzwMtSM
	 qQw8ar+wkR6ARG1eW2h+ChEz1AOz/AwJuW4ZWxODAoM34xdHJ4aSv+a7kL61TSipT9oZA
	 /eKZ5X0GhT6yZTt9rAK/CAQwE0LGQfeuewu+vGEU8Qsfs0n4yQgbL9bMHVWHjBiZ/kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EFBuj73oPdJKvRwxLJxK9CLRc9kA3FSTkIbUw/EBT0M=;
	b=FvXd63qRIDt7VpcBXarD1lx6wbpMORLxlUyVohumtl9XW391dIEg4WiFk54dkp6uK4WN
	 ADeL8kZqprd2qwu27qmUKQcKQQKDk4JHW4hL7IR44LNjCmR3g/zJ+11cj63R37fShjFkO
	 SzUeXfZ1HCuGnAu/EikfOzG3/+PmwO+0Tp9Fg9dLIJw3xwfb/wil1mBB/rcGXWix9D5zW
	 MaAg7E+KEhJHd6QOjPutBTJzHCBetkMl52yG39pO7MNlZEUoSl3r4RwwtTclQS4BRiE9F
	 dbL/1HvtBDmsyg/Mrg4P6cc0yYn0tQR2HzZK8+PGyhoeI5oVPpIVFPiLH3V+0dL3KvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLsvR4x0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08341606A329;
	Wed,  4 Nov 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLsvR4x0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D88D1F000C1;
	Wed,  4 Nov 2026 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793793113;
	bh=EFBuj73oPdJKvRwxLJxK9CLRc9kA3FSTkIbUw/EBT0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLsvR4x0e5jkKOViJh2p9Z6eEbC2rvzJ3lmmrKWIeVMv2UqCw5VG4seuzEN5wT6Lh
	 y/89lmcYzTZ+BdTuX+7gNUJY3MOXI7xBaQ8nGjXOKK7G7taC9Oy0z0TSUWqKLLDFDH
	 QFe3td7eVx3PS3KLrQQPuLXm/UUtmcxHrYsPMj35hM9849SRWGnXls65N2GPAAKC+E
	 sz8iqo1gss2nyh4mNYyS+eFLuZpmP/gAiYv7KGV3mh8tFX2grgouRx4lnzJjjd2fUd
	 bcRIYSqxXk7ZMKH8vY4/2KH4GzeA8bGaWrHgPjJNvRi6Stw08aI3XhIMtJbIVzkSgz
	 a6Zwn1ZD4U+RA==
Message-ID: <sashiko-outbox-197213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: apple: Integrate pwrctrl API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104-apple-pcie-pwren-v2-2-216a4066965f@cyberchaos.dev>
References: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
 <20261104-apple-pcie-pwren-v2-2-216a4066965f@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 11:51:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: apple: unbalanced pwrctrl power and device cleanup in apple=
_pcie_init()
--

commit 3ba5f942a54bed93131c2e3157428ab3600ebf03
Author: Yureka Lilian <yureka@cyberchaos.dev>

PCI: apple: Integrate pwrctrl API

This commit integrates the PCI pwrctrl API into the Apple PCIe host
controller driver so child port devices are created and powered on before
setting up the ports in apple_pcie_init().

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index c2cffc0659f44..2d32092e2122b 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c

[ ... ]

> @@ -825,6 +826,28 @@ static int apple_pcie_init(struct pci_config_window =
*cfg)
>  	if (WARN_ON(!pcie))
>  		return -ENOENT;
> =20
> +	// Ensure all ports can be powered on before attempting initialization
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret =3D pci_pwrctrl_create_device(of_port, pcie->dev);
> +		if (ret) {
> +			dev_err(pcie->dev, "Failed to create pwrctrl device: %pe\n", ERR_PTR(=
ret));
> +			return ret;
> +		}
> +
> +		ret =3D pci_pwrctrl_power_on_device(of_port);
> +		if (ret) {
> +			if (ret !=3D -EPROBE_DEFER) {
> +				dev_err(pcie->dev,
> +					"Failed to power on device: %pe\n",
> +					ERR_PTR(ret));
> +				for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +					pci_pwrctrl_destroy_device(of_port);
> +				}
> +			}
> +			return ret;
> +		}
> +	}
> +
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		ret =3D apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {

[Severity: Medium]
Can this loop in apple_pcie_init() leave pwrctrl devices powered on or leak=
ed
when an error or probe deferral occurs on a multi-port controller?

If an earlier port succeeds in both pci_pwrctrl_create_device() and
pci_pwrctrl_power_on_device(), and a subsequent port fails in:

1. pci_pwrctrl_create_device(): apple_pcie_init() returns immediately witho=
ut
   powering off or destroying the pwrctrl devices created and powered on in
   previous iterations.

2. pci_pwrctrl_power_on_device() with -EPROBE_DEFER:
   pci_pwrctrl_power_on_device() only unwinds children of the failing port
   node, leaving earlier sibling ports powered on. When deferred probing
   retries apple_pcie_init(), pci_pwrctrl_power_on_device() is called again
   on the earlier ports, enabling their regulators and clocks a second time
   and leaking enable reference counts on every retry.

3. pci_pwrctrl_power_on_device() with a non-deferral error: the error path
   calls pci_pwrctrl_destroy_device() without first calling
   pci_pwrctrl_power_off_device() on the ports that were already powered on,
   which unregisters active pwrctrl platform devices and frees regulators
   while they are still enabled. The inner
   for_each_available_child_of_node_scoped(dev->of_node, of_port) loop also
   redeclares of_port and shadows the outer loop variable (-Wshadow).

4. apple_pcie_setup_port() in the second loop: if port setup fails or retur=
ns
   -EPROBE_DEFER (for example from devm_fwnode_gpiod_get()), apple_pcie_ini=
t()
   returns without powering off the pwrctrl devices enabled in the first lo=
op
   or destroying them on non-deferral errors.

Would it be cleaner to use the controller-level helpers
pci_pwrctrl_create_devices(), pci_pwrctrl_power_on_devices(),
pci_pwrctrl_power_off_devices(), and pci_pwrctrl_destroy_devices() with goto
error unwinding so all ports are balanced properly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-apple-pcie=
-pwren-v2-0-216a4066965f@cyberchaos.dev?part=3D2
