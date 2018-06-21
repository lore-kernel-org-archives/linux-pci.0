Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754129AbeFUTWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2018 15:22:24 -0400
Date: Thu, 21 Jun 2018 12:22:20 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Logan Gunthorpe <logang@deltatee.com>
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 2/3] PCI: Allow specifying devices using a base bus
 and path of devfns
Message-ID: <20180621192220.GA6635@bombadil.infradead.org>
References: <20180618193636.16210-1-logang@deltatee.com>
 <20180618193636.16210-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180618193636.16210-3-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 18, 2018 at 01:36:35PM -0600, Logan Gunthorpe wrote:
> @@ -3000,14 +3000,18 @@
>  				or a set of devices (<pci_dev>). These are
>  				specified in one of the following formats:
>  
> -				[<domain>:]<bus>:<slot>.<func>
> +				[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>][/ ...]

How about:
+				[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*

> -				by other kernel parameters. The second format
> +				by other kernel parameters. Optionally
> +				a path from a device through multiple

I think that's "a path to a device", because you'd start by specifying the
root port, then continuing down the hierarchy, right?

> + * Test if a string (typically from a kernel parameter) formated as a

formatted

> + * path of slot/function addresses matches a PCI device. The string must
> + * be of the form:
> + *
> + *   [<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
> + *
> + * A path for a device can be obtained using 'lspci -t'. Using a path
> + * is more robust against renumbering of devices than using only

I'd call it bus renumbering rather than device renumbering.  After all,
if the device got renumbered, this would fail ;-)

>   * pci_dev_str_match - test if a string matches a device
>   * @dev:    the PCI device to test
>   * @p:      string to match the device against
>   * @endptr: pointer to the string after the match
>   *
>   * Test if a string (typically from a kernel parameter) matches a
> - * specified. The string may be of one of two forms formats:
> + * specified. The string may be of one of three formats:

Surely just "The string may be in one of three formats"

>   *
>   *   [<domain>:]<bus>:<slot>.<func>
> + *   path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
>   *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]

I think you're dropped the "path:" prefix from your parser?

>   * The first format specifies a PCI bus/slot/function address which
>   * may change if new hardware is inserted, if motherboard firmware changes,
>   * or due to changes caused in kernel parameters.
>   *
> - * The second format matches devices using IDs in the configuration
> + * The second format specifies a PCI bus/slot/function root address and
> + * a path of slot/function addresses to the specific device from the root.
> + * The path for a device can be determined through the use of 'lspci -t'.
> + * This format is more robust against renumbering issues than the first format.
> +
> + * The third format matches devices using IDs in the configuration
>   * space which may match multiple devices in the system. A value of 0
>   * for any field will match all devices.
>   *

So you probably want to reword this too.  Two formats, one with optional
trailing path elements?
