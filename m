Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Colin King <colin.king@canonical.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171005100145.29309-1-colin.king@canonical.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <985dc2ab-8ba6-3bb7-502d-4927427e2fa8@deltatee.com>
Date: Thu, 5 Oct 2017 09:37:09 -0600
MIME-Version: 1.0
In-Reply-To: <20171005100145.29309-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] switchtec: make struct event_regs static
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks!

Acked-by: Logan Gunthorpe <logang@deltatee.com>

On 10/5/2017 4:01 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure event_regs is local to the source and does not need to
> be in global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'event_regs' was not declared. Should it be static
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/pci/switch/switchtec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index af81b2dec42e..da45dbea20ce 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -943,7 +943,7 @@ static u32 __iomem *pff_ev_reg(struct switchtec_dev *stdev,
>   #define EV_PAR(i, r)[i] = {offsetof(struct part_cfg_regs, r), part_ev_reg}
>   #define EV_PFF(i, r)[i] = {offsetof(struct pff_csr_regs, r), pff_ev_reg}
>   
> -const struct event_reg {
> +static const struct event_reg {
>   	size_t offset;
>   	u32 __iomem *(*map_reg)(struct switchtec_dev *stdev,
>   				size_t offset, int index);
> 
