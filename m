Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9874384CE2
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121873; cv=none; b=N0mp7LZMNjIzOcYbvYsp5SSWnPFw7iE9x5cYYni/yLygXSMMWTl9QIfW5HYvku5UAg1kakqM/B0JvfisFQMMOyZMsLAWXje7cEO157pA18dSz5yU9SVfgOglaPjATU+INYCpRamtXcwns4bxXpyUOpSs/ZBh2ls6fmsznSU0r+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121873; c=relaxed/simple;
	bh=CQV/3/wnLgXrS+Hbzk0yPlUDeuZQjMiLX60w2A/e4AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4yEpOe2c8/8pXCZd1NG/sf5On1P4orhxptkRqxzqd5RWGweFeKe/XIzXWzjm3GcjMXEAU/VbPoOfqwogPrQq8ITHD2kuBb/zonzcRQsnhOgBMZAlZ+toBx+LB2aYBqDGDP3lc1ZxZjmGS2agsN0pwZBzIOcialIP4r1lTLy/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0Wc78qX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0Wc78qX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE791F00893
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121867;
	bh=XjTq1oOP/feqMLNEtr+6lW6g9yxstuMtmIXdvnkxczI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Z0Wc78qXdLXfJL6PQD8BM0rMZc/hzCusrGaa9hDB7ASZbnEgYs4zAdBvCT+3OPV8k
	 OOHBv4us40TsodyYMryReA4dnLjxIO4sghmWeW5kslVHCsEwfD1EP0OxoD+ToX/MLm
	 O4KdkDBkMb5weKSvm1tjHUJOeLs3IOTOtUngYCzugKRgsjWI4PwESk3YUexEKQtgBf
	 dFnWrAewSFfGJBPjbBEO+aVrrqz6Hb5GerjmxSQnrYUNatF/mrh2SPNybD6TpOj4Ix
	 qMDhVy5WAhUgSOxBREeMNDh8+W3NatDL2OIS/sPQZ50hXjWMgu2xwNC3x8rw1/IF4n
	 L1E7jjB/bvUoA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso209332e87.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 13:04:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9aTZGQazrnPmLG3VHKlqHpThN6niH7Ut4+crlIL4xBpR2BygmInKjYwP+TjJhF3OZUn6UQ4GLrOMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9R27I1pr0GephxKrIC4dD93q/WB8MgCzITFlCkcXCryuGZlZn
	6cKaipt3YUS8yfdTJ9SMo91Awmy5jpSF3Pc5JamfkCNLbL1qPplmh/1Y4F8PapszZ4icmEnzw+q
	BPPUU8BwXJvS66fezQZdRfrHjWdCl8o0=
X-Received: by 2002:a05:6512:10cd:b0:5aa:5edf:3311 with SMTP id
 2adb3069b0e04-5ad275bb099mr35944e87.12.1781121865663; Wed, 10 Jun 2026
 13:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603112018.97AA41F00893@smtp.kernel.org> <20260610191929.GA196607@bhelgaas>
In-Reply-To: <20260610191929.GA196607@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jun 2026 22:04:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwK2tFfiP5fyOEupC8rLgCC-BwKy8qEuj5w6mphfZMhQ@mail.gmail.com>
X-Gm-Features: AVVi8CeslDPHAJCcJ5ZxiEJCYgQpdYUc4G9YUkttFdyGtkUUjlKPeyI-vQtxsSk
Message-ID: <CAJZ5v0jwK2tFfiP5fyOEupC8rLgCC-BwKy8qEuj5w6mphfZMhQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PCI: Add d3cold as general reset method
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, 
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, linux-pci@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Rafael, D3cold->D0 delays]
>
> On Wed, Jun 03, 2026 at 11:20:18AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [High] pci_d3cold_reset() fails to wait for device readiness after tr=
ansitioning from D3cold to D0, leading to immediate config read failures an=
d state corruption.
> > - [High] pci_d3cold_reset() does not prevent execution on single-functi=
on bridges, leading to permanent state corruption and physical data loss of=
 all subordinate devices.
> > --
> >
> > commit c7a8523521475c131fd83bc43a00b0cc028fc9a1
> > Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> >
> > PCI: Add d3cold as general reset method
> >
> > This patch adds D3cold power cycling as a reset method for single-funct=
ion
> > devices via ACPI _PR3, placing it at the end of the reset hierarchy.
> >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8f7cfcc000901..096868f80cd4c 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> >
> > [ ... ]
> >
> > > +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> > > +{
> > > +   int ret;
> > > +
> > > +   if (dev->multifunction)
> > > +           return -ENOTTY;
> > > +
> >
> > [Severity: High]
> > Does this allow execution on single-function bridges, such as PCIe Root
> > Ports?
> >
> > If pci_set_power_state(dev, PCI_D3cold) is called on a bridge, it recur=
sively
> > updates all subordinate devices' tracking state to D3cold via
> > __pci_bus_set_current_state() and physically removes power from them.
> >
> > The subsequent transition back to D0 only updates the bridge itself. Th=
is
> > leaves all downstream devices tracked as PCI_D3cold indefinitely, and t=
hey
> > lose all their configuration and BARs since the reset framework only sa=
ves
> > and restores the bridge's configuration state.
>
> Secondary Bus Reset has a similar issue: the hot reset on the
> secondary side is propagated to downstream devices.
> pci_parent_bus_reset() returns -ENOTTY if we try to use SBR to reset a
> bridge.  I wonder if that check should be moved up to
> pci_reset_bus_function() we don't try to use pci_reset_hotplug_slot()
> on bridges either.
>
> So I think it *is* a problem if we put a bridge in D3cold because
> that's also a reset of any downstream devices.

It would also be quite confusing for the drivers of the downstream
devices, especially if they support runtime PM and use the reference
counting thereof to ensure no power loss.

It looks like such a reset would require unbinding all of the drivers
from the devices below the bridge.

> > > +   if (!pci_pr3_present(dev))
> > > +           return -ENOTTY;
> > > +
> > > +   if (probe)
> > > +           return 0;
> > > +
> > > +   if (dev->current_state !=3D PCI_D0)
> > > +           return -EINVAL;
> > > +
> > > +   ret =3D pci_dev_reset_iommu_prepare(dev);
> > > +   if (ret) {
> > > +           pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n"=
, ret);
> > > +           return ret;
> > > +   }
> > > +
> > > +   ret =3D pci_set_power_state(dev, PCI_D3cold);
> > > +   if (ret)
> > > +           goto done;
> > > +
> > > +   ret =3D pci_set_power_state(dev, PCI_D0);
> >
> > [Severity: High]
> > Does this sequence fail to account for the mandatory wait time before t=
he
> > device is responsive to config space accesses?
> >
> > A D3cold to D0 transition acts as a fundamental reset. pci_set_power_st=
ate()
> > internally invokes pci_power_up(), which applies power and immediately
> > attempts to read PCI_PM_CTRL without waiting for link training or handl=
ing
> > Configuration Request Retry Status (CRS).
>
> I don't think sashiko can infer this from the code, but my
> understanding is that platform_pci_set_power_state(PCI_D0) is
> responsible for delays after a D3cold -> D0 transition, so I don't
> think this one is actually an issue:
>
>   https://lore.kernel.org/all/CAJZ5v0iZN5NtUztqe=3DMxCRcXdBaaqzZ749OqSUka=
dwwBy0ugUQ@mail.gmail.com/

Right.

> > Because the device is unready, this read can return 0xFFFF (Unsupported
> > Request) and cause pci_power_up() to spuriously fail with -EIO. Should =
this
> > include a polling delay, similar to pci_dev_wait(), to prevent the rese=
t
> > framework from blindly failing or restoring state to an uninitialized d=
evice?
> >
> > > +
> > > +done:
> > > +   pci_dev_reset_iommu_done(dev);
> > > +   return ret;
> > > +}
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603105853.=
326290-1-jtornosm@redhat.com?part=3D1
