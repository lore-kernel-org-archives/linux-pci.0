Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 23 Sep 2016 14:17:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
Message-ID: <20160923191710.GB16019@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <20160920192636.GB4941@localhost>
 <0429663d51ed8e93fb0c96261dd2ecc7@codeaurora.org>
 <20160921131107.GB10804@localhost>
 <304377c6-554d-60ea-30df-006e557c7279@codeaurora.org>
 <20160922230806.GB1514@localhost>
 <e1b1c38f-0779-82a5-5d3c-b164215a4ed3@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <e1b1c38f-0779-82a5-5d3c-b164215a4ed3@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, gabriele.paoloni@huawei.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org,
 wangyijing@huawei.com, andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com,
 jhugo@codeaurora.org, Tomasz Nowicki <tn@semihalf.com>,
 linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com,
 linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
 liudongdong3@huawei.com, msalter@redhat.com, Liviu.Dudau@arm.com,
 arnd@arndb.de, jcm@redhat.com, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, dhdang@apm.com, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, hanjun.guo@linaro.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 23, 2016 at 02:41:39PM -0400, Christopher Covington wrote:
> On 09/22/2016 07:08 PM, Bjorn Helgaas wrote:
> > On Wed, Sep 21, 2016 at 06:40:47PM -0400, Christopher Covington wrote:
> >> Hi Bjorn,
> >>
> >> On 09/21/2016 09:11 AM, Bjorn Helgaas wrote:
> >>> On Tue, Sep 20, 2016 at 09:15:14PM -0400, cov@codeaurora.org wrote:
> >>
> >>>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> >>>>> index eb14f74..bb3b8ad 100644
> >>>>> --- a/drivers/acpi/pci_mcfg.c
> >>>>> +++ b/drivers/acpi/pci_mcfg.c
> >>>>> @@ -42,86 +42,59 @@ struct mcfg_fixup {
> >>>>> 	struct resource cfgres;
> >>>>> };
> >>>>>
> >>>>> -#define MCFG_DOM_ANY			(-1)
> >>>>
> >>>> Did you delete this because there were no current users, because you'd
> >>>> prefer users just use "-1", or for some other reason?
> >>>
> >>> I removed it because there were no users of it and, more importantly,
> >>> the code doesn't implement support for it.
> >>
> >> It looks like a stale "First match against PCI topology <domain:bus>..."
> >> comment remains.
> > 
> > Yep.  I removed the comment since it's sort of obvious from the code.
> > I also renamed a few things and pulled the match out into a helper
> > function.
> > 
> > I also changed the dmesg note: I think the actual resource and the
> > name of the pci_ecam_ops is more interesting than the table IDs (which
> > I think are already elsewhere in the dmesg log).
> 
> It looks like the resource is already being printed from
> drivers/pci/ecam.c:102.

Yes, but I want a hint that a quirk has overridden it because that's a
clue that there's something wonky about the platform or the firmware.

But I guess it'd be nice to mirror the format of the existing info
(mem first, then bus range).

> > Here's the incremental diff, which I can't really test:
> 
> Here's what it looks like for me:
> 
> ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
> acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug]
> acpi PNP0A08:02: _OSC: OS now controls [PME AER PCIeCapability]
> acpi PNP0A08:02: MCFG quirk: ECAM space for [bus 00-1f] at [mem 0xa0000000000-0xa0001ffffff] with pci_3

Is "pci_3" really the entire name?  If not, what happened to the rest?
I was hoping for a symbol we could grep for.

> acpi PNP0A08:02: ECAM at [mem 0xa0000000000-0xa0001ffffff] for [bus 00-1f]
> Remapped I/O 0x00000affffff0000 to [io  0x10000-0x1ffff window]
> PCI host bridge to bus 0002:00
> 
> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > index 245b79f..0b36bc5 100644
> > --- a/drivers/acpi/pci_mcfg.c
> > +++ b/drivers/acpi/pci_mcfg.c
> > @@ -36,7 +36,7 @@ struct mcfg_fixup {
> >  	char oem_id[ACPI_OEM_ID_SIZE + 1];
> >  	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> >  	u32 oem_revision;
> > -	u16 seg;
> > +	u16 segment;
> >  	struct resource bus_range;
> >  	struct pci_ecam_ops *ops;
> >  	struct resource cfgres;
> > @@ -102,30 +102,37 @@ static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> >  static char mcfg_oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> >  static u32 mcfg_oem_revision;
> >  
> > -static void pci_mcfg_match_quirks(struct acpi_pci_root *root,
> > +static int pci_mcfg_quirk_matches(struct mcfg_fixup *f, u16 segment,
> > +				  struct resource *bus_range)
> > +{
> > +	if (!memcmp(f->oem_id, mcfg_oem_id, ACPI_OEM_ID_SIZE) &&
> > +	    !memcmp(f->oem_table_id, mcfg_oem_table_id,
> > +	            ACPI_OEM_TABLE_ID_SIZE) &&
> > +	    f->oem_revision == mcfg_oem_revision &&
> > +	    f->segment == segment &&
> > +	    resource_contains(&f->bus_range, bus_range))
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
> >  				  struct resource *cfgres,
> >  				  struct pci_ecam_ops **ecam_ops)
> >  {
> > +	u16 segment = root->segment;
> > +	struct resource *bus_range = &root->secondary;
> >  	struct mcfg_fixup *f;
> >  	int i;
> >  
> > -	/*
> > -	 * First match against PCI topology <domain:bus> then use OEM ID, OEM
> > -	 * table ID, and OEM revision from MCFG table standard header.
> > -	 */
> >  	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
> > -		if (!memcmp(f->oem_id, mcfg_oem_id, ACPI_OEM_ID_SIZE) &&
> > -		    !memcmp(f->oem_table_id, mcfg_oem_table_id,
> > -		            ACPI_OEM_TABLE_ID_SIZE) &&
> > -		    f->oem_revision == mcfg_oem_revision &&
> > -		    f->seg == root->segment &&
> > -		    resource_contains(&f->bus_range, &root->secondary)) {
> > +		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
> >  			if (f->cfgres.start)
> >  				*cfgres = f->cfgres;
> >  			if (f->ops)
> >  				*ecam_ops =  f->ops;
> > -			dev_info(&root->device->dev, "Applying PCI MCFG quirks for %s %s rev: %d\n",
> > -				 f->oem_id, f->oem_table_id, f->oem_revision);
> > +			dev_info(&root->device->dev, "MCFG quirk: ECAM space for %pR at %pR with %ps\n",
> > +				 bus_range, cfgres, *ecam_ops);
> >  			return;
> >  		}
> >  	}
> > @@ -173,7 +180,7 @@ skip_lookup:
> >  	 * MCFG does not have it.  Invalid CFG start address means MCFG
> >  	 * firmware bug or we need another quirk in array.
> >  	 */
> > -	pci_mcfg_match_quirks(root, &res, &ops);
> > +	pci_mcfg_apply_quirks(root, &res, &ops);
> >  	if (!res.start)
> >  		return -ENXIO;
> >  
> > 
> 
> 
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
> Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
