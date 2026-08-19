Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6384432EC
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138231; cv=none; b=XFCl3H45FxN8uHtmp5oJ9U2DKgG37jVtjcSt9Izc8l2rrDC0fYefzXF9Evt6D0gw2sxzdEbqtgUlqP9daOpz03H1s0iJBCM95Q6GgImLgdtVd7ZR/NKO/zo3AceAJ4y8/0rl8tT4RXLzMesa0eXrhQoEriu8kzsodFy7wgv827U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138231; c=relaxed/simple;
	bh=fhamI47DjOVMmSx/5k34N5XYPsQYnZNXFMijhumIo0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JNfAlu6FYiGc0slwSX+X6sDnGDMaXsUoWT936AKFnfQXIaXV/C/0AMKLfgxvBiT2IbnmkVAqIx4gcjNmJPN4HQzH3hIZVHFHy0vefLHryYOjhjEk+haHRlab02ZK7MGkc9feXwzuIvQKN/dkoJ+dq+n6O76ptQTGqCcSwBcaZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH+DX5RW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH+DX5RW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A4C1F000E9;
	Wed, 19 Aug 2026 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138230;
	bh=fhamI47DjOVMmSx/5k34N5XYPsQYnZNXFMijhumIo0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nH+DX5RWEj7qkMJRLhfgmikrweoAnGAIsYzho0V8iQxUZTwXDfjuw0KmeUKsrBarP
	 xOHWEGcV+JvJ7I4V377t/OVDeCMMPfcFUp52Iv9eopH4FD6ZMesgS5C7R3UMAAof/z
	 K5mr1gBl338HVjZL2jfdxGGvDEza0gFCTx1mnVyp0khcE1L3ZZ9foZrHL71PXguTM6
	 YYVOltK1GcwAK0NzsTsYe387912aObxs6aUvirwA2kDuk1UtAKkYaMnLHd3uJT/S8D
	 0hfJ/mZNXGFy/0PVXJ5ZtiJtIhUUTnQlrTApqhTFbbR7RNrnx4/8lvwYp/JDtlXTSh
	 cy/x5X/XEZihA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] rust: io: register: support fixed offset
 register without bitfield
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-11-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-11-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:17:09 +0000
Message-Id: <20260819111709.F2A4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a rule to allow creating `IoLoc` in `register!()` using an existing
> type and not create a bitfield. Add an example to demonstrate this for FI=
FO
> registers.
>=20
> This rule is also going to be used to create subregions for registers; the
> example of doing so will be added later when relative registers are
> removed.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D11

