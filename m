Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865221E7C12;
	Sat, 20 Jun 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948738; cv=none; b=MJSWrYrwruRZO9ULZpSBC6Tb65PDvdarcH5egPvByGhM6buK63re8T7pB0Fi5eI2jXUvFHdCMXVhzdK0yt5HMen69ZQAS3tmSnatzCYX0nXAVenzzFj+2Jt2w33Hu/Vd1FM/6wzh86s/VuLnMD9pSd/nmuSSMp3yIl/tA19IEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948738; c=relaxed/simple;
	bh=FM7x9mbNBXi2mY5rEq/jlK3RjBhps3GLPVflatc3f50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTHerjoyQ8ERW4lTpic5jzzMDD2qzTTcTdCpn1Mo78ur/PIifmEGzWV0nbQdxIVmKFtseNliJcFFnhloRc6XksjJYvaCYijtFVWzHTMdcLf7Tge46Pe/m2tDSRbUNmkPYC9goilDBiSEzKb05pGYZ1IGOkgAQEru6BL2cOTkQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=o07VNPdg; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="o07VNPdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781948725; x=1782207925;
	bh=w91UndrluKphMXNpueUBXxeaF2lQLWm1pS5wQP8BHjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=o07VNPdgoOd5Ze6jio7ua0uuXT05tFzo0pz43nbywU25cOiUHaxv2NYAkbW7CAYGP
	 +ZGXaEXtIqTUNLB++JwHaz/LEic9DuYWFOFPCqBRsO4rkbcUzQEx2vaWtQbbaLVPyM
	 hxeHPemofw+jqr0Hp77gjvx/1Pz+0s5r7g7uO7ifTUCXaNlDVVRn8/SY9dGY4zfT+8
	 UEwibUG/uwoRDOcRew0KoeRBDvDR/bL2v548spY3lklUrJqUkQ/hciVHhPlQkE6eXq
	 WZEVINlhc1SlgHSd1MClMBtFzStMvw9C6FHwAugeXVMJhyGO2TY4txVqf2bT9D1y8V
	 uE4Zp0AO+OUdQ==
X-Pm-Submission-Id: 4gj8hf4sxYz2ScjF
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Lyude Paul <lyude@redhat.com>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
Date: Sat, 20 Jun 2026 12:45:19 +0300
Message-ID: <20260620094521.6484-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org> <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Jun 2026 10:45:48 +0200=0D
Maurice Hieronymus <mhi@mailbox.org> wrote:=0D
=0D
> Add a Rust sample driver for the QEMU EDU device, wired up via a new=0D
> SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.=0D
> =0D
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>=0D
> ---=0D
>  samples/rust/Kconfig            |  11 ++=0D
>  samples/rust/Makefile           |   1 +=0D
>  samples/rust/rust_driver_edu.rs | 378 ++++++++++++++++++++++++++++++++++=
++++++=0D
>  3 files changed, 390 insertions(+)=0D
> =0D
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig=0D
> index c49ab9106345..742c42262e9b 100644=0D
> --- a/samples/rust/Kconfig=0D
> +++ b/samples/rust/Kconfig=0D
> @@ -118,6 +118,17 @@ config SAMPLE_RUST_DRIVER_PCI=0D
>  =0D
>  	  If unsure, say N.=0D
>  =0D
> +config SAMPLE_RUST_DRIVER_EDU=0D
> +	tristate "EDU Driver"=0D
> +	depends on PCI=0D
> +	help=0D
> +	  This option builds the Rust EDU driver sample.=0D
> +=0D
> +	  To compile this as a module, choose M here:=0D
> +	  the module will be called rust_driver_edu.=0D
> +=0D
> +	  If unsure, say N.=0D
> +=0D
>  config SAMPLE_RUST_DRIVER_PLATFORM=0D
>  	tristate "Platform Driver"=0D
>  	help=0D
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile=0D
> index 6c0aaa58cccc..c24a328243b1 100644=0D
> --- a/samples/rust/Makefile=0D
> +++ b/samples/rust/Makefile=0D
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DMA)			+=3D rust_dma.o=0D
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+=3D rust_driver_i2c.o=0D
>  obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+=3D rust_i2c_client.o=0D
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+=3D rust_driver_pci.o=0D
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_EDU)		+=3D rust_driver_edu.o=0D
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+=3D rust_driver_platform.o=0D
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+=3D rust_driver_usb.o=0D
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+=3D rust_driver_faux.o=0D
> diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_e=
du.rs=0D
> new file mode 100644=0D
> index 000000000000..5f4efd514032=0D
> --- /dev/null=0D
> +++ b/samples/rust/rust_driver_edu.rs=0D
> @@ -0,0 +1,378 @@=0D
> +// SPDX-License-Identifier: GPL-2.0=0D
> +=0D
> +//! Rust EDU driver sample (based on QEMU's `edu`).=0D
> +//!=0D
> +//! To make this driver probe, QEMU must be run with `-device edu`.=0D
> +=0D
> +use kernel::{=0D
> +    device::Bound,=0D
> +    devres::Devres,=0D
> +    dma::{Coherent, Device, DmaMask},=0D
> +    io::{=0D
> +        poll::read_poll_timeout,=0D
> +        register,=0D
> +        Io, //=0D
> +    },=0D
> +    irq::{self, Flags},=0D
> +    pci::{self, IrqTypes},=0D
> +    prelude::*,=0D
> +    sync::{aref::ARef, Arc, Completion},=0D
> +    time::Delta, //=0D
> +};=0D
=0D
Multiple lines above needs to follow vertical style import.=0D
=0D
- Onur=0D
=0D
> +=0D
> +const QEMU_VENDOR_ID: u16 =3D 0x1234;=0D
> +const QEMU_EDU_DEVICE_ID: u32 =3D 0x11e8;=0D
> +const QEMU_EDU_DEVICE_MAGIC: u8 =3D 0xed;=0D
> +const QEMU_DMA_BASE: u64 =3D 0x40000;=0D
> +=0D
> +const IRQ_MAGIC_VALUE: u32 =3D 42;=0D
> +=0D
> +/// Bit set in `IRQ_STATUS` when a DMA transfer has completed.=0D
> +const DMA_IRQ: u32 =3D 0x100;=0D
> +=0D
> +mod regs {=0D
> +    use super::*;=0D
> +=0D
> +    register! {=0D
> +        pub(super) IDENTIFICATION(u32) @ 0x0 {=0D
> +            31:24 major;=0D
> +            23:16 minor;=0D
> +            7:0 magic;=0D
> +        }=0D
> +=0D
> +        pub(super) LIVENESS_CHECK(u32) @ 0x04 {}=0D
> +=0D
> +        pub(super) FACTORIAL(u32) @ 0x08 {}=0D
> +=0D
> +        pub(super) STATUS(u32) @ 0x20 {=0D
> +            0:0 computing;=0D
> +            7:7 raise_interrupt;=0D
> +        }=0D
> +=0D
> +        pub(super) IRQ_STATUS(u32) @ 0x24 {}=0D
> +        pub(super) IRQ_RAISE(u32) @ 0x60 {}=0D
> +        pub(super) IRQ_ACK(u32) @ 0x64 {}=0D
> +=0D
> +        pub(super) DMA_SRC(u64) @ 0x80 {}=0D
> +        pub(super) DMA_DST(u64) @ 0x88 {}=0D
> +        pub(super) DMA_COUNT(u64) @ 0x90 {}=0D
> +        pub(super) DMA_COMMAND(u64) @ 0x98 {=0D
> +            0:0 start_transfer;=0D
> +            1:1 direction;=0D
> +            2:2 raise_irq;=0D
> +        }=0D
> +    }=0D
> +=0D
> +    pub(super) const END: usize =3D 0xA0;=0D
> +}=0D
> +=0D
> +type Bar0 =3D pci::Bar<'static, { regs::END }>;=0D
> +=0D
> +#[pin_data(PinnedDrop)]=0D
> +struct EduDriver {=0D
> +    pdev: ARef<pci::Device>,=0D
> +    data: Arc<EduDriverData>,=0D
> +    #[pin]=0D
> +    irq_handler: irq::Registration<Arc<EduDriverData>>,=0D
> +}=0D
> +=0D
> +#[pin_data]=0D
> +struct EduDriverData {=0D
> +    #[pin]=0D
> +    bar: Devres<Bar0>,=0D
> +    #[pin]=0D
> +    irq_test_completion: Completion,=0D
> +    #[pin]=0D
> +    irq_dma_completion: Completion,=0D
> +    dma: Coherent<u64>,=0D
> +}=0D
> +=0D
> +impl EduDriver {=0D
> +    fn init(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverData)=
 -> Result {=0D
> +        Self::magic(pdev, bar)?;=0D
> +        Self::liveness_check(pdev, bar)?;=0D
> +        Self::factorial(pdev, bar)?;=0D
> +        Self::test_irq(pdev, bar, data)?;=0D
> +        Self::test_dma(pdev, bar, data)?;=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    fn magic(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {=0D
> +        let identification =3D bar.read(regs::IDENTIFICATION);=0D
> +=0D
> +        let magic: u8 =3D identification.magic().into();=0D
> +=0D
> +        if magic !=3D QEMU_EDU_DEVICE_MAGIC {=0D
> +            dev_err!(=0D
> +                pdev,=0D
> +                "magic mismatch: expected {:#x} got {:#x}\n",=0D
> +                QEMU_EDU_DEVICE_MAGIC,=0D
> +                magic=0D
> +            );=0D
> +            return Err(ENODEV);=0D
> +        }=0D
> +=0D
> +        dev_info!(=0D
> +            pdev,=0D
> +            "major: {:#x} minor: {:#x}\n",=0D
> +            identification.major(),=0D
> +            identification.minor()=0D
> +        );=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {=
=0D
> +        let test_value =3D 0xabcd;=0D
> +=0D
> +        bar.write(regs::LIVENESS_CHECK, test_value.into());=0D
> +=0D
> +        let inverse_value =3D bar.read(regs::LIVENESS_CHECK).into_raw();=
=0D
> +=0D
> +        if inverse_value !=3D !test_value {=0D
> +            dev_err!(=0D
> +                pdev,=0D
> +                "inverse mismatch: expected {:#x} got {:#x}\n",=0D
> +                !test_value,=0D
> +                inverse_value=0D
> +            );=0D
> +            return Err(ENODEV);=0D
> +        }=0D
> +=0D
> +        dev_info!(pdev, "inverse test successful\n");=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {=0D
> +        Self::wait_until_compute_has_finished(pdev, bar)?;=0D
> +=0D
> +        bar.write(regs::FACTORIAL, 4.into());=0D
> +=0D
> +        Self::wait_until_compute_has_finished(pdev, bar)?;=0D
> +=0D
> +        let result: u32 =3D bar.read(regs::FACTORIAL).into();=0D
> +=0D
> +        let expected =3D 24;=0D
> +=0D
> +        if result !=3D expected {=0D
> +            dev_err!(=0D
> +                pdev,=0D
> +                "factorial result wrong: expected {} got {}\n",=0D
> +                expected,=0D
> +                result=0D
> +            );=0D
> +            return Err(ENODEV);=0D
> +        }=0D
> +=0D
> +        dev_info!(pdev, "factorial test successful\n");=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    fn test_irq(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverD=
ata) -> Result {=0D
> +        dev_dbg!(pdev, "raising irq\n");=0D
> +=0D
> +        bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());=0D
> +=0D
> +        data.irq_test_completion.wait_for_completion();=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverD=
ata) -> Result {=0D
> +        dev_dbg!(pdev, "testing dma\n");=0D
> +=0D
> +        let dma =3D &data.dma;=0D
> +=0D
> +        const DMA_VALUE: u64 =3D 42;=0D
> +=0D
> +        kernel::dma_write!(dma, , DMA_VALUE);=0D
> +=0D
> +        bar.write(regs::DMA_SRC, dma.dma_handle().into());=0D
> +        bar.write(regs::DMA_DST, QEMU_DMA_BASE.into());=0D
> +        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());=0D
> +        bar.write(=0D
> +            regs::DMA_COMMAND,=0D
> +            regs::DMA_COMMAND::zeroed()=0D
> +                .with_start_transfer(true)=0D
> +                .with_direction(false)=0D
> +                .with_raise_irq(true),=0D
> +        );=0D
> +=0D
> +        data.irq_dma_completion.wait_for_completion();=0D
> +=0D
> +        // Destroy previous value to test roundtrip=0D
> +        kernel::dma_write!(dma, , 0);=0D
> +=0D
> +        bar.write(regs::DMA_SRC, QEMU_DMA_BASE.into());=0D
> +        bar.write(regs::DMA_DST, dma.dma_handle().into());=0D
> +        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());=0D
> +        bar.write(=0D
> +            regs::DMA_COMMAND,=0D
> +            regs::DMA_COMMAND::zeroed()=0D
> +                .with_start_transfer(true)=0D
> +                .with_direction(true)=0D
> +                .with_raise_irq(true),=0D
> +        );=0D
> +=0D
> +        data.irq_dma_completion.wait_for_completion();=0D
> +=0D
> +        let result =3D kernel::dma_read!(dma,);=0D
> +=0D
> +        if result !=3D DMA_VALUE {=0D
> +            dev_err!(=0D
> +                pdev,=0D
> +                "dma result wrong: expected {} got {}\n",=0D
> +                DMA_VALUE,=0D
> +                result=0D
> +            );=0D
> +            return Err(ENODEV);=0D
> +        }=0D
> +=0D
> +        dev_info!(pdev, "dma test successful\n");=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    fn wait_until_compute_has_finished(pdev: &pci::Device<Bound>, bar: &=
Bar0) -> Result {=0D
> +        read_poll_timeout(=0D
> +            || Ok(bar.read(regs::STATUS)),=0D
> +            |status| status.computing() =3D=3D 0,=0D
> +            Delta::from_millis(10),=0D
> +            Delta::from_millis(100),=0D
> +        )=0D
> +        .inspect_err(|_| dev_err!(pdev, "computation bit did not clear b=
efore timeout\n"))=0D
> +        .map(|_| ())=0D
> +    }=0D
> +}=0D
> +=0D
> +impl pci::Driver for EduDriver {=0D
> +    type IdInfo =3D ();=0D
> +    type Data<'bound> =3D Self;=0D
> +=0D
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;=0D
> +=0D
> +    fn probe<'bound>(=0D
> +        pdev: &'bound pci::Device<kernel::device::Core<'_>>,=0D
> +        _id_info: &'bound Self::IdInfo,=0D
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {=0D
> +        pin_init::pin_init_scope(move || {=0D
> +            let vendor =3D pdev.vendor_id();=0D
> +            dev_dbg!(=0D
> +                pdev,=0D
> +                "Probe Rust EDU driver sample (PCI ID: {}, 0x{:x}).\n",=
=0D
> +                vendor,=0D
> +                pdev.device_id()=0D
> +            );=0D
> +=0D
> +            pdev.enable_device()?;=0D
> +            pdev.set_master();=0D
> +=0D
> +            let mask =3D DmaMask::new::<28>();=0D
> +=0D
> +            // SAFETY: There are no concurrent calls to DMA allocation a=
nd mapping primitives.=0D
> +            unsafe { pdev.dma_set_mask_and_coherent(mask)? };=0D
> +=0D
> +            let ca: Coherent<u64> =3D Coherent::zeroed(pdev.as_ref(), GF=
P_KERNEL)?;=0D
> +=0D
> +            let irq =3D pdev=0D
> +                .alloc_irq_vectors(1, 1, IrqTypes::default().with(pci::I=
rqType::Msi))=0D
> +                .inspect_err(|e| dev_err!(pdev, "alloc_irq_vectors faile=
d: {:?}\n", e))?;=0D
> +=0D
> +            // State shared with the IRQ handler (the BAR and the comple=
tion the=0D
> +            // handler signals) lives in an `Arc<EduDriverData>`. `EduDr=
iverData`=0D
> +            // itself implements `irq::Handler`, and the registration ta=
kes an=0D
> +            // `Arc<T>` via the `impl Handler for Arc<T>` blanket impl. =
This keeps=0D
> +            // the handler's state out of `EduDriver` and avoids a self-=
reference.=0D
> +            let data =3D Arc::pin_init(=0D
> +                try_pin_init!(EduDriverData {=0D
> +                    bar <- pdev=0D
> +                        .iomap_region_sized(0, c"rust_driver_edu")=0D
> +                        .and_then(|bar| bar.into_devres()),=0D
> +                    irq_test_completion <- Completion::new(),=0D
> +                    irq_dma_completion <- Completion::new(),=0D
> +                    dma: ca,=0D
> +                }),=0D
> +                GFP_KERNEL,=0D
> +            )?;=0D
> +=0D
> +            let req =3D irq::Registration::new(=0D
> +                (*irq.start()).try_into()?,=0D
> +                Flags::TRIGGER_NONE,=0D
> +                c"rust_edu_irq",=0D
> +                Ok(data.clone()),=0D
> +            );=0D
> +=0D
> +            // Ordering matters: the handler is registered (`irq_handler=
 <- req`)=0D
> +            // *before* the `_:` block runs the self-tests, one of which=
 raises an=0D
> +            // interrupt and waits for the handler. Raising before the h=
andler is=0D
> +            // registered would hang (the completion is never signalled)=
.=0D
> +            Ok(try_pin_init!(Self {=0D
> +                irq_handler <- req,=0D
> +                // Side-effect block: run the staged self-tests against =
the mapped=0D
> +                // BAR now that the handler is live. A failure here abor=
ts probe.=0D
> +                _: {=0D
> +                    let bar =3D data.bar.access(pdev.as_ref())?;=0D
> +                    EduDriver::init(pdev, bar, &data)?;=0D
> +                    dev_info!(=0D
> +                        pdev,=0D
> +                        "rust_driver_edu successfully initialized\n",=0D
> +                    );=0D
> +                },=0D
> +                data,=0D
> +                pdev: pdev.into()=0D
> +            }))=0D
> +        })=0D
> +    }=0D
> +}=0D
> +=0D
> +impl irq::Handler for EduDriverData {=0D
> +    fn handle(&self, pdev: &kernel::device::Device<Bound>) -> irq::IrqRe=
turn {=0D
> +        dev_dbg!(pdev, "irq handler called\n");=0D
> +        // `access()` only fails on device mismatch, so this branch is=0D
> +        // structurally unreachable here, but it must be handled.=0D
> +        let Ok(bar) =3D self.bar.access(pdev.as_ref()) else {=0D
> +            dev_err!(pdev, "cannot access bar register inside irq handle=
r\n");=0D
> +            return irq::IrqReturn::None;=0D
> +        };=0D
> +        let status: u32 =3D bar.read(regs::IRQ_STATUS).into();=0D
> +=0D
> +        // DMA_IRQ=0D
> +        if status & DMA_IRQ !=3D 0 {=0D
> +            dev_dbg!(pdev, "handling dma completion in irq\n");=0D
> +            bar.write(regs::IRQ_ACK, DMA_IRQ.into());=0D
> +            self.irq_dma_completion.complete();=0D
> +        }=0D
> +=0D
> +        // TEST_IRQ=0D
> +        let magic =3D status & !DMA_IRQ;=0D
> +        if magic =3D=3D IRQ_MAGIC_VALUE {=0D
> +            dev_dbg!(pdev, "handling test completion in irq\n");=0D
> +            bar.write(regs::IRQ_ACK, magic.into());=0D
> +            self.irq_test_completion.complete();=0D
> +        }=0D
> +=0D
> +        irq::IrqReturn::Handled=0D
> +    }=0D
> +}=0D
> +=0D
> +#[pinned_drop]=0D
> +impl PinnedDrop for EduDriver {=0D
> +    fn drop(self: Pin<&mut Self>) {=0D
> +        dev_dbg!(self.pdev, "Remove Rust EDU driver sample.\n");=0D
> +    }=0D
> +}=0D
> +=0D
> +kernel::pci_device_table!(=0D
> +    PCI_TABLE,=0D
> +    MODULE_PCI_TABLE,=0D
> +    <EduDriver as pci::Driver>::IdInfo,=0D
> +    [(=0D
> +        pci::DeviceId::from_id(pci::Vendor::from_raw(QEMU_VENDOR_ID), QE=
MU_EDU_DEVICE_ID),=0D
> +        ()=0D
> +    )]=0D
> +);=0D
> +=0D
> +kernel::module_pci_driver! {=0D
> +    type: EduDriver,=0D
> +    name: "rust_driver_edu",=0D
> +    authors: ["Maurice Hieronymus"],=0D
> +    description: "Rust EDU driver",=0D
> +    license: "GPL v2",=0D
> +}=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
