Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC83F3285
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342183; cv=none; b=DAtmeL87fodCthMYPPg9ehrz8zFg28dZ3SQCTSXdFnsWW7xXlQCkTTwkR5Dla4FsVGRrozKFVlS9qgQO3M9UW1bdEckSLTEWby0XLzhGeNPY8XgznXElDrXtVa2Gmvqy+XCmDKUGEiXg0llrY7ku1amjzuibrssA09NdPMzOTOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342183; c=relaxed/simple;
	bh=AE0PmHDHTrdi2ViKlibXHZyR7xw5CCbECr2YYEbxzdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S/Weu3EqlhM+lFGQ7NHczR8oSNB4dT1BHP+zpGLnWz8j7HQm9wA6ZNAHQBkubiQRnRyO9z4NLV2UnG98B15sWIM5JpIGE8Mzr27M7R81Q6oUIDSZvOt4kqAl5UxhwFHksbGPEu+1FxlJKDo5A8NrAR2Si/p20WwTxw4SN1bYlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO/5kJpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO/5kJpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC701F000E9;
	Fri, 21 Aug 2026 19:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342181;
	bh=AE0PmHDHTrdi2ViKlibXHZyR7xw5CCbECr2YYEbxzdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LO/5kJpAHqNwptbLAoNKU/H88SbCF3UpErWsu1DREHmBsZAzHI8fuZ6eeREdaK6mj
	 egtXkZdPdncyx/R//x/RlMkVIKgAPPkJ/5P2JXtCp+IBjuNGhiRzg3IIg2ZMySy31+
	 0xutb55QYs61HNTaqk1V8tIx9vdDFjLlKQ5XbWm4rwP9tF7Cgl7vB6XN/WtnyMhpnq
	 VjjBlJzo+7MPqud+qWxda8I0CnbfW5NwP8kDHZ7R9phLo8342CThmAAx9YkhCSlpJr
	 XtSan5OJyEPpwJtG0/Ve32WqEWoqPsF/FePRw8H32uz6/IDmj1LBUH9ZCYviNeeAox
	 9L1Gvxar2b3cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/18] PCI/P2PDMA: Honor ACS egress control vectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-12-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-12-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:56:20 +0000
Message-Id: <20260821195621.3FC701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> An enabled Egress Control bit does not by itself redirect a peer Request.
> The result depends on the vector bit for the target port; a set bit witho=
ut
> Request Redirect is an ACS Violation, while a clear bit permits direct
> routing.
>=20
> Evaluate controls only at the path divergence: Request Redirect and Egress
> Control on the client-side port, and Completion Redirect on the
> provider-side port. Below it, traffic toward the other branch already
> routes upstream.
>=20
> Reject unreadable vectors and ACS Violations. Neither condition redirects
> the transaction upstream, so a host-bridge mapping cannot make the path
> usable.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D12

