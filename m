Return-Path: <linux-arch-owner@vger.kernel.org>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-10-git-send-email-wangyijing@huawei.com> <540993B3.1000701@cogentembedded.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <540993B3.1000701@cogentembedded.com>
Content-Type: text/plain;
	charset=gb2312
Message-Id: <58C2E84C-7080-4FDA-8684-5D0B2DAD7C20@gmail.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"arnab.basu@freescale.com" <arnab.basu@freescale.com>,
	"Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>,
	"x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Tony Luck <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Chris Metcalf <cmetcalf@tilera.com>,
	Ralf Baechle <ralf@linux-mips.org>
From: wangyijing <wangyijing0307@gmail.com>
Subject: Re: [PATCH v1 09/21] Irq_remapping/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Date: Fri, 5 Sep 2014 19:30:01 +0800
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> 在 2014年9月5日，18:42，Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> 写道：
> 
> Hello.
> 
>> On 9/5/2014 2:09 PM, Yijing Wang wrote:
>> 
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/iommu/irq_remapping.c |    8 +++++++-
>>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
>> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
>> index 33c4395..e75026e 100644
>> --- a/drivers/iommu/irq_remapping.c
>> +++ b/drivers/iommu/irq_remapping.c
> [...]
>> @@ -165,9 +170,10 @@ static void __init irq_remapping_modify_x86_ops(void)
>>      x86_io_apic_ops.set_affinity    = set_remapped_irq_affinity;
>>      x86_io_apic_ops.setup_entry    = setup_ioapic_remapped_entry;
>>      x86_io_apic_ops.eoi_ioapic_pin    = eoi_ioapic_pin_remapped;
>> -    x86_msi.setup_msi_irqs        = irq_remapping_setup_msi_irqs;
>> +    x86_msi.setup_msi_irqs          = irq_remapping_setup_msi_irqs;
> 
>   AFAICS, this change only converts tabs to spaces, so not needed at all.

Will update,  thanks.

> 
>>      x86_msi.setup_hpet_msi        = setup_hpet_msi_remapped;
>>      x86_msi.compose_msi_msg        = compose_remapped_msi_msg;
>> +    x86_msi_chip = &remap_msi_chip;
> 
>   Please align = with the rest of assignments.

Ok.

Thanks!
Yijing.

> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
