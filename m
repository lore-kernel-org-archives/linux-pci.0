Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85A47F794;
	Mon, 21 Sep 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009370; cv=none; b=poFwuFDfqvey4mrHQek7utM7Kot8Vx84mEoNY97vyWc1s5dVehyYlArVedUy6nEqGAw0bUpiFfiMvGrPVlUh5hdkJ9zI1Og68TqXL5eEl+eri1w9Y0Vs80dp5N+uVogo9VOCSlS+ldkyrRvX55qDv6plMAYFBaq2vDtxJkkCDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009370; c=relaxed/simple;
	bh=DItT6+jUMo41lHHGp2/QkV1TE00un6jPRSKJmOv+sRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T097svqVzI6smfxuvslx96M1W76llq3M2yzHbLHQicpiPQ6xKBMWYH4Oqk7f1DZfhwMeE0ZsJMMLnkOqzjtHGFiYs5wJicAfGkd9hW+h6H8yyup72MFe3kq0Yudt1KF3ms7uD6z588XEaEjTsAeeyNZbo/pLsShqn53Qio3r5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nArLOPjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nArLOPjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7831F00893;
	Mon, 21 Sep 2026 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009365;
	bh=+J3/YHVbBQ5+4l3XP0POplmrrM0EDMUaHXcBAgmqJoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nArLOPjqQ86XZDoP/wqJ8Z5P6jVVew0WFkWDL1xuh0asWfiIldnXTpzfNQBLP6lNr
	 ymRlxkTbEwAhjH8voxxiU0nlc8aZ3H3rKLQn4xW1skfY939SNEphn8XH/yJk3EIbON
	 W3slieT9/sw0n8MgiE/Iqv7a1FSce1Zz4WEmIMW3E/hwCUkYztSgV8d/yGDGfAugMc
	 0XhHtRoYJwyBSwK9+507GKlkjvbORBMVJ7DXdgwjvMlHTmL4v90jARHoNbOJItf4lz
	 CfbSRNpunpgT3qVLjUV2cQd6vzoZZLrzeIPYGrrm3QliNJRVMFZow/WQ9BFIM023Vt
	 oka1wK95EpwAg==
Date: Mon, 21 Sep 2026 18:49:17 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Madieu <john.madieu.xa@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 7/7] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Message-ID: <n7cafny3y6rr63tx6rkt5umxl3f4rsxpu2ojze7luudzzr4flb@egj7dru2bnhq>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
 <20260814141312.2947972-8-claudiu.beznea+renesas@tuxon.dev>
 <a7koqtuhya3psx7mmest3io5h775jxscivumouv64kbu23pssv@xkkqondobxui>
 <9c8fe3e4-1dcc-4663-8e3f-684ec4e09daa@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c8fe3e4-1dcc-4663-8e3f-684ec4e09daa@tuxon.dev>

On Fri, Sep 11, 2026 at 03:14:25PM +0300, claudiu beznea wrote:
> Hi, Mani,
> 
> On 9/10/26 17:38, Manivannan Sadhasivam wrote:
> > On Fri, Aug 14, 2026 at 05:13:12PM +0300, Claudiu Beznea wrote:
> > > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > > 
> > > The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers does not expose the
> > > standard PCIe Slot Capability registers, so the generic pciehp driver
> > > cannot be used. The only link-state signal the hardware provides is the
> > > DL_UpDown bit in the PEIS0 event status register, which is raised on every
> > > Data Link layer up/down transition.
> > > 
> > > Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
> > > can react to link-state changes: a device that trains after boot gets
> > > enumerated, and a device that disappears on link loss is removed. This
> > > provides hotplug-like behavior without the PCI hotplug core, which is
> > > unavailable for the reason above.
> > > 
> > > On a DL_UpDown event the handler acks the W1C status bit and schedules a
> > > worker that inspects PCSTAT1.DL_DOWN_STS:
> > > 
> > >    - link up: re-run max link speed negotiation, wait for the link to
> > >      settle and pci_rescan_bus() the root bus;
> > >    - link down: reset the root port, walk the bus in reverse and
> > >      pci_stop_and_remove_bus_device() each child.
> > > 
> > > Both paths take pci_lock_rescan_remove() to serialize against the PCI
> > > core.
> > > 
> > > While enumeration succeeds without resetting the root port, performing
> > > reads and writes to an NVMe endpoint after a link down/link up cycle
> > > results in failures on some devices. Address this by implementing
> > > pci_host_bridge::reset_root_port() for the RZ/G3S PCIe driver.
> > > 
> > > The implementation of pci_host_bridge::reset_root_port() masks all
> > > enabled interrupts and synchronizes them before resetting the controller
> > > to prevent asynchronous events from interfering with the reset operation.
> > > 
> > > After the controller is reset, all previously masked interrupts are
> > > restored.
> > > 
> > > Since rzg3s_pcie_host_stop() or rzg3s_pcie_host_start() can fail
> > > during a root port reset, introduce struct rzg3s_pcie_host::state to
> > > track the host controller state. The interrupt handlers and register
> > > access paths consult this state to avoid accessing the controller after a
> > > failed reset. This was implemented to be able to re-use the
> > > rzg3s_pcie_host_stop()/rzg3s_pcie_host_start() as is (since they call
> > > functions which can sleep).
> > > 
> > > The introduced states are START, STOP, PROCESS, and PORT_RESET. The initial
> > > state is STOP. After the controller is initialized, the state is switched
> > > to START. Any API exposed through struct pci_ops switches the controller
> > > to the PROCESS state, as do the interrupt handlers.
> > > 
> > > rzg3s_pcie_host_reset_root_port() switches the state to PORT_RESET to
> > > prevent any controller access while the Root Port reset is in progress.
> > > 
> > > A controller left in a broken state (STOP) after a failed root port reset
> > > can recover after a system suspend/resume cycle, since
> > > rzg3s_pcie_host_start() is invoked again during resume.
> > > 
> > > Link events are processed only after the controller has been fully
> > > initialized.
> > > 
> > > While at it, make probe tolerant of an absent device. Previously, if the
> > > link failed to come up during rzg3s_pcie_host_init(), probe tore the
> > > controller back down and failed. Distinguish this case with -ENODEV,
> > > leave the controller and refclk running, and let the link-up path
> > > enumerate the device once it appears.
> > > 
> > 
> > Please split the DL_UpDown addition and reset_root_port() into separate patches.
> 
> If splitting, it would mean the DL_UpDown patch will be broken (at least for
> RZ/G3S SoC). Would that be OK with you?
> 

It will not be broken, but just that the RP won't be reset through platform
specific reset hook. So it is OK to have the successive commit add that
functionality, provided it is mentioned in the commit message.

> > 
> > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > ---
> > > 
> > > Changes in v3:
> > > - added RZG3S_PCI_PEIE0_DL_UPDOWN
> > > - re-worked the support by implemeting
> > >    struct pci_host_bridge::reset_root_port()
> > > - introduced the struct rzg3s_pcie_host::state to:
> > > -- avoid touching the controller while a reset root port is in progress
> > > -- and avoid touching the controller in case a reset root port failed
> > > -- and to be able to re-use the already existing code in the reset
> > >     root port function
> > > -- and added CLASS() constructs helpers for it to keep the state handling
> > >     code simpler
> > > - updated the patch description to reflect the updates
> > > 
> > >   drivers/pci/controller/pcie-rzg3s-host.c | 375 +++++++++++++++++++++--
> > >   1 file changed, 356 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> > > index 4765ac1befba..b3531468ef38 100644
> > > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > > @@ -86,6 +86,7 @@
> > >   #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
> > >   #define RZG3S_PCI_PEIE0				0x200
> > > +#define RZG3S_PCI_PEIE0_DL_UPDOWN		BIT(9)
> > >   #define RZG3S_PCI_PEIS0				0x204
> > >   #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
> > > @@ -310,6 +311,24 @@ struct rzg3s_pcie_port {
> > >   	u32 device_id;
> > >   };
> > > +/**
> > > + * enum rzg3s_pcie_host_state - RZ/G3S PCIe Host state
> > > + * @RZG3S_PCIE_HOST_STATE_STOP: Host is stopped (initial state, reached from
> > > + *                              PORT_RESET, START)
> > > + * @RZG3S_PCIE_HOST_STATE_START: Host is started (reached from STOP, PROCESS,
> > > + *                               PORT_RESET)
> > > + * @RZG3S_PCIE_HOST_STATE_PROCESS: Host is started and is processing requests
> > > + *                                 (reached from START)
> > > + * @RZG3S_PCIE_HOST_STATE_PORT_RESET: Host root port is resetting (reached from
> > > + *                                    START)
> > > + */
> > > +enum rzg3s_pcie_host_state {
> > > +	RZG3S_PCIE_HOST_STATE_STOP,
> > > +	RZG3S_PCIE_HOST_STATE_START,
> > > +	RZG3S_PCIE_HOST_STATE_PORT_RESET,
> > > +	RZG3S_PCIE_HOST_STATE_PROCESS,
> > > +};
> > > +
> > >   /**
> > >    * struct rzg3s_pcie_host - RZ/G3S PCIe data structure
> > >    * @axi: base address for AXI registers
> > > @@ -323,6 +342,8 @@ struct rzg3s_pcie_port {
> > >    * @msi: MSI data structure
> > >    * @port: PCIe Root Port
> > >    * @hw_lock: lock for access to the HW resources
> > > + * @state: PCIe controller state
> > > + * @event_irq: PCIe event interrupt for DL_UpDown detection
> > >    * @intx_irqs: INTx interrupts
> > >    * @max_link_speed: maximum supported link speed
> > >    * @controller_id: PCIe controller identifier, used for System Controller access
> > > @@ -340,6 +361,8 @@ struct rzg3s_pcie_host {
> > >   	struct rzg3s_pcie_msi msi;
> > >   	struct rzg3s_pcie_port port;
> > >   	raw_spinlock_t hw_lock;
> > > +	atomic_t state;
> > > +	int event_irq;
> > >   	int intx_irqs[PCI_NUM_INTX];
> > >   	int max_link_speed;
> > >   	enum rzg3s_pcie_controller_id controller_id;
> > > @@ -348,6 +371,61 @@ struct rzg3s_pcie_host {
> > >   #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
> > > +/**
> > > + * struct rzg3s_pcie_host_atomic_state - RZ/G3S PCIe state data structure
> > > + * @state: Atomic state variable to operate on. Should point to
> > > + *         struct rzg3s_pcie_host::state.
> > > + * @expect: Expected host state. The host state is not changed if the
> > > + *          current host state differs from the expected state.
> > > + * @saved: Saved host state. When the host state is changed, the previous
> > > + *         state is saved in this variable. This is necessary to restore
> > > + *         the previous state after the protected section is executed.
> > > + *
> > > + * This structure is necessary for state setting and restoration using
> > > + * CLASS() constructs.
> > > + */
> > > +struct rzg3s_pcie_host_atomic_state {
> > > +	atomic_t *state;
> > > +	enum rzg3s_pcie_host_state expect;
> > > +	enum rzg3s_pcie_host_state saved;
> > > +};
> > > +
> > > +static struct rzg3s_pcie_host_atomic_state
> > > +rzg3s_pcie_host_atomic_state_save(atomic_t *state, int expect, int newval)
> > > +{
> > > +	return (struct rzg3s_pcie_host_atomic_state){
> > > +		.state = state,
> > > +		.expect = expect,
> > > +		.saved = atomic_cmpxchg(state, expect, newval),
> > > +	};
> > > +}
> > > +
> > > +static void
> > > +rzg3s_pcie_host_atomic_state_restore(struct rzg3s_pcie_host_atomic_state state)
> > > +{
> > > +	if (state.saved == state.expect)
> > > +		atomic_xchg(state.state, state.expect);
> > > +}
> > > +
> > > +DEFINE_CLASS(rzg3s_pcie_host_state_lock,
> > > +	     struct rzg3s_pcie_host_atomic_state,
> > > +	     rzg3s_pcie_host_atomic_state_restore(_T),
> > > +	     rzg3s_pcie_host_atomic_state_save(state, expect, newval),
> > > +	     atomic_t *state, int expect, int newval)
> > > +
> > > +/* Use it to change the state w/o the need to restore it on function exit. */
> > > +#define RZG3S_PCIE_HOST_STATE_CHANGE(_state, _from, _to) \
> > > +	CLASS(rzg3s_pcie_host_state_lock, _lock) \
> > > +	      (_state, RZG3S_PCIE_HOST_STATE_##_from, \
> > > +		       RZG3S_PCIE_HOST_STATE_##_to) \
> > > +
> > > +/*
> > > + * Use it to check if the state change failed. _from is the initial state.
> > > + * Use it in conjunction with RZG3S_PCIE_HOST_STATE_CHANGE().
> > > + */
> > > +#define RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(_from) \
> > > +	(_lock.saved != RZG3S_PCIE_HOST_STATE_##_from)
> > > +
> > 
> > I don't really see a need for all these state management. None of the other
> > controller drivers are doing and the serialization provided by the PCI core
> > using pci_lock should be enough. If you find any issue or race, please share it
> > here.
> 
> The problems I see are the following:
> 
> 1/ In theory, the rzg3s_pcie_host_start() in .reset_root_port() can fail. If
>    that happens the controller is left with the clocks and resets disabled.
>    Accessing  it later in this state may lead to sync aborts, and the system
>    being fully blocked. This is how the HW behaves. Re-enabling clocks and
>    resets in this situation may lead to unbalanced  reference counters for them.
> 

Once reset_root_port() fails, the controller is literally dead and the error is
propagated to the PCI core. So who is going to access it later?

> 2/ In theory, struct pci_ops::{read, write} ops could be called while the reset
>    is in progress, if I'm not wrong. That can be avoided by using a common spin
>    lock but we can't use it in .reset_root_port() since this calls APIs
>    that could sleep (e.g. clk_prepare_enable()/clk_disable_unprepare())
> 

AFAICS, 'block_cfg_access' will be set for the entire duration of the
reset_root_port() invocation and it will prevent config space accessors to race
with the reset.

> 3/ Since at the moment the .suspend() is called the IRQs are enabled, the link
>    event and the .suspend() can race. This could also be avoided by using
>    a spin lock but, again, there are APIs on .reset_root_port() that can sleep.
> 

suspend/resume callbacks are only invoked in the no_irq phase.

> 4/ To keep sane the reference counted resources, handled in
>    rzg3s_pcie_host_stop()/rzg3s_pcie_host_start(), the state track would be
>    needed, for .reset_root_port() failure case and racing, since these functions
>    are also called in suspend/resume
> 

You can solve it using a simple bool flag.

So I still do not see a real need for these complex state management.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
