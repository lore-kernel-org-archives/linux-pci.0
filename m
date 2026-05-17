Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB5194AE6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778978214; cv=none; b=bhXTQJ0m7dGYneZsqBQPhS42h2BFTsYk8EY6MvK+TQxVbZEvRz/DmUGWwcGW7GPdYpq7hxzQs99g4UxVkYTx5zl6tRmewwUzhl+I5kWo8EmJ+p8b63dJ6i3Q9tx9ofbR2IyhUwGCJKC05E+s5iWbfoTUpXzss9+g++EisYYNVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778978214; c=relaxed/simple;
	bh=P9fl85RrEDsBRrnNJjxhnFCDFMApq7oBYTsCyRUexr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a8vtI50DhDsDk1ZYUyubrHECFRg2fWHF0NlDmOEV4P+wpjbirUAE28hk/lXgoytJd9uzXLrjTYrastDUXVe0j+cRnMWY23fUilEw7ImUS7UQrIejPjpcFbn9YD9MGOQW+3JEXDLehrAkgaQW8OKFvyvHuzQzR+wo3yZcpqjf1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II2Hd+vU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II2Hd+vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADB1C19425;
	Sun, 17 May 2026 00:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778978214;
	bh=P9fl85RrEDsBRrnNJjxhnFCDFMApq7oBYTsCyRUexr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=II2Hd+vU/iE89caQCppeW/gaome1qyPZ0HazY/rmbtxNSCgzTw6wsbShW1WfsN4jV
	 7T9pUMkDgOdLxkvksIDarB/NR6VdOQYcC2HHGLRxXe4rpa7qNrRl7r4e5Lkfdis9gR
	 Kg67b448PiDLlh4fR8aTK1/yS8CJMtQn23M9h4YPTfekR6UXLL2ue/KH3yJKxXA3s/
	 N3cagD3QIBvu4mjtxJNRp9dX/DLyn5BZ+6uQKZcAf1nUiBH4JVPG9by69v6eeMFvra
	 3eoa2iD5+H5rFgN563taLLEUnLrnFpVBg+4T0n+nnj7eIyyQF+jh5jipNZksFOCt9h
	 hOBFZYHn2sbug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/27] rust: auxiliary: implement Sync for
 Device<Bound>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-8-dakr@kernel.org>
References: <20260517000149.3226762-8-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:36:53 +0000
Message-Id: <20260517003654.0ADB1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit implements `Sync` for `Device<device::Bound>` but omits =
the corresponding `Send` implementation.
--

commit 2db1931adb556a37661b5663fe290ef2d37425ff
Author: Danilo Krummrich <dakr@kernel.org>
rust: auxiliary: implement Sync for Device<Bound>

This commit implements the Sync trait for Device<Bound> in the auxiliary
bus abstraction. This allows drivers to safely store shared references to
the bound device in their private data.

> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs

[ ... ]

> @@ -369,6 +369,10 @@ unsafe impl Send for Device {}
>  // (i.e. `Device<Normal>) are thread safe.
>  unsafe impl Sync for Device {}
> =20
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct auxiliary_=
device` is the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

Should we also implement Send for Device<device::Bound>?

The commit message correctly notes that the Bound type-state marker is
zero-sized and does not alter the thread safety properties of the underlying
auxiliary_device struct. However, omitting the Send implementation creates
an API asymmetry compared to Device<Normal>.

Because ARef<T> requires T: Send + Sync for the reference-counted pointer
itself to be Send, the missing Send implementation prevents drivers from
safely sending an ARef<Device<Bound>> across threads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D7
