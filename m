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
Subject: RE: [PATCH v10 2/9] PCI: remove unused __weak attribute in
 pci_register_io_range()
Date: Tue, 7 Nov 2017 10:50:35 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC3351@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-3-git-send-email-gabriele.paoloni@huawei.com>
 <20171107002325.GC9538@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171107002325.GC9538@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 07 November 2017 00:23
> To: Gabriele Paoloni
> Cc: catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; rafael@kernel.org;
> arnd@arndb.de; linux-arm-kernel@lists.infradead.org;
> lorenzo.pieralisi@arm.com; mark.rutland@arm.com; brian.starkey@arm.com;
> olof@lixom.net; benh@kernel.crashing.org; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; Linuxarm; linux-pci@vger.kernel.org;
> minyard@acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v10 2/9] PCI: remove unused __weak attribute in
> pci_register_io_range()
>=20
> > PCI: remove unused __weak attribute in pci_register_io_range()
>=20
> Please capitalize to follow drivers/pci convention, e.g.,
>=20
>   PCI: Remove __weak attribute from pci_register_io_range()
>=20
> (Also do the same for the other PCI patches.)

Agreed, many thanks

Gab

>=20
> On Fri, Oct 27, 2017 at 05:11:20PM +0100, Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > Currently pci_register_io_range() has only one definition;
> > therefore there is no use of the __weak attribute.
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> > ---
> >  drivers/pci/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index af0cc34..eee967c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3270,7 +3270,7 @@ static DEFINE_SPINLOCK(io_range_lock);
> >   * Record the PCI IO range (expressed as CPU physical address +
> size).
> >   * Return a negative value if an error has occured, zero otherwise
> >   */
> > -int __weak pci_register_io_range(phys_addr_t addr, resource_size_t
> size)
> > +int pci_register_io_range(phys_addr_t addr, resource_size_t size)
> >  {
> >  	int err =3D 0;
> >
> > --
> > 2.7.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
