Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdLEUjX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Dec 2017 15:39:23 -0500
Date: Tue, 5 Dec 2017 14:39:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH -next] pci: add function stub for
 pci_get_domain_bus_and_slot()
Message-ID: <20171205203920.GI23510@bhelgaas-glaptop.roam.corp.google.com>
References: <80e3c9bb-fb65-4d87-76f9-db7c1273cef3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80e3c9bb-fb65-4d87-76f9-db7c1273cef3@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Sinan]

On Tue, Nov 28, 2017 at 02:31:21PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> The coretemp driver build fails when CONFIG_PCI is not enabled
> because it uses a function that does not have a stub for that
> config case, so add the function stub.
> 
> ../drivers/hwmon/coretemp.c: In function 'adjust_tjmax':
> ../drivers/hwmon/coretemp.c:250:9: error: implicit declaration of function 'pci_get_domain_bus_and_slot' [-Werror=implicit-function-declaration]
>   struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
> ../drivers/hwmon/coretemp.c:250:32: warning: initialization makes pointer from integer without a cast [enabled by default]
>   struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied with Guenter's ack to pci/enumeration for v4.16, thanks!

Apparently no other code calls pci_get_domain_bus_and_slot() when
CONFIG_PCI isn't enabled.

15ab6790f628 ("hwmon: (coretemp) deprecate pci_get_bus_and_slot()") is
already in linux-next via hwmon-staging.

The pci tree is merged into next slightly before hwmon-staging, so
this should be resolved as soon as the 0-day builder builds my
pci/enumeration branch and I merge it into my next branch.

> ---
>  include/linux/pci.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-next-20171128.orig/include/linux/pci.h
> +++ linux-next-20171128/include/linux/pci.h
> @@ -1660,6 +1660,9 @@ static inline struct pci_dev *pci_get_sl
>  static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
>  						unsigned int devfn)
>  { return NULL; }
> +static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
> +					unsigned int bus, unsigned int devfn)
> +{ return NULL; }
>  
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
> 
> 
