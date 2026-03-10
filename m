Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A73859C7
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142637; cv=none; b=upAbEyBo9qdEqD/SD+3oPkFjeAWaT3EWgfKMGx8QdMUIqljsj45qHeLlfga92rtppwFNcER20p6K70u2dyFGv3AupBcDlqmW6zronkDXurAxKe+jp7FlviFXDKOXt28vUJcDzxoc3K0O0fCesVrcR3jJ3nqC3v8XSP+WwIjjt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142637; c=relaxed/simple;
	bh=wfQo3G1VdAcgol/HRvdVZRGaZRNEhdOv8p8rm/8p2+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L74mFFutW+HcTWJUoSbb5uCwvAK/9a1q6ThGqNQUMDs304iKkufwMWtfoRNyucB/2CozuKuO6lJXrjCUUn7FhoIT4ddxF7WNA7HYvDSay+UbB9LNm2tzIsLjhKOMwNf1y6i+Ct7zqWk5kNdFEg0PRIocwei7nKKUmEogM4TEVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLkMYD3y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLkMYD3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773142636; x=1804678636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wfQo3G1VdAcgol/HRvdVZRGaZRNEhdOv8p8rm/8p2+w=;
  b=nLkMYD3yqndcIrqPzL9KuF2bn3jvE5Z3EKWzdgeCPv/0XGLYf3gteC4v
   latX0MJU3FNr1p0VMOGu/yqEe3yf6apQlO9cImcTQV+3aDAPZ231FmLTM
   nxzBDiUrJ+oJWtHalXq0Xsz84blYeKNtValMqd2Nrr0VTIF18Df/6WvZm
   tAghp+V+pXn8Xc8KPoWteb5QhCL7BtXEKbwgai3uSjREPKaSYGmnA7VnV
   mwZDEy1v/komqPOSNlQka2qYPvbv16Nab48GwHsIlHbAPpCUe6BUtUogQ
   VFLfDz5a3GHQjMUDHb7rc49q7nQ7a9E5MKPk54Hx7ximncwcdQJqWLJRe
   A==;
X-CSE-ConnectionGUID: +zsIKdNsSHepfoHMXAUn2w==
X-CSE-MsgGUID: HvvJMQiySuSs6lM+WrULVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85662719"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85662719"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:37:15 -0700
X-CSE-ConnectionGUID: TSz16qltT7iAOKBTtOnBNA==
X-CSE-MsgGUID: 7RkwOCdrRtKmeC9VswEKaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="243098885"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.33])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:37:13 -0700
Date: Tue, 10 Mar 2026 13:37:10 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/5] vgaarb: pass errors from pci_set_vga_state() up
Message-ID: <abACZiX80vhQP0d-@intel.com>
References: <20260307173538.763188-1-Simon.Richter@hogyros.de>
 <20260307173538.763188-3-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307173538.763188-3-Simon.Richter@hogyros.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Sun, Mar 08, 2026 at 02:35:35AM +0900, Simon Richter wrote:
> pci_set_vga_state() returns an error code, which so far has been ignored by
> the only caller, __vga_tryget(), so forward it to the caller. As the return
> type of __vga_tryget() is a pointer, wrap the error in ERR_PTR().
> 
> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> ---
>  drivers/pci/vgaarb.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 22b2b6ebdefd..c360eee11dd9 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -215,6 +215,7 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  	struct vga_device *conflict;
>  	unsigned int pci_bits;
>  	u32 flags = 0;
> +	int err;
>  
>  	/*
>  	 * Account for "normal" resources to lock. If we decode the legacy,
> @@ -307,7 +308,9 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  		if (change_bridge)
>  			flags |= PCI_VGA_STATE_CHANGE_BRIDGE;
>  
> -		pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
> +		err = pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
> +		if (err)
> +			return ERR_PTR(err);

I was thinking this one should never fail and maybe could warrant
a WARN, but uv_set_vga_state() involves some kind of BIOS call and
who knows what that does. So maybe a WARN isn't a good idea.

>  		conflict->owns &= ~match;
>  
>  		/* If we disabled normal decoding, reflect it in owns */
> @@ -337,7 +340,9 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  	if (wants & VGA_RSRC_LEGACY_MASK)
>  		flags |= PCI_VGA_STATE_CHANGE_BRIDGE;
>  
> -	pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
> +	err = pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
> +	if (err)
> +		return ERR_PTR(err);
>  
>  	vgadev->owns |= wants;
>  lock_them:
> @@ -455,6 +460,10 @@ int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible)
>  		}
>  		conflict = __vga_tryget(vgadev, rsrc);
>  		spin_unlock_irqrestore(&vga_lock, flags);
> +		if (IS_ERR(conflict)) {
> +			rc = PTR_ERR(conflict);
> +			break;
> +		}
>  		if (conflict == NULL)
>  			break;
>  
> -- 
> 2.47.3

-- 
Ville Syrjälä
Intel
