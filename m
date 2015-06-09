Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Jun 2015 11:24:52 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 03/18] NTB: Read peer info from local SPAD in transport
Message-ID: <20150609162452.GD23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <29c8beeb128ad2e86ee21dfebb5fb39056b47e93.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29c8beeb128ad2e86ee21dfebb5fb39056b47e93.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 05:44:30AM -0400, Allen Hubbe wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Importance:	High

Looks like junk, maybe inadvertently copied from an email header?

> The transport was writing and then reading the peer spad, essentially
> reading what it just wrote instead of exchanging any information with
> the peer.  The transport expects the peer values to be the same as the
> local values, so this issue was not obvious.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9faf1c6029af..d9538e911df6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -761,17 +761,17 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	ntb_peer_spad_write(ndev, VERSION, NTB_TRANSPORT_VERSION);
>  
>  	/* Query the remote side for its info */
> -	val = ntb_peer_spad_read(ndev, VERSION);
> +	val = ntb_spad_read(ndev, VERSION);
>  	dev_dbg(&pdev->dev, "Remote version = %d\n", val);
>  	if (val != NTB_TRANSPORT_VERSION)
>  		goto out;
>  
> -	val = ntb_peer_spad_read(ndev, NUM_QPS);
> +	val = ntb_spad_read(ndev, NUM_QPS);
>  	dev_dbg(&pdev->dev, "Remote max number of qps = %d\n", val);
>  	if (val != nt->qp_count)
>  		goto out;
>  
> -	val = ntb_peer_spad_read(ndev, NUM_MWS);
> +	val = ntb_spad_read(ndev, NUM_MWS);
>  	dev_dbg(&pdev->dev, "Remote number of mws = %d\n", val);
>  	if (val != nt->mw_count)
>  		goto out;
> @@ -779,10 +779,10 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	for (i = 0; i < nt->mw_count; i++) {
>  		u64 val64;
>  
> -		val = ntb_peer_spad_read(ndev, MW0_SZ_HIGH + (i * 2));
> +		val = ntb_spad_read(ndev, MW0_SZ_HIGH + (i * 2));
>  		val64 = (u64)val << 32;
>  
> -		val = ntb_peer_spad_read(ndev, MW0_SZ_LOW + (i * 2));
> +		val = ntb_spad_read(ndev, MW0_SZ_LOW + (i * 2));
>  		val64 |= val;
>  
>  		dev_dbg(&pdev->dev, "Remote MW%d size = %#llx\n", i, val64);
> -- 
> 2.4.0.rc0.43.gcf8a8c6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
