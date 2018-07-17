Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbeGQVfV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 17:35:21 -0400
Date: Tue, 17 Jul 2018 16:00:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Martin Mares <mj@ucw.cz>, Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: lspci: Display path to device
Message-ID: <20180717210053.GB128988@bhelgaas-glaptop.roam.corp.google.com>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717203900.GA1771@bombadil.infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 17, 2018 at 01:39:00PM -0700, Matthew Wilcox wrote:
> I don't like telling the user to grovel around lspci -t by hand.  It's
> not many lines of code to add a new -P option to lspci to show the path
> to each device instead of bus:dev.fn
> 
> Here's three examples, first without, then with -P.
> ...

> The Nehalem system makes an interesting testcase because it exposes some
> registers in fake PCIe devices that aren't behind the root ports.  eg:
> 
> ff:06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory Controller Channel 2 Thermal Control Registers (rev 04)

I think these appear as conventional PCI devices; at least the ones
I've seen, e.g., [1], don't have a PCIe capability, so I think it
makes sense that they're not behind a root port.

[1] https://bugzilla5.redhat.com/attachment.cgi?id=433169
