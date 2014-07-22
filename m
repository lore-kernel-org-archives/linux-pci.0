Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54504 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbaGVEbi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jul 2014 00:31:38 -0400
Message-ID: <53CDE926.4010802@infradead.org>
Date: Mon, 21 Jul 2014 21:31:34 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mike Qiu <qiudayu@linux.vnet.ibm.com>
CC: linux-pci@vger.kernel.org,
	Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	gong.chen@linux.intel.com, Lance Ortiz <lance.ortiz@hp.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] Fix build warnings in aer.h
References: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com> <20140722023813.GA27601@google.com>
In-Reply-To: <20140722023813.GA27601@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/21/2014 07:38 PM, Bjorn Helgaas wrote:
> [+cc Tuomas, Randy, Gavin, Gong, Lance, Tony]
> 
> On Wed, Jul 16, 2014 at 04:08:44AM -0400, Mike Qiu wrote:
>> build log:
>>
>> In file included from include/ras/ras_event.h:11:0,
>>                  from drivers/ras/ras.c:13:
>> include/linux/aer.h:42:129: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> include/linux/aer.h:42:129: warning: its scope is only
>> this definition or declaration, which is probably not
>> what you want [enabled by default]
>>
>> include/linux/aer.h:46:130: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> include/linux/aer.h:50:136: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> include/linux/aer.h:57:14: warning: ‘struct pci_dev’
>> declared inside parameter list [enabled by default]
>>
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> 
> OK, so the problem doesn't occur on x86 because there we have a struct
> pci_dev declaration reached earlier via:
> 
>   drivers/ras/ras.c
>     include/ras/ras_event.h
>       include/linux/edac.h
>         include/linux/device.h
>           include/linux/gfp.h
>             arch/x86/include/asm/mmzone.h
>               arch/x86/include/asm/mmzone_64.h
>                 arch/x86/include/asm/smp.h
>                   arch/x86/include/asm/mpspec.h
>                     arch/x86/include/asm/x86_init.h
>                       struct pci_dev;
>       include/linux/aer.h
>         ... pci_enable_pcie_error_reporting(struct pci_dev *dev);
> 
> You're building powerpc, which doesn't have the same pci_dev
> declaration in the arch header files, so you see the declaration
> problem in aer.h.

I get in on many i386 and x86_64 randconfig builds.... [checking]

20140715: 2 of 10 i386 randconfig builds
20140716: 1 of 10 i386 randconfig builds
20140717: 2 of 10 i386 randconfig builds
20140718: 1 of 10 i386 randconfig builds

20140715: 3 of 10 x86_64 randconfig builds
20140716: 1 of 10 x86_64 randconfig builds
20140717: 1 of 10 x86_64 randconfig builds
20140718: 2 of 10 x86_64 randconfig builds
20140721: 1 of 10 x86_64 randconfig builds


> I could apply your fix, but it should go in v3.16 along with the commit
> (0a2409aad38e ("trace, AER: Move trace into unified interface")) that
> exposes the problem, and I'm leaving on vacation before I can get this
> into -next, have it smoke-tested, and ask Linus to pull it.
> 
> So you might want to ask Tony to put in his tree, since it looks like
> he merged 0a2409aad38e in the first place.
> 
> Please add these:
> 
>   Fixes: 0a2409aad38e ("trace, AER: Move trace into unified interface")
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I know 0a2409aad38e isn't actually *responsible* for the problem, but
> anybody who backports 0a2409aad38e should pick up this fix as well.
> 
> Lance, I added you because of an unrelated issue I noticed while reviewing
> this: you added the AER trace events with 1ca1d8d54f92 ("aerdrv: Trace
> Event for PCI Express Advanced Error Reporting"):
> 
>   +#define aer_correctable_errors         \
>   +       {BIT(0),        "Receiver Error"},              \
>   ...
> 
> I'd like to see all those "BIT(...)" things changed to use the #defines
> that already exist in include/uapi/linux/pci_regs.h, e.g.,
> PCI_ERR_COR_RCVR.  That way grep will find these uses, which will make
> maintenance easier.  There's no hurry about this part, of course.
> 
> Bjorn
> 
>> ---
>>  include/linux/aer.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 4dbaa70..c826d1c 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -11,6 +11,8 @@
>>  #define AER_FATAL                        1
>>  #define AER_CORRECTABLE                        2
>>  
>> +struct pci_dev;
>> +
>>  struct aer_header_log_regs {
>>          unsigned int dw0;
>>          unsigned int dw1;
>> -- 


-- 
~Randy
