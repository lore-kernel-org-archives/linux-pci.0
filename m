Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:37026
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754080Ab2DIDJU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2012 23:09:20 -0400
Message-ID: <4F8252C0.9060002@freescale.com>
Date: Mon, 9 Apr 2012 11:08:48 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: <jbarnes@virtuousgeek.org>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: PCIe: Fix uninitialized variable 'cap_mask'
References: <1331104586-5720-1-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1331104586-5720-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Chunhe Lan wrote:
> Get rid of these:
>
> drivers/pci/pcie/portdrv_core.c: In function 'pcie_port_device_register':
> drivers/pci/pcie/portdrv_core.c:275:16: warning: 'cap_mask' may be used
> uninitialized in this function [-Wuninitialized]
> drivers/pci/pcie/portdrv_core.c:240:6: note: 'cap_mask' was declared here
>
> In some cases, 'cap_mask' may be not set in pcie_port_platform_notify,
> holding a garbage value.
>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 595654a..751b464 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -237,7 +237,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	int services = 0, pos;
>  	u16 reg16;
>  	u32 reg32;
> -	int cap_mask;
> +	int cap_mask = 0;
>  	int err;
>  
>  	if (pcie_ports_disabled)
>   
Hello Jesse Barnes,

  Have you any comment about this patch?
  It locates at http://article.gmane.org/gmane.linux.kernel.pci/14062

  If it has not question, can you merge it to your git tree?

  Thanks.
  -Lan
 


