Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44946 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935073AbeFRWZu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 18:25:50 -0400
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180618193636.16210-1-logang@deltatee.com>
 <20180618193636.16210-4-logang@deltatee.com>
 <20180618162100.3619575e@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa50bbcf-73ad-271f-c926-09d9e0369665@deltatee.com>
Date: Mon, 18 Jun 2018 16:25:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180618162100.3619575e@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 3/3] PCI: Introduce the disable_acs_redir parameter
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 18/06/18 04:21 PM, Alex Williamson wrote:
> Seems that too much is taken from the dynamic resource alignment that
> doesn't necessarily apply to a read-only, commandline-only, device
> discovery-only option.  I don't think we need locking, I don't think we
> need a massive static buffer, ideally perhaps even no buffer, just a
> pointer to commandline.  Thanks,

Yeah, fair points. I'll take another look and see what I can strip out.

Thanks,

Logan
