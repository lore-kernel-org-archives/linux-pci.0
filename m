Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C98547056
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766422; cv=none; b=Q/8eLbPlsX9FQ4R3pCG/feGcfbSTC11UQpWX57jEh0z79pK9G+shvIFctmEKHhtSMoA7jz/Q6qvKh8vuwGsLeKEskSO6yMrQpRWaG8H9RMSTKNKQtnM3rqrZvcuZCSz2cQIs4/67Q9VDKkaNeOOubChFUOT10O5o4X+UfIZMSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766422; c=relaxed/simple;
	bh=KTbWsmCC/DUIrWi5ZZar6MRsE7Hsez/N4FsUr2G7Z7Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U/12KigmZ6AiN6tcjDPclR9i+qY36D705++4gG9iFEBJ9xmeUK0QZjGrTV8NIQnmdrPikLBneNSDMvC9dBS4enc+JFzTgc1d6kllnd7JnzQw8YLsO9+q4gc4CtZhYfaydXYgrtKZXGHGSuQr9tUQMzgn4BziJHvFSbblRAgp3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8+/awYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8+/awYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538A51F0089B;
	Mon, 12 Oct 2026 00:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791766420;
	bh=3zWNS59eo6aCLON5AWgGF9gkN3+KumtirtROLC38CwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q8+/awYWcp6Gv9coilU1CzOwHPABYKlt4oNqKSdolxNh3TJMYjP5CbglbfW2pHiAT
	 Xx6X/QOy9xkWmevyo91Yu+nihtZmDGM0o42RSSUhRljWejtTWI2zjueJecqd/Op+ha
	 bvutR+fCpTo0sh5GS85FLcBub14AWCwyNf7PTVi6eFjOOgF/cQz1NXdEleEZ5nhJGF
	 QMVESNB8TRxfIXhYya8v2rcmpKgvbyqniB13wV7H7b2fVBmK+HQCv7mAim8tDttT7n
	 NscJ9KI2ldmYIIjdB7imsSU+xBrKDT949nsb/RZ3H1Co0bAlxaorEHepwx4p3k4UQU
	 QKVXxUOzsoGEQ==
Message-ID: <sashiko-outbox-167531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] samples: rust: add QEMU EDU sample driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lucas Costa" <2000.costalucas@gmail.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261012003849.82315-1-2000.costalucas@gmail.com>
References: <20261012003849.82315-1-2000.costalucas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 00:53:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] pci: unconditional IRQ_HANDLED in shared interrupt handler leads t=
o interrupt stealing
- [High] pci: dma buffer use-after-free on timeout error path in dma_test
- [High] pci: unbounded wait for hardware interrupt in probe can cause kern=
el thread deadlock
- [High] pci: infinite wait in factorial_irq due to missing timeout
- [Medium] pci: resource leak of device enable count and master state
- [Low] rust: missing #[inline] annotation on abstraction function from_raw
--

commit 72599ec79fdfa3396a1908c456cf647dcc3a5105
Author: Lucas Costa <2000.costalucas@gmail.com>

samples: rust: add QEMU EDU sample driver

Add a sample PCI driver, written in Rust, for QEMU's educational
("edu") device. The driver exercises the Rust PCI, IRQ, and DMA
abstractions in a single self-contained driver.

> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index dbaf301666e74..2747d92be91b6 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -154,9 +154,13 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Re=
sult {
> =20
>  /// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
>  impl Vendor {
> -    /// Create a Vendor from a raw 16-bit vendor ID.
> +    /// Create a [`Vendor`] from a raw 16-bit vendor ID.
> +    ///
> +    /// Prefer one of the named [`Vendor`] constants where one exists. T=
his is intended for
> +    /// vendor IDs that have no dedicated constant, e.g. test or emulate=
d devices whose IDs
> +    /// are not shared between multiple drivers and thus do not belong i=
n `pci_ids.h`.
>      #[inline]
> -    pub(super) fn from_raw(vendor_id: u16) -> Self {
> +    pub const fn from_raw(vendor_id: u16) -> Self {

[Severity: Low]
Is it intentional to remove the #[inline] annotation here?

The Rust subsystem guidelines state that small functions or functions
forwarding to a C binding call in abstractions should be annotated with
#[inline].

>          Self(vendor_id)
>      }

[ ... ]

> diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_e=
du.rs
> new file mode 100644
> index 0000000000000..e9e5593bb89a1
> --- /dev/null
> +++ b/samples/rust/rust_driver_edu.rs
[ ... ]
> +    fn factorial_irq(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Resul=
t {
> +        let operand: u32 =3D 6;
> +
> +        let msi =3D pci::IrqTypes::default().with(pci::IrqType::Msi);
> +        let vectors =3D pdev.alloc_irq_vectors(1, 1, msi)?;
> +
> +        let registration =3D KBox::pin_init(
> +            unsafe {
> +                Registration::new(
> +                    vectors.index(0)?.into(),
> +                    Flags::SHARED,
> +                    c"rust_driver_edu",
> +                    try_pin_init!(EduIrq {

[Severity: High]
Does this code handle shared interrupts correctly?

The driver requests a shared interrupt by passing Flags::SHARED for the MSI
interrupt here, but the handler implementation (EduIrq::handle) uncondition=
ally
claims the interrupt.

If the kernel invokes the handler for an interrupt raised by another device
sharing the same IRQ line, could this handler erroneously claim it,
potentially preventing the legitimate driver from handling it?

> +                        done <- Completion::new(),
> +                    }? Error),
> +                )
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        // Arm the "raise an IRQ when done" bit, then start the computat=
ion.
> +        bar.write_reg(regs::STATUS::zeroed().with_irq_on_done(true));
> +        bar.write_reg(regs::FACTORIAL::zeroed().with_value(operand));
> +
> +        // Sleep until the handler calls `complete_all()` from IRQ conte=
xt.
> +        registration.handler().done.wait_for_completion();

[Severity: High]
Could this unbounded wait cause a kernel thread deadlock during device prob=
e?

The driver puts the current kernel thread into an uninterruptible sleep sta=
te
with no timeout mechanism.

If the hardware fails to raise the interrupt or the interrupt is lost, the
wait will never complete. Could this permanently hang the kernel worker
thread running the device initialization?

> +
> +        // Acknowledge whatever the device raised so it lowers the inter=
rupt.
> +        let pending =3D bar.read(regs::INTERRUPT_STATUS).status().get();
> +        bar.write_reg(regs::INTERRUPT_ACK::zeroed().with_ack(pending));
> +
> +        let result =3D bar.read(regs::FACTORIAL).value().get();

[ ... ]

> +    fn dma_test(pdev: &pci::Device<Core<'_>>, bar: &Bar0<'_>) -> Result {
> +        const DEV_BUF: u32 =3D 0x40_000;
> +        const LEN: usize =3D 512;
> +        const CMD_START: u32 =3D 1 << 0;
> +        const CMD_TO_RAM: u32 =3D 1 << 1;
> +
> +        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<28>())? };
> +
> +        let mut src: CoherentBox<[u8]> =3D CoherentBox::zeroed_slice(pde=
v.as_ref(), LEN, GFP_KERNEL)?;
> +        src.fill(0xa5);
> +
> +        let src: Coherent<[u8]> =3D src.into();
> +
> +        let dst: Coherent<[u8]> =3D
> +            CoherentBox::<[u8]>::zeroed_slice(pdev.as_ref(), LEN, GFP_KE=
RNEL)?.into();
> +
> +        let src_dma =3D src.dma_address() as u32;
> +        let dst_dma =3D dst.dma_address() as u32;
> +
> +        let wait_dma =3D || {
> +            read_poll_timeout(
> +                || Ok(bar.read(regs::DMA_CMD).cmd().get()),
> +                |cmd| *cmd & CMD_START =3D=3D 0,
> +                Delta::from_millis(10),
> +                Delta::from_secs(1),
> +            )
> +        };
> +
> +        // 1) RAM -> device internal buffer. CMD is written last: it tri=
ggers the transfer.
> +        bar.write_reg(regs::DMA_SRC_ADDR::zeroed().with_src(src_dma));
> +        bar.write_reg(regs::DMA_DST_ADDR::zeroed().with_dst(DEV_BUF));
> +        bar.write_reg(regs::DMA_CNT::zeroed().with_size(LEN as u32));
> +        bar.write_reg(regs::DMA_CMD::zeroed().with_cmd(CMD_START));
> +        wait_dma()?;

[Severity: High]
Can this code cause a use-after-free if the DMA transfer times out?

If wait_dma() times out, it immediately propagates the error, which causes
the local variables src and dst to go out of scope and free the underlying
physical memory pages.

Because the hardware DMA engine was not explicitly halted before returning,
could the device continue to asynchronously read from or write to the newly
freed memory pages?

> +
> +        // 2) device internal buffer -> RAM, landing in `dst`.
> +        bar.write_reg(regs::DMA_SRC_ADDR::zeroed().with_src(DEV_BUF));
> +        bar.write_reg(regs::DMA_DST_ADDR::zeroed().with_dst(dst_dma));
> +        bar.write_reg(regs::DMA_CNT::zeroed().with_size(LEN as u32));
> +        bar.write_reg(regs::DMA_CMD::zeroed().with_cmd(CMD_START | CMD_T=
O_RAM));
> +        wait_dma()?;

[Severity: High]
Similarly, can this timeout error path also result in a use-after-free?

If wait_dma() times out here, the function returns and frees dst while the
device may still be actively writing to the dst_dma address.

> +
> +        // Transfer completed, check dst is the expected value
> +        let out =3D unsafe { dst.as_ref() };

[ ... ]

> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        dev_dbg!(
> +            pdev,
> +            "Probe Rust QEMU EDU driver sample (PCI ID: {}, 0x{:x}).\n",
> +            pdev.vendor_id(),
> +            pdev.device_id()
> +        );
> +
> +        pdev.enable_device_mem()?;
> +        pdev.set_master();

[Severity: Medium]
Does this code leak the PCI device enable count and bus master state?

The driver calls pdev.enable_device_mem() and pdev.set_master() during
probe(), but neither the error paths in probe() nor the driver remove path
(SampleDriverData::drop) call pci_disable_device() or pci_clear_master().

Could this permanently leak these resources on driver unload or if an error
occurs later in the probe function?

> +
> +        let bar =3D pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_d=
river_edu")?;

[ ... ]

> +impl Drop for SampleDriverData<'_> {
> +    fn drop(&mut self) {
> +        dev_dbg!(self.pdev, "Remove Rust QEMU EDU driver sample.\n");
> +    }
> +}
> +
> +/// Per-interrupt state shared between process context and IRQ context.
> +///
> +/// The factorial computation signals `done` from the IRQ handler; the p=
rocess
> +/// context that started it waits on the same [`Completion`].
> +#[pin_data]
> +struct EduIrq {
> +    #[pin]
> +    done: Completion,
> +}
> +
> +impl irq::Handler for EduIrq {
> +    // Runs in IRQ context when the EDU device raises its interrupt.
> +    fn handle(&self) -> irq::IrqReturn {
> +        self.done.complete_all();
> +        irq::IrqReturn::Handled
> +    }
> +}

[Severity: High]
Could claiming a spurious or shared interrupt prematurely complete the done
variable?

If the handler claims an interrupt not belonging to this device, it would
unblock wait_for_completion() before the data is actually ready, which could
cause the driver probe to read incomplete data from the FACTORIAL register
and fail.

> +
> +// Helper functions

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012003849.8231=
5-1-2000.costalucas@gmail.com?part=3D1
