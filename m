Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224F2D73B8;
	Wed,  9 Sep 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918106; cv=none; b=T0Hv1k33HUI9QuPXIETZ2jWkY7XIbBkkmD3RPEpa0kgiGZ3+VgS5EWVe02zuLtipxsnP8I+sm/j3+Qx5IM/iaFulgTROHwQQcETwQLvr5EFKxTZ9MmVZwyoi4f9MRMhNILnkbRGmhIvYeaO9TrlXfGCgIvXyQOpH4VLtRAtDtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918106; c=relaxed/simple;
	bh=7HkHNLXBuzspdCqPAV4cOMiBD3plUU02+d64I3A3jVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mG1EVUGhxh8zfvC9fGOoWL32T8w6O3BEzRF0+PuWMLsjqcOAae6B72YRXrLT3+IzvkIyh6cpmOH2TrJ4IKx/NbfXQLh3zYxSnKekC5fhcnr9eshwWfZulgLpsH6X2VDb3k7C3s+KNQTzVLN7H+ebiJLo40jSonCKEwku7FhJTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5AYpt/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5AYpt/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F44B1F00A3A;
	Wed,  9 Sep 2026 01:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918104;
	bh=B2OGWpnhUFB6vgSlsPohpNDps/shXdY+C2+w9twFdNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=T5AYpt/Olk15Or9qymffRfA2P5aYwzGaiABQ+LS+ogH4xstXoN713m5iIjLm8+Ziz
	 iPgYeJIZ1dmWgLw/yc3BseZFO30hSOVf5qoMnIlHooce06RNFS7tctIgdPqrJoqn5y
	 kEnBHlzCMZk0EInjfQkkHkBesXaEusU3xsGaS0wtPZe0kKmRfzGTUj1lWXPJgpz+vS
	 balpZoixpzyQe9fMLJjHMHOIPeNzI/uKOxTZX11XzKSQ3Gz4dgK80zpjTiXMTNoJo3
	 ddGipnb83m9TH9hSruncgWewwYgCb2Ws1DFZGM3djY3tk/BXBrLcoZ4Q/Xip7y43Zs
	 qlDuejS0aS4/g==
Date: Tue, 8 Sep 2026 20:41:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fahmy Hassan <fahmymohammed@gmail.com>
Cc: bhelgaas@google.com, kees@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: cpqphp: Check pci_hp_add_bridge() return value
Message-ID: <20260909014143.GA123333@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909013028.508870-1-fahmymohammed@gmail.com>

On Tue, Sep 08, 2026 at 07:30:28PM -0600, Fahmy Hassan wrote:
> cpqhp_configure_device() calls pci_hp_add_bridge() without checking
> its return value. If pci_hp_add_bridge() fails (e.g. no bus number
> is available for the hot-added bridge), dev->subordinate is left
> unset, so the subsequent pci_bus_add_devices(child) call is
> correctly skipped -- but the failure itself goes completely
> unreported, making such problems very hard to diagnose in the field.
> 
> Log an error via the driver's existing err() macro when
> pci_hp_add_bridge() fails, and remove the now-resolved TODO entry.

The patch doesn't seem to remove the TODO.

There are four other drivers that call pci_hp_add_bridge(), and none
of them check the return value either.  We should leave it alone or
fix them all, so the review effort can be applied to all of them at
once.

> Signed-off-by: Fahmy Hassan <fahmymohammed@gmail.com>
> ---
>  drivers/pci/hotplug/cpqphp_pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
> index 81c58b1ec200..34803f36ba65 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -100,7 +100,9 @@ int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
>  	}
>  
>  	if (func->pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> -		pci_hp_add_bridge(func->pci_dev);
> +		if (pci_hp_add_bridge(func->pci_dev))
> +			err("bus/device/function %x/%x/%x: pci_hp_add_bridge() failed\n",
> +			    func->bus, func->device, func->function);
>  		child = func->pci_dev->subordinate;
>  		if (child)
>  			pci_bus_add_devices(child);
> -- 
> 2.53.0
> 
