Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbdLFOlP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Dec 2017 09:41:15 -0500
Subject: Re: [PATCH] pci: provide pci_get_domain_bus_and_slot dummy helper
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Minter <matt@masarand.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20171206141751.757163-1-arnd@arndb.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <616e1d18-df26-f868-ddb9-602621e9240f@codeaurora.org>
Date: Wed, 6 Dec 2017 09:41:09 -0500
MIME-Version: 1.0
In-Reply-To: <20171206141751.757163-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/6/2017 9:17 AM, Arnd Bergmann wrote:
> When CONFIG_PCI is disabled, we still provide a pci_get_bus_and_slot()
> function that always returns NULL, but do not provide the same helper
> for pci_get_domain_bus_and_slot():
> 
> Replacing pci_get_bus_and_slot with pci_get_domain_bus_and_slot now causes
> a build error because of that:
> 
> drivers/hwmon/coretemp.c: In function 'adjust_tjmax':
> drivers/hwmon/coretemp.c:250:32: error: implicit declaration of function 'pci_get_domain_bus_and_slot'; did you mean 'pci_get_bus_and_slot'? [-Werror=implicit-function-declaration]
>   struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
> 
> This adds the missing helper function.
> 
> Fixes: 1630bd42079c ("hwmon: (coretemp) deprecate pci_get_bus_and_slot()")
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> It would be good to get this into v4.15, in order to increase the
> chances of it still working after the conversion patches get merged
> during the v4.16 merge window.
> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a1589dec7e33..69815397365e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1660,6 +1660,10 @@ static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
>  static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
>  						unsigned int devfn)
>  { return NULL; }
> +static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
> +						unsigned int bus,
> +						unsigned int devfn)
> +{ return NULL; }
>  
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
> 

I thought Bjorn merged a similar patch yesterday with subject

"[PATCH -next] pci: add function stub for pci_get_domain_bus_and_slot()"

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
