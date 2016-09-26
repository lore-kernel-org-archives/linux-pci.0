Return-Path: <gwshan@linux.vnet.ibm.com>
Return-Path: <gwshan@linux.vnet.ibm.com>
Date: Mon, 26 Sep 2016 23:08:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@ozlabs.org, bhelgaas@google.com, mpe@ellerman.id.au
Subject: Re: [PATCH 4/4] drivers/pci/hotplug: Support surprise hotplug
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1474460130-8316-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160921165703.GA17457@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160921165703.GA17457@localhost>
Message-Id: <20160926130802.GA16718@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 11:57:03AM -0500, Bjorn Helgaas wrote:
>Hi Gavin,
>
>You don't need my ack for any of these, and I assume you'll merge them
>through the powerpc tree.
>
>Minor comments below, feel free to ignore them.
>
>On Wed, Sep 21, 2016 at 10:15:30PM +1000, Gavin Shan wrote:
>> ...
>> @@ -536,9 +565,16 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
>>  	if (unlikely(!php_slot))
>>  		return NULL;
>>  
>> +	php_slot->event = kzalloc(sizeof(struct pnv_php_event), GFP_KERNEL);
>> +	if (unlikely(!php_slot->event)) {
>> +		kfree(php_slot);
>> +		return NULL;
>> +	}
>
>Since you *always* allocate the event when allocating the php_slot,
>making the event a member of php_slot (instead of keeping a pointer to
>it) would simplify your memory management a bit.
>
>It seems to be the style in this file to use "unlikely" liberally, but
>I really doubt there's any performance consideration in this code.  To
>me it adds more clutter than usefulness.
>
>> +static irqreturn_t pnv_php_interrupt(int irq, void *data)
>> +{
>> +	struct pnv_php_slot *php_slot = data;
>> +	struct pci_dev *pchild, *pdev = php_slot->pdev;
>> +	struct eeh_dev *edev;
>> +	struct eeh_pe *pe;
>> +	struct pnv_php_event *event;
>> +	u16 sts, lsts;
>> +	u8 presence;
>> +	bool added;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
>> +	sts &= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
>> +	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);
>
>I didn't realize that this is some sort of hybrid of native PCIe
>hotplug and PowerNV-specific stuff.  Wonder if there's any opportunity
>to combine with or leverage pciehp.  That seems pretty blue-sky
>though, since there's so much PowerNV special sauce here.
>

Bjorn, thanks a lot for your comments. All comments except last one
(leverage pciehp) are covered in v2 which wasn't copied to linux-pci@
list to avoid unnecessary traffic. Yeah, the driver is too much PowerNV
platform specific things, which makes it hard to be built on top of
pciehp.

Thanks,
Gavin
