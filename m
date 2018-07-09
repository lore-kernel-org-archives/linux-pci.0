Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:45990 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933274AbeGIRAt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Jul 2018 13:00:49 -0400
To: Alex Williamson <alex.williamson@redhat.com>
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180627174650.27433-1-logang@deltatee.com>
 <20180627174650.27433-4-logang@deltatee.com>
 <20180706165655.62306b6f@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <db0ed0d6-c9ad-6414-77b0-d8ff293337ef@deltatee.com>
Date: Mon, 9 Jul 2018 10:59:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180706165655.62306b6f@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 3/3] PCI: Introduce the disable_acs_redir parameter
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/6/2018 4:56 PM, Alex Williamson wrote:
> Maybe we track if we enabled ACS via a device specific quirk and
> minimally print an incompatibility error if it's also specified for
> disable_acs_redir?  Thanks,

Ok, makes sense. I'll look at it for v6.

Logan
