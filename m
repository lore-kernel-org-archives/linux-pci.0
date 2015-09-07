Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49854 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbbIGIph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Sep 2015 04:45:37 -0400
Date: Mon, 7 Sep 2015 09:45:42 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for
 ACPI
Message-ID: <20150907084542.GA29293@red-moon>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
 <20150526165844.GD2175@e106497-lin.cambridge.arm.com>
 <5564AB68.6080502@linux.intel.com>
 <55657EA3.5000601@linaro.org>
 <CAFpQJXUU4mVbJSyfQJJm_VjR_uAm-xKHP7syYaM_xuC+CG7q5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFpQJXUU4mVbJSyfQJJm_VjR_uAm-xKHP7syYaM_xuC+CG7q5w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 07, 2015 at 05:14:22AM +0100, Ganapatrao Kulkarni wrote:
> Hi Hanjun,
> 
> On Wed, May 27, 2015 at 1:51 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > Hi Liviu,
> >
> > On 2015???05???27??? 01:20, Jiang Liu wrote:
> >>
> >> On 2015/5/27 0:58, Liviu Dudau wrote:
> >>>
> >>> On Tue, May 26, 2015 at 01:49:14PM +0100, Hanjun Guo wrote:
> >>>>
> >>>> ARM64 ACPI based PCI host bridge init needs a arch dependent
> >>>> struct pci_controller to accommodate common PCI host bridge
> >>>> code which is introduced later, or it will lead to compile
> >>>> errors on ARM64.
> >>>
> >>>
> >>> Hi Hanjun,
> >>>
> >>> Two questions: why don't you introduce this patch next to the
> >>> one that is going to make use of it (or even merge it there)?
> >
> >
> > this is because of this patch is needed by Jiang Liu's patch set
> > to fix the compile error on ARM64, I'd rather do that, but It's
> > better to let Jiang Liu's patch goes in, and then this one, that's
> > why I prepared a single patch for the struct. (I mentioned it
> > in the cover letter)
> >
> >>> Second, why is the whole struct pci_controller not surrounded
> >>> by #ifdef CONFIG_ACPI as you are implying that this is needed
> >>> only for ACPI?
> >
> >
> > I hope it can be reused, since the NUMA node and segment (domain)
> > is both needed for DT and ACPI, if it's not the case foe now, I
> > can surrounded them all by #ifdef CONFIG_ACPI.
> we can make use of this structure to hold pci to numa node
> mapping(pcibus_to_node).
> can you please pull node member out of  CONFIG_ACPI ifdef.
> or you can put only acpi_device under ifdef.

That struct disappeared in the latest series:

https://lkml.org/lkml/2015/6/8/443

we have to have a common way to handle the NUMA info in DT and ACPI
so we should still find a solution that can be shared between the two,
it is yet another thing to take into account for PCI ACPI on arm64.

Thanks,
Lorenzo
