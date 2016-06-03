Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Christopher Covington <cov@codeaurora.org>,
        Tomasz Nowicki
	<tn@semihalf.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "arnd@arndb.de"
	<arnd@arndb.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jchandra@broadcom.com"
	<jchandra@broadcom.com>
CC: "jcm@redhat.com" <jcm@redhat.com>,
        "linaro-acpi@lists.linaro.org"
	<linaro-acpi@lists.linaro.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com"
	<ddaney@caviumnetworks.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        Wangyijing
	<wangyijing@huawei.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "liudongdong (C)"
	<liudongdong3@huawei.com>
Subject: RE: [RFC PATCH 1/3] pci, acpi: Match PCI config space accessors
 against platfrom specific ECAM quirks.
Date: Fri, 3 Jun 2016 15:32:32 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F76E9D7@lhreml507-mbx>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
 <1464856864-18049-2-git-send-email-tn@semihalf.com>
 <57519F09.2010201@codeaurora.org>
In-Reply-To: <57519F09.2010201@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Cov

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Christopher Covington
> Sent: 03 June 2016 16:15
> To: Tomasz Nowicki; helgaas@kernel.org; arnd@arndb.de;
> will.deacon@arm.com; catalin.marinas@arm.com; rafael@kernel.org;
> hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
> jchandra@broadcom.com
> Cc: jcm@redhat.com; linaro-acpi@lists.linaro.org; linux-
> pci@vger.kernel.org; dhdang@apm.com; Liviu.Dudau@arm.com;
> ddaney@caviumnetworks.com; jeremy.linton@arm.com; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> robert.richter@caviumnetworks.com; Suravee.Suthikulpanit@amd.com;
> msalter@redhat.com; Wangyijing; mw@semihalf.com;
> andrea.gallo@linaro.org; linux-arm-kernel@lists.infradead.org;
> liudongdong (C); Gabriele Paoloni
> Subject: Re: [RFC PATCH 1/3] pci, acpi: Match PCI config space
> accessors against platfrom specific ECAM quirks.
>=20
> Hi Tomasz,
>=20
> Thanks for your work on this.
>=20
> On 06/02/2016 04:41 AM, Tomasz Nowicki wrote:
> > Some platforms may not be fully compliant with generic set of PCI
> config
> > accessors. For these cases we implement the way to overwrite
> accessors
> > set. Algorithm traverses available quirk list, matches against
> > <oem_id, oem_rev, domain, bus number> tuple and returns corresponding
> > PCI config ops. oem_id and oem_rev come from MCFG table standard
> header.
> > All quirks can be defined using DECLARE_ACPI_MCFG_FIXUP() macro and
> > kept self contained. Example:
> >
> > /* Custom PCI config ops */
> > static struct pci_generic_ecam_ops foo_pci_ops =3D {
> > 	.bus_shift	=3D 24,
> > 	.pci_ops =3D {
> > 		.map_bus =3D pci_ecam_map_bus,
> > 		.read =3D foo_ecam_config_read,
> > 		.write =3D foo_ecam_config_write,
> > 	}
> > };
> >
> > DECLARE_ACPI_MCFG_FIXUP(&foo_pci_ops, <oem_id_str>, <oem_rev>,
> <domain_nr>, <bus_nr>);
> >
> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > ---
> >  drivers/acpi/pci_mcfg.c           | 32
> ++++++++++++++++++++++++++++++++
> >  include/asm-generic/vmlinux.lds.h |  7 +++++++
> >  include/linux/pci-acpi.h          | 19 +++++++++++++++++++
> >  3 files changed, 58 insertions(+)
> >
> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > index 1847f74..f3d4570 100644
> > --- a/drivers/acpi/pci_mcfg.c
> > +++ b/drivers/acpi/pci_mcfg.c
> > @@ -22,11 +22,43 @@
> >  #include <linux/kernel.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-acpi.h>
> > +#include <linux/pci-ecam.h>
> >
> >  /* Root pointer to the mapped MCFG table */
> >  static struct acpi_table_mcfg *mcfg_table;
> >  static int mcfg_entries;
> >
> > +extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
> > +extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
> > +
> > +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> > +{
> > +	int bus_num =3D root->secondary.start;
> > +	int domain =3D root->segment;
> > +	struct pci_cfg_fixup *f;
> > +
> > +	if (!mcfg_table)
> > +		return &pci_generic_ecam_ops;
> > +
> > +	/*
> > +	 * Match against platform specific quirks and return
> corresponding
> > +	 * CAM ops.
> > +	 *
> > +	 * First match against PCI topology <domain:bus> then use OEM ID
> and
> > +	 * OEM revision from MCFG table standard header.
> > +	 */
> > +	for (f =3D __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups;
> f++) {
> > +		if ((f->domain =3D=3D domain || f->domain =3D=3D
> PCI_MCFG_DOMAIN_ANY) &&
> > +		    (f->bus_num =3D=3D bus_num || f->bus_num =3D=3D
> PCI_MCFG_BUS_ANY) &&
> > +		    (!strncmp(f->oem_id, mcfg_table->header.oem_id,
> > +			      ACPI_OEM_ID_SIZE)) &&
> > +		    (f->oem_revision =3D=3D mcfg_table->header.oem_revision))
>=20
> Is this more likely to be updated between quirky and fixed platforms
> than oem_table_id? What do folks think about using oem_table_id instead
> of, or in addition to, oem_revision?

>From my understanding we need to stick to this mechanism as (otherwise)
there are platforms out in the field that would need a FW update.

So I don't think that using oem_table_id "instead" is possible; about
"in addition" I think it is doable, but I do not see the advantage much.
I mean that if a platform gets fixed the oem revision should change too,
Right?  =20

Thanks

Gab

>=20
> In case these details are helpful, here was my simple prototype of an
> MCFG based approach:
>=20
> https://codeaurora.org/cgit/quic/server/kernel/commit/?h=3Dcov/4.7-rc1-
> testing&id=3Dc5d8bc49a198fd8f61f82c7d8f169564d6176b07
> https://codeaurora.org/cgit/quic/server/kernel/commit/?h=3Dcov/4.7-rc1-
> testing&id=3D50bfe77ccd1639e6ce8c7c4fcca187d50e0bead4
>=20
> Thanks,
> Cov
>=20
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
