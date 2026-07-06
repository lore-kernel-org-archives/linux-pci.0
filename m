Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA2420868
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342732; cv=none; b=q4flahqPwmCFUE9OJf1XVZSY7PPj94lV0CcKBcK0Jrih4Q4o6nKzQpxmMTGiC3695K4REDR230Meqt8branjvYt+8gj+5hFriv7gZbDgMRpgKdxB5NuRCYXPVayVtfkV1asuTk7r/WgirFq6udDp64azOLD1zBh6av8LdRSfLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342732; c=relaxed/simple;
	bh=e9YcVi8TzkKb/NF51WCy2xs+cIuvDfI9ZQOmvym0bUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=igjFu52wd6gLGGNGgXnRX9jyggcjK0/UVOs/7EBJ+hHgLsNCeq6ifOR0scmfflyb+0BCkzU5qP5ed1pPFjV+mXVIItwiSP8sQZZuC/bP8TLtLgYah/7LJTrf9PPXJgZiDJMz3Kq1bFkw+exwMntSZxJWatrjwVOqN28aA71/Ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV6cEu7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV6cEu7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67351F000E9;
	Mon,  6 Jul 2026 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342731;
	bh=e9YcVi8TzkKb/NF51WCy2xs+cIuvDfI9ZQOmvym0bUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jV6cEu7yDR+99WD6NxEF/oU0uIMeuexwAVCPOviBjG9JhP84owRuy5w8jTYIlD3Un
	 0+asuca7goZp3cs/4uN40iOxYA0W17rBuWMHDkMzYYNMFwYMCIVRXlQCtQ1cto5Tiv
	 WlG6zWMvc66c3IVWN4RZEi1BjhWrbSnF4ICmaMnxuFbce+M213uiAZ0YGhKX0+ibRP
	 m03nhRwBkVihp8Rbu2jYCKeXb+d5f2A2NHmB84ezrRBsUxbec5UYLd7hkChGH8k6Qg
	 /L0LGvL1EhJIcgrJ/l4VV48C2fAwUWQYHJwKN+Tyw8haH8c2lB6RqL6IPx7x2vk8T5
	 uRa0jBE8qsGLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/20] rust: io: add projection macro and methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-13-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-13-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:58:50 +0000
Message-Id: <20260706125850.E67351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an `io_project!()` macro to allow projection from `Io` to a subview of
> it, using the pointer projection mechanism to perform compile-time checks.
>=20
> For cases where type-casting is required, the `try_cast()` function may be
> used where the size and alignment checks are performed at runtime.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D13

