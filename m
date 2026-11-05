Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842540;
	b=HHXQTQYG3uSg5lDnzbdo3n+3FYwENLfqFreono29E/SLHi5hM0U1wWWkqZDakS1FhN5b
	 T63Z+CV0evEQDvNAI3Mw7MbTwTyCoO94QmT3YptAcZfwqV2A/bZ942U9ExLgp39f7Nw3i
	 S3yRXu3qLswSf2WNNLD7OI0mxIPqaLsvx3t2ta5grBuclTnLvOFbd2m4a2GSKm9WD1o1e
	 481fVQ4QutlvUh8ldwa8C9AHB1UAS3qJ1w5WR5ETBr2VGornzX8wmJSkp456TK4skNVkj
	 yra/eO4IcyKupTeRrAwsELY4EWVKP+0e2chPqM4nklX0f8hZZOyfSinyW0iBQ5uPRxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842540;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To;
	bh=KttBQIY3CoR0oa+wCZDATiCKgDh41PjVmh/fyWWpT0g=;
	b=KQv9f7f7z/ElPIeX8AoDMqf6uGLF3xiTH6K8nXTzvo7Z6s36/gfJdLWF9r07RVQ7BStv
	 K3CPCQrDS+3kel/xDedE7zB33R/N+FryOrJpuf5rbvOW0QWpOGnGzjF2e5SYc/kkSN6Uk
	 IDcJlV7PBpp1UEwp4Mk9T5LOIzXRK96Qyn7M3AYdJDo8KzynkUoKg9alCGNr3kFswkvBo
	 oda0Xtr2Li0Y4T5HA57aKmKrgSYuOkSX9/2jcg9jyruTNKEI7hdkbVkLMrEA0pvxeruDN
	 kCNj3RleF7j4IM6I2ue4cNXab24wZsDCoJp5vgIh8IcQSLuBqQlwbWQlwHItnr2TGGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AWgQ/GVF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D56606A31B;
	Thu,  5 Nov 2026 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWgQ/GVF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241DA1F00919;
	Thu,  5 Nov 2026 01:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793842540;
	bh=KttBQIY3CoR0oa+wCZDATiCKgDh41PjVmh/fyWWpT0g=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=AWgQ/GVF2EPfjjBRjUQl2TwhcDoTOHFhv4OThVqNUfe1HHJvlheooMr1GzMztQ1C8
	 bdDigN/E6YS0yyDelrJfaAIPa0JM11JKsCj8P4uSdsuxbHNF1qTouqAxgvw+zkM537
	 QgN/gxgocgD/u5ZKcmMrLh74pqTjPNGVyBCnsQ0njBfmVN7OfPe7ZVU0Gz5FRlAA1M
	 j3VMkH18Qu2YN5aWhNsHX4MBDUcZvl4D8c5OZ9Wfczmt2I7kKzud6TJLW4NxnmLipM
	 LmmSf0MPFpE9Ql48nCc4qVKSW2FQchsBokmjMO7ac2tdXGudifv5z+Bx4kyM44HXuY
	 hMeQ0Yhhy/GJw==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 02:35:29 +0100
Message-Id: <DMMW3TIIN8OI.3MZC03PWC1MRK@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 9/9] samples: rust: add Rust SR-IOV PF and VF driver
 samples
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-10-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-10-xinmengs@nvidia.com>

On Fri Oct 30, 2026 at 6:12 PM CET, Simon Song wrote:
> +# Follow the nova-core/nova-drm cross-crate rules in drivers/gpu/Makefil=
e.
> +# Export Rust symbols from the PF only if the VF actually references the=
m.

This seems overkill, please make it two separate files, but a single kernel
module. We can always make them separate kernel modules once we have the ne=
w
build system.
