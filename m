Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:45174 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755375AbeFRXLk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 19:11:40 -0400
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180618193636.16210-1-logang@deltatee.com>
 <20180618193636.16210-2-logang@deltatee.com>
 <20180618154430.1af3d42f@t450s.home>
 <CAHp75VefSEvpUvsdi=W6rEiOX01zaJeMtxQMDqmSthPJP3uJFA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6df930b0-e0aa-67c3-357b-a366319c2f5d@deltatee.com>
Date: Mon, 18 Jun 2018 17:11:22 -0600
MIME-Version: 1.0
In-Reply-To: <CAHp75VefSEvpUvsdi=W6rEiOX01zaJeMtxQMDqmSthPJP3uJFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 18/06/18 05:06 PM, Andy Shevchenko wrote:
> On Tue, Jun 19, 2018 at 12:44 AM, Alex Williamson
>> There's probably really no path to resolve these, but acknowledging the
>> difference in this comment block might be helpful in the future.
> 
> ...or introduce a parser part to allow user supply "any" instead of
> numeric value.

I think the main difficulty is maintaining backwards compatibility. If
anyone is already using zero as a parameter then we will break their system.

>>> +                     pr_info("PCI: Can't parse resource_alignment parameter: pci:%s\n",
> 
>> The "pci:" prefix on %s doesn't make sense now, it was used above when
>> the pointer was already advanced past this token, now I believe it would
>> lead to "pci:pci:xxxx:yyyy" or "pci:xx:yy.z".  Thanks,
> 
> I'm just wondering if we can use pci_info() here, Or it makes no sense?
> Also, the original loglevel was an "error".

Yeah, I don't think pci_info() makes sense as it's not attached to a
specific device.

Not sure how I messed up the log level, but I'll fix it for v4.

Thanks,

Logan
