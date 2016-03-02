Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 2 Mar 2016 08:32:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	'Mark Rutland' <mark.rutland@arm.com>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"'bhelgaas@google.com'" <bhelgaas@google.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'tn@semihalf.com'" <tn@semihalf.com>,
	"'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
	"'jcm@redhat.com'" <jcm@redhat.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
 HiSilicon SoCs Host Controllers
Message-ID: <20160302143247.GA24024@localhost>
References: <20160209182429.GD4348@leverpostej>
 <20160225120750.GA32016@red-moon>
 <20160225195912.GA4818@localhost>
 <8105311.kD8XXIcipM@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8105311.kD8XXIcipM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 25, 2016 at 10:24:34PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 25, 2016 01:59:12 PM Bjorn Helgaas wrote:
> > On Thu, Feb 25, 2016 at 12:07:50PM +0000, Lorenzo Pieralisi wrote:
> > > On Thu, Feb 25, 2016 at 03:01:19AM +0000, Gabriele Paoloni wrote:
> > > 
> > > [...]
> > > 
> > > > > I think the relevant spec is the PCI Firmware Spec, r3.0, sec 4.1.2.
> > > > > Note 2 in that section says the address range of an MMCFG region
> > > > > must be reserved by declaring a motherboard resource, i.e., included
> > > > > in the _CRS of a PNP0C02 or similar device.
> > > > 
> > > > I had a look a this. So yes the specs says that we should use the 
> > > > PNP0C02 device if MCFG is not supported. 
> > > 
> > > AFAIK, PNP0C02 is a resource reservation mechanism, the spec says that
> > > MCFG regions must be reserved using PNP0C02, even though its
> > > current usage on x86 is a bit unfathomable to me, in particular
> > > in relation to MCFG resources retrieved for hotpluggable bridges (ie
> > > through _CBA, which I think consider the MCFG region as reserved
> > > by default, regardless of PNP0c02):
> > > 
> > > see pci_mmcfg_check_reserved() arch/x86/pci/mmconfig-shared.c
> > 
> > I don't know how _CBA-related resources would be reserved.  I haven't
> > personally worked with any host bridges that supply _CBA, so I don't
> > know whether or how they handled it.
> > 
> > I think the spec intent was that the Consumer/Producer bit (Extended
> > Address Space Descriptor, General Flags Bit[0], see ACPI spec sec
> > 6.4.3.5.4) would be used.  Resources such as ECAM areas would be
> > marked "Consumer", meaning the bridge consumed that space itself, and
> > windows passed down to the PCI bus would be marked "Producer".
> > 
> > But BIOSes didn't use that bit consistently, so we couldn't rely on
> > it.  I verified experimentally that Windows didn't pay attention to
> > that bit either, at least for DWord descriptors:
> > https://bugzilla.kernel.org/show_bug.cgi?id=15701
> > 
> > It's conceivable that we could still use that bit in Extended Address
> > Space descriptors, or maybe some hack like pay attention if the bridge
> > has _CBA, or some such.
> 
> Last time I asked the firmware vendor people in the ASWG about that,
> the answer was that the Consumer/Producer bit was useless as they had
> never paid any attention to it in general.
> 
> It may be good to update the spec to say something along these lines, actually.

Yes, we've tried updating the spec, but the update was kind of a
disaster.

ACPI 2.0b documented the Consumer/Producer bit in the General Flags
byte of QWORD, DWORD, and WORD Address Space Descriptors (6.4.3.5).

ACPI 2.0c removed that General Flags description, but left
ResourceConsumer in various examples and in the ASL grammar (16.1.3).

ACPI 3.0 added back the Consumer/Producer bit in General Flags (I
think this was an editing mistake) and added the Extended Address
Space Descriptor, also with a Consumer/Producer bit.

ACPI 5.0 removed the Consumer/Producer bit from QWORD, DWORD, and WORD
Address Space Descriptors, but kept it for Extended Address Space
Descriptors (the revision history says this change actually happened
in 4.0a, which I don't have a copy of: "4.0a Apr. 2010:
Consumer/Producer bit is ignored (Restored 2.0C change that had been
lost)").

ACPI 6.0 contains the following incorrect or misleading things:

  - 6.4.3.5.4 Extended Address Space Descriptor documents the
    Consumer/Producer bit in General Flags.

  - 19.2.8 ASL Resource Template Terms defines a ResourceUsage term
    for DWordIO, DWordMemory, DWordSpace, etc., even though I think
    there's no way to encode in in the AML.

  - 19.6.33 DWordIO and similar sections mention ResourceUsage, even
    though I think there's no way to encode it in the AML.

  - Various examples (5.2.21.10, 6.2.4, 9.12.4) show QWordMemory
    using ResourceConsumer.

It's sort of a mess.

Bjorn
