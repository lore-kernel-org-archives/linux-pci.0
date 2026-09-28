Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23A3D0C07;
	Mon, 28 Sep 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600251; cv=none; b=VHuq0Y9OC3cgH/JNoEegxk4aQ6bSKIce1m9P83Tr/SVBbBW0dAiDu24xA0NkKEVctG2hsQaLYkXDm4/uXzOn8jqkXWYL2qd6/sCA3EtQ84Afq0TAl3kY4WlRiPTYn8FYRQ2kgcaRwl9qCVNttZbK9mApqSSlcSFC1mFy7c0HX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600251; c=relaxed/simple;
	bh=NO3m05+MVb9sGRkEEQQ9zeN9rgKnk3WgXbm9hzLVRfM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RG6yS2+JXCStQDBPkMtCiD4QFrkXl/CLG+hpC+b6RSXIOA1CDc1dmGRY8V7E9cJRr+z4yQIQeIz6B/g+Wt7FACv7P1VAX4KOTB+Nv9PdmYxnMLpg3Is6Ea2Y5Lwk5MlYqZru5krK3M3g/vEnnQ7lTl5ofLM+bcdJS59ClRw7jTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfB/F5jK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfB/F5jK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790600250; x=1822136250;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NO3m05+MVb9sGRkEEQQ9zeN9rgKnk3WgXbm9hzLVRfM=;
  b=ZfB/F5jKpf0McRc27Djpsv7XGak+JYzrO0+EqGnXlHqjsx2wBBhR6Rr+
   tf4msmTpub6sQk39dT3bD7MbkU2JKaXeE1gJxbDxQhQBwEn8flY1TfcGu
   8rnjNit5zEbTPtf3M2HnLPG+ZQ2M7cNvXVSWn4emIeeGpkCFhWqtK9ZCW
   jh49XuDuatPrGQdqqT70gOTk7rAKlTUxjJ0ylCX7AQGCDChSBoBEJoSaU
   BECvFBeKzA6ati1KzLQESwSVPFMXcfclCZlOVrJC9UeD6WUMk8LSNHMXT
   KCSUhCzfRDUS1s74IVatsOVhS4K8nDl7gCSBmOG2BxX1uTXwNas8UXEon
   g==;
X-CSE-ConnectionGUID: qVfpZFQ0TmSJw1Vf4zdH9Q==
X-CSE-MsgGUID: aKb+Df1UQYWkhHCHLogXjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101466244"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="101466244"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:57:30 -0700
X-CSE-ConnectionGUID: tskufYWuSWqrGgDCV3n1NA==
X-CSE-MsgGUID: Z13anqShQyCagxvJjJ2+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="279772219"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:57:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Sep 2026 15:57:23 +0300 (EEST)
To: Deepanshu Kartikey <kartikey406@gmail.com>
cc: bhelgaas@google.com, david.laight.linux@gmail.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] PCI: sysfs: Reject unaligned resource I/O port
 accesses
In-Reply-To: <20260928123036.7902-1-kartikey406@gmail.com>
Message-ID: <fd1753ec-020b-b90d-ec1a-9d21ab2fa9a4@linux.intel.com>
References: <20260928123036.7902-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Sep 2026, Deepanshu Kartikey wrote:

> pci_resource_io() validates that the requested port lies within the
> BAR but never checks that it is aligned to the access size. A
> pwrite64()/pread64() on a resourceN file with an odd offset and
> count=2 or count=4 reaches outw()/outl() with a misaligned address.
> On arm64 this becomes a store/load to a Device-memory mapping
> (PCI_IOBASE + port), which architecturally requires natural
> alignment, causing an alignment fault and kernel oops.
> 
> Reject misaligned 2- and 4-byte accesses before they reach the
> low-level accessor. With natural alignment enforced, an access that
> starts inside the BAR cannot extend past its end, so drop the
> port + count - 1 range check.
> 
> Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7134530b25073b4ef373
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Check alignment per access size in the case 2/case 4 branches
>     instead of using IS_ALIGNED() with a user-controlled count, and
>     drop the now-redundant port + count - 1 range check.
>     (Bjorn, David, sashiko)
> ---
>  drivers/pci/pci-sysfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 1f21856aac8a..8118cc6b3a61 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1209,9 +1209,6 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  	if (port > pci_resource_end(pdev, bar))
>  		return 0;
>  
> -	if (port + count - 1 > pci_resource_end(pdev, bar))
> -		return -EINVAL;
> -
>  	switch (count) {
>  	case 1:
>  		if (write)
> @@ -1220,12 +1217,16 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			*(u8 *)buf = inb(port);
>  		return 1;
>  	case 2:
> +		if (port & 1)
> +			return -EINVAL;
>  		if (write)
>  			outw(*(u16 *)buf, port);
>  		else
>  			*(u16 *)buf = inw(port);
>  		return 2;
>  	case 4:
> +		if (port & 3)

Why fon't these use !IS_ALIGNED() anymore? You can use e.g. sizeof() to 
connect it to the natural alignment of the type so you don't have to use 
literals at all.

> +			return -EINVAL;
>  		if (write)
>  			outl(*(u32 *)buf, port);
>  		else
> 

-- 
 i.

