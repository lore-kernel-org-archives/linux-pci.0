Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20160620171649.GA30267@red-moon>
References: <1466004851-10214-1-git-send-email-cov@codeaurora.org>
 <20160620171649.GA30267@red-moon>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 21 Jun 2016 10:37:27 +0200
Message-ID: <CAKv+Gu9epdO_OLt1KnmO2kwCM_hYCx_hCJ7c_c=AwB=OwExrFA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] ACPI/PCI: Check platform specific ECAM quirks
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Jeff Hugo <jhugo@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
 David Daney <ddaney@caviumnetworks.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Robert Richter <robert.richter@caviumnetworks.com>,
 Dongdong Liu <liudongdong3@huawei.com>, Mark Salter <msalter@redhat.com>,
 Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jayachandran C <jchandra@broadcom.com>, Duc Dang <dhdang@apm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 20 June 2016 at 19:16, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> [+ Ard, Arnd]
>
> On Wed, Jun 15, 2016 at 11:34:10AM -0400, Christopher Covington wrote:
>> From: Tomasz Nowicki <tn@semihalf.com>
>>
>> Some platforms may not be fully compliant with the generic PCI config
>> operations. For these cases we implement a way to use custom map and
>> accessor functions. The algorithm traverses the available quirk list,
>> matches against <oem_id, oem_table_id, oem_revision, domain, bus number>
>> tuples and returns corresponding PCI config ops. oem_id, oem_table_id, and
>> oem_revision come from the MCFG table standard header. All quirks can be
>> defined using the DECLARE_ACPI_MCFG_FIXUP() macro and are kept self
>> contained. Example:
>>
>> /* Custom PCI config ops */
>> static struct pci_generic_ecam_ops foo_pci_ops = {
>>       .bus_shift      = 24,
>>       .pci_ops = {
>>               .map_bus = pci_ecam_map_bus,
>>               .read = foo_ecam_config_read,
>>               .write = foo_ecam_config_write,
>>       }
>> };
>>
>> DECLARE_ACPI_MCFG_FIXUP(&foo_pci_ops, "OEM", "TABLE-ID", <revision>,
>>                       <domain_nr>, <bus_nr>);
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>>
>> ---
>>
>> Changes from v2 to v3:
>> * Match against all three of oem_id, oem_table_id, and oem_revision.
>> * Perform substring match, so padding oem_id and oem_table_id isn't
>>   required. (Using min_t() thanks to Duc Dang's suggestion.)
>> * Print when quirk matched.
>> * Use __UNIQUE_ID() macro to generate a valid, unique symbol name even
>>   when OEM and table IDs contain characters such as dash "-".
>> * Move extern declaration to header and fix spelling and formatting to
>>   satisfy checkpatch/coding style.
>> ---
>>  drivers/acpi/pci_mcfg.c           | 49 ++++++++++++++++++++++++++++++++++++---
>>  include/asm-generic/vmlinux.lds.h |  7 ++++++
>>  include/linux/pci-acpi.h          | 24 +++++++++++++++++++
>>  3 files changed, 77 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index b5b376e..2a5d3dd 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -22,6 +22,10 @@
>>  #include <linux/kernel.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-acpi.h>
>> +#include <linux/pci-ecam.h>
>> +
>> +/* Root pointer to the mapped MCFG table */
>> +static struct acpi_table_mcfg *mcfg_table;
>>
>>  /* Structure to hold entries from the MCFG table */
>>  struct mcfg_entry {
>> @@ -35,6 +39,46 @@ struct mcfg_entry {
>>  /* List to save MCFG entries */
>>  static LIST_HEAD(pci_mcfg_list);
>>
>> +static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
>> +                              struct acpi_table_header *h)
>> +{
>> +     int olen = min_t(u8, strlen(f->oem_id), ACPI_OEM_ID_SIZE);
>> +     int tlen = min_t(u8, strlen(f->oem_table_id), ACPI_OEM_TABLE_ID_SIZE);
>> +
>> +     return (!strncmp(f->oem_id, h->oem_id, olen) &&
>> +             !strncmp(f->oem_table_id, h->oem_table_id, tlen) &&
>> +             f->oem_revision == h->oem_revision);
>> +}
>> +
>> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
>> +{
>> +     int bus_num = root->secondary.start;
>> +     int domain = root->segment;
>> +     struct pci_cfg_fixup *f;
>> +
>> +     if (!mcfg_table)
>> +             return &pci_generic_ecam_ops;
>> +
>> +     /*
>> +      * Match against platform specific quirks and return corresponding CAM
>> +      * ops.
>> +      *
>> +      * First match against PCI topology <domain:bus> then use OEM ID, OEM
>> +      * table ID, and OEM revision from MCFG table standard header.
>> +      */
>> +     for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
>> +             if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
>> +                 (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
>> +                 pci_mcfg_fixup_match(f, &mcfg_table->header)) {
>> +                     pr_info("Handling %s %s r%d PCI MCFG quirks\n",
>> +                             f->oem_id, f->oem_table_id, f->oem_revision);
>> +                     return f->ops;
>> +             }
>> +     }
>> +     /* No quirks, use ECAM */
>> +     return &pci_generic_ecam_ops;
>> +}
>> +
>>  phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
>>  {
>>       struct mcfg_entry *e;
>> @@ -54,7 +98,6 @@ phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
>>
>>  static __init int pci_mcfg_parse(struct acpi_table_header *header)
>>  {
>> -     struct acpi_table_mcfg *mcfg;
>>       struct acpi_mcfg_allocation *mptr;
>>       struct mcfg_entry *e, *arr;
>>       int i, n;
>> @@ -64,8 +107,8 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
>>
>>       n = (header->length - sizeof(struct acpi_table_mcfg)) /
>>                                       sizeof(struct acpi_mcfg_allocation);
>> -     mcfg = (struct acpi_table_mcfg *)header;
>> -     mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
>> +     mcfg_table = (struct acpi_table_mcfg *)header;
>> +     mptr = (struct acpi_mcfg_allocation *) &mcfg_table[1];
>>
>>       arr = kcalloc(n, sizeof(*arr), GFP_KERNEL);
>>       if (!arr)
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 6a67ab9..43604fc 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -300,6 +300,13 @@
>>               VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;      \
>>       }                                                               \
>>                                                                       \
>> +     /* ACPI MCFG quirks */                                          \
>> +     .acpi_fixup        : AT(ADDR(.acpi_fixup) - LOAD_OFFSET) {      \
>> +             VMLINUX_SYMBOL(__start_acpi_mcfg_fixups) = .;           \
>> +             *(.acpi_fixup_mcfg)                                     \
>> +             VMLINUX_SYMBOL(__end_acpi_mcfg_fixups) = .;             \
>> +     }                                                               \
>> +                                                                     \
>>       /* Built-in firmware blobs */                                   \
>>       .builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {      \
>>               VMLINUX_SYMBOL(__start_builtin_fw) = .;                 \
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 7d63a66..dac851b 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -25,6 +25,7 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
>>  extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
>>
>>  extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_res);
>> +extern struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root);
>>
>>  static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
>>  {
>> @@ -72,6 +73,29 @@ struct acpi_pci_root_ops {
>>       int (*prepare_resources)(struct acpi_pci_root_info *info);
>>  };
>>
>> +struct pci_cfg_fixup {
>> +     struct pci_ecam_ops *ops;
>> +     char *oem_id;
>> +     char *oem_table_id;
>> +     u32 oem_revision;
>> +     int domain;
>> +     int bus_num;
>> +};
>> +
>> +extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
>> +extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
>> +
>> +#define PCI_MCFG_DOMAIN_ANY  -1
>> +#define PCI_MCFG_BUS_ANY     -1
>> +
>> +/* Designate a routine to fix up buggy MCFG */
>> +#define DECLARE_ACPI_MCFG_FIXUP(ops, oem, table, rev, dom, bus)      \
>> +     static const struct pci_cfg_fixup                       \
>> +     __UNIQUE_ID(mcfg_fixup_)                                \
>> +     __used  __attribute__((__section__(".acpi_fixup_mcfg"), \
>> +                             aligned((sizeof(void *))))) =   \
>> +     { ops, oem, table, rev, dom, bus }
>> +
>
> Ok, a couple of comments on this quirks handling mechanism.
>
> Given that it is supposed to be just a temporary workaround for
> 1st generation non-ECAM-compliant platforms, the same mechanism
> can be implemented through a static array of hooks, that, through
> the same MCFG matching mechanism, initialize the pci_ops for
> the given platform.
>
> Furthermore, I suspect we do not even need a way to pass the
> non-ECAM compliant config space resources to the OS (ie we can't
> change FW anymore anyway in some platforms) so the quirks hooks
> are likely to hardcode the required config space addresses for
> the respective MCFG match.
>

As discussed off-list, I strongly second the idea to have a static
quirks array for hardware/firmware combos that are currently in the
pipeline, and for which we need special handling in software to be
able to drive them at all. This should be based on exact OEM table/rev
id matches, and contain all supplementary information required to
implement the quirk in the kernel source code. Anything that could
potentially be used to 'cheat', e.g., an OEM id triggering a substring
match on a platform that we currently don't know about, or things like
_DSD properties to parametrize the quirks implementation are out of
the question IMO

> It should be easier to implement (provided we find a place where
> to add this static array of hooks matching MCFG, I suspect it is
> going to be a file in drivers/pci/host but Tomasz and I need
> input on that) and prevent abuse (since it is a static array of
> hooks in a single place, it is easier to manage than section
> entries).
>
> Either that or we keep the section entry linker script approach
> this series implements, which means that the quirks handling hook
> will be added to a specific section instead of a static array,
> I see no other option.
>

I know __weak functions are unpopular, but in this case, having a
__weak empty function in the MCFG/ECAM core code, and overriding it in
arch/arm64/xxx/mcfg-quirks.c does not sound unreasonable to me.

> Last but not least, the MCFG table must not contain any region
> that is not ECAM compliant, I understand we need quirks but
> we must not abuse a standard table to provide the OS resources
> that are really not ECAM compliant when they are supposed to be.
>
> Tomasz will post a follow-up patch to this series implementing
> the above, if you have any comments/concerns/questions or you see
> anything wrong with what I say above please do chime in.
>
> Thanks !
> Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
