Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11F4C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF8A218FC
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCVQ0c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:26:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49028 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfCVQ0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 12:26:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00D5EA78;
        Fri, 22 Mar 2019 09:26:32 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1603F59C;
        Fri, 22 Mar 2019 09:26:30 -0700 (PDT)
Subject: Re: [PATCH] pci: pcie-xilinx: fix a missing-check bug for
 __get_free_pages
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190314055851.6884-1-kjlu@umn.edu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d0aa29e9-54c6-bc8b-4827-0562b277265f@arm.com>
Date:   Fri, 22 Mar 2019 16:26:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314055851.6884-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/03/2019 05:58, Kangjie Lu wrote:
> In case __get_free_pages fail, the fix returns to avoid NULL
> pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/pci/controller/pcie-xilinx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 9bd1a35cd5d8..b7083e995c45 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -341,6 +341,9 @@ static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
>  	phys_addr_t msg_addr;
>  
>  	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
> +	if (unlikely(!port->msi_pages))
> +		return;

Shouldn't the function return an error code for the calling function to
see? With this change the caller (xilinx_pcie_init_irq_domain) will
think that MSIs were enabled, but actually they weren't.

Steve

> +
>  	msg_addr = virt_to_phys((void *)port->msi_pages);
>  	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
>  	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
> 

