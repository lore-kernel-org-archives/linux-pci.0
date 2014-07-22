Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:44676 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaGVNwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jul 2014 09:52:01 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so9548170oac.22
        for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2014 06:52:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53CDE926.4010802@infradead.org>
References: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140722023813.GA27601@google.com> <53CDE926.4010802@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 22 Jul 2014 07:51:40 -0600
Message-ID: <CAErSpo6zOkjU0ELH-NQQL-rvjnG2L7B6963eOFbpPpEOgNUV6Q@mail.gmail.com>
Subject: Re: [PATCH] Fix build warnings in aer.h
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Chen Gong <gong.chen@linux.intel.com>,
	Lance Ortiz <lance.ortiz@hp.com>,
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 21, 2014 at 10:31 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 07/21/2014 07:38 PM, Bjorn Helgaas wrote:
>> [+cc Tuomas, Randy, Gavin, Gong, Lance, Tony]
>>
>> On Wed, Jul 16, 2014 at 04:08:44AM -0400, Mike Qiu wrote:
>>> build log:
>>>
>>> In file included from include/ras/ras_event.h:11:0,
>>>                  from drivers/ras/ras.c:13:
>>> include/linux/aer.h:42:129: warning: ‘struct pci_dev’
>>> declared inside parameter list [enabled by default]
>>>
>>> include/linux/aer.h:42:129: warning: its scope is only
>>> this definition or declaration, which is probably not
>>> what you want [enabled by default]
>>>
>>> include/linux/aer.h:46:130: warning: ‘struct pci_dev’
>>> declared inside parameter list [enabled by default]
>>>
>>> include/linux/aer.h:50:136: warning: ‘struct pci_dev’
>>> declared inside parameter list [enabled by default]
>>>
>>> include/linux/aer.h:57:14: warning: ‘struct pci_dev’
>>> declared inside parameter list [enabled by default]
>>>
>>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>>
>> OK, so the problem doesn't occur on x86 because there we have a struct
>> pci_dev declaration reached earlier via:
>>
>>   drivers/ras/ras.c
>>     include/ras/ras_event.h
>>       include/linux/edac.h
>>         include/linux/device.h
>>           include/linux/gfp.h
>>             arch/x86/include/asm/mmzone.h
>>               arch/x86/include/asm/mmzone_64.h
>>                 arch/x86/include/asm/smp.h
>>                   arch/x86/include/asm/mpspec.h
>>                     arch/x86/include/asm/x86_init.h
>>                       struct pci_dev;
>>       include/linux/aer.h
>>         ... pci_enable_pcie_error_reporting(struct pci_dev *dev);
>>
>> You're building powerpc, which doesn't have the same pci_dev
>> declaration in the arch header files, so you see the declaration
>> problem in aer.h.
>
> I get in on many i386 and x86_64 randconfig builds.... [checking]

Yeah, I should have said *an* x86 config doesn't see the problem.
There are lots of config variable involved in that path.

>> I could apply your fix, but it should go in v3.16 along with the commit
>> (0a2409aad38e ("trace, AER: Move trace into unified interface")) that
>> exposes the problem, and I'm leaving on vacation before I can get this
>> into -next, have it smoke-tested, and ask Linus to pull it.
>>
>> So you might want to ask Tony to put in his tree, since it looks like
>> he merged 0a2409aad38e in the first place.
>>
>> Please add these:
>>
>>   Fixes: 0a2409aad38e ("trace, AER: Move trace into unified interface")
>>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> I know 0a2409aad38e isn't actually *responsible* for the problem, but
>> anybody who backports 0a2409aad38e should pick up this fix as well.

Actually, since 0a2409aad38e is still in -next, the fix could be
merged first to avoid the bisection trap here.  But I don't know how
Tony feels about rebasing his branches.

Bjorn
