Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D44F3923;
	Mon, 28 Sep 2026 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615177; cv=none; b=irY6jZB0dyLDvcz/KlAaRbFsA50c3kW4DVHTw62vrWEBMPT+AU5TYa07PZzcU/v/gwzWRf9F7U20njaMK3EI3gw8wPYJOelEoFYENxDIjUFCOh7bB+fQIVagvb5pjpeIX4OrrTv7k2WERAk0W+X+7ZaKsXImkbq411t1zGcPTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615177; c=relaxed/simple;
	bh=0zPyBmEmDIKAijEWcL6dkXKHILKWrl/fB1F2e0rRGVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZVi5dZoi1y2d+hozM6PVeHge+aDG1Tyo7PXibzsHycNFGMjIfX45v0UeF7ENKfCBVsJ+d7djuLD3pEWe5XI+564zDbIWseudeFVq/i1QFSM9jkuX9oBV/+0/H4ENmx9WWpjg+hTTjbdfxXWhH9xO7U+FmlW6M33+OFXcdcrdhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0hSD9zo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0hSD9zo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8541F000FF;
	Mon, 28 Sep 2026 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615176;
	bh=xVgts+uCLuBUvQCGyi/vLaTy2dKYJ2pn8Wwzjyg6aME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0hSD9zoj6OM9C6feXfXBNCCgIZBitjFqK+PL9riu6TqNCfbhbs3jApk/D2+y4u5u
	 RlEGHsRWlApWgqhRcVo1hCTLGM99g6jj6dVTPXqMeo3IaQ/o/iRdlNhuXTNadZuEG2
	 C1N8qKucSmhj+x3bH0sueAcPSwdkNSwTjZHlIL3ZVwFSx6ruYGSW6JiAtgXE27UEAu
	 W9k34zzJjiGWdlH5XynMZhgUFsJiu4shzSRTnEGbhvRG5PuAbJhpviKcjawdms9F6y
	 UCAmXB/xLo8JkkFVfuE7MEf8PRLawh0sZqyoHx5Lbo3i6phwzaA9Q2M+rheuObNYfH
	 bH83OZcHFWHng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] PCI: rcar-gen4: Route Root Port AER to a
 virtual Root Port IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928165230.3397664-14-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-14-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:06:15 +0000
Message-Id: <20260928170616.1C8541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI: rcar: locking anti-pattern caused by wrong IRQ flow handler
--

commit 06909c0e9b8f6e26337c04f8e704d2dde673633d
Author: Koichiro Den <den@valinux.co.jp>

    PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ

This commit routes Root Port AER notifications to a virtual Root Port IRQ by
allocating an IRQ in a single-entry domain and setting no_rp_msi. It also a=
dds
logic to serialize dispatches from parent IRQs to this virtual IRQ using a
raw spinlock.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index aa80232afabad..c01f157a7198b 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -689,6 +707,21 @@ static bool rcar_gen4_pcie_handle_link_down(struct r=
car_gen4_pcie *rcar)
>  	return rcar->reinit_pending;
>  }
> =20
> +static void rcar_gen4_pcie_rp_irq_dispatch(struct rcar_gen4_pcie *rcar)
> +{
> +	/*
> +	 * Serialize dispatches from the parent IRQs. handle_level_irq() would
> +	 * ack an IRQ already in progress without running its handlers again.
> +	 * Recheck after taking the lock since the parent's check may be stale.
> +	 */
> +	guard(raw_spinlock_irqsave)(&rcar->rp_irq_lock);
> +
> +	if (rcar_gen4_pcie_handle_link_down(rcar))
> +		return;
> +
> +	generic_handle_domain_irq(rcar->rp_irq_domain, 0);

[Severity: High]
Does holding a raw spinlock across generic_handle_domain_irq() extend the
atomic section over arbitrary PCIe port service handlers (like AER and PME)?

On PREEMPT_RT, if a child handler acquires a sleepable lock (e.g. spinlock_=
t),
wouldn't this trigger a 'sleeping while atomic' panic?

> +}
> +
>  static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
>  {

[ ... ]

> +static int rcar_gen4_pcie_rp_irq_map(struct irq_domain *domain,
> +				     unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &rcar_gen4_pcie_rp_irq_chip,
> +				 handle_level_irq);

[Severity: High]
Could the external serialization lock workaround above be avoided entirely?

Since handle_level_irq drops back-to-back latched interrupts by aborting if
IRQ_INPROGRESS, using handle_edge_irq for latched hardware sources instead
natively loops on IRQS_PENDING to handle concurrent parent triggers. This
would completely eliminate the need for an external serialization lock.

> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_noprobe(irq);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D13
