Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA464A2A53;
	Wed,  2 Sep 2026 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357830; cv=none; b=KkhWgej7qBVsAeis06E19dcBM2wg0tGMKNAoibTfk/9YCE3zMDYVmvL6GnASFBIhyeULBeXi625CHruqHIu2m6DBBbkrTYnriEG/LgoUMptuxS7WZ/NtQieRkzoFI8C4V7KQ2R2+7XCzIG0EyReNCVKsZi4TUwK5A3xNO2Teyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357830; c=relaxed/simple;
	bh=J2oX7ScEJfHTWb0l6TSp1s8G5tOwWMdjxCG9O3h/LxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZOjkY0SvItvcGjkvuCJWydZc06vU4zTsCRY8vEu5LYFK0hHevHO3I+IMK43XJ2ULsrAadlxfFqUquFbMOW8WnHWyNei7xDzXqtbok7J7lfBPLbwfnt/BL7dWK0cFJDpVtHoJUnuGMGbUuKxDgKgbskQrR2BlBTrLXoh9ubndEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb3iMXOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb3iMXOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4A91F000E9;
	Wed,  2 Sep 2026 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357829;
	bh=6a6gnLKLhtLpwoKu2lp8ARACmAj5B8+yDrRZSdqLrw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eb3iMXOPJt6VMuPfF+AgWihwxnkxKtxuUVyA0xH1t0LTg92MvTAFoK5RpeKIJqdPx
	 XEZ762ZzUW/sHcxIIHZoHAcJM1iIcqn8nWzATNkn5SUBX6ii7o+kmpWXS12u38QEan
	 GjawES3U4csJOc3Rt0pqDM7VXm7ePcfesfNYJTFQOS/Gf7s4SgAf3O46v3Uk5PIi98
	 XpAcmIYmjvRPyoJ3JzIggxtW0j3XZq0Ty4AjrjGV/nKQ+uzG6JXOxVz/wYne9Z499g
	 cSYlTen058FJOq8JL8xctMm4Kb0jxoDsNC27I+yJPAIIJEMf1f1XhZiZuRnytS8+vo
	 Fn7F/Os3FMQ3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 8/9] PCI/CXL: Mask/Unmask CXL protocol errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902133933.2992457-9-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:03:48 +0000
Message-Id: <20260902140349.0E4A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Devres memory and action leak on CXL endpoint port unbind/rebind f=
or RCH topologies.
--

commit 6742f1a341d88bb57310da7468fadf1a3f3b4556
Author: Terry Bowman <terry.bowman@amd.com>

PCI/CXL: Mask/Unmask CXL protocol errors

This commit introduces helpers to mask and unmask CXL protocol errors. It
unmasks internal errors in cxl_dport_map_ras() and devm_cxl_port_ras_setup()
after the RAS register block is successfully mapped, and adds a devm action
to restore the mask on teardown.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index fac37b6fd882f..f1e05d240059b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

[ ... ]

> @@ -124,16 +124,64 @@ static void cxl_cper_prot_err_work_fn(struct work_s=
truct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);

[ ... ]

>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map =3D &dport->reg_map;
>  	struct device *dev =3D dport->dport_dev;
> =20
> -	if (!map->component_map.ras.valid)
> +	if (!map->component_map.ras.valid) {
>  		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		return;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	cxl_unmask_proto_interrupts(dev);
> +	if (devm_add_action_or_reset(dport_to_host(dport),
> +				     cxl_mask_proto_irqs, dev)) {

[Severity: High]
Does this devres action cause an unbounded memory and action leak when a CXL
endpoint port is unbound and rebound in RCH topologies?

In cxl_endpoint_port_probe() in drivers/cxl/port.c, when dport->rch is true,
it calls devm_cxl_dport_rch_ras_setup(dport). This executes repeatedly acro=
ss
unbind/bind cycles of the endpoint port.

That setup path eventually calls cxl_dport_map_ras(dport), which registers
the cxl_mask_proto_irqs action on the device returned by
dport_to_host(dport).

For RCH topologies, dport_to_host(dport) evaluates to the parent root port's
host device (the ACPI host bridge), not the endpoint port being probed.

Because the action is tied to the parent host device instead of the endpoint
port, unbinding and rebinding the endpoint port does not free the devres
action. This leaves a leaked action on the parent host device each time the
endpoint port is probed.

> +		dev_warn(dev, "failed to defer CXL proto-irq mask; CXL protocol error =
reporting disabled\n");
> +		dport->regs.component.ras =3D NULL;
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D8
