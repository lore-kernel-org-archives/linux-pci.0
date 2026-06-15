Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F43DC4A3
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518365; cv=none; b=szSPooFkttZ9F0qG127VkkGgra6+0ZDl1nbXkq0RZ2iapRaaMBHn6v0s3Ay8vlu/eGeUknSY7e4uRR1JD/tRiahW3n31IhsuN8m4djvzA1tkpgDMwBoihVabnS5GjMM0H7y9tR05OkUCa4qfVSAaXfnLX/5YMwg/2jupe33lvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518365; c=relaxed/simple;
	bh=N81QtR1cWsMrq2f4BueSffN6tt9zfJSjrfND7KI3evo=;
	h=Subject:Message-ID:Date:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ebo3v0g0k5DUY1/3vyA911AawdWE6NP84w5kgRAkpG/bvaUDmL+dnuYXeUTTVHhIfrT3NYC5vpiUbQWEOZ/OF684ExFTrEDdGRLNY49Bq3zieNDEwYef/Q79SMX76Zp/EVzk/2sUkzMSSJcvExlgl9UKxe3NZ+P5p90cNokddsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=16a+bLUi; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="16a+bLUi"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gf5XJ5HwXzwxv;
	Mon, 15 Jun 2026 12:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1781518352; bh=yPgAxKyTKK4gusJAaDk6SJgPrrt7wHffFNY2K6nQ5B0=;
	h=Subject:Date:From:To:Cc:Reply-To:References:In-Reply-To:From;
	b=16a+bLUielZ3GK04E7c5fx77j2C1Rmjno5Dccti242U9FldW+/JYgGqN5702Vyehc
	 oM0hSjFCO9s4wI8BkinMJgU9PIp7HyqyYMZGDae0BRO1z/m+PzO31zfAxifb7tv2bd
	 vXuFEMwioA77P4XjrXUsWC8WwmebI/Y22A96uF9A=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gf5XH3wCtzPdy;
	Mon, 15 Jun 2026 12:12:31 +0200 (CEST)
Subject: Re: [PATCH 4/4] rust: samples: add EDU PCI driver sample
Message-ID: <af210580-4c41-404d-ab27-f8af634bec19@mail.infomaniak.com>
Date: Mon, 15 Jun 2026 12:12:31 +0200
From: Ewan Chorynski <ewan.chorynski@ik.me>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Reply-To: Ewan Chorynski <ewan.chorynski@ik.me>
X-WS-Location: eJxzKUpMKykGAAfpAmU-
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
 <20260614-b4-rust-pci-edu-driver-v1-4-e3f2471b595c@mailbox.org>
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-4-e3f2471b595c@mailbox.org>
X-Mailer: Infomaniak Workspace (1.3.1281)
X-WS-User-Origin: eyJpdiI6ImVodUxDdkpZY3FnUXdLZGIxTjNxTlE9PSIsInZhbHVlIjoiQWJwVGdqYXoyeGZNbHJiZ2hvYUI5Zz09IiwibWFjIjoiYWY2ZmZhYmRiNzNmYTcwOWNhMGQ2NDRjYjBjMzdjMzRjMDUxM2FjNDU5ZTExY2UwYWRkYTMxNjRhZTkyZjQzNCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IjB6OWl3L2hYUWVoQUd1M0lpYlVoRmc9PSIsInZhbHVlIjoiQmV4VGFCMFgxdzIzZWswZEhjWk1MZz09IiwibWFjIjoiNWE5NDhkNzQzN2I2NDkyNGFiYzcyZWIyOTVhMzdhMWMxNGI3Mjc0NmNiYmEyMDlkNmMwZTMwNWZmNDNkNTQzNiIsInRhZyI6IiJ9
X-WS-LOCALE: fr_FR
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: :4c7cc581d092470:ham:e74197f626dda86
X-Infomaniak-Routing: alpha

Le 2026-06-14T17:59:48.000+02:00, Maurice Hieronymus <mhi@mailbox.org> a =
=C3=A9crit :
>  Add a Rust sample driver for the QEMU EDU device, wired up via a new
> SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
>  samples/rust/Kconfig            |  11 ++
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_driver_edu.rs | 379 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 391 insertions(+)
>=20
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index c49ab9106345..742c42262e9b 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -118,6 +118,17 @@ config SAMPLE_RUST_DRIVER_PCI
> =20
>  =09  If unsure, say N.
> =20
> +config SAMPLE_RUST_DRIVER_EDU
> +=09tristate "EDU Driver"
> +=09depends on PCI
> +=09help
> +=09  This option builds the Rust EDU driver sample.
> +
> +=09  To compile this as a module, choose M here:
> +=09  the module will be called rust_driver_edu.
> +
> +=09  If unsure, say N.
> +
>  config SAMPLE_RUST_DRIVER_PLATFORM
>  =09tristate "Platform Driver"
>  =09help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 6c0aaa58cccc..c24a328243b1 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DMA)=09=09=09+=3D rust_dma.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)=09=09+=3D rust_driver_i2c.o
>  obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)=09=09+=3D rust_i2c_client.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)=09=09+=3D rust_driver_pci.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_EDU)=09=09+=3D rust_driver_edu.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)=09+=3D rust_driver_platform.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)=09=09+=3D rust_driver_usb.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)=09=09+=3D rust_driver_faux.o
> diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_e=
du.rs
> new file mode 100644
> index 000000000000..c092117473d3
> --- /dev/null
> +++ b/samples/rust/rust_driver_edu.rs
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust EDU driver sample (based on QEMU's `edu`).
> +//!
> +//! To make this driver probe, QEMU must be run with `-device edu`.
> +
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
> +    time::Delta, //
> +};
> +
> +const QEMU_VENDOR_ID: u16 =3D 0x1234;
> +const QEMU_EDU_DEVICE_ID: u32 =3D 0x11e8;
> +const QEMU_EDU_DEVICE_MAGIC: u8 =3D 0xed;
> +const QEMU_DMA_BASE: u64 =3D 0x40000;
> +
> +const IRQ_MAGIC_VALUE: u32 =3D 42;
> +
> +/// Bit set in `IRQ_STATUS` when a DMA transfer has completed.
> +const DMA_IRQ: u32 =3D 0x100;
> +
> +mod regs {
> +    use super::*;
> +
> +    register! {
> +        pub(super) IDENTIFICATION(u32) @ 0x0 {
> +            31:24 major;
> +            23:16 minor;
> +            7:0 magic;
> +        }
> +
> +        pub(super) LIVENESS_CHECK(u32) @ 0x04 {}
> +
> +        pub(super) FACTORIAL(u32) @ 0x08 {}
> +
> +        pub(super) STATUS(u32) @ 0x20 {
> +            0:0 computing;
> +            7:7 raise_interrupt;
> +        }
> +
> +        pub(super) IRQ_STATUS(u32) @ 0x24 {}
> +        pub(super) IRQ_RAISE(u32) @ 0x60 {}
> +        pub(super) IRQ_ACK(u32) @ 0x64 {}
> +
> +        pub(super) DMA_SRC(u64) @ 0x80 {}
> +        pub(super) DMA_DST(u64) @ 0x88 {}
> +        pub(super) DMA_COUNT(u64) @ 0x90 {}
> +        pub(super) DMA_COMMAND(u64) @ 0x98 {
> +            0:0 start_transfer;
> +            1:1 direction;
> +            2:2 raise_irq;
> +        }
> +    }
> +
> +    pub(super) const END: usize =3D 0xA0;
> +}
> +
> +type Bar0 =3D pci::Bar<{ regs::END }>;
> +
> +#[pin_data(PinnedDrop)]
> +struct EduDriver {
> +    pdev: ARef<pci::Device>,
> +    data: Arc<EduDriverData>,
> +    #[pin]
> +    irq_handler: irq::Registration<Arc<EduDriverData>>,
> +}
> +
> +#[pin_data]
> +struct EduDriverData {
> +    #[pin]
> +    bar: Devres<Bar0>,
> +    #[pin]
> +    irq_test_completion: Completion,
> +    #[pin]
> +    irq_dma_completion: Completion,
> +    dma: Coherent<u64>,
> +}
> +
> +impl EduDriver {
> +    fn init(pdev: &pci::Device<Bound>, bar: &Bar0, data: &Arc<EduDriverD=
ata>) -> Result {
You can pass &EduDriverData instead

> +        Self::magic(pdev, bar)?;
> +        Self::liveness_check(pdev, bar)?;
> +        Self::factorial(pdev, bar)?;
> +        Self::test_irq(pdev, bar, data)?;
> +        Self::test_dma(pdev, bar, data)?;
> +        Ok(())
> +    }
> +
> +    fn magic(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
> +        let identification =3D bar.read(regs::IDENTIFICATION);
> +
> +        let magic: u8 =3D identification.magic().into();
> +
> +        if magic !=3D QEMU_EDU_DEVICE_MAGIC {
> +            dev_err!(
> +                pdev,
> +                "magic mismatch: expected {:#x} got {:#x}\n",
> +                QEMU_EDU_DEVICE_MAGIC,
> +                magic
> +            );
> +            return Err(ENODEV);
> +        }
> +
> +        dev_info!(
> +            pdev,
> +            "major: {:#x} minor: {:#x}\n",
> +            identification.major(),
> +            identification.minor()
> +        );
> +        Ok(())
> +    }
> +
> +    fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
> +        let test_value =3D 0xabcd;
> +
> +        bar.write(regs::LIVENESS_CHECK, test_value.into());
> +
> +        let inverse_value =3D bar.read(regs::LIVENESS_CHECK).into_raw();
> +
> +        if inverse_value !=3D !test_value {
> +            dev_err!(
> +                pdev,
> +                "inverse mismatch: expected {:#x} got {:#x}\n",
> +                !test_value,
> +                inverse_value
> +            );
> +            return Err(ENODEV);
> +        }
> +
> +        dev_info!(pdev, "inverse test successful\n");
> +        Ok(())
> +    }
> +
> +    fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
> +        Self::wait_until_compute_has_finished(pdev, bar)?;
> +
> +        bar.write(regs::FACTORIAL, 4.into());
> +
> +        Self::wait_until_compute_has_finished(pdev, bar)?;
> +
> +        let result: u32 =3D bar.read(regs::FACTORIAL).into();
> +
> +        let expected =3D 24;
> +
> +        if result !=3D expected {
> +            dev_err!(
> +                pdev,
> +                "factorial result wrong: expected {} got {}\n",
> +                expected,
> +                result
> +            );
> +            return Err(ENODEV);
> +        }
> +
> +        dev_info!(pdev, "factorial test successful\n");
> +        Ok(())
> +    }
> +
> +    fn test_irq(pdev: &pci::Device<Bound>, bar: &Bar0, data: &Arc<EduDri=
verData>) -> Result {
Same here

> +        dev_dbg!(pdev, "raising irq\n");
> +
> +        bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());
> +
> +        data.irq_test_completion.wait_for_completion();
> +        Ok(())
> +    }
> +
> +    fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data: &Arc<EduDri=
verData>) -> Result {
And here

> +        dev_dbg!(pdev, "testing dma\n");
> +
> +        let dma =3D &data.dma;
> +
> +        const DMA_VALUE: u64 =3D 42;
> +
> +        kernel::dma_write!(dma, , DMA_VALUE);
> +
> +        bar.write(regs::DMA_SRC, dma.dma_handle().into());
> +        bar.write(regs::DMA_DST, QEMU_DMA_BASE.into());
> +        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());
> +        bar.write(
> +            regs::DMA_COMMAND,
> +            regs::DMA_COMMAND::zeroed()
> +                .with_start_transfer(true)
> +                .with_direction(false)
> +                .with_raise_irq(true),
> +        );
> +
> +        data.irq_dma_completion.wait_for_completion();
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
> +
> +        let result =3D kernel::dma_read!(dma,);
> +
> +        if result !=3D DMA_VALUE {
> +            dev_err!(
> +                pdev,
> +                "dma result wrong: expected {} got {}\n",
> +                DMA_VALUE,
> +                result
> +            );
> +            return Err(ENODEV);
> +        }
> +
> +        dev_info!(pdev, "dma test successful\n");
> +        Ok(())
> +    }
> +
> +    fn wait_until_compute_has_finished(pdev: &pci::Device<Bound>, bar: &=
Bar0) -> Result {
> +        if read_poll_timeout(
> +            || Ok(bar.read(regs::STATUS)),
> +            |status| status.computing() =3D=3D 0,
> +            Delta::from_millis(10),
> +            Delta::from_millis(100),
> +        )
> +        .is_err()
> +        {
> +            dev_err!(pdev, "computation bit did not clear before timeout=
\n");
> +            return Err(ETIMEDOUT);
> +        }
You can replace the if block with read_poll_timeout(...).inspect_err(|_| de=
v_err!(pdev, ...))?;

> +        Ok(())
> +    }
> +}
> +
> +impl pci::Driver for EduDriver {
> +    type IdInfo =3D ();
> +
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> +
> +    fn probe(
> +        pdev: &pci::Device<kernel::device::Core>,
> +        _id_info: &Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> {
> +        pin_init::pin_init_scope(move || {
> +            let vendor =3D pdev.vendor_id();
> +            dev_dbg!(
> +                pdev,
> +                "Probe Rust EDU driver sample (PCI ID: {}, 0x{:x}).\n",
> +                vendor,
> +                pdev.device_id()
> +            );
> +
> +            pdev.enable_device()?;
> +            pdev.set_master();
> +
> +            let mask =3D DmaMask::new::<28>();
> +
> +            // SAFETY: There are no concurrent calls to DMA allocation a=
nd mapping primitives.
> +            unsafe { pdev.dma_set_mask_and_coherent(mask)? };
> +
> +            let ca: Coherent<u64> =3D Coherent::zeroed(pdev.as_ref(), GF=
P_KERNEL)?;
> +
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
> +            // itself implements `irq::Handler`, and the registration ta=
kes an
> +            // `Arc<T>` via the `impl Handler for Arc<T>` blanket impl. =
This keeps
> +            // the handler's state out of `EduDriver` and avoids a self-=
reference.
> +            let data =3D Arc::pin_init(
> +                try_pin_init!(EduDriverData {
> +                    bar <- pdev.iomap_region_sized(0, c"rust_driver_edu"=
),
> +                    irq_test_completion <- Completion::new(),
> +                    irq_dma_completion <- Completion::new(),
> +                    dma: ca,
> +                }),
> +                GFP_KERNEL,
> +            )?;
> +
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
> +            // registered would hang (the completion is never signalled)=
.
> +            Ok(try_pin_init!(Self {
> +                irq_handler <- req,
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
> +}
> +
> +impl irq::Handler for EduDriverData {
> +    fn handle(&self, pdev: &kernel::device::Device<Bound>) -> irq::IrqRe=
turn {
> +        dev_dbg!(pdev, "irq handler called\n");
> +        // `access()` only fails on device mismatch, so this branch is
> +        // structurally unreachable here, but it must be handled.
> +        let Ok(bar) =3D self.bar.access(pdev.as_ref()) else {
> +            dev_err!(pdev, "cannot access bar register inside irq handle=
r\n");
> +            return irq::IrqReturn::None;
> +        };
> +        let status: u32 =3D bar.read(regs::IRQ_STATUS).into();
> +
> +        // DMA_IRQ
> +        if status & DMA_IRQ !=3D 0 {
> +            dev_dbg!(pdev, "handling dma completion in irq\n");
> +            bar.write(regs::IRQ_ACK, DMA_IRQ.into());
> +            self.irq_dma_completion.complete();
> +        }
> +
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
> +
> +#[pinned_drop]
> +impl PinnedDrop for EduDriver {
> +    fn drop(self: Pin<&mut Self>) {
> +        dev_dbg!(self.pdev, "Remove Rust EDU driver sample.\n");
> +    }
> +}
> +
> +kernel::pci_device_table!(
> +    PCI_TABLE,
> +    MODULE_PCI_TABLE,
> +    <EduDriver as pci::Driver>::IdInfo,
> +    [(
> +        pci::DeviceId::from_id(pci::Vendor::from_raw(QEMU_VENDOR_ID), QE=
MU_EDU_DEVICE_ID),
> +        ()
> +    )]
> +);
> +
> +kernel::module_pci_driver! {
> +    type: EduDriver,
> +    name: "rust_driver_edu",
> +    authors: ["Maurice Hieronymus"],
> +    description: "Rust EDU driver",
> +    license: "GPL v2",
> +}
>=20
> --=20

Regards
