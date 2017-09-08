Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:19534 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbdIHL0k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Sep 2017 07:26:40 -0400
Subject: Re: [PATCH 4/4] PCI: xgene: Clean up whitespace
To: Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Scott Branden <sbranden@broadcom.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
References: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170905182721.27030.75771.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <6d9454ac-d238-fc64-04f2-4534b0a419de@free.fr>
Date: Fri, 8 Sep 2017 13:26:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170905182721.27030.75771.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2017 20:27, Bjorn Helgaas wrote:

> Use tabs (not spaces) for indentation.  No functional change intended.

git diff -b should be empty, right?

> @@ -280,12 +280,12 @@ static int xgene_v2_pcie_ecam_init(struct pci_config_window *cfg)
>   }
>   
>   struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
> -	.bus_shift      = 16,
> -	.init           = xgene_v2_pcie_ecam_init,
> -	.pci_ops        = {
> -		.map_bus        = xgene_pcie_map_bus,
> -		.read           = xgene_pcie_config_read32,
> -		.write          = pci_generic_config_write,
> +	.bus_shift	= 16,
> +	.init		= xgene_v2_pcie_ecam_init,
> +	.pci_ops	= {
> +		.map_bus	= xgene_pcie_map_bus,
> +		.read		= xgene_pcie_config_read32,
> +		.writei		= pci_generic_config_write,
>   	}
>   };
>   #endif

Spurious 'i' in '.writei' ;-)

Regards.
