Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CF3BD643
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948224; cv=none; b=jQD1vjFt2lNKRx7y0Dy0wkmUXyQKOtScHzEgqyeit7EkZcDqLQyaGXCLSMesBR2O0nE5GkWKen3phqcdJWOHaCKOtSIrBot9y+aRFz6nY1WDdEHxH5RAA2leNlmnAO1k5Q+zRk0AoBJsgn0R0HDjbMMiVRKJHbhM2r4onIhquD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948224; c=relaxed/simple;
	bh=ohtVowNY5JGV13lGpspYB+kc0UZb2zKeEcsa5r2MCAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BBoHIluCBaydF4xdQvmcvi1cTwuWTt5EsBtF7kpyahF68vWwcuyKMQ71mhW6C6mxNuwkVgTc1KMKP05Uqu1S8IORsb7zfEkpObN+G1mSBEa6Wk7dgC5chEube5Syd4I3c3qMgDgU8xnItR8KJLgW0D3PPn6S6JfrtoB9v2Nwd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScZeyG5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScZeyG5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC421F00A3A;
	Wed,  5 Aug 2026 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948222;
	bh=ohtVowNY5JGV13lGpspYB+kc0UZb2zKeEcsa5r2MCAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScZeyG5Nw/v4SSlnRLhcglGqh80IG1XpikwDNQOlZ/3PLv0m+Yyebs8aW7me/5eJT
	 Kj7Z+IinW/cNuFVgs6WTlrmMbBBTbbZQkPbEnNXCVqCmjGaulX7FRMNDQ1t2YjICgP
	 9zBof1JkfG9d3tMw0t7c7RcvDufTflj/zxIAzDsfNbGsqFnzJe8urhDE3iA+p9K+Yb
	 D+PRCof902YnenXh6kmbaduY9om0A2m/PmMUHtOOFlJrsp1yB0Pu2mEdY3vHGk+rFh
	 nKuKDDoo1Tzx7R4Gz4PmXWpousmCDXOMAv1SxIY2TffKK/PaXzOBmEILxiSe5k7klv
	 k1XQ8y/Y9yNYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] rust: io: register: make register have a typed
 base
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-10-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-10-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:43:42 +0000
Message-Id: <20260805164342.5FC421F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D10

