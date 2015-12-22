Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
Cc: "robert.richter@caviumnetworks.com"
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
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <567923D2.2010202@semihalf.com>
Date: Tue, 22 Dec 2015 11:20:02 +0100
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21.12.2015 12:47, Gabriele Paoloni wrote:
> 2) In the quirk mechanism you proposed, I see that the callback function
>     allows to do some preparation work for the host bridge. For example in
>     Hisilicon hip05 case we would need to read some values from the ACPI
>     table (see acpi_pci_root_hisi_add() function in
>     https://lkml.org/lkml/2015/12/3/426).
>     I am quite new to ACPI and I wonder if it is OK to add such "Packages"
>     to the  PCI host bridge ACPI device...or maybe we need to declare a new
>     one...?

I may miss sth so please correct me in that case.

https://lkml.org/lkml/2015/12/3/426 shows that you need special handling 
for root->secondary.start bus number only, right? So how about creating 
special MCFG region <rc-base:rc-base+rc-size> only for <segment,bus>. 
Like that:

[0008]                       Base Address : <rc-base>
[0002]               Segment Group Number : <segment>
[0001]                   Start Bus Number : <root->secondary.start>
[0001]                     End Bus Number : <root->secondary.start>
[0004]                           Reserved : 00000000


static const struct dmi_system_id hisi_quirk[] = {
	{
		.ident = "HiSi...",
		.matches = {
			DMI_MATCH(<whatever you need to match your platform>),
		},
	},
	{ }
};

static struct pci_ops hisi_ecam_pci_ops = {
	.map_bus = pci_mcfg_dev_base,
	.read = hisi_pcie_cfg_read,
	.write = hisi_pcie_cfg_write,
};

DECLARE_ACPI_MCFG_FIXUP(hisi_quirk, &hisi_ecam_pci_ops,
			<segment>, <bus>);

With above code you can use your custom PCI config accessor only for 
that region.

Let me know if that is not enough for you.

Tomasz
