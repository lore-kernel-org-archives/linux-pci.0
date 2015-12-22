Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Tomasz Nowicki <tn@semihalf.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>
CC: "robert.richter@caviumnetworks.com"
	<robert.richter@caviumnetworks.com>,
	"mw@semihalf.com" <mw@semihalf.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Wangyijing <wangyijing@huawei.com>,
	"Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"jchandra@broadcom.com" <jchandra@broadcom.com>,
	"jcm@redhat.com" <jcm@redhat.com>
Subject: RE: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Tue, 22 Dec 2015 14:48:05 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EC183BD@lhreml503-mbb>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
 <567923D2.2010202@semihalf.com>
In-Reply-To: <567923D2.2010202@semihalf.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Tomasz Nowicki
> Sent: 22 December 2015 10:20
> To: Gabriele Paoloni; bhelgaas@google.com; arnd@arndb.de;
> will.deacon@arm.com; catalin.marinas@arm.com; rjw@rjwysocki.net;
> hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
> jiang.liu@linux.intel.com; Stefano.Stabellini@eu.citrix.com
> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; tglx@linutronix.de;
> Wangyijing; Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
> acpi@lists.linaro.org; jchandra@broadcom.com; jcm@redhat.com
> Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space
> accessors against platfrom specific quirks.
> 
> On 21.12.2015 12:47, Gabriele Paoloni wrote:
> > 2) In the quirk mechanism you proposed, I see that the callback
> function
> >     allows to do some preparation work for the host bridge. For
> example in
> >     Hisilicon hip05 case we would need to read some values from the
> ACPI
> >     table (see acpi_pci_root_hisi_add() function in
> >     https://lkml.org/lkml/2015/12/3/426).
> >     I am quite new to ACPI and I wonder if it is OK to add such
> "Packages"
> >     to the  PCI host bridge ACPI device...or maybe we need to declare
> a new
> >     one...?
> 
> I may miss sth so please correct me in that case.
> 
> https://lkml.org/lkml/2015/12/3/426 shows that you need special
> handling for root->secondary.start bus number only, right? So how about
> creating special MCFG region <rc-base:rc-base+rc-size> only for
> <segment,bus>.
> Like that:
> 
> [0008]                       Base Address : <rc-base>
> [0002]               Segment Group Number : <segment>
> [0001]                   Start Bus Number : <root->secondary.start>
> [0001]                     End Bus Number : <root->secondary.start>
> [0004]                           Reserved : 00000000
> 
> 
> static const struct dmi_system_id hisi_quirk[] = {
> 	{
> 		.ident = "HiSi...",
> 		.matches = {
> 			DMI_MATCH(<whatever you need to match your platform>),
> 		},
> 	},
> 	{ }
> };
> 
> static struct pci_ops hisi_ecam_pci_ops = {
> 	.map_bus = pci_mcfg_dev_base,
> 	.read = hisi_pcie_cfg_read,
> 	.write = hisi_pcie_cfg_write,
> };
> 
> DECLARE_ACPI_MCFG_FIXUP(hisi_quirk, &hisi_ecam_pci_ops,
> 			<segment>, <bus>);
> 
> With above code you can use your custom PCI config accessor only for
> that region.
> 
> Let me know if that is not enough for you.

In principle I think it can work...

Liudongdong, Guo Hanjun what is your opinion about?

Thanks

Gab

> 
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
