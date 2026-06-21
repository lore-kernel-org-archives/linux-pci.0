Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF81B3B19;
	Sun, 21 Jun 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782044835; cv=none; b=Gih9KXXySQBC6q5Hf6/W4iYDcvaKzZjYzNb7DWOF8YBU/8QJcjRRszqO5+UiqDGbE2yosQ10aDn6QTHFk8cFyCvZY+Af2YLfxDXWFO1ZDrD9s87K2GESMOw7Inhw+4QW2JUrc7D27pIR/Xb0snC2jT6Ix7JrRADfw8T6DpEjAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782044835; c=relaxed/simple;
	bh=/9SnQ/Fp9kosce0XBSjggLKUZKdfCnpD8Hf+WXG8myM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DExNfhVp7uUFoBKhtT/cf85CKQbK3Kgz16zGY0MxViaapCgjz7ldcZdDkdhX6H3A54Gt7k+TWwGpdgpfkJ7Cmhnu/wr/IIw4aj8RFTdh98lyJY0hGQ8w5+7S8l6o09QchakV7k/h0YzV5kLbsHupDEAJMun5m1UYRGcC61A7PYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZO8SdZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZO8SdZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD59D1F000E9;
	Sun, 21 Jun 2026 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782044834;
	bh=VAGKo9r3tS8aD9e7qFs1qqubzWfr0NLscXm6GgqBFDQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=OZO8SdZhpx9g2GjXyXJa6+pFn2Gz151th2PpBkvA/vHs/S64B6wq66b34oDgKL1Hc
	 +mPulZerwvW+ipFj7tXOwOa8PTpoF26RiTyLC/729Sr86Has8A9mL6ICFYZSDtNMDc
	 AWI0FGDu7f6+tbYWiXGtecDtCFfdK7ZL3Vm9PpO1clredFp9HeWw8L2v9XtevlmTQy
	 sk+oNjOpzOj45GXLhrsLhkGMOiW375mvNe4oU8/HkupvzC0uPorPQ5y96loXvqVtYw
	 BbMvvcN0kAzmN/fsPCnloE7JyzXthRvt5XJQC30Rk6ZQUqqkRz2ITJiwE9G/oCxDGg
	 ud5lg2dEXtprQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 14:27:09 +0200
Message-Id: <DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org>
Subject: Re: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Maurice Hieronymus" <mhi@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>

On Sat Jun 20, 2026 at 10:45 AM CEST, Maurice Hieronymus wrote:
> Add a Rust sample driver for the QEMU EDU device, wired up via a new
> SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.
>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

This is a good example, but it seems a bit redundant with the existing samp=
le
driver. So, I think this one should just replace the existing one. The only
thing that is not covered is PCI configuration space access, but that shoul=
d be
trivial to demonstrate in this sample too.

> +impl pci::Driver for EduDriver {
> +    type IdInfo =3D ();
> +    type Data<'bound> =3D Self;

Please make this a new type and take advantage of Rust native lifetimes for
device resources, just like the existing sample driver and nova-core does.

I understand that the existing IRQ infrastructure is a bit in the way and y=
ou
have to work around it.

I'm going to send a patch to make the irq::Registration compatible with the
device driver lifetime rework soon. Please rebase onto that once it's sent,=
 so
this sample can land as idiomatic as possible.
