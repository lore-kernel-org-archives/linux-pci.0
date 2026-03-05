Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19BC189B84
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752637; cv=none; b=rqNZoq8eoxjtN7h7ZhUM1AT15htE4Sd9UcmlUBAjLS9T93IE8eZ8fK+TzIXLL2VGyE+L3b/uiOUYb3zWWdItyTSHdFFFjbzGEfwPNvGKg8/NhE0G208ze7KZV14RMchSqwwq0T7XURA5ZuA4C3UICA6cc9D7t1CixJxiUWV7saE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752637; c=relaxed/simple;
	bh=TOpxIPlE8bWUEC/eXadwubwgthFUGV2HPi0tB4VIdHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fKjU6JFqcbMslxSLaPT7YViGPRR7d3xnwQVSHD0oaCmbCc+Shxgx1+OQAsEUknjwr/Dv7++8+MX0MCTWYHXTZDLSvKluf2LmDH17SCLP195NKa/sSNhf2qP25p2m6Zj2AMl+hbOavPDSzWmXaIlHg0/5RGjVduedQ81Cc/OucVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFJiMvvQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFJiMvvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC71C116C6;
	Thu,  5 Mar 2026 23:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772752637;
	bh=TOpxIPlE8bWUEC/eXadwubwgthFUGV2HPi0tB4VIdHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HFJiMvvQ/97AqK2iNO3SkrcTkAi4yANO3DjD440nJmv+pxXTCNqPPVKKJrgbw7PY0
	 gBbNj87uaDaXyKn2JVzX0CD6A5gc3uGdKoe7+K8yejK9ZcJP6yxHMz3bpu69g2Vczy
	 n4D1rZyS30nqpcFCGpJt5olJTAcluz2AxdgQfS7PPkBTBdBLkqmkg/wwte5RwRKAw1
	 mlUN5Sig6eT+WQONdDLnAy9NRuDDmXg3vJx1E9EGmRzdgjTER8nMT+spdqvtm2/Ou3
	 6w86HMpeJTZhx9x1tNWM99WQplhw5tFzZiNv2lLmmXpMl50V/kRfg7+MG93aIaJhfr
	 aQuVKgCXxIgZA==
Date: Thu, 5 Mar 2026 17:17:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, dan.j.williams@intel.com, alex@shazbot.org,
	ilpo.jarvinen@linux.intel.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 0/3] pci slot reset handling fixes
Message-ID: <20260305231716.GA78251@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217160836.2709885-1-kbusch@meta.com>

On Tue, Feb 17, 2026 at 08:08:33AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Previous version:
> 
>   https://lore.kernel.org/linux-pci/20260212224112.1913980-1-kbusch@meta.com/
> 
> Changes from previous version:
> 
>   * Fix subject line to match convenction (s/pci/PCI)
> 
>   * Added example kernel panic logs for fatal hardware errors observed
>     without the slot handling fixes
> 
>   * Rearraged some code in the last patch to avoid the need for a
>     forward declaration.
> 
>   * Expanded on the comment explaing the difference between the
>     restore values for the bridge reset
> 
> Keith Busch (3):
>   PCI: rename __pci_bus_reset and __pci_slot_reset
>   PCI: allow all bus devices to use the same slot
>   PCI: make reset_subordinate hotplug safe
> 
>  drivers/pci/hotplug/pciehp_core.c |  3 +-
>  drivers/pci/pci-sysfs.c           |  3 +-
>  drivers/pci/pci.c                 | 97 ++++++++++++++++++++-----------
>  drivers/pci/pci.h                 |  2 +-
>  drivers/pci/slot.c                | 27 +++++++--
>  include/linux/pci.h               |  8 ++-
>  6 files changed, 97 insertions(+), 43 deletions(-)

Applied to pci/reset for v7.1, thanks!
