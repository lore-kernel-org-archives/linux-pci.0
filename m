Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50888 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbbLIRHC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Dec 2015 12:07:02 -0500
Message-ID: <56685FB1.8050407@arm.com>
Date: Wed, 09 Dec 2015 17:06:57 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Jake Oshins <jakeo@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 4/7] PCI: Add fwnode_handle to pci_sysdata
References: <1449275767-1510-1-git-send-email-jakeo@microsoft.com> <1449275767-1510-5-git-send-email-jakeo@microsoft.com> <56685BE5.3000909@arm.com> <DM2PR0301MB12320161CCEA8A4C097B82E6ABE80@DM2PR0301MB1232.namprd03.prod.outlook.com>
In-Reply-To: <DM2PR0301MB12320161CCEA8A4C097B82E6ABE80@DM2PR0301MB1232.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/12/15 16:54, Jake Oshins wrote:
>> -----Original Message-----
>> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
>> Sent: Wednesday, December 9, 2015 8:51 AM
>> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
>> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
>> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
>> vkuznets@redhat.com; tglx@linutronix.de; Haiyang Zhang
>> <haiyangz@microsoft.com>; bhelgaas@google.com; linux-
>> pci@vger.kernel.org
>> Subject: Re: [PATCH v7 4/7] PCI: Add fwnode_handle to pci_sysdata
>>
>> On 05/12/15 00:36, jakeo@microsoft.com wrote:
>>> From: Jake Oshins <jakeo@microsoft.com>
>>>
>>> This patch adds an fwnode_handle to struct pci_sysdata, which is
>>> used by the next patch in the series when trying to locate an
>>> IRQ domain associated with a root PCI bus.
>>>
>>> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
>>> ---
>>>  arch/x86/include/asm/pci.h | 15 +++++++++++++++
>>>  include/asm-generic/pci.h  |  4 ++++
>>>  2 files changed, 19 insertions(+)
>>>
>>
>> [...]
>>
>>> diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
>>> index f24bc51..4092886 100644
>>> --- a/include/asm-generic/pci.h
>>> +++ b/include/asm-generic/pci.h
>>> @@ -21,4 +21,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev
>> *dev, int channel)
>>>  #define PCI_DMA_BUS_IS_PHYS	(1)
>>>  #endif
>>>
>>> +#ifndef pci_root_bus_fwnode
>>> +#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
>>> +#endif
>>> +
>>>  #endif /* _ASM_GENERIC_PCI_H */
>>>
>>
>> This breaks at least arm64 (as you can see from the reply to patch #5,
>> because it does have its own asm/pci.h. Instead, how about moving this
>> to linux/pci.h, just after the include of asm/pci.h? I just gave it a
>> go, and it seems to work nicely (the first hunk fixes the rest of the
>> arm64 compile issue):
> 
> Thank you.  I was just working through how to do that.  I lost a
> couple of days trying to figure out how to cross-compile for arm64 to
> check that any fix that I made actually worked.  (In the process,
> I've completely messed up my development machine.  Any pointers to
> the right strategy would be appreciated.)

My own strategy is pretty simple. It involves:
- downloading a binary toolchain ([1] for example)
- untar this somewhere, putting the
gcc-linaro-5.2-2015.11-x86_64_aarch64-linux-gnu/bin directory in your PATH
- and then the usual "make ARCH=arm64 defconfig && make ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- all"

That's of course assuming you're using a Linux x86-64 box for
cross-compiling. I also cross-compile from 32bit ARM, but I doubt you'd
be interested... ;-)

Cheers,

	M.

[1]
https://releases.linaro.org/components/toolchain/binaries/5.2-2015.11/aarch64-linux-gnu/gcc-linaro-5.2-2015.11-x86_64_aarch64-linux-gnu.tar.xz
-- 
Jazz is not dead. It just smells funny...
