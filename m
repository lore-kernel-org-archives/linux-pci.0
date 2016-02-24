Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56CDD767.6020103@arm.com>
References: <1455069384-22323-1-git-send-email-dhdang@apm.com>
 <1456330151.5681.46.camel@redhat.com> <56CDD767.6020103@arm.com>
From: Duc Dang <dhdang@apm.com>
Date: Wed, 24 Feb 2016 14:28:10 -0800
Message-ID: <CADaLND=mrkxOWOzcEb8os16Rb=SDHfnn_8eSgB4bQYH3UguS3w@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot
 for X-Gene v1
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Salter <msalter@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Feng Kan <fkan@apm.com>,
	linux-pci@vger.kernel.org, patches <patches@apm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Loc Ho <lho@apm.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 8:16 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 24/02/16 16:09, Mark Salter wrote:
>> On Tue, 2016-02-09 at 17:56 -0800, Duc Dang wrote:
>>> This patch makes pci-xgene-msi driver ACPI-aware and provides
>>> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
>>>
>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>> ---
>>>  drivers/pci/host/pci-xgene-msi.c | 35 ++++++++++++++++++++++++++++++++---
>>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
>>> index a6456b5..466aa93 100644
>>> --- a/drivers/pci/host/pci-xgene-msi.c
>>> +++ b/drivers/pci/host/pci-xgene-msi.c
>>> @@ -24,6 +24,7 @@
>>>  #include <linux/pci.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/of_pci.h>
>>> +#include <linux/acpi.h>
>>>
>>>  #define MSI_IR0                     0x000000
>>>  #define MSI_INT0            0x800000
>>> @@ -39,7 +40,7 @@ struct xgene_msi_group {
>>>  };
>>>
>>>  struct xgene_msi {
>>> -    struct device_node      *node;
>>> +    struct fwnode_handle    *fwnode;
>>>      struct irq_domain       *inner_domain;
>>>      struct irq_domain       *msi_domain;
>>>      u64                     msi_addr;
>>> @@ -249,6 +250,13 @@ static const struct irq_domain_ops msi_domain_ops = {
>>>      .free   = xgene_irq_domain_free,
>>>  };
>>>
>>> +#ifdef CONFIG_ACPI
>>> +static struct fwnode_handle *xgene_msi_get_fwnode(struct device *dev)
>>> +{
>>> +    return xgene_msi_ctrl.fwnode;
>>> +}
>>> +#endif
>>> +
>>>  static int xgene_allocate_domains(struct xgene_msi *msi)
>>>  {
>>>      msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
>>> @@ -256,7 +264,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
>>>      if (!msi->inner_domain)
>>>              return -ENOMEM;
>>>
>>> -    msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
>>> +    msi->msi_domain = pci_msi_create_irq_domain(msi->fwnode,
>>>                                                  &xgene_msi_domain_info,
>>>                                                  msi->inner_domain);
>>
>> This doesn't work for me (ACPI probing on Mustang) unless I change this
>> to be pci_msi_create_default_irq_domain(). The problem seems to be that
>> the MSI probe happens after the PCIe RC is probed so there is no MSI domain
>> at the time the PCIe root is initialized by ACPI.
>
> pci_msi_create_default_irq_domain is the wrong thing do use, specially
> if you have multiple MSI controllers in the system. I certainly wouldn't
> want to see it being used on arm64.
>
> This is the usual dependency hell. You try moving the probing earlier,
> but that may break something else in the process.

Hi Mark and Marc,

I have modified Tianocore firmware to have MSI node declared before
PCIe node in Dsdt table. With this modification, the MSI driver will
be loaded before PCIe driver and MSI domain is available at the time
PCIe root is initialized.

So we will need a UEFI firmware update to work with this patch.

Regards,
Duc Dang.

>
>         M.
> --
> Jazz is not dead. It just smells funny...
