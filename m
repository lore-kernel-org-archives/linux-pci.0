Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752058AbcJQM4v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Oct 2016 08:56:51 -0400
Date: Mon, 17 Oct 2016 07:56:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Jose.Abreu@synopsys.com, CARLOS.PALMINHA@synopsys.com
Subject: Re: [PATCH] pci: changing maintainer
Message-ID: <20161017125646.GA18903@localhost>
References: <0c901c49ad655165e5f72245e9d260f43968cf9e.1476379239.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0c901c49ad655165e5f72245e9d260f43968cf9e.1476379239.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 06:26:13PM +0100, Joao Pinto wrote:
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

Applied to for-linus for v4.9, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01bff8e..5ac91d8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9052,7 +9052,7 @@ S:	Maintained
>  F:	drivers/pci/host/*designware*
>  
>  PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
> -M:	Joao Pinto <jpinto@synopsys.com>
> +M:	Jose Abreu <Jose.Abreu@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
