Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6003A89D7;
	Thu, 22 Jan 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117532; cv=none; b=AHFD5k05HcNIzQd6ffFKfJHv7UfcDfl64o5GAU8uopdbgFMGx4rx5QGQHOY9y4OoZI2WC5eOyEf7gGSlXcRqtwjCJxpDtz3k1ziBsl8pS3E3Rqks3oz2rnBeJJqYWNGqlOuGoxLBwVNilan4/XrxQ15ufxeCGhohYgAcXjzNf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117532; c=relaxed/simple;
	bh=1PDNyXAIynEOO+eic1VjYIz8RbSq0HPkr5SAsLsuc90=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=tlbTJwoA+MCKvScMc43UnIOjo9gclKSHDRxlt2YpUVDVI4icUrk5NrlbuxpoZA8DjjZeSVEstQgtMKbi+Kju6akDksBHsIakIPCEBGWs+fGMe/oexusz6nmJwITo+QpYuP/peHmKfop7CcNigotLMrYv6ugfFYIDxGXaK6TaLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR3Kv19x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR3Kv19x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59AFC116C6;
	Thu, 22 Jan 2026 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769117531;
	bh=1PDNyXAIynEOO+eic1VjYIz8RbSq0HPkr5SAsLsuc90=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=NR3Kv19x8Z6z2qTprUD87A1L9gPpiCixpTx6139cRYAUTlB7mWLVM4nL5iIcd0aXK
	 NAurF9sQEeHNocPoEEoYiyxtwn8qhf3Mz//Ye/TiVio7Z/kr7mhM+vMV5y5T+DF4R7
	 xRPdLF2eGR8m0qTMQS+DzGb/VVVFQqkQtTemqS1Q9GkLPOCEizkSjRq8lay3ZMONi4
	 eg4X3VmH4ulL3pFJL+AJ4Thfz/Tinxi1hAdofSMY3gt7i+zgI+NmNT0Rrn6eMKmJu3
	 FEWR/0S9akJOxyyLW7RMxOfE0EH0D66DWBrvISHNg6dB+T6oABIa+ce5SeC1+Y1Hg+
	 eFdm3t3Hl6VLQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 22:32:03 +0100
Message-Id: <DFVFTMRD9LM8.HGKSL57RYD1D@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/2] rust: introduce abstractions for fwctl
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, "Jason Gunthorpe"
 <jgg@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
In-Reply-To: <20260122204232.15988-1-zhiw@nvidia.com>

(Cc: Jason)

Looks like you used the recipient list of another patch series by accident.=
 :)

On Thu Jan 22, 2026 at 9:42 PM CET, Zhi Wang wrote:
> In the NVIDIA vGPU RFC [1], the vGPU type blobs must be provided to the G=
SP
> before userspace can enumerate available vGPU types and create vGPU
> instances. The original design relied on the firmware loading interface,
> but fwctl is a more natural fit for this use case, as it is designed for
> uploading configuration or firmware data required before the device becom=
es
> operational.
>
> This patch introduces a Rust abstraction over the fwctl subsystem,
> providing safe and idiomatic bindings.
>
> The new `fwctl` module allows Rust drivers to integrate with the existing
> C-side fwctl core through a typed trait interface. It provides:
>
>   - `Operations` trait =E2=80=94 defines driver-specific operations such =
as
>     `open_uctx()`, `close_uctx()`, `info()`, and `fw_rpc()`. =20
>     Each Rust driver implements this trait to describe its own per-FD
>     user-context behavior and RPC handling.
>
>   - `UserCtx<T>` =E2=80=94 a generic wrapper around `struct fwctl_uctx`
>     embedding driver-specific context data, providing safe conversion
>     from raw C pointers and access to the parent device.
>
>   - `Registration<T>` =E2=80=94 safe registration and automatic unregistr=
ation
>     of `struct fwctl_device` objects using the kernel's device model.
>
>   - `VTable<T>` =E2=80=94 a static vtable bridging C callbacks and Rust
>     trait methods, ensuring type safety across the FFI boundary.
>
> `rust/kernel/lib.rs` is updated to conditionally include this module
> under `CONFIG_FWCTL`.
>
> The repo with the patches can be found at [2].
>
> v2:
>
> - Don't open fwctl_put(). Add a rust helper. (Jason/Danilo)
> - Wrap Registration with Devres to guarantee proper lifetime management.
>   (Jason/Danilo)
> - Rename FwctlOps to Operations, FwctlUserCtx to UserCtx, FwctlDevice to
>   Device. (Danilo)
> - Use fwctl::DeviceType enum instead of raw u32 for DEVICE_TYPE. (Danilo)
> - Change fwctl_uctx field in UserCtx to Opaque<bindings::fwctl_uctx> and
>   make it private. (Danilo)
> - Provide Deref and DerefMut implementations for UserCtx::uctx. (Danilo)
> - Add UserCtx::parent_device_from_raw() to simplify parent device access.
> - Use cast() and cast_mut() instead of manual pointer casts. (Danilo)
> - Implement AlwaysRefCounted for Device and use ARef<Device> in
>   Registration. (Danilo)
> - Add rust_helper_fwctl_get() for reference counting.
> - Improve safety comments for slice::from_raw_parts_mut() in
>   fw_rpc_callback. (Danilo)
> - Convert imports to vertical style.
> - Fix all clippy warnings.
>
> v1:
>
> - Initial submission introducing fwctl Rust abstractions.
>
> [1] https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/
> [2] https://github.com/zhiwang-nvidia/driver-core/tree/fwctl-rust-abstrac=
tion-v2
>
> Zhi Wang (2):
>   rust: introduce abstractions for fwctl
>   samples: rust: fwctl: add sample code for fwctl
>
>  drivers/fwctl/Kconfig             |  12 +
>  include/uapi/fwctl/fwctl.h        |   1 +
>  rust/bindings/bindings_helper.h   |   1 +
>  rust/helpers/fwctl.c              |  17 ++
>  rust/helpers/helpers.c            |   3 +-
>  rust/kernel/fwctl.rs              | 456 ++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs                |   2 +
>  samples/rust/Kconfig              |  11 +
>  samples/rust/Makefile             |   1 +
>  samples/rust/rust_driver_fwctl.rs | 136 +++++++++
>  10 files changed, 639 insertions(+), 1 deletion(-)
>  create mode 100644 rust/helpers/fwctl.c
>  create mode 100644 rust/kernel/fwctl.rs
>  create mode 100644 samples/rust/rust_driver_fwctl.rs
>
> --=20
> 2.51.0

