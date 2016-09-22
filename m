Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tomasz Nowicki
	<tn@semihalf.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Will Deacon
	<will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael
 Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>,
        Sinan Kaya
	<okaya@codeaurora.org>,
        Jayachandran C <jchandra@broadcom.com>,
        "Christopher
 Covington" <cov@codeaurora.org>,
        Duc Dang <dhdang@apm.com>,
        Robert Richter
	<robert.richter@caviumnetworks.com>,
        Marcin Wojtas <mw@semihalf.com>, "Liviu
 Dudau" <Liviu.Dudau@arm.com>,
        Wangyijing <wangyijing@huawei.com>, Mark Salter
	<msalter@redhat.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Linaro ACPI Mailman List
	<linaro-acpi@lists.linaro.org>,
        Jon Masters <jcm@redhat.com>, Andrea Gallo
	<andrea.gallo@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Jeff Hugo
	<jhugo@codeaurora.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
Date: Thu, 22 Sep 2016 11:12:09 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8815C8@lhreml507-mbx>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-4-git-send-email-tn@semihalf.com>
 <20160919180900.GB13775@localhost>
 <49f53bfc-4421-a8b0-694c-bce7e61e1c9e@semihalf.com>
 <20160920133327.GB13855@localhost>
 <CAKv+Gu-AE7fft_j2cqBCN=xrsf5Yh=mePf5x3dZJuKAmdxF-Gg@mail.gmail.com>
 <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F87CF8F@lhreml507-mbx>
 <20160921185920.GC20006@localhost>
In-Reply-To: <20160921185920.GC20006@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 21 September 2016 19:59
> To: Gabriele Paoloni
> Cc: Ard Biesheuvel; Tomasz Nowicki; David Daney; Will Deacon; Catalin
> Marinas; Rafael Wysocki; Lorenzo Pieralisi; Arnd Bergmann; Hanjun Guo;
> Sinan Kaya; Jayachandran C; Christopher Covington; Duc Dang; Robert
> Richter; Marcin Wojtas; Liviu Dudau; Wangyijing; Mark Salter; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Linaro ACPI
> Mailman List; Jon Masters; Andrea Gallo; Jeremy Linton; liudongdong
> (C); Jeff Hugo; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Rafael J. Wysocki
> Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-
> specific register range for ACPI case
>=20
> On Wed, Sep 21, 2016 at 02:10:55PM +0000, Gabriele Paoloni wrote:
> > Hi Bjorn
> >
> > [...]
> >
> >
> > >
> > > If future hardware is completely ECAM-compliant and we don't need
> any
> > > more MCFG quirks, that would be great.
> > >
> > > But we'll still need to describe that memory-mapped config space
> > > somewhere.  If that's done with PNP0C02 or similar devices (as is
> done
> > > on my x86 laptop), we'd be all set.
> > >
> > > If we need to work around firmware in the field that doesn't do
> that,
> > > one possibility is a PNP quirk along the lines of
> > > quirk_amd_mmconfig_area().
> >
> > So, if my understanding is correct, for platforms that have not been
> > shipped yet you propose to use PNP0C02 in the ACPI table in order to
> > declare a motherboard reserved resource whereas for shipped platforms
> > you propose to have a quirk along pnp_fixups in order to track the
> > resource usage even if values are hardcoded...correct?
>=20
> Yes.  I'm open to alternate proposals, but x86 uses PNP0C02, and
> following existing practice seems reasonable.
>=20
> > Before Tomasz came up with this patchset we had a call between the
> vendors
> > involved in this PCI quirks saga and other guys from Linaro and ARM.
> >
> > Lorenzo summarized the outcome as in the following link
> > http://lkml.iu.edu/hypermail/linux/kernel/1606.2/03344.html
> >
> > Since this quirks mechanism has been discussed for quite a long time
> now
> > IMHO it would be good to have a last call including also you (Bjorn)
> so
> > that we can all agree on what to do and we avoid changing our drivers
> again
> > and again...
>=20
> I think we're converging pretty fast.  As far as I'm concerned, the
> v6 ECAM quirks implementation is perfect.  The only remaining issue is
> reporting the ECAM resources, and I haven't seen objections to using
> PNP0C02 + PNP quirks for broken firmware.
>=20
> There is the question of how or whether to associate a PNP0A03 PCI
> bridge with resources from a different PNP0C02 device, but that's not
> super important.  If the hard-coded resources appear both in a quirk
> and in the PCI bridge driver, it's ugly but not the end of the world.
> We've still achieved the objective of avoiding landmines in the
> address space.

Ok got it many thanks

Gab

>=20
> Bjorn
