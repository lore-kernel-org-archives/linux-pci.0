Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FB2EC54C
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108354; cv=none; b=mTWa5xFcohBwfslkr89WGw2VMPD1hFDPS9aUuI5JDLxrCid6FGjqEZDrvm1RBs/LPVDAAEoZ9Zu6JSLajIcxk9RcwCNeCO3hWKZ7QHK69eyRUfE+UOhzSGEn2uxAkmYTsinOKbt48T5M3MKxUNodxKOhQSwTgOCPMzMXaXPNkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108354; c=relaxed/simple;
	bh=0eAMR4hEDjX1V4GZ+X7z6lupK89eIT+AhtwTmTlukKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJczz6+zJODxH+upn/YkJ0lHDZXDtnRB3DcwlSKjuHBK0TlvuNTmmtDaeIbk86bsQ6NQzmnNo/IItyvMcjHh5zX78r6P0t7JCvhTcl2TkDJAt7DAarwXc8/+3Tdb6gAYNPzhqwvUR4u7DTxWhYK2hUM4QSXI4u7/Ut008afHtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9YpP+nn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9YpP+nn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8E0C116D0
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108353;
	bh=0eAMR4hEDjX1V4GZ+X7z6lupK89eIT+AhtwTmTlukKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k9YpP+nncPBtkBxYjpTWuUxcfIHztGuwWpRPWGorj/Cp4hsVhbXESYSMzfX0pLdj7
	 8q/gdY1uaV4rm74WzeKI0rEvWfts9FpW4yvBTC2LRh0QdM2AivRoYXo6/0tGdVjUVU
	 oHpWx979v7/tTdJOmhBuvcVOwEEzDQB4uKornHArOz8Wu8vUccl8Y8mPhqvSCcy/i7
	 ZCdgn+64AzqTTzAzXPuHFZ+Zyonb7Edb17Xrd49nTYwZwf9IJriSSBT7hbE9RTz4HL
	 JyTmXJOgY1uxeBCbZpLj/r37cQRltknHw9BfvueI+n2LOtdZeDD8vx1TeiypzkhLDD
	 SRQ8DNol9u3nw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40427db1300so790527fac.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 10:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWk9Jyv31XqkNQI9R68XGPFUOI95qxKgSPSetbto+HEMWR5d8BWq1bjSITiIP6F6PQgja7DMX92pKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTF0X6FiVLefRx5QSddnJYd+zCn+pMeS4Xxfmph+ISpQD3Hvg
	SKGqJRD/soMoF3fjNY/Mack4PuT0NHCxc2CMIA6f6dAK2ELTeTDzwOobtxWgHkNsM0Q6NyJP5S/
	c8WTZPNthtKGRfdx70cTnmTKBR9PP/zQ=
X-Received: by 2002:a05:6871:4b12:b0:3cd:a995:6c6 with SMTP id
 586e51a60fabf-408ab514a62mr349248fac.13.1769108352450; Thu, 22 Jan 2026
 10:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0iBNOmMtqfqEbrYyuK2u+2J2+zZ-iQd1FvyCPjdvU2TJg@mail.gmail.com> <aXJsnh4HeiQ2oOBl@google.com>
In-Reply-To: <aXJsnh4HeiQ2oOBl@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 19:59:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJhPV-9CU34hrPk3+pTqLKpO5UusO8sdb56M8LwK8R-w@mail.gmail.com>
X-Gm-Features: AZwV_QgzOCg5J1_mvXCItc5mlZCe4UTn1E5ttGO9I42hHWH70BP42ZN6cQeUNTk
Message-ID: <CAJZ5v0iJhPV-9CU34hrPk3+pTqLKpO5UusO8sdb56M8LwK8R-w@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/PM: Prevent runtime suspend until devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 7:29=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Thu, Jan 22, 2026 at 07:17:21PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 6:49=E2=80=AFPM Brian Norris <briannorris@chrom=
ium.org> wrote:
> > >
> > > Previously, it was possible for a PCI device to be runtime-suspended =
before
> > > it was fully initialized. When that happened, the suspend process cou=
ld
> > > save invalid device state, for example, before BAR assignment. Restor=
ing
> > > the invalid state during resume may leave the device non-functional.
> > >
> > > Prevent runtime suspend for PCI devices until they are fully initiali=
zed by
> > > deferring pm_runtime_enable().
> > >
> > > More details on how exactly this may occur:
> > >
> > >   1. PCI device is created by pci_scan_slot() or similar
> > >
> > >   2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 =
and
> > >      prevents runtime suspend prevented via pm_runtime_forbid()
> > >
> > >   3. pci_device_add() adds the underlying 'struct device' via device_=
add(),
> > >      which means user space can allow runtime suspend, e.g.,
> > >
> > >        echo auto > /sys/bus/pci/devices/.../power/control
> > >
> > >   4. PCI device receives BAR configuration
> > >      (pci_assign_unassigned_bus_resources(), etc.)
> > >
> > >   5. pci_bus_add_device() applies final fixups, saves device state, a=
nd
> > >      tries to attach a driver
> > >
> > > The device may potentially be suspended between #3 and #5, so this is=
 racy
> > > with user space (udev or similar).
> > >
> > > Many PCI devices are enumerated at subsys_initcall time and so will n=
ot
> > > race with user space, but devices created later by hotplug or modular
> > > pwrctrl or host controller drivers are susceptible to this race.
> > >
> > > More runtime PM details at the first Link: below.
> > >
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: stable@vger.kernel.org
> > > Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661=
883bd2b4ef475155c7aa72b@changeid/
> > > Link: https://lore.kernel.org/all/0e35a4e1-894a-47c1-9528-fc5ffbafd9e=
2@samsung.com/
> > >
> > > Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661=
883bd2b4ef475155c7aa72b@changeid/
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > >
> > > Changes in v5:
> > >  * Put pm_runtime_set_active() back where it was, to ensure our paren=
t
> > >    can't suspend before we're really ready. (See bug report in 2nd
> > >    "Link:")
> > >  * Add comments
> > >  * Update commit description with Bjorn's rewrite
> > >  * Add Marek's Tested-by
> > >
> > > Changes in v4:
> > >  * Move pm_runtime_set_active() too
> > >
> > > Changes in v3:
> > >  * Add Link to initial discussion
> > >  * Add Rafael's Reviewed-by
> > >  * Add lengthier footnotes about forbid vs allow vs sysfs
> > >
> > > Changes in v2:
> > >  * Update CC list
> > >  * Rework problem description
> > >  * Update solution: defer pm_runtime_enable(), instead of trying to
> > >    get()/put()
> > >
> > >  drivers/pci/bus.c | 7 +++++++
> > >  drivers/pci/pci.c | 5 ++++-
> > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index 4383a36fd6ca..90954f81962b 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/of_platform.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/proc_fs.h>
> > >  #include <linux/slab.h>
> > >
> > > @@ -379,6 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >                 put_device(&pdev->dev);
> > >         }
> > >
> > > +       /*
> > > +        * Enable runtime PM (and potentially suspend) only after we'=
ve fully
> > > +        * configured the PCI state.
> > > +        */
> >
> > I would make it a bit more precise, something like "Enable runtime PM,
> > which potentially allows the device to suspend immediately, only after
> > the PCI state has been configured completely."
> >
> > Also, it is not particularly what "we" means in kernel code comments,
> > so I generally avoid phrasing them this way.
>
> Well, you may disagree with plenty of other people :)
>
> $ git grep -ioh '\<we\>' ./drivers/pci | wc -w
> 943

I did that too in the past, but I find it confusing in some cases.

> Your suggestion also means using passive voice, which I sometimes
> attempt to avoid.

I'm not sure why exactly.

> But otherwise, looks fine to me.
>
> > > +       pm_runtime_enable(&dev->dev);
> > > +
> > >         if (!dn || of_device_is_available(dn))
> > >                 pci_dev_allow_binding(dev);
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 13dbb405dc31..07b0d029aa51 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3196,8 +3196,11 @@ void pci_pm_init(struct pci_dev *dev)
> > >  poweron:
> > >         pci_pm_power_up_and_verify_state(dev);
> > >         pm_runtime_forbid(&dev->dev);
> > > +       /*
> > > +        * Mark ourselves active now, to prevent our parent from susp=
ending
> > > +        * while we finish configuring the PCI device.
> > > +        */
> >
> > I would rephrase the comment this way:
> >
> > "Runtime PM will be enabled for the device when it has been fully
> > configured, but since its parent and suppliers may suspend in the
> > meantime, prevent them from doing so by changing the device's runtime
> > PM status to "active"."
>
> Sure. That's going on the more verbose end, like I suggested a bit ago.
> I'm fine with more verbose, if it helps people.
>
> I see Bjorn already applied this, so it seems he's happy enough. He also
> spent a lot of time on making earlier writing less verbose, so I'll
> defer to his opinions. I can spin a v6, or Bjorn can squash in his own
> update, or he can choose to leave it as-is.

I saw that it was applied and no big deal as far as I'm concerned.
