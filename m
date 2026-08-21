Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BA33DED1
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331346; cv=none; b=naaJr11GzdbJVBEsyBD+kbvl9NTtx3Db40fyLvqnpo0joo2WOHEGtu4DtJxJuGBbXlk6hv8KQG1I1VPZEYg1MjkIto/0h0Dc5XFF9fOw0pKLJRQULZrV2T8sXxE3t5rQ9Oi9g6df96qxPu6xFSgKTHosu+Vi2WbwAJfDoO5/WEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331346; c=relaxed/simple;
	bh=XQJuM16Iw5/K1ffeeGOkjwBAGIXoCpR0EGC6uA6kSFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c/X/t9YPphiowBaykOczyqgJUAJU2fZs9kReSqTINQJ13uwOKPEUbD6+e8hEeuR2WPyWv960pIcGGqCnA1A5tab4Bf/MDMAKcqyRW1ru+R4miM8+6ksHW8qLWYmukX2bBskXWfrC99Q6C6Emir2P5uVEbJupk8nnBI7fCCJaauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWZYMckK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWZYMckK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94091F000E9;
	Fri, 21 Aug 2026 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331344;
	bh=ZeOeoZuVsaxs7sdPHdqWBwfeRHpYbNwLYSEH2dHIJeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWZYMckKsIGcNYeJCrigP+7ahpjpKFZUZ06FdbVf8Bt5hrtgTRvZEUkvoRD5AOBfx
	 qR+j+popEt8CcKD6BCy8YPFaVs9fmcLq1T+zBotARBRsZO0gMpIsAq0YSGG2gRqAgg
	 /haHqyVhZaem7xfTzdGuFKMTXnBYqNiJ0/HeDafGKMLw87ndz6toHaeuL3SnWeRMeF
	 rdkmVeBA9mtuo8BhL5VVxc8yfd0FpU4UUgF09iCFvh6dFzT2DSxe5p54f8UdLgu0qJ
	 hsHsnycjZ1cjNkXerI5ztLfEtjgnF0RzjdYdXDsbLnkmsm21kYcnvWZ3OMv5lCjKdp
	 1eEIyejQEEkIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/VGA: Fix lost wakeup when waiting for a VGA
 resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "FAN YE" <fy15309206903@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-pci-vga-lost-wakeup-v1-1-39dc6a2333c6@gmail.com>
References: <20260821-pci-vga-lost-wakeup-v1-1-39dc6a2333c6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 16:55:43 +0000
Message-Id: <20260821165543.B94091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] vga_tryget() incorrectly masks actual error codes from __vga_tryge=
t() into -EBUSY, and its caller vgaarb_write() has inverted logic that trea=
ts this error as success.
- [High] Missing rollback in __vga_tryget() leaves conflicting devices perm=
anently disabled on error.
--

--- Patch [1]: [PATCH] PCI/VGA: Fix lost wakeup when waiting for a VGA reso=
urce ---
commit 14621d6221b003eab582f677ca7cbfeb78dd54ba
Author: FAN YE <fy15309206903@gmail.com>

PCI/VGA: Fix lost wakeup when waiting for a VGA resource
   =20
This commit addresses a lost wakeup issue in vga_get() when waiting for a
conflicting device to release its resource. It ensures the task is added to
the wait queue before dropping the vga_lock so that a concurrent wakeup
doesn't slip past.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3de05aee78599..51c7d171c9558 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -459,6 +459,23 @@ int vga_get(struct pci_dev *pdev, unsigned int rsrc,=
 int interruptible)
>  			break;
>  		}
>  		conflict =3D __vga_tryget(vgadev, rsrc);

[Severity: High]
This is a pre-existing issue, but does __vga_tryget() fail to roll back the
state of already-disabled conflicting devices if a subsequent operation
fails?

In drivers/pci/vgaarb.c:__vga_tryget():

    err =3D pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
    if (err)
        return ERR_PTR(err);

If this fails midway through disabling multiple devices, or fails when
enabling the target device later in the function, it returns ERR_PTR(err)
without reverting the disabled devices. Could this leave those GPUs
permanently disabled with corrupted arbiter state?

> +		/*
> +		 * We have a conflict; we wait until somebody kicks the
> +		 * work queue. Currently we have one work queue that we
> +		 * kick each time some resources are released, but it would
> +		 * be fairly easy to have a per-device one so that we only
> +		 * need to attach to the conflicting device.
> +		 *
> +		 * Queue up before dropping vga_lock: __vga_put() wakes the
> +		 * queue while holding it, so a wakeup cannot slip past.
> +		 */
> +		if (!IS_ERR_OR_NULL(conflict)) {
> +			init_waitqueue_entry(&wait, current);
> +			add_wait_queue(&vga_wait_queue, &wait);
> +			set_current_state(interruptible ?
> +					  TASK_INTERRUPTIBLE :
> +					  TASK_UNINTERRUPTIBLE);
> +		}
>  		spin_unlock_irqrestore(&vga_lock, flags);
>  		if (IS_ERR(conflict)) {

[Severity: High]
This isn't a bug introduced by this patch, but since we are handling
__vga_tryget() errors here, does vga_tryget() incorrectly mask actual error
returns from __vga_tryget() into -EBUSY?

In drivers/pci/vgaarb.c:vga_tryget():

    if (__vga_tryget(vgadev, rsrc))
        rc =3D -EBUSY;

And does the caller vgaarb_write() then treat this error as a success?

In drivers/pci/vgaarb.c:vgaarb_write():

    if (vga_tryget(pdev, io_state)) {
        /* Update the client's locks lists... */

Since vga_tryget() returns -EBUSY on failure, the non-zero return causes
vgaarb_write() to evaluate the condition as true. Can this false success
lead to userspace incorrectly acting as if the lock was acquired, causing
dangerous concurrent VGA access?

>  			rc =3D PTR_ERR(conflict);
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-pci-vga-lo=
st-wakeup-v1-1-39dc6a2333c6@gmail.com?part=3D1
