Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADA3AFCE6
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045674; cv=none; b=s3uJpz5Iw9jkFaSP1B71fynIMBTSAMVH6zgjwa+kKNCagn3mjSSS+sdi4OUTwX0WFO68vbVc6DWH6gYgJ8uqZKjtv4v7/8BAOiZvlPIAdOhnyo5vfpPkNP9AGb52cC2TMUEF3htBkVtuDUfq2MqcW5DrYeKjqULML/WUGquvJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045674; c=relaxed/simple;
	bh=Agj7zeeoNCFHTNLZ02avAu2lGXJEJZjAPrjZXACPBZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9BoW8mIYDFJq38uOZ22gCH2F5ZvEqR55EaASY7knzyh63p9oYRQwDUqYLCAv5+2tEeQOYgb+YX9ivFEdJihOGiB18XrjKPg2rPPGMc2qp/xeZvYdzy3Drjzfoecwmvi6dlAbn3tfOqjc/nrHa8EIOpSvFifA3NJWiANLnn1AKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiJzDHRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiJzDHRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC3C1F0089C;
	Tue, 22 Sep 2026 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790045667;
	bh=5TvFWJT3xT/l7e/vg1z1wZgL+TuqJFGHhR2Wo2t9C94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HiJzDHRTkWcThoP9fxfEnYmuQ9fy3F8yFu9fZxJvlPQpRd6MT0DKvsvihWyaR/Mdm
	 VnnIT6MiOi2H3XdG4yy4TBxK3+DLccXuqwCQ/11VxT2a49N8MutduuIp4j/U258/x2
	 BKyezppulwawlPLCseCZiesFHGpl3sfz0n0Ldlu60D3yrFMVJ3dD0F+/OY3kucGquY
	 HzTeNl7ynAWIIYLzaDDaAXFV8K4kPvOxkbas8abHyiEWLFe+SkydUARd3XbF35zCNp
	 8UXp1HYGp98sWWc1bFD324+6JePNTFuCkO2VDHxCSdtEgiFfjrYsALfdPx2cLgnOSN
	 MuM44VUYlSkaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] PCI: dw-rockchip: Make the INTx irq setup
 devm-managed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790044622-164744-3-git-send-email-shawn.lin@rock-chips.com>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <1790044622-164744-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 02:54:26 +0000
Message-Id: <20260922025427.5BC3C1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: dw-rockchip: INTx IRQ domain created too late for child devic=
es
- [High] PCI: dw-rockchip: missing .hwirq_max causes INTx IRQ mappings to f=
ail
- [High] PCI: dw-rockchip: missing synchronize_irq() in chained IRQ release=
 causes UAF
--

commit 94fa1be31fa024fc300334850bba499a495b5954
Author: Shawn Lin <shawn.lin@rock-chips.com>

PCI: dw-rockchip: Make the INTx irq setup devm-managed

The irq domain and the chained handler set up by the previous commit
are resources owned by the device, but nothing releases them if probing
ever fails after they are set up, and they are not tied to the device
lifetime in any other way either.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 59d9a1b095df6..561c296c770eb 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
[ ... ]
> @@ -187,9 +188,16 @@ static const struct irq_domain_ops intx_domain_ops =
=3D {
>  	.map =3D rockchip_pcie_intx_map,
>  };
> =20
> -static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
> +static void rockchip_pcie_intx_chained_release(void *data)
> +{
> +	struct rockchip_pcie *rockchip =3D data;
> +
> +	irq_set_chained_handler_and_data(rockchip->intx_irq, NULL, NULL);

[Severity: High]
Does this release function need a call to synchronize_irq() to prevent a
use-after-free?

Calling irq_set_chained_handler_and_data() with NULL masks the IRQ and remo=
ves
the handler, but it does not wait for any currently executing chained handl=
ers
on other CPUs to finish.

Since this is a devres cleanup action, the IRQ domain and the rockchip
structure (which was allocated with devm_kzalloc) will be destroyed and fre=
ed
shortly after this returns. If rockchip_pcie_intx_handler() is running
concurrently during probe failure, it could dereference the freed rockchip
structure or its destroyed irq_domain.

> +}
> +
> +static int rockchip_pcie_init_irq_domain(struct device *dev,
> +					 struct rockchip_pcie *rockchip)
>  {
[ ... ]
> -	rockchip->irq_domain =3D irq_domain_create_linear(of_fwnode_handle(intc=
), PCI_NUM_INTX,
> -							&intx_domain_ops, rockchip);
> +	rockchip->irq_domain =3D devm_irq_domain_instantiate(dev,
> +			&(struct irq_domain_info){
> +				.fwnode =3D of_fwnode_handle(intc),
> +				.size =3D PCI_NUM_INTX,
> +				.ops =3D &intx_domain_ops,
> +				.host_data =3D rockchip,
> +			});

[Severity: High]
Does this compound literal need to initialize .hwirq_max?

By omitting .hwirq_max, it defaults to 0. The core IRQ subsystem
(__irq_domain_create) assigns domain->hwirq_max =3D info->hwirq_max.

During interrupt mapping, irq_domain_associate_locked() validates mappings
with WARN(hwirq >=3D domain->hwirq_max). Because hwirq_max is 0, any valid
hardware IRQ (e.g., 0 to 3) will trigger this warning and cause the mapping
to abort with -EINVAL, disabling all INTx interrupts.

[ ... ]
> @@ -730,18 +743,27 @@ static int rockchip_pcie_configure_rc(struct platfo=
rm_device *pdev,
>  	 * which is also re-run by .reset_root_port(), so that the INTx irq
>  	 * domain is only created once, at probe time.
>  	 */
> -	irq =3D of_irq_get_byname(dev->of_node, "legacy");
> -	if (irq < 0)
> -		return irq;
> +	rockchip->intx_irq =3D of_irq_get_byname(dev->of_node, "legacy");
> +	if (rockchip->intx_irq < 0)
> +		return rockchip->intx_irq;
> =20
> -	ret =3D rockchip_pcie_init_irq_domain(rockchip);
> +	ret =3D rockchip_pcie_init_irq_domain(dev, rockchip);

[Severity: High]
Is this IRQ domain instantiated too late for child devices?

Earlier in rockchip_pcie_configure_rc(), dw_pcie_host_init() is called, whi=
ch
invokes pci_host_probe() to enumerate the PCIe bus and probe downstream dev=
ice
drivers.

Because the legacy INTx domain is not yet instantiated when those child
devices probe, pci_assign_irq() will fail to find the legacy domain, breaki=
ng
INTx interrupt mapping for downstream devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1790044622-164744-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D2
