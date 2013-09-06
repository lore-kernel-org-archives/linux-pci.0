Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:60847 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3IFXJq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 19:09:46 -0400
Received: by mail-ye0-f176.google.com with SMTP id m4so1254342yen.35
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 16:09:45 -0700 (PDT)
Date: Fri, 6 Sep 2013 17:09:41 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
Message-ID: <20130906230941.GC12956@google.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kenji, Alex]

On Fri, Sep 06, 2013 at 09:45:56AM +0800, Wei Yang wrote:
> In __pci_bus_size_bridges() we check whether a pci bus is a root
> bus by testing bus->self. As indicated by commit 79af72d7
> ("PCI: pci_is_root_bus helper"), bus->self == NULL is not a proper
> way to check the pci root bus.
> 
> This patch changes it to pci_is_root_bus() to check whether it is
> a root bus.

I think this is a good change, even if only on the grounds of
consistency.

Did you trip over a case where a root bus has bus->self != NULL?
I'd like to know more details about the case where:

  (bus->parent == NULL) && (bus->self != NULL)

I'm sure that situation exists, or Kenji and Alex would not have
made the change in 79af72d7, but I don't know the details.

I'd like to know the details so I can recognize similar problems
elsewhere.

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 520210f..989de3c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1134,7 +1134,7 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
>  	}
>  
>  	/* The root bus? */
> -	if (!bus->self)
> +	if (pci_is_root_bus(bus))
>  		return;
>  
>  	switch (bus->self->class >> 8) {
> -- 
> 1.7.1
> 
