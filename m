Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8731F98E;
	Thu, 21 May 2026 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406768; cv=none; b=GRrmVBKTTBYeqH67otHOBWiYaFfhgppfdr/n1zEQvMQc83mbwKRR/lOs7Ubzja3INDEyRTCxnS2PHEbuLyjjMVcPPOhQQb4DNiHNWZy9/nGt45OROV4SsK+Ks8unbiZHsXGWNxzep9Y7UwkdE8wTeU6K7Xja6Oi0ExlkL83VeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406768; c=relaxed/simple;
	bh=x3dZFMUUtuu6ylR0hw38q6QBb93LtOcHpn8biD5uuVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLOirMJYsQp969zB6/LOhhMDjiOTLMLXcWY4LvCA2xjhUdoFbX1uq+fDN1idpInK9y3BWPci98Hy1ld60CjEVnnZ0UsH39btt3i50jRg404i/iTeS0JbPCtHpJBXuON199+NdkB7QdZQeFkCdNspmdpxE4rtmDPXctu2/x1+oDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaPJnacM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaPJnacM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7341F00A3B;
	Thu, 21 May 2026 23:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406766;
	bh=ijMJWtwRHur6EZev09qU6JpbliROeigizWCF7odkHNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NaPJnacMvbtT9B3VgmxVX6ENRoNeBTGOAI/2DA7+M7cjr52RbwBRR5VKw+DglxgL8
	 +cpsQafoQbKfoPHIOg05XHrA3fAKP730W6xoiiX4h+B9/Jy60MXYHkAMRPuO1r0owq
	 fSUNhiU8D4LBVks6kD31yF63wLlUXK+BIx3r+Mf+g6N4NjOn3UKCn4eT+ORA0+cPJ4
	 5HeV42MOf9g+cYlY6xRbT7+WMyDEjSYKb1KcJAUmYOxw/vCvdHZ6v+az/oL6Qj/vZJ
	 8emOPqhe40vTi0bVXZyIk7MsziizylOXqssSAHZdMffPiCOjH6BFCBima3vBaInTQ+
	 Sy3Dgs4x96Bmg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com,
	pcolberg@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 01/27] rust: alloc: remove `'static` bound on `ForeignOwnable`
Date: Fri, 22 May 2026 01:34:27 +0200
Message-ID: <20260521233501.1191842-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

The `'static` bound is currently necessary because there's no
restriction on the lifetime of the GAT. Add a `Self: 'a` bound to
restrict possible lifetimes on `Borrowed` and `BorrowedMut`, and lift
the `'static` requirement.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 24 ++++++++++++++++++------
 rust/kernel/types.rs      |  8 ++++++--
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index c824ed6e1523..2f8c16473c2c 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -477,7 +477,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
 // pointer to `T` allocated by `A`.
-unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
+unsafe impl<T, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
@@ -487,8 +487,14 @@ unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
         core::mem::align_of::<T>()
     };
 
-    type Borrowed<'a> = &'a T;
-    type BorrowedMut<'a> = &'a mut T;
+    type Borrowed<'a>
+        = &'a T
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = &'a mut T
+    where
+        Self: 'a;
 
     fn into_foreign(self) -> *mut c_void {
         Box::into_raw(self).cast()
@@ -516,13 +522,19 @@ unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a mut T {
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
 // pointer to `T` allocated by `A`.
-unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
+unsafe impl<T, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
     const FOREIGN_ALIGN: usize = <Box<T, A> as ForeignOwnable>::FOREIGN_ALIGN;
-    type Borrowed<'a> = Pin<&'a T>;
-    type BorrowedMut<'a> = Pin<&'a mut T>;
+    type Borrowed<'a>
+        = Pin<&'a T>
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = Pin<&'a mut T>
+    where
+        Self: 'a;
 
     fn into_foreign(self) -> *mut c_void {
         // SAFETY: We are still treating the box as pinned.
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 4329d3c2c2e5..9cf9f869d195 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -27,10 +27,14 @@ pub unsafe trait ForeignOwnable: Sized {
     const FOREIGN_ALIGN: usize;
 
     /// Type used to immutably borrow a value that is currently foreign-owned.
-    type Borrowed<'a>;
+    type Borrowed<'a>
+    where
+        Self: 'a;
 
     /// Type used to mutably borrow a value that is currently foreign-owned.
-    type BorrowedMut<'a>;
+    type BorrowedMut<'a>
+    where
+        Self: 'a;
 
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
-- 
2.54.0

