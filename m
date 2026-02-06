Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754335975
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416251; cv=none; b=C7ykzPQfLlguUAETTciLSU36FqZp+hFdLkrxsKVl9XcF0J+XNX7empFZDPSs9WvJufhA19MgL90lLQ4spprTCjsDR79u5quxZ2eVTGw27VpZf9eIgpxJX1wueU4cSU1RP/5t9fzSUyfWIYYt4MlnMq73i5LUlLJjTL4edpDsW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416251; c=relaxed/simple;
	bh=UJu8YaeAhfZiUmsz9eR/fUU3iBjEQ2VwslqTCyVZo00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nphgHAY3XJQ40ubgZWfToZz2A6PLQ0x9VsiSf7L9zbXN/toJUqL1EXAHyNyyhs+vYXj0EPxw7BT5QkSDLjjs8WW4i/Qi8mqVYxlNesNI2OacFzNDoNgepJmnUFL1itaoYb1I9RBsTW8IjLyceFvEdQ4AeNtbk/hFiZCf6gyE7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR2U8Idv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR2U8Idv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0497C116C6;
	Fri,  6 Feb 2026 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416250;
	bh=UJu8YaeAhfZiUmsz9eR/fUU3iBjEQ2VwslqTCyVZo00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lR2U8IdvRJYKUILn9FqluPTSl1rlv8QyWZ747igzsJ/t+Kos8DbaPu/49lz8uDb8J
	 CmEj3zQnbdEcraRJhYO5tySzET/OjhoIGcC/zo3pAxUk7C3nvQp8lY7M+/aeWwdMUT
	 6+TIzWI2cQpPl0v/CjbI8Jak5d/6svZay4zR9QYJYtaARgXJCxx2DBjIaor4Is+MZ8
	 aCWKLzxOarYd0WCcuizDXAlcK8iKkcxcarnhvVjUzLErdsas/dT1XKdUUCsJsAdF08
	 h8FZWN8S87ITEqwb03vjLAnekF1lidyjlxmQBvYdJqUV8Nb9q4ARfNK3bPpTjFVHQN
	 jrfkmSRYz5S2A==
Date: Fri, 6 Feb 2026 16:17:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Sizhe Liu <liusizhe5@huawei.com>, bhelgaas@google.com,
	jonathan.cameron@huawei.com, shiju.jose@huawei.com,
	linux-pci@vger.kernel.org, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, fanghao11@huawei.com,
	shenyang39@huawei.com
Subject: Re: [PATCH] PCI: Fix PCI bridge resource allocation when base
 exceeds limit
Message-ID: <20260206221729.GA97748@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d9228d6-a230-6ddf-e300-fbf42d523863@linux.intel.com>

On Tue, Feb 03, 2026 at 07:21:38PM +0200, Ilpo Järvinen wrote:
> On Tue, 3 Feb 2026, Ilpo Järvinen wrote:
> 
> > On Tue, 3 Feb 2026, Sizhe Liu wrote:
> > 
> > > In pci_read_bridge_mmio_pref(), pci_read_bridge_mmio() and pci_read_bridge_io(),
> > > when the MEMORY_BASE value is greater than MEMORY_LIMIT,
> > > resource_set_range(res, 0, 0) is called to set both the start address
> > > and the size of the address of the PCI bridge resource to 0.
> > > However, the end address is later calculated as:
> > > res->end = res->start + size - 1
> > > As a result, the resource range becomes [0x00000000-0xffffffffffffffff]
> > > instead of the expected [0x00000000-0x00000000].
> > 
> > Hi,
> > 
> > Thanks for the patch but your understanding on how resources addresses 
> > work is not correct.
> > 
> > A zero sized resource should have end at start - 1, just like 
> > resource_set_range() sets it!
> > 
> > > This causes an exception in the subsequent resource claiming process,
> > > because the address range [0x00000000-0xffffffffffffffff] exceeds
> > > the range specified in the DSDT. The abnormal bridge triggers clipping
> > > when claiming resources, then the entire parent PCI bus address range
> > > becomes occupied. Other bridges on the same bus will report
> > > address conflicts during their claim process. The resource allocation
> > > may be degraded from 64-bit to 32-bit, or even worse, it fails.
> > > 
> > > The related boot log is as follows:
> > > pci 0000:20:00.0: PCI bridge to [bus 21]
> > > pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
> > > pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]
> > 
> > pci_bus_clip_resource() should not touch IORESOURCE_DISABLED resources 
> > nor zero sized resources. The problem seems to originate from 
> > pci_claim_bridge_resources() and pci_claim_bridge_resource() which try to 
> > claim such resources no matter what.
> > 
> > I think pci_claim_bridge_resources() should check if IORESOURCE_DISABLED 
> > is set and use continue, it already has check !r->flags which probably 
> > worked prior to 8278c6914306 ("PCI: Preserve bridge window resource type 
> > flags") but is no longer enough to decided if bridge window is valid or 
> > not.
> > 
> > Do you want to do that patch and test it? (I'm quite busy this week 
> > myself.)
> 
> I managed to get the patch done:
> 
> --
> From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
> Date: Tue, 3 Feb 2026 19:14:30 +0200
> Subject: [PATCH 1/1] PCI: Don't claim disabled bridge windows
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The commit 8278c6914306 ("PCI: Preserve bridge window resource type
> flags") change bridge window resource behavior such that flags are no
> longer zero if the bridge window is not valid or is disabled (mainly
> to preserve the type flags for later use). If a bridge window has its
> limit smaller than base address, pci_read_bridge_*() sets both
> IORESOURCE_UNSET and IORESOURCE_DISABLED to indicate the bridge window
> exists but is not valid with the current base and limit configuration.
> 
> The code in pci_claim_bridge_resources() still depends on the old
> behavior be checking validity of the bridge window solely based on
> !r->flags, whereas after the commit 8278c6914306 ("PCI: Preserve bridge
> window resource type flags"), also IORESOURCE_DISABLED may indicate
> bridge window addresses are not valid.
> 
> While pci_claim_resource() does check IORESOURCE_UNSET,
> pci_claim_bridge_resource() does attempt to clip the resource if
> pci_claim_resource() fails which is not correct for not valid bridge
> window resource. As pci_bus_clip_resource() performs clipping
> regardless flags and then clears IORESOURCE_UNSET, it should not be
> called for not valid resources.
> 
> The problem is visible in this log:
> 
> pci 0000:20:00.0: PCI bridge to [bus 21]
> pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
> pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io 0x0000-0xffff disabled]
> 
> Add IORESOURCE_DISABLED check into pci_claim_bridge_resources() to
> only claim bridge windows that appear to have a valid configuration.
> 
> Reported-by: Sizhe Liu <liusizhe5@huawei.com>
> Fixes: 8278c6914306 ("PCI: Preserve bridge window resource type flags")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v6.20, thanks!

FWIW, when applied to this message, b4 extracts Sizhe's original
patch, which isn't what we want in this case:

  $ b4 am -om/ https://lore.kernel.org/all/4d9228d6-a230-6ddf-e300-fbf42d523863@linux.intel.com
  ...
  $ head m/20260203_liusizhe5_pci_fix_pci_bridge_resource_allocation_when_base_exceeds_limit.mbx
  From git@z Thu Jan  1 00:00:00 1970
  Subject: [PATCH] PCI: Fix PCI bridge resource allocation when base exceeds
   limit
  From: Sizhe Liu <liusizhe5@huawei.com>
  Date: Tue, 03 Feb 2026 10:35:45 +0800
  ...

> ---
>  drivers/pci/setup-bus.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 6e90f46f52af..43ea635e1ea8 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1733,6 +1733,8 @@ static void pci_claim_bridge_resources(struct pci_dev *dev)
>  
>  		if (!r->flags || r->parent)
>  			continue;
> +		if (r->flags & IORESOURCE_DISABLED)
> +			continue;
>  
>  		pci_claim_bridge_resource(dev, i);
>  	}
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.39.5

