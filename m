Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39157 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbaBNSWI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 13:22:08 -0500
Received: by mail-ob0-f182.google.com with SMTP id wm4so14291340obc.41
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 10:22:08 -0800 (PST)
Date: Fri, 14 Feb 2014 11:22:04 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] PCI: Update outdated comment for
 pcibios_bus_report_status
Message-ID: <20140214182204.GA31093@google.com>
References: <1392292663-61468-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392292663-61468-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 13, 2014 at 07:57:43PM +0800, Yijing Wang wrote:
> pci_find_device() has been superseded by pci_get_device().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to my pci/misc branch for v3.15, thanks!

> ---
>  arch/arm/kernel/bios32.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 317da88..588ec19 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -19,7 +19,7 @@
>  static int debug_pci;
>  
>  /*
> - * We can't use pci_find_device() here since we are
> + * We can't use pci_get_device() here since we are
>   * called from interrupt context.
>   */
>  static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, int warn)
> -- 
> 1.7.1
> 
> 
