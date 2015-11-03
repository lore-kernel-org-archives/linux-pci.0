Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: David Daney <ddaney@caviumnetworks.com>,
	Hanjun Guo <hanjun.guo@linaro.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"robert.richter@caviumnetworks.com"
	<robert.richter@caviumnetworks.com>,
	"Narinder.Dhillon@caviumnetworks.com"
	<Narinder.Dhillon@caviumnetworks.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Wangyijing <wangyijing@huawei.com>,
	"Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>
Subject: RE: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
Date: Tue, 3 Nov 2015 18:00:10 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1629984F@lhreml503-mbs>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <20151103141512.GC3574@red-moon>
 <5638D07B.2030001@linaro.org> <5638F13D.3080406@caviumnetworks.com>
In-Reply-To: <5638F13D.3080406@caviumnetworks.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David

> -----Original Message-----
> From: David Daney [mailto:ddaney@caviumnetworks.com]
> Sent: 03 November 2015 17:39
> To: Hanjun Guo
> Cc: Lorenzo Pieralisi; Sinan Kaya; Tomasz Nowicki; bhelgaas@google.com;
> arnd@arndb.de; will.deacon@arm.com; catalin.marinas@arm.com; rjw@rjwysocki.net;
> jiang.liu@linux.intel.com; robert.richter@caviumnetworks.com;
> Narinder.Dhillon@caviumnetworks.com; Liviu.Dudau@arm.com; tglx@linutronix.de;
> Wangyijing; Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; Gabriele Paoloni; Wangzhou
> (B); liudongdong (C)
> Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
> hostbridge init
> 
> On 11/03/2015 07:19 AM, Hanjun Guo wrote:
> > On 11/03/2015 10:15 PM, Lorenzo Pieralisi wrote:
> >> On Wed, Oct 28, 2015 at 02:46:37PM -0400, Sinan Kaya wrote:
> >>
> >> [...]
> >>
> >>>> -int raw_pci_write(unsigned int domain, unsigned int bus,
> >>>> -        unsigned int devfn, int reg, int len, u32 val)
> >>>> +struct pci_ops pci_root_ops = {
> >>>> +    .map_bus = pci_mcfg_dev_base,
> >>>> +    .read = pci_generic_config_read,
> >>>> +    .write = pci_generic_config_write,
> >>>
> >>>
> >>> Can you change these with pci_generic_config_read32 and
> >>> pci_generic_config_write32? We have some targets that can only do 32
> >>> bits PCI config space access.
> >>
> >> No.
> >>
> >> http://www.spinics.net/lists/linux-pci/msg44869.html
> >>
> >> Can you be a bit more specific please ?
> >>
> >> Sigh. Looks like we have to start adding platform specific quirks even
> >> before we merged the generic ACPI PCIe host controller implementation.
> >
> > Cc Gab, Zhou, and Dondong who upstream the hip05 (designware) PCIe host
> > support.
> >
> > I think so, some platform may not support ECAM for root complex,
> > which needs special handling of access config space, we may need
> > to consider those cases.
> >
> 
> Yes, it is indeed true.  For example, some Cavium ThunderX processors
> fall into this category.
> 
> Some options I thought of are:
> 
>   o Use DECLARE_ACPI_MCFG_FIXUP() in the kernel to supply the needed
> config space accessors.
> 
>   o Define additional root_device_ids that imply the needed config space
> accessors.

Yes I like this

it would fit designware too

Gab

> 
> 
> > Thanks
> > Hanjun

