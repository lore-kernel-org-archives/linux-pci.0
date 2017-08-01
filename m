Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36842 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdHAS76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 14:59:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id d136so2471459qkg.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Aug 2017 11:59:58 -0700 (PDT)
Date: Tue, 1 Aug 2017 14:59:55 -0400
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
Subject: Re: [PATCH v3 13/16] switchtec_ntb: implement doorbell registers
Message-ID: <20170801185954.GI4186@kudzu.us>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725205753.4735-14-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 02:57:50PM -0600, Logan Gunthorpe wrote:
> Pretty straightforward implementation of doorbell registers.
> The shift and mask were setup in an earlier patch and this just hooks
> up the appropriate portion of the IDB register as the local doorbells
> and the opposite portion of ODB as the peer doorbells. The DB mask is
> protected by a spinlock to avoid concurrent read-modify-write accesses.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 89 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
> index 34d69fa8612d..3037ca730998 100644
> --- a/drivers/ntb/hw/mscc/switchtec_ntb.c
> +++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
> @@ -98,6 +98,9 @@ struct switchtec_ntb {
>  	int db_shift;
>  	int db_peer_shift;
>  
> +	/* synchronize rmw access of db_mask and hw reg */
> +	spinlock_t db_mask_lock;
> +
>  	int nr_direct_mw;
>  	int nr_lut_mw;
>  	int direct_mw_to_bar[MAX_DIRECT_MW];
> @@ -338,41 +341,115 @@ static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
>  
>  static u64 switchtec_ntb_db_valid_mask(struct ntb_dev *ntb)
>  {
> -	return 0;
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	return sndev->db_valid_mask;
>  }
>  
>  static int switchtec_ntb_db_vector_count(struct ntb_dev *ntb)
>  {
> -	return 0;
> +	return 1;
>  }
>  
>  static u64 switchtec_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector)
>  {
> -	return 0;
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	if (db_vector < 0 || db_vector > 1)
> +		return 0;
> +
> +	return sndev->db_valid_mask;
>  }
>  
>  static u64 switchtec_ntb_db_read(struct ntb_dev *ntb)
>  {
> -	return 0;
> +	u64 ret;
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	ret = ioread64(&sndev->mmio_self_dbmsg->idb) >> sndev->db_shift;
> +
> +	return ret & sndev->db_valid_mask;
>  }
>  
>  static int switchtec_ntb_db_clear(struct ntb_dev *ntb, u64 db_bits)
>  {
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	iowrite64(db_bits << sndev->db_shift, &sndev->mmio_self_dbmsg->idb);
> +
>  	return 0;
>  }
>  
>  static int switchtec_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
>  {
> +	unsigned long irqflags;
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	if (db_bits & ~sndev->db_valid_mask)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&sndev->db_mask_lock, irqflags);
> +	{
> +		sndev->db_mask |= db_bits << sndev->db_shift;
> +		iowrite64(~sndev->db_mask, &sndev->mmio_self_dbmsg->idb_mask);
> +	}

unnecessary braces.  Same for below

> +	spin_unlock_irqrestore(&sndev->db_mask_lock, irqflags);
> +
>  	return 0;
>  }
>  
>  static int switchtec_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
>  {
> +	unsigned long irqflags;
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	if (db_bits & ~sndev->db_valid_mask)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&sndev->db_mask_lock, irqflags);
> +	{
> +		sndev->db_mask &= ~(db_bits << sndev->db_shift);
> +		iowrite64(~sndev->db_mask, &sndev->mmio_self_dbmsg->idb_mask);
> +	}
> +	spin_unlock_irqrestore(&sndev->db_mask_lock, irqflags);
> +
> +	return 0;
> +}
> +
> +static u64 switchtec_ntb_db_read_mask(struct ntb_dev *ntb)
> +{
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	return (sndev->db_mask >> sndev->db_shift) & sndev->db_valid_mask;
> +}
> +
> +static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
> +				      phys_addr_t *db_addr,
> +				      resource_size_t *db_size)
> +{
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +	unsigned long offset;
> +
> +	offset = (unsigned long)sndev->mmio_self_dbmsg->odb -
> +		(unsigned long)sndev->stdev->mmio;
> +
> +	offset += sndev->db_shift / 8;
> +
> +	if (db_addr)
> +		*db_addr = pci_resource_start(ntb->pdev, 0) + offset;
> +	if (db_size)
> +		*db_size = sizeof(u32);
> +
>  	return 0;
>  }
>  
>  static int switchtec_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  {
> +	struct switchtec_ntb *sndev = ntb_sndev(ntb);
> +
> +	iowrite64(db_bits << sndev->db_peer_shift,
> +		  &sndev->mmio_self_dbmsg->odb);
> +
>  	return 0;
>  }
>  
> @@ -413,6 +490,8 @@ static const struct ntb_dev_ops switchtec_ntb_ops = {
>  	.db_clear		= switchtec_ntb_db_clear,
>  	.db_set_mask		= switchtec_ntb_db_set_mask,
>  	.db_clear_mask		= switchtec_ntb_db_clear_mask,
> +	.db_read_mask		= switchtec_ntb_db_read_mask,
> +	.peer_db_addr		= switchtec_ntb_peer_db_addr,
>  	.peer_db_set		= switchtec_ntb_peer_db_set,
>  	.spad_count		= switchtec_ntb_spad_count,
>  	.spad_read		= switchtec_ntb_spad_read,
> @@ -680,6 +759,8 @@ static irqreturn_t switchtec_ntb_doorbell_isr(int irq, void *dev)
>  
>  	dev_dbg(&sndev->stdev->dev, "doorbell\n");
>  
> +	ntb_db_event(&sndev->ntb, 0);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20170725205753.4735-14-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
