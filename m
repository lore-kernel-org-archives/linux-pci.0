Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62738 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaIPXKp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Sep 2014 19:10:45 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so769283pad.28
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 16:10:44 -0700 (PDT)
Date: Tue, 16 Sep 2014 17:10:40 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Megan Kamiya <megan.a.kamiya@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Parenthesize parameters in PCI_DEVID and
 PCI_VPD_LRDT_ID macros
Message-ID: <20140916231040.GF5050@google.com>
References: <1409973550-29434-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409973550-29434-1-git-send-email-jeffrey.t.kirsher@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 05, 2014 at 08:19:10PM -0700, Jeff Kirsher wrote:
> From: Megan Kamiya <megan.a.kamiya@intel.com>
> 
> Add parentheses around parameters in PCI_DEVID and PCI_VPD_LRDT_ID
> macros to prevent possible expansion errors as described by the CERT
> Secure Coding Standard: PRE01-C: Use parentheses within macros around
> parameter names
> 
> Signed-off-by: Megan Kamiya <megan.a.kamiya@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Applied to pci/misc for v3.18, thanks!

> ---
>  include/linux/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 61978a4..cb744f3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -45,7 +45,7 @@
>   * In the interest of not exposing interfaces to user-space unnecessarily,
>   * the following kernel-only defines are being added here.
>   */
> -#define PCI_DEVID(bus, devfn)  ((((u16)bus) << 8) | devfn)
> +#define PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn))
>  /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
>  
> @@ -1701,7 +1701,7 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
>  
>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
> -#define PCI_VPD_LRDT_ID(x)		(x | PCI_VPD_LRDT)
> +#define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
>  
>  /* Large Resource Data Type Tag Item Names */
>  #define PCI_VPD_LTIN_ID_STRING		0x02	/* Identifier String */
> -- 
> 1.9.3
> 
