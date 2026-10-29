Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286192;
	b=BupzHIezaB3AFjyjRhgezHd2/07X36lJhnT02b8TRoiBmkPy6MdrRl0v3LttuweqkmCi
	 BWntnZu4oqV8QbO2mKuyxqlEekWB3Ji41uFYl3L9ouXAWJu89w5oTqMTcNExVKUDWS3KV
	 1ByDZ1wS3mN6ctzRC5ygssxgqDSMKyUviEh2LK/HLw7iqAuNozIw2gsY617kpLFdX3c0E
	 Rh8rOr94OgU2q1mmO8FMiQH1mF9G2C4Vus99IW6d5IqB3HqjiWOQJUV1fb7MtmArNA3pP
	 JG5L912fl4vlFeH/YaNSljBxNSmlTJMRCtL/KypGyvmpmJw+oW/LkhR5V/YbDjTn1WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aaXyOe+fbwsFPyK1K2XfQ3TmVp/gwbxES3aCC9/Ukto=;
	b=U2FL2VI8XLKSujbSoN5HIp/SOZLETBneObLLee6DSQYJOnw3VhH6br7E9R/twl3u850A
	 1zIXRqzR+zwFNw4h7LU8aij1qFfjDEGS5cLJthHnBqNqjAbD6kJLvlbv21PSIA7TCFrJV
	 jielm8wox5y4I+tEYQqvxjTXqb22MrG03FRRCcv0LZtmb1aNijQTdYzllUAnNWP/46Po8
	 0nKYtI2u9cQiL2hFMXnYV4f42XLNim5KxV95vyGuiZvoBU62lziWgnWv9KpwfGUm7MXL9
	 nNa1BDH+nbwA9ANg9wWjYvZkhoQKLgn4wgPtNy0uIk2Dsw/3PaASxNUa6XR6w8trl0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2SshpJ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BF606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2SshpJ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9881F01825;
	Thu, 29 Oct 2026 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286192;
	bh=aaXyOe+fbwsFPyK1K2XfQ3TmVp/gwbxES3aCC9/Ukto=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=j2SshpJ0xB5K8dPSUkkx5/ODhhkkqLYZFJAni3gIzTDDp4UTtIhomhBiJSxrx9nib
	 UqG7NnUUQI4uVp2Qd7UcvEroD7O8c5o6dhYs8yk+xW7iy/x/oQ93izZgSdX/++nQLU
	 HVGxeJowARrCSrsqSJGgYJ/MkA9anudgLuhxq7xqyP0zwr6svVs5wJw0dEZKfob9WF
	 YHoG0EzJnQV+m3dfvXlGSMqcDF2Oo/m0sbCbomA8RJjXB14TelitvEDkZ8fZNfghju
	 laq2YbFEFFUie4uNFmfYpzs8/OGxV3mJcsLdVwCCFK1kHf9A4LbQ+aMWDYQ4agA4W8
	 qGfN484sf7Nhg==
Message-ID: <sashiko-outbox-189568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 03/18] cxl: Move decoder declarations to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-4-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:03:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the common decoder declarations to include/cxl/cxl.h for use by
> shared decoder settings. Preserve their layout and documentation.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D3

