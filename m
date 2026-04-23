Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BE3D7D9F
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776985773; cv=pass; b=YPzSPV6almp06npFguqw0pTbIAVesjJ2yJeuNME5jOxcaNpS1Ea6MDeFA4z8YGlo+BZjJD/lBGzVvMvj/ZTCK+cOnGCEhlcmVW9kK8hInpPmmrOf2cmfooWaWNHRat9EfvIKUHfTR76bgtnOTTB7M1TnYDpCcV5rfJIEOSyh0Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776985773; c=relaxed/simple;
	bh=VSDvtpQyodvkH89hy45oW/Z42kZp4O88fgmSS7BMvzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOHjsqje0uIIyg3ynMyJix+Rk8lnGSOtxPfJEyhirIo0tzgi3Zr+NmagMUeWWHHf2I2MpSw4UEYR/DLjpmeT/WyMOHrqFZ6TRgBvyyNPlg8SBJBWU4+z8DZQv/YRtttQKe7Ir338i0OZ5KUBDL7v2RyqB70eDqRlzBKrGgXCg5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqmA597z; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqmA597z"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e8292423fso63454581fa.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 16:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776985770; cv=none;
        d=google.com; s=arc-20240605;
        b=e/0kspVBuYa50oQlPFRgKEiPiiWSOs6QTQB6hCAI/sndPbls1V1XBJGpE4LFLRpQMl
         GBpBiArak6FRnZR35v9SoN4L1hl20ZRWHhRhZImF5mAeyP3aTPw1F11XjMS4QbV7PnFO
         vJoyhEelYbrF3GvwFpo0x6JFcuMzR5fhT+oebtF3Hb0FRDJlOGRPMIVyW8n2vd9dAKvZ
         lwBl45ppwf5Gxx8EUvgprfyzer+MAjhmtm1HnJKXLPcvp/fROPLony++OfeRo0gjnu0y
         MkiVFjBZYOOci9rgttj4ClBUu9VcXerOFzAGdm8vnOZc9sJlYxTDvGSzuHsVVoivCVcA
         r/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        fh=BZbvJ0t8vqyXp3VhFh7/tjl/cbEMmmDk8QQaLCP1dys=;
        b=lNQr6dAsVlCBKDxNBH9PO2Sn555ZzJeCZ+9azojz2mV7wBFzoTjNpqrnEYAkbwk0ic
         +0RJyJjHhj/cdBTN2UKXT2ZNfEGwquxkuqxjmUo57wDBxnpP4CM6L9QNSGLKOC1a+6DZ
         E2BZnd8CuMmrCZbGoya2SOxLE6MF36kkEzajaz0mdYEBDz1sxx6AL9D10YwQcaCmC7AW
         Rk1zn08g45SBeBDFF9iBtBJZfDEQxLmk22qzRrJsd6/DZVBzCpn+P5Bdb8hCEFyiohpi
         BDEre6hQZKQzcP41ip1Hs7hAkiWEjoEpfB4ECr27FMjcxtrJlzSYDXgNgYZnfdzCEpSv
         QHSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776985770; x=1777590570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        b=VqmA597zpWPLJykZ+qVtHxQMIF57cL7+JJDjRu7DOn15qon3vfMNKNm21wFO0ihqQr
         a+DYoC1AesbkgDijJF4s9J5H/xrQBR1u8s9yOO6g5YfrCK+lsegit/Hol6g9DMw8wQLV
         xYMJvMUP0JqsYvWAmnvV0ipZgELNNx/fs5E6rFOg3lekil5oKXntEvDynEcjnVaMPxDn
         3DQAatSeUa8bCmpNzqNw7dxfdAX1lNp5gbU8/rQ42J0ZuFEGsrpaNRx+R8J98e4x5Ahz
         xu+5ds4dWTs2kaboCtwWxxbgYL+QwxJ2FolBvn2of0RruQY0ktQ9nwwBlSO5a6dV9VOF
         b2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776985770; x=1777590570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        b=rgKeCO8Pp1wYZp/aezOnDVinMTMwz5D/8WDCfL1hb7XURuruJuDGDOgtM3lildNqSC
         GEx76G2K8cLEAWVmc06n6HEhWyC+SkN0Smp+3U9v1dAK01AQXKYreHXXXP+amIyanDeP
         vKab7yNdp7GSTsj6XIEncIrgy7DNGeobR+SGV74GZhhtMSd1d5Snjyruu5n0/kJWrnmy
         vIIIdJ7OzqMyZzokffiUxcyFvlhPPCNB++0xLILkl1xqKjS2hR1PuXFtVJAZQJ2vQdAu
         tnoCBpqRus0vXxJs4XfsIk9SvYG7ihczQ+8uO5WPEDiQ9oGhPrpELH3SBldJDODOaWuH
         OOwA==
X-Forwarded-Encrypted: i=1; AFNElJ/fLwHvh6qi3drbB0IgNrOzc7oqZc9aLzmiLBJ9q9qP2twug70128s3+GJ7M+UI5BuGux9SELKqrh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPbVjsuSeN7vYTV2EHWumIm7Bdi9f/vD0Kw9y7wj1ww8CP9UK
	0iz5KUx/0Vy4i7QKVmy/nB/ck7+2GslFxCAiD4j2J/uYdILSfTj7Stdwjgt82vsmSGjasoSKY2A
	j6V1t+ExX7GDVgnDGnm/wpUE+iqvOD24Z6CjPgJVG
X-Gm-Gg: AeBDietfHOkf6VmCAAHS3OtwumZHJeU5ZjdG/W+yg4YGAJCPRzMv2xkSBfLh7bv3sy2
	TgRtZbq3Ivx+sDnlARiejdVVqtMEds8Gj3ax+70RueXQLDCmIDA6echXiwMi0I8q+qtWEIgLuWF
	D0U8ut399WvVIGWDnVAIO1A5LM5MGWZXr2d/0H9R1nduFBfJqgvAGM3g92ESWvjGVHHt6lMUMSq
	O7YQ5oB/RQ+PzL4wQizj7b6HalAJ32zEFSPAbGpN0XQ8pBKuVnODcNItqL+SToe4YUOjcue3gO7
	20sjcWFkhCpK3eOati1FSIXbKO/AyA==
X-Received: by 2002:a05:651c:418e:b0:38a:965d:79ac with SMTP id
 38308e7fff4ca-38ec7845ffdmr82161421fa.12.1776985769266; Thu, 23 Apr 2026
 16:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-9-dmatlack@google.com>
 <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com> <20260423225253.GA3444440@nvidia.com>
In-Reply-To: <20260423225253.GA3444440@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 23 Apr 2026 16:09:01 -0700
X-Gm-Features: AQROBzCagtk2g3nQiz1XNHTS_Y7Vpcsrr0LE0644u_NVwvd3XuR0UjLC-oW_vCY
Message-ID: <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 3:53=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Apr 23, 2026 at 03:10:55PM -0700, David Matlack wrote:
> > On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > Restrict support for preserving PCI devices across Live Update to
> > > devices in immutable singleton IOMMU groups. A device's group is
> > > considered immutable if all bridges upstream from the device up to th=
e
> > > root port have the required ACS features enabled.
> > >
> > > Since ACS flags are inherited across a Live Update for preserved devi=
ces
> > > and all the way up to the root port, the preserved device should be i=
n a
> > > singleton IOMMU group after kexec in the new kernel.
> > >
> > > This change should still permit all the current use-cases for PCI dev=
ice
> > > preservation across Live Update, since it is intended to be used in
> > > Cloud enviroments which should have the required ACS features enabled
> > > for virtualization purposes.
> > >
> > > If a device is part of a multi-device IOMMU group, preserving it will
> > > now fail with an error. This restriction may be lifted in the future =
if
> > > support for preserving multi-device groups is desired.
> > >
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> >
> > Jason, do you think requiring singleton iommu groups is still
> > necessary/useful now that this series preserves ACS flags on preserved
> > devices and upstream bridges?
>
> I have forgotten why we introduced that? There are alot of funky
> things about iommu groups that might be important upon restoration..

You had originally suggested it in this thread:

  https://lore.kernel.org/kvm/20260301192236.GQ5933@nvidia.com/

> Like if you preserve one group member but not the other what do you ?

Yeah I imagine there could be some tricky cases there...

I wonder if PCI core is the right layer to enforce this. Maybe this
fits better into Sami's IOMMU core series since that is where all
those tricky cases will be (I imagine?).

> Even if you have ACS flags there are cases where groups are still
> aliasing DMA..

Hm, if a DMA alias can be created after boot time enumeration even
with the REQ_ACS_FLAGS check, then
pci_device_group_immutable_singleton() is not really immutable.



> Frankly, multi-device iommu groups don't even work fully last time we
> tried to use them in a VMM. So I think I would not expect them to ever
> intersect with live update. Blocking something tricky you can't test
> does seem like a reasonable thing.
