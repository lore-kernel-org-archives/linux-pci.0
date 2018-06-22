Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55456 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeFVUGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 16:06:20 -0400
Subject: Re: [PATCH v4 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
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
 <20180622194315.10475-2-logang@deltatee.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1222da4e-864c-5e27-b735-99fc53d1e367@infradead.org>
Date: Fri, 22 Jun 2018 13:05:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180622194315.10475-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 06/22/2018 12:43 PM, Logan Gunthorpe wrote:

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 97acba712e4e..cb999b2a9530 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -191,6 +191,92 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
>  EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  #endif
>  
> +/**
> + * pci_dev_str_match - test if a string matches a device
> + * @dev:    the PCI device to test
> + * @p:      string to match the device against
> + * @endptr: pointer to the string after the match
> + *
> + * Test if a string (typically from a kernel parameter) matches a
> + * specified. The string may be of one of the following formats:

"matches a specified."  eh?

> + *
> + *   [<domain>:]<bus>:<slot>.<func>
> + *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> + *
> + * The first format specifies a PCI bus/slot/function address which
> + * may change if new hardware is inserted, if motherboard firmware changes,
> + * or due to changes caused in kernel parameters. If the domain is
> + * left unspecified, it is taken to be 0.
> + *
> + * The second format matches devices using IDs in the configuration
> + * space which may match multiple devices in the system. A value of 0
> + * for any field will match all devices. (Note: this differs from
> + * in-kernel code that uses PCI_ANY_ID which is ~0; this is for
> + * legacy reasons and convienence so users don't have to specify

                         convenience

> + * FFFFFFFFs on the command line.)
> + *
> + * Returns 1 if the string matches the device, 0 if it does not and
> + * a negative error code if the string cannot be parsed.
> + */
> +static int pci_dev_str_match(struct pci_dev *dev, const char *p,
> +			     const char **endptr)
> +{

thanks,
-- 
~Randy
