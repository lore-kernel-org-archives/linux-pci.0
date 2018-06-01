Return-Path: <linux-kernel-owner@vger.kernel.org>
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
References: <20180531235010.5279-1-logang@deltatee.com>
 <20180531235010.5279-3-logang@deltatee.com>
 <20180601083000.62d10d14@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cb689b24-477d-9274-8984-574c244d2499@deltatee.com>
Date: Fri, 1 Jun 2018 09:47:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180601083000.62d10d14@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 01/06/18 08:30 AM, Alex Williamson wrote:
> Cool, I'm glad this worked.  I note though that there's really not much
> difference between:
> 
> [domain:]bus:slot.fn
> 
> and
> 
> [domain:]bus:slot.fn[/slot.fn[/slot.fn[/...]]]
> 
> IOW, what's defined here as the "path:" specification doesn't require
> that we start at a root bus device, it can really specify a path
> starting anywhere, including the target device directly.  So can we
> simply extend domain:bus:slot.fn to support paths without a separate
> identifier?  Thanks,

Yes, I think you are right. I was just hesitant to change existing
behavior. But if that's the consensus I'll change it for v3.

Thanks,

Logan
