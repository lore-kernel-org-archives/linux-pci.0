Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB96286A9;
	Sun, 15 Mar 2026 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773536223; cv=none; b=TNWp3atuEbtAZQdVpnBSY0CCG/H2UuN6x3GrZruXuiZ51xdp3fCKixS0q3SUGL2fV8QJ+LWtXcHDPXpV25mxIn9YX/JgiDw20esh1f/9+xegeknODFdcpkesqWWwkT10pjseRWqsZPIQOFXxjF/qDHq7mYgoBtlo6JXFACz+ByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773536223; c=relaxed/simple;
	bh=i/BnzbuVzFzJxCHZNVxxZgr4hfknOfVB6loqPoj5NOo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=GY+Fn128y/tHLPdXOsJzRmGfTt6qg5gbIZ55lr3/PySUBDCjz+c8Cy5i5NZhDCN5OdNNUYebeI1ybHbKO9IxBxPhe6cZsOJoVf1DH0helQ6ZH8oeVSJ3uoayj5Uw3tzbRKc3Ybu7Ima4ycDqt+vG0t/4WvKqTUBcIk5NouNTIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms3r0nLU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms3r0nLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1B7C116C6;
	Sun, 15 Mar 2026 00:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773536223;
	bh=i/BnzbuVzFzJxCHZNVxxZgr4hfknOfVB6loqPoj5NOo=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ms3r0nLUewqMCfoDMNqsbXybV25i7V5+v4nzm/6KOnjmkY7jaR5ZQveYb24Lk+WnB
	 DpL3cLDQH6c61L+msi17gIh5hAPLYAZ9i4TC8/HWFiZHlTK2iLFfffG/DyWa1R5tWe
	 FMD4NE4OniyY2kd6ViF0JRLiLgYb8oe8Ea+8IzWWwoFUPgHMQAhRsaOPBEEebTs1Jg
	 zRMaDtf3B/o4cEC2BTIbbhVuVKcODrt6AYPrjWE/AqrPdjp29hE4PHqZbW5IchTmOr
	 k8J7auQCA/40u73dWt1pFLG9RmoI2g94o52kGL9o62JvcIpznVaAbygJ89RSfQr/bH
	 qH/I0d/hP2Edw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Mar 2026 01:56:57 +0100
Message-Id: <DH2Y4ARETP73.9I0ZYYM0VBDI@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/6] rust: io: turn IoCapable into a functional trait
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>

On Fri Feb 6, 2026 at 7:00 AM CET, Alexandre Courbot wrote:

I've now picked this up in the topic/io topic branch [1]; it will soon be m=
erged
into driver-core-next and drm-rust-next, thanks!

> Alexandre Courbot (6):
>       rust: io: turn IoCapable into a functional trait
>       rust: io: mem: use non-relaxed I/O ops in examples
>       rust: io: provide Mmio relaxed ops through a wrapper type

    [ Use kernel import style in examples. - Danilo ]

>       rust: io: remove legacy relaxed accessors of Mmio
>       rust: pci: io: remove overloaded Io methods of ConfigSpace
>       rust: io: remove overloaded Io methods of Mmio

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/log/?h=3Dtopic/io
