Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D1E39934B;
	Thu, 10 Sep 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051097; cv=none; b=KpKwPjEbzGJnaMSvhq0eqw4c3d1a/yDfz6bxoSE/D1Ax46khbjqXAU3han7X0DXK29YScB2WKLqNGLySgjWQpkhd4I+OOQa2EUUyMkfuG6wlzetayd/K/ozP5JUPvprEZTUxCoTJb8J3O3ed9tb7FG/MDxmUm5naYvupQlMOvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051097; c=relaxed/simple;
	bh=pOrkdQvRTQPDhoFL9csPTxwvD1ftpG+QQsmA+MhHG0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0ZFV8GGK5V4RnqgtdQB5OiA9Q8pQ4AvRRZqXBtUisTTsdWfpUjCK8a46kvZOsDGOMiCgWfllxOKZ/QZkg8LlZ6aTOC6frYU48ZfyloRr/MyLNhrbFLpkP37kDS4BwEPKKENUjZZUnhb5O+5fjf9zYidTG/fF5s1J2Kwzi3d91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzj0Ru/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzj0Ru/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2781F00893;
	Thu, 10 Sep 2026 14:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051095;
	bh=JBC4TPbSc6K2cXwlD8EdflKlmcvnwmcpYEgKeyBBgHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hzj0Ru/JSqFjvVp7L9a124mggYLoK3gSZFyP1xU3HjdwrEGh+Cxy7Zj76j9V8O4ev
	 /cEhM0CNzM197o8fYdcaOEj7kgVP3kqqMxJsLuNjYtUSmevgMUnQPTDXKOLFEFC3Lq
	 ZUq2n1dDiDFpJgmoyvB+ODsVmAHBObBO3x+vzsZiDDfgAQwsl5u4Q2EH3t+4kLZDr2
	 qJO9h52afH9ypikpNi0qtFy0EaQTz5xXgVivdKVOETAr5oHj7xDvyIG5j96zQro/b8
	 n4sFBJV6MTzI6GRwrEY9V4qRMF8/xpgy4HjjfdsIjTCU90xucvueVK6XLT623hanv+
	 yOHz2o55jkBSA==
Date: Thu, 10 Sep 2026 16:38:06 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, p.zabel@pengutronix.de, claudiu.beznea@tuxon.dev, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Madieu <john.madieu.xa@bp.renesas.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 7/7] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Message-ID: <a7koqtuhya3psx7mmest3io5h775jxscivumouv64kbu23pssv@xkkqondobxui>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
 <20260814141312.2947972-8-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814141312.2947972-8-claudiu.beznea+renesas@tuxon.dev>

On Fri, Aug 14, 2026 at 05:13:12PM +0300, Claudiu Beznea wrote:
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> 
> The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers does not expose the
> standard PCIe Slot Capability registers, so the generic pciehp driver
> cannot be used. The only link-state signal the hardware provides is the
> DL_UpDown bit in the PEIS0 event status register, which is raised on every
> Data Link layer up/down transition.
> 
> Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
> can react to link-state changes: a device that trains after boot gets
> enumerated, and a device that disappears on link loss is removed. This
> provides hotplug-like behavior without the PCI hotplug core, which is
> unavailable for the reason above.
> 
> On a DL_UpDown event the handler acks the W1C status bit and schedules a
> worker that inspects PCSTAT1.DL_DOWN_STS:
> 
>   - link up: re-run max link speed negotiation, wait for the link to
>     settle and pci_rescan_bus() the root bus;
>   - link down: reset the root port, walk the bus in reverse and
>     pci_stop_and_remove_bus_device() each child.
> 
> Both paths take pci_lock_rescan_remove() to serialize against the PCI
> core.
> 
> While enumeration succeeds without resetting the root port, performing
> reads and writes to an NVMe endpoint after a link down/link up cycle
> results in failures on some devices. Address this by implementing
> pci_host_bridge::reset_root_port() for the RZ/G3S PCIe driver.
> 
> The implementation of pci_host_bridge::reset_root_port() masks all
> enabled interrupts and synchronizes them before resetting the controller
> to prevent asynchronous events from interfering with the reset operation.
> 
> After the controller is reset, all previously masked interrupts are
> restored.
> 
> Since rzg3s_pcie_host_stop() or rzg3s_pcie_host_start() can fail
> during a root port reset, introduce struct rzg3s_pcie_host::state to
> track the host controller state. The interrupt handlers and register
> access paths consult this state to avoid accessing the controller after a
> failed reset. This was implemented to be able to re-use the
> rzg3s_pcie_host_stop()/rzg3s_pcie_host_start() as is (since they call
> functions which can sleep).
> 
> The introduced states are START, STOP, PROCESS, and PORT_RESET. The initial
> state is STOP. After the controller is initialized, the state is switched
> to START. Any API exposed through struct pci_ops switches the controller
> to the PROCESS state, as do the interrupt handlers.
> 
> rzg3s_pcie_host_reset_root_port() switches the state to PORT_RESET to
> prevent any controller access while the Root Port reset is in progress.
> 
> A controller left in a broken state (STOP) after a failed root port reset
> can recover after a system suspend/resume cycle, since
> rzg3s_pcie_host_start() is invoked again during resume.
> 
> Link events are processed only after the controller has been fully
> initialized.
> 
> While at it, make probe tolerant of an absent device. Previously, if the
> link failed to come up during rzg3s_pcie_host_init(), probe tore the
> controller back down and failed. Distinguish this case with -ENODEV,
> leave the controller and refclk running, and let the link-up path
> enumerate the device once it appears.
> 

Please split the DL_UpDown addition and reset_root_port() into separate patches.

> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v3:
> - added RZG3S_PCI_PEIE0_DL_UPDOWN
> - re-worked the support by implemeting
>   struct pci_host_bridge::reset_root_port()
> - introduced the struct rzg3s_pcie_host::state to:
> -- avoid touching the controller while a reset root port is in progress
> -- and avoid touching the controller in case a reset root port failed
> -- and to be able to re-use the already existing code in the reset
>    root port function
> -- and added CLASS() constructs helpers for it to keep the state handling
>    code simpler
> - updated the patch description to reflect the updates
> 
>  drivers/pci/controller/pcie-rzg3s-host.c | 375 +++++++++++++++++++++--
>  1 file changed, 356 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 4765ac1befba..b3531468ef38 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -86,6 +86,7 @@
>  #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
>  
>  #define RZG3S_PCI_PEIE0				0x200
> +#define RZG3S_PCI_PEIE0_DL_UPDOWN		BIT(9)
>  
>  #define RZG3S_PCI_PEIS0				0x204
>  #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
> @@ -310,6 +311,24 @@ struct rzg3s_pcie_port {
>  	u32 device_id;
>  };
>  
> +/**
> + * enum rzg3s_pcie_host_state - RZ/G3S PCIe Host state
> + * @RZG3S_PCIE_HOST_STATE_STOP: Host is stopped (initial state, reached from
> + *                              PORT_RESET, START)
> + * @RZG3S_PCIE_HOST_STATE_START: Host is started (reached from STOP, PROCESS,
> + *                               PORT_RESET)
> + * @RZG3S_PCIE_HOST_STATE_PROCESS: Host is started and is processing requests
> + *                                 (reached from START)
> + * @RZG3S_PCIE_HOST_STATE_PORT_RESET: Host root port is resetting (reached from
> + *                                    START)
> + */
> +enum rzg3s_pcie_host_state {
> +	RZG3S_PCIE_HOST_STATE_STOP,
> +	RZG3S_PCIE_HOST_STATE_START,
> +	RZG3S_PCIE_HOST_STATE_PORT_RESET,
> +	RZG3S_PCIE_HOST_STATE_PROCESS,
> +};
> +
>  /**
>   * struct rzg3s_pcie_host - RZ/G3S PCIe data structure
>   * @axi: base address for AXI registers
> @@ -323,6 +342,8 @@ struct rzg3s_pcie_port {
>   * @msi: MSI data structure
>   * @port: PCIe Root Port
>   * @hw_lock: lock for access to the HW resources
> + * @state: PCIe controller state
> + * @event_irq: PCIe event interrupt for DL_UpDown detection
>   * @intx_irqs: INTx interrupts
>   * @max_link_speed: maximum supported link speed
>   * @controller_id: PCIe controller identifier, used for System Controller access
> @@ -340,6 +361,8 @@ struct rzg3s_pcie_host {
>  	struct rzg3s_pcie_msi msi;
>  	struct rzg3s_pcie_port port;
>  	raw_spinlock_t hw_lock;
> +	atomic_t state;
> +	int event_irq;
>  	int intx_irqs[PCI_NUM_INTX];
>  	int max_link_speed;
>  	enum rzg3s_pcie_controller_id controller_id;
> @@ -348,6 +371,61 @@ struct rzg3s_pcie_host {
>  
>  #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
>  
> +/**
> + * struct rzg3s_pcie_host_atomic_state - RZ/G3S PCIe state data structure
> + * @state: Atomic state variable to operate on. Should point to
> + *         struct rzg3s_pcie_host::state.
> + * @expect: Expected host state. The host state is not changed if the
> + *          current host state differs from the expected state.
> + * @saved: Saved host state. When the host state is changed, the previous
> + *         state is saved in this variable. This is necessary to restore
> + *         the previous state after the protected section is executed.
> + *
> + * This structure is necessary for state setting and restoration using
> + * CLASS() constructs.
> + */
> +struct rzg3s_pcie_host_atomic_state {
> +	atomic_t *state;
> +	enum rzg3s_pcie_host_state expect;
> +	enum rzg3s_pcie_host_state saved;
> +};
> +
> +static struct rzg3s_pcie_host_atomic_state
> +rzg3s_pcie_host_atomic_state_save(atomic_t *state, int expect, int newval)
> +{
> +	return (struct rzg3s_pcie_host_atomic_state){
> +		.state = state,
> +		.expect = expect,
> +		.saved = atomic_cmpxchg(state, expect, newval),
> +	};
> +}
> +
> +static void
> +rzg3s_pcie_host_atomic_state_restore(struct rzg3s_pcie_host_atomic_state state)
> +{
> +	if (state.saved == state.expect)
> +		atomic_xchg(state.state, state.expect);
> +}
> +
> +DEFINE_CLASS(rzg3s_pcie_host_state_lock,
> +	     struct rzg3s_pcie_host_atomic_state,
> +	     rzg3s_pcie_host_atomic_state_restore(_T),
> +	     rzg3s_pcie_host_atomic_state_save(state, expect, newval),
> +	     atomic_t *state, int expect, int newval)
> +
> +/* Use it to change the state w/o the need to restore it on function exit. */
> +#define RZG3S_PCIE_HOST_STATE_CHANGE(_state, _from, _to) \
> +	CLASS(rzg3s_pcie_host_state_lock, _lock) \
> +	      (_state, RZG3S_PCIE_HOST_STATE_##_from, \
> +		       RZG3S_PCIE_HOST_STATE_##_to) \
> +
> +/*
> + * Use it to check if the state change failed. _from is the initial state.
> + * Use it in conjunction with RZG3S_PCIE_HOST_STATE_CHANGE().
> + */
> +#define RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(_from) \
> +	(_lock.saved != RZG3S_PCIE_HOST_STATE_##_from)
> +

I don't really see a need for all these state management. None of the other
controller drivers are doing and the serialization provided by the PCI core
using pci_lock should be enough. If you find any issue or race, please share it
here. But I really believe that we can fix it without all these complicated
state management.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
