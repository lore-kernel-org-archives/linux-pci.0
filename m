Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786C29BD88;
	Thu, 22 Jan 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085630; cv=none; b=Po8FAXkKOOabT218LW1dZOvtJs5mS/G1CDAUr2VvaW68qMwvm8kWZilnMt9U2M+pMvO2h824k49niLrIPn2lOazjLFeNY4HWGdpx+JWam11sJ5Nd22BU0+YV1o1hsq6RjY93KlSBT2YKjTPet3UY2NFwW9mJCDimigwsxtDDldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085630; c=relaxed/simple;
	bh=Znsmg9/kbaBgdKgM4uXoMUEbX+Ligb/qQxqQFSk9yhc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=bi+DFvuoRL4G5N0iUlbWMtWiNrcG5HegD2w2a9olPTNXEbalrQ1yfPu0KDzmhrnPpvzGrHeB7uXt4sIQEkyXZ7ZLpaeuBqT7Gt6cFym1Geohjdh6knztfm4MmyvBNVnuLhlggVVq5mwx1/jGor8rfdimf2CEt3H4SVbjWMew9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNUVxzev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNUVxzev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F46C116C6;
	Thu, 22 Jan 2026 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769085629;
	bh=Znsmg9/kbaBgdKgM4uXoMUEbX+Ligb/qQxqQFSk9yhc=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=SNUVxzev3LOvMdIci9I/oa6AqQk7exVdrTs3g7VvMJjxTB8uy1gRhgj5knVzY+q5g
	 jUL4bQkuL5tvNglTVMcEj33uUugx4KQqxYooUSDUnzxUxxYBrjvlJDw7lvKll8pswm
	 3EZkirDAZ3D9BwPIMvNVe+uxr1EIW60Eiq5UxS7VK/gkALgWUZf41f+f4r3tYUlHiS
	 jcz6hwj+KOOIcfVkFrN+KVdlbuyWwCFlKRVC2JuRKtbBJWlr188dLREeKbGPuVHQB3
	 Z6S15pO4K6WBeE66imr5WSeeIJOlEBRJ1LcjuUH2qVmcc114ngAyBOPZJQv+6lan/H
	 Yw+TG6PJYRn+g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 13:40:22 +0100
Message-Id: <DFV4IJDQC2J6.1Q91JOAL6CJSG@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v12 4/5] rust: pci: add config space read/write support
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-5-zhiw@nvidia.com>
 <DFV3N1SHS8SK.338Z25H89HINU@garyguo.net>
In-Reply-To: <DFV3N1SHS8SK.338Z25H89HINU@garyguo.net>

On Thu Jan 22, 2026 at 12:59 PM CET, Gary Guo wrote:
> On Wed Jan 21, 2026 at 8:22 PM GMT, Zhi Wang wrote:
>> +    /// Returns the size of configuration space in bytes.
>> +    fn cfg_size(&self) -> Result<usize> {
>> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_de=
v`.
>> +        let size =3D unsafe { (*self.as_raw()).cfg_size };
>> +        match size {
>> +            256 | 4096 =3D> Ok(size as usize),
>> +            _ =3D> {
>> +                debug_assert!(false);
>> +                Err(EINVAL)
>> +            }
>> +        }
>> +    }
>
> This method is only invoked from maxsize, which turns error into `0`. Do =
apart
> from the debug assertion, the error code is pointless. I think this funct=
ion
> should just return `usize` as it's specified in the device (we should tru=
st the
> C side that the value is sensible).

That seems reasonable, but I also think we should keep the enum ConfigSpace=
Size
we had before and call the new trait ConfigSpaceKind instead, such that thi=
s
method becomes:

	fn cfg_size(&self) -> ConfigSpaceSize;

> The check, as Alex mentioned, need to be done when ConfigSpace is created=
 in
> the first place and is too late when you already hand out `Ok(ConfigSpace=
)`.

We need the check for config_space_extended(), but not for config_space(), =
as it
represents the minimum size, i.e. it's always valid.

Here's a diff of what I think this should look like on top of this series.

(@Zhi: If we all agree on the diff and nothing else comes up you don't need=
 to
resend. :)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 9020959ce0c7..1d1a253e5d5d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -42,6 +42,7 @@
 };
 pub use self::io::{
     Bar,
+    ConfigSpaceKind,
     ConfigSpaceSize,
     Extended,
     Normal, //
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 39df41d0eaab..5dbdfe516418 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -24,6 +24,31 @@
     ops::Deref, //
 };

+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of=
 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the P=
CI Express
+/// specification.
+#[repr(usize)]
+#[derive(PartialEq)]
+pub enum ConfigSpaceSize {
+    /// 256-byte legacy PCI configuration space.
+    Normal =3D 256,
+
+    /// 4096-byte PCIe extended configuration space.
+    Extended =3D 4096,
+}
+
+impl ConfigSpaceSize {
+    /// Get the raw value of this enum.
+    #[inline(always)]
+    pub const fn into_raw(self) -> usize {
+        // CAST: PCI configuration space size is at most 4096 bytes, so th=
e value always fits
+        // within `usize` without truncation or sign change.
+        self as usize
+    }
+}
+
 /// Marker type for normal (256-byte) PCI configuration space.
 pub struct Normal;

@@ -34,16 +59,16 @@
 ///
 /// This trait is implemented by [`Normal`] and [`Extended`] to provide
 /// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceSize {
+pub trait ConfigSpaceKind {
     /// The size of this configuration space in bytes.
     const SIZE: usize;
 }

-impl ConfigSpaceSize for Normal {
+impl ConfigSpaceKind for Normal {
     const SIZE: usize =3D 256;
 }

-impl ConfigSpaceSize for Extended {
+impl ConfigSpaceKind for Extended {
     const SIZE: usize =3D 4096;
 }

@@ -55,7 +80,7 @@ impl ConfigSpaceSize for Extended {
 /// The generic parameter `S` indicates the maximum size of the configurat=
ion space.
 /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`]=
 for
 /// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ConfigSpaceSize =3D Extended> {
+pub struct ConfigSpace<'a, S: ConfigSpaceKind =3D Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
     _marker: PhantomData<S>,
 }
@@ -118,11 +143,11 @@ macro_rules! call_config_write {
 }

 // PCI configuration space supports 8, 16, and 32-bit accesses.
-impl<'a, S: ConfigSpaceSize> IoCapable<u8> for ConfigSpace<'a, S> {}
-impl<'a, S: ConfigSpaceSize> IoCapable<u16> for ConfigSpace<'a, S> {}
-impl<'a, S: ConfigSpaceSize> IoCapable<u32> for ConfigSpace<'a, S> {}
+impl<'a, S: ConfigSpaceKind> IoCapable<u8> for ConfigSpace<'a, S> {}
+impl<'a, S: ConfigSpaceKind> IoCapable<u16> for ConfigSpace<'a, S> {}
+impl<'a, S: ConfigSpaceKind> IoCapable<u32> for ConfigSpace<'a, S> {}

-impl<'a, S: ConfigSpaceSize> Io for ConfigSpace<'a, S> {
+impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
     const MIN_SIZE: usize =3D S::SIZE;

     /// Returns the base address of the I/O region. It is always 0 for con=
figuration space.
@@ -134,7 +159,7 @@ fn addr(&self) -> usize {
     /// Returns the maximum size of the configuration space.
     #[inline]
     fn maxsize(&self) -> usize {
-        self.pdev.cfg_size().map_or(0, |v| v)
+        self.pdev.cfg_size().into_raw()
     }

     // PCI configuration space does not support fallible operations.
@@ -150,7 +175,7 @@ fn maxsize(&self) -> usize {
 }

 /// Marker trait indicating ConfigSpace has a known size at compile time.
-impl<'a, S: ConfigSpaceSize> IoKnownSize for ConfigSpace<'a, S> {}
+impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {}

 /// A PCI BAR to perform I/O-Operations on.
 ///
@@ -281,29 +306,35 @@ pub fn iomap_region<'a>(
         self.iomap_region_sized::<0>(bar, name)
     }

-    /// Returns the size of configuration space in bytes.
-    fn cfg_size(&self) -> Result<usize> {
+    /// Returns the size of configuration space.
+    fn cfg_size(&self) -> ConfigSpaceSize {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         let size =3D unsafe { (*self.as_raw()).cfg_size };
         match size {
-            256 | 4096 =3D> Ok(size as usize),
+            256 =3D> ConfigSpaceSize::Normal,
+            4096 =3D> ConfigSpaceSize::Extended,
             _ =3D> {
-                debug_assert!(false);
-                Err(EINVAL)
+                // PANIC: The PCI subsystem only ever reports the configur=
ation space size as either
+                // `ConfigSpaceSize::Normal` or `ConfigSpaceSize::Extended=
`.
+                unreachable!();
             }
         }
     }

     /// Return an initialized normal (256-byte) config space object.
-    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a, Normal>> {
-        Ok(ConfigSpace {
+    pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
+        ConfigSpace {
             pdev: self,
             _marker: PhantomData,
-        })
+        }
     }

     /// Return an initialized extended (4096-byte) config space object.
     pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, E=
xtended>> {
+        if self.cfg_size() !=3D ConfigSpaceSize::Extended {
+            return Err(EINVAL);
+        }
+
         Ok(ConfigSpace {
             pdev: self,
             _marker: PhantomData,
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci=
.rs
index 1bc5bd1a8df5..8eea79e858a2 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -67,8 +67,8 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> =
{
         Ok(bar.read32(Regs::COUNT))
     }

-    fn config_space(pdev: &pci::Device<Bound>) -> Result {
-        let config =3D pdev.config_space()?;
+    fn config_space(pdev: &pci::Device<Bound>) {
+        let config =3D pdev.config_space();

         // TODO: use the register!() macro for defining PCI configuration =
space registers once it
         // has been move out of nova-core.
@@ -89,8 +89,6 @@ fn config_space(pdev: &pci::Device<Bound>) -> Result {
             "pci-testdev config space read32 BAR 0: {:x}\n",
             config.read32(0x10)
         );
-
-        Ok(())
     }
 }

@@ -123,7 +121,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo)=
 -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
-                    Self::config_space(pdev)?;
+                    Self::config_space(pdev);
                 },
                 pdev: pdev.into(),
             }))

