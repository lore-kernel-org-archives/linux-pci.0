Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E365A79B;
	Thu, 18 Jun 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801957; cv=none; b=byhvgvHpeA+CKIctanfzABf185O2pvbg6dMwJh8YlTCsQJLsfmbvqNm48S2506InNo8hapWcJRNoHuhW5ypfgwyXG8SEbNCGvX07WR4h5NNkSWOpZyLNQz9vrnAdvS8a62CDmqqYmbqDyvqLt1PAXxj5r9s5nUxfm/PkuJ83kIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801957; c=relaxed/simple;
	bh=g7n8Z/9a0MOb4UEVvv7K08MZ15bP0ygFqSTWA6YnWs0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JozcajlB1SPo6FXIh1OLI6Vnk60+rr6LgwLFR334KB7m1rbSwK227bvjaphODFknhuFauScPtqvJ+fJ8RYUHaN30CRyF4UeueE274cmqz2wnjRhcCeebyWf1HGkYB4DppkYRWKCOsywA2Q2yzZHVhgyswJdvd+v/LXMz/lXQ9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob9KP63D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob9KP63D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE91F000E9;
	Thu, 18 Jun 2026 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781801956;
	bh=4QtKsnQ5HoMjEEp3FVXe5eE43D5mwoIP+ysDQmC5rk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ob9KP63DuJ1AIuP7Lv1D+9nlRBgHsWEJ4+kuRuLkCBk1r/7A2fdPneuNxkFnmTiME
	 OwnVQkvCW2GCWjTKNKTKNojJCRA513SzxIsNhDphXedQhneGoBrVKKemmh6mLOf9Jm
	 ZkiOd6ztZPxwxW/xoUj4rmBwDGk/B2HiLcIed9i9Ft6eOMT117LeSF4tubh5MVLDMp
	 cvMR5zNV9WNdGZ/tJbwvf21q3X/mNHWDZL9vrdgSq/ynQvoLkY307XggcvjMFNEifn
	 UtToxlQGUsaaxk46aljuWz0H+GAn4TWhPcW73u1Rni1DPH1CYp67pXp2dsvKdZ1tC0
	 d6R0h7yfnOJUw==
Date: Thu, 18 Jun 2026 11:59:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, a-garg7@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] PCI: controller: Add missing rescan lock around root
 bus removal
Message-ID: <20260618165914.GA394420@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521161822.132996-1-18255117159@163.com>

On Fri, May 22, 2026 at 12:18:13AM +0800, Hans Zhang wrote:
> Several PCIe host controller drivers call pci_stop_root_bus() and
> pci_remove_root_bus() without holding the global PCI rescan lock
> (pci_rescan_remove_global_lock). This can cause race conditions with
> concurrent PCI rescan or hotplug operations triggered via sysfs,
> potentially leading to use-after-free or system crashes.
> 
> This series adds the missing lock pairs to all drivers currently
> exhibiting this pattern. No functional change other than proper
> synchronization.
> 
> Each patch is independent and targets a specific controller driver.
> Please review and apply.

Thanks for this work.  I amended the commit logs of the eight applied
patches so they're all the same (since all the patches do exactly the
same thing) and so they all mention the reason for the change.

There are only four callers of pci_stop_root_bus() and
pci_remove_root_bus() that would not be able to use a trivial helper
function that does the lock/stop/remove/unlock internally:

  zpci_bus_release
  acpi_pci_root_remove
  hv_pci_remove
  vmd_remove

It would be nice to analyze those to see if they could use the same
pattern, which could be done inside a helper function that would avoid
the possibility of adding the same bug elsewhere.

> ---
> The following are the comments from the sashiko-bot@kernel.org review.
> 
> https://lore.kernel.org/linux-pci/20260519132017.63E1BC2BCB3@smtp.kernel.org/
> """
> > +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
> > +{
> > +	struct pci_host_bridge *bridge;
> > +
> > +	cdns_pcie_debugfs_deinit(&rc->pcie);
> > +	bridge = pci_host_bridge_from_priv(rc);
> > +	pci_stop_root_bus(bridge->bus);
> > +	pci_remove_root_bus(bridge->bus);
> > +}
> 
> Could this lead to a race condition during root bus teardown?
> 
> Calling pci_stop_root_bus() and pci_remove_root_bus() without holding the
> PCI rescan lock allows race conditions with concurrent PCI rescan or hotplug
> operations triggered via sysfs.
> 
> While this pattern might have been copied from a pre-existing function like
> cdns_pcie_host_disable(), does it need to be fixed here to prevent
> use-after-free or system crashes?
> 
> Should these operations be protected by acquiring the lock using
> pci_lock_rescan_remove() and pci_unlock_rescan_remove()?
> """
> 
> 
> The function cdns_pcie_hpa_host_disable() mentioned in the bot's comment is from
> a separate patch series and will be fixed independently. This series focuses only
> on existing controller drivers in the mainline kernel.
> ---
> 
> Hans Zhang (9):
>   PCI: cadence: Protect root bus removal with rescan lock
>   PCI: dwc: Protect root bus removal with rescan lock
>   PCI: altera: Protect root bus removal with rescan lock
>   PCI: brcmstb: Protect root bus removal with rescan lock
>   PCI: iproc: Protect root bus removal with rescan lock
>   PCI: mediatek: Protect root bus removal with rescan lock
>   PCI: rockchip: Protect root bus removal with rescan lock
>   PCI: vmd: Protect root bus removal with rescan lock
>   PCI: plda: Protect root bus removal with rescan lock
> 
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 2 ++
>  drivers/pci/controller/dwc/pcie-designware-host.c  | 2 ++
>  drivers/pci/controller/pcie-altera.c               | 2 ++
>  drivers/pci/controller/pcie-brcmstb.c              | 2 ++
>  drivers/pci/controller/pcie-iproc.c                | 2 ++
>  drivers/pci/controller/pcie-mediatek.c             | 2 ++
>  drivers/pci/controller/pcie-rockchip-host.c        | 2 ++
>  drivers/pci/controller/plda/pcie-plda-host.c       | 2 ++
>  drivers/pci/controller/vmd.c                       | 2 ++
>  9 files changed, 18 insertions(+)
> 
> 
> base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
> -- 
> 2.34.1
> 
