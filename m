Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263E47D45C
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281891; cv=pass; b=lT+UaxAKOBI7sw75XJ3p+UNK4GDEsOoNXxLLab6aGSDH6YUQiCFtpNA1MSGAfkB1W26/1WfwPYEiw48Hfd8BIZRFWT+g+waoNfqbEn0ZJgBT9jp6IqWeRQeEsdK060FQbdnu8TrpUIKlPe7KxFNZPOvrptg6du+Tc0L5eUZy4II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281891; c=relaxed/simple;
	bh=Y/7lDHTHiylr1QgLDeg6pOBDgQs1p/N3mwc5S+PKAyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njvqJcAZ+acpzuQW+2DBOJ9S+g7X1tag8Rwe2wAR+uNuhqxwcEI36Vp/lc1iG/922SQcOPAp5j+NRa8cyIK1MUFyKthOhUR8VBfs3rzPJ8f65YfGLyxnLTMRcSP0ol0vpBxQTA/NWVHMuyZZR/Q/YPLVlirp01tEXf1gvxMfh8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOO0nKqW; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOO0nKqW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so374058b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 16:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785281881; cv=none;
        d=google.com; s=arc-20260327;
        b=GZqEI74fU2nPq+oK+pDwEYCEQhW7XYVYfiZybAI5Q2wGck5sScHIr2wa+47gPEB1qL
         dGqFvq9t7A0fgpt4jZWXP0noodgI+hcfa2N74S0TVMwOMvmg6mUBNTNGe5Uy80pAsxMv
         5Mak5jcD0Jso6QScBL1NnetyGGH1wk8byHfm8r0jAdKMwq0ZBk188Vpi+CqF7mNzFDaB
         O4gBL+dZ3ntX258XK7gJveQakh7tOjCC/Z0NjEY4zsIQ84W5eiqjZz0366yY5JXuxF3C
         8VUY99yy5RP4eH1606lJBs7ASrxCJF7jUUqGtcRkIlPwYFEU4xKwK5t3px/0pfWvI57N
         TGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PnypmSI+s/fXBsLmEE0Vb445cRMkPE/zdF74oKMtcHQ=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=VXdOfwgtKR6QIugUTk3WDVBB7XWcY0EM87q5IaOoeTHOnrGE1ipfnN4NZxpFDvNr11
         NtgCOD7Jf3zw7omsX8P1avDeViiyeRIFt32Svj4MqpiXT+lDYH9U0CyZ72B4eYLLgrry
         N+o4YIgdJ/FiCF6HzVpfkBMCBBQ6lHxVsC1qaLrCpmM77VFIC123jlof4CxuBkwIqS4S
         vL2m5ie5X+0Qp8eYjqmKt3jlCJTxq2oHXQrvWRq9oHUbtdsriXrJnEa8LGCfXdftmScT
         Nl/TrXpsxffrb92KcC2nTBiLeRLSf8yaZCqgDp5PuaXlq7Ybj915XJzi+2bPT6QpzLW/
         k3MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785281881; x=1785886681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PnypmSI+s/fXBsLmEE0Vb445cRMkPE/zdF74oKMtcHQ=;
        b=sOO0nKqW3XSMzPcqZGurTouwQfx7+l5B4EEGta92vQHlJiHJHpYz2gwaLM2mopPU92
         igF3hE5G+hz6A4DW/XBBDIlzi3wBFiOPiOWC3rR4RXmknU3jXAmm4sT/9xowQwf33tX8
         dBchX/+FGwnfmPiepsS/V2sXkHKG2u7IfQ8sn3rRw1Duuh6YeVHyeiFOfnaVyhH2K3/Y
         8eIALYurcP1N2vW9/HUCNYBrmsGVa7mYIoJ3pPriOwu4fVue7MpkWYJI+NDvDfgPvS2j
         oi9Nv/Db5AIYRkVZnyc9M7cUxXYqiM4XbcBegEglK5/UHMVgPflpAamKtdS061nQw6M8
         iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281881; x=1785886681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PnypmSI+s/fXBsLmEE0Vb445cRMkPE/zdF74oKMtcHQ=;
        b=BQV0yw3vpSgMS/mObXwdC6W+JyZ4dCQDAuuzn+PS/3VdS0EZBkFJPPft/INrC80SFV
         +B0la6763oPjbofDbEHiXEtjIrALtW6fmTVBAPCvweD8l0UsDolz6ae8KRCi1mXXd9FJ
         /zXGTTRTd6pNnvPhEg08Vp0oLM8WxuYKW32PrCRB+3PMNE5TQsu20vv/kyJ0kQfHBnAx
         ocOuDMXagKG+1jjxjoC3IE1WfNn70uz41y6mpXxodMfX9YP9Ph7dZLJSVgX3a2JdSXOB
         Cyih1Qe3UTypWPySZQvoDRD8YvP28uUmkJUYqWUtGNrUalUJxvy/6fziUY7yjpvxhOwu
         zDYw==
X-Gm-Message-State: AOJu0YyG1rMJa1Sc6elE0pyiRmFIQToF0jk4NRc0PkKuQ+NiMiSwiuvl
	fVjtVGNyNttgMZxq5SxmwyUeWaODNLUDmtwoidl2aCCktPEQGgsaERIJ+DzxuO8ZRR7KsCStqHr
	BwwPyOhQ+mcWv8RCFotoN9rL2WHz405V4W8FWrARl
X-Gm-Gg: AR+sD13SljwnAeywoIZnBgz2Anw4MMIQXmhwpVVt4hgvglrBMUshrDiKt+Fo3kx0qP0
	3xl20X36B9wS7/moGbtBLvoGZIGBAYOZon0X43oLKfawZdz6lICeQPgslImugC2R7JScCpUSwTe
	m8vrZCAEonRgPxHQaV12MTQXhlxNHdSkYx+tLJCFtPZXY6EqiSAfFQ9SoRaAlbvLmYnFMFXVX/q
	VpNE+48TnKWMb6RyGVphhY8TSjcZLi80Gdg11tfSm3IWvX0PF3ycMEWbRvG6Qj6wazreofN3YTf
	ooGkmH9R6PM7JShtVKzlHiabTvVHKDm+siS3sTx7Q1Do
X-Received: by 2002:a05:6a20:7d9f:b0:3c3:719d:dfe2 with SMTP id
 adf61e73a8af0-3c8ba5b7fd8mr5420726637.36.1785281880740; Tue, 28 Jul 2026
 16:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-4-dmatlack@google.com>
 <20260728222257.56AD41F000E9@smtp.kernel.org>
In-Reply-To: <20260728222257.56AD41F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Tue, 28 Jul 2026 16:37:33 -0700
X-Gm-Features: AUfX_mwUmZPQSsI1M3rguBFdOcHxxC_9pcGjpiPxQwiLxWBxcM9tgJpez83n9Xw
Message-ID: <CALzav=et-+vV2ewWuB0MKV+JCoLdWr+=W8K7Tf-AX0kj_TkZnQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] Unconditional kernel panic in the incoming FLB finish path if a =
preserved PCI device is missing or fails setup.
> - [High] `pci_flb_unpreserve()` destroys outgoing FLB memory without clea=
ring device pointers, leading to a Use-After-Free.
> - [High] Transient errors or version mismatches during FLB retrieval caus=
e an immediate kernel panic on device setup.
> - [Medium] Leaking preserved KHO memory for `ser->devices` on early error=
 paths in `pci_flb_retrieve()`.
> --
>
> --- Patch [3]: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved=
 PCI devices ---
> commit 8fdc703d6dd44076cd03589af0bcffa13c79e7f4
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Track incoming preserved PCI devices
>
> This patch allows the PCI core to track incoming preserved PCI devices
> during enumeration. It fetches the serialized state from the Live Update
> Orchestrator and exposes APIs for drivers to handle incoming devices.
>
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index b003b7069cdb0..5ce5f8b369029 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> [ ... ]
> > @@ -140,15 +174,91 @@ static int pci_flb_retrieve(struct liveupdate_flb=
_op_args *args)
> >  {
> > +     struct pci_ser *ser =3D phys_to_virt(args->data);
> > +     struct pci_flb_incoming *incoming;
> > +     struct pci_dev_ser *dev_ser;
> > +     struct kho_block_set_it it;
> > +     int ret;
> >
> >       pr_debug("Retrieving struct pci_ser (0x%llx)\n", args->data);
> > -     args->obj =3D phys_to_virt(args->data);
> > +
> > +     if (ser->version !=3D PCI_LUO_FLB_VERSION) {
> > +             pr_err("Incoming PCI FLB version (v%d) is incompatible wi=
th this kernel (v%d)\n",
> > +                    ser->version, PCI_LUO_FLB_VERSION);
> > +             ret =3D -EINVAL;
> > +             goto err_restore_free;
> > +     }
> > +
> > +     incoming =3D kzalloc_obj(*incoming);
> > +     if (!incoming) {
> > +             ret =3D -ENOMEM;
> > +             goto err_restore_free;
> > +     }
> [ ... ]
> > +err_restore_free:
> > +     kho_restore_free(ser);
> > +     return ret;
> > +}
>
> [Severity: Medium]
> Does this error path leak the KHO memory for ser->devices?
>
> When jumping to err_restore_free (e.g. due to a version mismatch or kzall=
oc
> failure), kho_restore_free(ser) is called, but it doesn't appear to resto=
re
> or free the memory pointed to by ser->devices.
>
> Since KHO pages are reserved across kexec, will this permanently leak the
> memory for the uptime of the successor kernel?

Yes, but PCI FLB retrieve errors are fatal (panic).

>
> [ ... ]
> > +static void pci_check_all_devices_finished(struct pci_flb_incoming *in=
coming)
> > +{
> > +     struct pci_dev *dev =3D NULL;
> > +
> > +     if (READ_ONCE(incoming->ser->nr_devices) =3D=3D 0)
> > +             return;
> > +
> > +     for_each_pci_dev(dev) {
> > +             if (READ_ONCE(dev->liveupdate.incoming))
> > +                     pci_emerg(dev, "Preserved device was never finish=
ed!\n");
> > +     }
> > +
> > +     /*
> > +      * This should only happen if a driver violated the contract to c=
all
> > +      * pci_liveupdate_finish() (something is extremely broken).
> > +      */
> > +     panic("Some preserved devices were never finished!\n");
> > +}
>
> [Severity: High]
> Is an unconditional panic here safe if a preserved device is missing or
> fails to probe?
>
> If a PCI device that was preserved by the previous kernel fails to probe =
in
> the new kernel (e.g. the driver module is missing, or it encounters a
> transient error), pci_liveupdate_finish() will never be called and
> incoming->ser->nr_devices will not be decremented.
>
> When the Live Update orchestrator concludes the update and calls
> pci_flb_finish(), pci_check_all_devices_finished() is invoked and sees
> that nr_devices is still > 0. Does this mean normal system conditions lik=
e
> a missing driver will trigger a kernel panic?

The file associated with a device that fails to be enumerated or
probed cannever be retrieved by userspace, and therefore never go
through its finish() callback. So LUO will never call
pci_flb_finish(). This panic will only happen if there is a serious
bug in the driver or LUO.

>
> [ ... ]
> > @@ -325,6 +435,75 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev=
)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> >
> > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> > +{
> > +     struct pci_flb_incoming *incoming =3D NULL;
> > +     int ret;
> [ ... ]
> > +     /*
> > +      * There is incoming FLB data that matches pci_liveupdate_flb.com=
patible
> > +      * but retrieve failed (pci_flb_retrieve() returned an error or L=
UO
> > +      * failed to acquire a reference to pci_liveupdate_flb_ops.owner)=
.
> > +      */
> > +     if (ret)
> > +             panic("Failed to retrieve incoming FLB data (%d)\n", ret)=
;
> > +
> > +     return incoming;
> > +}
>
> [Severity: High]
> Does this panic prevent the new kernel from booting if there's a simple
> FLB version mismatch?
>
> During PCI enumeration in the new kernel, pci_setup_device() calls
> pci_liveupdate_setup_device(), which invokes
> pci_liveupdate_flb_get_incoming().
>
> If pci_flb_retrieve() encounters an error like a version mismatch (-EINVA=
L)
> or an allocation failure (-ENOMEM), it returns that error code. This bran=
ch
> then catches the error and unconditionally panics. Will this reliably cra=
sh
> the new kernel during early boot and break the kexec handover fallback
> mechanism?

Yes all FLB retrieve errors are considered fatal. A version mismatch
is considered a retrieve error because it means the current kernel
can't understand the data passed by the previous kernel.

We do want more graceful versioning support to handle
upgrade/downgrade scenarios, but that requires deeper design work in
LUO before the PCI core can use it. We aren't going to build a
PCI-specific versioning solution.

>
> [ ... ]
>
> I also have a question about the unpreserve path in pci_flb_unpreserve()
> which might lead to a regression:
>
> drivers/pci/liveupdate.c:pci_flb_unpreserve() {
>     ...
>     WARN_ON(outgoing->ser->nr_devices);
>     kho_block_set_destroy(&outgoing->block_set);
>     kho_unpreserve_free(outgoing->ser);
>     kfree(outgoing);
> }
>
> [Severity: High]
> Does pci_flb_unpreserve() destroy outgoing FLB memory without clearing th=
e
> device pointers?
>
> If a driver fails to unpreserve its devices before the orchestrator abort=
s a
> Live Update, pci_flb_unpreserve() will issue a WARN_ON but proceed to
> destroy the block set and free the outgoing FLB object.
>
> The dev->liveupdate.outgoing pointers on the pci_dev structs are left
> dangling. If a new Live Update is subsequently initiated and the driver
> attempts to preserve the device again, pci_liveupdate_preserve_device()
> will access dev->liveupdate.outgoing->refcount via the dangling pointer:
>
> drivers/pci/liveupdate.c:pci_liveupdate_preserve_device() {
>     ...
>     if (dev->liveupdate.outgoing) {
>         if (!dev->liveupdate.outgoing->refcount) {
>     ...
> }
>
> Can this lead to a use-after-free of the KHO block set memory?

Yes. We can handle that the same way as dangling incoming pointers and
panic. This will only happen if the driver or LUO are very broken.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.20=
98560-1-dmatlack@google.com?part=3D3
