Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55949 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933782AbcIFLNg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2016 07:13:36 -0400
Subject: Re: [PATCH] pci: adding support for PCI_MSI_IRQ_DOMAIN in ARC arch
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
References: <fdd37b0b995d178fddb34fdbdb5daf5981822f52.1470757628.git.jpinto@synopsys.com>
 <64d6513b-13f1-953d-410b-a4aeea6908c3@synopsys.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <05c5bab3-77bf-9993-8661-49ca9f41a7ca@synopsys.com>
Date: Tue, 6 Sep 2016 12:05:20 +0100
MIME-Version: 1.0
In-Reply-To: <64d6513b-13f1-953d-410b-a4aeea6908c3@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
Did you have the chance to check this patch?

Thanks.

On 8/10/2016 6:55 PM, Vineet Gupta wrote:
> On 08/09/2016 08:51 AM, Joao Pinto wrote:
>> Due to the added dependency on PCI_MSI_IRQ_DOMAIN for all PCIe RC 
>> drivers, we were unable to build a RC solution for an ARC platform.
>>
>> To fix this, this patch adds ARC as a PCI_MSI_IRQ_DOMAIN supportive
>> platform and adds the generation of msi.h in the ARC arch.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> 
> LGTM - Bjorn I presume you will pick this up ?
> 
> -Vineet
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
> 
> 

