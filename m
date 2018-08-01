Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbeHATwE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Aug 2018 15:52:04 -0400
Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, rgummal@xilinx.com
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
Date: Wed, 1 Aug 2018 11:05:09 -0700
MIME-Version: 1.0
In-Reply-To: <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/1/2018 9:44 AM, Bharat Kumar Gogada wrote:
> Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> Error Interrupt Message Number. The controller has dedicated interrupt line
> for reporting PCIe errors along with AER.
> 
> Using dedicated controller irq number for AER which is shared with misc
> interrupt handler in pcie-xilinx-nwl. This irq number is set
> using PCI quirk.
> 
> Signed-off-by: Bharat Kumar Gogada<bharat.kumar.gogada@xilinx.com>
> ---
>   drivers/pci/pcie/portdrv_core.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e0261ad..fa9150e 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>   	int retval;
>   	struct pcie_device *pcie;
>   	struct device *device;
> +#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL)
> +	if (service == PCIE_PORT_SERVICE_AER && pdev->sysdata)
> +		irq = *(int *)pdev->sysdata;
> +#endif
>   

I remember seeing a similar patch before. The patch above looks ugly to
be honest. Need to find a way to generalize this. Can you search the
mailing list archive to find out what the history is?
