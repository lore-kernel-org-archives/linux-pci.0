Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F0317162
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453799; cv=none; b=F7GmRrO7sl968S+bHZ2u2GaYMFGolSdeK93Ji0++qZBaDj2Tcl1mgL36WiBgXl9ukZMvJBuBktk5QXMYv+4D+oDtkyHBboiW23kbsGBlfzc3d3Bqa7+CcYucnhDlwftQllQSeN6+lR0Z2+xfbmTALRPpbcaDDusdF9RNyRkM2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453799; c=relaxed/simple;
	bh=RQRK/WWbSK02Cir8k88OGp1ureAWdkr6Fky3CT+34ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a2qku650odkp4Jgf1tiRwVs5odOIyy1Og06EFtNmIzVloKEkVXt5my2LSa13SSTlNCuvDVk6M9kjZCZohVlgiPZUG/++iY09dZRbFK46/t2Js88rvT0pTVLc4+cNzGNaxxzguOByEWsn02C0Yyfj+aUhNGyymWnh/sDJgTcvcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbcDiLq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbcDiLq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DAF1F000E9;
	Sun, 14 Jun 2026 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781453798;
	bh=BTOWsxIuOT6WHyAovIBGY0mAILVyjAhE/SzfUZrEd50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbcDiLq/V243UjUNVnj5GT6X8Rl1WrbMWyTPP0WuekzRbE9NrbsxzTOwZs7aqnM4I
	 O5iRAhLxCmh+T3YOCtJ+hXIRW6IJ5aQWveEUdNHBon2xdAk5Rxui4YZfNk8DvNzANd
	 iCHwjkELXKBg4chV/hxiTeZzOCwRQfdCoJ1oSENS/y6T1rxrqUGQBuutGJ6gWFFlMK
	 ld/vJDrktM42w+1gYZ6v6A4NNrK6hJfl+wrwyXI4jG4ibvYBDY4BVQhgIEYqm7q9XB
	 XbEY7hhs6AAC3+Expxd9Yxn6BSj8155sRuuDICTHTuqPr9vX6ytyU2v0rQ+Fo04+6L
	 aBSzxR/XU2iAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] rust: samples: add EDU PCI driver sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-4-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-4-e3f2471b595c@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 16:16:37 +0000
Message-Id: <20260614161637.C9DAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The IRQ handler unconditionally returns `irq::IrqReturn::Handled` =
even if no interrupt was serviced.
- [High] The driver blocks indefinitely in `probe()` waiting for hardware i=
nterrupts, risking a system hang.
- [High] An unacknowledged factorial interrupt causes the subsequent IRQ te=
st to fail and hang indefinitely.
- [High] Leftover interrupts or spurious IRQs trigger premature completions=
, causing a data race with active DMA transfers.
- [High] The allocated PCI IRQ vectors are prematurely freed before the dri=
ver is fully initialized, permanently breaking interrupts.
--

commit 028e22726596441f18ba4b799ddf50110e879fa5
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: samples: add EDU PCI driver sample
   =20
Add a Rust sample driver for the QEMU EDU device, wired up via a new
SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.

> diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_e=
du.rs
> new file mode 100644
> index 0000000000000..c092117473d3d
> --- /dev/null
> +++ b/samples/rust/rust_driver_edu.rs

[ ... ]

> +    fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
> +        Self::wait_until_compute_has_finished(pdev, bar)?;
> +
> +        bar.write(regs::FACTORIAL, 4.into());
> +
> +        Self::wait_until_compute_has_finished(pdev, bar)?;
> +
> +        let result: u32 =3D bar.read(regs::FACTORIAL).into();

[Severity: High]
Does this code leave the FACT_IRQ bit set in IRQ_STATUS without acknowledgi=
ng
it?

Since IRQ_ACK is never written to clear this completion, could the leftover
unacknowledged interrupt cause the strict equality check
magic =3D=3D IRQ_MAGIC_VALUE to fail later in the IRQ handler, and block
test_irq() indefinitely?

> +
> +        let expected =3D 24;

[ ... ]

> +    fn test_irq(pdev: &pci::Device<Bound>, bar: &Bar0, data: &Arc<EduDri=
verData>) -> Result {
> +        dev_dbg!(pdev, "raising irq\n");
> +
> +        bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());
> +
> +        data.irq_test_completion.wait_for_completion();

[Severity: High]
Can this block probe() indefinitely?

If the hardware fails to raise the interrupt, wouldn't waiting without a
timeout stall the driver probe sequence and potentially lock up subsystem
initialization?

> +        Ok(())
> +    }
> +
> +    fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data: &Arc<EduDri=
verData>) -> Result {

[ ... ]

> +        bar.write(
> +            regs::DMA_COMMAND,
> +            regs::DMA_COMMAND::zeroed()
> +                .with_start_transfer(true)
> +                .with_direction(false)
> +                .with_raise_irq(true),
> +        );
> +
> +        data.irq_dma_completion.wait_for_completion();

[Severity: High]
As with test_irq(), can this unbounded wait hang the system if the DMA
interrupt never arrives?

> +
> +        // Destroy previous value to test roundtrip
> +        kernel::dma_write!(dma, , 0);
> +
> +        bar.write(regs::DMA_SRC, QEMU_DMA_BASE.into());
> +        bar.write(regs::DMA_DST, dma.dma_handle().into());
> +        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());
> +        bar.write(
> +            regs::DMA_COMMAND,
> +            regs::DMA_COMMAND::zeroed()
> +                .with_start_transfer(true)
> +                .with_direction(true)
> +                .with_raise_irq(true),
> +        );
> +
> +        data.irq_dma_completion.wait_for_completion();

[Severity: High]
Could this return immediately due to stale completion counts?

If there are leftover interrupts from a previous module load or a spurious =
IRQ
inflates the completion count before this second transfer,
wait_for_completion() might not wait for the active transfer. Could this
result in a data race with the active DMA transfer?

> +
> +        let result =3D kernel::dma_read!(dma,);

[ ... ]

> +    fn probe(
> +        pdev: &pci::Device<kernel::device::Core>,
> +        _id_info: &Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> {
> +        pin_init::pin_init_scope(move || {

[ ... ]

> +            let irq =3D pdev
> +                .alloc_irq_vectors(1, 1, IrqTypes::default().with(pci::I=
rqType::Msi))
> +                .inspect_err(|e| dev_err!(pdev, "alloc_irq_vectors faile=
d: {:?}\n", e))?;
> +
> +            // State shared with the IRQ handler (the BAR and the comple=
tion the
> +            // handler signals) lives in an `Arc<EduDriverData>`. `EduDr=
iverData`

[ ... ]

> +            Ok(try_pin_init!(Self {
> +                irq_handler <- req,
> +                // Side-effect block: run the staged self-tests against =
the mapped
> +                // BAR now that the handler is live. A failure here abor=
ts probe.
> +                _: {
> +                    let bar =3D data.bar.access(pdev.as_ref())?;
> +                    EduDriver::init(pdev, bar, &data)?;

[Severity: High]
Are the allocated IRQ vectors prematurely freed before this block executes?

Since irq is a local variable in the closure passed to pin_init_scope(),
won't its Drop implementation run and free the vectors when the closure
returns? This would happen before the initializer is pinned and the
side-effect block runs EduDriver::init(), causing the self-tests to trigger
device events on freed IRQ vectors.

> +                    dev_info!(
> +                        pdev,
> +                        "rust_driver_edu successfully initialized\n",
> +                    );
> +                },
> +                data,
> +                pdev: pdev.into()
> +            }))
> +        })
> +    }
> +}
> +
> +impl irq::Handler for EduDriverData {
> +    fn handle(&self, pdev: &kernel::device::Device<Bound>) -> irq::IrqRe=
turn {

[ ... ]

> +        // TEST_IRQ
> +        let magic =3D status & !DMA_IRQ;
> +        if magic =3D=3D IRQ_MAGIC_VALUE {
> +            dev_dbg!(pdev, "handling test completion in irq\n");
> +            bar.write(regs::IRQ_ACK, magic.into());
> +            self.irq_test_completion.complete();
> +        }
> +
> +        irq::IrqReturn::Handled

[Severity: High]
Will returning irq::IrqReturn::Handled unconditionally circumvent the kerne=
l's
spurious interrupt detection mechanism?

If IRQ_STATUS is 0 or no specific interrupt source is found, wouldn't claim=
ing
to handle the interrupt cause an infinite IRQ storm instead of correctly
returning irq::IrqReturn::None?

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-rust-pc=
i-edu-driver-v1-0-e3f2471b595c@mailbox.org?part=3D4
