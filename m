Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34214 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdHATKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 15:10:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id i19so2536820qte.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Aug 2017 12:10:54 -0700 (PDT)
Date: Tue, 1 Aug 2017 15:10:51 -0400
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
Subject: Re: [PATCH v3 14/16] switchtec_ntb: implement scratchpad registers
Message-ID: <20170801191050.GJ4186@kudzu.us>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725205753.4735-15-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 02:57:51PM -0600, Logan Gunthorpe wrote:
> Seeing there is no dedicated hardware for this, we simply add
> these as entries in the shared memory window. Thus, we could support
> any number of them but 128 seems like enough, for now.

It would probaly be better if I remarked about the SPADs in the actual
patch about the SPADS :)

The whole point of using the SPADs in the NTB driver was to workaround
the problems establishing a connection between the two sides of the
NTB and where everything lives.  So, using a MW to get around the
SPADs is sort of backwards (and slightly funny).  I realize you are
trying to use the existing transport with minimal changes to enable
your hardware, and thus this makes logical sense to you.  However, if
the SPADs are not really needed, then we should either remove them
from the transport (or use them for something else).

Per my comment in the other patch, I'm amenable to take this series
as-is, assuming you are willing to address this design issue in the
near future.  Thoughts?

Thanks,
Jon

> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 75 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
> index 3037ca730998..ca403ad2f7ac 100644
> --- a/drivers/ntb/hw/mscc/switchtec_ntb.c
> +++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
> @@ -67,6 +67,7 @@ struct shared_mw {
>  	u32 link_sta;
>  	u32 partition_id;
>  	u64 mw_sizes[MAX_MWS];
> +	u32 spad[128];
>  };
>  
>  #define MAX_DIRECT_MW ARRAY_SIZE(((struct ntb_ctrl_regs *)(0))->bar_entry)
> @@ -455,22 +456,90 @@ static int switchtec_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  
>  static int switchtec_ntb_spad_count(struct ntb_dev *ntb)
>  {
> -	return 0;
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	return ARRAY_SIZE(sndev->self_shared->spad);
>  }
>  
>  static u32 switchtec_ntb_spad_read(struct ntb_dev *ntb, int idx)
>  {
> -	return 0;
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	if (idx < 0 || idx >= ARRAY_SIZE(sndev->self_shared->spad))
> +		return 0;
> +
> +	if (!sndev->self_shared)
> +		return 0;
> +
> +	return sndev->self_shared->spad[idx];
>  }
>  
>  static int switchtec_ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
>  {
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	if (idx < 0 || idx >= ARRAY_SIZE(sndev->self_shared->spad))
> +		return -EINVAL;
> +
> +	if (!sndev->self_shared)
> +		return -EIO;
> +
> +	sndev->self_shared->spad[idx] = val;
> +
>  	return 0;
>  }
>  
> +static u32 switchtec_ntb_peer_spad_read(struct ntb_dev *ntb, int pidx,
> +					int sidx)
> +{
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	if (pidx != NTB_DEF_PEER_IDX)
> +		return -EINVAL;
> +
> +	if (sidx < 0 || sidx >= ARRAY_SIZE(sndev->peer_shared->spad))
> +		return 0;
> +
> +	if (!sndev->peer_shared)
> +		return 0;
> +
> +	return ioread32(&sndev->peer_shared->spad[sidx]);
> +}
> +
>  static int switchtec_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
>  					 int sidx, u32 val)
>  {
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	if (pidx != NTB_DEF_PEER_IDX)
> +		return -EINVAL;
> +
> +	if (sidx < 0 || sidx >= ARRAY_SIZE(sndev->peer_shared->spad))
> +		return -EINVAL;
> +
> +	if (!sndev->peer_shared)
> +		return -EIO;
> +
> +	iowrite32(val, &sndev->peer_shared->spad[sidx]);
> +
> +	return 0;
> +}
> +
> +static int switchtec_ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx,
> +					int sidx, phys_addr_t *spad_addr)
> +{
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +	unsigned long offset;
> +
> +	if (pidx != NTB_DEF_PEER_IDX)
> +		return -EINVAL;
> +
> +	offset = (unsigned long)&sndev->peer_shared->spad[sidx] -
> +		(unsigned long)sndev->stdev->mmio;
> +
> +	if (spad_addr)
> +		*spad_addr = pci_resource_start(ntb->pdev, 0) + offset;
> +
>  	return 0;
>  }
>  
> @@ -496,7 +565,9 @@ static const struct ntb_dev_ops switchtec_ntb_ops = {
>  	.spad_count		= switchtec_ntb_spad_count,
>  	.spad_read		= switchtec_ntb_spad_read,
>  	.spad_write		= switchtec_ntb_spad_write,
> +	.peer_spad_read		= switchtec_ntb_peer_spad_read,
>  	.peer_spad_write	= switchtec_ntb_peer_spad_write,
> +	.peer_spad_addr		= switchtec_ntb_peer_spad_addr,
>  };
>  
>  static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
> -- 
> 2.11.0
> 
