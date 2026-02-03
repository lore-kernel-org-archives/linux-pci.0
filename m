Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3831AA90
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131706; cv=none; b=F+KvDUjWLDv1iqA0Q6Nf9qiVGSEXB91bdCdJFHadD474RWDK6sTC5/AC0XZ6ZM+jMAMYQ3PInGUs4R4x2noVaG7YN3L+z0EBy/St+f2kwTo/TYGM3fzrkFMg/+ghM5HCZrwOUIcWJj3B91/CuIzSva0hdTTV3xgknJvbRDI0ejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131706; c=relaxed/simple;
	bh=iuhGctjnfCD2wO81raeBfrVWoGcVrFTZZg5a+wsO3Ck=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C0KbqYWycZbBfJULbWK3/+j7PGjof7TxitDHIK425iFI9myXlBUwC6RFeoGJ22bdV53qKq5OUEynIwaWUvHRVpnFKK1G75pNajdLuZA0lpO94TSOlq6JOa/xV2JOizH9BkNQzPV52leaagZC3cKd92grbVGLBU3Oebgvqx7xvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8UiHhx8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8UiHhx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770131703; x=1801667703;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iuhGctjnfCD2wO81raeBfrVWoGcVrFTZZg5a+wsO3Ck=;
  b=Q8UiHhx8doWhcG0YEIFbHqJL9sQomlBFZyCwaiibYlsYJs9lNlNFSq4P
   tvfOuJPSyAYISs4B+9Gz/y9vMdCT3UZOUbC9g2NHuF8fAvcp3nsLwZaSN
   bUhQLvTV3oOf2GQk7OKTRo+G/EWjdEKQUfY2JUiSszDzUaGuJ4S6l1fO3
   rSjIqnXq8ODCZ4F2XgbVt7wRsiyHVXbZxPA+oHobbrEqwhsFShyX24+/t
   hnpx8+Y6GuDtVtaBmU8rH6nX4eHENPyX7cexhYEVKFczNUuxywC2TvCiv
   tw9BhiAW2IZt4paC6X0hpTrmQUuEwo6xuoRuWxNLYoYYMvC2lFxNOLi2+
   g==;
X-CSE-ConnectionGUID: hyKVId7xTT2V7ArCGgvm5g==
X-CSE-MsgGUID: ZtmoAiaySPeKg26sf2ctXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="73901450"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="73901450"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:15:01 -0800
X-CSE-ConnectionGUID: 5XoCBJaUR5W/DkTZ7Ftlbw==
X-CSE-MsgGUID: 8lwMDtVvRVGTDV/DgxkkFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="240549998"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:14:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Feb 2026 17:14:55 +0200 (EET)
To: Sizhe Liu <liusizhe5@huawei.com>
cc: bhelgaas@google.com, jonathan.cameron@huawei.com, shiju.jose@huawei.com, 
    linux-pci@vger.kernel.org, linuxarm@huawei.com, prime.zeng@hisilicon.com, 
    fanghao11@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH] PCI: Fix PCI bridge resource allocation when base exceeds
 limit
In-Reply-To: <20260203023545.2753811-1-liusizhe5@huawei.com>
Message-ID: <cc4121b7-b99e-d7e0-8c20-8a2f0d3a0e2d@linux.intel.com>
References: <20260203023545.2753811-1-liusizhe5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Feb 2026, Sizhe Liu wrote:

> In pci_read_bridge_mmio_pref(), pci_read_bridge_mmio() and pci_read_bridge_io(),
> when the MEMORY_BASE value is greater than MEMORY_LIMIT,
> resource_set_range(res, 0, 0) is called to set both the start address
> and the size of the address of the PCI bridge resource to 0.
> However, the end address is later calculated as:
> res->end = res->start + size - 1
> As a result, the resource range becomes [0x00000000-0xffffffffffffffff]
> instead of the expected [0x00000000-0x00000000].

Hi,

Thanks for the patch but your understanding on how resources addresses 
work is not correct.

A zero sized resource should have end at start - 1, just like 
resource_set_range() sets it!

> This causes an exception in the subsequent resource claiming process,
> because the address range [0x00000000-0xffffffffffffffff] exceeds
> the range specified in the DSDT. The abnormal bridge triggers clipping
> when claiming resources, then the entire parent PCI bus address range
> becomes occupied. Other bridges on the same bus will report
> address conflicts during their claim process. The resource allocation
> may be degraded from 64-bit to 32-bit, or even worse, it fails.
> 
> The related boot log is as follows:
> pci 0000:20:00.0: PCI bridge to [bus 21]
> pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
> pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]

pci_bus_clip_resource() should not touch IORESOURCE_DISABLED resources 
nor zero sized resources. The problem seems to originate from 
pci_claim_bridge_resources() and pci_claim_bridge_resource() which try to 
claim such resources no matter what.

I think pci_claim_bridge_resources() should check if IORESOURCE_DISABLED 
is set and use continue, it already has check !r->flags which probably 
worked prior to 8278c6914306 ("PCI: Preserve bridge window resource type 
flags") but is no longer enough to decided if bridge window is valid or 
not.

Do you want to do that patch and test it? (I'm quite busy this week 
myself.)

> pci 0000:20:00.0:   bridge window [io  0x0000-0xffff disabled]
> pci 0000:20:00.0: bridge window [mem size 0x00000000 disabled]: can't claim; no address assigned
> pci 0000:20:00.0: [mem 0x00000000-0xffffffffffffffff disabled] clipped to [mem 0x800000000000-0x8013ffffffff disabled]
> pci 0000:20:00.0: bridge window [mem 0x800000000000-0x8013ffffffff disabled]: can't claim; no compatible bridge window
> pci 0000:20:00.0: bridge window [mem size 0x00000000 64bit pref disabled]: can't claim; no address assigned
> pci 0000:20:00.0: [mem 0x00000000-0xffffffffffffffff 64bit pref disabled] clipped to [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
> pci 0000:20:00.0:   bridge window [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
> pci 0000:20:08.0: PCI bridge to [bus 22]
> pci 0000:20:08.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
> pci 0000:20:08.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]
> pci 0000:20:08.0: bridge window [io  0x0000-0xffff disabled]: can't claim; address conflict with PCI Bus 0000:21 [io  0x0000-0xffff disabled]
> pci 0000:20:08.0: bridge window [mem size 0x00000000 disabled]: can't claim; no address assigned
> pci 0000:20:08.0: [mem 0x00000000-0xffffffffffffffff disabled] clipped to [mem 0x800000000000-0x8013ffffffff disabled]
> pci 0000:20:08.0: bridge window [mem 0x800000000000-0x8013ffffffff disabled]: can't claim; no compatible bridge window
> pci 0000:20:08.0: bridge window [mem size 0x00000000 64bit pref disabled]: can't claim; no address assigned
> pci 0000:20:08.0: [mem 0x00000000-0xffffffffffffffff 64bit pref disabled] clipped to [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
> pci 0000:20:08.0: bridge window [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]: can't claim; address conflict with PCI Bus 0000:21 [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
> pci 0000:20:09.0: PCI bridge to [bus 23]
> pci 0000:20:09.0: bridge window [io  0x0000-0x0fff]: can't claim; address conflict with PCI Bus 0000:21 [io  0x0000-0xffff disabled]
> pci 0000:20:09.0: bridge window [mem 0x800003000000-0x8000048fffff 64bit pref]: can't claim; address conflict with PCI Bus 0000:21 [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
> 
> Solution:
> A comment in pci_read_bridge_mmio_pref() states:
> /*
>  * Some bridges set the base > limit by default, and some
>  * (broken) BIOSes do not initialize them.  If we find
>  * this, just assume they are not being used.
>  */
> When the base is greater than the limit, a proper fix is to set the
> resource flag to IORESOURCE_UNSET or IORESOURCE_DISABLED while keeping
> the start and end addresses as 0. This prevents the clipping process
> from being triggered incorrectly.
> 
> Fixes: 8278c6914306 ("PCI: Preserve bridge window resource type flags")
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
> ---
>  drivers/pci/probe.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 41183aed8f5d..561f2420d9eb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -429,7 +429,6 @@ static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
>  		if (log)
>  			pci_info(dev, "  bridge window %pR\n", res);
>  	} else {
> -		resource_set_range(res, 0, 0);
>  		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  	}
>  }
> @@ -455,7 +454,6 @@ static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res,
>  		if (log)
>  			pci_info(dev, "  bridge window %pR\n", res);
>  	} else {
> -		resource_set_range(res, 0, 0);
>  		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  	}
>  }
> @@ -511,7 +509,6 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
>  		if (log)
>  			pci_info(dev, "  bridge window %pR\n", res);
>  	} else {
> -		resource_set_range(res, 0, 0);
>  		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  	}
>  }


-- 
 i.

