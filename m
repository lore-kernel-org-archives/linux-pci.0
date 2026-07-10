Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54105331A7E
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721267; cv=pass; b=cmJjomuZ5paHz3xb3z76Fy/NtYza/oi7p7FpLLpNvWmmRgCY3D+dyiQFEzWhBGWbrIXt4DLhTHas2KE4FkkqN5eDU4HgrGZi5k/X4Dkp2YdcuKELg/SwJnLTR1Y9eMq8dfA4CIJZnqs8D2Jt22Xn1/QdYvSWIaxpd5+BI4kwRJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721267; c=relaxed/simple;
	bh=Vff3kRK5AiWmdmzWNqNi86ldeIRObG3k21H9VsN8aes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+2bmv4YEmlxCcsX5K9gjzNbIcGV5yy8PsmiMCUrQTHeuLszpK0UH/IpwLSKybZYgpFNzlCRw+cUnf2milktjj1fCJBRXumtQJJvToHasXW1iYFGGGTLGk5snhssjMyco7UL30hm3TtUgnpdBiXqkzQcIc3V5RfayXVjSEvU0oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=df39Kejb; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="df39Kejb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848593533cbso1116333b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 15:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783721265; cv=none;
        d=google.com; s=arc-20260327;
        b=DeuumK1OZyC2KNU/k5fH7JZCNal41GOZ4mHJM7sezh/kspQs+eti3VP++W2cASscoi
         d7YlM/zwrjwmMNX1WSI3iADJQdwPtJnd95VXvY0lrML9ymBE38zbQiCMEzjxseeXg2L8
         Duo8I913ic24Mpaz9mCrHjyJJ3+Z+rXvF2JSVHI2jF04J+FPa9Ng8EctQLj5NUgTH9S/
         MQrW9cRZE0/wNkWaUK/O5kCi445oXm6A8CzpZ44TK8zCx7ih+5YaxEUF62txOCIe4fG9
         1I+/c/4RhZfz4df4K/x0VaaH760RsJJ1jEFsD1AKxFkFN+0zNcCMpgWoHc513hnrBSg4
         JsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uCi4vdatGlMYBO57z4Q+nFs0o+7WfmBZSwOdUxt/AOM=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=FX+2FGc+CRsHwMpoHD22qziwIlMT0Nbo9EPuA8EVqup9glMmVtV5MOb5TtduJ5ncip
         HRvX7bYP+6R0ABj7mRGmYQ1UPCOFW4w4Sdzf7F4bU5wJV7jvQAOyhTXin3JmRLLFxsDY
         Qxc3RotNodL5ikOxUgVty6VFjbqcbMkGd52piHXtpKOrVY4c9vtXp3R1HDY17u0FAj3g
         bCMK1FOYhDAMH34PiuqvXN4wCZx3eBeFMFHZswBPsNzOizQylSdPq8b4jU89HF6yXwZm
         PP4D2kcCXYKfBucxiuICx5/Fiat1NDVJu66QaezEdLa9uf4Wk6X7ThepBoWD3P3cJTZD
         TPpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721265; x=1784326065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uCi4vdatGlMYBO57z4Q+nFs0o+7WfmBZSwOdUxt/AOM=;
        b=df39KejbQcLt4pTQBJtPenYXXM65vPVeIRoqb2eK3HpDEKATIiZvHTr90NuN5tZba9
         49Qpk+IKd607eFPsw77kaWKg45P93f7MJOQsv2gYhGTL7nm+kWoKTRlcUjSHnjp9wPxd
         NldYGI3aaPG6kInP+Ua92uRXot8gAP08hrKE5+0jp0TRNSlFjEhVv0BBkZqSuOkoDtiT
         OCNd0r4ym8m4BGdwe/9VtmNevDVPSnACzFYl5bpzSFq0yLLTI7H5J2cKnhk2QN6lGbGA
         r5rHUZduCkKVcYwrc7jWtIBHn78Dr4w/CL8QPs8nWuLXzvQ/twFbyPtdRwllt5ylXEap
         fc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721265; x=1784326065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCi4vdatGlMYBO57z4Q+nFs0o+7WfmBZSwOdUxt/AOM=;
        b=rrsS/mQO+e3sJ59r7CiwxArehfM+h1LWZvpV+IDdTIVNk0pOTXlHn5RfWphbtxst3y
         1/l7268dQdomW6dac7YNruI58fk/0LMldfy6pkLdgBCEbPODaO4DNQrfmt+OsAOx96Eh
         y3udoStUOnGZo83n/5u2VnElRzo2Zqsn1z6T1ZC0vCJDq0vcbztX0VA4F24IjNFSxK19
         Yu2UdUYdXtzwAM39Fpu7S1XusOJ8aQmE8BvFjCBAws1KSCc42VSvBnJAXxy0dtRUoMsB
         QEcwtYd+BQA9P/Oy614NbaMw3o4LbKzsc5iSTssrspFSQ23YGtczAYC7M/TsvBQQSlku
         gxbA==
X-Gm-Message-State: AOJu0YwSh0RYMCAhLb4YAHkPwLdy5qZkhoh/KGaUkiQAHzynARugaYGL
	LEu29HAvTaONvdDOBalOf5mzzbpkvtSFUD6oHY/reNcFv+BrpcuBni9v9fu6D8/B3iukBDaFY0h
	4c3btgwl4UN2C/72CLOwV3lpS74UFCMsP1skwUVL+UACIvPU7MkZ+uFrVliA=
X-Gm-Gg: AfdE7cn6Vlx/ky219mpT1dSBOBAtnoiz0t4yc6QftWhyegc7agq8XPwzZgxkxN94+4M
	Z2R8nit/n5i+aEZCz79iQ3v3vLGIVbW7KCkgD9KomrHqTvprNKwbEFyFhLsm+/VslEfx4/O+9a9
	dBdYFB8dMhmokkeOiucT3+xn762QPvVUvqnj1YagUO2kkRtcOca+wwnaBymI6wPikJm9mJkuvUo
	jLrFslD7ykejwAGNsuNA0e1N+hzpp8a4IYb49xZf4jbKie2KHxOr/2Q2QAl+8FHqVHJm4Vl
X-Received: by 2002:a05:6a21:3a97:b0:3bf:b68f:4685 with SMTP id
 adf61e73a8af0-3c110779989mr867436637.23.1783721265104; Fri, 10 Jul 2026
 15:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-10-dmatlack@google.com>
 <20260710213733.B4A461F000E9@smtp.kernel.org>
In-Reply-To: <20260710213733.B4A461F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 10 Jul 2026 15:07:18 -0700
X-Gm-Features: AVVi8CexiXT1H3iCKRj5ssh2jkXiPSEyAsC89XKny5WUNfb4_b7wLF2ahEoukU8
Message-ID: <CALzav=c1+ZJDJ8=B1ZkBmB8cbx51ke_zFfDhPTjDfF5XhB_ZrA@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 2:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Data race on the `ari_enabled` bitfield of the bridge device.
> --
>
> --- Patch [9]: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding E=
nable on preserved bridges ---
> commit dba41feb80b848815c664a662c635fefb4ca7403
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
>
> This commit inherits the ARI Forwarding Enable on preserved bridges durin=
g a
> Live Update. It updates the pci_dev->ari_enabled flag so preserved device=
s
> can be identified with the expanded 8-bit function number.
>
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index a95bfe5eff770..74a11e520f0d3 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
>
> [ ... ]
>
> > @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
> >       return 0;
> >  }
> >
> > +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > +{
> > +     u16 val;
> > +
> > +     guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +     if (!dev->liveupdate.incoming)
> > +             return -EINVAL;
> > +
> > +     pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> > +     dev->ari_enabled =3D !!(val & PCI_EXP_DEVCTL2_ARI);
>
> [Severity: Medium]
> Can this bitfield modification race with concurrent updates to other
> bitfields in the same word?
>
> In pci_liveupdate_configure_ari(), dev->ari_enabled is updated. Since
> bitfield modifications compile to read-modify-write operations on the
> underlying word, concurrent updates to other flags in the same word (like
> is_busmaster, is_managed, or msi_enabled) could be silently lost.
>
> The pci_liveupdate.rwsem protects liveupdate structures but does not appe=
ar
> to provide mutual exclusion for the pci_dev bitfields.

pci_liveupdate_configure_ari() is called from pci_configure_ari()
which also sets dev->ari_enabled=3D1 and is pre-existing code.

If writing to dev->ari_enabled in this path is indeed unsafe then that
is a pre-existing bug.

>
> > +     return 0;
> > +}
>
> [ ... ]
>
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 739ecaab2e76f..e0c133b66a359 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
>
> [ ... ]
>
> > @@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
> >       if (!(cap & PCI_EXP_DEVCAP2_ARI))
> >               return;
> >
> > +     if (!pci_liveupdate_configure_ari(bridge))
> > +             return;
> > +
> > +     if (pcie_ari_disabled)
> > +             return;
> > +
> >       if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
> >               pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> >                                        PCI_EXP_DEVCTL2_ARI);
> >               bridge->ari_enabled =3D 1;
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but this preexisting fallback
> path in pci_configure_ari() also modifies the bridge->ari_enabled bitfiel=
d.
>
> Could this also be susceptible to the same read-modify-write data race
> against other flags in the same word?

See above.
