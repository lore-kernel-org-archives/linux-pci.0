Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0F40D566
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945984; cv=none; b=qQclEPltngazSRhOZqjwyCdwZnP3J+/ioDFoQpmVA4LkPlwJKlCBgnD2OvxRtiCham+f1yMh5wVI4jM+gyRfMGMFdjJ7SwjQgNrVO0moudniw7nPYPXYDYw3rklJGaYAg8AMRNz89ydfUKQnO7IPe9ndOo3+WhagCxZf7a/PkHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945984; c=relaxed/simple;
	bh=tIOSGAD1ReQlsY+eYimBHf7+8wG6N8I0kZ3Qf1Hkvu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCI5mxtLl2+CT7HsdYcdgGi23oLcF7Ts/Q2Jj3TfJXLpoqMhkzeQoSdCawNFisIBWQvm/ME8WGgU7xLr+HdEBzftMHFoh3zqtSp4aoC2eS3sGK4ed15LnOvz955HQzNTaqRPUbrhqpMGZ0jg+IjMJ12VBtkIiqCyd2Ek2sxNk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXtYP2f4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXtYP2f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2811F000E9;
	Sat, 20 Jun 2026 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781945983;
	bh=Px/5CTQeH8sf4FoA9nkTBIRJN7UO21MYeNoAWtpDEmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iXtYP2f460fWSTk2nOg3j5O6MBQbGn50mcD71doUNWcjpQcgD3hrc+n1oa1oOMlsj
	 rDKmafm+09rcJTy4Yg7niFEIlOtV7SDYqDg4+DnYA2JmIcvsaxWGiZpPFIBdSpNvZE
	 BOM+jsN7P7cBXMyqPnhamA5w/ktUsKXT2ie5BMJlLh7IB20nZ/MkCmYURGEeAHIahb
	 a0eta8Gbv4Kqnz77dcXzD9bsg8IUe3cYj6AU+0nWm/yeqZivdTlYNCQYnvHIF+gSCr
	 j92zyhUgFUU0r1q+Rr2ExXE56/zSeuAaU1+GlfE+pO1W6o8LTwPoYLS4eRb51RU3og
	 3nEZGmKw4pPTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 08:59:42 +0000
Message-Id: <20260620085942.DF2811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Unbounded `wait_for_completion()` during device probe can hang the=
 initialization thread indefinitely.
- [High] The IRQ handler unconditionally returns `irq::IrqReturn::Handled`,=
 masking unhandled or spurious interrupts from the kernel core.
- [High] Premature free / Resource Leak of PCI IRQ vectors due to dropped R=
AII guard.
- [High] Conditional compilation failure on 32-bit architectures due to 64-=
bit I/O accesses without Kconfig dependency.
- [Medium] Race condition due to registering the IRQ handler before clearin=
g pending device interrupts.
- [Low] The sample driver does not adhere to the kernel vertical import for=
matting style.
--

commit a4248f6e8c334990c2dbb321e89efee30d176e8c
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: samples: add EDU PCI driver sample

This commit adds a Rust sample driver for the QEMU EDU device, wired up via=
 a
new SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.

> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index c49ab91063459..742c42262e9b4 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
[ ... ]
> +config SAMPLE_RUST_DRIVER_EDU
> +	tristate "EDU Driver"
> +	depends on PCI

[Severity: High]
Since the driver uses 64-bit I/O operations for DMA registers, will this
fail to compile on 32-bit architectures?

Should this config depend on 64BIT to avoid conditional compilation errors
where the IoCapable<u64> trait is unimplemented?

> +	help
> +	  This option builds the Rust EDU driver sample.
[ ... ]
> diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_e=
du.rs
> new file mode 100644
> index 0000000000000..5f4efd5140326
> --- /dev/null
> +++ b/samples/rust/rust_driver_edu.rs
[ ... ]
> +use kernel::{
> +    device::Bound,
> +    devres::Devres,
> +    dma::{Coherent, Device, DmaMask},
> +    io::{
> +        poll::read_poll_timeout,
> +        register,
> +        Io, //
> +    },
> +    irq::{self, Flags},
> +    pci::{self, IrqTypes},
> +    prelude::*,
> +    sync::{aref::ARef, Arc, Completion},

[Severity: Low]
Does this horizontal import grouping violate the kernel vertical import
style documented in the rust coding guidelines?

> +    time::Delta, //
> +};
[ ... ]
> +    fn test_irq(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverD=
ata) -> Result {
> +        dev_dbg!(pdev, "raising irq\n");
> +
> +        bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());
> +
> +        data.irq_test_completion.wait_for_completion();

[Severity: High]
If the hardware fails or is misconfigured and does not raise an interrupt,
will this unbounded wait block the initialization thread indefinitely?

Could this be replaced with a bounded wait like wait_for_completion_timeout=
()
to gracefully fail the probe?

> +        Ok(())
> +    }
> +
> +    fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverD=
ata) -> Result {
> +        dev_dbg!(pdev, "testing dma\n");
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
Similarly, is there a risk of hanging the kernel thread indefinitely here
if the DMA interrupt never fires?

> +
> +        // Destroy previous value to test roundtrip
> +        kernel::dma_write!(dma, , 0);
[ ... ]
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<kernel::device::Core<'_>>,
> +        _id_info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        pin_init::pin_init_scope(move || {
[ ... ]
> +            let irq =3D pdev
> +                .alloc_irq_vectors(1, 1, IrqTypes::default().with(pci::I=
rqType::Msi))
> +                .inspect_err(|e| dev_err!(pdev, "alloc_irq_vectors faile=
d: {:?}\n", e))?;
[ ... ]
> +            let req =3D irq::Registration::new(
> +                (*irq.start()).try_into()?,
> +                Flags::TRIGGER_NONE,
> +                c"rust_edu_irq",
> +                Ok(data.clone()),
> +            );
> +
> +            // Ordering matters: the handler is registered (`irq_handler=
 <- req`)
> +            // *before* the `_:` block runs the self-tests, one of which=
 raises an
> +            // interrupt and waits for the handler. Raising before the h=
andler is
> +            // registered would hang (the completion is never signalled).
> +            Ok(try_pin_init!(Self {
> +                irq_handler <- req,

[Severity: Medium]
Is it possible for a pending device interrupt from a prior session or reset
failure to trigger immediately upon registering the handler here?

If the device state is not yet validated and quiescent, could a spurious
interrupt cause the handler to consume the irq_dma_completion or
irq_test_completion prematurely?

> +                // Side-effect block: run the staged self-tests against =
the mapped
> +                // BAR now that the handler is live. A failure here abor=
ts probe.
> +                _: {
> +                    let bar =3D data.bar.access(pdev.as_ref())?;
> +                    EduDriver::init(pdev, bar, &data)?;
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

[Severity: High]
Does the local variable irq drop at the end of this closure, prematurely
freeing the allocated PCI IRQ vectors?

Since irq isn't stored in the initialized EduDriver struct state, would this
result in a use-after-free of the IRQ vectors?

> +impl irq::Handler for EduDriverData {
> +    fn handle(&self, pdev: &kernel::device::Device<Bound>) -> irq::IrqRe=
turn {
> +        dev_dbg!(pdev, "irq handler called\n");
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
> +    }
> +}

[Severity: High]
By unconditionally returning irq::IrqReturn::Handled, could this mask
unhandled or spurious interrupts from the kernel core?

If the interrupt line is shared or level-triggered, could a failure to retu=
rn
irq::IrqReturn::None defeat the kernel's spurious interrupt detector and
potentially cause an IRQ storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-b4-rust-pc=
i-edu-driver-v2-0-6fd6684f2c14@mailbox.org?part=3D4
