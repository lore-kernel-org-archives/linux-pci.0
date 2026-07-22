Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A88405C47
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739639; cv=pass; b=n55uZusqQ29sL0qcilPPSsSGjNUKNG43ddg6AbFfGMIu9HflrtJpXfB+G6INXV8nDiXjlDeeWd4yFpWK3jamgf+p8XVKr3HPRz65UbJAoAke8uQ/JWbhGH68Uq9StDX7/ZLCGU9XUSNneE4fDco7v+il+QzTiBNaO6d5SlF640Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739639; c=relaxed/simple;
	bh=6V6kom/z+kESg4y/hUUgBifatIFy6BKWqM8OtFqWQ6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6DwQIzMxHx7kcgTiLtm40iaLn+mp1+WjlwGxq+rLu2m3VOvjYwdr7HfJOIFJ7OXAAXwfGrVmOv/fTwRJPC7FuJnoR+W8jbsmZLBuJAgnEp/PxQfyJUamjneQt+NmiZ5RwGt0SUzJJMJ3OeL6ppqSlZwHW0PrOfyqbGmgHT8aTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dG7JSt3f; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dG7JSt3f"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so87504a91.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 10:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784739635; cv=none;
        d=google.com; s=arc-20260327;
        b=J/WRA44n8dvHmm9/tXX3NQtyJgGd+leLoKMXiQQIQ+u8jy/B9oRGzM4PIxckLWSs0m
         Iu16Yr7Zw0IeONW1UDFdp9/JhigbRR8rY51RSm9lbgx70B7z0EBb/y9wugvyF4807pnl
         0LTDcs1epK+X8sAXbQNxRQSxHf5fiq3L1+B2BZI73VmBo3PztJviB3tv8FvHVyTtMJtB
         isyWtZwwqUYeOx6/rzda4p9f96cL+sZ1LDSMIzzBr9oLuq8k432yVlrcDCpjsTcGjwTq
         rN2nuYCS6lEn2CfHOeiyFFFFZUCxFcz5/ZtDLD2jGPoPhqtaCqjbg4W+lFgokZNQL4Bi
         dTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b6BLtSCxCp7M8WEIqu/WUMj2zfCCYaejhLZ7J9DExtM=;
        fh=n465nb85Up7SgsXe4Xd4mD6bYGyjpQdQFro3zWCDdkA=;
        b=oj6n6K3Aq5q6DfQU7rvrn15VfVIyHmpevt9q73fQBflX9hB8ivFRKMWsTfBDhbgwWr
         NWJUfvl9lQDxkxxqhchm+DzLvBzFgzogonNK2TMdLCgEs3VP2SlykZmdmM208cHqOr/y
         4JTnPyeN1rD9sWcPFNSfSIJsdBgq3LCuwGAaLdEjontuPu77c7Wakpfnpx/rVVva/sNg
         nwO6gNimGhcgtv9bcIFd/FaxjVokJ90GDcQtCcFWnkC5rBES1om7IfQ8puD7W4N0fbo0
         GZgYufFw2reL6aHFEIgcswqFBPxpnA0ASY/xwiK6pfxAs0nV/75izTw5KxaxC8XBic6t
         F3rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784739635; x=1785344435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b6BLtSCxCp7M8WEIqu/WUMj2zfCCYaejhLZ7J9DExtM=;
        b=dG7JSt3fnE13iaRvAmoo9g4yjRs4OFmIAYoHp2m/DY1Qb9ajfooO0zJFa6rVXb+/S7
         92oQv0b25KU90cPvrxQ7gT/H//rFfG8Abgpren+PQzksQwX3wHM11GjhPoWoEyetaKBj
         P1LwiU7BVGzQUtVR7+lYai23ZfodmXNeBQdvI/IrRdeeMAIBLIdxRXvwfhynywh30pPP
         j/+AjrSg49qDTOs6Wrh4OLYauPaiZT/4f/q+55CuW6pNp+m2MPs5wJRQ1IHj5CHh4YNd
         YoBeWthpEV7B6R+oEwliHXWiOeaJyPfHg7XaoIZ0gH8C9XyVSWq9E9ZxCZBnSDZDQkWd
         Aufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739635; x=1785344435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6BLtSCxCp7M8WEIqu/WUMj2zfCCYaejhLZ7J9DExtM=;
        b=B+oCcwksVxhtd5Nwf2wrNOFLmoUedSYpG+HA5olLRofWLyzdF06pswC++S9dozBsr9
         8et4owcVMjkeXqphdBblnXJgCJNiTprXNKuUmVz22GoMAyiIqTPHj0icAeJWd7nSWUpE
         Dh8+1LGQ7osKOl6P/kzyt77klwJapRIIyO6TsJdi1z1m4R6Cj78Sw1sZQfqZuAgMAu0M
         oijLW589dTTea4HOHzYiHjtj+HHpL5Bfz/dfn3Q2jrubwhPkxkLhBoUhx0XFsSecU57R
         MhNxXhXLrMp4E6n7VmunFbRDp2NWkal9aK5snwcRSJhMNcJONwyVJXkvSQScvX+aAZ32
         7luA==
X-Forwarded-Encrypted: i=1; AHgh+RqbS05faBo03RU/aym0CPCDrP8QvkqwOklXtQOg/6FG8apKWCNn/tUAj+ppByWx0HM+u2ZDN3Pv7wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56AuYLfZxon48mDiiS4eRJOazrzjefDJyjm8a2BkTVW9VCGl4
	6GGMWHC7iRrijT6sgQGlcR43rEcEcD9d9qUiR1zTt04angEQmxdeqRWFGfFNDr31R8jO3T6RVXF
	wXutB+jYvR8wMTNs9Um1Jxc2rTjDZ6rB6L3Ls7d2T
X-Gm-Gg: AR+sD12xftT9fmc/B4Mpl+muflFDL9ddQSiTIaioFIbcmWbUjhPmuxxctSvxzeMzz+Q
	OztSES9Qck5Vz+BTMtR+bQozrrDrvAD6chEyRomUVucz51FHIoHmZ2Lt5gEgrwaETZpJ03xOrS/
	dKam2iT94HZ8MaESV8HYoo9pPAqhHr3gWSYLVXV9RRlmb/ovhhxrKSPc9wEkEy5ECZiUGO4IDyP
	o1FQRyqe6kzddSf4jAGgpjffV8bzIChFy/eJABdJ5jbmfbuUVLgdF5ms6XiCRbyKwL6eHWSC7I9
	Nzhv7NGKhtlWxjk=
X-Received: by 2002:a17:90b:1f88:b0:38d:f1a4:1116 with SMTP id
 98e67ed59e1d1-38e4b537bedmr20414674a91.33.1784739634476; Wed, 22 Jul 2026
 10:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4> <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <al_3nOssZoa6RoCq@google.com> <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
 <CALzav=fYx7R7c6FTQ5bC4bbQ+_KNaC3gopcPihOtKmHGaB6s1Q@mail.gmail.com> <amAExy1vqMbx31WU@plex>
In-Reply-To: <amAExy1vqMbx31WU@plex>
From: David Matlack <dmatlack@google.com>
Date: Wed, 22 Jul 2026 10:00:07 -0700
X-Gm-Features: AUfX_mw9U43t-da8vfCp9-yZYFJuwnLedP2gk2wgS7EP9CWA2swr-hVEqcna6rY
Message-ID: <CALzav=dHJ6g9FZmoWC5hFRCwCtf=BTHOmEFqbFFaDZiYDbRBvw@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, 
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

On Tue, Jul 21, 2026 at 4:46=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 07-21 16:18, David Matlack wrote:
> > On Tue, Jul 21, 2026 at 4:16=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Tue, Jul 21, 2026 at 4:02=E2=80=AFPM Samiullah Khawaja <skhawaja@g=
oogle.com> wrote:
> > > >
> > > > On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
> > > > >On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
> > > > ><pasha.tatashin@soleen.com> wrote:
> > > > >>
> > > > >> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@goog=
le.com> wrote:
> > > > >> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate=
.c
> > > > >> > index 03075ce06ac9..df6a02240aa4 100644
> > > > >> > --- a/drivers/pci/liveupdate.c
> > > > >> > +++ b/drivers/pci/liveupdate.c
> > > > >> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci=
_dev *dev)
> > > > >> > [ ... skip 76 lines ... ]
> > > > >> > +     /*
> > > > >> > +      * Hold the ref on the incoming FLB until pci_liveupdate=
_finish() so
> > > > >> > +      * that dev->liveupdate.incoming cannot get freed while =
the PCI core
> > > > >> > +      * has a pointer to it. It's better to leak the incoming=
 FLB than do a
> > > > >> > +      * use-after-free if driver does not call pci_liveupdate=
_finish().
> > > > >> > +      */
> > > > >>
> > > > >> I am confused by this. Each preserved PCI device must have an as=
sociated
> > > > >> FD preserved with it via LUO. I.e., vfiofd would need to be pres=
erved. If
> > > > >> the vfiofd was not reclaimed, and finish is not possible, that v=
fiofd
> > > > >> would still be owned by LUO, and therefore PCI FLB refcount woul=
d stay
> > > > >> positive.
> > > > >>
> > > > >> However, if finish is possible, and this is the last vfiofd that=
 is
> > > > >> finished, FLB will be freed as soon as the reference count reach=
es zero,
> > > > >> which I would think is the expected behavior.
> > > > >>
> > > > >> What is the point of holding a reference here, instead of only f=
or the
> > > > >> duration of FLB access, i.e. to make sure we are accessing a val=
id data?
> > > > >
> > > > >The duration of the access is from here until pci_liveupdate_finis=
h()
> > > > >because that it when the pointer (dev->liveupdate.incoming) is
> > > > >cleared. So that is why the PCI core holds the reference from here
> > > > >until pci_liveupdate_finish().
> > > >
> > > > I think LUO gives you guarantee that this pointer remains valid unt=
il
> > > > the FLB finish(), because all the vfiofd that were preserved have n=
ot
> > > > finished. And when all vfiofd have finished, LUO lets you know that=
 the
> > > > pointer is becoming invalid so you can unset these in the finish()
> > > > callback from LUO?
> > > >
> > > > If I understand this correctly, I think by keeping long references =
until
> > > > finish you are replicating the vfiofd bound lifecycle that LUO alre=
ady
> > > > gives you.
> > >
> > > Yes that's right. I am taking the approach of not trusting drivers
> > > (i.e. VFIO) and having the PCI core maintain it's own references so
> > > that FLB finish() is guaranteed to never be called while a device has
> > > device->liveupdate.incoming set.
> > >
> > > Alternatively, the PCI core could avoid taking a reference and instea=
d
> > > check for driver bugs in FLB finish(). I previously explored that
> > > approach and ran into a circular lock dependency between the FLB mute=
x
> > > and pci_liveupdate.rwsem. But I can look into that again, or just do =
a
> > > lockless walk of all PCI devices and panic if any still has
> > > dev->liveupdate.incoming set. It will only happen if the driver is
> > > completely broken so panicking seems fine.
> >
> > Pasha what do you think of this approach?
>
> I like it, let's do lockless sanity checking in flb finish callback, and
> avoid messing with references.

Great! I'll take this approach in v8.

> >
> > It avoids the PCI core taking a long reference (your conern) and also
> > avoids the PCI core needing to take lots of short references to access
> > dev->liveupdate.incoming (my concern). So seems like a good
> > compromise.
