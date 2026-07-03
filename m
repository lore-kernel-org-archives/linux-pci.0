Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D961FFC48;
	Fri,  3 Jul 2026 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113141; cv=none; b=jqOUN/db4hEqiBd3S/g84D9m/GJ1eHLE7zhKWeJfbMxYXyi7hyhXEFPzVa7AehPSOUDz0Q1tq289w6xcuAtDjUKONZAxl6hhY24HTe+nqXA8kZM3p7Mm3uKjGPgFDYhBLbxw6wZyqWKBGtXUP7KyfqnAD500ItrsZa34oJB3ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113141; c=relaxed/simple;
	bh=9VWf4infm8V20Dp3e6wzvaCsfLv7XGcfSMuJRybRsRQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=p7dnmzqDC1O+eNHoHLoduGBqWUIVmga0dapbqs2wpknD9fMpL6iRraL0OQmF0vDLhVlczSiiuTl8Ay6VWfjXcBKk1SXr20Oax1db3MJkHZDRIJCRheUxTnwItarrBQRdxP16H6rfEWyERUNSyWuA9wodvom1Yg2njKfJwdOdEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLq1DOMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLq1DOMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6401F000E9;
	Fri,  3 Jul 2026 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783113139;
	bh=fOFC/QF39f9FgArllPamaxq52CS03wol5+f7DSlkIeE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=nLq1DOMHVrZ2RzriWTwXtuoFxsrlKZoATUzHfHWyrg0S+jmiQC5C6Xtn5WezTYZfW
	 DifTEX/sxIGL7+Xyz7Yqa+qrJfLVjU4205yP5CiT1MEmWr9SWrF9daOKikhESUmPmt
	 9AdCgbK/++A6XRap8OMpDNQ6s6p55hnAkZwi4K1Jk9MTv41HZS6shlKXUkCXJzEFMK
	 dTGTbWn+eoyyJGQO046WyM4ICxSYJFO2GJ4tBczGkaA5qelA9+tluHugIUZD/zxdVs
	 SIWqYesNaSCVLcuKK8mKEc/0ETHg59YclPl/l/cVt+mv+TQDsFY4wcYYEWU1SEkGNu
	 8yNJHyRRv+ajQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 23:12:14 +0200
Message-Id: <DJP8UPM9XT95.102LJRRRY4P2S@kernel.org>
Subject: Re: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Maurice Hieronymus" <mhi@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
 <DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org>
In-Reply-To: <DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org>

On Sun Jun 21, 2026 at 2:27 PM CEST, Danilo Krummrich wrote:
> I'm going to send a patch to make the irq::Registration compatible with t=
he
> device driver lifetime rework soon. Please rebase onto that once it's sen=
t, so
> this sample can land as idiomatic as possible.

Please find the patch in [1]; purely mechanical conversion of the EDU drive=
r for
testing purposes in [2].

[1] https://lore.kernel.org/driver-core/20260703210936.1128698-1-dakr@kerne=
l.org/

[2]

diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_edu=
.rs
index 5f4efd514032..301b780773cb 100644
--- a/samples/rust/rust_driver_edu.rs
+++ b/samples/rust/rust_driver_edu.rs
@@ -6,7 +6,6 @@

 use kernel::{
     device::Bound,
-    devres::Devres,
     dma::{Coherent, Device, DmaMask},
     io::{
         poll::read_poll_timeout,
@@ -16,7 +15,7 @@
     irq::{self, Flags},
     pci::{self, IrqTypes},
     prelude::*,
-    sync::{aref::ARef, Arc, Completion},
+    sync::Completion,
     time::Delta, //
 };

@@ -66,20 +65,21 @@ mod regs {
     pub(super) const END: usize =3D 0xA0;
 }

-type Bar0 =3D pci::Bar<'static, { regs::END }>;
+type Bar0<'a> =3D pci::Bar<'a, { regs::END }>;
+
+struct EduDriver;

 #[pin_data(PinnedDrop)]
-struct EduDriver {
-    pdev: ARef<pci::Device>,
-    data: Arc<EduDriverData>,
+struct EduDriverData<'bound> {
+    pdev: &'bound pci::Device,
     #[pin]
-    irq_handler: irq::Registration<Arc<EduDriverData>>,
+    irq_handler: irq::Registration<'bound, IrqHandler<'bound>>,
 }

 #[pin_data]
-struct EduDriverData {
-    #[pin]
-    bar: Devres<Bar0>,
+struct IrqHandler<'a> {
+    pdev: &'a pci::Device,
+    bar: Bar0<'a>,
     #[pin]
     irq_test_completion: Completion,
     #[pin]
@@ -88,16 +88,16 @@ struct EduDriverData {
 }

 impl EduDriver {
-    fn init(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverData) -=
> Result {
+    fn init(pdev: &pci::Device<Bound>, bar: &Bar0<'_>, handler: &IrqHandle=
r<'_>) -> Result {
         Self::magic(pdev, bar)?;
         Self::liveness_check(pdev, bar)?;
         Self::factorial(pdev, bar)?;
-        Self::test_irq(pdev, bar, data)?;
-        Self::test_dma(pdev, bar, data)?;
+        Self::test_irq(pdev, handler)?;
+        Self::test_dma(pdev, handler)?;
         Ok(())
     }

-    fn magic(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
+    fn magic(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
         let identification =3D bar.read(regs::IDENTIFICATION);

         let magic: u8 =3D identification.magic().into();
@@ -121,7 +121,7 @@ fn magic(pdev: &pci::Device<Bound>, bar: &Bar0) -> Resu=
lt {
         Ok(())
     }

-    fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
+    fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result=
 {
         let test_value =3D 0xabcd;

         bar.write(regs::LIVENESS_CHECK, test_value.into());
@@ -142,7 +142,7 @@ fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0=
) -> Result {
         Ok(())
     }

-    fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
+    fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
         Self::wait_until_compute_has_finished(pdev, bar)?;

         bar.write(regs::FACTORIAL, 4.into());
@@ -167,28 +167,30 @@ fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0) -=
> Result {
         Ok(())
     }

-    fn test_irq(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverDat=
a) -> Result {
+    fn test_irq(pdev: &pci::Device<Bound>, handler: &IrqHandler<'_>) -> Re=
sult {
         dev_dbg!(pdev, "raising irq\n");

-        bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());
+        handler.bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());

-        data.irq_test_completion.wait_for_completion();
+        handler.irq_test_completion.wait_for_completion();
         Ok(())
     }

-    fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverDat=
a) -> Result {
+    fn test_dma(pdev: &pci::Device<Bound>, handler: &IrqHandler<'_>) -> Re=
sult {
         dev_dbg!(pdev, "testing dma\n");

-        let dma =3D &data.dma;
+        let dma =3D &handler.dma;

         const DMA_VALUE: u64 =3D 42;

         kernel::dma_write!(dma, , DMA_VALUE);

-        bar.write(regs::DMA_SRC, dma.dma_handle().into());
-        bar.write(regs::DMA_DST, QEMU_DMA_BASE.into());
-        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());
-        bar.write(
+        handler.bar.write(regs::DMA_SRC, dma.dma_handle().into());
+        handler.bar.write(regs::DMA_DST, QEMU_DMA_BASE.into());
+        handler
+            .bar
+            .write(regs::DMA_COUNT, (dma.size() as u64).into());
+        handler.bar.write(
             regs::DMA_COMMAND,
             regs::DMA_COMMAND::zeroed()
                 .with_start_transfer(true)
@@ -196,15 +198,17 @@ fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, da=
ta: &EduDriverData) -> Resu
                 .with_raise_irq(true),
         );

-        data.irq_dma_completion.wait_for_completion();
+        handler.irq_dma_completion.wait_for_completion();

         // Destroy previous value to test roundtrip
         kernel::dma_write!(dma, , 0);

-        bar.write(regs::DMA_SRC, QEMU_DMA_BASE.into());
-        bar.write(regs::DMA_DST, dma.dma_handle().into());
-        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());
-        bar.write(
+        handler.bar.write(regs::DMA_SRC, QEMU_DMA_BASE.into());
+        handler.bar.write(regs::DMA_DST, dma.dma_handle().into());
+        handler
+            .bar
+            .write(regs::DMA_COUNT, (dma.size() as u64).into());
+        handler.bar.write(
             regs::DMA_COMMAND,
             regs::DMA_COMMAND::zeroed()
                 .with_start_transfer(true)
@@ -212,7 +216,7 @@ fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data=
: &EduDriverData) -> Resu
                 .with_raise_irq(true),
         );

-        data.irq_dma_completion.wait_for_completion();
+        handler.irq_dma_completion.wait_for_completion();

         let result =3D kernel::dma_read!(dma,);

@@ -230,7 +234,7 @@ fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data=
: &EduDriverData) -> Resu
         Ok(())
     }

-    fn wait_until_compute_has_finished(pdev: &pci::Device<Bound>, bar: &Ba=
r0) -> Result {
+    fn wait_until_compute_has_finished(pdev: &pci::Device<Bound>, bar: &Ba=
r0<'_>) -> Result {
         read_poll_timeout(
             || Ok(bar.read(regs::STATUS)),
             |status| status.computing() =3D=3D 0,
@@ -244,7 +248,7 @@ fn wait_until_compute_has_finished(pdev: &pci::Device<B=
ound>, bar: &Bar0) -> Res

 impl pci::Driver for EduDriver {
     type IdInfo =3D ();
-    type Data<'bound> =3D Self;
+    type Data<'bound> =3D EduDriverData<'bound>;

     const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;

@@ -275,76 +279,61 @@ fn probe<'bound>(
                 .alloc_irq_vectors(1, 1, IrqTypes::default().with(pci::Irq=
Type::Msi))
                 .inspect_err(|e| dev_err!(pdev, "alloc_irq_vectors failed:=
 {:?}\n", e))?;

-            // State shared with the IRQ handler (the BAR and the completi=
on the
-            // handler signals) lives in an `Arc<EduDriverData>`. `EduDriv=
erData`
-            // itself implements `irq::Handler`, and the registration take=
s an
-            // `Arc<T>` via the `impl Handler for Arc<T>` blanket impl. Th=
is keeps
-            // the handler's state out of `EduDriver` and avoids a self-re=
ference.
-            let data =3D Arc::pin_init(
-                try_pin_init!(EduDriverData {
-                    bar <- pdev
-                        .iomap_region_sized(0, c"rust_driver_edu")
-                        .and_then(|bar| bar.into_devres()),
-                    irq_test_completion <- Completion::new(),
-                    irq_dma_completion <- Completion::new(),
-                    dma: ca,
-                }),
-                GFP_KERNEL,
-            )?;
-
-            let req =3D irq::Registration::new(
-                (*irq.start()).try_into()?,
-                Flags::TRIGGER_NONE,
-                c"rust_edu_irq",
-                Ok(data.clone()),
-            );
+            let bar =3D pdev.iomap_region_sized::<{ regs::END }>(0, c"rust=
_driver_edu")?;

-            // Ordering matters: the handler is registered (`irq_handler <=
- req`)
-            // *before* the `_:` block runs the self-tests, one of which r=
aises an
-            // interrupt and waits for the handler. Raising before the han=
dler is
-            // registered would hang (the completion is never signalled).
-            Ok(try_pin_init!(Self {
+            // SAFETY: The Registration is not leaked.
+            let req =3D unsafe {
+                irq::Registration::new(
+                    (*irq.start()).try_into()?,
+                    Flags::TRIGGER_NONE,
+                    c"rust_edu_irq",
+                    try_pin_init!(IrqHandler {
+                        pdev,
+                        bar,
+                        irq_test_completion <- Completion::new(),
+                        irq_dma_completion <- Completion::new(),
+                        dma: ca,
+                    }? Error),
+                )
+            };
+
+            Ok(try_pin_init!(EduDriverData {
                 irq_handler <- req,
-                // Side-effect block: run the staged self-tests against th=
e mapped
-                // BAR now that the handler is live. A failure here aborts=
 probe.
+                // Ordering matters: the handler is registered (`irq_handl=
er <- req`)
+                // *before* the `_:` block runs the self-tests, one of whi=
ch raises an
+                // interrupt and waits for the handler. Raising before the=
 handler is
+                // registered would hang (the completion is never signalle=
d).
                 _: {
-                    let bar =3D data.bar.access(pdev.as_ref())?;
-                    EduDriver::init(pdev, bar, &data)?;
+                    let handler =3D irq_handler.handler();
+                    EduDriver::init(pdev, &handler.bar, handler)?;
                     dev_info!(
                         pdev,
                         "rust_driver_edu successfully initialized\n",
                     );
                 },
-                data,
-                pdev: pdev.into()
+                pdev,
             }))
         })
     }
 }

-impl irq::Handler for EduDriverData {
-    fn handle(&self, pdev: &kernel::device::Device<Bound>) -> irq::IrqRetu=
rn {
-        dev_dbg!(pdev, "irq handler called\n");
-        // `access()` only fails on device mismatch, so this branch is
-        // structurally unreachable here, but it must be handled.
-        let Ok(bar) =3D self.bar.access(pdev.as_ref()) else {
-            dev_err!(pdev, "cannot access bar register inside irq handler\=
n");
-            return irq::IrqReturn::None;
-        };
-        let status: u32 =3D bar.read(regs::IRQ_STATUS).into();
+impl irq::Handler for IrqHandler<'_> {
+    fn handle(&self) -> irq::IrqReturn {
+        dev_dbg!(self.pdev, "irq handler called\n");
+        let status: u32 =3D self.bar.read(regs::IRQ_STATUS).into();

         // DMA_IRQ
         if status & DMA_IRQ !=3D 0 {
-            dev_dbg!(pdev, "handling dma completion in irq\n");
-            bar.write(regs::IRQ_ACK, DMA_IRQ.into());
+            dev_dbg!(self.pdev, "handling dma completion in irq\n");
+            self.bar.write(regs::IRQ_ACK, DMA_IRQ.into());
             self.irq_dma_completion.complete();
         }

         // TEST_IRQ
         let magic =3D status & !DMA_IRQ;
         if magic =3D=3D IRQ_MAGIC_VALUE {
-            dev_dbg!(pdev, "handling test completion in irq\n");
-            bar.write(regs::IRQ_ACK, magic.into());
+            dev_dbg!(self.pdev, "handling test completion in irq\n");
+            self.bar.write(regs::IRQ_ACK, magic.into());
             self.irq_test_completion.complete();
         }

@@ -353,7 +342,7 @@ fn handle(&self, pdev: &kernel::device::Device<Bound>) =
-> irq::IrqReturn {
 }

 #[pinned_drop]
-impl PinnedDrop for EduDriver {
+impl PinnedDrop for EduDriverData<'_> {
     fn drop(self: Pin<&mut Self>) {
         dev_dbg!(self.pdev, "Remove Rust EDU driver sample.\n");
     }
