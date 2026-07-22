Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640935C183
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762686; cv=none; b=ZKwbPxkO9hjzk5G/lW+t8N7/Lt2vB1HtcogtMrr//Y3sGt1Rz5QdFumAA9xgiLHQg1/EEz2Nsxkq2FDP+3N5wsvS8NqeZnGGu2AYoq3/0WkRJiAAzIpVFsgHmWr/Fmj8ijN8sRtj3onEX++J+PmpQujWgbgRbih8jfUUdJSAjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762686; c=relaxed/simple;
	bh=t9VJOuILX+LSnlxOX1wKYhRozG24/sqFcDqwO3K81Og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jE99kOl4HCXZFtBQH3Tbfor0GWt/+Oa/U3xS4EpYTTX9eFxq+ggCW+Xp54yjxSE0sOIMbnaheQPWMf6hFT0t99/FN0a1EpAJ3YPhQTWZ2103Dva+aDqUzlDawbu7IWcvsSHKR7WnMZl3ZoM0Hkg7H1UfnYsKYytCQDZ7dxX8Jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZk1zuXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZk1zuXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC101F000E9;
	Wed, 22 Jul 2026 23:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762685;
	bh=Z/Cgp23g76Rgd17mBZtRKoTUyeFKNDZTJ9vOUYaY5ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZk1zuXIcKIkJndNNSFFw23E8UKxln0bG5NAgMiBP2SkC9wSuqKcN4e4zuNqHzmrb
	 qh724WPnhM8hViHylZgxPR3Pqa7m+TKNtndJ86NJNjaWNsG7BpLh/sKldodyTVzOzF
	 x4i+JZsVT3Y5eNzg5tJ+IEmmB2saBf7JCeHYIlJJ2THTbO42hhNc/x3zxhG2aTvHbW
	 moO7tfReRUKF0rjRla+CxJKunrpLrev3TF1C6qbo4qvMW6kQWlmO4im5aFrnE83Z8+
	 ssmmFA2vxXhN68FYslM4AVdi/tlE/XsryT7lCEmwOHB7AJz4apsATjhCUSOme2mlER
	 4uQuLhGAt4SVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: apple: use fwnode_irq_get() for port IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260722231214.857760-1-rosenp@gmail.com>
References: <20260722231214.857760-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:24:44 +0000
Message-Id: <20260722232445.4CC101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing teardown for partially initialized ports in `apple_pcie_in=
it()` leaves dangling chained IRQ handlers and leaked IRQ domains, leading =
to a Use-After-Free on probe error.
- [High] MSI parent IRQ domain is leaked on probe failure, leading to Use-A=
fter-Free on re-probe.
--

--- Patch [1]: [PATCH] PCI: apple: use fwnode_irq_get() for port IRQ lookup=
 ---
commit eab8bdc8d6046daad9b1ca1595a1c3a4a1b10540
Author: Rosen Penev <rosenp@gmail.com>

PCI: apple: use fwnode_irq_get() for port IRQ lookup

Replace irq_of_parse_and_map() with fwnode_irq_get() on the PCIe
controller device's fwnode. Propagate the error instead of checking
for zero, allowing negative errors like -EPROBE_DEFER to be handled.

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index c2cffc0659f44..535acf274b786 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -400,14 +400,13 @@ static int apple_pcie_port_setup_irq(struct apple_p=
cie_port *port)
>  {
>  	struct fwnode_handle *fwnode =3D &port->np->fwnode;
>  	struct apple_pcie *pcie =3D port->pcie;
> -	unsigned int irq;
> +	int irq;
>  	u32 val =3D 0;
> =20
>  	/* FIXME: consider moving each interrupt under each port */
> -	irq =3D irq_of_parse_and_map(to_of_node(dev_fwnode(port->pcie->dev)),
> -				   port->idx);
> -	if (!irq)
> -		return -ENXIO;
> +	irq =3D fwnode_irq_get(dev_fwnode(pcie->dev), port->idx);
> +	if (irq < 0)
> +		return irq;

[Severity: High]
This isn't a bug introduced by this patch, but returning the error here
(which can now be -EPROBE_DEFER) exposes a missing teardown path in
apple_pcie_init().

When apple_pcie_port_setup_irq() returns an error, apple_pcie_setup_port()
and then apple_pcie_init() abort without tearing down previously initialized
ports:

drivers/pci/controller/pcie-apple.c:apple_pcie_init() {
    ...
    for_each_available_child_of_node_scoped(dev->of_node, of_port) {
        ret =3D apple_pcie_setup_port(pcie, of_port);
        if (ret) {
            dev_err(dev, "Port %pOF setup fail: %d\n", of_port, ret);
            return ret;
        }
    }
    ...
}

Because the chained handlers (irq_set_chained_handler_and_data) and IRQ
domains (irq_domain_create_linear) set up for previous ports are not managed
by devres, they remain active.=20

Devres will free the port structures, so if an interrupt fires or a re-probe
occurs, won't apple_port_irq_handler() dereference a freed port pointer?

[Severity: High]
This is also a pre-existing issue, but propagating an error like
-EPROBE_DEFER here makes a leak in apple_pcie_probe() much more reachable.

If this error propagates up and causes pci_host_common_init() to fail in
apple_pcie_probe(), the MSI parent IRQ domain created earlier by
apple_msi_init() is not removed:

drivers/pci/controller/pcie-apple.c:apple_pcie_probe() {
    ...
    ret =3D apple_msi_init(pcie);
    if (ret)
        return ret;
    ...
    return pci_host_common_init(pdev, bridge, &apple_pcie_cfg_ecam_ops);
}

The domain created via msi_create_parent_irq_domain() is not devres-managed.
Devres will free the pcie structure on error, leaving the leaked domain's
host_data pointing to freed memory.=20

On re-probe, IRQ lookups will match the leaked domain, and
apple_msi_domain_alloc() will dereference the freed pcie pointer.=20

Should there be manual cleanup for the MSI domain when pci_host_common_init=
()
fails?

> =20
>  	port->domain =3D irq_domain_create_linear(fwnode, 32,
>  						&apple_port_irq_domain_ops,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722231214.8577=
60-1-rosenp@gmail.com?part=3D1
