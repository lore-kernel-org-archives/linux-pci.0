Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E249EC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 13:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D982087C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="evEGBkRe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Uu9h//1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfC0Ngx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:36:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36252 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfC0Ngx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 09:36:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7DF3C6110F; Wed, 27 Mar 2019 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693811;
        bh=joPWq+7/TbS8Zvg/jE0bn2Zy5AjH8o/6gogU2N/f6YA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=evEGBkRek8A0VK8m4ORo8LPwsA9a9BPhqmamIkNjVr7gkr9pCMrqsmoSpl1L3gG13
         BcMdQpf0+NONcfd+ZyZEwrAohhDr1ChOXfxb2YDFciHCR5kOWnR6VqHWjFqAn0SWsS
         F4RLVmQXd8Xb82bvCIKPgmaJgCdVsoiQoH/k1AO4=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 318BA60E5D;
        Wed, 27 Mar 2019 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553693809;
        bh=joPWq+7/TbS8Zvg/jE0bn2Zy5AjH8o/6gogU2N/f6YA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Uu9h//1KBj5VavrSEdI92IbDDztK1fQ7nkueOI+ybKCXLPsNAT7m1WRSeq2i4ic0g
         Z54Q2QJW60+CeG+bcxJGYyF/tVr2XkjkrzHY9WOisxbI8Y8p2COjpjJnxr4FBCP4EB
         2DAMvVexEbDItl6PEdH2gfm6KNMBLtzewuvI+0G0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 318BA60E5D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] PCI: xilinx: Check for __get_free_pages() failure
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190325215105.GB24180@google.com>
 <20190325221909.26315-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <97060ae9-0018-d9f3-960d-41b519325779@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:06:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325221909.26315-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/26/2019 3:49 AM, Kangjie Lu wrote:
> If __get_free_pages() fails, the patch returns -ENOMEM to avoid
> NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
> v3: remove "unlikely", as suggested by Bjorn Helgaas.
> v2: caller is redefined to accept the error code, as suggested by
> Steven Price <steven.price@arm.com>
> ---
>   drivers/pci/controller/pcie-xilinx.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 9bd1a35cd5d8..abc214e94f7c 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -336,14 +336,19 @@ static const struct irq_domain_ops msi_domain_ops = {
>    * xilinx_pcie_enable_msi - Enable MSI support
>    * @port: PCIe port information
>    */
> -static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
> +static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
>   {
>   	phys_addr_t msg_addr;
>   
>   	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
> +	if (!port->msi_pages)
> +		return -ENOMEM;
> +
>   	msg_addr = virt_to_phys((void *)port->msi_pages);
>   	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
>   	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
> +
> +	return 0;
>   }
>   
>   /* INTx Functions */
> @@ -498,6 +503,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>   	struct device *dev = port->dev;
>   	struct device_node *node = dev->of_node;
>   	struct device_node *pcie_intc_node;
> +	int ret;
>   
>   	/* Setup INTx */
>   	pcie_intc_node = of_get_next_child(node, NULL);
> @@ -526,7 +532,9 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
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
