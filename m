Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeIFCBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 22:01:52 -0400
Date: Wed, 5 Sep 2018 16:29:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] switchtec: Fix potential Spectre v1
Message-ID: <20180905212947.GU107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180816190646.GA9610@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180816190646.GA9610@embeddedor.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 02:06:46PM -0500, Gustavo A. R. Silva wrote:
> p.port can is indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/pci/switch/switchtec.c:912 ioctl_port_to_pff() warn: potential
> spectre issue 'pcfg->dsp_pff_inst_id' [r]
> 
> Fix this by sanitizing p.port before using it to index
> pcfg->dsp_pff_inst_id
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied with Logan's ack to for-linus for v4.19, thanks!

> ---
>  drivers/pci/switch/switchtec.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 9940cc7..54a8b30 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -14,6 +14,8 @@
>  #include <linux/poll.h>
>  #include <linux/wait.h>
>  
> +#include <linux/nospec.h>
> +
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
>  MODULE_VERSION("0.1");
>  MODULE_LICENSE("GPL");
> @@ -909,6 +911,8 @@ static int ioctl_port_to_pff(struct switchtec_dev *stdev,
>  	default:
>  		if (p.port > ARRAY_SIZE(pcfg->dsp_pff_inst_id))
>  			return -EINVAL;
> +		p.port = array_index_nospec(p.port,
> +					ARRAY_SIZE(pcfg->dsp_pff_inst_id) + 1);
>  		p.pff = ioread32(&pcfg->dsp_pff_inst_id[p.port - 1]);
>  		break;
>  	}
> -- 
> 2.7.4
> 
