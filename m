Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD54625;
	Fri, 14 Aug 2026 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666196; cv=none; b=rfAz02MwXkEEdY0RNghxYQf50YhzmGaGLYAxuarCXF1dm9NPn8TLNrQHt9lfB9+pbkrllJsY1aJdnmfCLx2xr/fHLiAcjzGrYBJJFLdaxtee1leDLw+Mmk7/CedOChcvsDXQ+3FKEfpitzznBrwZGo1BUravXCME285FFBO1E6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666196; c=relaxed/simple;
	bh=HgAD51W3RnV/dPqo5nifdH1Lmq0VqaNBfJyblj8ss/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s7y06oUSEh75Zba93Ol5RQ3g0jNqPzQLr6oaIDSpVJmsKbBY5G2EjmPfWWeJ52IGmQqZ+csAbGtGtTKDk+DsYTo9NNN2ZxhDUuGk/dyya2OBXK3fbIOYXplntj9hm5qfKHA5NsFTs6sp5RmT2fZ/ZuwMTnJu6X7rKBcV6nH/7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAOSkzGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAOSkzGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73141F000E9;
	Fri, 14 Aug 2026 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666195;
	bh=PIe8Q6g3Q5bovhCq4SpUmj282PlM040MCNrypQMkBPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAOSkzGrCM82oux9ohO/65Sa3mpSkpYMXOyAtvb7s0PWviu27vHVgm5nogozPBoSL
	 yfE0P78o+PNQO2l5ApWsQpBbcTo27ZGqABDv0tK7fDFu3E+y4ofjeOUNRzaa5CuiCO
	 oJudJEaLbF9boJ1juFF2htok5A9pK0jfUfmxmCDicrTeM6mb2x9LIwFYOweADPh4pv
	 l0pUmJn2nk0Zv4QmdyLkx9zMjde/j+Hi+jrthZcXP+c3VcUSl7ZORAC/Z3kfAPvt5V
	 Ln9JeQwVKU6V8mZux0vYdzP6+/7WvgO2s821tKiSH32RgHAtWrNe1v1/FwqgNrGb3H
	 iNa0WI48zSzig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/23] dmaengine: sdxi: Install administrative context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260410-sdxi-base-v1-8-1d184cb5c60a@amd.com>
References: <20260410-sdxi-base-v1-8-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:09:50 +0000
Message-Id: <20260814000950.C73141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware retains access to freed DMA memory due to missing L1 entr=
y invalidation during teardown.
- [Medium] Incorrect error check for `dma_pool_zalloc` allocation of `cxt->=
cxt_ctl`.
--

--- Patch [8]: [PATCH 08/23] dmaengine: sdxi: Install administrative contex=
t ---
commit 17401dc26aa25b16b19cf4cf87900b7c0d64a889
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Install administrative context

Serialize the context control block, akey table, and L1 entry for the
admin context, making its descriptor ring, write index, and context
status block visible to the SDXI implementation once it is activated.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 0a6821992776c..097d871e530fd 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> @@ -115,13 +267,23 @@ static void free_admin_cxt(void *ptr)
> =20
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  {
> +	int err;
> +	struct sdxi_sq *sq;
> +
>  	struct sdxi_cxt *cxt __free(sdxi_cxt) =3D sdxi_alloc_cxt(sdxi);

[Severity: Medium]
In sdxi_alloc_cxt() called here, the code handles allocation as follows:

drivers/dma/sdxi/context.c:sdxi_alloc_cxt() {
    ...
    cxt->cxt_ctl =3D dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
                                   &cxt->cxt_ctl_dma);
    if (!cxt->cxt_ctl_dma)
        return NULL;
    ...
}

Is this the correct check for dma_pool_zalloc() failure? DMA address 0 can =
be
a valid address returned by the DMA API on some platforms, which would cause
this check to falsely treat a successful allocation as a failure. Should it
check if (!cxt->cxt_ctl) instead?

>  	if (!cxt)
>  		return -ENOMEM;
> =20
> +	sq =3D cxt->sq;
> +	/* SDXI 1.0 4.1.8.4.b: Set CXT_STS.state to CXTV_RUN. */
> +	sq->cxt_sts->state =3D FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
>  	cxt->id =3D SDXI_ADMIN_CXT_ID;
>  	cxt->db =3D sdxi->dbs + cxt->id * sdxi->db_stride;
> =20
> +	err =3D sdxi_publish_cxt(cxt);
> +	if (err)
> +		return err;
> +
>  	sdxi->admin_cxt =3D no_free_ptr(cxt);
> =20
>  	return devm_add_action_or_reset(sdxi_to_dev(sdxi), free_admin_cxt, sdxi=
);

[Severity: High]
When an administrator unbinds the driver via sysfs or unloads the module, t=
he
devres teardown path calls free_admin_cxt(). This ultimately calls
sdxi_free_cxt() which frees the DMA memory back to the kernel.

Since sdxi_publish_cxt() now writes the VL=3D1 bit and makes the memory vis=
ible
to the hardware, does the driver need to clear this bit in the L1 table ent=
ry
and stop the hardware before freeing the memory?

The driver also lacks a .remove callback in sdxi_driver (in
drivers/dma/sdxi/pci.c) to safely stop the PCI device and its DMA operations
before devres cleanup begins.

Will the active hardware continue to fetch descriptors and write statuses to
the now-freed memory pages, causing a DMA use-after-free and potential kern=
el
memory corruption?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410-sdxi-base-=
v1-0-1d184cb5c60a@amd.com?part=3D8
