Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E03A8744
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475941; cv=none; b=c0S10BW+G2mxm0qYEkmgiNJeO/DCnSaV1y1bQmbjSBMufxMTexw5J4fs0OUeqXkxc/D3lSeIuEKqIn9ldHurfPR9Y5RciLjn8/d5qeKKYWc0H7rycoh40yFHUS3yvYjE4URCLxvcrMeMzkQC2699x2OW2KEeKmpQAYWPSn3sxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475941; c=relaxed/simple;
	bh=QGzvRWFNj8Zq6nOBFIr7spCk1Fu+OMmL9C4S4hZmiyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YonNk1H+Rp8Cwh5/FAjSdtxSeqoSA3PAUucofkU7/X0/8dacWbuvfOmBhcofgfYba+7j9PxrJgCnECRXWuDnLkT4/5z27PZepwILFtTr2us0Vnn9DAb3ML1MH2uC7ND64ORfgWPVpk9P1tM4AeD83sfJq7iDpx4cfdGQsFcCrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8MNPbGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8MNPbGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51A91F00A3A;
	Sun, 19 Jul 2026 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784475940;
	bh=bLFd178n8aQvGAtgSwU7+qThe56RuOjFYPH2TeKX7Xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8MNPbGvCkvJQZzl7Oq3eFibdm+uLAmsMjfBPopf0h6h5OfVNJ98/N3btawyNx4SW
	 Yk/lkidylw6S30EE0HPG0exwHU802123SjjRbVHnFMIGZsWBIYT9c1CxIdxep/QcRI
	 qGsm0CgFSMZyTLskcYO1tf+uJLdXLl64F6KYrEUaImeLrRPhyhTqrfOMnQdmLMivfE
	 7OoN/i3dMuZuyRTKsEuvXRYePCXQimN4RbyOrqweLNdv2DkrI6EhE6mXcZQ6Yq5xCY
	 hqhulLgSTxiWmAOEF8Z/11d2BKN7nnu23iUCUewRwkgxg/4j484xDbrTG8AqbIHPyx
	 px+g5oDbrtAPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rust: irq: make Registration compatible with
 lifetime-bound drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260719153631.559341-1-dakr@kernel.org>
References: <20260719153631.559341-1-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 15:45:39 +0000
Message-Id: <20260719154539.C51A91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
> (HRT) device driver architecture introduced in commit 2c7c65933600
> ("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
> device drivers"").
>=20
> With HRT, driver structs carry a lifetime parameter tied to the device
> binding scope, allowing device resources such as pci::Bar<'bar> to be
> held directly rather than through Devres indirection. However, the IRQ
> abstraction required Handler: Sync + 'static, preventing handlers from
> embedding lifetime-parameterized resources.
>=20
> Remove the 'static bound from Handler and ThreadedHandler and replace
> the Devres<RegistrationInner> indirection with direct request_irq() /
> free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
> stores the IrqRequest<'a>, which structurally ties it to the device
> [ ... ]
> every registration scoped to a driver binding through compile-time
> lifetime bounds.
>=20
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719153631.5593=
41-1-dakr@kernel.org?part=3D1

