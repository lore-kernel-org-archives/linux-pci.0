Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbeHIXn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 19:43:56 -0400
Date: Thu, 9 Aug 2018 16:17:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 3/4] PCI: Introduce disable_acs_redir quirk
Message-ID: <20180809211714.GG113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730161840.13733-1-logang@deltatee.com>
 <20180730161840.13733-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730161840.13733-4-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 10:18:39AM -0600, Logan Gunthorpe wrote:
> Intel SPT PCH hardware has an implementation of the ACS bits that
> does not comply with the PCI express standard. To deal with this
> the existing code has an enable_acs() quirk for the hardware.
> 
> In order to be able to correctly disable the ACS redirect bits for
> all hardware we need an analagous quirk to disable those bits.
> 
> This adds the function pci_dev_specific_disable_acs_redir() which
> behaves similarly to pci_dev_specific_enable_acs() but uses a new
> function pointer for quirks which disables the ACS redirect bits.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> ...

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index abd5d5e17aee..0a436ec4fef5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1880,6 +1880,7 @@ enum pci_fixup_pass {
>  void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
> +int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
>  #else
>  static inline void pci_fixup_device(enum pci_fixup_pass pass,
>  				    struct pci_dev *dev) { }
> @@ -1892,6 +1893,10 @@ static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  {
>  	return -ENOTTY;
>  }
> +static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
> +{
> +	return -ENOTTY;
> +}

I assume these could go in drivers/pci/pci.h instead of
include/linux/pci.h?

I can do that (and add another patch to move the
pci_dev_specific_acs_enabled() and pci_dev_specific_enable_acs()
declarations, which also are only used inside drivers/pci) if you agree.

>  #endif
>  
>  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
> -- 
> 2.11.0
> 
