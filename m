Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:41482 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965684AbbBCPbv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 10:31:51 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so29593199obc.4
        for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2015 07:31:50 -0800 (PST)
Date: Tue, 3 Feb 2015 09:31:46 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 01/15] PCI: Add pci_device_to_OF_node() stub for
 !CONFIG_OF
Message-ID: <20150203153146.GA19679@google.com>
References: <1422923108.4625.2.camel@ellerman.id.au>
 <1422927444-31292-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422927444-31292-1-git-send-email-haokexin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 03, 2015 at 09:37:24AM +0800, Kevin Hao wrote:
> Add a stub for pci_device_to_OF_node() so drivers don't need to
> use #ifdef CONFIG_OF around calls to it.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/misc for v3.20, thanks!

> ---
> Hi Bjorn,
> 
> Here is the revised version with the update of the subject and commit log
> in case that you want to take it for 3.20. Otherwise we will merge this
> version to powerpc tree during the 3.21 cycle.
> 
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
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
> -- 
> 1.9.3
> 
