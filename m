Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"jcm@redhat.com" <jcm@redhat.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	qiujiang <qiujiang@huawei.com>
Subject: RE: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
 controller ECAM compliant
Date: Tue, 9 Feb 2016 15:56:26 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECAF200@lhreml503-mbs>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <2599997.xBRrI3qHak@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECAD436@lhreml503-mbs>
 <3763449.y3Mfs92xrA@wuerfel>
In-Reply-To: <3763449.y3Mfs92xrA@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 09 February 2016 15:32
> To: linux-arm-kernel@lists.infradead.org
> Cc: Gabriele Paoloni; Lorenzo.Pieralisi@arm.com; jcm@redhat.com;
> tn@semihalf.com; linux-pci@vger.kernel.org; Linuxarm; xuwei (O); linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Wangzhou (B);
> liudongdong (C); Guohanjun (Hanjun Guo); bhelgaas@google.com;
> zhangjukuo; Liguozhu (Kenneth); qiujiang
> Subject: Re: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
> controller ECAM compliant
> 
> On Monday 08 February 2016 17:21:27 Gabriele Paoloni wrote:
> > Hi Arnd
> >
> > > -----Original Message-----
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > Sent: 08 February 2016 16:30
> > > To: Gabriele Paoloni
> > > Cc: linux-arm-kernel@lists.infradead.org; Guohanjun (Hanjun Guo);
> > > Wangzhou (B); liudongdong (C); Linuxarm; qiujiang;
> bhelgaas@google.com;
> > > Lorenzo.Pieralisi@arm.com; tn@semihalf.com; linux-
> pci@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; xuwei (O); linux-acpi@vger.kernel.org;
> > > jcm@redhat.com; zhangjukuo; Liguozhu (Kenneth)
> > > Subject: Re: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe
> host
> > > controller ECAM compliant
> > >
> > > On Monday 08 February 2016 15:55:35 Gabriele Paoloni wrote:
> > > > > Doesn't this break backwards compatibility?
> > > >
> > > > Well Hip05/Hip06 SoCs are used into evaluation boards
> > > > For the Estuary project.
> > > >
> > > > https://github.com/hisilicon/estuary
> > > >
> > > > As this new driver gets upstream we'll merge this new driver into
> > > estuary
> > > > and release a new version of the firmware to support it.
> > >
> > > So what happens to folks running the old firmware then?
> >
> > So far we haven't released the PCIe nodes dtsi upstream and we think
> > we can handle the firmware upgrade for our current users either
> > by pointing them to the updated Estuary branch or by internal
> > channels
> 
> The dts files in the kernel tree are not really that important,
> the question is whether you are breaking things for real users.
> 
> If the upstream drivers work on some released firmware version,
> they should keep working.
> 
> > >
> > > > > I think you need to use a new compatible string in the firmware
> > > > > if you change the register layout, and then change the driver
> > > > > to support both the old and the new layout.
> > > >
> > > > You are right, for some reason in this patchset I missed the
> > > Documentation
> > > > update that I posted in the previous one, i.e.:
> > > >
> > > > --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > > > @@ -23,8 +23,8 @@ Optional properties:
> > > >  Hip05 Example (note that Hip06 is the same except compatible):
> > > >         pcie@0xb0080000 {
> > > >                 compatible = "hisilicon,hip05-pcie", "snps,dw-
> pcie";
> > > > -               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000
> 0
> > > 0x2000>;
> > > > -               reg-names = "rc_dbi", "config";
> > > > +               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00100000
> 0
> > > 0x0f00000>;
> > > > +               reg-names = "rc_dbi", "ecam-cfg";
> > > >
> > >
> > > That is not the compatible string, it's an undocumented register
> set.
> >
> > Sorry, I misunderstood here, got it now :)
> >
> > > You can either define the a new compatible string that gives the
> > > "config"
> > > registers a new meaning, or you change the binding to allow two
> either
> > > a "config" or an "ecam-cfg" register set, and let the driver handle
> > > both.
> >
> > As per reply above I think that it would be quite easy for us to
> > let out current users update the BIOS so I don't think there is any
> > value in maintaining two version of the drivers one of which will
> > not be used.
> >
> > What do you think?
> 
> Requiring a BIOS update for a kernel update is really bad, even more
> so when the same BIOS update breaks older kernels.

Well I see your point.

To be honest I won't expect many users of the old BIOS version since
as I said we plan to send out the BIOS update to pretty much every user,
however on the other side it is not too much effort for me to add code
to support both ECAM/non ECAM, 
so ok I'll fix this in v3,

Many Thanks

Gab

> 
> 	Arnd
