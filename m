Return-Path: <SRS0=5gg5=53=linux.vnet.ibm.com=gpiccoli@kernel.org>
Return-Path: <SRS0=5gg5=53=linux.vnet.ibm.com=gpiccoli@kernel.org>
Subject: Re: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
To: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: rakesh@tuxera.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20170601111039.8913-1-hch@lst.de>
 <20170601111039.8913-2-hch@lst.de>
 <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
 <20170606104836.GB24297@lst.de>
 <20170606211443.GB12672@bhelgaas-glaptop.roam.corp.google.com>
 <20170607182936.GA31815@lst.de>
 <20170612231423.GB4379@bhelgaas-glaptop.roam.corp.google.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 17:41:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170612231423.GB4379@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <02708e29-c19a-84a4-b8ab-c62bbf810fd4@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 06/12/2017 08:14 PM, Bjorn Helgaas wrote:
> On Wed, Jun 07, 2017 at 08:29:36PM +0200, Christoph Hellwig wrote:
>> On Tue, Jun 06, 2017 at 04:14:43PM -0500, Bjorn Helgaas wrote:
>>> So I guess the method here is
>>> dev->driver->err_handler->reset_notify(), and the PCI core should be
>>> holding device_lock() while calling it?  That makes sense to me;
>>> thanks a lot for articulating that!
>>
>> Yes.
>>
>>> 1) The current patch protects the err_handler->reset_notify() uses by
>>> adding or expanding device_lock regions in the paths that lead to
>>> pci_reset_notify().  Could we simplify it by doing the locking
>>> directly in pci_reset_notify()?  Then it would be easy to verify the
>>> locking, and we would be less likely to add new callers without the
>>> proper locking.
>>
>> We could do that, except that I'd rather hold the lock over a longer
>> period if we have many calls following each other.  
> 
> My main concern is being able to verify the locking.  I think that is
> much easier if the locking is adjacent to the method invocation.  But
> if you just add a comment at the method invocation about where the
> locking is, that should be sufficient.
> 
>> I also have
>> a patch to actually kill pci_reset_notify() later in the series as
>> well, as the calling convention for it and ->reset_notify() are
>> awkward - depending on prepare parameter they do two entirely
>> different things.  That being said I could also add new
>> pci_reset_prepare() and pci_reset_done() helpers.
> 
> I like your pci_reset_notify() changes; they make that much clearer.
> I don't think new helpers are necessary.
> 
>>> 2) Stating the rule explicitly helps look for other problems, and I
>>> think we have a similar problem in all the pcie_portdrv_err_handler
>>> methods.
>>
>> Yes, I mentioned this earlier, and I also vaguely remember we got
>> bug reports from IBM on power for this a while ago.  I just don't
>> feel confident enough to touch all these without a good test plan.
> 
> Hmmm.  I see your point, but I hate leaving a known bug unfixed.  I
> wonder if some enterprising soul could tickle this bug by injecting
> errors while removing and rescanning devices below the bridge?

Well, although I don't consider myself an enterprising soul...heheh
I can test it, just CC me in next spin and provide some comment on how
to test (or point me the thread of original report).

I guess it was myself the reporter of the issue, I tried a simple fix
for our case and Christoph mentioned issue was more generic and needed a
proper fix..

Hopefully this one is that fix!
Thanks,


Guilherme

> 
> Bjorn
> 
