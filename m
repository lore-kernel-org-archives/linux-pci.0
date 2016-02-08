Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
 controller ECAM compliant
Date: Mon, 8 Feb 2016 17:21:27 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECAD436@lhreml503-mbs>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <3532826.pJr5R5Xa4c@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECACF44@lhreml503-mbs>
 <2599997.xBRrI3qHak@wuerfel>
In-Reply-To: <2599997.xBRrI3qHak@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 08 February 2016 16:30
> To: Gabriele Paoloni
> Cc: linux-arm-kernel@lists.infradead.org; Guohanjun (Hanjun Guo);
> Wangzhou (B); liudongdong (C); Linuxarm; qiujiang; bhelgaas@google.com;
> Lorenzo.Pieralisi@arm.com; tn@semihalf.com; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; xuwei (O); linux-acpi@vger.kernel.org;
> jcm@redhat.com; zhangjukuo; Liguozhu (Kenneth)
> Subject: Re: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
> controller ECAM compliant
> 
> On Monday 08 February 2016 15:55:35 Gabriele Paoloni wrote:
> > > Doesn't this break backwards compatibility?
> >
> > Well Hip05/Hip06 SoCs are used into evaluation boards
> > For the Estuary project.
> >
> > https://github.com/hisilicon/estuary
> >
> > As this new driver gets upstream we'll merge this new driver into
> estuary
> > and release a new version of the firmware to support it.
> 
> So what happens to folks running the old firmware then?

So far we haven't released the PCIe nodes dtsi upstream and we think
we can handle the firmware upgrade for our current users either
by pointing them to the updated Estuary branch or by internal 
channels  

> 
> > > I think you need to use a new compatible string in the firmware
> > > if you change the register layout, and then change the driver
> > > to support both the old and the new layout.
> >
> > You are right, for some reason in this patchset I missed the
> Documentation
> > update that I posted in the previous one, i.e.:
> >
> > --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > @@ -23,8 +23,8 @@ Optional properties:
> >  Hip05 Example (note that Hip06 is the same except compatible):
> >         pcie@0xb0080000 {
> >                 compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> > -               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0
> 0x2000>;
> > -               reg-names = "rc_dbi", "config";
> > +               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00100000 0
> 0x0f00000>;
> > +               reg-names = "rc_dbi", "ecam-cfg";
> >
> 
> That is not the compatible string, it's an undocumented register set.

Sorry, I misunderstood here, got it now :)

> You can either define the a new compatible string that gives the
> "config"
> registers a new meaning, or you change the binding to allow two either
> a "config" or an "ecam-cfg" register set, and let the driver handle
> both.

As per reply above I think that it would be quite easy for us to
let out current users update the BIOS so I don't think there is any
value in maintaining two version of the drivers one of which will
not be used.

What do you think?

Thanks

Gab

> 
> 	Arnd
