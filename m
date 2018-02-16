Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752984AbeBPAmO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Feb 2018 19:42:14 -0500
Date: Thu, 15 Feb 2018 18:42:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] rapidio/tsi721: use PCI_EXP_DEVCTL2_COMP_TIMEOUT macro
Message-ID: <20180216004210.GC195653@bhelgaas-glaptop.roam.corp.google.com>
References: <20171215225952.177299.86044.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <8D983423E7EDF846BB3056827B8CC5D161B3B7F7@corpmail1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8D983423E7EDF846BB3056827B8CC5D161B3B7F7@corpmail1>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 18, 2017 at 03:25:19PM +0000, Bounine, Alexandre wrote:
> Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
> 
> Hi Andrew,
> 
> Please apply the patch below.

Applied with Alexandre's ack to pci/misc for v4.17.

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
> Sent: Friday, December 15, 2017 6:00 PM
> To: Bounine, Alexandre <Alexandre.Bounine@idt.com>; Matt Porter <mporter@kernel.crashing.org>
> Cc: linux-pci@vger.kernel.org
> Subject: [PATCH] rapidio/tsi721: use PCI_EXP_DEVCTL2_COMP_TIMEOUT macro
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use the existing PCI_EXP_DEVCTL2_COMP_TIMEOUT macro instead of hard-coding
> the PCIe Completion Timeout Value mask.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/rapidio/devices/tsi721.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
> index 9a68914100ad..bb655854713d 100644
> --- a/drivers/rapidio/devices/tsi721.c
> +++ b/drivers/rapidio/devices/tsi721.c
> @@ -2880,8 +2880,9 @@ static int tsi721_probe(struct pci_dev *pdev,
>  				 "Invalid MRRS override value %d", pcie_mrrs);
>  	}
>  
> -	/* Adjust PCIe completion timeout. */
> -	pcie_capability_clear_and_set_word(pdev, PCI_EXP_DEVCTL2, 0xf, 0x2);
> +	/* Set PCIe completion timeout to 1-10ms */
> +	pcie_capability_clear_and_set_word(pdev, PCI_EXP_DEVCTL2,
> +					   PCI_EXP_DEVCTL2_COMP_TIMEOUT, 0x2);
>  
>  	/*
>  	 * FIXUP: correct offsets of MSI-X tables in the MSI-X Capability Block
> 
