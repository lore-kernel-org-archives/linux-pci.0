Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B74582C4
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675835; cv=pass; b=UYBRQn2cVlLabN6tXOjFo3gLmSElfq/9h3lfMOs8P+zsRd6fknIbGKhPmR3SsGxdWZ7+JmB92cFUese79XUxA7/MHWpEMelZG07iZAHLPDqbyIWcvQUVZMxLkg6i74Kyc1vEqSGJc1MdFjD+FwErLEbhDHWKvvTK5u9KsmkyvtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675835; c=relaxed/simple;
	bh=ixJiEIB3IFCdgmVozwXQ5lsPDefOeoRv/OC6Bg1emsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFhjudB0f8WhMHMJ0Relhfk9D8W12iBnsmcC9eY7cSs4sPbwRmr/BSu89M+N5NwYDVOTs/9OlNHivIAOBsgPLIH6bSy8yMgH/vA2tUsna0yKtHI4f117kBM/Cz4oWYOPssJ8p/7Eb12Zpfu4V7QYPFghP9CDyso3oCi6lZNj6HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYHqs2Vj; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYHqs2Vj"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so9010155a12.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 16:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784675832; cv=none;
        d=google.com; s=arc-20260327;
        b=qwVCWLOMTWS9GYxxA5bX52Fx3eOSlILfJhvXumOcUlav5DamkrFqDg1MryjapgRyAC
         M29OeqCpUGwujHN9QvCB6r76F5ywRB3bT5CnKGiC5BvjnmeqNwxN12mcDLa0HsE2ZVlt
         GkqyicAnppvvgLKlDqrx54CsWmIMgXpa0j4vj2a4nUnkJ1fHati3tFZYOTVoAWH2a2Uv
         EptkB5NHXPyzfQ1sKIU2srjU9MqN3w50uwonVthHgMPwGKLrIxq+81tnD6qTww/onT9I
         n8iPK0nqml+uziqynU7i6AZww9TA0aPR7FFeG5iUWPzukTZ99QD/IgFLt6Po1hdKljeS
         b90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZ7qRUkeVcw09Vx52wAPeyyp7zrSxjZkAHO4XaqMzD4=;
        fh=2RQvfdxeSEoEcrbk8tHQ3WoE0XMg2+ytgq76zWnqp4o=;
        b=GdxTIjg64k1zQK2GENkZKcq7VdIrFAigXMdNVm8PO25a4jWVpk9E5beggEQKVvJzc7
         EYdEJmvbkDyOj1IElsDO0mfcM5ZwIRRACSyT+oP9F2OOGHWo5Vjp4I3zYZBM4PAtNOtY
         dY1ZfhSOCZDTMUv+PnWr0shjsadrnwKAwNLuOUmT+h7PE1pyci59ZA8MmMmkAdSkly32
         33kuF8QWF0x3YlHAd/f2vSszgbdXhQt9ndsODmSOIsp0uscx7ZnIxcawHBVq6nmqedgS
         wSn10CPjxvrpZx7728qD8aVWXuVrqDrs4OaduENkt1onvaGy37Qk17CFC5N3y18djavx
         CoeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675832; x=1785280632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XZ7qRUkeVcw09Vx52wAPeyyp7zrSxjZkAHO4XaqMzD4=;
        b=tYHqs2VjcpDzUVPn3ZYnf9NvsMr45MZoprS6JSOUBCtUxTvWOu42atJVl/cqH5knRl
         ZLMwHTYoJPc46Pb3FuZxvyG57aLmB9Sr6tCSzlCe8p/xJR2BXgfsCQhU5WNlwSJegFzc
         fWaIMLEzDkPSoJRhq4WRmZ8x6b+ObRMUd69bids2GmHDB4DEZOaFEwJbPutY5PAD+XJ1
         BMNjOyb6scfc9pVy/9kE4B+3dro4S+MWaugAyUSNq1hSCG0/Hy6jur7XTYi/4ZGw/taY
         xcQs00LVabzjB/B/g09vI6kMSj61tmVQUx+lLJE1tdCqvbtbhGC83SWAgzVEtJXVsnW7
         NjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675832; x=1785280632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZ7qRUkeVcw09Vx52wAPeyyp7zrSxjZkAHO4XaqMzD4=;
        b=SkZwtgynJuWE8+O3NKEqI0KomUE8rvImQQ5o6Ih3QDSboN3Wh7kX4AtmcIt7gDlTwz
         cMDSrNkZ0HTrnBPgHnlRldvfHrk4xBaWy1QTJszMXRGNuDWBfbSypKtdxGL1lxdDcXY1
         K/9DSKOjhaPFMzw99kZsiulU1J3KhQPhZD3SzVNUmlJ0bPCGJo5Dkjux/ow8RgSHJFGu
         7eDVXIFzM2LrhD2YZNnycZZaDuCFmZRb12retyF3RESRaIkxV0yupj0wWifcDQ8t2iDi
         SGcBvtewVgK6lJyopbTfxT+I8pkXxdah2si1lyH+lzYFPLqdlrgZbzLFyCHvuvXkeKp8
         4eKA==
X-Forwarded-Encrypted: i=1; AHgh+RoBMrU2m6wudgI12hfFl49aV5/tuGiLRoAM0LYj/tRF7LvLG7BuTwHlI2JqYjDGmICTCzgrjpZXLwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBP2Pa/KmSciKkHDoVRfz1ObIX/CmCA4C3OUaCGiJEj0HnTWP4
	Vc6thQ+znOjpivvJJCnFGCSYKImkTUOVY6F7lNbU9nk87WGd2KSkvVIGbE9lpgrPAh5d5WYzsOU
	w1LS6IoE9cN2GzaEE+6Py4KD2HzFGgmxc8oq68uoX
X-Gm-Gg: AR+sD11M/tHZt6B/iGojH1Ejy55BYQucYSJcL82syqcYuRU3oaK58eg1H9Zezlt/X7k
	xtvPxfU9z638OXBkkZfSt2PyCubMAUCu+vhmzXJgmScRe0QA9cd4+nvKeixtsOSkSszgf9kp6gf
	RykHk/g4GFBh5KaikSIx5c5SvwlKadIIIp7xZ1APtp/L05h3fT3vacN6xN4YAsdCug8KKCigNjm
	6ADotKE4Xq/+kT+z9NLPK9hXIv2/T/QdALcQcU2tAansFWRrKD4M5i8R9lk6w==
X-Received: by 2002:a05:6a20:1446:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3c3ad8537d2mr21934058637.33.1784675831570; Tue, 21 Jul 2026
 16:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4> <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <al_3nOssZoa6RoCq@google.com>
In-Reply-To: <al_3nOssZoa6RoCq@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Jul 2026 16:16:44 -0700
X-Gm-Features: AUfX_mxmcKg9wEWL8G2cbUIPdoOXypA3DIQHnJ26Qr2Bjm3tZvSdzwlvs3nabeo
Message-ID: <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
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

On Tue, Jul 21, 2026 at 4:02=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
> >On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
> ><pasha.tatashin@soleen.com> wrote:
> >>
> >> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com=
> wrote:
> >> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> >> > index 03075ce06ac9..df6a02240aa4 100644
> >> > --- a/drivers/pci/liveupdate.c
> >> > +++ b/drivers/pci/liveupdate.c
> >> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *=
dev)
> >> > [ ... skip 76 lines ... ]
> >> > +     /*
> >> > +      * Hold the ref on the incoming FLB until pci_liveupdate_finis=
h() so
> >> > +      * that dev->liveupdate.incoming cannot get freed while the PC=
I core
> >> > +      * has a pointer to it. It's better to leak the incoming FLB t=
han do a
> >> > +      * use-after-free if driver does not call pci_liveupdate_finis=
h().
> >> > +      */
> >>
> >> I am confused by this. Each preserved PCI device must have an associat=
ed
> >> FD preserved with it via LUO. I.e., vfiofd would need to be preserved.=
 If
> >> the vfiofd was not reclaimed, and finish is not possible, that vfiofd
> >> would still be owned by LUO, and therefore PCI FLB refcount would stay
> >> positive.
> >>
> >> However, if finish is possible, and this is the last vfiofd that is
> >> finished, FLB will be freed as soon as the reference count reaches zer=
o,
> >> which I would think is the expected behavior.
> >>
> >> What is the point of holding a reference here, instead of only for the
> >> duration of FLB access, i.e. to make sure we are accessing a valid dat=
a?
> >
> >The duration of the access is from here until pci_liveupdate_finish()
> >because that it when the pointer (dev->liveupdate.incoming) is
> >cleared. So that is why the PCI core holds the reference from here
> >until pci_liveupdate_finish().
>
> I think LUO gives you guarantee that this pointer remains valid until
> the FLB finish(), because all the vfiofd that were preserved have not
> finished. And when all vfiofd have finished, LUO lets you know that the
> pointer is becoming invalid so you can unset these in the finish()
> callback from LUO?
>
> If I understand this correctly, I think by keeping long references until
> finish you are replicating the vfiofd bound lifecycle that LUO already
> gives you.

Yes that's right. I am taking the approach of not trusting drivers
(i.e. VFIO) and having the PCI core maintain it's own references so
that FLB finish() is guaranteed to never be called while a device has
device->liveupdate.incoming set.

Alternatively, the PCI core could avoid taking a reference and instead
check for driver bugs in FLB finish(). I previously explored that
approach and ran into a circular lock dependency between the FLB mutex
and pci_liveupdate.rwsem. But I can look into that again, or just do a
lockless walk of all PCI devices and panic if any still has
dev->liveupdate.incoming set. It will only happen if the driver is
completely broken so panicking seems fine.
