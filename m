Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF4477288;
	Mon, 21 Sep 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987205; cv=none; b=OBSvxrCVLIxc70Af2vxQy/9x/PJfFSa7kfq72xx7UtTesHChJCUzXynqpBV3pfOGUR937DXuDGYnNq8cLLX+it0Zy5tv4Zt41312DWjnxfwXV806d2s9hqNfymJp9SaIishs8tIIu3LRHDZ+kHsxQ7ewekNNXsQP6NDGPC9Curg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987205; c=relaxed/simple;
	bh=Ad6fpYFCwCgyEm0jJN8fMhX4f6iQUwkGcN+NiWPLSVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rYAZRhW8uy3Fqf0vPsmmC82dGp4nAo/+OOq7HcOm8N+EeQBYieF/wWjaAEIB0DK3xD4ildfUwG5DR2SbHRsbiCAkuvZQsTIlQcMRNeDxb+YyhaMgR2nddGZINlBBtKl0cQFVHNTVqLiO8Fch6i9KOifzSIQuNDP3dX9rVS/8RSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ir2w5z8T; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ir2w5z8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789987203; x=1821523203;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Ad6fpYFCwCgyEm0jJN8fMhX4f6iQUwkGcN+NiWPLSVk=;
  b=ir2w5z8TgDaPas7SLM6wc8jMMERmefrnYrE5hebZc1ETFnv6Ntlb+85I
   gbLrSXzGt/TzgQxeSVX3xmY1jQqvjwn5uddHolZAcLoB+j26U0C3/7eKp
   E3n64edPJlpaRhEGSiBs8PJRbNeQY4yexFcmm63SNyQ53xFX0gv7cDPKZ
   FhnKE9561sBoAI9DRTSirY7aT3m25Z1XQP69I9hy4+c18L2br4S3V1DQs
   FRpdPpJlNLqkCOOA9c10zFQxP8nVCX220Ey0HdAzSnRcQmP+qGE7582no
   oLKDmDyp61RSREnVPGFtAdBsUQQ26MvqJ451QPgmDBql4bWl+y/baTjvi
   g==;
X-CSE-ConnectionGUID: WJ0p+OgrRaGD6hY7MKVUWg==
X-CSE-MsgGUID: qAbrOtEzRbiy4/SStXSD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="995193"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="995193"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 03:40:02 -0700
X-CSE-ConnectionGUID: 8+XazXeCTmuTJA6Wr/tqcA==
X-CSE-MsgGUID: mZc7qbq5SBS9jMbwFfsXTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="269116455"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.180])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 03:40:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hui Peng <benquike@gmail.com>, bhelgaas@google.com, airlied@redhat.com
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: fix inverted vga_tryget() return check and
 clear removed pci_dev
In-Reply-To: <20260919222629.3798073-1-benquike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260919222629.3798073-1-benquike@gmail.com>
Date: Mon, 21 Sep 2026 13:39:54 +0300
Message-ID: <21d4bbfe6facdf2f88b09b277bddfe0afff5e5a4@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 19 Sep 2026, Hui Peng <benquike@gmail.com> wrote:
> Fix two issues in drivers/pci/vgaarb.c:

One change per patch, please.

>
> 1. In vga_arb_device_init() / vga_arbiter_From_pci_dev(), vga_tryget()
>    returns 0 on success and a negative errno on failure, so checking if
>    (!vga_tryget(...)) is inverted and skips unlocking on success.
> 2. In vga_arbiter_del_pci_device(), clear any open vga_arb_user_init
>    priv->target references pointing to the removed pci_dev so subsequent
>    writes or close() on /dev/vga_arbiter do not dereference a freed
>    pci_dev.
>
> Fixes: 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to drivers/pci")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3de05aee7859..4f13e542505a 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -818,11 +818,33 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
> +#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
> +
> +/* Each user has an array of these, tracking which cards have locks */
> +struct vga_arb_user_card {
> +	struct pci_dev *pdev;
> +	unsigned int mem_cnt;
> +	unsigned int io_cnt;
> +};
> +
> +struct vga_arb_private {
> +	struct list_head list;
> +	struct pci_dev *target;
> +	struct vga_arb_user_card cards[MAX_USER_CARDS];
> +	spinlock_t lock;
> +};
> +
> +static LIST_HEAD(vga_user_list);
> +static DEFINE_SPINLOCK(vga_user_lock);
> +
>  static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>  {
>  	struct vga_device *vgadev;
> +	struct vga_arb_private *priv;
>  	unsigned long flags;
>  	bool ret = true;
> +	int i;
>  
>  	spin_lock_irqsave(&vga_lock, flags);
>  	vgadev = vgadev_find(pdev);
> @@ -845,6 +867,21 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>  	wake_up_all(&vga_wait_queue);
>  bail:
>  	spin_unlock_irqrestore(&vga_lock, flags);
> +	if (ret) {
> +		spin_lock_irqsave(&vga_user_lock, flags);
> +		list_for_each_entry(priv, &vga_user_list, list) {
> +			if (priv->target == pdev)
> +				priv->target = PCI_INVALID_CARD;
> +			for (i = 0; i < MAX_USER_CARDS; i++) {
> +				if (priv->cards[i].pdev == pdev) {
> +					priv->cards[i].pdev = PCI_INVALID_CARD;
> +					priv->cards[i].io_cnt = 0;
> +					priv->cards[i].mem_cnt = 0;
> +				}
> +			}
> +		}
> +		spin_unlock_irqrestore(&vga_user_lock, flags);
> +	}
>  	kfree(vgadev);
>  	return ret;
>  }
> @@ -1025,27 +1062,6 @@ EXPORT_SYMBOL(vga_client_register);
>   * the arbiter.
>   */
>  
> -#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
> -#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
> -
> -/* Each user has an array of these, tracking which cards have locks */
> -struct vga_arb_user_card {
> -	struct pci_dev *pdev;
> -	unsigned int mem_cnt;
> -	unsigned int io_cnt;
> -};
> -
> -struct vga_arb_private {
> -	struct list_head list;
> -	struct pci_dev *target;
> -	struct vga_arb_user_card cards[MAX_USER_CARDS];
> -	spinlock_t lock;
> -};
> -
> -static LIST_HEAD(vga_user_list);
> -static DEFINE_SPINLOCK(vga_user_lock);
> -
> -
>  /*
>   * Take a string in the format: "PCI:domain:bus:dev.fn" and return the
>   * respective values. If the string is not in this format, return 0.
> @@ -1168,7 +1184,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		}
>  
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
> @@ -1215,7 +1231,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		}
>  
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
> @@ -1266,12 +1282,12 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		 */
>  
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
>  
> -		if (vga_tryget(pdev, io_state)) {
> +		if (vga_tryget(pdev, io_state) == 0) {
>  			/* Update the client's locks lists... */
>  			for (i = 0; i < MAX_USER_CARDS; i++) {
>  				if (priv->cards[i].pdev == pdev) {
> @@ -1335,7 +1351,8 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		for (i = 0; i < MAX_USER_CARDS; i++) {
>  			if (priv->cards[i].pdev == pdev)
>  				break;
> -			if (priv->cards[i].pdev == NULL) {
> +			if (priv->cards[i].pdev == NULL ||
> +			    priv->cards[i].pdev == PCI_INVALID_CARD) {
>  				priv->cards[i].pdev = pdev;
>  				priv->cards[i].io_cnt = 0;
>  				priv->cards[i].mem_cnt = 0;
> @@ -1366,7 +1383,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  			goto done;
>  		}
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
> @@ -1429,7 +1446,7 @@ static int vga_arb_release(struct inode *inode, struct file *file)
>  	list_del(&priv->list);
>  	for (i = 0; i < MAX_USER_CARDS; i++) {
>  		uc = &priv->cards[i];
> -		if (uc->pdev == NULL)
> +		if (uc->pdev == NULL || uc->pdev == PCI_INVALID_CARD)
>  			continue;
>  		vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt == %d, uc->mem_cnt == %d\n",
>  			uc->io_cnt, uc->mem_cnt);

-- 
Jani Nikula, Intel
