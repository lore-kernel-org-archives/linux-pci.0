Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD041D12C
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736673; cv=pass; b=cKRgjLLv1yzmOoGWmSOfI3bg8wg5dRg3ZfwxkMhM58JdkcmFLoElsQgDmgMzYEIL0d+eoebJOFjt8Jcizow5UH9HF0N1JTFeQOsOC1Y5tgib9AZ/CrikOcjQqkVBC2Yd7PSCe8Zy7uG44tu99oLvVkj6cRC2cwiEvpwNkb7C3A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736673; c=relaxed/simple;
	bh=X+axyyoRN6mByFR26fJSK7CZ9lsHionFDsNxBN6Pz3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEIgkc3OT+Ev46eNMp/bhWkxFKOVOgfGmvnvFMHnhkoPRzNmJ1n8Tt87olv88/9vytPtOBwUMcndS7/QONVzUo13h5wHQboxm79iNq6Sl7o0h7qDJb6wyYGxRzcx3zAg4TlZygaA4h+4ruDPnx8+InjZ6jsHQL/zfEStzNC+8NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvyzGsZQ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvyzGsZQ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so11384501e87.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 09:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784736669; cv=none;
        d=google.com; s=arc-20260327;
        b=clibmEcXbwfsROkrK8ZSDAC2YPuXZRscgJRBr0vCIpBuLsdjTqsN0P7vM7vIQd2vbD
         foAjVWqWAxd0f3wiSfaBVq0cqqzpHvlJF6e8iS7vbdw0m8bdRKEPe/ZJ5IeIMHJ244PU
         Yzrn6rjsijoW/ltbqtmO7aWGd2pWrPLZUWdi3B/rdExQLjgzG01PkUsr9j/9+4gIypzT
         mOUQaO0hZ09ovzbzkBxaUOW7ci+hFhwyr+jAQBZraFXklHdW7QItoxB8EHayZccOIEMO
         ZQ8ZDkOn7HjGuxvcQ/JH/ahj5VKiki/vIUqhD3i7GjYaenFdSkAnVp38X/TqEl7/Tr5s
         qp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IcI5qs7jN/uu8ChWZU0RS5LTqt9hibuExW779DaX+1k=;
        fh=wZyTKcIEOp9HaR2ywOpDH0+ZFFTRqWFYgeiMSbS8PMM=;
        b=Ao0X7pLqD7S2OSmzNMkD8ONKBFf55LU3FpUXEoclFJtxkr+QLGmFZonhmnHpDu48io
         VztaE8sP8Bfk0NzXQkMoml4ybveDxGh2lwNA5ijXSDPK9GQdso8lFjy0v3EplxMtPNch
         kv7TE6U7Dnn+FSbjnd1Hp9eajTFa9WzWJ4Z/4mhq46YoWx6xKdF2STg4XY3Hwu45o7RW
         eIEnmWBEUVdbRqQYaRXKfi3VbtiRKUWJwIH3VZlCVFw2q0cxyki/tdk8tRYWpWsgiwi3
         OeS9g8tmoWnngU+neFpRI+Kgc73BbvK5Vo99W587do+MH1BKpu0fbwFohHyC3JKHurhe
         ssDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784736669; x=1785341469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IcI5qs7jN/uu8ChWZU0RS5LTqt9hibuExW779DaX+1k=;
        b=JvyzGsZQFLWXH6vtrVjrkY7obZQ2Boft8iNbpVV3PXM97cg7NQLtsxBNvwQrybU0zx
         1gXMxNv4JX5Ch3uEkUu71jySzryR5X91B1NTSRUINjkHsrXmF77Is1kjka4wba5egCxO
         6grh5npIDC0OMGmMArg19bup4w472jzQnCbrlCXHOM4srlk3htvRadseGDDcLN5jonIB
         OdHRwADoNGp21PKLulu52fze0KdQApMoo2rr/J4tnWDnC8BqLFEo2/Yl0Kk9qknvdQE6
         WXLfzckTPCo3wZ5hmoN1he9drCCBvI1Y3J4Jh1GXPib8b4Q4sYsGDejzmEXmPt/dCFlb
         1gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784736669; x=1785341469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IcI5qs7jN/uu8ChWZU0RS5LTqt9hibuExW779DaX+1k=;
        b=VIIoRXuZq5zC5Fak+SrN4/TsgoPlOX/OQ2BDdatKax34gIhBMjSdvItZboV9XeT+Ui
         moBuZKVnCCrnSAW/icHmf5TgEnvWNAP25gr1DkhKzOrQYwMU+vGtril5GooX98T0YnJC
         JqbD4LPSNKRPIlG1Xv7P6f+ve3QP3KlM+7G3bowAZnHLEj8iLxG++9VxtQ78QmlzYkTi
         V5PrVQxlH/ENx2eFzvKDjoRtAxP6z0uk4bLi5pX94eiccobLn9JyBYbusIICrktZR4Re
         EZLQ/Lqb+dZmfXGfzvkxvBJGMLaawaGZ5Wi1w3NfDXNNLVdKYNxxe3hq7pfUxbGS3wYy
         Ca5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqQhZDACQmNjwIdWx4+Ex0g3vc7T/JOt0q4/u2ZeUnENtDkZqsiLiAllW4G9BAbSAR7sA6cXTPBgJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyvLTbuwczi/Qy43Gb8dMt+tYdJy1157FPfZJ9YGsp5Kj4Pm/
	tSsoeFZW2zm/Ggc4GymocbALM/d2mJxZeGeItNT+pWMpmnW+SQrgJxAnNTrtx7+6qwGqJZoBm4C
	vuTUHWaCpTY03/uwtc+zFVFy6D8LRTdEqsc+hDUzX
X-Gm-Gg: AR+sD11ic57+Fd7QQRavX6UEcKdQ/qlbcmDYn3nJTnPLSZDLDu5bIvuafiQn6gTLpxk
	yJp1dX30BLbh4aJ9NYG2bC3EJzXz6CkIwc0lDMo+uV2uA9rPp2QQCRIyAxSx+7IOulllGGXLNhh
	uSHPB98hJMPDF+YRk0L8mKEZYtX/xdfbxckUR75Ji/vuqZCJ5tYS2EM7CG64f/loc5NMFSgJT/c
	6oIre1/0GrzSWgG1dlVplWHEq0J3BO1ng15SoivyQLJxO5d/aJIfiXKtnIH0xI21q4x5pmgR4EC
	43CwHPh4FDCLmw8s
X-Received: by 2002:a05:6512:124f:b0:5b0:1ace:3bca with SMTP id
 2adb3069b0e04-5b28fac59dcmr5709185e87.65.1784736669024; Wed, 22 Jul 2026
 09:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <20260717163820.6bc8c13b@shazbot.org> <CALzav=eQ-0rbxh6Eekbt4zUoNGNZc_THmSCvVWVwE3om1BPtdw@mail.gmail.com>
In-Reply-To: <CALzav=eQ-0rbxh6Eekbt4zUoNGNZc_THmSCvVWVwE3om1BPtdw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 22 Jul 2026 09:10:35 -0700
X-Gm-Features: AUfX_myAcr2geqnXYh1xnj0XUmNEe2bz-zIOTwyIeRO5MtevXktrjd32lAucA7Y
Message-ID: <CALzav=ej05tZbVJUqZC4BOSCtZ=EkQ8GsckqLN61qKbyMHWfKg@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Alex Williamson <alex@shazbot.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 3:00=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Fri, Jul 17, 2026 at 3:38=E2=80=AFPM Alex Williamson <alex@shazbot.org=
> wrote:
> >
> > On Fri, 10 Jul 2026 21:26:06 +0000
> > David Matlack <dmatlack@google.com> wrote:
> >
> > > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *d=
ev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> > >
> > > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void=
)
> > > +{
> > > +     struct pci_flb_incoming *incoming =3D NULL;
> > > +     int ret;
> > > +
> > > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void =
**)&incoming);
> > > +
> > > +     /* Live Update is not enabled. */
> > > +     if (ret =3D=3D -EOPNOTSUPP)
> > > +             return NULL;
> > > +
> > > +     /* Live Update is enabled, but there is no incoming FLB data. *=
/
> > > +     if (ret =3D=3D -ENODATA)
> > > +             return NULL;
> > > +
> > > +     /*
> > > +      * Live Update is enabled and there is incoming FLB data, but n=
one of it
> > > +      * matches pci_liveupdate_flb.compatible.
> > > +      *
> > > +      * This could mean that no PCI FLB data was passed by the previ=
ous
> > > +      * kernel, but it could also mean the previous kernel used a di=
fferent
> > > +      * compatibility string (i.e. a different ABI).
> > > +      */
> > > +     if (ret =3D=3D -ENOENT) {
> > > +             pr_info_once("No incoming FLB matched %s\n", pci_liveup=
date_flb.compatible);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     /*
> > > +      * There is incoming FLB data that matches pci_liveupdate_flb.c=
ompatible
> > > +      * but it cannot be retrieved.
> > > +      */
> > > +     if (ret)
> > > +             panic("Failed to retrieve incoming FLB data (%d)\n", re=
t);
> > > +
> > > +     return incoming;
> > > +}
> >
> > I'm having trouble following the error escalation here.  What's
> > fundamentally the difference between FLB data being provided and not
> > compatible (subtle log message) versus FLB data being provided and
> > compatible but we cannot access it (panic!)?
>
> There is no fundamental difference IMO and I think we should handle
> them the same way (panic). The problem is the PCI core cannot actually
> distinguish between "PCI FLB provided and not compatible" (should
> panic) and "no PCI FLB provided" (should log). I would like to propose
> changes to LUO so that the FLB handlers can detect the former
> situation but that requires some non-trivial work that I didn't want
> to block on.
>
> For now, I guess you could say it is up to the user to not perform
> Live Update between incompatible versions. I can update the
> documentation.

An alternative approach would be to make the PCI compatibility string
just "pci" and then put the version number as the first field in
struct pci_ser. That would ensure the PCI core can always fetch its
FLB data and panic on a version mismatch. I think first-class handling
in LUO would be better, but that is a larger problem to solve; it also
needs to be solved for file handlers.

Pasha and Sami, what do you think?

> >
> > Don't both suggest devices are running but we can't get their FLB data
> > to continue letting them run?
> >
> > The errno interpretation is also slightly different than the comment
> > above liveupdate_flb_get_incoming():
> >
> >  * Return: 0 on success, or a negative errno on failure. -ENODATA means=
 no
> >  * incoming FLB data, -ENOENT means specific flb not found in the incom=
ing
> >  * data, -ENODEV if the FLB's module is unloading, and -EOPNOTSUPP when
> >  * live update is disabled or not configured.
>
> I think the only disagreement is the lack of specific -ENODEV
> handling. Is that what you are referring to?
>
> >
> > Thanks,
> > Alex
