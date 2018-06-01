Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:35002 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeFAPqi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Jun 2018 11:46:38 -0400
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180531235010.5279-1-logang@deltatee.com>
 <20180531235010.5279-2-logang@deltatee.com>
 <CAHp75VcQwDGqND8v1RTo4+6Hyf9G5_2w9x9aiVONwKXsTKgJ1Q@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <806279a8-1faa-7b86-f761-15eb95b10887@deltatee.com>
Date: Fri, 1 Jun 2018 09:46:05 -0600
MIME-Version: 1.0
In-Reply-To: <CAHp75VcQwDGqND8v1RTo4+6Hyf9G5_2w9x9aiVONwKXsTKgJ1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 01/06/18 04:39 AM, Andy Shevchenko wrote:
>> -       pci=option[,option...]  [PCI] various PCI subsystem options:
>> +       pci=option[,option...]  [PCI] various PCI subsystem options.
>> +
>> +                               Some options herein operate on a specific device
>> +                               or a set of devices (<pci_dev>). These are
>> +                               specified in one of two formats:
> 
> I would rather to add
> 
>  <pci_dev>
> 
> here in the same way as done for options.
> It would be easy for people to find a referenced paragraph.

Sorry, I don't understand what you are asking. Can you be more specific?

>> +
>> +                               [<domain>:]<bus>:<slot>.<func>
>> +                               pci:<vendor>:<device>[:<subvendor>:<subdevice>]
>> +
>> +                               Note: the first format specifies a PCI
>> +                               bus/slot/function address which may change
>> +                               if new hardware is inserted, if motherboard
>> +                               firmware changes, or due to changes caused
>> +                               by other kernel parameters. The second format
>> +                               selects devices using IDs from the
>> +                               configuration space which may match multiple
>> +                               devices in the system.
> 
>> +static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>> +                            const char **endptr)
> 
> This change I hope has no functional alteration, so, can be split to a
> separate patch.

That's all this patch does... Or do you want be to separate out
documentation from implementation? That just seems a bit excessive to me.

Logan
