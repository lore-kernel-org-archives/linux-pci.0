Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF31224AF2;
	Thu, 26 Mar 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555468; cv=none; b=FQ1EyX44C/C6yXvU0w9D1ADxE63mU208BOaoxFl/qUtYw70IOgi6tHATQkiDZmQ09NlDzwGa4+v1EunJG52kLBuwjekVDYA+jgyXMKuOxJIwCcHKNpbL0a91SqQrlcnZffzz1mjlS34vcTNEwB0IlHXrFhAw7wDFsqV2rZCbWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555468; c=relaxed/simple;
	bh=sZNT2e0B1LQxT/1mfSQVTlK8Ki0YbWy4SsBvTrrIuVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LVEmK5I/MR4aJag6TD4O73cNyw5PILwY5H303+ksElzlEjIUjkWfhrr83TmbvfUF0HdGw9OPso5pK35oS39jWJ+SAsCHmU54CPrYpaRb8hkj8cKrIB1ZlpmHw39BvRjiaXv3fcRknuBzgQzYNionlSnSzfVQDJ9Z2NuHbq/spho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J13ckptV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J13ckptV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A23C116C6;
	Thu, 26 Mar 2026 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555468;
	bh=sZNT2e0B1LQxT/1mfSQVTlK8Ki0YbWy4SsBvTrrIuVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J13ckptVxDDe0fcEJIOf9rOw5ebdC4BMwoiPH/0oB/EoSJeduleMRoQDnFu+8ii38
	 OHLu8kqahdoz4tdDGQskW4KOQjptdYH8OrSX36vYaCMGGIvEstGBabm7nSgwFIb+Uj
	 vvlu97rezxX0KuL4ZWaMudMkOOj+g6XjBwvaA/khMnn63W1Qk+0Pe9aK8YCfbOp5AF
	 gRVwbZ1ZBHIKLIzLp1oYTtUKUwPeGmOEbe0k6tGBmUx71XZquA+a5cZWRCEO2WDsCp
	 p8wC87gGhf8+5LiIzBaFkfqxEL3GbYbdeWI7z1jv7UPTZwB9T4QN4K9MG1lwDhe+Z1
	 sGk7oiExPs6fw==
Date: Thu, 26 Mar 2026 15:04:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steve Oswald <stevepeter.oswald@gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: Prevent shrinking bridge window from its
 required size
Message-ID: <20260326200427.GA1340256@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219153951.68869-1-ilpo.jarvinen@linux.intel.com>

On Thu, Feb 19, 2026 at 05:39:51PM +0200, Ilpo Järvinen wrote:
> pci_bridge_distribute_available_resources() -> ... ->
> adjust_bridge_window() is called in between __pci_bus_size_bridges()
> and assigning the resources. Since the commit 948675736a77 ("PCI: Allow
> adjust_bridge_window() to shrink resource if necessary")
> adjust_bridge_window() can also shrink the bridge window to force it to
> a smaller size. The shrunken size, however, conflicts what
> __pci_bus_size_bridges() -> pbus_size_mem() calculated as the required
> bridge window size. By shrinking the resource size,
> adjust_bridge_window() prevents rest of the resource fitting algorithm
> working as intended. Resource fitting logic is expecting assignment
> failures when bridge windows need resizing, but there are cases where
> failures are no longer happening after the commit 948675736a77 ("PCI:
> Allow adjust_bridge_window() to shrink resource if necessary").
> 
> The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> resource if necessary") justifies the change by the extra reservation
> made due to hpmemsize parameter, however, the kernel code contradicts
> with that statement. (For simplicity, finer-grained hpmmiosize and
> hpmmiopref parameters that can be used to the same effect as hpmemsize
> are ignored in this description.)
> 
> pbus_size_mem() calls calculate_memsize() twice. First with add_size=0
> to find out the minimal required resource size. The second call occurs
> with add_size=hpmemsize (effectively) but the result does not directly
> affect the resource size only resulting in an entry on the realloc_head
> list (a.k.a. add_list). Yet, adjust_bridge_window() directly changes
> the resource size which does not include what is reserved due to
> hpmemsize. Also, if the required size for the bridge window exceeds
> hpmemsize, the parameter does not have any effect even on the second
> size calculcation made by pbus_size_mem(); from calculate_memsize():
> 
>   size = max(size, add_size) + children_add_size;
> 
> The commit ae4611f1d7e9 ("PCI: Set resource size directly in
> adjust_bridge_window()") that precedes the commit 948675736a77 ("PCI:
> Allow adjust_bridge_window() to shrink resource if necessary") is also
> related to causing this problem. Its changelog explicitly states
> adjust_bridge_window() wants to "guarantee" allocation success.
> Guaranteed allocations, however, are incompatible with how the other
> parts of the resource fitting algorithm work. The given justification
> fails to explain why guaranteed allocations at this stage are required
> nor why forcing window to a smaller value than what was calculated by
> pbus_size_mem() is correct. While the change might have worked by chance
> in some test scenario, too small bridge window does not "guarantee"
> success from the point of view of the endpoint device resource
> assignments. No issue is mentioned within the changelog so it's unclear
> if the change was made to fix some observed issue nor and what that
> issue was.
> 
> The unwanted shrinking of a bridge window occurs, e.g., when a device
> with large BARs such as eGPU is attached using Thunderbolt and the Root
> Port holds less than enough resource space for the eGPU. The GPU
> resources are in order of GBs and the default hotplug allocation is
> mere 2M (DEFAULT_HOTPLUG_MMIO_PREF_SIZE). The problem is illustrated by
> this log (filtered to the relevant content only):
> 
> pci 0000:00:07.0: PCI bridge to [bus 03-2c]
> pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
> pci 0000:03:00.0: PCI bridge to [bus 00]
> pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> pci 0000:03:00.0: PCI bridge to [bus 04-2c]
> pcieport 0000:00:07.0: Assigned bridge window [mem 0x6000000000-0x601bffffff 64bit pref] to [bus 03-2c] cannot fit 0xc00000000 required for 0000:03:00.0 bridging to [bus 04-2c]
> pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref] to [bus 04-2c] add_size 100000 add_align 100000
> pcieport 0000:00:07.0: distributing available resources
> pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref] shrunken by 0x00000007e4400000
> pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pref]: assigned
> 
> The initial size of the Root Port's window is 448MB (0x601bffffff -
> 0x6000000000). __pci_bus_size_bridges() -> pbus_size_mem() calculates
> the required size to be 32772 MB (0x10003fffff - 0x800000000) which
> would fit the eGPU resources. adjust_bridge_window() then shrinks the
> bridge window down to what is guaranteed to fit into the Root Port's
> bridge window. The bridge window for 03:00.0 is also eliminated from
> the add_list (a.k.a. realloc_head) list by adjust_bridge_window().
> 
> After adjustment, the resources are assigned and as the bridge window
> for 03:00.0 is assigned successfully, no failure is recorded. Without a
> failure, no attempt to resize the window of the Root Port is required.
> The end result is eGPU not having large enough resources to work.
> 
> The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> resource if necessary") also claims nested bridge windows are sized the
> same, which is false. pbus_size_mem() calculates the size for the
> parent bridge window by summing all the downstream resources so the
> resource fitting calculates larger bridge window for the parent to
> accomodate the childen. That is, hpmemsize does not result the same
> size for the case where there are nested bridge windows.
> 
> In order to fix the most immediate problem, don't shrink the resource
> size in adjust_bridge_window() as hpmemsize had nothing to do with it.
> When considering add_size, only reduce it up to what is added due to
> hpmemsize (if required size is larger than hpmemsize, the parameter has
> no impact, see calculate_memsize()). Unfortunately, if the tail of the
> bridge window was aligned in calculate_memsize() from below hpmemsize
> to above it, the size check will falsely match but the check at least
> errs to the side of caution. There's not enough information available
> in adjust_bridge_window() to know the calculated size precisely.
> 
> This is not exactly a revert of the commits e4611f1d7e9 ("PCI: Set
> resource size directly in adjust_bridge_window()") and 948675736a77
> ("PCI: Allow adjust_bridge_window() to shrink resource if necessary")
> as shrinking still remains in place but is implemented differently,
> and the end result behaves very differently.
> 
> It is possible that those two commits fixed some other issue that is
> not described with enough detail in the changelog and undoing parts of
> them results in another regression due to behavioral change.
> Nonetheless, as described above, the solution by those two commits was
> flawed and the issue, if one exists, should be solved in a way that is
> compatible with the rest of the resource fitting algorithm instead of
> working against it.
> 
> Besides shrinking, the case where adjust_bridge_window() expands the
> bridge window is likely somewhat wrong as well because it removes the
> entry from add_list (a.k.a. realloc_head), but it is less damaging as
> that only impacts optional resources and may have no impact if
> expanding by hpmemsize is larger than what add_size was. Fixing it is
> left as further work.
> 
> Fixes: 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink resource if necessary")
> Fixes: ae4611f1d7e9 ("PCI: Set resource size directly in adjust_bridge_window()")
> Reported-by: Steve Oswald <stevepeter.oswald@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v7.1, thanks!

> ---
> 
> v2:
> - Rebased
> - Adjust to pci_dev_res_remove_from_list() rename
> 
> 
> Hi Bjorn,
> 
> v1 of this seems to have fallen through cracks. I might have accidently
> marked it "superceded" myself in Patchwork when I moved most of my fix
> patches into the large series to avoid conflicts but not this one.
> 
>  drivers/pci/setup-bus.c | 42 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 32aa72456a44..1b94ed55aa7a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1827,6 +1827,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  				 resource_size_t new_size)
>  {
>  	resource_size_t add_size, size = resource_size(res);
> +	struct pci_dev_resource *dev_res;
>  
>  	if (resource_assigned(res))
>  		return;
> @@ -1839,9 +1840,46 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
>  			&add_size);
>  	} else if (new_size < size) {
> +		int idx = pci_resource_num(bridge, res);
> +
> +		/*
> +		 * hpio/mmio/mmioprefsize hasn't been included at all? See the
> +		 * add_size param at the callsites of calculate_memsize().
> +		 */
> +		if (!add_list)
> +			return;
> +
> +		/* Only shrink if the hotplug extra relates to window size. */
> +		switch (idx) {
> +			case PCI_BRIDGE_IO_WINDOW:
> +				if (size > pci_hotplug_io_size)
> +					return;
> +				break;
> +			case PCI_BRIDGE_MEM_WINDOW:
> +				if (size > pci_hotplug_mmio_size)
> +					return;
> +				break;
> +			case PCI_BRIDGE_PREF_MEM_WINDOW:
> +				if (size > pci_hotplug_mmio_pref_size)
> +					return;
> +				break;
> +			default:
> +				break;
> +		}
> +
> +		dev_res = res_to_dev_res(add_list, res);
>  		add_size = size - new_size;
> -		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> -			&add_size);
> +		if (add_size < dev_res->add_size) {
> +			dev_res->add_size -= add_size;
> +			pci_dbg(bridge, "bridge window %pR optional size shrunken by %pa\n",
> +				res, &add_size);
> +		} else {
> +			pci_dbg(bridge, "bridge window %pR optional size removed\n",
> +				res);
> +			pci_dev_res_remove_from_list(add_list, res);
> +		}
> +		return;
> +
>  	} else {
>  		return;
>  	}
> 
> base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> -- 
> 2.39.5
> 
