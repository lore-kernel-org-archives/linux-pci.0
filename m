Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F73B19D9;
	Mon, 10 Aug 2026 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402203; cv=none; b=XebNFjLdRwWGn3HedKmqZxwGKBf8cHPBKZSUaM2uR5G+3spdG4Av+Z/P58kC8y3CWldBaRNwpwtHTZOvOmq4ipoPi8m1MYqeSYZXci+1hYMdM6u/Atf9uXMsZaaAninFXYYp3meR7K4BimpAHDRCXrWqIKlscjHPZhXEhhx+VD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402203; c=relaxed/simple;
	bh=wMqEVW5kWhDeIECn7gd5WW2NWRQ88U2SA09YBzsxIWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/TR7K730T5I1zali24oH9k66UWW+W+2kqAMogYDQ0hHnTJvY33ziTnxgFT2KOk0M8MbXOI+/HjAUAMxulpfP9UD1kAihb6FwuvDS4OpV/Lp/wsXgRN5n2lGZ6mUlumP7vxxl625Xer8Nu56WuganN24xuq/uFl5xAJ5ZvegN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O96udFG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O96udFG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BB71F00A3A;
	Mon, 10 Aug 2026 22:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402201;
	bh=37IhENiCIf1Rxw+TUNdCHt8A5GZ16leg1dT5esUP9zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O96udFG4ZkgHwcvEbW8Kwb0fguD6dKXMADB8xh/Wday4AU0IPJLxZ5a/EUFZVd/sH
	 0bl4Ik5Z8DnDPjfi56IV8EIvaA7kBFDNmE7s2x5GKL+VefkCD2RtGNzuSw5CFFYT9L
	 9InXtj6Yp2Gz5ZzIE6PlqusUe0YhEotu5FRw8otelEEf5UPIEczgKP9WPiV1ylsjNV
	 IzZUMkpbapa8VfqNUzn29l7vBvmVEJEcqlf2TvSCH9uK2WrYWEy0qpp6J6wbmGxpoC
	 6v3o6HLpUen1xppY9OsCekWrxy2SCVIhAbvvC6QjS/WdZYdo/Drs0qix2cH0Xs9/7Y
	 kForV2k4FXapw==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	dakr@kernel.org,
	kwilczynski@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	jhubbard@nvidia.com,
	ttabi@nvidia.com,
	apopple@nvidia.com,
	ecourtney@nvidia.com,
	shashanks@nvidia.com,
	zhiw@nvidia.com
Cc: driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] rust: irq: add anchor generic to IrqRequest and Registration
Date: Tue, 11 Aug 2026 00:47:40 +0200
Message-ID: <20260810224800.2314458-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810224800.2314458-1-dakr@kernel.org>
References: <20260810224800.2314458-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an IrqRequestAnchor marker trait and a generic parameter A
(defaulting to ()) on IrqRequest, Registration, and
ThreadedRegistration.

Bus-specific IRQ sources can implement IrqRequestAnchor for a reference
to their allocation type, so that the Registration stores a real borrow
of the allocation and prevents it from being dropped while the handler
is live.

The default anchor () keeps all existing behavior unchanged; platform
devices are unaffected.

Add a new constructor IrqRequest::new_anchored() that accepts the anchor
value. The existing IrqRequest::new() continues to produce
IrqRequest<'a, ()>.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/irq.rs         | 10 ++++-
 rust/kernel/irq/request.rs | 86 ++++++++++++++++++++++++++++----------
 2 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
index 09ef1e7f853c..dd3cc6969ebf 100644
--- a/rust/kernel/irq.rs
+++ b/rust/kernel/irq.rs
@@ -19,6 +19,12 @@
 pub use flags::Flags;
 
 pub use request::{
-    Handler, IrqRequest, IrqReturn, Registration, ThreadedHandler, ThreadedIrqReturn,
-    ThreadedRegistration,
+    Handler,
+    IrqRequest,
+    IrqRequestAnchor,
+    IrqReturn,
+    Registration,
+    ThreadedHandler,
+    ThreadedIrqReturn,
+    ThreadedRegistration, //
 };
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index c1c6525a676a..760381a07816 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -44,17 +44,31 @@ pub trait Handler: Sync {
     fn handle(&self) -> IrqReturn;
 }
 
+/// Marker trait for the anchor stored in an [`IrqRequest`].
+///
+/// Bus-specific IRQ sources can implement this for a reference to their allocation type, so that
+/// the [`Registration`] that stores the request keeps the allocation alive. The default `()`
+/// imposes no constraint beyond the device lifetime.
+pub trait IrqRequestAnchor: Send + Sync {}
+
+impl IrqRequestAnchor for () {}
+
 /// A request for an IRQ line for a given device.
 ///
+/// The anchor `A` is stored in the [`Registration`] built from this request. When `A` is a
+/// reference to a bus-specific allocation, the borrow prevents the allocation from being dropped
+/// before the handler is freed.
+///
 /// # Invariants
 ///
 /// - `ìrq` is the number of an interrupt source of `dev`.
 /// - `irq` has not been registered yet; this is consumed by [`Registration::new()`].
-pub struct IrqRequest<'a> {
+pub struct IrqRequest<'a, A: IrqRequestAnchor = ()> {
     irq: u32,
     /// Proves the device is bound at registration time and ties `'a` to the device's bound
     /// lifetime, ensuring the [`Registration`] cannot outlive it.
     _dev: PhantomData<&'a Device<Bound>>,
+    anchor: A,
 }
 
 impl<'a> IrqRequest<'a> {
@@ -63,14 +77,34 @@ impl<'a> IrqRequest<'a> {
     /// # Safety
     ///
     /// - `irq` should be a valid IRQ number for `dev`.
+    #[inline]
     pub(crate) unsafe fn new(_dev: &'a Device<Bound>, irq: u32) -> Self {
+        // SAFETY: Caller guarantees `irq` is valid for `dev`.
+        unsafe { Self::new_anchored(_dev, irq, ()) }
+    }
+}
+
+impl<'a, A: IrqRequestAnchor> IrqRequest<'a, A> {
+    /// Creates a new IRQ request with an anchor to a bus-specific resource allocation.
+    ///
+    /// # Safety
+    ///
+    /// `irq` must be a valid IRQ number for `dev`.
+    #[inline]
+    pub(crate) unsafe fn new_anchored(_dev: &'a Device<Bound>, irq: u32, anchor: A) -> Self {
         // INVARIANT: `irq` is a valid IRQ number for `dev`.
         IrqRequest {
             irq,
             _dev: PhantomData,
+            anchor,
         }
     }
 
+    /// Returns a reference to the anchor.
+    pub fn anchor(&self) -> &A {
+        &self.anchor
+    }
+
     /// Returns the IRQ number of an [`IrqRequest`].
     #[inline]
     pub fn irq(&self) -> u32 {
@@ -154,8 +188,8 @@ pub fn irq(&self) -> u32 {
 ///
 /// * We own an irq handler registered via `request_irq` whose cookie is a pointer to `Self`.
 #[pin_data(PinnedDrop)]
-pub struct Registration<'a, T: Handler> {
-    request: IrqRequest<'a>,
+pub struct Registration<'a, T: Handler, A: IrqRequestAnchor = ()> {
+    request: IrqRequest<'a, A>,
 
     #[pin]
     handler: T,
@@ -166,7 +200,7 @@ pub struct Registration<'a, T: Handler> {
     _pin: PhantomPinned,
 }
 
-impl<'a, T: Handler> Registration<'a, T> {
+impl<'a, T: Handler, A: IrqRequestAnchor + 'a> Registration<'a, T, A> {
     /// Registers the IRQ handler with the system for the given IRQ number.
     ///
     /// # Safety
@@ -174,7 +208,7 @@ impl<'a, T: Handler> Registration<'a, T> {
     /// Callers must not `mem::forget()` the returned [`Registration`] or otherwise prevent its
     /// [`Drop`] implementation from running.
     pub unsafe fn new(
-        request: IrqRequest<'a>,
+        request: IrqRequest<'a, A>,
         flags: Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
@@ -199,7 +233,7 @@ pub unsafe fn new(
                 to_result(unsafe {
                     bindings::request_irq(
                         request.irq,
-                        Some(handle_irq_callback::<T>),
+                        Some(handle_irq_callback::<T, A>),
                         flags.into_inner(),
                         name.as_char_ptr(),
                         this.as_ptr().cast::<c_void>(),
@@ -223,7 +257,7 @@ pub fn synchronize(&self) {
 }
 
 #[pinned_drop]
-impl<T: Handler> PinnedDrop for Registration<'_, T> {
+impl<T: Handler, A: IrqRequestAnchor> PinnedDrop for Registration<'_, T, A> {
     fn drop(self: Pin<&mut Self>) {
         // SAFETY: The cookie was set to a pointer to `Self` in `Registration::new()`. This blocks
         // until all in-flight handlers complete, so no references to `self` remain after this
@@ -240,9 +274,12 @@ fn drop(self: Pin<&mut Self>) {
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_irq`.
-unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
-    let ptr = ptr.cast_const().cast::<Registration<'_, T>>();
-    // SAFETY: `ptr` is a pointer to `Registration<'_, T>` set in `Registration::new()`.
+unsafe extern "C" fn handle_irq_callback<T: Handler, A: IrqRequestAnchor>(
+    _irq: i32,
+    ptr: *mut c_void,
+) -> c_uint {
+    let ptr = ptr.cast_const().cast::<Registration<'_, T, A>>();
+    // SAFETY: `ptr` is a pointer to `Registration<'_, T, A>` set in `Registration::new()`.
     let registration = unsafe { &*ptr };
 
     T::handle(&registration.handler) as c_uint
@@ -371,8 +408,8 @@ fn handle(&self) -> ThreadedIrqReturn {
 /// * We own an irq handler registered via `request_threaded_irq` whose cookie is a pointer to
 ///   `Self`.
 #[pin_data(PinnedDrop)]
-pub struct ThreadedRegistration<'a, T: ThreadedHandler> {
-    request: IrqRequest<'a>,
+pub struct ThreadedRegistration<'a, T: ThreadedHandler, A: IrqRequestAnchor = ()> {
+    request: IrqRequest<'a, A>,
 
     #[pin]
     handler: T,
@@ -383,7 +420,7 @@ pub struct ThreadedRegistration<'a, T: ThreadedHandler> {
     _pin: PhantomPinned,
 }
 
-impl<'a, T: ThreadedHandler> ThreadedRegistration<'a, T> {
+impl<'a, T: ThreadedHandler, A: IrqRequestAnchor + 'a> ThreadedRegistration<'a, T, A> {
     /// Registers the IRQ handler with the system for the given IRQ number.
     ///
     /// # Safety
@@ -391,7 +428,7 @@ impl<'a, T: ThreadedHandler> ThreadedRegistration<'a, T> {
     /// Callers must not `mem::forget()` the returned [`ThreadedRegistration`] or otherwise prevent
     /// its [`Drop`] implementation from running.
     pub unsafe fn new(
-        request: IrqRequest<'a>,
+        request: IrqRequest<'a, A>,
         flags: Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
@@ -416,8 +453,8 @@ pub unsafe fn new(
                 to_result(unsafe {
                     bindings::request_threaded_irq(
                         request.irq,
-                        Some(handle_threaded_irq_callback::<T>),
-                        Some(thread_fn_callback::<T>),
+                        Some(handle_threaded_irq_callback::<T, A>),
+                        Some(thread_fn_callback::<T, A>),
                         flags.into_inner(),
                         name.as_char_ptr(),
                         this.as_ptr().cast::<c_void>(),
@@ -441,7 +478,7 @@ pub fn synchronize(&self) {
 }
 
 #[pinned_drop]
-impl<T: ThreadedHandler> PinnedDrop for ThreadedRegistration<'_, T> {
+impl<T: ThreadedHandler, A: IrqRequestAnchor> PinnedDrop for ThreadedRegistration<'_, T, A> {
     fn drop(self: Pin<&mut Self>) {
         // SAFETY: The cookie was set to a pointer to `Self` in `ThreadedRegistration::new()`. This
         // blocks until all in-flight handlers complete, so no references to `self` remain after
@@ -458,12 +495,12 @@ fn drop(self: Pin<&mut Self>) {
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
-unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler>(
+unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler, A: IrqRequestAnchor>(
     _irq: i32,
     ptr: *mut c_void,
 ) -> c_uint {
-    let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T>>();
-    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T>` set in
+    let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T, A>>();
+    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T, A>` set in
     // `ThreadedRegistration::new()`.
     let registration = unsafe { &*ptr };
 
@@ -473,9 +510,12 @@ fn drop(self: Pin<&mut Self>) {
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
-unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
-    let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T>>();
-    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T>` set in
+unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler, A: IrqRequestAnchor>(
+    _irq: i32,
+    ptr: *mut c_void,
+) -> c_uint {
+    let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T, A>>();
+    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T, A>` set in
     // `ThreadedRegistration::new()`.
     let registration = unsafe { &*ptr };
 
-- 
2.55.0

