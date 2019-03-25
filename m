Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0EAC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 21:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4732083D
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553550670;
	bh=Iy1CDnFErlvFInVMLBtWRRhdbBwy2pb0dVURBJT0vZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LmZpmXe3SRdTYg3SYKkloDDpS8Vwxc//HKeF4TDSgfbWW50Ppy+5gRpyijQ9rHasq
	 xbHtzyS0zsv6Ik/FPzBiCrtsGZlsrpcBrRW3TIEru4mcCZ7ODkTVVDhz8KxiaFbxTL
	 6vfNJG7g4my0kzgqHwAD6ZrbsJ80IbrInJKs9LBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfCYVvK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbfCYVvJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 17:51:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0CF7206DF;
        Mon, 25 Mar 2019 21:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553550668;
        bh=Iy1CDnFErlvFInVMLBtWRRhdbBwy2pb0dVURBJT0vZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4mXjQEC7aYK2z3HNc7+OcJpARrfJbYR3Ptqmi6SS8tvHAm0epjVHoLFtQgS4l4DT
         qtRP9DgL+IFuH4PWEJECuIuK8p8TFFnTGi9hSi+I1fiC7ACQdKdPz0vpV6fXqmVvHi
         ZeED8MfCcIduYMTmaAl+o/UC7LyyFwU18TQnaz4s=
Date:   Mon, 25 Mar 2019 16:51:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] pci: pcie-xilinx: fix a missing-check bug for
 __get_free_pages
Message-ID: <20190325215105.GB24180@google.com>
References: <d0aa29e9-54c6-bc8b-4827-0562b277265f@arm.com>
 <20190325213113.24705-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325213113.24705-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kangjie,

Thanks for the patch!

Please update the subject line like this:

  PCI: xilinx: Check for __get_free_pages() failure

You can always get a good idea of the style for subject lines by doing
something like this:

  git log --oneline --follow drivers/pci/controller/pcie-xilinx.c

On Mon, Mar 25, 2019 at 04:31:13PM -0500, Kangjie Lu wrote:
> In case __get_free_pages fail, the fix returns -ENOMEMto avoid
> NULL pointer dereference.

s/In case/If/
s/__get_free_pages/__get_free_pages()/
s/fail/fails/
s/the fix returns/return/
s/-ENOMEMto/-ENOMEM to/

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Reviewed-by: Steven Price <steven.price@arm.com>

I didn't see Steven's reviewed-by on the mailing list.  I did see his
*review*, but his "Reviewed-by: Steven Price <steven.price@arm.com>"
implies that he reviewed it *and* believes it to ready for merging
(see Documentation/process/submitting-patches.rst for all the
details).

So we should only add the Reviewed-by tag after Steven himself posts
it.

> ---
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
> +	if (unlikely(!port->msi_pages))
> +		return -ENOMEM;

No need to use "unlikely()" here.  It *is* unlikely that
__get_free_pages() will fail, but the annotation clutters the code a
bit, so I prefer to avoid it except for performance paths.

This should probably be documented somewhere in
Documentation/process/, but regrettably, it isn't (yet).

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
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
