Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385050;
	b=BpuXf6eaJnWUCxncVdz+hrxg8tMX3Isql5VCvfq6Fo+7afxShPds+hlU7z393utBAM5l
	 i/UkqJSx2mbepzXCZiPQaxSN0UGb8d+WMeSyCvu+jWqpXpliJypUmcE2oUsvNPd2q13Mh
	 aPvaxGkw/IgRDl/tcsiFKDYAbib0SNht+x1yxo8di5f0LCjQdlmQb7dX3XuUgq7JIl7T3
	 AsadnrE+Kfeha6XlyIOZZQbf5261Pi728UokINiK6MAUhOP9FMWQMgJTc5nbCGZCb1YC4
	 31M67BNgebhwL6dfnivbrto/We0WrBJI+cTBsi+bvLJ2V2srWi9vvjN+UCU5vwUM1Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/IUyD51Xe0yKK+Ii63dUdk7neZ4Ync99LYBgAJGSZJQ=;
	b=KWXIN61QWg604JModnWqdGuqvSYeoobRtgHkC0FPDxZBGwvClWuEaoXDd0x0AbfQ9m7t
	 ilO0ibsLm6Jdkw5X5FTAZqVLopj4YGCw0pjgIjOUKZMVqqAuSqrajNA4fKEp06WN0xPs+
	 nSkBGETBOJGGZwIDln6GKLL16IQn/olu1bjWiH0cLdAK3t/BNSFA6NZFzg3EsM7gnkMs/
	 MPHlopgJN2nT05hr31iLyV9jrrnp6W1qafTtAu08lM0EIZlVJ6Ek16gJNdGEVaOlLAPZy
	 PS71Rm5YSxJ8uDoXkrTv9BdQ1bNRWMgTwvznTBPxzGJJxaeFyhjf3V/sLiGq2Orib8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzGjzpie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76887606A31E
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzGjzpie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE851F000C1;
	Fri, 30 Oct 2026 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385050;
	bh=/IUyD51Xe0yKK+Ii63dUdk7neZ4Ync99LYBgAJGSZJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LzGjzpie6fI2A57hDlBjY2u5NAlLZpORqRtOVHk7rUKF3GKpTWkzm6p4jSqk8gPeM
	 BNInP+bWyX8XXU6oyCHH1aXA/P3yoZ1kc4fCvSFLCISmyylx4gORW35O2t3mVG/9+x
	 1rELHgVn/ByrwYlunREHXiFSBKUZxcQRTVdMf9urPCYYHstcTgXCH5hi46uGRPA0PX
	 MVvvtX6y6/NhYGmpQWwkJODQVCbsvFboHoyC9p+Y1ggGDODwiBZXj7aspF4O/0is61
	 DLd9OXZhW1ywkL1iYMLoscRWhAIHaRKxX00Erb5hRsHGx3qNn9w0eG98rbzeavt9mQ
	 eTjQlNIujTgVA==
Message-ID: <sashiko-outbox-191409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] samples: rust: add QEMU EDU sample driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lucas Costa" <2000.costalucas@gmail.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261030181540.102665-1-2000.costalucas@gmail.com>
References: <20261030181540.102665-1-2000.costalucas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:30:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rust: pci: clear_master() and disable_device() exposed on Sync Dev=
ice<Normal>
- [Medium] rust: sync: bad timeout conversion in wait_for_completion_timeou=
t()
--

commit 49001463072fd010a27e67166e414638fec06345
Author: Lucas Costa <2000.costalucas@gmail.com>

samples: rust: add QEMU EDU sample driver

This commit adds a Rust PCI sample driver for QEMU's educational ("edu")
device along with PCI teardown helpers and completion timeout support.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 3ec897709e890..810703d7a2fb5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -445,6 +445,20 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Disable bus-mastering for this device.
> +    #[inline]
> +    pub fn clear_master(&self) {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        unsafe { bindings::pci_clear_master(self.as_raw()) };
> +    }
> +
> +    /// Disable the device.
> +    #[inline]
> +    pub fn disable_device(&self) {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        unsafe { bindings::pci_disable_device(self.as_raw()) };
> +    }
>  }
> =20
>  impl<'a> Device<device::Core<'a>> {

[Severity: High]
Should clear_master() and disable_device() be restricted to
Device<device::Core<'_>> alongside enable_device_mem() and set_master()
rather than exposed on impl Device (Device<device::Normal>)?

Device<device::Normal> and Device<device::Bound> implement Sync under the
safety invariant that all methods on Device<device::Normal> are thread-safe,
and Device<device::Normal> implements AlwaysRefCounted so ARef<pci::Device>
can be shared across threads and outlive driver unbind:

rust/kernel/pci.rs:
    // SAFETY: `Device` can be shared among threads because all methods of =
`Device`
    // (i.e. `Device<Normal>) are thread safe.
    unsafe impl Sync for Device {}

However, pci_clear_master() (via __pci_set_master()) and
pci_disable_device() perform unsynchronized read-modify-write sequences on
PCI_COMMAND in configuration space and non-atomic writes to
dev->is_busmaster, which is a 1-bit C bitfield sharing a storage word with
msi_enabled, msix_enabled, block_cfg_access, is_managed, and state_saved in
struct pci_dev.

Furthermore, in samples/rust/rust_driver_edu.rs, SampleDriverData::drop()
calls self.pdev.clear_master() and self.pdev.disable_device():

samples/rust/rust_driver_edu.rs:
    impl Drop for SampleDriverData<'_> {
        fn drop(&mut self) {
            dev_dbg!(self.pdev, "Remove Rust QEMU EDU driver sample.\n");

            self.pdev.clear_master();
            self.pdev.disable_device();
        }
    }

During unbind, Registration::post_unbind_callback() drops SampleDriverData
in device_unbind_cleanup() only after pci_device_remove() has already
dropped the runtime PM reference and cleared pci_dev->driver and after
pci_dma_cleanup() has detached the IOMMU default domain. In addition,
SampleDriverData::drop() runs before its bar field (Bar0) is dropped, so
pci_disable_device() executes before Bar::drop() calls pci_iounmap() and
pci_release_region().

Would moving clear_master() and disable_device() to
impl Device<device::Core<'_>> and performing teardown in
pci::Driver::unbind() (or managing device enablement via devres) avoid both
the Sync soundness issue and the out-of-phase teardown?

[ ... ]

> diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion=
.rs
> index 35ff049ff0783..83a22d25b61dd 100644
> --- a/rust/kernel/sync/completion.rs
> +++ b/rust/kernel/sync/completion.rs
> @@ -111,4 +116,17 @@ pub fn wait_for_completion(&self) {
>          // SAFETY: `self.as_raw()` is a pointer to a valid `struct compl=
etion`.
>          unsafe { bindings::wait_for_completion(self.as_raw()) };
>      }
> +
> +    /// Wait for completion of a task, with a timeout.
> +    ///
> +    /// Returns `true` if the task completed before `timeout` elapsed, a=
nd `false` otherwise.
> +    pub fn wait_for_completion_timeout(&self, timeout: Delta) -> bool {
> +        let timeout =3D timeout.as_millis().clamp(0, u32::MAX as i64) as=
 u32;
> +        let jiffies =3D crate::time::msecs_to_jiffies(timeout);
> +
> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct compl=
etion`.
> +        let remaining =3D unsafe { bindings::wait_for_completion_timeout=
(self.as_raw(), jiffies) };
> +
> +        remaining !=3D 0
> +    }
>  }

[Severity: Medium]
Can this timeout conversion in Completion::wait_for_completion_timeout()
mishandle both sub-millisecond and large Delta values?

First, timeout.as_millis() truncates towards zero rather than rounding up
with timeout.as_millis_ceil(), so any positive Delta under 1 ms (such as
Delta::from_micros(500)) is converted to 0 jiffies and times out
immediately without sleeping if the completion is not already done.

Second, clamping the upper bound to u32::MAX passes values in
(i32::MAX as u32 + 1)..=3Du32::MAX to __msecs_to_jiffies(), which treats any
value where (int)m < 0 as a negative timeout and returns MAX_JIFFY_OFFSET
(an infinite timeout on 64-bit systems):

kernel/time/time.c:__msecs_to_jiffies()
    if ((int)m < 0)
        return MAX_JIFFY_OFFSET;
    return _msecs_to_jiffies(m);

Should this use timeout.as_millis_ceil().clamp(0, i32::MAX as i64) as u32
(and also be marked #[inline] like the other methods on Completion)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030181540.1026=
65-1-2000.costalucas@gmail.com?part=3D1
