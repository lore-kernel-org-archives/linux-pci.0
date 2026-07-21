Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB63E49EF
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675935; cv=pass; b=XLJdfKcuAjYI2okOQZQbLrdDWwgrk/zS0m/tJxg0XVjKEW7UhIQpIaNle78AHQKyf81vUxk+eUNuRtEXYP1PZGcq24DaLefdQuu5XP9SSkml1zXhXDKA4pXoI82MJFqr8h806weZi0TDM0senGhKeI2O9a+wm1tZaDfcQEPMxs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675935; c=relaxed/simple;
	bh=BFd5p9md0SulO7r0XdkZg4DHAs3kRKCtgQkW3CzSCDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXFRHHohIVEYNwaQNM3/D8vqIlwlMZTX/OWr7mhwcfxzZdxQfwRGcljw1+Xf3IcHTE2/9qsAx2OLTYh9TbVIxMxLk/rudNb3k97k4PPrCUJsSf6j652ckM2q0xP2gf3nXVkhPs5OfGGzEVphxTF3AqFVzm67JZgU1b7g73SbfLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMw6WaiS; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMw6WaiS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dcbade417so10161538a91.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 16:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784675932; cv=none;
        d=google.com; s=arc-20260327;
        b=c6iZ+InGMIEbyB73CZpKbRMUqmVoqZyRPST6nr1p0OwquXL9bt22OHzkp/jZIISxOs
         d3u2bP56zDN29u7etkboMOPr4iGoYDVFoTx0pacDZlK5HGzkCp1fpL5pFLQ4O/Zgn1TD
         LWpfzOP+V9bjTdpEexWjNQ8j4y2fNmFhFs7e5q0Utl+6ih5K3OAfFrR9+gAdbgmYTNRW
         4svxqbcy3lIFC9xGRnBEFkywcxTe01UTHQvUZtNeQxoiAiUU+r1YUlpK6T/YoiWqDaQV
         rQsjRi4ZNtTDLAFnMRFvbU0aPSyx2/AIHul2Re9at+/8lnbmpCCA3OHRNNVRYT4zwmBu
         gGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWaHQpsMmrxTrkWgIFegEM8fU8LCXLhjFNzfjSgjkGU=;
        fh=9eylaCGoL6g0PEL2lmPxlrUNTZHM72YEZgxTPyDnZ9I=;
        b=fx512QfnxKBbALkYS8vKk1k3GBmxltXNv0unegTdBIwphTKQSENElWcW8NBpJVAOIc
         iIdn078KYxKFwSoHEny5J2ZUOzjecpuABvanSPyFAdFWiyhyELtzNlq7V2W7ZwG8M5+A
         M3yhwPJRHCcTKjXbkNtM3wU6n4dr8x/1q6OCSJ/uIPly2pAS/MDflTLgJ4pqNma6Sknh
         +0i1oSPNnHXXBcKMQifbRZiQWmtzUCP7srkbyvK/kY4Wsx30iSXduwRgDxmM30Xr7OQG
         cxnSYfggYNwrcWdHt/RBwrdXORSH/IygJQhCWI4vvPckvl3bvdMXbYG2f5Fxms7f3RWc
         pHEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675932; x=1785280732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SWaHQpsMmrxTrkWgIFegEM8fU8LCXLhjFNzfjSgjkGU=;
        b=mMw6WaiSbEFRRHD3EV8o9PRpwfucd/Qt4VWb+bMg0KnZq3qYTkiui7r9oigT7ehRhA
         bdSPyNHVCUrl7y+8TdbpLlURTtoAMWjNUAmMGE4SoTx7cTSYwausBLxoGjMk5jP0pH73
         6yHhrygOyzpg5wqKxRq4MfLGWs0/g/amRSEBFJiTXOMcISJVN8/GcoHrOIo9I/4i5Qma
         3l/QHBClq7qRX8OW621WxgxHBNUeDDqNCcsvGNoHT3Lm0Mjan/gw95GNs/oucc9rOMde
         pcJKPyxcphfpPPQEixPToUrAoXs6IGU7KWFn2dwCGJ4OuUg3t1v6ffAJrsJwCcdHXe4T
         Zd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675932; x=1785280732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWaHQpsMmrxTrkWgIFegEM8fU8LCXLhjFNzfjSgjkGU=;
        b=VTyNoMGUq68wS5e7H7Y4YQwmj2eiz5Yi1ntitgiWgFRwf3ADbCIK1NFLAK4eaTIDSJ
         4GqDJhew3o0EH1c8+bsjfdGniSOo6/4FWcZKRpXSjdNgsGOkfedvFFOmKcyJLfriqBeL
         SDfCIGN4iDE7bmo70vLNU0tiNh/a/0pSq3jD1QgUwAJpGnmT4+jagkqu/KmHGcreqSNm
         YSJrvr5jk7HwHIYeuuNhqKzkPqk25Me0hAK9ZAUcSuweY4gof2SHZfjFvS1EILu6lN13
         71l6c++YoBUO6IkWokoXeQ+odogUVyLAkD7HKSpMTujU8ngL7zeNYanDVWBLPZMgn2xr
         rYRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQxXaWSp63l/7oXAe+vA9rLY8wXDNktbQSKo2TqrFqtvdz6Vdi6vrh2GbrDmsO5XDUV1mnpeWEvbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03Ns04vcNcDbxs3cDnZ81QX7Y8C9246B6Z/RlUt1zQ+84B0SG
	0aNRR/WzwmBAOjQsaW0/F1dN8Qgqjown4yaqzU+Z5WSONbSb+YkRnhMmniqtgkS1LuTHVRIK4eP
	7vCptHiFimNdR5lN5XBj5/Ya+5kKFyRi9Qc71Y1NK
X-Gm-Gg: AR+sD13ZSTHhvQv43fmRwDwKuvpCEvQ+rOuohpU464XtsPq5dpqd6xlSf7d+JchJJjB
	hs6FDsjtIzSVL5xlk4Z/XaXPdP9h9Q7zIkLtwbDPO3ioyeMlWeb/Bbw82bQIjdiI6HUZOcY79kk
	6nrBWJc2Wmhtoue2IQFchYgQOvTt4Ut0Ha2MbnVLi6zvsTyGo37ZGrF/124Ph0GA1cVNeMYZh2X
	2z6RsPe242TbEdaOxjzhLnQLjWsA9qzzADCCuN3jsNTevGIF1tJTers3CQuAK2+i6AfIl5J
X-Received: by 2002:a17:90a:f94e:b0:38e:500:3975 with SMTP id
 98e67ed59e1d1-38e4b476b7bmr20562050a91.18.1784675931394; Tue, 21 Jul 2026
 16:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4> <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <al_3nOssZoa6RoCq@google.com> <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
In-Reply-To: <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Jul 2026 16:18:24 -0700
X-Gm-Features: AUfX_mw8WVTULDGM5fg02urMXenJj0foOmNcG_--0euC3EYm6G6QAbnPcLHsH0I
Message-ID: <CALzav=fYx7R7c6FTQ5bC4bbQ+_KNaC3gopcPihOtKmHGaB6s1Q@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 4:16=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Tue, Jul 21, 2026 at 4:02=E2=80=AFPM Samiullah Khawaja <skhawaja@googl=
e.com> wrote:
> >
> > On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
> > >On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
> > ><pasha.tatashin@soleen.com> wrote:
> > >>
> > >> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.c=
om> wrote:
> > >> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > >> > index 03075ce06ac9..df6a02240aa4 100644
> > >> > --- a/drivers/pci/liveupdate.c
> > >> > +++ b/drivers/pci/liveupdate.c
> > >> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev=
 *dev)
> > >> > [ ... skip 76 lines ... ]
> > >> > +     /*
> > >> > +      * Hold the ref on the incoming FLB until pci_liveupdate_fin=
ish() so
> > >> > +      * that dev->liveupdate.incoming cannot get freed while the =
PCI core
> > >> > +      * has a pointer to it. It's better to leak the incoming FLB=
 than do a
> > >> > +      * use-after-free if driver does not call pci_liveupdate_fin=
ish().
> > >> > +      */
> > >>
> > >> I am confused by this. Each preserved PCI device must have an associ=
ated
> > >> FD preserved with it via LUO. I.e., vfiofd would need to be preserve=
d. If
> > >> the vfiofd was not reclaimed, and finish is not possible, that vfiof=
d
> > >> would still be owned by LUO, and therefore PCI FLB refcount would st=
ay
> > >> positive.
> > >>
> > >> However, if finish is possible, and this is the last vfiofd that is
> > >> finished, FLB will be freed as soon as the reference count reaches z=
ero,
> > >> which I would think is the expected behavior.
> > >>
> > >> What is the point of holding a reference here, instead of only for t=
he
> > >> duration of FLB access, i.e. to make sure we are accessing a valid d=
ata?
> > >
> > >The duration of the access is from here until pci_liveupdate_finish()
> > >because that it when the pointer (dev->liveupdate.incoming) is
> > >cleared. So that is why the PCI core holds the reference from here
> > >until pci_liveupdate_finish().
> >
> > I think LUO gives you guarantee that this pointer remains valid until
> > the FLB finish(), because all the vfiofd that were preserved have not
> > finished. And when all vfiofd have finished, LUO lets you know that the
> > pointer is becoming invalid so you can unset these in the finish()
> > callback from LUO?
> >
> > If I understand this correctly, I think by keeping long references unti=
l
> > finish you are replicating the vfiofd bound lifecycle that LUO already
> > gives you.
>
> Yes that's right. I am taking the approach of not trusting drivers
> (i.e. VFIO) and having the PCI core maintain it's own references so
> that FLB finish() is guaranteed to never be called while a device has
> device->liveupdate.incoming set.
>
> Alternatively, the PCI core could avoid taking a reference and instead
> check for driver bugs in FLB finish(). I previously explored that
> approach and ran into a circular lock dependency between the FLB mutex
> and pci_liveupdate.rwsem. But I can look into that again, or just do a
> lockless walk of all PCI devices and panic if any still has
> dev->liveupdate.incoming set. It will only happen if the driver is
> completely broken so panicking seems fine.

Pasha what do you think of this approach?

It avoids the PCI core taking a long reference (your conern) and also
avoids the PCI core needing to take lots of short references to access
dev->liveupdate.incoming (my concern). So seems like a good
compromise.
