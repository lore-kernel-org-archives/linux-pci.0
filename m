Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFE2E5429
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277133; cv=none; b=XMBBW9bbKbRMyRpIP1TMlo06pmW0P8HUaDrtm7S8wuflFzUc4ORNJxW1MDBcoD+nwATf+OBdBdo0p49FH+gVWUfQ37nbBZv0SKqVkLCWwj3lM1u0c1xK7sL+rPZpKtmDwAlsT6t7Y11irLnnqV7ZSGuPOuGOKHAQlFc+a5mzku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277133; c=relaxed/simple;
	bh=y1iXl4UrPQt9mzXS9HlKeKdxvpDshKwGWKH5m+gh59k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2ftkt/H7fWmN0apqMY2O3OgqlAc6LbK0F9zjsEY+XUrvUGys2jCBcNStsyrRAKkg5qXxgbAjDHvRI5Aryk9ggr8tUnTI+G2v2kbdAzXlED3BgaW7zBXdwp+tYGelpFcoSlHItdECloHRz5BR1YfFnX6dwOpXL23AUqUGWs8iTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDjfaENU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDjfaENU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0A61F000FF;
	Thu, 24 Sep 2026 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277132;
	bh=y1iXl4UrPQt9mzXS9HlKeKdxvpDshKwGWKH5m+gh59k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDjfaENUVOgdiDpyKicYQjZfnMoab0AHlVQtcSQBfYOqvIxybnFJf3J4/CZL6thA3
	 YDEtOrc+6K5hgVXJtNMhz8O2PoH1KCTDqyldg7qvntDJHvh4WBxp9RCBrqdr0kdlMw
	 h5P9RRd6eaP+hqnmNrH4GSUm3OUd3MwiJGYcwZ3Z4M2K6g42rx0qPWcs+G3vkwUJEu
	 7lIhrTGNVfmx6iP7g6xc+9Qsn1mkwqBcI2qfngjYPWgTtTh9zw7aFNk72bg9QjqDsM
	 HN51Uo49Of7GzFxxv0gUKr0COgkqz/2QuKOgUPtMX+EndbLYWPA4ukjWu9Myo3V1kP
	 jft4shRZB8ZKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] rust: pci: add is_physfn(), to check for PFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260924190556.1620886-5-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-5-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:12:11 +0000
Message-Id: <20260924191211.AC0A61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <pcolberg@redhat.com>
>=20
> Add a method to check if a PCI device is a Physical Function (PF).
>=20
> zhiw: Keep this role check private to the PCI SR-IOV implementation
> instead of extending the public `Device` API. Add a dead-code
> expectation because this standalone API commit has no in-tree caller.
>=20
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D4

