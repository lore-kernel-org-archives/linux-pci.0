Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35922 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdHASO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 14:14:56 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15so2362143qta.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Aug 2017 11:14:56 -0700 (PDT)
Date: Tue, 1 Aug 2017 14:14:53 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v3 06/16] ntb: ensure ntb_mw_get_align() is only called
 when the link is up
Message-ID: <20170801181452.GE4186@kudzu.us>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725205753.4735-7-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 02:57:43PM -0600, Logan Gunthorpe wrote:
> With Switchtec hardware it's impossible to get the alignment parameters
> for a peer's memory window until the peer's driver has configured it's
> windows. Strictly speaking, the link doesn't have to be up for this,
> but the link being up is the only way the client can tell that
> the otherside has been configured.
> 
> This patch converts ntb_transport and ntb_perf to use this function after
> the link goes up. This simplifies these clients slightly because they
> no longer have to store the alignment parameters. It also tweaks
> ntb_tool so that peer_mw_trans will print zero if it is run before
> the link goes up.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

This also looks like a bug fix.  However, given that it is a little more
invasive and no one reporting any problems with it, I'm less apt to
pull it into the bug-fixes branch without anyone compilaining of a
bug (lest I break something in -stable).

Thanks,
Jon

> ---
>  drivers/ntb/ntb_transport.c | 20 ++++++++++----------
>  drivers/ntb/test/ntb_perf.c | 18 +++++++++---------
>  drivers/ntb/test/ntb_tool.c |  6 +++---
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index b29558ddfe95..7ed745aaa213 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -191,8 +191,6 @@ struct ntb_transport_qp {
>  struct ntb_transport_mw {
>  	phys_addr_t phys_addr;
>  	resource_size_t phys_size;
> -	resource_size_t xlat_align;
> -	resource_size_t xlat_align_size;
>  	void __iomem *vbase;
>  	size_t xlat_size;
>  	size_t buff_size;
> @@ -687,13 +685,20 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
>  	struct pci_dev *pdev = nt->ndev->pdev;
>  	size_t xlat_size, buff_size;
> +	resource_size_t xlat_align;
> +	resource_size_t xlat_align_size;
>  	int rc;
>  
>  	if (!size)
>  		return -EINVAL;
>  
> -	xlat_size = round_up(size, mw->xlat_align_size);
> -	buff_size = round_up(size, mw->xlat_align);
> +	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
> +			      &xlat_align_size, NULL);
> +	if (rc)
> +		return rc;
> +
> +	xlat_size = round_up(size, xlat_align_size);
> +	buff_size = round_up(size, xlat_align);
>  
>  	/* No need to re-setup */
>  	if (mw->xlat_size == xlat_size)
> @@ -722,7 +727,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	 * is a requirement of the hardware. It is recommended to setup CMA
>  	 * for BAR sizes equal or greater than 4MB.
>  	 */
> -	if (!IS_ALIGNED(mw->dma_addr, mw->xlat_align)) {
> +	if (!IS_ALIGNED(mw->dma_addr, xlat_align)) {
>  		dev_err(&pdev->dev, "DMA memory %pad is not aligned\n",
>  			&mw->dma_addr);
>  		ntb_free_mw(nt, num_mw);
> @@ -1106,11 +1111,6 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  	for (i = 0; i < mw_count; i++) {
>  		mw = &nt->mw_vec[i];
>  
> -		rc = ntb_mw_get_align(ndev, PIDX, i, &mw->xlat_align,
> -				      &mw->xlat_align_size, NULL);
> -		if (rc)
> -			goto err1;
> -
>  		rc = ntb_peer_mw_get_addr(ndev, i, &mw->phys_addr,
>  					  &mw->phys_size);
>  		if (rc)
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 759f772fa00c..427112cf101a 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -108,8 +108,6 @@ MODULE_PARM_DESC(on_node, "Run threads only on NTB device node (default: true)")
>  struct perf_mw {
>  	phys_addr_t	phys_addr;
>  	resource_size_t	phys_size;
> -	resource_size_t	xlat_align;
> -	resource_size_t	xlat_align_size;
>  	void __iomem	*vbase;
>  	size_t		xlat_size;
>  	size_t		buf_size;
> @@ -472,13 +470,20 @@ static int perf_set_mw(struct perf_ctx *perf, resource_size_t size)
>  {
>  	struct perf_mw *mw = &perf->mw;
>  	size_t xlat_size, buf_size;
> +	resource_size_t	xlat_align;
> +	resource_size_t	xlat_align_size;
>  	int rc;
>  
>  	if (!size)
>  		return -EINVAL;
>  
> -	xlat_size = round_up(size, mw->xlat_align_size);
> -	buf_size = round_up(size, mw->xlat_align);
> +	rc = ntb_mw_get_align(perf->ntb, PIDX, 0, &xlat_align,
> +			      &xlat_align_size, NULL);
> +	if (rc)
> +		return rc;
> +
> +	xlat_size = round_up(size, xlat_align_size);
> +	buf_size = round_up(size, xlat_align);
>  
>  	if (mw->xlat_size == xlat_size)
>  		return 0;
> @@ -567,11 +572,6 @@ static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
>  
>  	mw = &perf->mw;
>  
> -	rc = ntb_mw_get_align(ntb, PIDX, 0, &mw->xlat_align,
> -			      &mw->xlat_align_size, NULL);
> -	if (rc)
> -		return rc;
> -
>  	rc = ntb_peer_mw_get_addr(ntb, 0, &mw->phys_addr, &mw->phys_size);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index a69815c45ce6..91526a986caa 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -753,9 +753,9 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
>  
>  	phys_addr_t base;
>  	resource_size_t mw_size;
> -	resource_size_t align_addr;
> -	resource_size_t align_size;
> -	resource_size_t max_size;
> +	resource_size_t align_addr = 0;
> +	resource_size_t align_size = 0;
> +	resource_size_t max_size = 0;
>  
>  	buf_size = min_t(size_t, size, 512);
>  
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20170725205753.4735-7-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
