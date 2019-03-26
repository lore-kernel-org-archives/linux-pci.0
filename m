Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B1C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DAE2070D
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 11:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCZLkz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:40:55 -0400
Received: from foss.arm.com ([217.140.101.70]:34926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfCZLkz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 07:40:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2FCD1596;
        Tue, 26 Mar 2019 04:40:54 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43E933F59C;
        Tue, 26 Mar 2019 04:40:53 -0700 (PDT)
Subject: Re: [PATCH v3] PCI: xilinx: Check for __get_free_pages() failure
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190325215105.GB24180@google.com>
 <20190325221909.26315-1-kjlu@umn.edu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <377aa504-7bfa-4e8d-5db7-fce01c931e28@arm.com>
Date:   Tue, 26 Mar 2019 11:40:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325221909.26315-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/03/2019 22:19, Kangjie Lu wrote:
> If __get_free_pages() fails, the patch returns -ENOMEM to avoid

As Bjorn suggested s/the patch returns/return/ would suffice and is
slightly easier to read. But I'm happy either way.

> NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v3: remove "unlikely", as suggested by Bjorn Helgaas.
> v2: caller is redefined to accept the error code, as suggested by
> Steven Price <steven.price@arm.com>
> ---
>  drivers/pci/controller/pcie-xilinx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 9bd1a35cd5d8..abc214e94f7c 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -336,14 +336,19 @@ static const struct irq_domain_ops msi_domain_ops = {
>   * xilinx_pcie_enable_msi - Enable MSI support
>   * @port: PCIe port information
>   */
> -static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
> +static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
>  {
>  	phys_addr_t msg_addr;
>  
>  	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
> +	if (!port->msi_pages)
> +		return -ENOMEM;
> +
>  	msg_addr = virt_to_phys((void *)port->msi_pages);
>  	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
>  	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
> +
> +	return 0;
>  }
>  
>  /* INTx Functions */
> @@ -498,6 +503,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
>  	struct device_node *pcie_intc_node;
> +	int ret;
>  
>  	/* Setup INTx */
>  	pcie_intc_node = of_get_next_child(node, NULL);
> @@ -526,7 +532,9 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  			return -ENODEV;
>  		}
>  
> -		xilinx_pcie_enable_msi(port);
> +		ret = xilinx_pcie_enable_msi(port);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
> 

