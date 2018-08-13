Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:35126 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbeHMSiq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Aug 2018 14:38:46 -0400
To: Matthew Wilcox <willy@infradead.org>, Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
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
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
 <mj+md-20180810.091549.51451.nikam@ucw.cz>
 <mj+md-20180810.103017.64385.nikam@ucw.cz>
 <20180810145655.GA16533@bombadil.infradead.org>
 <mj+md-20180812.092635.39872.nikam@ucw.cz>
 <20180812103133.GB2984@bombadil.infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <98953063-2fa8-fe2b-afc5-801d0a341051@deltatee.com>
Date: Mon, 13 Aug 2018 09:55:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180812103133.GB2984@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: lspci: Display path to device
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/08/18 04:31 AM, Matthew Wilcox wrote:
> I pondered asking Logan to change his parser to include the bus number
> as a solution, but then I remembered the entire point of this is to make
> specifying a device robust against bus number assignmnet changes.  I suppose
> we could have the parser accept and ignore the bus number ...

Yes, exactly. Bjorn's already accepted the series but we could add
support for ignored bus letters in another patch if we want. I just
think that might be confusing when you end up in a situation where the
path includes numbers that no longer actually match the actual addresses
after the bus numbers change.

Thanks,

Logan
