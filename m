Return-Path: <SRS0=PMJS=CF=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=PMJS=CF=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com"
	<will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "olof@lixom.net"
	<olof@lixom.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm
	<linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        John Garry
	<john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH v10 9/9] MANTAINERS: Add maintainer for HiSilicon LPC
 driver
Date: Tue, 7 Nov 2017 10:49:12 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC3305@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-10-git-send-email-gabriele.paoloni@huawei.com>
 <20171107002120.GB9538@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171107002120.GB9538@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many Thanks for reviewing

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 07 November 2017 00:21
> To: Gabriele Paoloni
> Cc: catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; rafael@kernel.org;
> arnd@arndb.de; linux-arm-kernel@lists.infradead.org;
> lorenzo.pieralisi@arm.com; mark.rutland@arm.com; brian.starkey@arm.com;
> olof@lixom.net; benh@kernel.crashing.org; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; Linuxarm; linux-pci@vger.kernel.org;
> minyard@acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v10 9/9] MANTAINERS: Add maintainer for HiSilicon
> LPC driver
>=20
> s/MANTAINERS/MAINTAINERS/

Oops thanks

>=20
> On Fri, Oct 27, 2017 at 05:11:27PM +0100, Gabriele Paoloni wrote:
> > Added maintainer for drivers/bus/hisi_lpc.c
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f66488d..b49d4c0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6130,6 +6130,13 @@ F:	include/uapi/linux/if_hippi.h
> >  F:	net/802/hippi.c
> >  F:	drivers/net/hippi/
> >
> > +HISILICON LPC BUS DRIVER
> > +L:	linuxarm@huawei.com
> > +W:	http://www.hisilicon.com
> > +S:	Maintained
> > +F:	drivers/bus/hisi_lpc.c
> > +F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-
> pin-count.txt
>=20
> Does this really count as a "maintainer" since it's only a mailing
> list, not a real person?  I personally prefer a specific person
> because there's no accountability with a mailing list.

Right; before the maintainer was meant to be me but as I am moving
to a different role we decided to put down a mailing list.
However after discussing internally we agreed to have a person as
maintainer and we'll specify him in the next patchset.

Cheers
Gab

>=20
> > +
> >  HISILICON NETWORK SUBSYSTEM DRIVER
> >  M:	Yisen Zhuang <yisen.zhuang@huawei.com>
> >  M:	Salil Mehta <salil.mehta@huawei.com>
> > --
> > 2.7.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
