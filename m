Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D132AAA3
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527567; cv=none; b=LyunFQypaEXMkrRGd3CJtqyoUesXY7p+5uwLoxn8ahk7cA/kAR0YcUYHba29ceUD0jXpa7p+IypZUQBvGDoeDl9Kro7St7cenGQ+dngj2zQdLXpOPKUlYdBbCd7dPUpWFMUEPEazHUPJKY2ds43Q25ySsl5wEVo26NALp/0lzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527567; c=relaxed/simple;
	bh=WpxYNLWQuz8jDnzLobChOZaaqCsJT63vlCVRr86HY5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG8YO6dsJEcV8PDU/Vlxdx95YlKlTkUNZWXQz7sUZ1X2wybkSfH8psU4Bx0ke79aPJpz4gAJPVCGOucVK42WBpcnadR0XhfNv/UqiHQDBWKOdWwEvs2JHRMLAhEfBd+VPagIB6emr5JXgFzRpdu5bjr4HUMqZua1REy/2vyjdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdiYmpnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdiYmpnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0191F00ACA
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527565;
	bh=ESATx76s/Tvy+cKAQwvviNJs2YLUpoRJAZxnvj1hRew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VdiYmpnFS0fgKty2zKoaaid3i5lJMoASqQM9rA7LgpINt+0TJUk/DhIsgmuwypIBP
	 OFWfPL2cww/vnC93aElUwoccA7pPFUZQH93LYpamuTbhPgdi/Wc88B7Q1SFXn39u6F
	 Z/I1p0ySEPRht0N7wr3M9HPIHgKlSOEmXMM3G2nYJA1c58gAmRcfkmFwPYb9zA1654
	 daWGVQjdqytc1HI3xw66CiAwVNOJfh/Npm5PqFeoMF0klSf+pDx7RlJ4MB7W4IrrKY
	 nJmFSk3El2ls9wnNkdt5p4+yfdWuM7uMslH6bdGOdaSmTS4c+bDL5sI2eSA9oxmpVm
	 gplFw2q3iXBIQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so9283201fa.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:12:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz425ORRcR5GFQiXiOJuqS4VojOyllRJvrBJcAua2R9BOmSh581KFabAgwg2rafn/MPKcuqug3VSIk=@vger.kernel.org
X-Gm-Message-State: AFuF++kSsVI3K+Yiv+rFExUjRzwVa10/Kqsk3Vd45CcE4F5Edto+Sdz5
	HRFJBxqxk2hOJFsTb60BsudBwKFTB3oN8XaMNWza+KAu/p50QR6cOAHEUVd26jMWubmXATdzIJw
	ePr/DaKdGWH+H99aJjXEj22nrWHVi5x4=
X-Received: by 2002:a05:651c:a38c:20b0:3a3:33b8:f64d with SMTP id
 38308e7fff4ca-3a371bd455dmr5223581fa.14.1788527563534; Fri, 04 Sep 2026
 06:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
 <20260831205533.2325747-3-mario.limonciello@amd.com> <CAJZ5v0hgvyRrgVa2fiGMLmT0Uc7gygik8bdSoRhgS3fboQpi8g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hgvyRrgVa2fiGMLmT0Uc7gygik8bdSoRhgS3fboQpi8g@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:11:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g76N88Pe_QKLBGS0dg6r9rP84OXZ0UvQ9ifT_FGRBDcA@mail.gmail.com>
X-Gm-Features: AcwNN1XzxkN6Exzba6ALXcs2pEsiKht0aWH5cosTl94T-nuQZGTUnZ2Nv59tyjY
Message-ID: <CAJZ5v0g76N88Pe_QKLBGS0dg6r9rP84OXZ0UvQ9ifT_FGRBDcA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/PM: Run bridge power up actions as part of
 restore phase
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 3:09=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Mon, Aug 31, 2026 at 10:56=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > From: "Mario Limonciello (AMD)" <superm1@kernel.org>
> >
> > pci_pm_resume_noirq() calls pci_pm_bridge_power_up_actions() when a
> > bridge is coming back from D3cold and bus PM was not skipped, so that
> > the mandatory post-power-on link training delays are observed before
> > any downstream device is accessed.
> >
> > The last patch in this series makes the hibernate poweroff_noirq path
> > put bridges with downstream devices into D3 (including D3cold),
> > mirroring what the S3 suspend path already does.  For that to be safe,
> > the hibernate image restore path has to bring those bridges back up the
> > same way suspend resume does; otherwise a downstream device may be
> > accessed before its parent bridge's link is retrained.
>
> Note though that pci_pm_restore_noirq() runs after the boot kernel has
> initialized the PCI bus, so all of the links should be retrained by
> that time.
>
> It then carries out a "freeze" transition before passing control to

s/It then/The boot kernel/

> the image kernel, so "restore" doesn't really get devices in
> "pristine" states.
>
> Moreover, BIOS code runs before "poweroff_noirq" and the boot kernel

s/before/between/

> and it also messes up with devices in general.

Sent too early, sorry about that, but the question below is still relevant.

> Is there a specific issue that is avoided by this change?
>
> > Add the same bridge power up actions to pci_pm_restore_noirq(), gated o=
n
> > the same conditions as the resume path (bus PM not skipped and the
> > previous state being D3cold), so that hibernate restore and suspend
> > resume behave identically for bridges.
> >
> > Tested-by: Eric Naim <dnaim@cachyos.org>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > ---
> >  drivers/pci/pci-driver.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index e3d352c7b31d4..d15b3eb55ec53 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -1297,10 +1297,15 @@ static int pci_pm_restore_noirq(struct device *=
dev)
> >  {
> >         struct pci_dev *pci_dev =3D to_pci_dev(dev);
> >         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm :=
 NULL;
> > +       pci_power_t prev_state =3D pci_dev->current_state;
> > +       bool skip_bus_pm =3D pci_dev->skip_bus_pm;
> >
> >         pci_pm_default_resume_early(pci_dev);
> >         pci_fixup_device(pci_fixup_resume_early, pci_dev);
> >
> > +       if (!skip_bus_pm && prev_state =3D=3D PCI_D3cold)
> > +               pci_pm_bridge_power_up_actions(pci_dev);
> > +
> >         if (pci_has_legacy_pm_support(pci_dev))
> >                 return 0;
> >
> > --
> > 2.43.0
> >
