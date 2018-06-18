Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38129 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbeFRXGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jun 2018 19:06:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180618154430.1af3d42f@t450s.home>
References: <20180618193636.16210-1-logang@deltatee.com> <20180618193636.16210-2-logang@deltatee.com>
 <20180618154430.1af3d42f@t450s.home>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Jun 2018 02:06:36 +0300
Message-ID: <CAHp75VefSEvpUvsdi=W6rEiOX01zaJeMtxQMDqmSthPJP3uJFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2018 at 12:44 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 18 Jun 2018 13:36:34 -0600
> Logan Gunthorpe <logang@deltatee.com> wrote:

> I realize this is not a change in behavior, but since we're spelling it
> out in a proper comment rather than burying it in the implementation,
> using 0 as a wildcard is rather questionable behavior.  It always
> surprises me when I read this because pci_match_one_device() uses
> PCI_ANY_ID (~0) as a wildcard and as a result of struct pci_device_id
> using __u32 for these fields, we actually need to specify ffffffff on
> the commandline to get a wildcard match for dynamic ids.  The latter is
> tedious to use, but I think it's more correct, and the use of a __u32 is
> probably attributed to the fact that 0xffff is only reserved for vendor
> ID, the spec doesn't seem to reserve any entries from the vendor's
> device ID range.
>
> There's probably really no path to resolve these, but acknowledging the
> difference in this comment block might be helpful in the future.

...or introduce a parser part to allow user supply "any" instead of
numeric value.

>> +                     pr_info("PCI: Can't parse resource_alignment parameter: pci:%s\n",

> The "pci:" prefix on %s doesn't make sense now, it was used above when
> the pointer was already advanced past this token, now I believe it would
> lead to "pci:pci:xxxx:yyyy" or "pci:xx:yy.z".  Thanks,

I'm just wondering if we can use pci_info() here, Or it makes no sense?
Also, the original loglevel was an "error".

-- 
With Best Regards,
Andy Shevchenko
