Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB5233931
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485712; cv=pass; b=VscnGe9v1OoaxoTk5fRfsuUCg8O691woPPKJPNWrRo5UQ4718IzXj8kDKhQ3InXbZ6hRqv7GBpIqFn02jItpgAXd32dBGmM0lg+dp/6xfd6YUtjHDN8oEFhLoQxw2VAPRygesNavlou7PU7GZq/mZGwy4Ig3O0Kf5mMh95VIgEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485712; c=relaxed/simple;
	bh=IrCbpRqZ79TSnNZHPbrCyoMMlKKTtlqCPS9dngunr+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXQrwMIATuxKXMRRYXMfB0mSUcFEGgjZeQTUX8RxNmmwSkMk/LhQgsWnL3Rus+9CvldoZUcy7T8RjtncDAaW/QnjMZPSpwrmebczyUNqqoNJMt20yaTgX9jQtk8Ue5qgX1AJG20eVNR14MFQdOpfXiSf56RVkgV2BTjLRhOig2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUFPzXLp; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUFPzXLp"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-134ac81c445so9255381c88.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 14:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779485709; cv=none;
        d=google.com; s=arc-20240605;
        b=C2eXU0PaJWbSLxvPoE/rr7NCe2xUUYXfQfWwGybjG5ipYp/BpuC5D5V9G55hVY4Ok4
         I72+Z3SvUPxlXX32/qzo+YFJWGYkOLdaO9OcWoMcaIiCPkQ/uVs3v36NTf+hawRo8N5H
         1n46WMekYX+/EVkpOvKwmKRp1BkyMqfT75mv/q/ex3coTOr2Pwu85kKX5cCp5zSO6dGg
         aeZJmTFB4gevd+Y9QO+itU1HmnT2/jPuHGipsIsjq9agRvl+lIKqohQftrQeAz4CXQGB
         cBW83p9RcVx4vWM9DpIpxezUNx26K/GKzbxvnAtX2R1+g7oY3LAxvVJ/1Kp27jKi93k7
         EbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8h6W9a2RrHRkCjSZUakkIOZj2QLkrMpaYUdZtjDG85o=;
        fh=91QGYt6IqY2tEFAID6ZWJ6dSC++M38hEZvyjjHwosNY=;
        b=aP/rKu7tGI4N3iytWe5yXnq5Atmafd5y7irE8+PY9HLCqo/ZBOOO0WHrA38Nt8uwWZ
         ZEnZdm35KCVGSpmtYgznL42pJOcabDtp7VPXRm1Q8ligB5gJ3ovqk6aL5Vka9YiWnHZY
         SI5ZHqzWw2hFwYqTYs13pKdYROxZk1JIpKy8/UBhnRe45qfBqoA5bp+3M5CYkcqruLGm
         g8Uy1vmob6j5ekyK6m06KoPsIv4c1tTUXmKyHxu5h+/3roP74XERlt7+Sv+cJXC6Fl/c
         j8UjLAeDhH2DoRpFBtiJeGbJA6VEpreFRgfTQwapfGd+J8euURHub1wevOivZPcNHSWK
         C9yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779485709; x=1780090509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h6W9a2RrHRkCjSZUakkIOZj2QLkrMpaYUdZtjDG85o=;
        b=vUFPzXLpHQq4B5TeXCsnVwSngf5JMU2XBdOTJj/PWzJc57V1O8/ynfj2Sg6TXXchHv
         UN84uIg/e2nbqhMs0m43hnea+nJxMbyxaHd0tBpq1yfomb2TVNtQjgHpymrp6o5eyK2w
         1P8eJ7bBu8ArlEDWcYRmbMmGSZ4qiUE2Tg6tR7TozhoJbtd60cJB+DOptepcu5QSH6mM
         pFeKkTH7yf4di9viGxNa9csMgDdWsTQoiiLSw1L7sjukKrsaU71igyBXRHr27twrxk53
         Ask6VW6dZ2lyGyb2Q9cvtvGkFapbR4sBOptFDvEnO0V68LXZDkmAMVGL/PHEM1HLrH9C
         P5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485709; x=1780090509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8h6W9a2RrHRkCjSZUakkIOZj2QLkrMpaYUdZtjDG85o=;
        b=lTjIjs2UyJMQjgs/mTxvYPHxj5dvuOyB5ZSQdg5NqqWgVVJVmeZ40CdSiyAzrKzo/y
         etAEY+8JNPt/ieFQZ0StJrYNtySWhTeEf2mELrqBlf0/tjTfXzIq2p7BuT7BmiTYBCON
         zCD/MMLimmCvlC3ZcSJVjiHN18aR60QdNXONLLhWcLoqEF1IQKAPGjxhXQoUP2+DFfnM
         K9H7/Yk9XM6CFokAP2kARrW0q4wB8QznLEa30vk82BSa7tRj+WlT+FYY7Wfbk1r9atqI
         HNvw5a7VUosjRke2BU8QIW1UG3zvihbMK8M3OqBfTzzpmUrd6KcRRMJOta6fbnMGXoX3
         VH5g==
X-Gm-Message-State: AOJu0YxM/bUvHVEVWGT0ok35maPj0UHISTQcYp+EMdDUG7DDxvqPR6Vz
	vgaEtQEOh1Aw7PL9TbGeOtZzXa9eFhDoGDomyqOiXhtQgAc51BNy3o3eazfOBrMCw6HxQMjB4UY
	GLSGhCokJ/6s9t7QoZhuGIkMIYJOUgDgU9UWqwLXWWo9GfL3fQbXgxw==
X-Gm-Gg: Acq92OElKXQm50MuDLOyi9ZbFXNhlvUTYB5vjXTy+rkZq8OXCSu3Iucjz3trLutgS+S
	LOs1u2qYV8g7CiU4sfAhHyI1nZxYbRYEQUF4K3FcUUTieXYmbyrveFkf5PDZ1Vz/uuWEEEzB0tY
	LrfNkxf8s4ibnD6zCr7JFimuIcbTMjTuXMcKdAn/x1j2lgSSRITZedMrk6zy1SL82IgvDy5IYIh
	G7iDqrDTm/IUDtGXQbUIecqFP884I7dW0+and/TZMPTA915B34QrXO7PvfejlNaLpkoCclEFWdL
	hABKr7y5ErK5G9a6RA==
X-Received: by 2002:a05:7022:100a:b0:135:fdeb:4776 with SMTP id
 a92af1059eb24-1365fc779e3mr1949222c88.34.1779485708931; Fri, 22 May 2026
 14:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-4-dmatlack@google.com> <20260522211333.D56A21F000E9@smtp.kernel.org>
In-Reply-To: <20260522211333.D56A21F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 22 May 2026 14:34:42 -0700
X-Gm-Features: AVHnY4JpuIbwi96KtUWFH2D1iE7-iC6vCxFKsYXwS1gOK1ets8Nv2GgQxQFJCJM
Message-ID: <CALzav=cYxfUDBbWf=a3GM15f=2HZF8CJ7Ax5G2vg1VjrnC7w-w@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Pratyush Yadav <prty@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] pci_flb_retrieve() frees the incoming preserved memory (ser)=
 on failure, causing a Use-After-Free when the core retries.
> - [Medium] Leaked reference to the incoming FLB when a device's preserved=
 refcount is corrupted.
> --
>
> commit 5af02c95c00f317cc5c4fa203b8b79373f2759a5
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Track incoming preserved PCI devices
>
> During PCI enumeration, the PCI core fetches serialized state from the
> Live Update Orchestrator to identify incoming preserved devices. This
> patch adds tracking and lifecycle management APIs for these devices.
>
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 065d5af822f74..96c43b84532cc 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> [ ... ]
> > @@ -128,13 +157,49 @@ static void pci_flb_unpreserve(struct liveupdate_=
flb_op_args *args)
> >
> >  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> >  {
> > -     args->obj =3D phys_to_virt(args->data);
> > +     struct pci_ser *ser =3D phys_to_virt(args->data);
> > +     struct pci_flb_incoming *incoming;
> > +     int ret =3D -ENOMEM;
> > +     u32 i;
> > +
> > +     incoming =3D kmalloc_obj(*incoming);
> > +     if (!incoming)
> > +             goto err_restore_free;
> > +
> > +     incoming->ser =3D ser;
> > +     xa_init(&incoming->xa);
> > +
> > +     for (i =3D 0; i < incoming->ser->max_nr_devices; i++) {
> > +             struct pci_dev_ser *dev_ser =3D &incoming->ser->devices[i=
];
> > +             unsigned long key;
> > +
> > +             if (!dev_ser->refcount)
> > +                     continue;
> > +
> > +             key =3D pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> > +             ret =3D xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL=
);
> > +             if (ret)
> > +                     goto err_xa_destroy;
> > +     }
> > +
> > +     args->obj =3D incoming;
> >       return 0;
> > +
> > +err_xa_destroy:
> > +     xa_destroy(&incoming->xa);
> > +     kfree(incoming);
> > +err_restore_free:
> > +     kho_restore_free(ser);
>
> [Severity: Critical]
> Does this error path create a use-after-free if the retrieval is retried?
>
> If pci_flb_retrieve() fails here (e.g. from -ENOMEM), kho_restore_free()
> frees the preserved physical memory for the incoming state. However, the
> Live Update Orchestrator propagates this error without marking the FLB
> as retrieved or finished.
>
> When the next PCI device is enumerated, pci_liveupdate_setup_device()
> calls pci_liveupdate_flb_get_incoming() again, which invokes
> pci_flb_retrieve() a second time with the exact same data address. The
> function will then attempt to read incoming->ser->max_nr_devices from
> memory that was already freed.

Yes but that is a bug in LUO. It should not be attempting FLB
retrieve() multiple times.

(Pasha and Pratyush FYI)

>
> > +     return ret;
> >  }
> [ ... ]
> > @@ -280,7 +430,83 @@ void pci_liveupdate_cleanup_device(struct pci_dev =
*dev)
> >               pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n=
");
> >               pci_liveupdate_unpreserve(dev);
> >       }
> > +
> > +     if (READ_ONCE(dev->liveupdate.incoming)) {
> > +             pci_WARN(dev, 1, "Destroying incoming-preserved device!\n=
");
> > +             pci_liveupdate_finish(dev);
> > +     }
> > +}
> > +
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
>
> [Severity: Medium]
> Can this early return leak a reference to the incoming FLB?
>
> In pci_liveupdate_setup_device(), a reference is held to protect
> dev->liveupdate.incoming. This reference is expected to be released via
> pci_liveupdate_flb_put_incoming() at the end of this function.
>
> By returning early here when the refcount is corrupted, we skip the put
> call, leaking the reference. Furthermore, dev->liveupdate.incoming is lef=
t
> non-NULL, which means pci_liveupdate_cleanup_device() might later try to
> finish it again and hit this same leak. Should this error path drop the
> reference and clear the incoming pointer?

Yes but dropping a reference to the incoming FLB when the refcount is
corrupted could lead to use-after-free. Logging a warning and leaking
FLB seems like the safer approach, aside from panicking.
