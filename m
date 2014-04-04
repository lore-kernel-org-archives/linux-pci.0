Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:41214 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbaDDVoP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 17:44:15 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so4017799pbc.16
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 14:44:14 -0700 (PDT)
Date: Fri, 4 Apr 2014 15:44:10 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ryan Desfosses <ryan@desfo.org>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: changed '...pci_bus* bus' to '...pci_bus *bus'
Message-ID: <20140404214410.GB13931@google.com>
References: <1396646614-6458-1-git-send-email-ryan@desfo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396646614-6458-1-git-send-email-ryan@desfo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 04, 2014 at 05:23:34PM -0400, Ryan Desfosses wrote:
> change made to resolve following checkpatch message:
>     drivers/pci/pci.c:109: ERROR: "foo* bar" should be "foo *bar"
> branch: Linux 3.14-rc8
> 
> Signed-off-by: Ryan Desfosses <ryan@desfo.org>

Applied (folded into your other patch), thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fdbc294..a50d542 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -106,7 +106,7 @@ static bool pcie_ari_disabled;
>   * Given a PCI bus, returns the highest PCI bus number present in the set
>   * including the given PCI bus and its list of child PCI buses.
>   */
> -unsigned char pci_bus_max_busnr(struct pci_bus* bus)
> +unsigned char pci_bus_max_busnr(struct pci_bus *bus)
>  {
>  	struct list_head *tmp;
>  	unsigned char max, n;
> -- 
> 1.9.1
> 
