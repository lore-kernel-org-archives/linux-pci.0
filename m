Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47634 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754178AbeFVUup (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jun 2018 16:50:45 -0400
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7e5b459d-f083-286c-bd6c-87cf62cc7541@deltatee.com>
Date: Fri, 22 Jun 2018 14:50:18 -0600
MIME-Version: 1.0
In-Reply-To: <c1278ab2-63a8-19b6-9c8d-fed0b4f94c11@infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 22/06/18 02:01 PM, Randy Dunlap wrote:
>> Thus, we add an option to specify devices in the following format:
>>
>> [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
> 
> Please explain the trailing '*'.  I looked thru the code and it doesn't
> seem to look for it or care.

This was Willy's suggestion and I liked it. It's similar to regular
expression syntax: the '*' indicating you may have any number of the
expression repeated in the square brackets.

Logan
