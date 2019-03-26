Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3129CC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 13:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0887E2070B
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 13:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCZNBO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:01:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35996 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCZNBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 09:01:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6A11596;
        Tue, 26 Mar 2019 06:01:13 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4693F59C;
        Tue, 26 Mar 2019 06:01:11 -0700 (PDT)
Subject: Re: [PATCH v2] pci: pcie-xilinx: fix a missing-check bug for
 __get_free_pages
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, kjlu@umn.edu,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190323210423.8881-1-pakki001@umn.edu>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d3d64f70-0db7-6571-c38e-5fdc35c3577f@arm.com>
Date:   Tue, 26 Mar 2019 13:01:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190323210423.8881-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/03/2019 21:04, Aditya Pakki wrote:
> In case __get_free_pages fail, the fix returns error upstream
> to avoid NULL pointer dereference.

Where does msi_pages ever get dereferenced?

The logic here might actually still have a chance of working out OK with 
NULL depending on how the memory maps line up, but even if it doesn't, 
the problem is certainly not one of dereferencing.

Robin.

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> ---
> v1: Return error upstream as suggested by Steven
> ---
>   drivers/pci/controller/pcie-xilinx.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 9bd1a35cd5d8..91d8945bfb0c 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -335,15 +335,19 @@ static const struct irq_domain_ops msi_domain_ops = {
>   /**
>    * xilinx_pcie_enable_msi - Enable MSI support
>    * @port: PCIe port information
> + * Return: 0 on success, negative error on failure
>    */
> -static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
> +static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
>   {
>   	phys_addr_t msg_addr;
>   
>   	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
> +	if (!port->msi_pages)
> +		return -ENOMEM;
>   	msg_addr = virt_to_phys((void *)port->msi_pages);
>   	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
>   	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
> +	return 0;
>   }
>   
>   /* INTx Functions */
> @@ -498,6 +502,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>   	struct device *dev = port->dev;
>   	struct device_node *node = dev->of_node;
>   	struct device_node *pcie_intc_node;
> +	int ret;
>   
>   	/* Setup INTx */
>   	pcie_intc_node = of_get_next_child(node, NULL);
> @@ -526,7 +531,9 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>   			return -ENODEV;
>   		}
>   
> -		xilinx_pcie_enable_msi(port);
> +		ret = xilinx_pcie_enable_msi(port);
> +		if (ret)
> +			return ret;
>   	}
>   
>   	return 0;
> 
