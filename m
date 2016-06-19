Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:49565 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbcFSLpV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2016 07:45:21 -0400
Date: Sun, 19 Jun 2016 13:49:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] PCI: Document connection between pci_power_t and
 hardware PM capability
Message-ID: <20160619114919.GA2457@wunner.de>
References: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 18, 2016 at 01:00:56PM -0500, Bjorn Helgaas wrote:
> The dev.pme_support field, pci_pm_init(), and pci_pme_capable() depend on
> the fact that the pci_power_t values (PCI_D0, PCI_D1, etc.) match the
> definition of the PME_Support field of the Power Management Capabilities
> register in the Power Management capability (see PCI Bus Power Management
> spec r1.2, sec 3.2.3).

In addition, pci_power_t is assumed to match the power state in the
PM Control and Status Register, see pci_raw_set_power_state().
The PMCSR reserves only 2 bits for the power state, so it can only
represent D0 to D3hot. If the device is in D3cold, reads from its
config space usually result in an "all ones" fabricated response.
Thus D3hot and D3cold cannot be differentiated when reading the
power state in the PMCSR, they're represented by the same value.

Best regards,

Lukas

> 
> Add a note to this effect at the pci_power_t typedef.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/pci.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8597b42..85cede3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -101,6 +101,10 @@ enum {
>  	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
>  };
>  
> +/*
> + * pci_power_t values must match the bits in the PME_Support field of the
> + * Power Management Capabilities register in the Power Management capability.
> + */
>  typedef int __bitwise pci_power_t;
>  
>  #define PCI_D0		((pci_power_t __force) 0)
> 
