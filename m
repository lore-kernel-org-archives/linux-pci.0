Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] pci: adding support for PCI_MSI_IRQ_DOMAIN in ARC arch
To: Bjorn Helgaas <helgaas@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <fdd37b0b995d178fddb34fdbdb5daf5981822f52.1470757628.git.jpinto@synopsys.com>
 <20160906155739.GD1214@localhost>
CC: <Vineet.Gupta1@synopsys.com>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <a7b7c384-e559-85e5-cee0-11ff9906bbb1@synopsys.com>
Date: Tue, 6 Sep 2016 17:14:25 +0100
MIME-Version: 1.0
In-Reply-To: <20160906155739.GD1214@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 9/6/2016 4:57 PM, Bjorn Helgaas wrote:
> On Tue, Aug 09, 2016 at 04:49:37PM +0100, Joao Pinto wrote:
>> To fix this, this patch adds ARC as a PCI_MSI_IRQ_DOMAIN supportive
>> platform and adds the generation of msi.h in the ARC arch.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> 
> I added Vineet's ack and put this on pci/msi for v4.9, thanks!

Great! Thanks!

> 
>> ---
>>  arch/arc/include/asm/Kbuild | 1 +
>>  drivers/pci/Kconfig         | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
>> index 0b10ef2..c332604 100644
>> --- a/arch/arc/include/asm/Kbuild
>> +++ b/arch/arc/include/asm/Kbuild
>> @@ -25,6 +25,7 @@ generic-y += mcs_spinlock.h
>>  generic-y += mm-arch-hooks.h
>>  generic-y += mman.h
>>  generic-y += msgbuf.h
>> +generic-y += msi.h
>>  generic-y += param.h
>>  generic-y += parport.h
>>  generic-y += pci.h
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 67f9916..6555eb7 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -25,7 +25,7 @@ config PCI_MSI
>>  	   If you don't know what to do here, say Y.
>>  
>>  config PCI_MSI_IRQ_DOMAIN
>> -	def_bool ARM || ARM64 || X86
>> +	def_bool ARC || ARM || ARM64 || X86
>>  	depends on PCI_MSI
>>  	select GENERIC_MSI_IRQ_DOMAIN
>>  
>> -- 
>> 1.8.1.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
