Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBF2EBDDE;
	Mon,  6 Jul 2026 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378776; cv=none; b=ADlxXhlm5X2P+cQlz3hG3g/61UIKo9Ha0EocsoNSLRqmGYyUnRVqQuE4/SFUf5at1R2dFaShx8RTJP/LvB2goaqJSE5LbAI8ZIhQ/Y7BqlTu8hQCTMzX+tB9KtqievsjFnK4JGAYzev8u5+eXdqEsVmi1pf0IRaK8d5Nj9eznOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378776; c=relaxed/simple;
	bh=ptqgcGp5cRHqyL3XeoeWvjzM/BM58yDGqarH5YbanTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=auOve8K/8r/qPa8c+jDoiwFskzJkUWifZhmeHeexbSQaJzS+cMq6++AvrLu/jHaCfXuuQN0b5Oz6ghjO9rBWjwo8p5YWEHNbJgXE/J++io6fm1Nfo1Kb3Ctu+6VjlOesXufhrnV6gN7RNiBIQHtrOTnss5aqDrGUIIW7R1VF2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlrfT22K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlrfT22K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2491F000E9;
	Mon,  6 Jul 2026 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783378774;
	bh=saA9KT9maPK2PRUwGt1UO16/rxvb6cwmEV5YwfrJ9us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LlrfT22KHAcMFYN9x/qCLhBUceHLMRid/obD19e+wm8a2rWtzmf8W8krF1KZMnHpq
	 2GobgEaSJk9iioZobJTESThfPlP3jd9WVfkF8JXArhokkBK9D872n+b1+59L//QxSg
	 d5h5+ERUKF4NfDgNFmKn/8WxdA3a0VB7Q8qIxnftH9Ngl7rVuAg7pcX++MGsQsJWzC
	 LRF7zZH3kRzQM8DqcAA/Jbk9r2eiyQLuTa64pzBAyNUvV7X6pPrxJQ6Ws6NrouG5Hv
	 qnpbhuLziE5CAd6H0TVIcLjuLK9CLKtCCdjGp3F91MbZulcqArqWa0Xl73N1tnX1LP
	 9hJTztXfU9ImQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: apple: Integrate pwrctrl API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260707-apple-pcie-pwren-v1-1-5a281b182fe2@cyberchaos.dev>
References: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
 <20260707-apple-pcie-pwren-v1-1-5a281b182fe2@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 22:59:34 +0000
Message-Id: <20260706225934.9B2491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing cleanup of PCI pwrctrl devices on error paths in apple_pci=
e_init().
- [Medium] Using the `%pe` format specifier with an integer error code inst=
ead of an error pointer.

Pre-existing issues:
- [Critical] Use-After-Free and resource leak of port IRQ handlers and doma=
ins on probe failure.
- [High] MSI IRQ domain is permanently leaked on probe deferral, heavily ex=
acerbated by the new pwrctrl deferred probing.
--

--- Patch [1]: [PATCH 1/2] PCI: apple: Integrate pwrctrl API ---
commit 937db91081c31bded4a8e5eaa8859cec8bb3fc57
Author: Yureka Lilian <yureka@cyberchaos.dev>
Subject: PCI: apple: Integrate pwrctrl API

This patch integrates the PCI pwrctrl framework into the Apple PCIe host
driver to provide standardized power management. It allows powering on
devices like WiFi and SD card readers using the pci-pwrctrl-generic
driver before probing the ports.

Link: https://lore.kernel.org/lkml/20220502093832.32778-4-marcan@marcan.st/

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index c2cffc0659f44..db038a9d4831f 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c

[ ... ]

> @@ -825,6 +826,21 @@ static int apple_pcie_init(struct pci_config_window =
*cfg)
>  	if (WARN_ON(!pcie))
>  		return -ENOENT;
> =20
> +	ret =3D pci_pwrctrl_create_devices(pcie->dev);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to create pwrctrl devices: %pe\n", ret);

[Severity: Medium]
Are we using the %pe format specifier with an integer error code instead
of a pointer here?

Passing the 32-bit integer ret directly might cause undefined behavior on
64-bit architectures, or print a hashed pointer address instead of the
actual error string since IS_ERR() evaluates to false.

Should this be cast with ERR_PTR(ret)?

> +		return ret;
> +	}
> +
> +	ret =3D pci_pwrctrl_power_on_devices(pcie->dev);
> +	if (ret) {
> +		if (ret !=3D -EPROBE_DEFER) {
> +			dev_err(pcie->dev, "Failed to power on devices: %pe\n", ret);

[Severity: Medium]
Is this %pe format specifier also receiving the integer ret directly
instead of a pointer?

> +			pci_pwrctrl_destroy_devices(pcie->dev);
> +		}
> +		return ret;

[Severity: High]
This is a pre-existing issue, but does returning -EPROBE_DEFER here
exacerbate a memory leak in apple_msi_init()?

Because pci_pwrctrl_power_on_devices() relies on of_platform_device_create()
spawning child devices that probe asynchronously, it seems this might
frequently return -EPROBE_DEFER.

Earlier in the probe path, apple_msi_init() creates an MSI domain via
msi_create_parent_irq_domain(), but lacks a devm_add_action() to clean
it up.

If we defer probe here, do we permanently leak the previous MSI domain and
pcie->bitmap allocations on each retry?

> +	}
> +
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		ret =3D apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {
>  			dev_err(dev, "Port %pOF setup fail: %d\n", of_port, ret);
>  			return ret;

[Severity: High]
If apple_pcie_setup_port() fails and we return ret here, do we bypass
tearing down the successfully created pwrctrl devices?

If pci_pwrctrl_create_devices() and pci_pwrctrl_power_on_devices()
succeeded earlier, it seems this error path leaves the hardware powered on
indefinitely and leaks the child platform devices since they are not
devres-managed.

Should we call pci_pwrctrl_power_off_devices() and
pci_pwrctrl_destroy_devices() before returning?

[Severity: Critical]
This isn't a bug introduced by this patch, but could this error path lead
to a use-after-free and resource leak of port IRQ handlers?

If the loop successfully sets up the first port but fails on a subsequent
port, the probe fails and devres frees the struct apple_pcie_port for
the successful port.

However, looking at apple_pcie_port_register_irqs(), it registers the
handler using request_irq() without devm:

drivers/pci/controller/pcie-apple.c:apple_pcie_port_register_irqs() {
    ...
    ret =3D request_irq(irq, apple_pcie_port_irq, 0, port_irqs[i].name, por=
t);
    ...
}

Similarly, apple_pcie_port_setup_irq() uses
irq_set_chained_handler_and_data() without a devm teardown.

Since the IRQs remain active, could an incoming interrupt trigger the
handlers and dereference the freed port structure?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-apple-pcie=
-pwren-v1-0-5a281b182fe2@cyberchaos.dev?part=3D1
