Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495153;
	b=aEUEVQoaQammHwZ+J8WHwd1P/eu4+jPe7qoBvUmQNZZmPnOIdqedz7hXzwWSRHPWFg7r
	 raEj+J79JsYPYq+B5iih/92cvHmBncQMGuzhDWVtbGFAIKQ5qZlzcffy4avn59hiYrDla
	 F6lV70ocM3PNCMDzgGQXd2APbVzl8+kr88D3Ge/3+VSCCqxddsTrazMcvzxSvgvXsWDp3
	 OTRUUodbClsQrZSt5zN52JJzWY3e6FGO6jsRB+MyN/vW2NjO0FrPfFWOj0QBOIpxSd0Nn
	 jUU6/vxeYfqYjeLIrrMdENaFlrAUbBEjBdWmXf3cGF5nhlwso+fPcFJM3ekUu77OsHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=52vZOQ9OiQnWW/qrVv26eDLPqN6Kg1miXaQMvij+1yU=;
	b=2LAFLaj2P5GgD0NgUbGC7L2vdNoNu4JdyF5QcmCXVCd59cogh4D6XmtkGt4gpL3L2gdR
	 Te6vyjTa6lstAbknJhbpBJRMsheT/OChmh0C7G7Ukyif6EdG6NBx2JYVSu11dnrobTo4B
	 QaMrf99o9cJAATPt5fb1VHdqt/lrStW0X6i+dskS+JxgfhYqENzLYg5d+eqlslDfE7xCG
	 UZ1mpP3UImWlHG4/6L3zrlCqerzvnp5i/hsYedWCLLkqTIhjlQ8n3rx7Q0QAOfHOs7viz
	 x0u6g5gXnUUNKGW33WRBSbcXiqGkykrJyWfqT9olmqJX7P0BDmI/qYcU9+NnyGAmmMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpT5QlZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666DF606A887;
	Thu, 12 Nov 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpT5QlZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDC11F00A0A;
	Thu, 12 Nov 2026 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495153;
	bh=52vZOQ9OiQnWW/qrVv26eDLPqN6Kg1miXaQMvij+1yU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lpT5QlZEyUA4ZyfmdZeAq0UTpVG3dfgKm3ZO6keCTTy6L6yPR4mKo03p9R/aLVpXg
	 3hnS/eNbM5P7COlW1SXPENTMT/6Fmks6MXKHWhhO4iT98TaXHF+AKQyG8TboUwJaBe
	 /0EG1H32kVf0owehCSwbsDC4Ga+PVFZz4MU7dEH6WD2hr54V6WGMiODyVKK3sHUclM
	 Xgq64aQJcZ3hZvCrmmQZnVBIMfkRQ8Nq2cI/ox4A9/ODCD9OuYz9Kn95nusLFqvNAw
	 iCxayXbMSFuOmuWt2frVSaw2GHANylXPuobQ+8OON6mIatt8t2bcUdJNMy05f8fHqi
	 cxAlocSByzTBA==
Message-ID: <sashiko-outbox-211389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 14/20] vfio/pci: Add INTx recovery operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-15-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:52:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] vfio/pci: permanent INTx masking in __vfio_pci_intx_mask() on
  runtime suspend
- [High] vfio/pci: unmasked shared INTx in
  vfio_pci_intx_mask_for_recovery()
- [Medium] vfio/pci: premature INTx unmask after blocked irq in
  vfio_intx_handler()
--

commit 832141c440dca237115d9dc7d2fca6d1c8bdf80a
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Add INTx recovery operations

This commit adds blocked INTx operations and recovery helpers to mask INTx,
record pending unmask requests while access is blocked, and restore INTx
state when recovery finishes.

> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pc=
i_intrs.c
> index 64f80f64ff57a..f78c7217017d2 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -29,6 +29,8 @@ struct vfio_pci_irq_ctx {
>  	struct virqfd			*mask;
>  	char				*name;
>  	bool				masked;
> +	bool				recovery_masked;
> +	bool				unmask_pending;
>  	struct irq_bypass_producer	producer;
>  };
> =20
> @@ -126,6 +128,10 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_cor=
e_device *vdev)
>  	if (WARN_ON_ONCE(!ctx))
>  		goto out_unlock;
> =20
> +	/* An explicit mask cancels any unmask request saved during recovery. */
> +	ctx->recovery_masked =3D false;
> +	ctx->unmask_pending =3D false;
> +
>  	if (!ctx->masked) {
>  		/*
>  		 * Can't use check_and_mask here because we always want to

[Severity: High]
Can __vfio_pci_intx_mask() leave INTx permanently masked if
vfio_pci_core_runtime_suspend() runs during recovery?

Unlike userspace mask paths, vfio_pci_core_runtime_suspend() is not gated
by vfio_pci_core_access() and calls:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_core_runtime_suspend() {
    ...
	vdev->pm_intx_masked =3D ((vdev->irq_type =3D=3D VFIO_PCI_INTX_IRQ_INDEX) =
&&
				vfio_pci_intx_mask(vdev));
    ...
}

When INTx is masked for recovery (ctx->masked is true and
ctx->recovery_masked or ctx->unmask_pending is true), a runtime suspend
(for example when pm_runtime_put() runs after an ioctl on a device in
VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY) clears both ctx->recovery_masked and
ctx->unmask_pending here, skips the !ctx->masked block, and returns false.
vfio_pci_core_runtime_suspend() then records vdev->pm_intx_masked =3D false,
so neither vfio_pci_core_runtime_resume() nor
vfio_pci_intx_recovery_finish() will unmask INTx again.

> @@ -220,33 +245,151 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_dev=
ice *vdev)
>  	mutex_unlock(&vdev->igate);
>  }
> =20
> -static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
> +/*
> + * Recovery always masks INTx and remembers whether to unmask it afterwa=
rd.
> + * The interrupt handler masks INTx only if this device has a pending
> + * interrupt, since another device may share the line.
> + */
> +static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device =
*vdev,
> +					    struct vfio_pci_irq_ctx *ctx,
> +					    bool quiesce)
>  {
> -	struct vfio_pci_irq_ctx *ctx =3D dev_id;
> -	struct vfio_pci_core_device *vdev =3D ctx->vdev;
> -	unsigned long flags;
> -	int ret =3D IRQ_NONE;
> +	lockdep_assert_held(&vdev->irqlock);
> =20
> -	spin_lock_irqsave(&vdev->irqlock, flags);
> +	if (ctx->masked)
> +		return false;
> =20
> +	if (!vdev->pci_2_3)
> +		disable_irq_nosync(vdev->pdev->irq);
> +	else if (quiesce)
> +		pci_intx(vdev->pdev, 0);
> +	else if (!pci_check_and_mask_intx(vdev->pdev))
> +		return false;
> =20
> +	ctx->masked =3D true;
> +	if (quiesce)
> +		ctx->recovery_masked =3D true;
> +	return true;
> +}

[Severity: High]
Does the early return when ctx->masked is true prevent
vfio_pci_intx_handle_blocked() from masking shared PCI 2.3 interrupts
during recovery?

vfio_pci_intx_recovery_start() calls vfio_pci_intx_mask_for_recovery()
with quiesce =3D true, setting ctx->masked =3D true.  However, on a PCI 2.3
device, PCI_COMMAND_INTX_DISABLE can still be clear in hardware if config
space read 0xffff when error_detected ran, or after a host slot/bus reset
clears PCI_COMMAND before state restoration.  If the device then asserts a
shared INTx line while access is blocked, vfio_pci_intx_handle_blocked()
calls vfio_pci_intx_mask_for_recovery(vdev, ctx, false), which returns
false immediately because ctx->masked is true instead of calling
pci_check_and_mask_intx(), returning IRQ_NONE and leaving the shared level
interrupt asserted.

> +
> +irqreturn_t vfio_pci_intx_handle(struct vfio_pci_core_device *vdev,
> +				 struct vfio_pci_irq_ctx *ctx)
> +{
> +	lockdep_assert_held(&vdev->irqlock);
>  	if (!vdev->pci_2_3) {
>  		disable_irq_nosync(vdev->pdev->irq);
>  		ctx->masked =3D true;
> -		ret =3D IRQ_HANDLED;
> -	} else if (!ctx->masked &&  /* may be shared */
> -		   pci_check_and_mask_intx(vdev->pdev)) {
> +		return IRQ_HANDLED;
> +	}
> +	if (!ctx->masked && pci_check_and_mask_intx(vdev->pdev)) {
>  		ctx->masked =3D true;
> -		ret =3D IRQ_HANDLED;
> +		return IRQ_HANDLED;
>  	}
> +	return IRQ_NONE;
> +}
> +
> +irqreturn_t vfio_pci_intx_handle_blocked(struct vfio_pci_core_device *vd=
ev,
> +					 struct vfio_pci_irq_ctx *ctx)
> +{
> +	lockdep_assert_held(&vdev->irqlock);
> +	/* A shared interrupt line still needs pending INTx to be masked. */
> +	if (vfio_pci_intx_mask_for_recovery(vdev, ctx, false) ||
> +	    (ctx->masked && !vdev->pci_2_3))
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
> +{
> +	struct vfio_pci_irq_ctx *ctx =3D dev_id;
> +	struct vfio_pci_core_device *vdev =3D ctx->vdev;
> +	unsigned long flags;
> +	irqreturn_t ret;
> =20
> +	spin_lock_irqsave(&vdev->irqlock, flags);
> +	ret =3D vfio_pci_access_ops(vdev)->intx_handler(vdev, ctx);
>  	spin_unlock_irqrestore(&vdev->irqlock, flags);
> =20
>  	if (ret =3D=3D IRQ_HANDLED)
>  		vfio_send_intx_eventfd(vdev, ctx);
> -
>  	return ret;
>  }

[Severity: Medium]
When vfio_pci_intx_handle_blocked() returns IRQ_HANDLED,
vfio_intx_handler() delivers the automasked interrupt to userspace via
vfio_send_intx_eventfd(), but neither vfio_pci_intx_mask_for_recovery()
nor vfio_pci_intx_handle_blocked() clears ctx->recovery_masked or
ctx->unmask_pending.  Can this cause vfio_pci_intx_recovery_finish() to
unmask INTx prematurely before userspace has processed and unmasked the
interrupt?

CPU0                                      CPU1 (<hardirq>)
vfio_pci_intx_recovery_start()
  spin_lock_irqsave(&vdev->irqlock)
  vfio_pci_intx_mask_for_recovery(..., true)
    disable_irq_nosync(pdev->irq)
    ctx->masked =3D true
    ctx->recovery_masked =3D true
  spin_unlock_irqrestore(&vdev->irqlock)
                                          vfio_intx_handler()
                                            spin_lock_irqsave(&vdev->irqloc=
k)
                                            vfio_pci_intx_handle_blocked()
                                              ctx->masked && !vdev->pci_2_3
                                              --> returns IRQ_HANDLED
                                            spin_unlock_irqrestore(...)
                                            vfio_send_intx_eventfd()
...
vfio_pci_intx_recovery_finish()
  if (ctx->recovery_masked || ...)
    vfio_pci_intx_unmask_live()           <-- unmasks before userspace

On !vdev->pci_2_3 devices, if ctx->masked was already true before recovery
started, the (ctx->masked && !vdev->pci_2_3) check also returns
IRQ_HANDLED and triggers a spurious eventfd signal while masked.  The same
premature unmask happens if vfio_pci_intx_unmask_blocked() sets
ctx->unmask_pending =3D true while ctx->masked is still false (before
vfio_pci_intx_recovery_start() runs) and an interrupt is then masked and
signaled by vfio_pci_intx_handle_blocked() without clearing
ctx->unmask_pending.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D14
