Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <d0467282-a44a-bd1e-e449-0bba953c4cfd@broadcom.com>
References: <20171007120851.20230-1-sbodomerle@gmail.com>
 <d0467282-a44a-bd1e-e449-0bba953c4cfd@broadcom.com>
From: Sandor Bodo-Merle <sbodomerle@gmail.com>
Date: Wed, 11 Oct 2017 10:26:39 +0200
Message-ID: <CABLWAfR+Nk85wurWnPArpmFPXVhxn0jZ+7H13WnKEPCMJVU0XA@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Allow allocation of multiple MSIs
To: Ray Jui <ray.jui@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, Bodo-Merle Sandor <esndbod@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ray,

we tested on a custom board based on BCM56260. SMP affinity was not
tested as our board runs on a single core.

br,

Sandor

ps - sorry for the duplicate, but by default gmail sent out html
formatted mail :(

On Tue, Oct 10, 2017 at 8:09 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> Hi Bodo,
>
>
> On 10/7/2017 5:08 AM, Bodo-Merle Sandor wrote:
>>
>> From: Sandor Bodo-Merle <sbodomerle@gmail.com>
>>
>> Add support for allocating multiple MSIs at the same time, so that the
>> MSI_FLAG_MULTI_PCI_MSI flag can be added to the msi_domain_info
>> structure.
>>
>> Avoid storing the hwirq in the low 5 bits of the message data, as it is
>> used by the device. Also fix an endianness problem by using readl().
>>
>> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
>> ---
>>   drivers/pci/host/pcie-iproc-msi.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc-msi.c
>> b/drivers/pci/host/pcie-iproc-msi.c
>> index 2d0f535a2f69..990fc906d73d 100644
>> --- a/drivers/pci/host/pcie-iproc-msi.c
>> +++ b/drivers/pci/host/pcie-iproc-msi.c
>> @@ -179,7 +179,7 @@ static struct irq_chip iproc_msi_irq_chip = {
>>     static struct msi_domain_info iproc_msi_domain_info = {
>>         .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> -               MSI_FLAG_PCI_MSIX,
>> +               MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
>>         .chip = &iproc_msi_irq_chip,
>>   };
>>   @@ -237,7 +237,7 @@ static void iproc_msi_irq_compose_msi_msg(struct
>> irq_data *data,
>>         addr = msi->msi_addr + iproc_msi_addr_offset(msi, data->hwirq);
>>         msg->address_lo = lower_32_bits(addr);
>>         msg->address_hi = upper_32_bits(addr);
>> -       msg->data = data->hwirq;
>> +       msg->data = data->hwirq << 5; >   }
>>     static struct irq_chip iproc_msi_bottom_irq_chip = {
>> @@ -251,7 +251,7 @@ static int iproc_msi_irq_domain_alloc(struct
>> irq_domain *domain,
>>                                       void *args)
>>   {
>>         struct iproc_msi *msi = domain->host_data;
>> -       int hwirq;
>> +       int hwirq, i;
>>         mutex_lock(&msi->bitmap_lock);
>>   @@ -267,10 +267,14 @@ static int iproc_msi_irq_domain_alloc(struct
>> irq_domain *domain,
>>         mutex_unlock(&msi->bitmap_lock);
>>   -     irq_domain_set_info(domain, virq, hwirq,
>> &iproc_msi_bottom_irq_chip,
>> -                           domain->host_data, handle_simple_irq, NULL,
>> NULL);
>> +       for (i = 0; i < nr_irqs; i++) {
>> +               irq_domain_set_info(domain, virq + i, hwirq + i,
>> +                                   &iproc_msi_bottom_irq_chip,
>> +                                   domain->host_data, handle_simple_irq,
>> +                                   NULL, NULL);
>> +       }
>>   -     return 0;
>> +       return hwirq;
>>   }
>>     static void iproc_msi_irq_domain_free(struct irq_domain *domain,
>> @@ -302,7 +306,8 @@ static inline u32 decode_msi_hwirq(struct iproc_msi
>> *msi, u32 eq, u32 head)
>>         offs = iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
>>         msg = (u32 *)(msi->eq_cpu + offs);
>> -       hwirq = *msg & IPROC_MSI_EQ_MASK;
>> +       hwirq = readl(msg);
>> +       hwirq = (hwirq >> 5) + (hwirq & 0x1f);
>>         /*
>>          * Since we have multiple hwirq mapped to a single MSI vector,nnn
>>
>
> Change looks okay to me in general. May I know which platform you tested
> this patch on and was SMP affinity configuration tested?
>
> Thanks,
>
> Ray

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
