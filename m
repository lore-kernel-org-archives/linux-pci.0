Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V6 2/5] PCI/ACPI: Check platform specific ECAM quirks
To: Duc Dang <dhdang@apm.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-3-git-send-email-tn@semihalf.com>
 <CADaLNDk0JPJYT_pqjWYwrMBvbyWkpL+6=dEDU9H9qDGMhnQvyw@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki
 <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>,
 Sinan Kaya <okaya@codeaurora.org>, Jayachandran C <jchandra@broadcom.com>,
 Christopher Covington <cov@codeaurora.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robert Richter <robert.richter@caviumnetworks.com>,
 Marcin Wojtas <mw@semihalf.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
 David Daney <ddaney@caviumnetworks.com>, Yijing Wang
 <wangyijing@huawei.com>, Mark Salter <msalter@redhat.com>,
 linux-pci@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>,
 linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>,
 Andrea Gallo <andrea.gallo@linaro.org>, jeremy.linton@arm.com,
 Dongdong Liu <liudongdong3@huawei.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jeffrey Hugo <jhugo@codeaurora.org>, linux-acpi@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5bb5d2c3-32b1-7d88-8376-dc3e77bb665e@semihalf.com>
Date: Tue, 13 Sep 2016 08:37:19 +0200
MIME-Version: 1.0
In-Reply-To: <CADaLNDk0JPJYT_pqjWYwrMBvbyWkpL+6=dEDU9H9qDGMhnQvyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 13.09.2016 00:24, Duc Dang wrote:
> On Fri, Sep 9, 2016 at 12:24 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>>
>> Some platforms may not be fully compliant with generic set of PCI config
>> accessors. For these cases we implement the way to overwrite CFG accessors
>> set and configuration space range.
>>
>> In first place pci_mcfg_parse() saves machine's IDs and revision number
>> (these come from MCFG header) in order to match against known quirk entries.
>> Then the algorithm traverses available quirk list (static array),
>> matches against <oem_id, oem_table_id, rev, domain, bus number range> and
>> returns custom PCI config ops and/or CFG resource structure.
>>
>> When adding new quirk there are two possibilities:
>> 1. Override default pci_generic_ecam_ops ops but CFG resource comes from MCFG
>> { "OEM_ID", "OEM_TABLE_ID", <REV>, <DOMAIN>, <BUS_NR>, &foo_ops, MCFG_RES_EMPTY },
>> 2. Override default pci_generic_ecam_ops ops and CFG resource. For this case
>> it is also allowed get CFG resource from quirk entry w/o having it in MCFG.
>> { "OEM_ID", "OEM_TABLE_ID", <REV>, <DOMAIN>, <BUS_NR>, &boo_ops,
>>   DEFINE_RES_MEM(START, SIZE) },
>>
>> pci_generic_ecam_ops and MCFG entries will be used for platforms
>> free from quirks.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  drivers/acpi/pci_mcfg.c | 80 +++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 74 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index ffcc651..2b8acc7 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -32,6 +32,59 @@ struct mcfg_entry {
>>         u8                      bus_start;
>>         u8                      bus_end;
>>  };
>> +struct mcfg_fixup {
>> +       char oem_id[ACPI_OEM_ID_SIZE + 1];
>> +       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>> +       u32 oem_revision;
>> +       u16 seg;
>> +       struct resource bus_range;
>> +       struct pci_ecam_ops *ops;
>> +       struct resource cfgres;
>> +};
>> +
>> +#define MCFG_DOM_ANY                   (-1)
>> +#define MCFG_BUS_RANGE(start, end)     DEFINE_RES_NAMED((start),       \
>> +                                               ((end) - (start) + 1),  \
>> +                                               NULL, IORESOURCE_BUS)
>> +#define MCFG_BUS_ANY           MCFG_BUS_RANGE(0x0, 0xff)
>> +#define MCFG_RES_EMPTY         DEFINE_RES_NAMED(0, 0, NULL, 0)
>> +
>> +static struct mcfg_fixup mcfg_quirks[] = {
>> +/*     { OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, cfgres, ops }, */
>> +};
>> +
>> +static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>> +static char mcfg_oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
>> +static u32 mcfg_oem_revision;
>> +
>> +static void pci_mcfg_match_quirks(struct acpi_pci_root *root,
>> +                                 struct resource *cfgres,
>> +                                 struct pci_ecam_ops **ecam_ops)
>> +{
>> +       struct mcfg_fixup *f;
>> +       int i;
>> +
>> +       /*
>> +        * First match against PCI topology <domain:bus> then use OEM ID, OEM
>> +        * table ID, and OEM revision from MCFG table standard header.
>> +        */
>> +       for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>> +               if (f->seg == root->segment &&
>
> Is dropping the comparison with MCFG_DOM_ANY intended? It is useful if
> all the controllers (segs) can use the same quirk (X-Gene case).

MCFG_DOM_ANY makes sense only if we want to use the same ops for segment 
range, but not for CFG range manipulation. So we can add MCFG_DOM_ANY 
back here in the hope it will be used properly.

Thanks,
Tomasz
