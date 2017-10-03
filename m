Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Oct 2017 10:09:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Govindarajulu Varadarajan <gvaradar@cisco.com>
Cc: Christoph Hellwig <hch@lst.de>, benve@cisco.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, mingo@redhat.com,
        peterz@infradead.org, okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI: AER: fix deadlock in do_recovery
Message-ID: <20171003080954.GA19637@lst.de>
References: <20170930054938.43271-1-gvaradar@cisco.com> <20171001075514.GA11554@lst.de> <alpine.LNX.2.20.1710021606440.30867@cae-iprp-alln-lb.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1710021606440.30867@cae-iprp-alln-lb.cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 02, 2017 at 05:14:09PM -0700, Govindarajulu Varadarajan wrote:
>
> I would avoid increasing the size of pci_dev. The list_head would be empty after
> we call aer_pci_walk_bus(). We already have pci_bus *subordinate to link all the
> 'device's. Making list_head available to others would require a lock. I would
> avoid that.

It does not require a new lock if you clearly document the concurrency
semantics.  And I'd much rather add a hlist_node (which should be enough
if we want to be small) to pci_dev than requiring these additional
memory allocations and boiler plate code in an error recovery situation.

>
>>> +static void aer_pci_walk_bus(struct pci_bus *top,
>>> +			     int (*cb)(struct pci_dev *, void *),
>>> +			     struct aer_broadcast_data *result)
>>> +{
>>> +	HLIST_HEAD(dev_hlist);
>>> +	struct hlist_node *tmp;
>>> +	struct aer_device_list *entry;
>>
>> Do we want to offer this as generic PCIe functionality?  If not we can
>> probably hardcode the callback and callback data to simplify this a lot.
>>
>
> I could not find any other code which aquires device_lock in pci_walk_bus cb
> function. Can you tell me how we can hardcore callback and callback data here?

The word is hardcode.  If you follow the above suggestion we won't
really need the aer_pci_walk_bus helper but could just open code most
of the code.  Or maybe just keep passing the cb for simplicity - it
was just extending on the above idea.
