Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbdJEVJv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Oct 2017 17:09:51 -0400
Date: Thu, 5 Oct 2017 16:09:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] switchtec: make struct event_regs static
Message-ID: <20171005210949.GX25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171005100145.29309-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005100145.29309-1-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 05, 2017 at 11:01:45AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure event_regs is local to the source and does not need to
> be in global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'event_regs' was not declared. Should it be static
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied with Logan's ack to pci/switchtec for v4.15, thanks!

> ---
>  drivers/pci/switch/switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index af81b2dec42e..da45dbea20ce 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -943,7 +943,7 @@ static u32 __iomem *pff_ev_reg(struct switchtec_dev *stdev,
>  #define EV_PAR(i, r)[i] = {offsetof(struct part_cfg_regs, r), part_ev_reg}
>  #define EV_PFF(i, r)[i] = {offsetof(struct pff_csr_regs, r), pff_ev_reg}
>  
> -const struct event_reg {
> +static const struct event_reg {
>  	size_t offset;
>  	u32 __iomem *(*map_reg)(struct switchtec_dev *stdev,
>  				size_t offset, int index);
> -- 
> 2.14.1
> 
