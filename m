Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965305AbeEXNho (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 09:37:44 -0400
Date: Thu, 24 May 2018 08:37:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Myron Stowe <myron.stowe@redhat.com>,
        Dave Fugate <david.fugate@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] x86/PCI: Add additional VMD device root ports to VMD
 AER quirk
Message-ID: <20180524133742.GB95348@bhelgaas-glaptop.roam.corp.google.com>
References: <20180518192802.20371-1-jonathan.derrick@intel.com>
 <20180518192802.20371-5-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518192802.20371-5-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 01:28:01PM -0600, Jon Derrick wrote:
> VMD devices change the source id of messages from child devices to the
> VMD endpoint. This patch adds additional VMD root port device ids to the
> AER quirk which requires walking the bus to determine which devices were
> throwing the error.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Can you pick up this series, Lorenzo?

> ---
>  arch/x86/pci/fixup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 54ef19e90705..13f4485ca388 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -636,6 +636,10 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334a, quirk_no_aersid);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334b, quirk_no_aersid);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334c, quirk_no_aersid);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334d, quirk_no_aersid);
>  
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  
> -- 
> 2.14.3
> 
