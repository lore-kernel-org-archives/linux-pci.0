Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH V5 5/6] PCI: Deprecate pci_reset_bus() and
 pci_reset_slot() functions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 open list <linux-kernel@vger.kernel.org>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
 <1530572336-20296-6-git-send-email-okaya@codeaurora.org>
 <20180718223027.GI128988@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <3d664a22-7362-07ec-584d-b38829a22ba2@kernel.org>
Date: Wed, 18 Jul 2018 15:36:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180718223027.GI128988@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 7/18/2018 3:30 PM, Bjorn Helgaas wrote:
> On Mon, Jul 02, 2018 at 06:58:54PM -0400, Sinan Kaya wrote:
>> pci_reset_bus() and pci_reset_slot() functions are not being used by
>> any code. Remove them from the kernel in favor of pci_try_reset_bus()
>> and pci_try_reset_slot() functions.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   drivers/pci/pci.c   | 55 ++---------------------------------------------------
>>   include/linux/pci.h |  2 --
>>   2 files changed, 2 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index a31e6db..7e3f2e9 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4784,9 +4784,9 @@ int pci_probe_reset_slot(struct pci_slot *slot)
>>   EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
>>   
>>   /**
>> - * pci_reset_slot - reset a PCI slot
>> + * __pci_try_reset_slot - Try to reset a PCI slot
>>    * @slot: PCI slot to reset
>> - *
>> + *`
> 
> Is this "*`" intentional or a typo?  I can't find it in kernel-doc.rst
> (but it's full of ` and maybe I missed it).

Typo.

> 
> I do see a few other occurrences in the code, although they look like
> typos to me:
> 
>    $ git grep "\*\`" | grep -v Documentation
>    arch/mips/cavium-octeon/octeon-usb.c:	 *`	0x1 = Big endian
>    arch/mips/cavium-octeon/octeon-usb.c:	 *`	0x1 = Big endian
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:/*`
> 
