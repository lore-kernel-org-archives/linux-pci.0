Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5232C08CF
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281811; cv=none; b=GGTYBllkSilwVAucidspQJX/pZy3x4v1TRdLs/Oirai7tLLf9PbPL43SO3NxQSAys5HHuhtHXGpKOPNr3IJwpmooKdSnlQFEYWgv2gsJ5J8WkGTKmTH0RFbrAgz+5elnDvYmN9j+B24lsLVCthhY9RURN0YPYe5eJj/ZmsxeftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281811; c=relaxed/simple;
	bh=P2tgRchgNNKwmf5RHpcgwD65FaP4xVUNk3aMBKwvNTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tFCh9kmgOqCGbRhatVnjKL4mrw70G+ao9RB4nEj2R1369dAZGS9ubB4CcThk9xW6H8DPosIcKtzaDqXmPp0kzr4/MprSeGMzs3qHN6NkfVpJtmRoGJMX4yt3f62wtHuBLyoWpskk1qu5/KQNcVS6UDjq9P3XAn0K5+DRvTrjJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImNtKedZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImNtKedZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D781F000E9;
	Tue,  1 Sep 2026 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281810;
	bh=i+hC59F/gkOdcy0T83rPtC4oxmdeqJwoY6Tt6VtMYKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImNtKedZdUXGf1m1uvIletHP6AVtL31SJMZq30ImuRnduEjKZmxTOhLNA/gbI3A8f
	 SASfb0KBvjCZqx6mKeigrjAUMmlAbsv8D+rYqMQOpyJPN4Ue2Ibm7Bc9zGNegReoIG
	 e/lmCpbR/FeaNol47/q22zWyvB7vss92bBLRS2PriZvL7dOxv0u3z/sHd5ZI7ShhZH
	 dR5yjH/YCdz7WjknBLKnTyS/zF75snFAgoAC9XBfJua9txnPyIC56+Ir+05ztnWKt3
	 utqVMj3sNngbjGDbChKdftDgeYDbqOTwdHHKTGElSPjqgyiFT4AmMpL2pz6JMJVTf9
	 WS3diwCc+1uRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/16] rust: io: register: reimplement as proc macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-1-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-1-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:56:49 +0000
Message-Id: <20260901165649.B2D781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The existing `register!` macro is implemented as a declarative macro.
> Reimplement it as proc macro instead, with no functional changes intended.
>=20
> The old implementation produces unhelpful diagnostics when things go wron=
g.
> For example, for code like
>=20
>     register! {
>         pub(crate) TESTREG(u32) {
>             31:0    data;
>         }
>     }
>=20
> which misses out the "@ offset" part of the specification, and the
> following error is produced:
>=20
> [ ... ]
>=20
> possible; declarative macro will reject this as `@` is not in the
> follow-set of "ty" metavariable kind.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D1

