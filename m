Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20180730161840.13733-1-logang@deltatee.com>
 <20180730161840.13733-2-logang@deltatee.com>
 <20180809211541.GF113140@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <512aa96e-1c31-ecbd-88c7-a5e417d533ba@deltatee.com>
Date: Thu, 9 Aug 2018 15:18:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180809211541.GF113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v8 1/4] PCI: Make specifying PCI devices in kernel
 parameters reusable
List-ID: <linux-pci.vger.kernel.org>



On 09/08/18 03:15 PM, Bjorn Helgaas wrote:
>> @@ -2994,7 +2994,26 @@
>>  			See header of drivers/block/paride/pcd.c.
>>  			See also Documentation/blockdev/paride.txt.
>>  
>> -	pci=option[,option...]	[PCI] various PCI subsystem options:
>> +	pci=option[,option...]	[PCI] various PCI subsystem options.
>> +
>> +				Some options herein operate on a specific device
>> +				or a set of devices (<pci_dev>). These are
>> +				specified in one of the following formats:
>> +
>> +				[<domain>:]<bus>:<slot>.<func>
>> +				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
>> +
>> +				Note: the first format specifies a PCI
>> +				bus/slot/function address which may change
> 
> Unless you object, I'm going to change "slot" references like this to
> "device" so they match "BDF" and the language in the spec, which uses
> "slot" to refer to a physical slot and "device" when referring to
> geographical device addresses.  I can do this when I apply these, so
> no need for you to repost them.

No objection. I never liked the "slot" reference but was trying to
remain consistent with what was there before. If I remember correctly
there's a bunch of places in the kernel that use slot as well.

Thanks,

Logan
