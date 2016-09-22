Return-Path: <mpe@ellerman.id.au>
Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org, bhelgaas@google.com
Subject: Re: [PATCH 4/4] drivers/pci/hotplug: Support surprise hotplug
In-Reply-To: <20160921165703.GA17457@localhost>
References: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com> <1474460130-8316-5-git-send-email-gwshan@linux.vnet.ibm.com> <20160921165703.GA17457@localhost>
Date: Thu, 22 Sep 2016 20:51:28 +1000
Message-ID: <877fa48axb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> Hi Gavin,
>
> You don't need my ack for any of these, and I assume you'll merge them
> through the powerpc tree.

Thanks Bjorn, I wasn't sure if you wanted to ack it or not. I'll take
the whole series via the powerpc tree.

> Minor comments below, feel free to ignore them.
>
> On Wed, Sep 21, 2016 at 10:15:30PM +1000, Gavin Shan wrote:
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
> Since you *always* allocate the event when allocating the php_slot,
> making the event a member of php_slot (instead of keeping a pointer to
> it) would simplify your memory management a bit.

> It seems to be the style in this file to use "unlikely" liberally, but
> I really doubt there's any performance consideration in this code.  To
> me it adds more clutter than usefulness.

Agreed on both counts. Gavin can you do another spin with those changes,
thanks.

cheers
