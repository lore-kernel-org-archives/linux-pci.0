Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91606381AE4
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138463; cv=none; b=ApdvKKdae9nLHbQug7YY4d+qSzWiv2HkX1RgzCS/jX4HrTftsTpJiDJEZlZ8l2TjtF/x2eQM/FquLmFslTQcpLbFNBqYkoiTFYF9xmkRR0lNjA1lEjT/9hQZ86Ak84HCHmhCk7zdF3VFvFW2bteMzHcTVt2J9k7y0fsUL/P76m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138463; c=relaxed/simple;
	bh=5v9aCr6UOwTja2NOou3O3WvFffmOzimBJvCNoGx72V0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htfJraf1n9zZFa+aYsPQScPKrmuf9ovGgQojIr+hxCjLmYwNgLGa6ip/6iJIsSpkM5xThnuGEqVfP0HX8QzwuD1lrRord1Y5dKNdLJI0dRwa7kCKog5nEnvMs6ZCNFDz1twKidA0jLX15ColKylAIXnEcAAAF7D+ybZluPaSxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If+8TRl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If+8TRl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6921F000E9;
	Wed, 19 Aug 2026 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138462;
	bh=5v9aCr6UOwTja2NOou3O3WvFffmOzimBJvCNoGx72V0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=If+8TRl985wSroRRPlL9Uaip0CCxUlbGeyXyeIPVfvPPWusxs5GwiyT+0UzfNYDAv
	 GLJKC2TvAPOGijDelJ4xFwIAn1Y1yizUC6ZGcpRTfV6bAjv2QwDdqL8Wt7iBpf5DsD
	 NMqPqS6ErGDsE31/+47xE3/wGeJxOABb8yw/nDY5jBQhiZf/jvkjqW2OAikJTT6UUz
	 BWqcAjxeVI8plyxbpZKrUzyKcressLrKSY18TSgEMtcXLZ8HVnE9w2r+oqgSy0oeA1
	 HARMXE5J7mnbaUYcywTpsqmZLcinZthlDtVDsiU2XLsZlIC0itPxLbOCorZi0y9ElU
	 uhEBlvI4R3CbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260819-typed_register-v3-15-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-15-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:21:01 +0000
Message-Id: <20260819112101.DC6921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D15

