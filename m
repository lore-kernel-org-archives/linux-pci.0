Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D764519A7
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138303; cv=none; b=PV0Wr5udya8w1zFcdtUKWd+KAPcgGtLOw+ErcCjul99g7vKHFCgDL3ViG1hK37DlRRzawZRRqiI3Uxo4q3Of65cdzuG/QbE4UtVhRq0e/r06C9o6lp3znVq3Nfnj9uNYfWJNj13MWrAt5P9DU86/hCAT/hgTVwx3cvDqgZIvyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138303; c=relaxed/simple;
	bh=FYzAx3q1HTOKJoYBfb7xnuKvqbSKOS59WcJe5qPWUrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qQuNjSwaY3GPm7wn2P2KohoJlFoYihVucQFOyDn4pC2WOmturwf/T4FFqkDYLOjylNEkjJkZFdSa4nzSQI2sQUpq9mASnwRcCafBXjiRy7GjRipifgjeXprgC5umrYQpNYsK/dgt5ZeN6t+sD6SCimCKeAh5W7zLYJ6UhXN1VeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbIvVgYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbIvVgYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2123A1F000E9;
	Wed, 19 Aug 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138302;
	bh=FYzAx3q1HTOKJoYBfb7xnuKvqbSKOS59WcJe5qPWUrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fbIvVgYsaaAXFkJVkNck0HMMApPMsObNrrB/ATfTguqlyHsF9/LCeR1puSJxu5PhK
	 R8c2d0Ef4L/Bw0de4Xshi/e5oBRUsI7sHEwKv9CMWmBwA8WTsvSiKUBsoWwhPb3gj5
	 m6FQzsmYJw2IaqQ7F3pI5ETzE8HxmCXyJ1YRkSfH4Q9n95NXhxNHQwCIEFsls2T1l3
	 u45zmpjTjTHvu1SvUyEMgQaXlWFIU7AbguyKb1lDlL8yq6e1+tlAbZKprvPPM2+xii
	 68RYmmC6cj+HvANg3jrLOBp1bZ/HRLW0E+kobkSJsLopzr5/5CIeOLk8m5sDbxck61
	 aAVcXRVzNFOYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/16] rust: io: register: make register have a typed
 base
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:18:21 +0000
Message-Id: <20260819111822.2123A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>=20
> Also, add an `io_project!` example which is enabled by this change.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D10

