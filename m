Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898984039
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053611; cv=none; b=aIkywqcMhh46SvMhdO/tjrnBmwDHiBvfvUBQWNJkqVC1E6f9V2AWXQgWdWhVvX8z7Qwtnm8nE11LPs74ziO7Votazp6ygfM1FQkP1HlI0DNaqil6q/DrVW/tGAZkpQqAYqsenCCMr4yC+ezzFbgGp5NxMd+lpBjlz9uY9+LqnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053611; c=relaxed/simple;
	bh=1/DaATqrkHFYKG/clSmHNT+hdcht4ffM0ocGiJLnMmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HcdA3+fx+v0q3DBibli9FlbfyfZrKcDCUlJ3drGuhQvmeD3PHRNxMdL6SUQtjlqTJki93FKR5RcXgZ0CP9QbiISMT1ebt5pz5CZYddg24LwsjENNbzdAgwqPnwojPNE9vIF3HrnLoU+8n1LGCwIYLtOQJnWOcXxWUzL6h46Lxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtwtnQd9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtwtnQd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB9E1F00A3E;
	Fri,  3 Jul 2026 04:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053602;
	bh=6a17RHXlBKR2KaGgq6r4FDauu+5Kon/TtUvM1pBX8Ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtwtnQd9YtQ8K96paGcJc2a6YXk/f4y7JeS9jQ8vePZhJAprQ6eTf2p5hOgqn1aCc
	 AD+Q4aRIN3ahnLKjZZoBxkzFC2lpmZBtoYZfjHga7SgzbdaIg1+c1wbR8dSysFpTFo
	 WfCw7FJqA60le1oYyWZrlHRDsZhZlfPFpPa9k6jFgTsLCGk8GwxkCkZJNUileYgQ+E
	 5JjP1mx32ux3rg7PGmsiVz7jNVT3CHtoO0WQfRVaN/uHOw8Lcu8edlAgwomMYHQ08m
	 9m2AVzjFMoOz1Qt1zx7Qo0agSetqx1foZ60gAOoqMIsEdwTuv6/U2nOu3W7DXBMEKN
	 1zHZRxGTv/bQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/18] iommu/arm-smmu-v3: Recheck CMDQ_ERR in
 tegra241_vintf0_handle_error()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2f83aa2157ea08642f7f55c5dd3fb1c66e883c91.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <2f83aa2157ea08642f7f55c5dd3fb1c66e883c91.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:40:02 +0000
Message-Id: <20260703044002.9FB9E1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition between teardown paths and the threaded ISR leading=
 to a NULL pointer dereference.
- [High] Missing index offset for the second 64-bit LVCMDQ error map causes=
 incorrect array access and an unhandled IRQ storm.
- [High] Premature IRQ registration allows the ISR to fire before core data=
 structures are allocated, leading to an uninitialized pointer dereference.
--

commit 24d0e50ef454f78b71fd6e45f50c5e36ef3cc631
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Recheck CMDQ_ERR in tegra241_vintf0_handle_error()

This patch introduces locking when reading and acknowledging the
GERROR/GERRORN pair in both tegra241_vintf0_handle_error() and
tegra241_vcmdq_hw_deinit(). It ensures that concurrent acknowledgments
do not skip errors on already-handled errors. It also properly
initializes the cmdq_err_lock at allocation.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iom=
mu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 9012ab584d1dd..666dd23b0c7ca 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -319,10 +319,19 @@ static void tegra241_vintf0_handle_error(struct teg=
ra241_vintf *vintf)
>  		while (map) {
>  			unsigned long lidx =3D __ffs64(map);
>  			struct tegra241_vcmdq *vcmdq =3D vintf->lvcmdqs[lidx];

[Severity: High]
This isn't a bug introduced by this patch, but does this code compute the
correct array index for logical VCMDQs when the outer loop index i is
greater than 0?

Since this loop processes LVCMDQ_ERR_MAP_64(i), if an error occurs on a log=
ical
VCMDQ with an index >=3D 64, the hardware sets the corresponding bit in the
second 64-bit error map. By computing lidx purely as __ffs64(map) and omitt=
ing
an (i * 64) offset, wouldn't it erroneously access an index in the 0..63 ra=
nge
instead of the correct queue? Could this fail to acknowledge the actual que=
ue's
hardware error and lead to an unhandled IRQ storm?

[Severity: High]
This is a pre-existing issue, but is it possible for a race condition to oc=
cur
between the teardown paths and this threaded ISR?

If the driver is removed (e.g., via rmmod) and tegra241_cmdqv_remove() init=
iates
teardown and nullifies the vintf->lvcmdqs[lidx] pointers before free_irq() =
is
called, could this concurrently active ISR thread read the hardware map and
dereference the newly nullified vintf->lvcmdqs[lidx] without holding any lo=
cks?

> -			u32 gerror =3D readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
> +			struct arm_smmu_cmdq *cmdq =3D &vcmdq->cmdq;
> +			unsigned long flags;
> +			u32 gerror, gerrorn;

[ ... ]

I also noticed another pre-existing issue outside the scope of this diff:

drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:__tegra241_cmdqv_probe() {
    ...
		ret =3D request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
					   IRQF_ONESHOT, "tegra241-cmdqv",
					   cmdqv);
    ...
}

[Severity: High]
This is a pre-existing issue, but is there a race condition here where the =
IRQ
handler is registered before core data structures are fully initialized?

If request_threaded_irq() is called while cmdqv->vintfs is still an
uninitialized pointer (e.g. following devm_krealloc without __GFP_ZERO), co=
uld a
latched interrupt cause the ISR to fire instantly and dereference
cmdqv->vintfs[0] in tegra241_cmdqv_isr() before it is safely initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D10
