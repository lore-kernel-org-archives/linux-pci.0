Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62054 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbcFSLtt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Jun 2016 07:49:49 -0400
Message-ID: <1466336986.30123.164.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: Document connection between pci_power_t and
 hardware PM capability
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Date: Sun, 19 Jun 2016 14:49:46 +0300
In-Reply-To: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2016-06-18 at 13:00 -0500, Bjorn Helgaas wrote:
> The dev.pme_support field, pci_pm_init(), and pci_pme_capable() depend
> on
> the fact that the pci_power_t values (PCI_D0, PCI_D1, etc.) match the
> definition of the PME_Support field of the Power Management
> Capabilities
> register in the Power Management capability (see PCI Bus Power
> Management
> spec r1.2, sec 3.2.3).

Nice to know! Thanks.

If it matters:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Add a note to this effect at the pci_power_t typedef.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/pci.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8597b42..85cede3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -101,6 +101,10 @@ enum {
>  	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
>  };
>  
> +/*
> + * pci_power_t values must match the bits in the PME_Support field of
> the
> + * Power Management Capabilities register in the Power Management
> capability.
> + */
>  typedef int __bitwise pci_power_t;
>  
>  #define PCI_D0		((pci_power_t __force) 0)
> 

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
