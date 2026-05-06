Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF252D97B5;
	Wed,  6 May 2026 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090847; cv=none; b=TfTfzV5NYbWc3u9oDgYe78BNq6G+SDhWjXhg1Z75m0KZWPj3b34jJ7vGHirpEdkj/FSpJyREVZ8rejoJhEaX/043LreSaPE1kp0NeuoveqAeLJ3b9S9pZ9NQHgjTQ/97JfRiZl2idl8sjCPQXKX79NJbR4ielX8YzUkaUFfUHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090847; c=relaxed/simple;
	bh=wlJkrDLZhIopZMlYoqQ55aSV73gvHlF6UEt0GwKv2o8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ORHkx1I+F/QnXRzGx75FwXRN3Lv+VbydUwnB6eXo5/RNpMISsqblVFKX8CGcyo2f0HnJEwu4CihkQr5c1S4dQDtCag5d36Eu4PRca0673KdP8hKXNlPVrfPvitDE86uAaz1ludhA/wsKYw+e1o6auIigL6ecCBP8sZYnxWy4JiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5/J9YQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5/J9YQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF258C2BCB0;
	Wed,  6 May 2026 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778090846;
	bh=wlJkrDLZhIopZMlYoqQ55aSV73gvHlF6UEt0GwKv2o8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A5/J9YQ4UQXBSzLqsHRy6wbwkZRqYk/1AU1vSada9/5fWP8M9G4t9NTkU8nkwxK1n
	 QVNjaI0OlS9BtF/GbcDliuGWYlatHDnBzqbLhyBLA34i7F7oFb9wDMKPzJlwafjWDs
	 Q+bsfrGFR5sGw1aorocTLsMoCE4dNO/FqojnqoMTJCUYErpjCd1wZzE3arAKVfh2qc
	 +OVASX9jQXE3QisY4WyqdL2w81WjwQ144AnW7cpaQYT+AOXDGizWXdCGieXeiR1fMB
	 4OiXxS/YQCd4xLm5RyHE9EzZNDvqfb+ISmhuvJScaFGSnPUoqcg00A12mpZEnRtJSS
	 IiOZK6GVopURw==
Date: Wed, 6 May 2026 13:07:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
Cc: bhelgaas@google.com, eduardo.habkost@lambdal.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bilbao@vt.edu, Kai-Heng Feng <kaihengf@nvidia.com>,
	Michael Schaller <michael@5challer.de>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Don't reconfigure ASPM entering low-power state
Message-ID: <20260506180725.GA801910@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428040104.78524-1-carlos.bilbao@kernel.org>

[+cc Kai-Heng, Michael, David, Mani]

On Mon, Apr 27, 2026 at 09:01:04PM -0700, Carlos Bilbao (Lambda) wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> Reconfiguring ASPM when a device transitions to low-power state can enable
> L1.1/L1.2 substates on the PCIe link at a time when the device is sleeping
> and may be unable to exit them. ASPM should be reconfigured on D0 entry
> (resume), not on the way down.
> 
> pci_set_low_power_state() calls pcie_aspm_pm_state_change() after writing
> D3hot to PCI_PM_CTRL. pcie_aspm_pm_state_change() resets link->aspm_capable
> to link->aspm_support and then calls pcie_config_aspm_path(), which can
> enable ASPM L1.1/L1.2 substates on the PCIe link. If the device cannot
> recover the link from L1.2 while in D3hot, subsequent config space reads
> return 0xFFFF ("device inaccessible") and pci_power_up() fails with message
> "Unable to change power state from D3hot to D0, device inaccessible".
> 
> This was observed on NVIDIA H100 SXM5 GPUs bound to vfio-pci when Linux
> runtime PM suspends them to D3hot: the GPU becomes permanently inaccessible
> and disappears from the PCIe bus.
> 
> The call to pcie_aspm_pm_state_change() in pci_set_low_power_state() was
> restored by commit f93e71aea6c6 ("Revert "PCI/ASPM: Remove
> pcie_aspm_pm_state_change()""), which reverted
> commit 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()").
> The revert was necessary because the
> removal broke suspend/resume on certain platforms that required ASPM to be
> reconfigured on D0 entry. However, the revert restored the call in both
> pci_set_full_power_state() (D0 entry) and pci_set_low_power_state()
> (low-power entry).
> 
> Only the D0-entry call is needed to fix the suspend/resume regression. The
> low-power-entry call is harmful: reconfiguring ASPM immediately after
> putting a device into D3hot can enable link substates that the device or
> platform cannot exit while the device is sleeping.
> 
> Remove the pcie_aspm_pm_state_change() call from pci_set_low_power_state().
> ASPM will still be reconfigured correctly when the device returns to D0 via
> pci_set_full_power_state().

Sounds right to me.  I don't know why we would want to touch ASPM
during suspend to D3hot.  I could imagine disabling ASPM states
*before* that transition, but enabling new states at that point sounds
wrong.

Any comments, Kai-Heng and Michael?

I know your regression report was long ago, Michael,
(https://lore.kernel.org/all/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de/),
so likely not practical for you to test this change, but I would hate
to have your system break again.

> Fixes: f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
> Link: https://lore.kernel.org/r/20240102232550.1751655-1-helgaas@kernel.org
> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
> ---
>  drivers/pci/pci.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2ccb8e122f2..8b47887019f9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1542,9 +1542,6 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>  				     pci_power_name(dev->current_state),
>  				     pci_power_name(state));
>  
> -	if (dev->bus->self)
> -		pcie_aspm_pm_state_change(dev->bus->self, locked);
> -
>  	return 0;
>  }
>  
> -- 
> 2.50.1 (Apple Git-155)
> 
