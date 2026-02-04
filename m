Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E3426EA6;
	Wed,  4 Feb 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218438; cv=pass; b=WFv+VtQ9+rrZw72SnHhqftccnf2yuoHX5JRF6000IYaJW2aQr6XEqywQs3T10aFjt60R/xqQ1sunzW60MqLt3dbQHH9pLTI7oUWs9CQD7OMZPO6Cb9gdTGgj8rMd0nhZ2lOIn5/O+T8f30TP9nCZ28rXdlr1K4FdHZxzrjzGj0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218438; c=relaxed/simple;
	bh=xdQ7IEnWUm9frL9EWFAzHBsR40y0ym+5rVIYfbksmis=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cbwkfAmzkTO404//i+nxleO9sP9Y+1HvqwQE2k3zK/NWdhT2eGPZDD5/6zdvGoZXlPM0Pm0Nqqqhybhj773ZfQOEhday6l5uawMNdoXxfBk1c++xBOHs5ODxS699FL93pFVMuEkul13IUMlDdyp1PZwBDq96rw/U5YJmkD8klDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=f4VXM0AU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="f4VXM0AU"
ARC-Seal: i=1; a=rsa-sha256; t=1770218411; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LkL7v0DighD2mvfxFHzjF0UjtmnZ29u1sf5vELZq3wlp8Fd6za7FAy71XiFLHeqMVvKKYZKSdObKXsOvD7ZPbuqF0h7tjMkDQ1pRq5rQzCBnRF+ojlCBuzK/0WPdfzOnBqhHabQfhiRUM9yRFkbxeWwhYKg9EqclwOgvZ2TdwJE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770218411; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GMS2v19i2T6rYSBMcR/sXPSiFNzgoydVxzUY+ieFNbg=; 
	b=dxBeiYp7dLtRKc3R4ddguqax8EBFwSqmYCFhfKF09jF7hHVC6BtDhEPak0xnKK2ApZI3973Qr0LlgvPAXqe3iTP+EXsqp7ByXjuaN1vC8HKSRyI8LEoyrYirqfTorGrqBfyudQc6F0mq1c1502H0rOE0pYLsVGLSFdGlM5JQHBI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770218411;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=GMS2v19i2T6rYSBMcR/sXPSiFNzgoydVxzUY+ieFNbg=;
	b=f4VXM0AUI/fLoZVoCxt51LBEamHj9NHZ4nzVDaX0tv7YW4g5herm+Ea73DOQxzui
	yz4eszsEwkKqerD7uJiJkZ4nnrWVbmwj+vfhjZXhPQDRH6wFJu2GsPeSaqv2UvWAwmW
	Xe1atiP2k2tqShu5Z98Z0JcQQbKMl5/21Bc9xBgg=
Received: by mx.zohomail.com with SMTPS id 1770218408981350.9294090611644;
	Wed, 4 Feb 2026 07:20:08 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 4/6] rust: io: remove legacy relaxed accessors of Mmio
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260202-io-v1-4-9bb2177d23be@nvidia.com>
Date: Wed, 4 Feb 2026 12:19:52 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Zhi Wang <zhiw@nvidia.com>,
 Lyude Paul <lyude@redhat.com>,
 Eliot Courtney <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E5C2D1B-C876-4F73-A497-338128F38E59@collabora.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-4-9bb2177d23be@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 2 Feb 2026, at 05:13, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> The relaxed access functionality is now provided by the `RelaxedMmio`
> wrapper type, and we don't have any user of the legacy methods left.
> Remove them.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> rust/kernel/io.rs | 40 ----------------------------------------
> 1 file changed, 40 deletions(-)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index baa8d3baa20c..e1094a237ff7 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -660,46 +660,6 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> =
&Self {
>         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
>         unsafe { &*core::ptr::from_ref(raw).cast() }
>     }
> -
> -    define_read!(infallible, pub read8_relaxed, =
call_mmio_read(readb_relaxed) -> u8);
> -    define_read!(infallible, pub read16_relaxed, =
call_mmio_read(readw_relaxed) -> u16);
> -    define_read!(infallible, pub read32_relaxed, =
call_mmio_read(readl_relaxed) -> u32);
> -    define_read!(
> -        infallible,
> -        #[cfg(CONFIG_64BIT)]
> -        pub read64_relaxed,
> -        call_mmio_read(readq_relaxed) -> u64
> -    );
> -
> -    define_read!(fallible, pub try_read8_relaxed, =
call_mmio_read(readb_relaxed) -> u8);
> -    define_read!(fallible, pub try_read16_relaxed, =
call_mmio_read(readw_relaxed) -> u16);
> -    define_read!(fallible, pub try_read32_relaxed, =
call_mmio_read(readl_relaxed) -> u32);
> -    define_read!(
> -        fallible,
> -        #[cfg(CONFIG_64BIT)]
> -        pub try_read64_relaxed,
> -        call_mmio_read(readq_relaxed) -> u64
> -    );
> -
> -    define_write!(infallible, pub write8_relaxed, =
call_mmio_write(writeb_relaxed) <- u8);
> -    define_write!(infallible, pub write16_relaxed, =
call_mmio_write(writew_relaxed) <- u16);
> -    define_write!(infallible, pub write32_relaxed, =
call_mmio_write(writel_relaxed) <- u32);
> -    define_write!(
> -        infallible,
> -        #[cfg(CONFIG_64BIT)]
> -        pub write64_relaxed,
> -        call_mmio_write(writeq_relaxed) <- u64
> -    );
> -
> -    define_write!(fallible, pub try_write8_relaxed, =
call_mmio_write(writeb_relaxed) <- u8);
> -    define_write!(fallible, pub try_write16_relaxed, =
call_mmio_write(writew_relaxed) <- u16);
> -    define_write!(fallible, pub try_write32_relaxed, =
call_mmio_write(writel_relaxed) <- u32);
> -    define_write!(
> -        fallible,
> -        #[cfg(CONFIG_64BIT)]
> -        pub try_write64_relaxed,
> -        call_mmio_write(writeq_relaxed) <- u64
> -    );
> }
>=20
> /// [`Mmio`] wrapper using relaxed accessors.
>=20
> --=20
> 2.52.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

