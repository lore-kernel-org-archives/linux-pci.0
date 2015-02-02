Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:50377 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423AbbBBC2X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 1 Feb 2015 21:28:23 -0500
Message-ID: <1422844101.11325.4.camel@ellerman.id.au>
Subject: Re: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for
 !CONFIG_OF
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kevin Hao <haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 02 Feb 2015 13:28:21 +1100
In-Reply-To: <1422712065-9403-2-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
	 <1422712065-9403-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> So we can avoid the ugly #ifdef in some drivers.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)


Hi Bjorn,

Do you mind putting this into your next for 3.20? Or giving us an ACK for it if
you prefer.

cheers

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8323cbf93913..421eb6a9e600 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1863,6 +1863,8 @@ static inline void pci_set_of_node(struct pci_dev *dev) { }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
>  static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
> +static inline struct device_node *
> +pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
>  #endif  /* CONFIG_OF */
>  
>  #ifdef CONFIG_EEH


