Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
To: Dongdong Liu <liudongdong3@huawei.com>, Duc Dang <dhdang@apm.com>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <575ED57F.6050503@codeaurora.org>
 <CADaLNDkfKxxXWmG3eAawH1H=B+4ia6ZYh41anjTuOdTWGbhfNg@mail.gmail.com>
 <575F9B4D.8080501@huawei.com>
 <CADaLND=esW9rwrfdKtAvkyPhCs4F9hMH9LDY4DWTpOv0ZgoT9w@mail.gmail.com>
 <575FD253.3070508@huawei.com>
Cc: Christopher Covington <cov@codeaurora.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org,
 Jayachandran C <jchandra@broadcom.com>, robert.richter@caviumnetworks.com,
 Marcin Wojtas <mw@semihalf.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
 David Daney <ddaney@caviumnetworks.com>, Yijing Wang
 <wangyijing@huawei.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 linux-acpi@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>,
 Andrea Gallo <andrea.gallo@linaro.org>, jeremy.linton@arm.com,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Chenxin (Charles)" <charles.chenxin@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, "liudong-1989@163.com" <liudong-1989@163.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <575FEFF1.9020105@semihalf.com>
Date: Tue, 14 Jun 2016 13:52:17 +0200
MIME-Version: 1.0
In-Reply-To: <575FD253.3070508@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 14.06.2016 11:45, Dongdong Liu wrote:
> Hi Duc
>
> 在 2016/6/14 17:00, Duc Dang 写道:
>> On Mon, Jun 13, 2016 at 10:51 PM, Dongdong Liu
>> <liudongdong3@huawei.com> wrote:
>>> Hi Duc
>>>
>>> 在 2016/6/14 4:57, Duc Dang 写道:
>>>>
>>>> On Mon, Jun 13, 2016 at 8:47 AM, Christopher Covington
>>>> <cov@codeaurora.org> wrote:
>>>>>
>>>>> Hi Dongdong,
>>>>>
>>>>> On 06/13/2016 09:02 AM, Dongdong Liu wrote:
>>>>>>
>>>>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>>>>> index d3c3e85..49612b3 100644
>>>>>> --- a/drivers/acpi/pci_mcfg.c
>>>>>> +++ b/drivers/acpi/pci_mcfg.c
>>>>>> @@ -22,6 +22,10 @@
>>>>>>    #include <linux/kernel.h>
>>>>>>    #include <linux/pci.h>
>>>>>>    #include <linux/pci-acpi.h>
>>>>>> +#include <linux/pci-ecam.h>
>>>>>> +
>>>>>> +/* Root pointer to the mapped MCFG table */
>>>>>> +static struct acpi_table_mcfg *mcfg_table;
>>>>>>
>>>>>>    /* Structure to hold entries from the MCFG table */
>>>>>>    struct mcfg_entry {
>>>>>> @@ -35,6 +39,38 @@ struct mcfg_entry {
>>>>>>    /* List to save mcfg entries */
>>>>>>    static LIST_HEAD(pci_mcfg_list);
>>>>>>
>>>>>> +extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
>>>>>> +extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
>>>>>> +
>>>>>> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
>>>>>> +{
>>>>>> +     int bus_num = root->secondary.start;
>>>>>> +     int domain = root->segment;
>>>>>> +     struct pci_cfg_fixup *f;
>>>>>> +
>>>>>> +     if (!mcfg_table)
>>>>>> +             return &pci_generic_ecam_ops;
>>>>>> +
>>>>>> +     /*
>>>>>> +      * Match against platform specific quirks and return
>>>>>> corresponding
>>>>>> +      * CAM ops.
>>>>>> +      *
>>>>>> +      * First match against PCI topology <domain:bus> then use
>>>>>> OEM ID
>>>>>> and
>>>>>> +      * OEM revision from MCFG table standard header.
>>>>>> +      */
>>>>>> +     for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups;
>>>>>> f++) {
>>>>>> +             if ((f->domain == domain || f->domain ==
>>>>>> PCI_MCFG_DOMAIN_ANY) &&
>>>>>> +                 (f->bus_num == bus_num || f->bus_num ==
>>>>>> PCI_MCFG_BUS_ANY) &&
>>>>>> +                 (!strncmp(f->oem_id, mcfg_table->header.oem_id,
>>>>>> +                           ACPI_OEM_ID_SIZE)) &&
>>>>>> +                 (!strncmp(f->oem_table_id,
>>>>>> mcfg_table->header.oem_table_id,
>>>>>> +                           ACPI_OEM_TABLE_ID_SIZE)))
>>>>>
>>>>>
>>>>> This would just be a small convenience, but if the character count
>>>>> used
>>>>> here were
>>>>>
>>>>> min(strlen(f->oem_id), ACPI_OEM_ID_SIZE)
>>>>>
>>>>> then the parameters to DECLARE_ACPI_MCFG_FIXUP macro could be
>>>>> substrings
>>>>> and
>>>>> wouldn't need to be padded out to the full length.
>>>>>
>>>>>> +                     return f->ops;
>>>>>> +     }
>>>>>> +     /* No quirks, use ECAM */
>>>>>> +     return &pci_generic_ecam_ops;
>>>>>> +}
>>>>>
>>>>>
>>>>>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>>>>>> index 7d63a66..088a1da 100644
>>>>>> --- a/include/linux/pci-acpi.h
>>>>>> +++ b/include/linux/pci-acpi.h
>>>>>> @@ -25,6 +25,7 @@ static inline acpi_status
>>>>>> pci_acpi_remove_pm_notifier(struct acpi_device *dev)
>>>>>>    extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle
>>>>>> handle);
>>>>>>
>>>>>>    extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource
>>>>>> *bus_res);
>>>>>> +extern struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root
>>>>>> *root);
>>>>>>
>>>>>>    static inline acpi_handle acpi_find_root_bridge_handle(struct
>>>>>> pci_dev
>>>>>> *pdev)
>>>>>>    {
>>>>>> @@ -72,6 +73,25 @@ struct acpi_pci_root_ops {
>>>>>>         int (*prepare_resources)(struct acpi_pci_root_info *info);
>>>>>>    };
>>>>>>
>>>>>> +struct pci_cfg_fixup {
>>>>>> +     struct pci_ecam_ops *ops;
>>>>>> +     char *oem_id;
>>>>>> +     char *oem_table_id;
>>>>>> +     int domain;
>>>>>> +     int bus_num;
>>>>>> +};
>>>>>> +
>>>>>> +#define PCI_MCFG_DOMAIN_ANY  -1
>>>>>> +#define PCI_MCFG_BUS_ANY     -1
>>>>>> +
>>>>>> +/* Designate a routine to fix up buggy MCFG */
>>>>>> +#define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, dom,
>>>>>> bus) \
>>>>>> +     static const struct
>>>>>> pci_cfg_fixup                               \
>>>>>> +
>>>>>> __mcfg_fixup_##oem_id##oem_table_id##dom##bus                   \
>>>>>
>>>>>
>>>>> I'm not entirely sure that this is the right fix--I'm pretty blindly
>>>>> following a GCC documentation suggestion [1]--but removing the
>>>>> first two
>>>>> preprocessor concatenation operators "##" solved the following build
>>>>> error
>>>>> for me.
>>>>>
>>>>> include/linux/pci-acpi.h:90:2: error: pasting "__mcfg_fixup_" and
>>>>> ""QCOM"" does not give a valid preprocessing token
>>>>>     __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
>>>>
>>>>
>>>> I think the problem is gcc is not happy with quoted string when
>>>> processing these tokens
>>>> (""QCOM"", the extra "" are added by gcc). So should we not concat
>>>> string tokens and
>>>> use the fixup definition in v1 of this RFC:
>>>> /* Designate a routine to fix up buggy MCFG */
>>>> #define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, rev, dom,
>>>> bus)             \
>>>>           static const struct pci_cfg_fixup
>>>> __mcfg_fixup_##system##dom##bus\
>>>>            __used
>>>> __attribute__((__section__(".acpi_fixup_mcfg"),         \
>>>>                                   aligned((sizeof(void *)))))
>>>> =           \
>>>>           { ops, oem_id, rev, dom, bus };
>>>
>>>
>>> V1 fixup exist the redefinition error when compiling mutiple
>>> DECLARE_ACPI_MCFG_FIXUP
>>> with the same PCI_MCFG_DOMAIN_ANY and PCI_MCFG_BUS_ANY.
>>>
>>> #define EFI_ACPI_HISI_OEM_ID "HISI"
>>> #define EFI_ACPI_HISI_D02_OEM_TABLE_ID "HISI-D02"
>>> #define EFI_ACPI_HISI_D03_OEM_TABLE_ID "HISI-D03"
>>>
>>> DECLARE_ACPI_MCFG_FIXUP(&hisi_pcie_ecam_ops, EFI_ACPI_HISI_OEM_ID,
>>>         EFI_ACPI_HISI_D02_OEM_TABLE_ID, PCI_MCFG_DOMAIN_ANY,
>>> PCI_MCFG_BUS_ANY);
>>>
>>> DECLARE_ACPI_MCFG_FIXUP(&hisi_pcie_ecam_ops, EFI_ACPI_HISI_OEM_ID,
>>>         EFI_ACPI_HISI_D03_OEM_TABLE_ID, PCI_MCFG_DOMAIN_ANY,
>>> PCI_MCFG_BUS_ANY);
>>>
>>> In file included from drivers/pci/host/pcie-hisi-acpi.c:15:0:
>>> include/linux/pci-acpi.h:98:43: error: redefinition of
>>> '__mcfg_fixup_systemPCI_MCFG_DOMAIN_ANYPCI_MCFG_BUS_ANY'
>>>           static const struct pci_cfg_fixup
>>> __mcfg_fixup_##system##dom##bus\
>>>                                             ^
>>> drivers/pci/host/pcie-hisi-acpi.c:215:1: note: in expansion of macro
>>> 'DECLARE_ACPI_MCFG_FIXUP'
>>>   DECLARE_ACPI_MCFG_FIXUP(&hisi_pcie_ecam_ops, EFI_ACPI_HISI_OEM_ID,
>>>   ^
>>> include/linux/pci-acpi.h:98:43: note: previous definition of
>>> '__mcfg_fixup_systemPCI_MCFG_DOMAIN_ANYPCI_MCFG_BUS_ANY' was here
>>>           static const struct pci_cfg_fixup
>>> __mcfg_fixup_##system##dom##bus\
>>>                                             ^
>>> drivers/pci/host/pcie-hisi-acpi.c:212:1: note: in expansion of macro
>>> 'DECLARE_ACPI_MCFG_FIXUP'
>>>
>>>
>>> V2 fixup can resolve the redefinition error, but need to use macro.
>>> We can see that the name of macro is not replace with it's value in
>>> "__mcfg_fixup_EFI_ACPI_HISI_OEM_IDEFI_ACPI_HISI_D03_OEM_TABLE_IDPCI_MCFG_DOMAIN_ANYPCI_MCFG_BUS_ANY".
>>>
>>>
>>> Any good idea is appreciated.
>> Hmmm.
>>
>> I was testing # op and using min_t to get the min-len when doing
>> strncmp similar to Chris' suggestion (using min_t avoids type
>> warnings)
>>
>> /* Designate a routine to fix up buggy MCFG */
>> #define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, rev, dom,
>> bus) \
>>          static const struct pci_cfg_fixup
>> __mcfg_fixup##oem_id##oem_table_id##rev##dom##bus\
>>           __used
>> __attribute__((__section__(".acpi_fixup_mcfg"),         \
>>                                  aligned((sizeof(void *)))))
>> =           \
>
>>          { ops, #oem_id, #oem_table_id, rev, dom, bus };
>
>
> This should change to { ops, oem_id, oem_table_id, rev, dom, bus };
> ‘#’ is not need.

Both solutions are OK.

1. This works when we use macros as OEM ID and OEM table ID:

#define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, rev, dom, bus)\
	static const struct pci_cfg_fixup				\
		__mcfg_fixup_##oem_id##oem_table_id##dom##bus		\
	 __used	__attribute__((__section__(".acpi_fixup_mcfg"),		\
				aligned((sizeof(void *))))) =		\
	{ ops, oem_id, oem_table_id, rev, dom, bus };

#define OEM_ID "XXXXXX"
#define OEM_TABLE_ID "YYYYYYYY"

DECLARE_ACPI_MCFG_FIXUP(&quirk_ops, OEM_ID, OEM_TABLE_ID, 1, 
PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);

2. This works w/o macro which means we need to define OEM ID and OEM as 
string w/o quotation marks:

#define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, rev, dom, bus)\
static const struct pci_cfg_fixup \
__mcfg_fixup_##oem_id##oem_table_id##dom##bus \
__used __attribute__((__section__(".acpi_fixup_mcfg"), \
aligned((sizeof(void *))))) = \
{ ops, #oem_id, #oem_table_id, rev, dom, bus };

DECLARE_ACPI_MCFG_FIXUP(&quirk_ops, XXXXXX, YYYYYYYY, 1, 
PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);

Personally I think that (2) is better, no need for macro definitions.
Tomasz
