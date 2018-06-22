Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180622194315.10475-1-logang@deltatee.com>
 <20180622194315.10475-3-logang@deltatee.com>
 <c1278ab2-63a8-19b6-9c8d-fed0b4f94c11@infradead.org>
 <7e5b459d-f083-286c-bd6c-87cf62cc7541@deltatee.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f4bbe0f2-1087-c626-7776-a4fb6b5457c8@infradead.org>
Date: Fri, 22 Jun 2018 14:33:34 -0700
MIME-Version: 1.0
In-Reply-To: <7e5b459d-f083-286c-bd6c-87cf62cc7541@deltatee.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/22/2018 01:50 PM, Logan Gunthorpe wrote:
> 
> 
> On 22/06/18 02:01 PM, Randy Dunlap wrote:
>>> Thus, we add an option to specify devices in the following format:
>>>
>>> [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
>>
>> Please explain the trailing '*'.  I looked thru the code and it doesn't
>> seem to look for it or care.
> 
> This was Willy's suggestion and I liked it. It's similar to regular
> expression syntax: the '*' indicating you may have any number of the
> expression repeated in the square brackets.

Oh, OK.  I can do that syntax, I just didn't know that this was
using that notation.

Hopefully admins can read it that way.

-- 
~Randy
