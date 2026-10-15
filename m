Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1457497B96;
	Thu, 15 Oct 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068026; cv=pass; b=m3W2kDf6EhqTMP5EN5osjGHryM0KgA0SjhF24kJ3Wgh49zwN+WqaAIPn6a7jKnM+9O/dq5PNrcrsbT+/nYTJ0bQOlrponxtoLB1QWgbYqsL/w78rBtxsRp/22nCBklzl2Qe8v1ZKQF5d+pp/2oKXGE3tyV3NkxD0Y5D+5u/RSac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068026; c=relaxed/simple;
	bh=yKp8E6nC9w04l/mekaViVdwdgvxUGi+7n4/D2986peA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmDvAXxHYHjQ2a9jh/nBz72mniRDDX8e8ldOyARUub7zQkPpo6YKeltpK8MxcKHxK65ne40/mFgcVUBoD42lEHI8QP8luC3pec66T8IpDAVFQga1il/ZyMYdSksGv7T+KAzk2tYHNpl/eXc+VPgAxJwKHBKwyGnrRNsfaqTIZsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JAhD4p9Y; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JAhD4p9Y"
ARC-Seal: i=1; a=rsa-sha256; t=1792067992; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i58BRpbrnpqvtcNbC1i7LqNi/QoFYdJ0WQh6PF01d214je4F+9C/2/BUN8QKWvsm9W/MkeH5gWbldx0hGZaXTtPvaQyVPJfR+gyF2RUO/JtSwKyY7gTZ6TmtZwsxQQw9XiqfX/smot5XHnEKMq6E71opb8TT5aNoYnkqeBgvFbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792067992; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TEFbSXr8ncrZ1dmHLc4vUbYu+X3AJk5I+ihgStVMv4U=; 
	b=fO4YmgEdlNoPzpN7a9wKaleaJhHA6Aih1fE9Ry6vrHIBa7lyX0np4pOVhZwoRUZobpqwWlrrVZqg2maqVNsJwrVYM67SATUuLDv3LKJFDdrBuw6m3lRTez1q2v7my77MOSIPP+Kf/ppauIeKqHIjXFp5ZrWzbq5CzsyvmXa5tVc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067992;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=TEFbSXr8ncrZ1dmHLc4vUbYu+X3AJk5I+ihgStVMv4U=;
	b=JAhD4p9Y01Gs7U+Orx0P6+SoiyDZdeRVi+cmpECX7uHqBzx8A+Elf6unUIU855vr
	3nO0nMMCIs+ynjNHNMw+xKhZy0Bbp9iUe9R9w30DgLfeJsnFlIdj5IM826RLwGirA4Q
	n5ayFOXbl9/06RHsVMETx/FTY0+pM40TPobcB/uU=
Received: by smtp.zohomail.com with SMTPS id 1792067990607904.8150282045541;
	Thu, 15 Oct 2026 05:39:50 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 15 Oct 2026 09:39:10 -0300
Subject: [PATCH 6/7] rust: io: register: add `#[ro]` and `#[wo]` attributes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-io-access-modes-v1-6-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
In-Reply-To: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

`register!` gives every register a location with the `ReadWrite` access
mode, so any register can be read, written and updated, including the
ones the hardware defines as read-only or write-only.

Add the `#[ro]` and `#[wo]` attributes, which make the macro use the
`ReadOnly` or `WriteOnly` mode instead: in the register's `OffsetLoc`
for fixed registers, and as `RegisterArray::Access` for arrays. Reading
a write-only register, or writing or updating a read-only one, then does
not compile. An alias does not inherit the mode of the register it
aliases. Add an example to the `register!` documentation.

The tyr driver uses the attributes in a following patch.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/io/register.rs | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/io/register.rs | 35 ++++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 9218dc66017b..5c0188947879 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -147,6 +147,13 @@ impl<Base: ?Sized, T> OffsetLoc<Base, T> {
     pub const fn new(offset: usize) -> Self {
         Self(offset, PhantomData)
     }
+}
+
+impl<Base: ?Sized, T, A> OffsetLoc<Base, T, A> {
+    #[inline]
+    pub const fn with_access(offset: usize) -> Self {
+        Self(offset, PhantomData)
+    }
 
     #[inline]
     pub const fn const_offset(self) -> usize {
@@ -596,6 +603,52 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
 /// io_project!(io, build: CPU0).write_reg(CPU_CTL::zeroed());
 /// # }
 /// ```
+///
+/// ## Access modes
+///
+/// Registers are read-write unless declared with the `#[ro]` (read-only) or `#[wo]` (write-only)
+/// attribute. Reading a write-only register, or writing or updating a read-only one, does not
+/// compile:
+///
+/// ```no_run
+/// use kernel::io::{
+///     register,
+///     Io,
+///     Region,
+/// };
+/// # use kernel::io::Mmio;
+///
+/// register! {
+///     base: Region<0x1000>;
+///
+///     #[ro]
+///     pub R1(u32) @ 0x0 {
+///         31:0 value;
+///     }
+///
+///     #[wo]
+///     pub R2(u32) @ 0x4 {
+///         31:0 value;
+///     }
+///
+///     #[ro]
+///     pub R3: u8 @ 0x8;
+/// }
+///
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
+/// let r1 = io.read(R1);
+/// let r3 = io.read(R3);
+/// io.write_reg(R2::zeroed());
+///
+/// // Neither of these compiles.
+/// // io.write_reg(r1);
+/// // io.read(R2);
+/// # }
+/// ```
+///
+/// The mode applies to accesses through the register's location only. An alias is read-write
+/// unless declared `#[ro]` or `#[wo]` itself, and the register's offset can still be accessed
+/// directly through the I/O region.
 #[macro_export]
 macro_rules! register {
     ($($tt:tt)*) => {
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 2d92c7f41447..171a4c1f96b4 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -63,6 +63,7 @@ struct Reg {
     attrs: Vec<Attribute>,
     vis: Visibility,
     name: Ident,
+    access: Type,
     unique: bool,
     ty: Type,
     array: Option<RegArrayDef>,
@@ -72,7 +73,26 @@ struct Reg {
 
 impl Parse for Reg {
     fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
-        let attrs = input.call(Attribute::parse_outer)?;
+        let mut attrs = input.call(Attribute::parse_outer)?;
+        let modes = attrs
+            .extract_if(.., |attr| {
+                attr.path().is_ident("ro") || attr.path().is_ident("wo")
+            })
+            .collect::<Vec<_>>();
+        if let Some(attr) = modes.get(1) {
+            Err(Error::new_spanned(
+                attr,
+                "only one of `#[ro]` and `#[wo]` can be specified",
+            ))?
+        }
+        let access = match modes.first() {
+            None => parse_quote!(::kernel::io::access::ReadWrite),
+            Some(attr) if attr.path().is_ident("ro") => {
+                parse_quote!(::kernel::io::access::ReadOnly)
+            }
+            Some(_) => parse_quote!(::kernel::io::access::WriteOnly),
+        };
+
         let vis = input.parse()?;
         let name = input.parse()?;
 
@@ -161,6 +181,7 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
             attrs,
             vis,
             name,
+            access,
             unique,
             ty,
             array,
@@ -205,6 +226,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             attrs,
             vis,
             name,
+            access,
             unique,
             ty,
             array,
@@ -220,7 +242,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             RegOffset::Fixed { offset } => quote!(#offset),
             RegOffset::Alias { alias } => {
                 quote_spanned!(alias.span().resolved_at(span) =>
-                    ::kernel::io::register::OffsetLoc::<#base, _>::const_offset(#alias)
+                    ::kernel::io::register::OffsetLoc::<#base, _, _>::const_offset(#alias)
                 )
             }
             RegOffset::ElementAlias { alias, idx } => {
@@ -246,15 +268,16 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
                 if unique {
                     outputs.extend(quote!(
                         impl ::kernel::io::register::FixedIoLoc<#base> for #ty {
-                            type Location = ::kernel::io::register::OffsetLoc<#base, #ty>;
+                            type Location = ::kernel::io::register::OffsetLoc<#base, #ty, #access>;
                             const LOCATION: Self::Location = #name;
                         }
                     ))
                 }
 
                 outputs.extend(quote_spanned!(span =>
-                    #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
-                        ::kernel::io::register::OffsetLoc::new(#offset);
+                    #(#attrs)* #vis const #name:
+                        ::kernel::io::register::OffsetLoc<#base, #ty, #access> =
+                        ::kernel::io::register::OffsetLoc::with_access(#offset);
                 ));
             }
 
@@ -283,7 +306,7 @@ impl ::kernel::io::register::Array for #name {}
 
                     impl ::kernel::io::register::RegisterArray for #name {
                         type Base = #base;
-                        type Access = ::kernel::io::access::ReadWrite;
+                        type Access = #access;
                         const OFFSET: usize = #offset;
                         const SIZE: usize = #size;
                         const STRIDE: usize = #stride;

-- 
2.56.0

