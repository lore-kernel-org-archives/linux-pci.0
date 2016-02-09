Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Feb 2016 18:11:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Mark Salter <msalter@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: ACPI: IA64: fix IO port generic range check
Message-ID: <20160209181139.GD22868@red-moon>
References: <1454322357-10912-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160209170006.GA21247@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160209170006.GA21247@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Feb 09, 2016 at 11:00:06AM -0600, Bjorn Helgaas wrote:
> Hi Lorenzo,
> 
> On Mon, Feb 01, 2016 at 10:25:57AM +0000, Lorenzo Pieralisi wrote:
> > The [0 - 64k] ACPI PCI IO port resource boundary check in:
> > 
> > acpi_dev_ioresource_flags()
> > 
> > is currently applied blindly in the ACPI resource parsing to all
> > architectures, but only x86 suffers from that IO space limitation.
> > The check in generic ACPI code leaves other arches (ie IA64) IO space
> > broken (ie kernel can't claim IO resources since the host bridge
> > IO resource is disabled and discarded by ACPI core code, eg log on
> > IA64):
> > 
> > pci 0000:00:03.0: [1002:515e] type 00 class 0x030000
> > 
> > pci 0000:00:03.0: reg 0x10: [mem 0x80000000-0x87ffffff pref]
> > 
> > pci 0000:00:03.0: reg 0x14: [io  0x1000-0x10ff]
> > 
> > pci 0000:00:03.0: reg 0x18: [mem 0x88020000-0x8802ffff]
> > 
> > pci 0000:00:03.0: reg 0x30: [mem 0x88000000-0x8801ffff pref]
> > 
> > pci 0000:00:03.0: supports D1 D2
> > 
> > pci 0000:00:03.0: can't claim BAR 1 [io  0x1000-0x10ff]: no compatible
> > bridge window
> 
> I think your text and code changes make sense, but I don't understand
> this example.  I guess there must have been a host bridge window from
> _CRS that got discarded, which would lead to this error for any I/O
> resources in the tree below that bridge.

Exactly, claiming IO space fails since the root bridge aperture from
_CRS was discarded by core ACPI code.

> I guess that probably doesn't show up in the dmesg log, except that
> the root bus doesn't have any I/O resources, because we only show the
> root bus resources, not the original _CRS resources.

Yep.

> This seems like something we might explicitly note in dmesg, i.e.,
> maybe we should log a warning when we discard an invalid resource.

Yes, I can do that, with a separate patch (unless you want it to go
in via this fix). I will send a v2 with a rephrased commit log to show
how the root bus resources have to look like and how they look currently,
reporting the regression.

Thanks,
Lorenzo

> > For this reason, the IO port resources boundaries check in generic ACPI
> > parsing code should be moved to x86 arch code so that more arches (ie
> > ARM64) can benefit from the generic ACPI resources parsing interface
> > without incurring in unexpected resource filtering, fixing at the same
> > time current breakage on IA64.
> > 
> > This patch moves the IO ports boundary [0 - 64k] check to x86 arch code
> > code that validates the PCI host bridge resources.
> > 
> > Fixes: 3772aea7d6f3 ("ia64/PCI/ACPI: Use common ACPI resource parsing
> > interface for host bridge")
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Jiang Liu <jiang.liu@linux.intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Tomasz Nowicki <tn@semihalf.com>
> > Cc: Mark Salter <msalter@redhat.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > ---
> >  arch/x86/pci/acpi.c     | 18 +++++++++++++-----
> >  drivers/acpi/resource.c |  3 ---
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> > index 3cd6983..e20dbe5 100644
> > --- a/arch/x86/pci/acpi.c
> > +++ b/arch/x86/pci/acpi.c
> > @@ -275,11 +275,14 @@ static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
> >   *     to access PCI configuration space.
> >   *
> >   * So explicitly filter out PCI CFG IO ports[0xCF8-0xCFF].
> > + *
> > + * Furthermore, IO ports address space is limited to 16k on x86,
> > + * any IO resource exceeding the boundary must therefore be discarded.
> >   */
> > -static bool resource_is_pcicfg_ioport(struct resource *res)
> > +static bool ioport_valid(struct resource *res)
> >  {
> > -	return (res->flags & IORESOURCE_IO) &&
> > -		res->start == 0xCF8 && res->end == 0xCFF;
> > +	return !(res->start == 0xCF8 && res->end == 0xCFF) &&
> > +	       !(res->end >= 0x10003);
> >  }
> >  
> >  static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> > @@ -287,13 +290,18 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> >  	struct acpi_device *device = ci->bridge;
> >  	int busnum = ci->root->secondary.start;
> >  	struct resource_entry *entry, *tmp;
> > +	struct resource *res;
> >  	int status;
> >  
> >  	status = acpi_pci_probe_root_resources(ci);
> >  	if (pci_use_crs) {
> > -		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
> > -			if (resource_is_pcicfg_ioport(entry->res))
> > +		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> > +			res = entry->res;
> > +
> > +			if (res->flags & IORESOURCE_IO && !ioport_valid(res))
> >  				resource_list_destroy_entry(entry);
> > +		}
> > +
> >  		return status;
> >  	}
> >  
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index d02fd53..c112e1d 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -127,9 +127,6 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
> >  	if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
> >  		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
> >  
> > -	if (res->end >= 0x10003)
> > -		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
> > -
> >  	if (io_decode == ACPI_DECODE_16)
> >  		res->flags |= IORESOURCE_IO_16BIT_ADDR;
> >  	if (translation_type == ACPI_SPARSE_TRANSLATION)
> > -- 
> > 2.5.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
