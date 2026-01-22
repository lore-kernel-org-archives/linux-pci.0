Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2935EDBA;
	Thu, 22 Jan 2026 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086357; cv=none; b=rheynuBSjsfAzBt2/kqMjqF+6F+TovTpfIvK9V8o/THnHr3XpnCF2rH5Y6GLF69bGDMS7KGWIIK4aglR+j11fiLKCem32XE+OMnUdDwpvya1c5tgA0J6dGMb59+1epjzG3b3zyWwATZNwFmZAscCAAJJ551FHbFhPp3dJZf7sck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086357; c=relaxed/simple;
	bh=JHyfsLNz6xHNu6YUkIGqk67NfobRT5uwjtCGqEc7p3M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=firx1vn8799zri9CAWLCT3smGqqY4WyAfo8yokeBxUPoZMwBLhOe5Fo7x4PPJfvfyN87/W1Dcjp7wMbmGKXD/CkEJuZyQ94QKdakDxAsfB6/JhFzCDWas+YNoyrPG4JEIWxCO7pA3Je0JAxP+iX2l01T3Fcr75+rpVtoahfL6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlrFLAIl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlrFLAIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA0DC116C6;
	Thu, 22 Jan 2026 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769086357;
	bh=JHyfsLNz6xHNu6YUkIGqk67NfobRT5uwjtCGqEc7p3M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=TlrFLAIlSVw3ZIIWin45aHzlxJ1QN6JunYK2iLRD1FRx/Z7XTjYB8Bot8Wtl2p1+5
	 bpFn9jOKwy2XrWNA9iGI/PjBenJ9IHNlJcGVKIrjRyxrYQUUjnCDme/zML29bpq1c6
	 fxmUt/+JgGMqzVWKg2Oh0wF6J+NKmj84LrJX0/xX7tpUyvXTK7ZYKLDSmvHnld+ko7
	 GdR/j6jl77ypFDCnY0NZ6aUxPO3nNzO4vRIQfKXCcNPqKEpLMgACOv0I5kfzBxz3kW
	 WjCufu97ubNNCOPa4iinXRf2z9afcrbyRH8Sq26tKM5oQrv5iukx2VCIT7uhPF6fJ1
	 6LZbMGERWrNkw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 13:52:29 +0100
Message-Id: <DFV4RTLGQU1C.1FNHL8AC2DW2L@kernel.org>
Subject: Re: [PATCH v12 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>,
 <ukleinek@kernel.org>, <m.wilczynski@samsung.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-3-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-3-zhiw@nvidia.com>

(Cc: Uwe, Michal)

On Wed Jan 21, 2026 at 9:22 PM CET, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct. This coupling prevent=
ed
> reusing the I/O helpers for other backends, such as PCI configuration
> space.
>
> Establish a clean separation between the I/O interface and concrete
> backends by separating generic I/O helpers from MMIO implementation.
>
> Introduce a new trait hierarchy to handle different access capabilities:
>
> - IoCapable<T>: A marker trait indicating that a backend supports I/O
>   operations of a certain type (u8, u16, u32, or u64).
>
> - Io trait: Defines fallible (try_read8, try_write8, etc.) and infallibil=
e
>   (read8, write8, etc.) I/O methods with runtime bounds checking and
>   compile-time bounds checking.
>
> - IoKnownSize trait: The marker trait for types support infallible I/O
>   methods.
>
> Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> implements the Io traits. Rename IoRaw to MmioRaw and update consumers to
> use the new types.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/drm/tyr/regs.rs            |   1 +
>  drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
>  drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
>  drivers/gpu/nova-core/vbios.rs         |   1 +
>  drivers/pwm/pwm_th1520.rs              |   5 +-
>  rust/kernel/devres.rs                  |  19 +-
>  rust/kernel/io.rs                      | 398 ++++++++++++++++++++-----
>  rust/kernel/io/mem.rs                  |  16 +-
>  rust/kernel/io/poll.rs                 |  16 +-
>  rust/kernel/pci/io.rs                  |  12 +-
>  samples/rust/rust_driver_pci.rs        |   1 +
>  11 files changed, 433 insertions(+), 131 deletions(-)

<snip>

> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index e3b7e77356fc..616ca398b2c5 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -26,7 +26,10 @@
>      clk::Clk,
>      device::{Bound, Core, Device},
>      devres,
> -    io::mem::IoMem,
> +    io::{
> +        mem::IoMem,
> +        Io, //
> +    },
>      of, platform,
>      prelude::*,
>      pwm, time,
