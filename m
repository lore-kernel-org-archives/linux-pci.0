Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3D1373
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556002; cv=none; b=GNZVUXA9ulh24y3sUzb5dzG0c1v1GD7tcvIr66JaAo76jrMX3pJEjpxcOjl1arSWE5UpyK9f6MVSBtVx3NV7xTYArC/xu3aR+g0usQSqv3uxS9lkno3QVI/6AEkvDBSzLMG3+0yKQVisAmztVXhixqGNo9Wjg+8tozy2XzpL4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556002; c=relaxed/simple;
	bh=4Q0G+qc2aRxGwxSJL5t5gR4r031VHXQVb0dJbtxmjps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ugZtpq/wxLC0GpfQjhbCtfKM2xHV3/B20HLBS/cP1WYwG8YUd/KtvUwLQLdvcNLjqBsnuXOtt08ih1cH4G8MpDyCZn9UNzIAT0hqKNmgyfM0tI3n6Y00uu4eNBLjbpgtW4k9VafVkUlPMcRvzoJBeRqGjcT9LGPSz4FGwyNjCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzuDsKIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzuDsKIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F5FC116C6;
	Tue, 27 Jan 2026 23:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769556002;
	bh=4Q0G+qc2aRxGwxSJL5t5gR4r031VHXQVb0dJbtxmjps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JzuDsKIjnQPVVPp+IJnLZ01Hw6CU+Knu4lGX2yLfJqDCud+0CCXL8CJevZDwoBlEy
	 IYPAvGz5zdpFadDmCeAsbiJYFqjlcwT5O8Xr1MN/GgRB4jY1SSb1EjAgGRaFWmj1zP
	 pSXy7vhNnOmWDlf+n1zyOsCYqdNauHxYEzjhRDbPRyyAGfCTxHQgWdqPr3H0EnvXv6
	 lS3keYffvpp0wk1YQ07T+r3GT+M2MhfJhnVPijqpqdI+5QMazyf7xWY5vMgzCJlN7l
	 M80U4WJ+ARR/RjGwfyTe5fNHwUgTAshCbplKhOUtq/l3/7ROc+HhODsBMPiGp4/WkG
	 fc6mys/15tPHg==
Date: Tue, 27 Jan 2026 17:20:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, alex@shazbot.org,
	lukas@wunner.de, Keith Busch <kbusch@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] pci: fix slot trylock error handling
Message-ID: <20260127232001.GA386879@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116184150.3013258-1-kbusch@meta.com>

[+cc Dan, author of a4e772898f8bf2]

On Fri, Jan 16, 2026 at 10:41:49AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The device lock isn't held if pci_bus_trylock() fails, so the code had
> been attempting to improperly unlock it.
> 
> Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 72d88ea95f3cc..3378221c5723a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5494,10 +5494,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
>  		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate)) {
> -				pci_dev_unlock(dev);
> +			if (!pci_bus_trylock(dev->subordinate))
>  				goto unlock;
> -			}
>  		} else if (!pci_dev_trylock(dev))
>  			goto unlock;
>  	}
> -- 
> 2.47.3
> 
