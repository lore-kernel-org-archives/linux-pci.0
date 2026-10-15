Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB7231836;
	Thu, 15 Oct 2026 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035817; cv=none; b=dRtLNGq+7+7LY6FY6Bojt2otbi6GlwKy7R6a+Cg2Pqd1tyOYf/bKpEqiD46iGqRXW/piTt4cIEjCEqPkHnXtLGHsbxFg0dZ5aXSTPOTibhkLcYIXCPauXkvJ+qdSnh/dOI/nc7A8WySS+UR0rKcR89NwQCMBBqoSwTl6QgFn1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035817; c=relaxed/simple;
	bh=BWoHp+YAPgfcTVyY8kJKFbo0JeglMhtAdyvVyJ/IEtU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UtrwXSNwh/H30li1qbgkcag71NqZQFjVrKfRZDwpT3v6enfE85LUj+P+bZwDOcVisihcjftNt4uhcq4YWTTM0BN3gTNNn0f9SCC9BCXRnZfVupZpFL4IiIuHe6cUnlEQEuDCAdbu1QzE3FHbSLAHO/mVpSfVHozi8wrBbqrszP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGQVH+2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGQVH+2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2675C1F000C4;
	Thu, 15 Oct 2026 03:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035816;
	bh=qZ7SciTPz8zC3htd8nsl6KRpQ8rzqkGuuSlF+m9DnF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGQVH+2CZtWStPpeinxH+SlnRzzr/XzqBtS4vq/FRIl+j7Eh9vD+tiYIQHEF9iw7p
	 LP9KocmS6+7ylE6PBsgveE0sCUCSkke9VTBTrVm1xPhb6LOwX7+VaWxx/6QH7/ItSx
	 lWd0fI5aSIYDyASUblwsG3Gwbmhf7+z+WXkdq45aY38cJzFZ7WDdsGws3CdotTLnhf
	 YDIP/OMYgSGgjfeO+jGaP8Rn40Jfv2KBh9GVJy+CZ6F0HaLj4+SzjcJsc9pFewJZC+
	 0ZSYeWL3qAAW1Mh6Et/WrP5KdBk5OUMGcI6pJQUkMXS999ogj//LLb8BPAWm5DMW5m
	 H4/5JYtLH0ySg==
Message-ID: <sashiko-outbox-172218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/18] PCI: rcar-gen4: Take over the iMSI-RX
 interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261015033103.3076869-12-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:43:35 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: dwc: infinite interrupt loop on unmapped MSI
--

commit d7610b61a0b56b2000f9c7946a3b5317c331ed06
Author: Koichiro Den <den@valinux.co.jp>

PCI: rcar-gen4: Take over the iMSI-RX interrupt

On R-Car Gen4 SoCs, intreq_pcim_sub ("msi") carries more than the
integrated MSI receiver. This commit requests the interrupt in the driver
in all configurations and demultiplexes the MSIs through
dw_handle_msi_irq() in a dedicated handler.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 54260e62293b1..d51c0fc5ff363 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -613,6 +616,54 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pc=
ie_rp *pp)
>  	return ret;
>  }
> =20
> +/*
> + * intreq_pcim_sub carries the iMSI-RX interrupt along with other contro=
ller
> + * notifications, so the driver owns it instead of the DesignWare core (=
see
> + * pp->msi_irq[0]) and demultiplexes the MSIs itself.
> + */
> +static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
> +{
> +	struct rcar_gen4_pcie *rcar =3D data;
> +	u32 status;
> +
> +	status =3D readl(rcar->base + PCIEINTSTS0) &
> +		 readl(rcar->base + PCIEINTSTS0EN);
> +	if (!(status & MSI_CTRL_INT))
> +		return IRQ_NONE;
> +
> +	dw_handle_msi_irq(&rcar->dw.pp);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Can this cause an infinite interrupt loop if an unmapped MSI is received?

If a PCIe endpoint sends an unmapped MSI, generic_handle_demux_domain_irq()
returns false.

Because dw_handle_msi_irq() ignores this return value:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_handle_msi_irq() {
        ...
        for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
                generic_handle_demux_domain_irq(pp->irq_domain, irq_off + p=
os);
}

The write-1-to-clear hardware status bit in PCIE_MSI_INTR0_STATUS is never
cleared for the unmapped interrupt.

Since rcar_gen4_pcie_msi_irq_handler() unconditionally returns IRQ_HANDLED
when MSI_CTRL_INT is set, the un-cleared bit keeps the interrupt line
asserted. The generic IRQ subsystem's spurious interrupt detector won't step
in to disable the line because the handler claims it handled the interrupt.

Could this introduce a hard lockup if an untrusted endpoint triggers an
unmapped MSI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D11
