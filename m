Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562885;
	b=C1BHx66ADVrJlwHELEKINV+9MV6Va+0Cp93U4OqIMenXd9/lAv9xrmwCXPKRa793Lw80
	 NQyIxwV+1NJOMBhzL67tPxfnPJYfV1gW5uLjvvzb//oyQopXdY5aJI9s2jEHUg8h6PLEK
	 6N88UaKso5dVj/v4tTlMARN0w9jHAxh4PYEDP0ahKaDRE1JnS+l+4nQec6cRMpQ3E1XSR
	 J8uYvpGABIANqjceEXXNv3Lw8LP8puuG8rTXUxYRvU8UEj8wp/LgbvNrEl2YmRlF0SMZy
	 Cq3iBHZD02e0OygNWkqVsWfWQBxjq5GcCR126xchToWEr3trDKB+umGLmHj3Y7Awv4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562885;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e08IKl8cuBBIsRhTefRMXH9yyrlJ5903Bm6C16lOTgw=;
	b=4hQYwTC3V9G5+aeDy40dWLokI1x0ab8JYBfoOxrrXWxJYzMDMspaf4ABSsxFiQMcqGB4
	 1sTThN/m5TQXU90I5esIio4Qm6zGhbwWn7jyBWASXTHRv14vZsYnTiLSTl9bhmDIPumMg
	 /t9Q6naITspptTr0xS8qh4KrPX69d/isy2C7zPyG1zEDnBIcRSS/QUSJHuZ2xkJqaJbIX
	 NknbcbYo9uSNCeEqskbg+7AqoX+Tw6QzutPn7Tva9eSKkCrl67rOz+Xx0W4gUdMchfFoL
	 Zns0At++Hha5YU6/3LHrx/1lyYvcmOAifk6SHFBtP2dtw9DnY7bzB3701UpJ/gmQbJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opC0cO78;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82171606A323;
	Tue, 24 Nov 2026 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opC0cO78
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA681F000CF;
	Tue, 24 Nov 2026 23:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795562885;
	bh=e08IKl8cuBBIsRhTefRMXH9yyrlJ5903Bm6C16lOTgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opC0cO78hR5M0GxIiFgeUlDOJYGAjpNo00je0ZS+32Tw1bHsTDC9+VWYDnI5bTUdG
	 x82rcEJqjVFBrR/gavYI+bdes2Z8LWb3g/BZIxIH5fiVpz7ch/RgLaJtAwSyJqUVou
	 ExcKrbpD4jnVjVGUCT6HAVN4RlFIT3ZTyC913Qhxm10dK+zoycDp1bcd1829W0QJHJ
	 D7bmKf8SgFo3y7XNzHjI8ECLIjRB+VqJUFbvJfur4L78QQ4YsYmfeETI+W+fKSSHnH
	 wqC8DIZZ86ctR2jYGQZzYZOrjzu3i36kR/5uYo9nv9B5pToBUz5Vz4aa/viSThR0yL
	 cQOMWZqx3o6Lw==
From: Danilo Krummrich <dakr@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] rust: pci: add a prerequisite for the r000 GSP firmware
Date: Wed, 25 Nov 2026 00:27:57 +0100
Message-ID: <20261124232757.2443082-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111200549.160806-1-jhubbard@nvidia.com>
References: <20261111200549.160806-1-jhubbard@nvidia.com>
X-Patch-Reply: applied
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 12:05:48 -0800, John Hubbard wrote:
> [PATCH v2 0/1] rust: pci: add a prerequisite for the r000 GSP firmware

Applied, thanks!

  Branch: topic/pci-sriov-7.5-rc1
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: pci: add domain_nr() accessor
      commit: 002b9422b314

      [ Move domain_nr() to Device<Bound>, since pci_domain_nr() may access
        host controller data through bus->sysdata. References to the PCI
        device and bus do not necessarily keep that data alive after host
        controller removal. The bound context guarantees the required
        lifetime. - Danilo ]

The patch is in the topic/pci-sriov-7.5-rc1 topic branch and will be merged into
the corresponding target branch soon.
