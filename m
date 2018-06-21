Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:40342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932721AbeFUVAm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jun 2018 17:00:42 -0400
To: Matthew Wilcox <willy@infradead.org>
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
References: <20180618193636.16210-1-logang@deltatee.com>
 <20180618193636.16210-3-logang@deltatee.com>
 <20180621192220.GA6635@bombadil.infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6a6e5417-eb7b-921f-34a7-41e22abe5541@deltatee.com>
Date: Thu, 21 Jun 2018 15:00:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180621192220.GA6635@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 21/06/18 01:22 PM, Matthew Wilcox wrote:
> On Mon, Jun 18, 2018 at 01:36:35PM -0600, Logan Gunthorpe wrote:
> So you probably want to reword this too.  Two formats, one with optional
> trailing path elements?

Thanks for the review Matthew! I've addressed all your feedback for a v4
which I'll post shortly.

Logan
