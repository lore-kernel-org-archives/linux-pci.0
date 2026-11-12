Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448074;
	b=V0OhKOw0OqgOc/3O7t/28nn5KXx9nOE7O8FflQR3/I5t3l51E8SCh24mJr2Wk8K3tQV+
	 aDZlbyHfWDGbX2JoKMLT57SBnrVn9W9cHwWwWs+6PBQ4v8eqWkjm23Tz7mUJgYO/MlnRk
	 /Kej5v81rZv/EXjrqcagwnwvqjnIqo4mqHwjg2+YM78NMbUofNapLXVEnwR8Il/5pbJec
	 CGaRuUInaXfGc02KoZPStJ6ySTR1pTT2b1d9BOWJdpvWr7mSeY4IrdoWCzqpDprxdlUG+
	 YU4PgAc7PmP/AUuh/gq5DLMgl1++JRdYhwzVQvCNGbzxlv4ITQXYZOdxaY1ZL4PygdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p5n7ewt6sUsyIn8Vt7iEbtT2eE2+PKwMHmyfddh20ww=;
	b=NQ+veTctp2iJ++8ZKSYx0J+GvA1myor0XanUY0g7rAHBIe8CN0yAsojtEKvUuORs2MET
	 Twv/nPcjKHgAar0MB4vlBOR1Ab7b/PQx919WyH0rYIo5hz9ghkK0Hca9wE85Q+LIdM+Li
	 5c1tvS0SrK1x4aAWSS0cnkkd0z258qTPpoFj57GXyQ35bnLYJD7heqHlmfeKMtwJ/vwuR
	 zKd9k2lp5oWEmMCHdrs59x5+PMR3rX7wHnJ2mBuOmjJYOhtFOGADOmj6KPH8UqkV/SlQn
	 W77cN39FqQiwKcYqlnZOz0NuriGsUfLmlcbNbVKOgnPrp2tGe7KJricpYCjiT53riPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iQ5ad/Rw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81940606A31C;
	Thu, 12 Nov 2026 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQ5ad/Rw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2551F00A05;
	Thu, 12 Nov 2026 01:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448074;
	bh=p5n7ewt6sUsyIn8Vt7iEbtT2eE2+PKwMHmyfddh20ww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQ5ad/RwiUnFncOL6/f+YtzHHw18K7dYBAQfKzba8jDy9gTLPPQi1f+vATCqVMkUt
	 BadSu3BCEZ7M5onp55N05CUy4Vm0XXvyRV0P5dTiKpDRJH7sX/3kg1uRS8nmaEU4rS
	 PyE4s53qmr0pPSW0m7smL/wyKaIJ8O6+CbU0sYYvdELh/onTVIgDGgSrmsz/Af3J8z
	 ETwemIF6tBszwQAfFsV4cgqD3ha/hhV+b65V5v+MgRTMGdTu9SfgU+pHxmLCeWPObH
	 QyL9oTT+1FpfqurJSE6I5PDSLkK+yTtdwDyTSmms7JF8CMxpzLEFBf2VbkEcMGCkP0
	 TWpE+eIQBJx1Q==
Message-ID: <sashiko-outbox-210094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] rust: serdev: remove the unbind() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261112005455.1224352-5-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <20261112005455.1224352-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:47:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] rust: serdev: null pointer dereference in
  receive_buf_callback() [1]
--

commit 957ca5c83392506736074a2417dcd46b9e299666
Author: Danilo Krummrich <dakr@kernel.org>

rust: serdev: remove the unbind() callback

This commit removes the serdev::Driver::unbind() callback and the
corresponding adapter remove_callback(), documenting that device teardown
belongs in Drop or PinnedDrop.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..fd998b68b74f3 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
[ ... ]
> @@ -210,29 +209,6 @@ extern "C" fn probe_callback(sdev: *mut bindings::se=
rdev_device) -> kernel::ffi:
>          })
>      }
> =20
> -    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
> -        // SAFETY: The serial device bus only ever calls the remove call=
back with a valid pointer
> -        // to a `struct serdev_device`.
> -        //
> -        // INVARIANT: `sdev` is valid for the duration of `remove_callba=
ck()`.
> -        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> -
> -        // SAFETY: `remove_callback` is only ever called after a success=
ful call to
> -        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> -        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> -        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> -
> -        // SAFETY: No one has exclusive access to `private_data.driver`.
> -        let data =3D unsafe { &*private_data.driver.get() };
> -        // SAFETY:
> -        // - `private_data.driver` is pinned.
> -        // - `remove_callback` is only ever called after a successful ca=
ll to `probe_callback`,
> -        //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> -        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> -
> -        T::unbind(sdev, data_pinned);
> -    }
> -
>      extern "C" fn receive_buf_callback(
>          sdev: *mut bindings::serdev_device,
>          buf: *const u8,

[Severity: High]
This problem wasn't introduced by this patch, but can receive_buf_callback()
trigger a NULL pointer dereference [1] if T::probe() fails after the
serdev device has been opened?

In probe_callback(), the error-path ScopeGuard calls drvdata_obtain(), which
clears the device's drvdata pointer to NULL before dropping PrivateData and
calling serdev_device_close():

CPU0                                CPU1
probe_callback()
  serdev_device_open()
  T::probe() fails
  ScopeGuard::drop()
    drvdata_obtain() // sets NULL
                                    receive_buf_callback()
                                      drvdata_borrow() <-- NULL deref
    PrivateData::drop()
      serdev_device_close()

rust/kernel/serdev.rs:probe_callback() {
    ...
            let private_data =3D ScopeGuard::new_with_data(private_data, |_=
| {
                // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_=
, T>>() });
            });
    ...
}

rust/kernel/serdev.rs:receive_buf_callback() {
    ...
        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Privat=
eData<'_, T>>() };
    ...
}

If a serial RX interrupt arrives between drvdata_obtain() and
serdev_device_close(), receive_buf_callback() dereferences the NULL drvdata
pointer.

[1] https://sashiko.dev/#/bug/linux-790dcb6c-6485-4b14-be30-8851e99a0542

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112005455.1224=
352-1-dakr@kernel.org?part=3D4
