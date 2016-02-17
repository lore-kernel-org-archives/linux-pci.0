Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 17 Feb 2016 17:45:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>, okaya@codeaurora.org,
	jiang.liu@linux.intel.com,
	Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>,
	Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V5 07/15] pci, acpi: Provide generic way to assign bus
 domain number.
Message-ID: <20160217174516.GA11132@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-8-git-send-email-tn@semihalf.com>
 <CAKc_7PU+i2AwOVCyW2VNt4BZCWw=KBMAbV8v9DVQ2Ess3WE=kw@mail.gmail.com>
 <56C47E9A.5010901@semihalf.com>
 <CAKc_7PUiLQhUuJjR8wcuRm7KJdxBYjb+ZBd_cLTtjNPbEro6wA@mail.gmail.com>
 <56C48C45.7050203@semihalf.com>
 <CAKc_7PV=p7kHt73c673L+v=KCaFV8RzoaSHwcH2gd1g-fWGq5w@mail.gmail.com>
 <56C49342.1070308@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C49342.1070308@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Guys,

On Wed, Feb 17, 2016 at 04:35:30PM +0100, Tomasz Nowicki wrote:

[...]

> >>>>>In my patchset, I had a slightly different and I think better approach
> >>>>>for
> >>>>>this without calling the _SEG method again. Please see
> >>>>>http://www.spinics.net/lists/arm-kernel/msg478167.html
> >>>>>at the last part
> >>>>>ofhttp://www.spinics.net/lists/arm-kernel/msg478169.html
> >>>>
> >>>>
> >>>>Relying on NULL parent device to make decision on boot method is really
> >>>>ugly
> >>>>way. This may hit us again once we want to obtain another firmware
> >>>>specific
> >>>>info e.g. numa node. IMO we need to fix it this way.
> >>>
> >>>
> >>>I am not relying on NULL there, in the current code parent is NULL
> >>>in case of ACPI, and the check is needed not to crash (unless that
> >>>has changed).
> >>
> >>
> >>This series passes down valid parent, see [PATCH V5 06/15].
> >>
> >>>
> >>>The main part was the macro acpi_pci_get_segment() and the use
> >>>of acpi_pci_root_info from sysdata to do this.
> >>
> >>
> >>Since we can obtain related firmware specific data from valid parent device
> >>(without defining another accessors), I do not see the point to use sysdata.
> >>Let me know your opinion.
> >
> >In the patch, you use the parent info and call _SEG method again.
> >The segment information is available in the ->root->segment of
> >acpi_pci_root_info if you setup the sysdata like in my patch
> 
> I know it is in sysdata->root->segment, but the way it is passed
> down is wrong. sysdata is the pointer to unknown content (void *) so
> we need to validate it before we can use it. If we merge this patch
> we can remove first _SEG call.

I personally do not think there is such a significant difference, both
solutions have pros and cons, it is worth keeping in mind though
that reading _SEG again to set the bus domain number works only if
the value we stash in acpi_pci_root.segment is not overridden, if it
is (ie see x86 - agreed that's to fix a FW bug) we have a disconnect.

On the other hand Tomasz's code allows removing some IA64 code in the
process (code that sets the bridge companion, so part of the patch
should be kept regardless).

So, there are two things to do:

- Assign the bridge companion in PCI core code
- Decide where to get the domain number from (acpi_pci_root.segment vs
  calling _SEG again). At present they are equivalent so I do not see
  any compelling reason to change this patch.

Side note: there is already a function (pci_domain_nr()) that you
can implement in ACPI PCI host generic (by deselecting
PCI_DOMAINS_GENERIC if ACPI) so there is no need for acpi_pci_get_segment()
in case we have to override _SEG value in the future, at present
there is no need, comments appreciated.

Lorenzo
