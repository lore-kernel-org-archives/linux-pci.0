Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9730EF90
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485354; cv=pass; b=j/QJPFwn9p8PTOtcJCt2+bkWCeg3dYvzEmmpwS/aHYHgY4bLdQF9tQOgG4G4mKKJqJH2y7hAyNWDdieFPxtj0p5DrbRdZPBoCUUgQ1rQGGrIxXPvIXt/6hUZcH4aPWFaX5mM37W9399HxUHJ7iq6jYQLnwFmqvcdCBT0N28juUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485354; c=relaxed/simple;
	bh=GI3ksNffcgu0gYhPpqaOoDcdU1m2F3Yiyb09sVMjOvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0nMDYq8YbzPzXAkfXtfdn+aImnuJa0nZGKFIbEfiwgVxamSWWpHGyTTGpX1hF50gyT4z5AB8PIePQ4wfgDHNB1qBIAmyIqJm6VdPqfLLwqNcvZgrOJUgCmLP7U8vaUB3rRqSczhhYSnvcLbbp2epbgoNkvSE9VhVO5O0WJBwD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pV11dzqx; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pV11dzqx"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1357c851a48so9930145c88.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 14:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779485352; cv=none;
        d=google.com; s=arc-20240605;
        b=XK3luXaPvIBklqm2dth0IewDLW1ksbWLb6+QqlJ0QoLCQpq24rmmKfL2bm1pq+KoL6
         jsSucYn5+amikjZMugfPiLk3IhZjl6xefqiGiPHcfneAUxsPfujoQ1Gty7vDyb+tvVi2
         WVlPUxM1ejFMD1rAIDIpNrfbxXsaxgS9eKUv5pyCurXWhqU3c1lnIXWWFNr1uV78gcaV
         TyAjaEqIFv94z3gkZH+3ptHZsMsUQ0jXWdE2Gu2saVLhNwsT3rkItiraNo4COKvuVoNH
         nOIfaaKihjcub33XX2vHUkbky+k/NbW02VTSn2WFJmRIebZdrQ+uHZFBFePbqnWdLy9c
         KAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6K2ANhvmgyd4o7NGx/ivPgd7PtVVhTtattoThaE0WQc=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=IEbVtH+/rS1mN7LTG/fYilyKNYvu3YUlka4udhAtZ3ZZ5PhFIJ33BP2rkcO3LkEiPT
         70LnHKdrh7aykZFdPhm8aXWnk6NANkEZJxxd5Nu++yuTGiswlf/EekbiFJtL2UJu2QpE
         GcJm6TXf02oazKYDFAnH+I0BVW+r1luLzdwixI8fQdO8r7/LfEV8+8UvMAIL/mmFviTi
         FBCXXVsmcas7h5Ma0M/HMX990VmT/e0CHWe+mD+7oU5UnSSI00rORlJdj65OY3BV9HNY
         /jipR2M7q3s2ZJFGrtkWWkmtujto5Qud/MefvmKx6BwaO1soAR9kumLPkXVTo6Vpl5hy
         DDCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779485352; x=1780090152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K2ANhvmgyd4o7NGx/ivPgd7PtVVhTtattoThaE0WQc=;
        b=pV11dzqxotpQYnIXFL5xD14B7+tGv9izYT2Pya1M30HF9tjMzIPu4szhIIqNUjgRtt
         zq6on0QLXZIPVokD99xUS9FrK/9XgXnNKxGkCRelB7b4Lq7IMRs03Ol1j4NmA1QYNPdl
         REOUt5l/2umqbbf7ePXjaeeNNvi/7xNwDgogvZB/WrlP92wqcb7LyW1JHyL1h13Skla4
         mhJ2x2wmvQxt/iCE8scgzrfT4dIPb3Xg0x7xXh39HyzfxJtsPlF7PfDAaFBlQCI15BHh
         rPTenL2Z6ULmrJf5eIp5fzslbHcoFYxC/vCt+XASr8DIMGCC4XlZALUCS/PuxfmfTU1k
         XWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485352; x=1780090152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6K2ANhvmgyd4o7NGx/ivPgd7PtVVhTtattoThaE0WQc=;
        b=fNeTbGev/PCUpDeDw1vuT2eypdXyjBrOovJriwBnzUC7Nx4Vk8g06xH3SMkodoXwCI
         6hnTLsjCsCoXv1KHokBwOqsoDsTwJivXpVmmp9fwNKkvVE9EtmzgypvfhGMNHQrV/vR/
         efRKKdx2MSouDARVrC2il7OKulsFW9LnzrVYSQ9k/jfv8ATgZcBQOQfbb1UGvJin/zD2
         buYNWnkJqXjsUSb4euybgWO+lYH4VJsMjkaKu0DcfOjHtbeHjRsdHHrWjPrUx9Q0QiZ8
         M0IpVMFndsa/HgU+jhdJ1rcRTYOyHTccsP9sZv33lxtRxH52hjLgxEccAqzDaDH4gTEw
         WXsA==
X-Gm-Message-State: AOJu0YxwovQdXBSePr8QnG9Mymp36gmA2QxCysMvYQqtDGW+o3fH8Q5Z
	TfREfsQs7dLG4907YaojK6a2WHZw7l206AGOKTDz/oGiPLuV3B5zInTeImRZVuUWnuUmoM/+IP/
	rRP0dpjTR+h15tLosfmtxOr4qmXUJSECmSf8G7box
X-Gm-Gg: Acq92OHVT8Gl0T7sgBG9Cs595rkjm+7pWl5j6K7KZOEkCMQyTSWfYkcP8hX6cVthdRh
	yBJq7Cq0A25wuwFXCctqW5DNEgvO1TuUXK+b6pJz79KPlFYwhj05pYkaWJWmK9ae/ic5pGcHlHh
	Rjn1IfScxMKOid0ZvJY3TywmtrewtVoW4tvKW6/0jn/+MllhmL3OZhIjN2WBRFBMae3JdU3XRDk
	JjLIqNc/jH3Vo50BeWPwZ4ZWyz7NKTqh/Xpf6M/0ooFK0PKcGdK5NXpIsmvOo5qrvr0Rc8z0uwG
	QyFqN9iN7+hHqiyZEw==
X-Received: by 2002:a05:701b:2905:b0:12d:ce60:cb52 with SMTP id
 a92af1059eb24-1365f81b447mr1254036c88.18.1779485351351; Fri, 22 May 2026
 14:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-3-dmatlack@google.com> <20260522205453.F34021F000E9@smtp.kernel.org>
In-Reply-To: <20260522205453.F34021F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 22 May 2026 14:28:44 -0700
X-Gm-Features: AVHnY4KamDj--aV3AykLsYOKZZoEGo-UbptTXXYbt8naapMG4RPx0patVsAYs7U
Message-ID: <CALzav=fgi_ezr7JV3to=RM-RC7sF_XsEcash_+vp65J-jXnkWQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI devices
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 1:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Acquiring a sleepable rw_semaphore (rwsem_write) during PCI devi=
ce release, which can occur in atomic contexts.
> --

> > +void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> > +{
> > +     /*
> > +      * It should be safe to READ_ONCE() outside of the rwsem during c=
leanup
> > +      * since there should no longer be any references to @dev on the =
system.
> > +      */
> > +     if (READ_ONCE(dev->liveupdate.outgoing)) {
> > +             pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n=
");
> > +             pci_liveupdate_unpreserve(dev);
>
> [Severity: High]
> Can calling pci_liveupdate_unpreserve() here cause a sleep-in-atomic bug?
>
> pci_liveupdate_unpreserve() unconditionally acquires a sleepable rw_semap=
hore:
> guard(rwsem_write)(&pci_liveupdate.rwsem).
>
> Since pci_liveupdate_cleanup_device() is called from pci_release_dev(), t=
his
> runs when the last reference to a struct pci_dev is dropped via pci_dev_p=
ut().
>
> Because pci_dev_put() can be called from atomic contexts (such as hardwar=
e
> interrupt handlers or while holding spinlocks) to drop references acquire=
d
> during lookups, acquiring a sleepable lock here could trigger a
> scheduling-while-atomic BUG or deadlock.

> > @@ -2490,6 +2491,7 @@ static void pci_release_dev(struct device *dev)
> >
> >       pci_dev =3D to_pci_dev(dev);
> >       pci_release_capabilities(pci_dev);
> > +     pci_liveupdate_cleanup_device(pci_dev);
> >       pci_release_of_node(pci_dev);
> >       pcibios_release_device(pci_dev);
> >       pci_bus_put(pci_dev->bus);

Gemini found 3 files where pci_dev_put() is called under a spinlock:

 - drivers/net/ethernet/microsoft/mana/gdma_main.c (mana_driver_exit())
 - arch/x86/pci/i386.c (pcibios_fw_addr_list_del())
 - arch/powerpc/platforms/pasemi/dma_lib.c (pasemi_dma_init())

OTOH, pci_release_dev() does not seem atomic-safe. On s390, it can
take the zpci_add_remove_lock mutex via pcibios_release_device(). And
on all architectures it can call kernfs_remove() via pci_bus_put(),
which takes multiple semaphores.
