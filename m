Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
Subject: Re: [PATCH v2 2/5] PCI: iproc: Fix up corrupted PAXC root complex
 config registers
To: poza@codeaurora.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 linux-pci-owner@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-3-git-send-email-ray.jui@broadcom.com>
 <2bafb8ae70029279a1849fb68a020d18@codeaurora.org>
 <1f059e9b5ebeabf6f5a7e11a134221ae@codeaurora.org>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <330f9f0d-761a-706b-2a58-2ae15f2e0105@broadcom.com>
Date: Tue, 12 Jun 2018 09:56:46 -0700
MIME-Version: 1.0
In-Reply-To: <1f059e9b5ebeabf6f5a7e11a134221ae@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 6/12/2018 5:23 AM, poza@codeaurora.org wrote:
> On 2018-06-12 13:57, poza@codeaurora.org wrote:
>> On 2018-06-12 05:51, Ray Jui wrote:
>>> On certain versions of Broadcom PAXC based root complexes, certain
>>> regions of the configuration space are corrupted. As a result, it
>>> prevents the Linux PCIe stack from traversing the linked list of the
>>> capability registers completely and therefore the root complex is
>>> not advertised as "PCIe capable". This prevents the correct PCIe RID
>>> from being parsed in the kernel PCIe stack. A correct RID is required
>>> for mapping to a stream ID from the SMMU or the device ID from the
>>> GICv3 ITS
>>>
>>> This patch fixes up the issue by manually populating the related
>>> PCIe capabilities
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> ---
>>>  drivers/pci/host/pcie-iproc.c | 65 
>>> +++++++++++++++++++++++++++++++++++++++----
>>>  drivers/pci/host/pcie-iproc.h |  3 ++
>>>  2 files changed, 62 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-iproc.c 
>>> b/drivers/pci/host/pcie-iproc.c
>>> index 3c76c5f..680f6b1 100644
>>> --- a/drivers/pci/host/pcie-iproc.c
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>> @@ -85,6 +85,8 @@
>>>  #define IMAP_VALID_SHIFT        0
>>>  #define IMAP_VALID            BIT(IMAP_VALID_SHIFT)
>>>
>>> +#define IPROC_PCI_PM_CAP        0x48
>>> +#define IPROC_PCI_PM_CAP_MASK        0xffff
>>>  #define IPROC_PCI_EXP_CAP        0xac
>>>
>>>  #define IPROC_PCIE_REG_INVALID        0xffff
>>> @@ -375,6 +377,17 @@ static const u16 iproc_pcie_reg_paxc_v2[] = {
>>>      [IPROC_PCIE_CFG_DATA]        = 0x1fc,
>>>  };
>>>
>>> +/*
>>> + * List of device IDs of controllers that have corrupted capability 
>>> list that
>>> + * require SW fixup
>>> + */
>>> +static const u16 iproc_pcie_corrupt_cap_did[] = {
>>> +    0x16cd,
>>> +    0x16f0,
>>> +    0xd802,
>>> +    0xd804
>>> +};
>>> +
>>>  static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
>>>  {
>>>      struct iproc_pcie *pcie = bus->sysdata;
>>> @@ -495,6 +508,49 @@ static unsigned int iproc_pcie_cfg_retry(void
>>> __iomem *cfg_data_p)
>>>      return data;
>>>  }
>>>
>>> +static void iproc_pcie_fix_cap(struct iproc_pcie *pcie, int where, 
>>> u32 *val)
>>> +{
>>> +    u32 i, dev_id;
>>> +
>>> +    switch (where & ~0x3) {
>>> +    case PCI_VENDOR_ID:
>>> +        dev_id = *val >> 16;
>>> +
>>> +        /*
>>> +         * Activate fixup for those controllers that have corrupted
>>> +         * capability list registers
>>> +         */
>>> +        for (i = 0; i < ARRAY_SIZE(iproc_pcie_corrupt_cap_did); i++)
>>> +            if (dev_id == iproc_pcie_corrupt_cap_did[i])
>>> +                pcie->fix_paxc_cap = true;
>>
>> and I think this code will try to fix up every time config space is read.
>> Does this get corrupted often, randomly ?
>> Can it not be solved by using one time Quirk ?
>> and if not Quirk, you dont want to be setting pcie->fix_paxc_cap =
>> false somewhere
>>
>> besides, pcie->fix_paxc_cap = true; is set if PCI_VENDOR_ID is read 
>> first.
>> and rest cases stay with the assumption that PCI_VENDOR_ID will be 
>> read first.
>> which is infact read first during enumeration
>> (that is the assumption code is making), but that is safe assumption
>> to make I think.
>>
> 
> ok I see that Bjorn has suggested to fix it this way instead of Quirks.
> will just mark

Right, and there are benefits with this approach like Bjorn has 
explained. We now have consistent lspci and config dump output using 
this approach.

> 
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> 
>>> +        break;
>>> +
>>> +    case IPROC_PCI_PM_CAP:
>>> +        if (pcie->fix_paxc_cap) {
>>> +            /* advertise PM, force next capability to PCIe */
>>> +            *val &= ~IPROC_PCI_PM_CAP_MASK;
>>> +            *val |= IPROC_PCI_EXP_CAP << 8 | PCI_CAP_ID_PM;
>>> +        }
>>> +        break;
>>> +
>>> +    case IPROC_PCI_EXP_CAP:
>>> +        if (pcie->fix_paxc_cap) {
>>> +            /* advertise root port, version 2, terminate here */
>>> +            *val = (PCI_EXP_TYPE_ROOT_PORT << 4 | 2) << 16 |
>>> +                PCI_CAP_ID_EXP;
>>> +        }
>>> +        break;
>>> +
>>> +    case IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL:
>>> +        /* Don't advertise CRS SV support */
>>> +        *val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
>>> +        break;
>>> +
>>> +    default:
>>> +        break;
>>> +    }
>>> +}
>>> +
>>>  static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int 
>>> devfn,
>>>                    int where, int size, u32 *val)
>>>  {
>>> @@ -509,13 +565,10 @@ static int iproc_pcie_config_read(struct pci_bus
>>> *bus, unsigned int devfn,
>>>      /* root complex access */
>>>      if (busno == 0) {
>>>          ret = pci_generic_config_read32(bus, devfn, where, size, val);
>>> -        if (ret != PCIBIOS_SUCCESSFUL)
>>> -            return ret;
>>> +        if (ret == PCIBIOS_SUCCESSFUL)
>>> +            iproc_pcie_fix_cap(pcie, where, val);
>>>
>>> -        /* Don't advertise CRS SV support */
>>> -        if ((where & ~0x3) == IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL)
>>> -            *val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
>>> -        return PCIBIOS_SUCCESSFUL;
>>> +        return ret;
>>>      }
>>>
>>>      cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, 
>>> where);
>>> diff --git a/drivers/pci/host/pcie-iproc.h 
>>> b/drivers/pci/host/pcie-iproc.h
>>> index 814b600..9d5cfee 100644
>>> --- a/drivers/pci/host/pcie-iproc.h
>>> +++ b/drivers/pci/host/pcie-iproc.h
>>> @@ -60,6 +60,8 @@ struct iproc_msi;
>>>   * @ep_is_internal: indicates an internal emulated endpoint device 
>>> is connected
>>>   * @has_apb_err_disable: indicates the controller can be configured 
>>> to prevent
>>>   * unsupported request from being forwarded as an APB bus error
>>> + * @fix_paxc_cap: indicates the controller has corrupted capability 
>>> list in its
>>> + * config space registers and requires SW based fixup
>>>   *
>>>   * @need_ob_cfg: indicates SW needs to configure the outbound 
>>> mapping window
>>>   * @ob: outbound mapping related parameters
>>> @@ -85,6 +87,7 @@ struct iproc_pcie {
>>>      int (*map_irq)(const struct pci_dev *, u8, u8);
>>>      bool ep_is_internal;
>>>      bool has_apb_err_disable;
>>> +    bool fix_paxc_cap;
>>>
>>>      bool need_ob_cfg;
>>>      struct iproc_pcie_ob ob;
