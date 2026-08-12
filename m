Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2236D4F1
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 20:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565538; cv=none; b=R4AfzLlx8NEXOWlM1HfWLSVVCuiWQ+iTJwJ0gebY5uw0BXIoipFnPokFuBuQszQntE6ROCataqJdrTP7vmwvK629472rGX+i5NuyLSFIK13JK6aqhFpSogIDPaLN6DT38wMVq8uRK7fPLjD8/+BR+bbHomnlYht/XE0kof2pulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565538; c=relaxed/simple;
	bh=KS8/aTc2IeMwgy/9KDdm7Y1gzS3lFhK15CDYE/dG+FY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WFYairDBB5LjrG4pBVzL36QD3IG95vxbunpesx6a6xFt9hQusf2W+Jqd/ZNGuaj3IDVh5DGbXfLZN8ULYYk9ThxX7+auUcTyxMu4yjvdBQnWOfzVVPmQC7J7YQxrB06nKwv5u8+qhXdWTx9Mc8/ZSWgM+FZ+gh0rEaACzbhYXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj1wZC5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj1wZC5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C471F000E9;
	Wed, 12 Aug 2026 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786565537;
	bh=lo6r+6zRHQdevup9WfhO+15kkGYy+NurlJUzu0RDWL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lj1wZC5YwE6DzRied3GoFN3/MWoU1MGYm/qYZNyc0auGBCpdIAeISAHICmdMGZNTL
	 cHYjabHjf9kZpW7DlwjYBO2vyggNMIRLVWIJohSzSDZdsXvEnUDxDCpbwL2Nn94rDT
	 TVcH/s92HMcoxnME/I91WOUbn2DMprG/TKZgEXq+3WCEC0TyHbMdIV/i4gx8MrQGER
	 FK/CxzfCB7h4NrkUJ02Ju5t9R+aRSQNMiubJ9Hg92qrYWDFhLVrtHgeE7UFWYVVXrE
	 hHTkEv62lufDvn54lf1dZv1s0b1lu2+1uprfj5gDlklhUi/yQXSiF67qBb6CaJmHCF
	 poVshTgKb8fSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] rust: samples: add EDU PCI driver sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-5-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-5-5d0b5594e52b@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:12:16 +0000
Message-Id: <20260812201216.B4C471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unbounded wait_for_completion() during probe can hang the system.
- [High] 64-bit MMIO accesses will cause compilation failures on 32-bit arc=
hitectures.
- [Medium] Unconditional Handled return in IRQ handler defeats spurious int=
errupt detection.
--

--- Patch [5]: [PATCH v3 5/5] rust: samples: add EDU PCI driver sample ---
commit c231e5461a247a3fe7e624e02b7930ee66f864b3
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: samples: add EDU PCI driver sample

Add a Rust sample driver for the QEMU EDU device, wired up via a new
SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.

> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 0cae695acd842..115f71ed63283 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -107,6 +107,17 @@ config SAMPLE_RUST_I2C_CLIENT
> =20
>  	  If unsure, say N.
> =20
> +config SAMPLE_RUST_DRIVER_EDU
> +	tristate "EDU Driver"
> +	depends on PCI

[Severity: High]
Does this missing 64BIT dependency cause build failures on 32-bit
architectures?

The driver defines 64-bit MMIO registers (like DMA_SRC(u64)), but the
IoCapable<u64> trait is only conditionally implemented for Mmio on 64-bit
architectures. Building on a 32-bit target will fail compilation because the
64-bit write method on pci::Bar will be unavailable.

> +	help
> +	  This option builds the Rust EDU driver sample.

[ ... ]

> diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_e=
du.rs
> new file mode 100644
> index 0000000000000..52f6c4cf3b08d
> --- /dev/null
> +++ b/samples/rust/rust_driver_edu.rs
> @@ -0,0 +1,421 @@

[ ... ]

> +    fn test_irq(pdev: &pci::Device<Bound>, handler: &IrqHandler<'_>) -> =
Result {
> +        dev_dbg!(pdev, "raising irq\n");
> +
> +        handler.bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());
> +
> +        handler.irq_test_completion.wait_for_completion();

[Severity: High]
Can this unbounded wait hang the system?

Since test_irq() is called synchronously from the driver probe path, a drop=
ped
hardware interrupt or faulty device might block the thread indefinitely.
This could prevent the kernel from booting or loading other drivers.

Would a timed wait like wait_for_completion_timeout() avoid this risk?

> +
> +        dev_info!(pdev, "irq test successful\n");
> +        Ok(())
> +    }
> +
> +    fn test_dma(pdev: &pci::Device<Bound>, handler: &IrqHandler<'_>) -> =
Result {
> +        dev_dbg!(pdev, "testing dma\n");

[ ... ]

> +        handler.bar.write(
> +            regs::DMA_COMMAND,
> +            regs::DMA_COMMAND::zeroed()
> +                .with_start_transfer(true)
> +                .with_direction(false)
> +                .with_raise_irq(true),
> +        );
> +
> +        handler.irq_dma_completion.wait_for_completion();

[Severity: High]
Similarly, could this unbounded wait block the probe sequence indefinitely =
if
the DMA completion interrupt is never received?

> +
> +        // Destroy previous value to test roundtrip

[ ... ]

> +impl irq::Handler for IrqHandler<'_> {
> +    fn handle(&self) -> irq::IrqReturn {
> +        dev_dbg!(self.pdev, "irq handler called\n");
> +        let status: u32 =3D self.bar.read(regs::IRQ_STATUS).into();
> +
> +        // DMA_IRQ
> +        if status & DMA_IRQ !=3D 0 {
> +            dev_dbg!(self.pdev, "handling dma completion in irq\n");
> +            self.bar.write(regs::IRQ_ACK, DMA_IRQ.into());
> +            self.irq_dma_completion.complete();
> +        }
> +
> +        // TEST_IRQ
> +        let magic =3D status & !DMA_IRQ;
> +        if magic =3D=3D IRQ_MAGIC_VALUE {
> +            dev_dbg!(self.pdev, "handling test completion in irq\n");
> +            self.bar.write(regs::IRQ_ACK, magic.into());
> +            self.irq_test_completion.complete();
> +        }
> +
> +        irq::IrqReturn::Handled

[Severity: Medium]
Does this unconditional return of Handled defeat the kernel's spurious
interrupt detection?

If the status matches neither DMA_IRQ nor IRQ_MAGIC_VALUE, the handler
processes no bits but still returns irq::IrqReturn::Handled.

When a spurious interrupt occurs, the kernel will believe this device handl=
ed
it and won't increment the spurious interrupt counter. This could prevent t=
he
IRQ subsystem from disabling a faulty IRQ line, potentially causing an
interrupt storm.

Should this return irq::IrqReturn::None when no expected bits are set?

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-b4-rust-pc=
i-edu-driver-v3-0-5d0b5594e52b@mailbox.org?part=3D5
