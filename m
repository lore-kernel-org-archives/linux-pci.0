Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A68C1F;
	Sun, 21 Jun 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782043332; cv=none; b=Zfjcb41lrglnjO8AEL8OLWxIRS5hmMIvSNFTF5zVXWXHZ5xCal4l6AAWfIt1NkgBzmdLaYJiKFV5f9oMNl1Nv+tKzGfvIWZYIcK/reL4Mp1F+vpzkDnk43hsCaBrvspKeGIuCrTdLXmxLdOpdlywEQwltyHMBDwt3OHyX7kh2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782043332; c=relaxed/simple;
	bh=kaC0PvbCmiG6Ywh2nibLeZaEMJBBNjvSg1NxaI9Vztg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Y+FK0fKFNWxbPODHZgY05+ZV6qmpm+yoleuVGTPLQsoQnwJo4PJXKN7VNkZ2IFw86JmV8ViZeFfdv6x0aDjH8VUl4nXgYfZoALhbvLUhFN6sH2VqnFiLIdPkd5UpLhtKBJoeO9cr6GEaAU1LNS5TRs/6C3pCUSbvTi51xKunXGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUifdo4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUifdo4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F141F000E9;
	Sun, 21 Jun 2026 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782043331;
	bh=kaC0PvbCmiG6Ywh2nibLeZaEMJBBNjvSg1NxaI9Vztg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=cUifdo4FZa7CNBExoWKnLcb8WDL+x9PctDdw3772mD2VCbv+wzqb0HAxaXNAAv3nV
	 wgECwMkcd7yEMprb3lz4puNMxU++5aG9M+QK3XBPRDQjZWxKBAHBGlYkyBg+K3NBtr
	 mWOLNWLOpSXX+Nzi/76aSq/X4m0otfLKU17V1ALonXOVfam/1K4YJMq+csmDah9RB9
	 YWKykhGUiNjBM3jN6Jcdo8sgMlALtxWjrA2vMGOVgy6ayjFRh90mLyAxw9rrxZvn0c
	 u1oN44sH4VXZtifc43MGzzLqR6ms6OMfcRPEpZ37sLVY3lSpwmKv0K3UzD+KCagkFY
	 5p9e4mk/7Ngqw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 14:02:06 +0200
Message-Id: <DJEPMYC7J6ZG.D0ODUD4YGFCT@kernel.org>
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Lyude
 Paul" <lyude@redhat.com>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Fiona
 Behrens" <me@kloenk.dev>
To: "Maurice Hieronymus" <mhi@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/4] rust: pci: add managed Device::enable_device()
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-2-6fd6684f2c14@mailbox.org>
 <20260620095401.11939-1-work@onurozkan.dev>
 <23297c85b12edcf0eafb183827e0db750620e6cb.camel@mailbox.org>
In-Reply-To: <23297c85b12edcf0eafb183827e0db750620e6cb.camel@mailbox.org>

On Sun Jun 21, 2026 at 12:19 AM CEST, Maurice Hieronymus wrote:
> Isn't it confusing when we only have `enable_device_managed` and
> `enable_device_mem_unmanaged` but not `enable_device_unmanaged` and
> `enable_device_mem_managed`?

I think we only need enable_device_managed() and a enable_device() /
disable_device() pair.

enable_device_managed() should be preferred, the unmanaged functions may st=
ill
be used for runtime PM.

The existing enable_device_mem() should just be removed and nova-core shoul=
d use
enable_device_managed() in probe() instead.

If you are interested, feel free to create a small separate patch series ma=
king
those changes; you can stack this one on top of it.
