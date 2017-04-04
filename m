Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752259AbdDDRED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Apr 2017 13:04:03 -0400
Date: Tue, 4 Apr 2017 12:03:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [TRIVIAL PATCH] PCI: fix typo in doc for pci_cfg_access_lock()
Message-ID: <20170404170359.GC27692@bhelgaas-glaptop.roam.corp.google.com>
References: <20170328004614.12889-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170328004614.12889-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 27, 2017 at 05:46:14PM -0700, Brian Norris wrote:
> There is no pci_cfg_access_unlocked(). I think the author meant
> pci_cfg_access_unlock().
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied to pci/misc for v4.12, thanks!

> ---
>  drivers/pci/access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 8b7382705bf2..20ec96c4239e 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -629,7 +629,7 @@ void pci_vpd_release(struct pci_dev *dev)
>   *
>   * When access is locked, any userspace reads or writes to config
>   * space and concurrent lock requests will sleep until access is
> - * allowed via pci_cfg_access_unlocked again.
> + * allowed via pci_cfg_access_unlock again.
>   */
>  void pci_cfg_access_lock(struct pci_dev *dev)
>  {
> -- 
> 2.12.2.564
