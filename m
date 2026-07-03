Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E528505E;
	Fri,  3 Jul 2026 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112988; cv=none; b=AE78TqKW6o7Ex3B3fmX1r+85fdFD2lH0p/YVBtN76wMc3P3hZ8EVzY71Lw+RGFJE1pqi9GWJ9I4TuXxregJZSiymchtqzmnNn4zWG+ihTkcGZdx9wBlFlzxyYhjmj02GXvMJND2GV/ciE1T8ZFvaWe4fHZifdjhM/ShSStH4VqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112988; c=relaxed/simple;
	bh=6x/f2a/9w2jjApIyjjsc9qsKNhostpjDGT6vqcl63hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwnYbdMnzrfNKgDeDl8j4imt+t5TPhZ71E7bRg8iGNKpBkxsjKlTQAKDRVXcWPIW0d2LXipwr9MX3zawAkoHnx2hRsF45SjBHvyyYecBK3YBTUum+uUfrRdlbR7qeFU8IrTha85+MhegY5GP6htg2BSNgz9Q4LuvClP/Y2+CMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpR1mX5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpR1mX5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32251F000E9;
	Fri,  3 Jul 2026 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112986;
	bh=a9RVvfRrxThRB0XMcfQponpssTZqdDtsLB8632nX4+s=;
	h=From:To:Cc:Subject:Date;
	b=fpR1mX5jt0aI6IDPX7IUzHOHRIcGfRvgDdGZnU9iPAKLZfN+DxTtCv5kpGYPPB0Js
	 y72N9XkbHHhxqUxRf0cp3e6YztvPehasPXZtJ9kvIAGZ/fmbg3lcKqp96P5LHAyroU
	 YVcuDe2iCFKWKIfJxpZnXtBWRbqh6fgDbWXkdqKmtzpXn0Pb7TfcsKP2TGipFzLENA
	 lY5ixmuE6wsSgjyvVtW2zdUtWljoishBW3vXQtsfVheh+8OJkofRW1Ei4at6N89iM+
	 G8jd9NolxgyLYieow2Xr9M6PovWgH4LF3QUxKwNjlKqr/aGr0w7k8AyJAGclyjLcFY
	 l278ywd6Antgw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
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
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mhi@mailbox.org
Cc: driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: irq: make Registration compatible with lifetime-bound drivers
Date: Fri,  3 Jul 2026 23:09:21 +0200
Message-ID: <20260703210936.1128698-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
(HRT) device driver architecture introduced in commit 2c7c65933600
("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
device drivers"").

With HRT, driver structs carry a lifetime parameter tied to the device
binding scope, allowing device resources such as pci::Bar<'bar> to be
held directly rather than through Devres indirection. However, the IRQ
abstraction required Handler: Sync + 'static, preventing handlers from
embedding lifetime-parameterized resources.

Remove the 'static bound from Handler and ThreadedHandler and replace
the Devres<RegistrationInner> indirection with direct request_irq() /
free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
stores the IrqRequest<'a>, which structurally ties it to the device
binding scope.

Also remove the &Device<Bound> parameter from the handler callbacks,
since handlers that need device access can embed it in their own type.

IRQ handlers can now directly own device resources:

	struct IrqHandler<'irq> {
	    bar: pci::Bar<'irq, BAR_SIZE>,
	}

	impl irq::Handler for IrqHandler<'_> {
	    fn handle(&self) -> IrqReturn {
	        let stat = self.bar.read(regs::STAT);
	        ...
	    }
	}

This eliminates the indirection previously required for IRQ handlers to
access device resources and aligns with the broader goal of expressing
every registration scoped to a driver binding through compile-time
lifetime bounds.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/irq/request.rs | 427 +++++++++++++++++--------------------
 rust/kernel/pci/irq.rs     |  26 ++-
 rust/kernel/platform.rs    |  48 +++--
 3 files changed, 250 insertions(+), 251 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index f425fe12f7c8..88e474b2ab73 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -5,16 +5,21 @@
 //! [`ThreadedRegistration`], which allow users to register handlers for a given
 //! IRQ line.
 
-use core::marker::PhantomPinned;
-
-use crate::alloc::Allocator;
-use crate::device::{Bound, Device};
-use crate::devres::Devres;
-use crate::error::to_result;
-use crate::irq::flags::Flags;
-use crate::prelude::*;
-use crate::str::CStr;
-use crate::sync::Arc;
+use core::marker::{
+    PhantomData,
+    PhantomPinned, //
+};
+
+use crate::{
+    device::{
+        Bound,
+        Device, //
+    },
+    error::to_result,
+    irq::flags::Flags,
+    prelude::*,
+    str::CStr,
+};
 
 /// The value that can be returned from a [`Handler`] or a [`ThreadedHandler`].
 #[repr(u32)]
@@ -27,7 +32,7 @@ pub enum IrqReturn {
 }
 
 /// Callbacks for an IRQ handler.
-pub trait Handler: Sync + 'static {
+pub trait Handler: Sync {
     /// The hard IRQ handler.
     ///
     /// This is executed in interrupt context, hence all corresponding
@@ -36,73 +41,20 @@ pub trait Handler: Sync + 'static {
     /// All work that does not necessarily need to be executed from
     /// interrupt context, should be deferred to a threaded handler.
     /// See also [`ThreadedRegistration`].
-    fn handle(&self, device: &Device<Bound>) -> IrqReturn;
-}
-
-impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
-    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
-        T::handle(self, device)
-    }
-}
-
-impl<T: ?Sized + Handler, A: Allocator + 'static> Handler for Box<T, A> {
-    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
-        T::handle(self, device)
-    }
+    fn handle(&self) -> IrqReturn;
 }
 
-/// # Invariants
-///
-/// - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
-/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It is guaranteed to be unique
-///   by the type system, since each call to `new` will return a different instance of
-///   `Registration`.
-#[pin_data(PinnedDrop)]
-struct RegistrationInner {
-    irq: u32,
-    cookie: *mut c_void,
-}
-
-impl RegistrationInner {
-    fn synchronize(&self) {
-        // SAFETY: safe as per the invariants of `RegistrationInner`
-        unsafe { bindings::synchronize_irq(self.irq) };
-    }
-}
-
-#[pinned_drop]
-impl PinnedDrop for RegistrationInner {
-    fn drop(self: Pin<&mut Self>) {
-        // SAFETY:
-        //
-        // Safe as per the invariants of `RegistrationInner` and:
-        //
-        // - The containing struct is `!Unpin` and was initialized using
-        // pin-init, so it occupied the same memory location for the entirety of
-        // its lifetime.
-        //
-        // Notice that this will block until all handlers finish executing,
-        // i.e.: at no point will &self be invalid while the handler is running.
-        unsafe { bindings::free_irq(self.irq, self.cookie) };
-    }
-}
-
-// SAFETY: We only use `inner` on drop, which called at most once with no
-// concurrent access.
-unsafe impl Sync for RegistrationInner {}
-
-// SAFETY: It is safe to send `RegistrationInner` across threads.
-unsafe impl Send for RegistrationInner {}
-
 /// A request for an IRQ line for a given device.
 ///
 /// # Invariants
 ///
 /// - `ìrq` is the number of an interrupt source of `dev`.
-/// - `irq` has not been registered yet.
+/// - `irq` has not been registered yet; this is consumed by [`Registration::new()`].
 pub struct IrqRequest<'a> {
-    dev: &'a Device<Bound>,
     irq: u32,
+    /// Proves the device is bound at registration time and ties `'a` to the device's bound
+    /// lifetime, ensuring the [`Registration`] cannot outlive it.
+    _dev: PhantomData<&'a Device<Bound>>,
 }
 
 impl<'a> IrqRequest<'a> {
@@ -111,9 +63,12 @@ impl<'a> IrqRequest<'a> {
     /// # Safety
     ///
     /// - `irq` should be a valid IRQ number for `dev`.
-    pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {
+    pub(crate) unsafe fn new(_dev: &'a Device<Bound>, irq: u32) -> Self {
         // INVARIANT: `irq` is a valid IRQ number for `dev`.
-        IrqRequest { dev, irq }
+        IrqRequest {
+            irq,
+            _dev: PhantomData,
+        }
     }
 
     /// Returns the IRQ number of an [`IrqRequest`].
@@ -139,10 +94,18 @@ pub fn irq(&self) -> u32 {
 /// [`Completion::wait_for_completion()`]: kernel::sync::Completion::wait_for_completion
 ///
 /// ```
-/// use kernel::device::{Bound, Device};
-/// use kernel::irq::{self, Flags, IrqRequest, IrqReturn, Registration};
-/// use kernel::prelude::*;
-/// use kernel::sync::{Arc, Completion};
+/// use core::pin::Pin;
+/// use kernel::{
+///     irq::{
+///         self,
+///         Flags,
+///         IrqRequest,
+///         IrqReturn,
+///         Registration,
+///     },
+///     prelude::*,
+///     sync::Completion,
+/// };
 ///
 /// // Data shared between process and IRQ context.
 /// #[pin_data]
@@ -153,7 +116,7 @@ pub fn irq(&self) -> u32 {
 ///
 /// impl irq::Handler for Data {
 ///     // Executed in IRQ context.
-///     fn handle(&self, _dev: &Device<Bound>) -> IrqReturn {
+///     fn handle(&self) -> IrqReturn {
 ///         self.completion.complete_all();
 ///         IrqReturn::Handled
 ///     }
@@ -163,12 +126,21 @@ pub fn irq(&self) -> u32 {
 /// //
 /// // This runs in process context and assumes `request` was previously acquired from a device.
 /// fn register_irq(
-///     handler: impl PinInit<Data, Error>,
 ///     request: IrqRequest<'_>,
-/// ) -> Result<Arc<Registration<Data>>> {
-///     let registration = Registration::new(request, Flags::SHARED, c"my_device", handler);
+/// ) -> Result<Pin<KBox<Registration<'_, Data>>>> {
+///     // SAFETY: The returned Registration is not leaked.
+///     let registration = unsafe {
+///         Registration::new(
+///             request,
+///             Flags::SHARED,
+///             c"my_device",
+///             try_pin_init!(Data {
+///                 completion <- Completion::new(),
+///             }? Error),
+///         )
+///     };
 ///
-///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
+///     let registration = KBox::pin_init(registration, GFP_KERNEL)?;
 ///
 ///     registration.handler().completion.wait_for_completion();
 ///
@@ -179,11 +151,10 @@ pub fn irq(&self) -> u32 {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler whose cookie is a pointer to `Self`.
-#[pin_data]
-pub struct Registration<T: Handler> {
-    #[pin]
-    inner: Devres<RegistrationInner>,
+/// * We own an irq handler registered via `request_irq` whose cookie is a pointer to `Self`.
+#[pin_data(PinnedDrop)]
+pub struct Registration<'a, T: Handler> {
+    request: IrqRequest<'a>,
 
     #[pin]
     handler: T,
@@ -194,43 +165,44 @@ pub struct Registration<T: Handler> {
     _pin: PhantomPinned,
 }
 
-impl<T: Handler> Registration<T> {
+impl<'a, T: Handler> Registration<'a, T> {
     /// Registers the IRQ handler with the system for the given IRQ number.
-    pub fn new<'a>(
+    ///
+    /// # Safety
+    ///
+    /// Callers must not `mem::forget()` the returned [`Registration`] or otherwise prevent its
+    /// [`Drop`] implementation from running.
+    pub unsafe fn new(
         request: IrqRequest<'a>,
         flags: Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<Self, Error> + 'a {
+    ) -> impl PinInit<Self, Error> + 'a
+    where
+        T: 'a,
+    {
         try_pin_init!(&this in Self {
             handler <- handler,
-            inner <- Devres::new(
-                request.dev,
-                try_pin_init!(RegistrationInner {
-                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
-                    cookie: this.as_ptr().cast::<c_void>(),
-                    irq: {
-                        // SAFETY:
-                        // - The callbacks are valid for use with request_irq.
-                        // - If this succeeds, the slot is guaranteed to be valid until the
-                        //   destructor of Self runs, which will deregister the callbacks
-                        //   before the memory location becomes invalid.
-                        // - When request_irq is called, everything that handle_irq_callback will
-                        //   touch has already been initialized, so it's safe for the callback to
-                        //   be called immediately.
-                        to_result(unsafe {
-                            bindings::request_irq(
-                                request.irq,
-                                Some(handle_irq_callback::<T>),
-                                flags.into_inner(),
-                                name.as_char_ptr(),
-                                this.as_ptr().cast::<c_void>(),
-                            )
-                        })?;
-                        request.irq
-                    }
-                })
-            ),
+            request: {
+                // SAFETY:
+                // - The callbacks are valid for use with request_irq.
+                // - If this succeeds, the slot is guaranteed to be valid until the destructor of
+                //   Self runs, which will deregister the callbacks before the memory location
+                //   becomes invalid.
+                // - When request_irq is called, everything that handle_irq_callback will touch
+                //   has already been initialized, so it's safe for the callback to be called
+                //   immediately.
+                to_result(unsafe {
+                    bindings::request_irq(
+                        request.irq,
+                        Some(handle_irq_callback::<T>),
+                        flags.into_inner(),
+                        name.as_char_ptr(),
+                        this.as_ptr().cast::<c_void>(),
+                    )
+                })?;
+                request
+            },
             _pin: PhantomPinned,
         })
     }
@@ -241,19 +213,24 @@ pub fn handler(&self) -> &T {
     }
 
     /// Wait for pending IRQ handlers on other CPUs.
-    ///
-    /// This will attempt to access the inner [`Devres`] container.
-    pub fn try_synchronize(&self) -> Result {
-        let inner = self.inner.try_access().ok_or(ENODEV)?;
-        inner.synchronize();
-        Ok(())
+    pub fn synchronize(&self) {
+        // SAFETY: `self.request.irq` is a valid registered IRQ number (type invariant).
+        unsafe { bindings::synchronize_irq(self.request.irq) };
     }
+}
 
-    /// Wait for pending IRQ handlers on other CPUs.
-    pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
-        let inner = self.inner.access(dev)?;
-        inner.synchronize();
-        Ok(())
+#[pinned_drop]
+impl<T: Handler> PinnedDrop for Registration<'_, T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: The cookie was set to a pointer to `Self` in `Registration::new()`. This blocks
+        // until all in-flight handlers complete, so no references to `self` remain after this
+        // returns.
+        unsafe {
+            bindings::free_irq(
+                self.request.irq,
+                core::ptr::from_mut::<Self>(self.get_unchecked_mut()).cast::<c_void>(),
+            )
+        };
     }
 }
 
@@ -261,13 +238,11 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 ///
 /// This function should be only used as the callback in `request_irq`.
 unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
-    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
-    let registration = unsafe { &*(ptr as *const Registration<T>) };
-    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
-    // callback is running implies that the device has not yet been unbound.
-    let device = unsafe { registration.inner.device().as_bound() };
+    let ptr = ptr.cast_const().cast::<Registration<'_, T>>();
+    // SAFETY: `ptr` is a pointer to `Registration<'_, T>` set in `Registration::new()`.
+    let registration = unsafe { &*ptr };
 
-    T::handle(&registration.handler, device) as c_uint
+    T::handle(&registration.handler) as c_uint
 }
 
 /// The value that can be returned from [`ThreadedHandler::handle`].
@@ -284,7 +259,7 @@ pub enum ThreadedIrqReturn {
 }
 
 /// Callbacks for a threaded IRQ handler.
-pub trait ThreadedHandler: Sync + 'static {
+pub trait ThreadedHandler: Sync {
     /// The hard IRQ handler.
     ///
     /// This is executed in interrupt context, hence all corresponding
@@ -293,8 +268,7 @@ pub trait ThreadedHandler: Sync + 'static {
     /// handler, i.e. [`ThreadedHandler::handle_threaded`].
     ///
     /// The default implementation returns [`ThreadedIrqReturn::WakeThread`].
-    #[expect(unused_variables)]
-    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
+    fn handle(&self) -> ThreadedIrqReturn {
         ThreadedIrqReturn::WakeThread
     }
 
@@ -302,27 +276,7 @@ fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
     ///
     /// This is executed in process context. The kernel creates a dedicated
     /// `kthread` for this purpose.
-    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn;
-}
-
-impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
-    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
-        T::handle(self, device)
-    }
-
-    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
-        T::handle_threaded(self, device)
-    }
-}
-
-impl<T: ?Sized + ThreadedHandler, A: Allocator + 'static> ThreadedHandler for Box<T, A> {
-    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
-        T::handle(self, device)
-    }
-
-    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
-        T::handle_threaded(self, device)
-    }
+    fn handle_threaded(&self) -> IrqReturn;
 }
 
 /// A registration of a threaded IRQ handler for a given IRQ line.
@@ -339,13 +293,20 @@ fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
 /// [`Mutex`](kernel::sync::Mutex) to provide interior mutability.
 ///
 /// ```
-/// use kernel::device::{Bound, Device};
-/// use kernel::irq::{
-///   self, Flags, IrqRequest, IrqReturn, ThreadedHandler, ThreadedIrqReturn,
-///   ThreadedRegistration,
+/// use core::pin::Pin;
+/// use kernel::{
+///     irq::{
+///         self,
+///         Flags,
+///         IrqRequest,
+///         IrqReturn,
+///         ThreadedHandler,
+///         ThreadedIrqReturn,
+///         ThreadedRegistration,
+///     },
+///     prelude::*,
+///     sync::Mutex,
 /// };
-/// use kernel::prelude::*;
-/// use kernel::sync::{Arc, Mutex};
 ///
 /// // Declare a struct that will be passed in when the interrupt fires. The u32
 /// // merely serves as an example of some internal data.
@@ -363,7 +324,7 @@ fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
 ///     // This will run (in a separate kthread) if and only if
 ///     // [`ThreadedHandler::handle`] returns [`WakeThread`], which it does by
 ///     // default.
-///     fn handle_threaded(&self, _dev: &Device<Bound>) -> IrqReturn {
+///     fn handle_threaded(&self) -> IrqReturn {
 ///         let mut data = self.value.lock();
 ///         *data += 1;
 ///         IrqReturn::Handled
@@ -375,13 +336,21 @@ fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
 /// // This is executing in process context and assumes that `request` was
 /// // previously acquired from a device.
 /// fn register_threaded_irq(
-///     handler: impl PinInit<Data, Error>,
 ///     request: IrqRequest<'_>,
-/// ) -> Result<Arc<ThreadedRegistration<Data>>> {
-///     let registration =
-///         ThreadedRegistration::new(request, Flags::SHARED, c"my_device", handler);
+/// ) -> Result<Pin<KBox<ThreadedRegistration<'_, Data>>>> {
+///     // SAFETY: The returned Registration is not leaked.
+///     let registration = unsafe {
+///         ThreadedRegistration::new(
+///             request,
+///             Flags::SHARED,
+///             c"my_device",
+///             try_pin_init!(Data {
+///                 value <- kernel::new_mutex!(0),
+///             }? Error),
+///         )
+///     };
 ///
-///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
+///     let registration = KBox::pin_init(registration, GFP_KERNEL)?;
 ///
 ///     {
 ///         // The data can be accessed from process context too.
@@ -396,11 +365,11 @@ fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
 ///
 /// # Invariants
 ///
-/// * We own an irq handler whose cookie is a pointer to `Self`.
-#[pin_data]
-pub struct ThreadedRegistration<T: ThreadedHandler> {
-    #[pin]
-    inner: Devres<RegistrationInner>,
+/// * We own an irq handler registered via `request_threaded_irq` whose cookie is a pointer to
+///   `Self`.
+#[pin_data(PinnedDrop)]
+pub struct ThreadedRegistration<'a, T: ThreadedHandler> {
+    request: IrqRequest<'a>,
 
     #[pin]
     handler: T,
@@ -411,44 +380,45 @@ pub struct ThreadedRegistration<T: ThreadedHandler> {
     _pin: PhantomPinned,
 }
 
-impl<T: ThreadedHandler> ThreadedRegistration<T> {
+impl<'a, T: ThreadedHandler> ThreadedRegistration<'a, T> {
     /// Registers the IRQ handler with the system for the given IRQ number.
-    pub fn new<'a>(
+    ///
+    /// # Safety
+    ///
+    /// Callers must not `mem::forget()` the returned [`ThreadedRegistration`] or otherwise prevent
+    /// its [`Drop`] implementation from running.
+    pub unsafe fn new(
         request: IrqRequest<'a>,
         flags: Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<Self, Error> + 'a {
+    ) -> impl PinInit<Self, Error> + 'a
+    where
+        T: 'a,
+    {
         try_pin_init!(&this in Self {
             handler <- handler,
-            inner <- Devres::new(
-                request.dev,
-                try_pin_init!(RegistrationInner {
-                    // INVARIANT: `this` is a valid pointer to the `ThreadedRegistration` instance.
-                    cookie: this.as_ptr().cast::<c_void>(),
-                    irq: {
-                        // SAFETY:
-                        // - The callbacks are valid for use with request_threaded_irq.
-                        // - If this succeeds, the slot is guaranteed to be valid until the
-                        //   destructor of Self runs, which will deregister the callbacks
-                        //   before the memory location becomes invalid.
-                        // - When request_threaded_irq is called, everything that the two callbacks
-                        //   will touch has already been initialized, so it's safe for the
-                        //   callbacks to be called immediately.
-                        to_result(unsafe {
-                            bindings::request_threaded_irq(
-                                request.irq,
-                                Some(handle_threaded_irq_callback::<T>),
-                                Some(thread_fn_callback::<T>),
-                                flags.into_inner(),
-                                name.as_char_ptr(),
-                                this.as_ptr().cast::<c_void>(),
-                            )
-                        })?;
-                        request.irq
-                    }
-                })
-            ),
+            request: {
+                // SAFETY:
+                // - The callbacks are valid for use with request_threaded_irq.
+                // - If this succeeds, the slot is guaranteed to be valid until the destructor of
+                //   Self runs, which will deregister the callbacks before the memory location
+                //   becomes invalid.
+                // - When request_threaded_irq is called, everything that the two callbacks will
+                //   touch has already been initialized, so it's safe for the callbacks to be
+                //   called immediately.
+                to_result(unsafe {
+                    bindings::request_threaded_irq(
+                        request.irq,
+                        Some(handle_threaded_irq_callback::<T>),
+                        Some(thread_fn_callback::<T>),
+                        flags.into_inner(),
+                        name.as_char_ptr(),
+                        this.as_ptr().cast::<c_void>(),
+                    )
+                })?;
+                request
+            },
             _pin: PhantomPinned,
         })
     }
@@ -459,19 +429,24 @@ pub fn handler(&self) -> &T {
     }
 
     /// Wait for pending IRQ handlers on other CPUs.
-    ///
-    /// This will attempt to access the inner [`Devres`] container.
-    pub fn try_synchronize(&self) -> Result {
-        let inner = self.inner.try_access().ok_or(ENODEV)?;
-        inner.synchronize();
-        Ok(())
+    pub fn synchronize(&self) {
+        // SAFETY: `self.request.irq` is a valid registered IRQ number (type invariant).
+        unsafe { bindings::synchronize_irq(self.request.irq) };
     }
+}
 
-    /// Wait for pending IRQ handlers on other CPUs.
-    pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
-        let inner = self.inner.access(dev)?;
-        inner.synchronize();
-        Ok(())
+#[pinned_drop]
+impl<T: ThreadedHandler> PinnedDrop for ThreadedRegistration<'_, T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: The cookie was set to a pointer to `Self` in `ThreadedRegistration::new()`. This
+        // blocks until all in-flight handlers complete, so no references to `self` remain after
+        // this returns.
+        unsafe {
+            bindings::free_irq(
+                self.request.irq,
+                core::ptr::from_mut::<Self>(self.get_unchecked_mut()).cast::<c_void>(),
+            )
+        };
     }
 }
 
@@ -482,24 +457,22 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
     _irq: i32,
     ptr: *mut c_void,
 ) -> c_uint {
-    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
-    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
-    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
-    // callback is running implies that the device has not yet been unbound.
-    let device = unsafe { registration.inner.device().as_bound() };
+    let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T>>();
+    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T>` set in
+    // `ThreadedRegistration::new()`.
+    let registration = unsafe { &*ptr };
 
-    T::handle(&registration.handler, device) as c_uint
+    T::handle(&registration.handler) as c_uint
 }
 
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
 unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
-    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
-    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
-    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
-    // callback is running implies that the device has not yet been unbound.
-    let device = unsafe { registration.inner.device().as_bound() };
+    let ptr = ptr.cast_const().cast::<ThreadedRegistration<'_, T>>();
+    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<'_, T>` set in
+    // `ThreadedRegistration::new()`.
+    let registration = unsafe { &*ptr };
 
-    T::handle_threaded(&registration.handler, device) as c_uint
+    T::handle_threaded(&registration.handler) as c_uint
 }
diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index d9230e105541..fea484dcf9cf 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -173,34 +173,44 @@ fn drop(&mut self) {
 
 impl Device<device::Bound> {
     /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
-    pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
+    ///
+    /// # Safety
+    ///
+    /// Callers must not `mem::forget()` the resulting [`irq::Registration`] or otherwise prevent
+    /// its [`Drop`] implementation from running.
+    pub unsafe fn request_irq<'a, T: crate::irq::Handler + 'a>(
         &'a self,
         vector: IrqVector<'a>,
         flags: irq::Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<irq::Registration<T>, Error> + 'a {
+    ) -> impl PinInit<irq::Registration<'a, T>, Error> + 'a {
         pin_init::pin_init_scope(move || {
             let request = vector.try_into()?;
 
-            Ok(irq::Registration::<T>::new(request, flags, name, handler))
+            // SAFETY: Caller guarantees the Registration will not be leaked.
+            Ok(unsafe { irq::Registration::<T>::new(request, flags, name, handler) })
         })
     }
 
     /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
-    pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
+    ///
+    /// # Safety
+    ///
+    /// Callers must not `mem::forget()` the resulting [`irq::ThreadedRegistration`] or otherwise
+    /// prevent its [`Drop`] implementation from running.
+    pub unsafe fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'a>(
         &'a self,
         vector: IrqVector<'a>,
         flags: irq::Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a {
+    ) -> impl PinInit<irq::ThreadedRegistration<'a, T>, Error> + 'a {
         pin_init::pin_init_scope(move || {
             let request = vector.try_into()?;
 
-            Ok(irq::ThreadedRegistration::<T>::new(
-                request, flags, name, handler,
-            ))
+            // SAFETY: Caller guarantees the Registration will not be leaked.
+            Ok(unsafe { irq::ThreadedRegistration::<T>::new(request, flags, name, handler) })
         })
     }
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9b362e0495d3..a4510c68e290 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -339,22 +339,30 @@ macro_rules! define_irq_accessor_by_index {
         $handler_trait:ident
     ) => {
         $(#[$meta])*
-        pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
+        ///
+        /// # Safety
+        ///
+        /// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+        /// [`Drop`] implementation from running.
+        pub unsafe fn $fn_name<'a, T: irq::$handler_trait + 'a>(
             &'a self,
             flags: irq::Flags,
             index: u32,
             name: &'static CStr,
             handler: impl PinInit<T, Error> + 'a,
-        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'a {
+        ) -> impl PinInit<irq::$reg_type<'a, T>, Error> + 'a {
             pin_init::pin_init_scope(move || {
                 let request = self.$request_fn(index)?;
 
-                Ok(irq::$reg_type::<T>::new(
-                    request,
-                    flags,
-                    name,
-                    handler,
-                ))
+                // SAFETY: Caller guarantees the Registration will not be leaked.
+                Ok(unsafe {
+                    irq::$reg_type::<T>::new(
+                        request,
+                        flags,
+                        name,
+                        handler,
+                    )
+                })
             })
         }
     };
@@ -368,22 +376,30 @@ macro_rules! define_irq_accessor_by_name {
         $handler_trait:ident
     ) => {
         $(#[$meta])*
-        pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
+        ///
+        /// # Safety
+        ///
+        /// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+        /// [`Drop`] implementation from running.
+        pub unsafe fn $fn_name<'a, T: irq::$handler_trait + 'a>(
             &'a self,
             flags: irq::Flags,
             irq_name: &'a CStr,
             name: &'static CStr,
             handler: impl PinInit<T, Error> + 'a,
-        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'a {
+        ) -> impl PinInit<irq::$reg_type<'a, T>, Error> + 'a {
             pin_init::pin_init_scope(move || {
                 let request = self.$request_fn(irq_name)?;
 
-                Ok(irq::$reg_type::<T>::new(
-                    request,
-                    flags,
-                    name,
-                    handler,
-                ))
+                // SAFETY: Caller guarantees the Registration will not be leaked.
+                Ok(unsafe {
+                    irq::$reg_type::<T>::new(
+                        request,
+                        flags,
+                        name,
+                        handler,
+                    )
+                })
             })
         }
     };

base-commit: e7e09a8546a9e41a164378979471a4b4bd166bc7
-- 
2.55.0

