Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71D52269A
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068610; cv=none; b=FcWTvgxhntbFPsdCdco1Izf7IL5YGGcUBhMHrZmjePaRjEFx/fz+OMRPiNE9vePEA3nSlOQPk7JXVyO03HFu9Q528yS9SLk8jtSO2MQWxc69/djH24w5fULsgKEzDd3BoFcBV/6JXvU+Nkl/njWnhLDraevh802J5Lsz2NuONEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068610; c=relaxed/simple;
	bh=4HgEVinMBYY0j5VWtJFAAtKyM4yzeyWsHSd57Bvlh2s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=j96Er+S+Ep16gyGjbXwp6P6dqVFsMuyR4peSHcnGvvSTGriRHJx37r0gG5k58GezVR1DEMOMS20QrwroXnctak9bgWTcO1kJEWkfb9kEtS3KtRnR2Cq/WT1sbeQETISAekZbtnwZiO52gjfClyZGjnV08V7VjqILLkeOicFumKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBwImnoS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBwImnoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8326F1F000C4;
	Thu, 15 Oct 2026 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068609;
	bh=4HgEVinMBYY0j5VWtJFAAtKyM4yzeyWsHSd57Bvlh2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KBwImnoSSEBjvdF2q5VM2nA/WVGSCGRR+h7eAj8eN7CRpaFISiiBYKGxwgZbHsU0A
	 ResXmqJtE2ib9+RTTtI2e1eLEYpnSzlaZbY75fZMAC4AYQNLhpBhZbnrnz3v9zl7xT
	 h9yQgKoEIWLUJ7TPe11NjA8buqING5BfHZ2vw7DxBCbqhFWkmS5KthziLc0S3ZcrVM
	 5bgEGPNCQ5U+8QB5/ZzIevaA4Eb3ng5E5iF5SBYsul+QR9Bgi2KnpXkUZYNN1ZBNPc
	 hez2+MOOymxCLYZypJCt00QXDQZFoGxAH6Zf7YFyR4AvOUGueKE7X0kV4LjL0CTsAf
	 k4fP9DpFAFAyg==
Message-ID: <sashiko-outbox-172869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] rust: io: let I/O locations carry an access mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015-io-access-modes-v1-5-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-5-93611b84b5e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:50:09 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Io::read`, `Io::write`, `Io::update` and their fallible variants
> project the view to the given `IoLoc` and access it there. A location
> has no say in which accesses are allowed, so a register cannot be
> declared read-only or write-only.
>=20
> Add the `io::access` module with the `Mode` trait and the `ReadWrite`,
> `ReadOnly` and `WriteOnly` modes, and add an `Access` associated type to
> `IoLoc`. Projecting through a location applies its mode: `ReadWrite`
> leaves the view as it is, while `ReadOnly` and `WriteOnly` wrap it in the
> `ReadOnly` and `WriteOnly` views. The bounds of the generic accessors now
> apply to the backend of the restricted view, so a write to a read-only
> location, or a read from a write-only one, does not compile.
>=20
> Raw offsets are `ReadWrite`. `OffsetLoc` takes the mode as a type
> parameter that defaults to `ReadWrite`, and `RegisterArray` gets an
> `Access` type, which `register!` sets to `ReadWrite` for now.
>=20
> No existing location changes its mode, so there is no functional change.
> A following patch lets `register!` declare read-only and write-only
> registers.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-io-access-=
modes-v1-0-93611b84b5e3@collabora.com?part=3D5

