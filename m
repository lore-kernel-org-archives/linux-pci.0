Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E93A8736;
	Wed,  7 Oct 2026 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406875; cv=none; b=aIGFIrCzBITav70s29vQX4kzhPtdC2/wwb51hv7bwZRh9mUp4/++YSQCyk0o03PontenNCh+Mw54jdyMY73UuqzXv+dYO7rtojUNQ/tr632DJUXikpxuITIgde+CJiDN+vPcGVK03FrQqzLR44n5CIo+y6jnDoQ1F/c5GKgiPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406875; c=relaxed/simple;
	bh=++JAg6n5WWw/0s0UJ+aaZybr9nVpCSgjfM9E3JC/k2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sDUjMyS8qyYGhzJlL3pj7S/gS21h9s5KldfSsKqLvXHllD1l0jLjoQI1OXBDmcdPgprlfc3azVmPNioLpIBZPvdQHSwZBwXmeDs79vQd2Ggsejsy/q2yoVuSqy1bGcMxCQxNsl5XuBD7bXq/SqUDng7p0ALyF2PhKXvfA/17kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjjiUvXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjjiUvXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0921F000FF;
	Wed,  7 Oct 2026 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406873;
	bh=PUk1RoUh5fgwSQayemPlpxSccIqVOskNjlRRgN0DgPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hjjiUvXKEhFW2AAZQTT2b+PiA/oEfqsNvI/zjYMTrbHvIydw5JG95HhvCZdmBt6L6
	 F1o44jxY24fAVbI9L8pM/XHC1WHUzLi4g0n4A1fFbCp+/zc3dY1jEXFZvuLFcD8V3k
	 EqywJ/3v4dBVwB2WlgL7hxILRBTBGyb0t9BX/+EqUW6xDlGzaJDZYYMWWk7TR2fMfc
	 nXhnuB1VEFBnwkg2l88U3F5v6yZjEzFiyvVgUYrmDB9mKju+dAwSPOMahzJlb2BDBB
	 P1lYfZZg5WeEya+FS7AXO4705acJniU4QXpRc70Q3jW1NdUXOJLs2jK1pc6BXBtKMT
	 1NyEgX+82H9yg==
Date: Wed, 7 Oct 2026 16:01:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] PCI: Add Lane Margining at the Receiver debugfs
 interface
Message-ID: <20261007210112.GA787166@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-pcie-link-endpoints-v6-0-154d71657d32@google.com>

On Tue, Oct 06, 2026 at 08:59:09PM +0000, Priyank Rathod wrote:
> Lane Margining at the Receiver lets software move the sampling point of
> a receiver in time or in voltage while the link stays up, and read back
> the errors the receiver sees, to find out how much margin a link running
> at 16.0 GT/s or faster has.  pcilmr in pciutils does this today by
> writing the capability registers directly from user space.
> 
> This series adds a debugfs interface for it.  The kernel sets the link
> up for margining and puts it back afterwards:
> 
>   - ASPM is turned off for the session with the existing ASPM API,
>     Hardware Autonomous Width/Speed Disable are set on both ends, and
>     both ends are kept runtime resumed.  All of this is undone when
>     the session ends or either end of the link is removed.
>   - Before each margining command, the link is checked against the
>     state the session started in.
>   - User space selects the receiver and the steps; the kernel does not
>     run sweeps or interpret results.
> 
> Patch 1 adds the interface and its documentation, patch 2 a kselftest.
> 
> The only PCI core changes are the init/exit hooks in probe.c and
> remove.c and their prototypes in drivers/pci/pci.h.  aspm.c, pci.c and
> include/linux/pci.h are not changed.
> 
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---
> Changes in v6:
> - Add a kref on struct pci_lmr_port and use pci_lmr_end_sessions() in
>   pci_lmr_reboot_notify() so reboot/kexec waits for in-flight commands
>   outside pci_lmr_mutex (preserving the port->lock -> pci_lmr_mutex lock
>   order) instead of skipping ports on mutex_trylock() failure.
> - Link to v5: https://lore.kernel.org/r/20261006-pcie-link-endpoints-v5-0-c1e73235746b@google.com

These reposts (v4, v5, and v6 within four hours) are a little bit too
fast.  The pace suggests this isn't fully baked yet, and it's too much
for reviewers to assimilate.

> Changes in v5:
> - Clarify in pcie_lmr.sh why the sysfs 'link/' check targets receiver 6
>   (and rename 'up' to 'child'): in PCIe terminology the Upstream Port
>   (receiver 6) is the child device below the Downstream Port, and in
>   drivers/pci/pcie/aspm.c aspm_ctrl_attrs_are_visible() looks up the
>   link via pcie_aspm_get_link(pdev) -> pci_upstream_bridge(pdev)->link_state,
>   so '/sys/bus/pci/devices/<dev>/link/' is attached to the child device
>   below the Downstream Port, not to the Downstream Port itself.
> - Link to v4: https://lore.kernel.org/r/20261006-pcie-link-endpoints-v4-0-ad5398c4260c@google.com
> 
> Changes in v4:
> - Drop the exported pcie_get_link_endpoints(); the partner lookup is
>   private to margin.c (Ilpo).
> - Drop pci_aspm_inhibit() and all aspm.c changes.  Use
>   pcie_aspm_enabled(), pci_disable_link_state() and
>   pci_force_enable_link_state(), call neither when no ASPM state is
>   enabled, and restore Clock PM when CLKREQ# was enabled.  ASPM Control
>   is checked on both ends before each command.  The remaining
>   differences after a session are documented.
> - Remove the MSampleMultipleReceivers capability bit.
> - One receiver per session, selected with a port-level 'receiver'
>   file.  A session starts with receiver 1 on a Downstream Port and 6
>   below it, as pcilmr does; receiver 0 is not used for margining.
> - Add a per-lane 'status' file with the step response and error count,
>   and a 'port' file with the Margining Port bits.  Stop writing
>   Margining Port Status.
> - Locking: take both device locks with pci_dev_trylock() only while a
>   session starts or stops, require both ends to be added, and make no
>   runtime PM calls under the LMR locks.
> - End sessions from pci_lmr_exit() for either end of the link.
> - Commands fail with -EIO after a system suspend.
> - Move debugfs to pcie_lmr_<device> at the debugfs root.
> - Keep per-device state in margin.c instead of struct pci_dev.
> - Split the selftest into its own patch, rename it pcie_lmr, use KTAP,
>   and only start a session on the port named by PCIE_LMR_DEV.
> - Refer to registers by name instead of specification section numbers.
> ...
