Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40F3914E4
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722742; cv=pass; b=J1Zf2R87w9GV7UQMo86GBsAxBNsDpo/8+Fu6rPxhVnYuX/WToGnUzDblV2gWxdrPFcPl1TmiU5nQQ45AhJAyfkVgISTO5S7a1+hD/5N1QJA2tnCVCHpgcbc+RorSb2bmSTHy2/XCs1UECcfs3BuDwY2TGCcmRrdLgIKkPfs7PfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722742; c=relaxed/simple;
	bh=n3jWPBEXC7YO12UP+Hg3xDyh43EJdvNxaruIU8/G3A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZJWRYm86JEFkvBgal4vCyrm50GTYtu6G5bc4t2DgP4hx+w18ccJxGOHBLch+gSCDxpleQD9FNIlgkACEN16DuWdkc7dPYuqQMhqtKZhUSdYuMMwmSoo7H+sJpUWJ4l+NaCbySM9FfoDmHcBBNN/mcGmb0TNZ51M0uSR0gOEYLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1d8I3Bq; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1d8I3Bq"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1372748a12.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 15:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783722741; cv=none;
        d=google.com; s=arc-20260327;
        b=TCxS3pz7dxKIST7BObNpn6ePQT8l/3fvsRJ8u5bsAa12969hynt08qT9ePVisTEerF
         b5qXPBCAB5ucwUyzhzaAC0uAlt5jr2mnR13Qd0gIz0UWHxKLegkQoAePJcCVyt9BSPui
         u/jIPs1fHeJE1Co6WxepsHRc4UJLKEgDFXBGe0xZunGEVbr6NtCFNS2Hk1pePlPiM2Es
         P5OvFB6+ZJA6OFmIPpojt1XQ2FAzcvvSdcv4HopaqUW18qExkD847UuFokugdOJN9BpQ
         FEvLBz9oXHV1soNaPN5IgRX9fXC2VS7YLU2L2KwTfVk79P6kqxsbE0dA7VdQEYSJvrPz
         /tDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rEqvrzWdNs03NSYY4Llo7JEtAwRyuEAURCyKKRu8aMg=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=gNXxwe1qAE7+QuNe3yY6WQ1DPJ6TPeeM/GHJVoX0bNuW86gq/ztes8u+bGGQ+vSfQs
         qm7js0Iy027+pF6y1dbFwPEZC6p17lM6MaF7tgPKkBRRVuKWEMENn78LKIgVIpYF9qlD
         RFXlWzvB5rHYcGHPFghMkMKEhStKHLnPxudmnbCB2FW0+y64zNAbrf2ar7eZnoJ3CUaq
         1xHWQcVQJLETp2nvjpxFvhv1A2xD/g0HfZFsXvsH5jAage+LOa2YNLjfysyRhri9zETF
         ADkd95Xq39s4dvoKLahdb4g2HKqaeLS01O3FouUvlXrNqb3QrWb0HiqZyZAnDeY85Lyb
         PZ3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783722741; x=1784327541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rEqvrzWdNs03NSYY4Llo7JEtAwRyuEAURCyKKRu8aMg=;
        b=g1d8I3BqbCxj2vyuBb+fUQJr8KgiIH6CIRMSRWB4hS2MScYpQcga+aY0Iv5ROBJqln
         iWqzrI2mN6RGLo0jrTAx3C9zjyni/FtYNLt/9/RdqKc3eZLqLUK+YdtK3vT5v+fUUUUP
         3NGiJxsqMPX4ZCJpLwvi2BfA8TbfTWqx3d2p7MxdWehHSRBGYVPbffVRt5h9qjA/5mS7
         CNv8SHF2eW0NwLPCILOlIwDHVNoa14G+89SHwkgwvwQitla5sW3cYiZlkCoNvE3pw21N
         nbl1k/oxMZxLbqJ9Mwx/SeinoQmsJdYY0be6gFRtZOyobRBE8PuCaeCQYnFq+xClziZN
         8g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722741; x=1784327541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEqvrzWdNs03NSYY4Llo7JEtAwRyuEAURCyKKRu8aMg=;
        b=IbGW1NM3G+C4s/Ir2g4Jbfjj+xNwzBxgz0YYZdsDPTjczN/OG2ps/bPuDWwCB0wTqQ
         rYzcv1WhMFGntKzHd/4zvcBoRkjkdZ1RWNVYgyaTXJHRweisaTn61eCMITW9R5SlDAmN
         4i7ZSsduphi7JpDWJFA4kIytjp9miolLNQu83uKL1iQ5HtPbaePTyQ42biTknXWAFddf
         goiS4PzI/smjMBqicMjx/AakeQY12LkRT2/z+xNA6n/f/8JJElRA3O/Dqv95KKdI8iWh
         qT4KSyPouMIDNdc/Zrk4e79cN3jtlF2dZ3j0ZiL9xbTOdQHYmG1eDtHMhWhjd7SmcEUr
         0QPw==
X-Gm-Message-State: AOJu0YyYIQrhd8oL81COfMA/sLJZnq9KjoqPJLzYox+SXgAq0CqB3MKB
	uBBBPH0FvhZce1edw99YyJeBkkWRK6tlizs+0TVgWoyikdjctiVRs4aB8QW6aXCASxGe2yOCNJq
	6qs43+AN5vkoP2bRx8DDNpliZ1Mp1y7qiHvEExDdT
X-Gm-Gg: AfdE7ckVmgF5L3LRSYTw5vhY3Wsgv3fJG/2YleE93kbo38527hn4laQhuffwmBAlOmN
	hhG/s9VSTWnEVk0Mqv5F3FdZDfx6PlCIHSwdA4kvIVUa6a+glLVMzGDkaaIvUQJ037aS3EdlEkA
	MO5OgdcGdYhgkkYYlTbc6romINDqvhen5GB5lVWwK3wfOIs3nMRpA/V+cOtx0I5+c23ob2F5CZO
	ZCDt2g6NCvZyN/2KSDq2jIP55VTQOw330O1kzkWea+mpuEzo2UiQ4xU5MfDUINt1yQNS1rN
X-Received: by 2002:a05:6a20:3d0c:b0:3c0:9c1b:d0bf with SMTP id
 adf61e73a8af0-3c110a50703mr921139637.74.1783722740175; Fri, 10 Jul 2026
 15:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <20260710213928.E7CE11F0155B@smtp.kernel.org>
In-Reply-To: <20260710213928.E7CE11F0155B@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 10 Jul 2026 15:31:53 -0700
X-Gm-Features: AVVi8Cfjqrg4u4sl-DpUERrkw0gK2lYYXpeCMTm0VWzP26rFLxArTRQ3P79NdQ4
Message-ID: <CALzav=eL+nA2w7KzTXkn-_qm5couU9nANsEkqF+1qCA9NNV0Dw@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 2:39=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] pci_liveupdate_finish_device() incorrectly aborts if refcount !=
=3D 1, completely breaking the preservation lifecycle for parent bridges an=
d leaking their FLB references.
> - [Medium] `pci_liveupdate_cleanup_device()` fails to clear `dev_ser->ref=
count`, leading to state contamination for subsequently hot-plugged devices=
.
> - [Medium] Memory allocated for incoming preserved PCI devices (the KHO b=
lock set) is leaked in `pci_flb_retrieve()` if `kzalloc_obj()` fails.
> --
>
> --- Patch [3]: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved=
 PCI devices ---
> commit 4fcd6c9f661309adcb1a2b891b9c5a34af9e319f
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Track incoming preserved PCI devices
>
> This patch adds support to the PCI core for tracking preserved PCI device=
s
> across Live Update. It introduces pci_liveupdate_setup_device() to fetch
> serialized state from the Live Update Orchestrator and exposes APIs for
> drivers to notify the PCI core when preservation is finished.
>
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 03075ce06ac98..df6a02240aa47 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
>
> [ ... ]
>
> > @@ -138,13 +172,58 @@ static void pci_flb_unpreserve(struct liveupdate_=
flb_op_args *args)
> >
> >  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> >  {
> > -     args->obj =3D phys_to_virt(args->data);
> > +     struct pci_ser *ser =3D phys_to_virt(args->data);
> > +     struct pci_flb_incoming *incoming;
> > +     struct pci_dev_ser *dev_ser;
> > +     struct kho_block_set_it it;
> > +     int ret =3D -ENOMEM;
> > +
> > +     incoming =3D kzalloc_obj(*incoming);
> > +     if (!incoming)
> > +             goto err_restore_free;
>
> [ ... ]
>
> > +err_block_set_destroy:
> > +     kho_block_set_destroy(&incoming->block_set);
> > +err_free_incoming:
> > +     xa_destroy(&incoming->xa);
> > +     kfree(incoming);
> > +err_restore_free:
> > +     kho_restore_free(ser);
> > +     return ret;
> >  }
>
> [Severity: Medium]
> If kzalloc_obj() fails, the code jumps to err_restore_free and calls
> kho_restore_free(ser).
>
> Because the underlying memory pages backing ser->devices (the KHO block s=
et)
> have not been restored or explicitly freed, does this error path permanen=
tly
> leak the memory reserved for the block set?

Yes. If retrieve fails, it permanently free the preserved memory and
then panic sin the caller (pci_liveupdate_flb_get_incoming()).

>
> [ ... ]
>
> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev=
)
>
> [ ... ]
>
> > +void pci_liveupdate_setup_device(struct pci_dev *dev)
> > +{
>
> [ ... ]
>
> > +     dev_ser =3D xa_load(&incoming->xa, key);
> > +
> > +     /*
> > +      * This device was not preserved across Live Update, or it was pr=
eserved
> > +      * but has already been probed and gone through pci_liveupdate_fi=
nish(),
> > +      * e.g. due to removing and re-adding the device. Either way, it'=
s not
> > +      * treated as incoming-preserved.
> > +      */
> > +     if (!dev_ser || !dev_ser->refcount) {
> > +             pci_liveupdate_flb_put_incoming();
> > +             return;
> > +     }
>
> [ ... ]
>
> >  void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> >  {
> >       /*
> > @@ -309,7 +469,83 @@ void pci_liveupdate_cleanup_device(struct pci_dev =
*dev)
> >        */
> >       if (READ_ONCE(dev->liveupdate.outgoing))
> >               pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n=
");
> > +
> > +     if (READ_ONCE(dev->liveupdate.incoming)) {
> > +             pci_WARN(dev, 1, "Destroying incoming-preserved device!\n=
");
> > +             pci_liveupdate_flb_put_incoming();
> > +     }
> >  }
>
> [Severity: Medium]
> In pci_liveupdate_cleanup_device(), the FLB reference is dropped but
> dev_ser->refcount is left unmodified.
>
> If a preserved device is removed or destroyed before its driver calls
> pci_liveupdate_finish() (for instance, if probe fails), and a new device
> is subsequently hot-plugged at the same BDF, won't pci_liveupdate_setup_d=
evice()
> see the stale dev_ser with a non-zero refcount and incorrectly associate =
the
> new device with the stale preserved state?

Same thing can happen if the user hot-plugs a device during Live
Update before the new kernel enumerates that slot. The user should not
hot-plug devices they are preserving across Live Update.

Also, probe() failing does not cause the device to be removed. probe()
can still be retried.

The only way this would happen is if the initial setup of the device
fails, e.g. the kernel can't allocate memory during scanning. The
reason I opted to keep the refcount elevated is it at least gives the
user the possibility of trying another scan and recovering the device
if the issue was transient.

>
> > +static void pci_liveupdate_finish_device(struct pci_ser *ser, struct p=
ci_dev *dev)
> > +{
> > +     if (!dev->liveupdate.incoming) {
> > +             pci_warn(dev, "Cannot finish preserving an unpreserved de=
vice\n");
> > +             return;
> > +     }
> > +
> > +     if (dev->liveupdate.incoming->refcount !=3D 1) {
> > +             pci_WARN(dev, 1, "Preserved device has a corrupted refcou=
nt!\n");
> > +             return;
> > +     }
>
> [Severity: High]
> Is this strict refcount !=3D 1 check correct for PCI bridges?
>
> Looking at the outgoing path in pci_liveupdate_preserve_device_again(), a
> bridge legitimately has its refcount incremented for each preserved downs=
tream
> device, making it greater than 1.
>
> When the bridge driver calls pci_liveupdate_finish() on the incoming side=
,
> won't this check fail, abort the finish process, and permanently leak the
> FLB reference for the bridge?

No, the refcount can only be 0 or 1 in this patch. Bridge preservation
and pci_liveupdate_preserve_device_again() are not introduced until a
later patch in this series, and that patch updates this code to
decrement the refcount instead of checking for 1.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.13=
51130-1-dmatlack@google.com?part=3D3
