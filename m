Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6143E48D;
	Thu, 22 Jan 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082216; cv=none; b=In2JTv3fo2cLyHDIY/Vd8yAe/iCG0arR6ayVMyAv5nZSpkfxBi3hnBxeZXR2KvQo6WfiDCyF4EWtkh97nnaBALHMF2eWOpsZ0iF8gMZDtTbbJFPjVjdsLB+DgZn4XChX14JtmWIgaDx39BZrDNAPEYm6LMGSoMGa5InubbHfxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082216; c=relaxed/simple;
	bh=CZr4ik0Nb2wjw1tkAfiGzajB32IXqucGhnVKa/SaMZM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZQhRVXpIIQtjnamT5HDVtrCRxf7vIruszGueEIvgjxix3MYZTLw5vsMA1jm4wVWKaE5ATt0w2UF6b8zMuvRXwe0gPzBrKUbKsCNaP83dZle0RG8QRMgHkWAu1UDy77IVijRySL/yFloQH1gR+/wFlUQy6+ZF7eYm+jh+hbg8iA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDDyLObM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDDyLObM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D0BC116C6;
	Thu, 22 Jan 2026 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769082215;
	bh=CZr4ik0Nb2wjw1tkAfiGzajB32IXqucGhnVKa/SaMZM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pDDyLObMLVJWrWm5+tqY7s3EVFV2SAqsEaQUpfaFheFmHbxvvjHVlWgiLQ/KYVlSn
	 SzrOSuzMvql2fSSQG7PU4fqo/h33ZPhK1mwkT7PHhFC0ii1LIUlE0sl0G/UNn9xiBi
	 91ZHM+MtBMFzgdjhV7tQ3w5kcQiEyDNtZT0iJRxCkLl6gHbk0aeeIp2oXMEYpWAJH3
	 SFdXPIL29bbF+6US7beBRM03+1lnergV5NPwV3pIsVkYd/2efH/BDZSuvhFUBSfQ+d
	 +/dQ+lYXz270pzeMIDS7iFoqUdZ6To+/J5lNbRODPg28G2Cq1daKVMj6gP0mgzREfX
	 j3YpqXGv94ikQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 12:43:27 +0100
Message-Id: <DFV3AYO352GC.1XSOQB0PG25GT@kernel.org>
Subject: Re: [PATCH v10 1/5] rust: devres: style for imports
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-2-zhiw@nvidia.com>
 <CANiq72kL9xwT-wdyGNpekmnXioUhwLjcayE_pkmKEEw+RDCyrg@mail.gmail.com>
 <20260121112929.5497b997.zhiw@nvidia.com>
 <CANiq72kz9a=Hx_tWLpSmmQ82MzO98V8-i+91qSutJvgKU+d-kQ@mail.gmail.com>
 <d0b6b17a-1521-4259-a1e1-3270af7f787f@nvidia.com>
In-Reply-To: <d0b6b17a-1521-4259-a1e1-3270af7f787f@nvidia.com>

On Thu Jan 22, 2026 at 3:24 AM CET, John Hubbard wrote:
> Yes, and in particular, there is a mini-trend to include everyone
> from scripts/get_maintainer.pl's output, as a Cc, even on v0 of a
> series, before any discussion. That can bloat the commit log really
> heavily, and people are mildly pushing back against it. I'm glad
> we aren't doing that here.

I think it depends on what you mean with "we". In the end it really depends=
 on
the particular subsystem.

For instance, MM tends to add Cc: tags when a patch is applied for everyone=
 that
patch was sent to before.

Whereas for the subsystems I (co-)maintain it would at least raise eyebrows=
 and
likely result in a kind request asking not to do it.

> Yes. But for smaller discussions, this is effectively a convenient way
> to implement your guideline below, without having to spend too much time
> mentally weighing "which of these replies is from a Real Stakeholder".
>
> So it's reasonable approximate guideline to use in many situations.
> In other words, "not quite systematically" seems about right.

I don't mind using Cc: tags in this paricular way, but it should be noted t=
hat
it shifts the semantics of those tags from "those people should really get =
a
chance to comment before this is merged" to "those people should get a chan=
ce to
follow-up given that they have been providing feedback on a previous versio=
n".
