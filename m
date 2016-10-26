Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <20160921212258.GE20006@localhost>
References: <1474122278-32525-1-git-send-email-dhdang@apm.com>
 <20160919200614.GB21763@localhost> <CADaLNDmYoYAiufYFrwhWjPBj29XPBSx1FydoM67v0c03D8N7vQ@mail.gmail.com>
 <20160921212258.GE20006@localhost>
From: Duc Dang <dhdang@apm.com>
Date: Tue, 25 Oct 2016 18:31:29 -0700
Message-ID: <CADaLNDmBTCApAnWqmYyzj1zTsF5Sh=Nn3urVqeb-Wc9JdsBskw@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rafael Wysocki <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>,
	Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 2:22 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Sep 19, 2016 at 06:07:37PM -0700, Duc Dang wrote:
>> On Mon, Sep 19, 2016 at 1:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Sat, Sep 17, 2016 at 07:24:38AM -0700, Duc Dang wrote:
>
>> This patch only adds the ability for X-Gene PCIe controller to be
>> probable in ACPI boot mode. All the 'quirk' code added is for ECAM to
>> work with X-Gene.
>>
>> > I sort of expected this to also remove, for example, the seemingly
>> > identical xgene_pcie_config_read32() in drivers/pci/host/pci-xgene.c.
>> > Actually, a bunch of this code seems to be duplicated from there.  It
>> > doesn't seem like we should end up with all this duplicated code.
>> >
>> > I'd really like it better if all this could get folded into
>> > pci-xgene.c so we don't end up with more files.
>>
>> I am still debating whether to put this X-Gene ECAM quirk code into
>> drivers/acpi or keep it here in drivers/pci/host. But given the
>> direction of other quirk patches for ThunderX and HiSi, seem like the
>> quirk will stay in drivers/pci/host. I can definitely fold the new
>> quirk code into pci-xgene.c as you suggested and eliminate the
>> identical one.
>
> I like Tomasz's patches, where the MCFG quirk itself is in
> acpi/pci_mcfg.c, and it uses config accessors exported from
> drivers/pci/host.

Yes, I removed the new file and folded the quirk code into pci-xgene.c.

>
> I do not want to end up with duplicate accessors.  The mapping
> functions and accessors should be the same whether we're booting with
> DT or ACPI.
>
> I think a patch to add ACPI support should only contain:
>
>   - acpi/pci_mcfg.c quirks to fix incorrect ACPI MCFG resources or use
>     special accessors,
>
>   - pnp/quirks.c quirks to compensate for missing ACPI _CRS for the
>     ECAM regions, and
>
>   - pci-xgene.c code to derive the csr_base and cfg_base.  Today we
>     get that from DT, but the _CRS producer/consumer mess means we
>     don't have a good way to get it from ACPI, so you'll need some
>     sort of quirk for this.

The new quirk code (v2 patch) follows this direction, but I have not
found a good way to introduce quirk into pnp/quirks.c yet. Just to
clarify a little bit, our ACPI table provides ECAM base address from
_CBA method. The missing piece is the controller register base address
(csr_base) that I need to get from a hard-coded resource array.

I also owe you the rework for Configuration Request Retry Status
workaround, but it will need to be done in a separate patch set for
both DT and ACPI.
>
>> >> +struct xgene_pcie_acpi_root {
>> >> +     void __iomem *csr_base;
>> >> +     u32 version;
>> >> +};
>> >
>> > I think this should be folded into struct xgene_pcie_port so we don't
>> > have to allocate and manage it separately.
>>
>> I will need to look into this more. When booting with ACPI mode, the
>> code in pci-xgene.c is not used (except the cfg read/write functions
>> that are shared with ECAM quirk code), so puting these into
>> xgene_pcie_port will force ECAM quirk code to allocate this structure
>> as well.
>
> This information is needed whether booting with DT or ACPI, so we
> should use the existing xgene_pcie_port.csr_base and initialize it
> differently depending on which we're using.

The new ECAM quirk code will also allocate struct xgene_pcie_port, I
got rid of xgene_pcie_acpi_root struct.

>
>> >> +     default:
>> >> +             return -ENODEV;
>> >> +     }
>> >> +
>> >> +     xgene_root->csr_base = ioremap(csr_base, XGENE_CSR_LENGTH);
>> >
>> > There should be a request_region() somewhere, too.  Ideal would be to
>> > use devm_ioremap_resource(), but I don't know where this apparent
>> > resource is coming from.
>>
>> Yes, I will use request_region/devm_ioremap_resource here.
>
> We're not *adding* any new resources that need ioremapping; all we're
> doing is changing the *source* of the resource, so we should use the
> same devm_ioremap_resource() you already have in xgene_pcie_map_reg().
> You might have to refactor that slightly so we can lookup the resource
> via either DT or ACPI (you'll probably actually use a quirk since ACPI
> doesn't have a good mechanism for this), and then use the same call to
> devm_ioremap_resource().

I changed to use devm_ioremap_resource to map the csr_base from the
fixed resource array defined for each X-Gene SoC. The 'cat
/proc/iomem' for PCIe port on Mustang board is like following:

1f2b0000-1f2bffff : PNP0A08:00
e040000000-e07fffffff : PCI Bus 0000:00
  e040000000-e0401fffff : PCI Bus 0000:01
    e040000000-e0400fffff : 0000:01:00.0
      e040000000-e0400fffff : mlx4_core
    e040100000-e0401fffff : 0000:01:00.0
e0d0000000-e0dfffffff : PCI ECAM
f000000000-ffffffffff : PCI Bus 0000:00
  f000000000-f001ffffff : PCI Bus 0000:01
    f000000000-f001ffffff : 0000:01:00.0
      f000000000-f001ffffff : mlx4_core

Is this what you expect? Or you are looking for something else?

Regards,
Duc Dabng.
