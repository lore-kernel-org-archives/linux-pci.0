Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380863;
	b=uKmLg9u9yIUXci6T2AFTvgnetZRr5WtdxhBGn2UQ8A/4kadRR8SEHqq3PGBNFOWyXaxV
	 T8iSgGAQEd8zNhneeInEH66lz+zeisPhIXMHL636bVUpifRyfDm+GFZzqz44dqX5k5G4y
	 5nYACJ6+FyYM7JP7aDCBK/XlfsVxKHXa2DzP2Cr0eXZLI7Ch/Yc7LfPr+MIFzy9hLH74p
	 X2peSFzuX1VN0LhaNewuzvMo8iJGc2MiDhxg7e5uS9oXpcxRydvXoyD7SN2d5NI2dkiD/
	 9VvENU71MYWNaMOx+8uOOCtrMH7vfDabbwlCCdw9Lb91q10gEcokMVjxG6sivS6Tk/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ffqIt+vlxR3qCmeJYyJcXrTpPgwHFiS9VNH/c+hjcM=;
	b=w72vKNMscBY0sgxjx46LY+Lp7SGxCRaNxFHrXGCQuLoU3zmZ9SmKeuJkDnpakjN+IRFd
	 TLB+bX+7wOZ2HMcOl0ti+KD1NcMVxxSRdIyEJ5T40eFpUmklVB5n5OIQkrQXKrRol/ax9
	 fdm8sLeQX+r5E9JueED4EDioijQOfkTWpEc/wE1IswqRtfWoXolyN6Mz7of+CYe9EHW2v
	 KieSOd//ViVBu2dy7usQNqPMtfLkBMVmwTN8LSOaR14vRoFgtyDRvbjLV4mHuiQXtgcpi
	 St/dso6NTFNGA+ALLLftnLbIcYnLnenCG0w/WRgn4dDxJwi12tQ3K5GgI0kFUpil6Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjVC0lGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F4606A31C
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjVC0lGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AF81F000C1;
	Fri, 30 Oct 2026 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380862;
	bh=3ffqIt+vlxR3qCmeJYyJcXrTpPgwHFiS9VNH/c+hjcM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JjVC0lGUAGaZauKuP9O6wbvmyRZrhDoQbNbtUEiSrWC0fw7tK4m4ZAq3oPMJhc5QR
	 dZXZ+T9CtaLc7y0I9TPhquB+7mLIN8Q61ZdjgKXhOkeCPaNxS0aCxNiq/LoYjAA2E6
	 pMjPkg4pmoXuPiS2VUS1jo/XxK+g+iiaOqQXnNlQxOTsXflkrnj53WSDEabkKDvRH0
	 3RUIMBfOcKcySP8D5rjenJhLAvs6Vtl0p/aasjg4V0ntDoqXBTil1hn49Dbeo6qLni
	 KiRv6eGArrjWfnGkXZtOBarpD5e1GHc1HkCYyrmJbX8QsgTYvXa64eD7RARsZYV0qM
	 Gx7JXtbldRrHg==
Message-ID: <sashiko-outbox-191324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] rust: pci: add num_vf(), to return number of VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-5-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-5-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:21:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Add a method to return the number of Virtual Functions (VF) enabled for
> a Physical Function (PF).
>=20
> Expose the query in the PCI core callback context and return u16,
> matching the type of the VF count stored by the PCI core.
>=20
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D4

