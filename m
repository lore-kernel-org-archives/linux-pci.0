Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD4194AE6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977998; cv=none; b=Jzw3GFUtspqovmpwP9Vmn2xm5yMlWKRujZ3x100vXd/9DSI1iGDWWzcfa3174y/hiW8Yv3USuRAMc8/XecUb5R04ayKm+2BL9YczBYpKJ9HRUr16HrRNcrmPJc1smZLr9tXaLOvBg2bCFtZJhtSbcP5ltdrzuxq0ooiAy1kwefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977998; c=relaxed/simple;
	bh=mIQ1LrwKqJ022DCz7xjRc2JuhNFHec6SXgdffe0gH4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gMBi/AwgFkzXhDqjUYd678LX/TRnnALHPfNVvywUyPUaMKvREz1PWk4E59COu6R6MWA85NkLw8wHVyMaHklQc+uTGsFXWjJtzbS4ZZ3HWEeWDAwqRjPo/7wrtxB4m86JN5DfCzfB640ib9AwGM1YIdVMZtJECjU5kOjehcIRkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guOt/kfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guOt/kfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D060FC19425;
	Sun, 17 May 2026 00:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977998;
	bh=mIQ1LrwKqJ022DCz7xjRc2JuhNFHec6SXgdffe0gH4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=guOt/kfCZ7C8uFDYSkQPlAqNynixhl6smFZ1xGMulT9djpSbUb4q8fRIFhMG0cegL
	 6ZX2ZXZIGckH6F5pN/9inJoH+ERGQaVl+KmBA900r5KXGLKNVFcE6XPhAv4k16WQHk
	 d64raCxpxnyad3jHyYTuliKvtxRSNMGOzI1rJ0XKNZSs+Fbz+Fq4OWv2yb4gNzJC5H
	 nVGR2tCndiflWRgAd9BTqtL5Ll0oF6QKjzw39v12z1nhDMGfb/uf7flpLloQ5Z85c1
	 Dtm8I2mV46eekm24LVC6Q9mhG5FhMUYH0xem7TmRDOndoyZylFnvVldllpu77qWslc
	 1qQC2rbcl+UXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/27] rust: usb: implement Sync for Device<Bound>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-9-dakr@kernel.org>
References: <20260517000149.3226762-9-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:33:17 +0000
Message-Id: <20260517003317.D060FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch is unusable for its stated purpose because `usb::Device`=
 is private and cannot be obtained as a `<Bound>` instance.
- [High] Missing `Sync` implementation for `usb::Interface<device::Bound>`,=
 which is the type USB drivers actually bind to.
- [Medium] The patch omits the `Send` trait for `Device<device::Bound>` and=
 fails to use generic bounds for context markers.
--

commit 58da801d401502ae94fc21b502a93555301c6b9c
Author: Danilo Krummrich <dakr@kernel.org>

rust: usb: implement Sync for Device<Bound>

This commit implements the Sync trait for Device<Bound> to allow drivers to
store bound device references in their private data while maintaining thread
safety.

> rust: usb: implement Sync for Device<Bound>
>
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>
> Device<Bound> uses the same underlying struct usb_device as
> Device<Normal>; Bound is a zero-sized type-state marker that does not
> affect thread safety.
>
> This is needed for drivers to store &'bound usb::Device<Bound> in their
> private data while remaining Send.

Since drivers bind to a usb::Interface rather than a usb::Device, do they
actually need to store usb::Interface<device::Bound> instead? If so, it
appears Sync is not implemented for usb::Interface<device::Bound>, which
might leave driver data structures unable to be sent across threads.

Additionally, it looks like struct Device in rust/kernel/usb.rs is private
since it lacks the pub modifier. Because drivers reside outside the
kernel::usb module, are they able to name usb::Device as a field type?

Even if it were public, is there a way for drivers to obtain a Bound
instance? usb::Interface implements AsRef<Device>, but this returns a
reference to Device<Normal>, and there does not seem to be an as_bound()
method available.

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 794abe06f5bd7..995221d327b89 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -468,6 +468,10 @@ unsafe impl Send for Device {}
>  // allow any mutation through a shared reference.
>  unsafe impl Sync for Device {}
> =20
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct usb_device=
` is the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

Should Send also be implemented for Device<device::Bound>? Bound is a
zero-sized marker, and Device<Normal> implements both Send and Sync.

Would it be better to implement these thread-safety traits generically over
all context markers to avoid omissions? For example, implementing them for
Device<Ctx> where Ctx: device::DeviceContext.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D8
