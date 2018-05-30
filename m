Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:48476 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbeE3Rgl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 13:36:41 -0400
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180524214816.14485-1-logang@deltatee.com>
 <20180524214816.14485-3-logang@deltatee.com>
 <20180530102329.7423dc57@w520.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d3a139c0-53d4-56cf-fa7e-8db5fb527136@deltatee.com>
Date: Wed, 30 May 2018 11:36:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180530102329.7423dc57@w520.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 30/05/18 10:23 AM, Alex Williamson wrote:
> I like the idea, but can't we improve the implementation?  It seems
> that we shouldn't need to allocate more than a working copy of the
> original path string.  We can use strrchr() to find the last path
> divider ('/'), match the slot.fn after that to the current devfn, set
> that path divider to null, step to the next upstream device and
> repeat.  

Ok, I'll give it a shot. I thought this would be a bit more tricky, but
perhaps not.

> Also, since we're working from a downstream device up, I
> suspect we don't need to get and put references at each step, the
> downstream device probably already holds a reference to the upstream
> device for each step along the way.  

That makes sense to me. I think it's something I added in similar p2pdma
code from somebody's review. But sounds like I can probably strip it out
there too and just put a comment noting this.

Thanks,

Logan
