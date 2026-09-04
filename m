Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AA48AE28;
	Fri,  4 Sep 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523169; cv=none; b=ty9oQ0s0fI7H2B+YaIEgb/8Dw0oXtGeW9CSfbIyA8s5ZiOV0P7P+/PUA930eJd8hEplVR6FyVCCh2YE/T+E8k0TMCQXNlKPnVi/WUyxcTufi51JYzI2jBxDWzanXw7710wZsAqx8pLNRKPerngDpK5iG35N5kMeksRIXYI7Br78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523169; c=relaxed/simple;
	bh=PtNn2CKy/6LpTLp9eW+K2q48vSWtJVCu51S3/MZA1vI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OFPEXilUdMwlVDmMH+JTzFqZgFoPuV+pk8hUG+ID1NLgkxSZgK/1mM2VBBiS/ob80/jWee18RY7ayPl8DQ1PkP0CYI9MVc4ayKsfEREvmVY+sFpV4FZ/RUrPfUS+zHkxidIboxr03zE905+cyWP+g26WsX9bM6fzmVDUZmTVMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+MSo8uR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+MSo8uR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788523168; x=1820059168;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PtNn2CKy/6LpTLp9eW+K2q48vSWtJVCu51S3/MZA1vI=;
  b=S+MSo8uRJ5uBT+gEYsIK+PAQ3eu3EOhFNj5KVsPdTCUWsFJw3Yv8hg8B
   U0O+qzCH3VcI7kL7jla0LbX4Hd93pLFw839w32CPuFit/2ENCwItUPuol
   iBaHPFCOE0MYjCmKZy2+E3cZbLjoSyExI73aPmcBJKAhxzPIGilUyh5LD
   6ykeUb7vO392xN5jdl9PlQNQJkzkSkrMof9cXkKQ8OopBWBbnjbGmeCZb
   +9qmGJpS23BXWKGWEv4UuPz1CNgPAN8gr0O7Bwe3aQgRisGG8LGPXpO4l
   cFcv4RHFY+J9WBrKKVR8WlOQb6yc+bQNBaHKTkP4Lc775yXDkPW/5gr3H
   g==;
X-CSE-ConnectionGUID: HM9bR2NYQPiMXbJJwX+FgQ==
X-CSE-MsgGUID: S/QXw17PSHG3dP3jrOyiYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99682048"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="99682048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 04:59:27 -0700
X-CSE-ConnectionGUID: /4iuymQdQAKWvRdE1ajn3Q==
X-CSE-MsgGUID: iRkrZIqpSkqC9SQJSY7sTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="266770564"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 04:59:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Sep 2026 14:59:21 +0300 (EEST)
To: Yury Murashka <yurypm@arista.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
In-Reply-To: <20260904111318.1063858-1-yurypm@arista.com>
Message-ID: <6e10813b-3c79-7f61-2bf8-85a6d09674ed@linux.intel.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Sep 2026, Yury Murashka wrote:

> With a nested PCIe topology with multiple layers of hotplug, a link can go
> down near the bottom of the topology shortly before a link above it goes
> down. In that case, pcie_wait_for_link_status() can wait for the full
> timeout while every read of the link status register fails because the
> device has disappeared.
> 
> Return immediately when reading the link status fails so event processing
> can continue.
> 
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> Co-authored-by: James Sewart <jamessewart@arista.com>
> ---
>  drivers/pci/pci.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be..a568d5ac1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4565,8 +4565,9 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>   * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE.
>   * @active: Waiting for active or inactive?
>   *
> - * Return 0 if successful, or -ETIMEDOUT if status has not changed within
> - * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
> + * Return 0 if successful, -ENODEV if the link status cannot be read, or
> + * -ETIMEDOUT if status has not changed within PCIE_LINK_RETRAIN_TIMEOUT_MS
> + * milliseconds.
>   */
>  static int pcie_wait_for_link_status(struct pci_dev *pdev,
>  				     bool use_lt, bool active)
> @@ -4580,7 +4581,8 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>  
>  	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
>  	do {
> -		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +		if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta))
> +			return -ENODEV;

Wouldn't it be better to base such checks on PCI_POSSIBLE_ERROR()?

If you keep the check for the case where pcie_capability_read_word() 
returns error, its return value should be converted with 
pcibios_err_to_errno(), not just return -ENODEV.

>  		if ((lnksta & lnksta_mask) == lnksta_match)
>  			return 0;
>  		msleep(1);
> @@ -4603,8 +4605,9 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>   * according to @use_lt.  It is not verified whether the use of the DLLLA
>   * bit is valid.
>   *
> - * Return 0 if successful, or -ETIMEDOUT if training has not completed
> - * within PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
> + * Return 0 if successful, -ENODEV if the link status cannot be read, or

Kerneldoc wants this formatting:

Return:

> + * -ETIMEDOUT if training has not completed within
> + * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
>   */
>  int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
>  {
> 
> base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
> 

-- 
 i.

