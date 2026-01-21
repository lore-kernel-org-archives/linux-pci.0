Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AFC314A95;
	Wed, 21 Jan 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005548; cv=none; b=e98/Za0gZHW3gMJvSeKyhxlBWcrdEhW1CWHG8Qcc+vb7C61gPsXsr8UoTvtHeDqq3rQg2c0arOrFoX7/UyOy3RsO3RceMtCHanc0e+o9kQvArWLbjDOnjwYzlwFyNwMHYugxGwsONQP0Tqyp/3ijYjBPIb6Onz8T+f6frTemGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005548; c=relaxed/simple;
	bh=s5Nq0HAlrnKoaor/1oHLA1vK4fWOkQ1SjbQ6I3l0cyk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LXl5Bwe4ma7AMDusW4Tr1OwUvfvSumDJUz9jVe8O5b7HU8jmes3BgdtWBx+YDmFNUHV9OvjgaSiDvk8JHudc7mYzCmtr9uSUHeoTuUd8x8d53K46Nlyu4gQGPiWFRkktrMXAWPtoM5wjhNrjFk6QFFYyB6ov2gG93KJglrKO4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4HsMv9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4HsMv9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7A1C4CEF1;
	Wed, 21 Jan 2026 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769005547;
	bh=s5Nq0HAlrnKoaor/1oHLA1vK4fWOkQ1SjbQ6I3l0cyk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b4HsMv9O0EvOCNATle6LFoEC78iyH8OaqENt8aLoJLwfdTwe/epL3WU5fVo1xg8kx
	 Cy3KgUJ4TMpKzwZSPfJV3kqniJYEko52CQEJg+EneNYxdWX2HgexsAS8ZrwQgy0bk0
	 JaTGYDYRLpx6XJFFPO4YLyyt1R8qkDseralI4f/Jpn6nEHrns47i4XcJSj/xJaQk6L
	 syREeoPVWE3/ky9FKidFOwvmekSIIK0rS7MNWL6bu8xx5UOEwZ0qDHkwg1Czy2kU/e
	 JEewIsq5kEfyColJEuPDTKlWuk+pyX09dTIVAEyf5Mq3X6wIvMU3OXQXR2OlgbcdO4
	 GNiu8/pCGXHUQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 15:25:42 +0100
Message-Id: <DFUC4N7OZ43Z.XFIJ7M0P2TM5@kernel.org>
Subject: Re: [PATCH 1/4] rust: device: support `dev_printk` on all devices
Cc: "Gary Guo" <gary@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260120181152.3640314-1-gary@kernel.org>
 <DFTN9F5OGCBS.2CRNLWNC60971@kernel.org>
 <DFUBAXCDIF1H.2R3004ZHIZPOE@garyguo.net>
In-Reply-To: <DFUBAXCDIF1H.2R3004ZHIZPOE@garyguo.net>

On Wed Jan 21, 2026 at 2:46 PM CET, Gary Guo wrote:
> I converted them as they're the users that benefit from this behaviour in=
 the
> kernel crate (i.e. "convert the users"). Do you want them separate so you=
 can
> take it via a different tree?

No it eventually goes through the same tree, but in general patches should =
be
split up per subsystem / component / driver if possible.

For instance, the split should go as follows:

1. DMA
  - samples/rust/rust_dma.rs

2. DRIVER CORE
  - samples/rust/rust_driver_auxiliary.rs
  - samples/rust/rust_driver_faux.rs
  - samples/rust/rust_driver_platform.rs

3. PCI
  - rust/kernel/pci.rs
  - samples/rust/rust_driver_pci.rs

4. I2C
  - samples/rust/rust_driver_i2c.rs
  - samples/rust/rust_i2c_client.rs
