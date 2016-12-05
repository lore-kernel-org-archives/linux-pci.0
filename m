Return-Path: <SRS0=hAyG=XU=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=hAyG=XU=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
To: Bjorn Helgaas <helgaas@kernel.org>, Duc Dang <dhdang@apm.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
 <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDk-cMW8k+bXqH3+yYCye_kHf6RXUYQ=eCCZ4FF2ZTjgkQ@mail.gmail.com>
 <20161205212012.GA22455@bhelgaas-glaptop.roam.corp.google.com>
Cc: Mark Salter <msalter@redhat.com>, Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <3dd5dd01-e711-76bc-d533-aef7aa593e0a@redhat.com>
Date: Mon, 5 Dec 2016 18:31:52 -0500
MIME-Version: 1.0
In-Reply-To: <20161205212012.GA22455@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 12/05/2016 04:20 PM, Bjorn Helgaas wrote:
> On Fri, Dec 02, 2016 at 11:06:30PM -0800, Duc Dang wrote:
>> On Fri, Dec 2, 2016 at 3:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>>> index 8a177a1..a16fc8e 100644
>>> --- a/arch/arm64/kernel/pci.c
>>> +++ b/arch/arm64/kernel/pci.c
>>> @@ -114,6 +114,19 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>>>         return 0;
>>>  }
>>>
>>> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>>> +{
>>> +       struct resource_entry *entry, *tmp;
>>> +       int status;
>>> +
>>> +       status = acpi_pci_probe_root_resources(ci);
>>> +       resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>>> +               if (!(entry->res->flags & IORESOURCE_WINDOW))
>>> +                       resource_list_destroy_entry(entry);
>>> +       }
>>> +       return status;
>>> +}
>>> +
>>>  /*
>>>   * Lookup the bus range for the domain in MCFG, and set up config space
>>>   * mapping.
>>> @@ -190,6 +203,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>>>         }
>>>
>>>         root_ops->release_info = pci_acpi_generic_release_info;
>>> +       root_ops->prepare_resources = pci_acpi_root_prepare_resources;
>>>         root_ops->pci_ops = &ri->cfg->ops->pci_ops;
>>>         bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
>>>         if (!bus)
>>
>> I tried your patch above with my X-Gene ECAM v4 patch on Mustang, here
>> is the kernel boot log and output of 'cat /proc/iomem'. The PCIe core
>> does not print the MMIO space as a window (which is expected per your
>> patch above).
> 
> Thanks!

...and just for the record, here it is on HPE ProLiant m400 (Moonshot),
with the same result that the region is no longer claimed as PCI space
(it - 1f500000 - is now showing as being owned by PNP0A08:00):

# cat /proc/iomem 
10520000-10523fff : APMC0D18:00
  10520000-10523fff : APMC0D18:00
10524000-10527fff : APMC0D17:00
10540000-1054a0ff : APMC0D01:00
  10546000-10546fff : APMC0D50:00
  1054a000-1054a00f : APMC0D12:03
    1054a000-1054a00f : APMC0D12:02
      1054a000-1054a00f : APMC0D12:01
        1054a000-1054a00f : APMC0D12:00
17000000-17000fff : APMC0D01:00
17001000-17001fff : APMC0D01:00
  17001000-170013ff : APMC0D15:00
    17001000-170013ff : APMC0D15:00
1701c000-1701cfff : APMC0D14:00
1a800000-1a800fff : APMC0D0D:00
  1a800000-1a800fff : APMC0D0D:00
1c000200-1c0002ff : APMC0D06:00
1c021000-1c0210ff : APMC0D08:00
  1c021000-1c02101f : serial
1c024000-1c024fff : APMC0D07:00
1f230000-1f230fff : APMC0D0D:00
  1f230000-1f230fff : APMC0D0D:00
1f23d000-1f23dfff : APMC0D0D:00
  1f23d000-1f23dfff : APMC0D0D:00
1f23e000-1f23efff : APMC0D0D:00
  1f23e000-1f23efff : APMC0D0D:00
1f2a0000-1f31ffff : APMC0D06:00
1f500000-1f50ffff : PNP0A08:00
78800000-78800fff : APMC0D13:00
  78800000-78800fff : APMC0D12:03
    78800000-78800fff : APMC0D12:02
      78800000-78800fff : APMC0D12:01
        78800000-78800fff : APMC0D12:00
          78800000-78800fff : APMC0D11:00
          78800000-78800fff : APMC0D10:03
          78800000-78800fff : APMC0D10:02
          78800000-78800fff : APMC0D10:01
          78800000-78800fff : APMC0D10:00
79000000-798fffff : APMC0D0E:00
7c000000-7c1fffff : APMC0D12:00
7c200000-7c3fffff : APMC0D12:01
7c400000-7c5fffff : APMC0D12:02
7c600000-7c7fffff : APMC0D12:03
7e000000-7e000fff : APMC0D13:00
7e200000-7e200fff : APMC0D10:03
  7e200000-7e200fff : APMC0D10:02
    7e200000-7e200fff : APMC0D10:01
      7e200000-7e200fff : APMC0D10:00
7e600000-7e600fff : APMC0D11:00
7e700000-7e700fff : APMC0D10:03
  7e700000-7e700fff : APMC0D10:02
    7e700000-7e700fff : APMC0D10:01
      7e700000-7e700fff : APMC0D10:00
7e720000-7e720fff : APMC0D10:03
  7e720000-7e720fff : APMC0D10:02
    7e720000-7e720fff : APMC0D10:01
      7e720000-7e720fff : APMC0D10:00
7e800000-7e800fff : APMC0D10:00
7e840000-7e840fff : APMC0D10:01
7e880000-7e880fff : APMC0D10:02
7e8c0000-7e8c0fff : APMC0D10:03
7e930000-7e930fff : APMC0D13:00
4000000000-4001ffffff : System RAM
  4000080000-4000c3ffff : Kernel code
  4000db0000-400165ffff : Kernel data
40023a0000-4ff733ffff : System RAM
4ff7340000-4ff77cffff : reserved
4ff77d0000-4ff79cffff : System RAM
4ff79d0000-4ff7e7ffff : reserved
4ff7e80000-4ff7e8ffff : System RAM
4ff7e90000-4ff7efffff : reserved
4ff7f10000-4ff800ffff : reserved
4ff8010000-4fffffffff : System RAM
a020000000-a03fffffff : PCI Bus 0000:00
  a020000000-a0201fffff : PCI Bus 0000:01
    a020000000-a0200fffff : 0000:01:00.0
      a020000000-a0200fffff : mlx4_core
    a020100000-a0201fffff : 0000:01:00.0
a060000000-a07fffffff : PCI Bus 0000:00
a0d0000000-a0dfffffff : PCI ECAM
a110000000-a14fffffff : PCI Bus 0000:00
  a110000000-a121ffffff : PCI Bus 0000:01
    a110000000-a111ffffff : 0000:01:00.0
      a110000000-a111ffffff : mlx4_core
    a112000000-a121ffffff : 0000:01:00.0

Tested-by: Jon Masters <jcm@redhat.com>

-- 
Computer Architect | Sent from my Fedora powered laptop
