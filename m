Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] PCI: Do not disable memory decoding in
 pci_reassigndev_resource_alignment()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160701005036.GA18999@gwshan>
Cc: nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	linux-doc@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, warrier@linux.vnet.ibm.com,
	alex.williamson@redhat.com, paulus@samba.org, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Fri, 1 Jul 2016 14:35:04 +0800
MIME-Version: 1.0
In-Reply-To: <20160701005036.GA18999@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a968e6af-3a17-0c79-bdfe-34329f38b2f9@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gavin,

On 2016/7/1 8:50, Gavin Shan wrote:

> On Thu, Jun 30, 2016 at 06:53:09PM +0800, Yongji Xie wrote:
>> We should not disable memory decoding when we reassign alignment
>> in pci_reassigndev_resource_alignment(). It's meaningless and
>> have some side effect. For example, some fixup functions such as
>> quirk_e100_interrupt() read PCI_COMMAND_MEMORY to know whether
>> the devices has been initialized by the firmware or not. If we
>> disable memory decoding here, these functions will get a wrong
>> information that the devices was not initialized by the firmware
>> which may cause a wrong fixup. Besides, disabling memory decoding
>> may also break some devices that need to have memory decoding
>> always-on during probing.
>>
> It seems the changelog isn't correct enough if it's talking about
> below check in code:
>
> if (!(command & PCI_COMMAND_MEMORY) || !pci_resource_start(dev, 0))
> 	return;

Could you give me more details?  It seems that we couldn't disable
e100 interrupts which enabled by some firmware if we disabling
memory decoding here.

>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>> drivers/pci/pci.c |    8 +-------
>> 1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 6ae02de..6241cfc 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4820,7 +4820,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>> 	int i;
>> 	struct resource *r;
>> 	resource_size_t align, size;
>> -	u16 command;
>>
>> 	/* We should never try to reassign VF's alignment */
>> 	if (dev->is_virtfn)
>> @@ -4838,12 +4837,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>> 		return;
>> 	}
>>
>> -	dev_info(&dev->dev,
>> -		"Disabling memory decoding and releasing memory resources.\n");
>> -	pci_read_config_word(dev, PCI_COMMAND, &command);
>> -	command &= ~PCI_COMMAND_MEMORY;
>> -	pci_write_config_word(dev, PCI_COMMAND, command);
>> -
>> +	dev_info(&dev->dev, "Releasing memory resources.\n");
> Is there a problem you found with PCI_COMMAND removed? If so, could you
> please share more details, thanks.

Disabling memory decoding may break some devices which
have flag mmio_always_on. Besides the mmio_always_on case,
I also found this would break some P2P bridge such as
PEX 8718 controller.

Thanks,
Yongji
