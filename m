Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22506 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbaFSAK6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jun 2014 20:10:58 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7E00ITT368L480@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 19 Jun 2014 09:10:56 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Fabio Estevam' <festevam@gmail.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	'Fabio Estevam' <fabio.estevam@freescale.com>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Mohit Kumar' <mohit.kumar@st.com>
References: <1403104613-9867-1-git-send-email-festevam@gmail.com>
In-reply-to: <1403104613-9867-1-git-send-email-festevam@gmail.com>
Subject: Re: [PATCH] PCI: designware: Use IS_ENABLED()
Date: Thu, 19 Jun 2014 09:10:56 +0900
Message-id: <005201cf8b52$f1006db0$d3014910$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 19, 2014 12:17 AM, Fabio Estevam wrote:
> 
> We can get rid of the 'ifdef' by using the IS_ENABLED() macro.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

(+cc Mohit Kumar)

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 1eaf4df3..dc842fd 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -497,9 +497,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> 
>  	pci_common_init_dev(pp->dev, &dw_pci);
>  	pci_assign_unassigned_resources();
> -#ifdef CONFIG_PCI_DOMAINS
> -	dw_pci.domain++;
> -#endif
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS))
> +		dw_pci.domain++;
> 
>  	return 0;
>  }
> --
> 1.8.3.2

