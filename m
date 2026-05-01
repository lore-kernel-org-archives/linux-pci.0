Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571A2E6CB3;
	Fri,  1 May 2026 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652993; cv=none; b=pT6FblGfnzTSEB9fJR9Cj0PCfxpuEsbCMpl589uY9eG8V4vozObsXVtEkcOML1CyutWFQ4r/17bYGgU+6lk0uZgNh6R4NcvA3ESmvkJ4EXtHoKBTXiFDZ0DYMwZ7rH8dEp0yeT6FJZDIgAUfJMuZ1ZdBo+/xTw2fBFXujVP8m00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652993; c=relaxed/simple;
	bh=cT57DQJwEZ9wXBMt1SuLsrsTBfq6hlX25JO8vLFm27Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P01WKuv5NZUxTuTydpGcz+KdQhUZFwJ4C6TLK8WyL+5ur+2qs95Ho3/WW3gB7IRjrgxqWytQ1eyIDplbt7C88ZTwj5c/EOi688U2o3rpNnokU49QmeEKkTTEYua9zWG+1lvbKyiIaqo7tc7WlRRP7qskLW5IBNPSjCEuV3VPPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLy28P8Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLy28P8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD851C2BCB4;
	Fri,  1 May 2026 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777652990;
	bh=cT57DQJwEZ9wXBMt1SuLsrsTBfq6hlX25JO8vLFm27Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLy28P8QoKPlLWSXhV0UL6Evl41iNIdwCNdUnoJP9Ajw/NJfrQCZ5Jk/+OZ17HBDb
	 m7CpMHGfoA6t6DubFJEpJpjegYBYr5vNUd4sql/hDInj/NOF9S+t5uYeZLi29lTr+I
	 UxsfJP1BqYgG94HrVshdeqYA/Ul04j8cGZpSPZIRjEcxHOPCLqCKEfvddSRT9qH4oR
	 A0P6m0Gt15QE1vVU0Bc9rVUSW/MNebD/pI+/nYwHqrEBl2TsjA1ie1azPxUgtSebxm
	 XF1Kouy1MUj8KVMXk2kSf0/hsKmVbLuN8qljnu3qHONus0Qv1chodNOd6Javk5YNNh
	 IDUS5JpvJCbmA==
Date: Fri, 1 May 2026 21:59:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v3 09/10] NTB: epf: Fix doorbell bitmask handling in
 db_read/db_clear
Message-ID: <557gikafd5b5gryyosswktl7knexnu5gzhtd5ybgxkvdb56ftu@6ytkbxd5j57h>
References: <20260323031544.2598111-1-den@valinux.co.jp>
 <20260323031544.2598111-10-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323031544.2598111-10-den@valinux.co.jp>

On Mon, Mar 23, 2026 at 12:15:43PM +0900, Koichiro Den wrote:
> The EPF driver currently stores the incoming doorbell as a vector number
> (irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
> This breaks db_read()/db_clear() semantics when multiple doorbells are
> used.
> 
> Store doorbells as a bitmask (BIT_ULL(vector)) and make
> db_clear(db_bits) clear only the specified bits. Use atomic64 operations
> as db_val is updated from interrupt context.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

On this patch too, but some pre-existing issues as well:

https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp?part=9

- Mani

> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 67cdc5d729d5..741d30821390 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -108,7 +109,7 @@ struct ntb_epf_dev {
>  	unsigned int self_spad;
>  	unsigned int peer_spad;
>  
> -	int db_val;
> +	atomic64_t db_val;
>  	u64 db_valid_mask;
>  };
>  
> @@ -337,15 +338,16 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  	int irq_no;
>  
>  	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
> -	ndev->db_val = irq_no + 1;
>  
>  	if (irq_no == EPF_IRQ_LINK) {
>  		ntb_link_event(&ndev->ntb);
>  	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
>  		dev_warn_ratelimited(ndev->dev,
>  				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
> +		atomic64_or(BIT_ULL(0), &ndev->db_val);
>  		ntb_db_event(&ndev->ntb, 0);
>  	} else {
> +		atomic64_or(BIT_ULL(irq_no - EPF_IRQ_DB_START), &ndev->db_val);
>  		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
>  	}
>  
> @@ -530,7 +532,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  
> -	return ndev->db_val;
> +	return atomic64_read(&ndev->db_val);
>  }
>  
>  static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
> @@ -542,7 +544,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  
> -	ndev->db_val = 0;
> +	atomic64_and(~db_bits, &ndev->db_val);
>  
>  	return 0;
>  }
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்
