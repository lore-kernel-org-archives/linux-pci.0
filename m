Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116492;
	b=jep76O8FI7Bldy4MhlT9EQDPdkEpojfbpDOPTqlAuR9fzUkBs6sIXm4INKRLGr7m9EWj
	 yAzRPdt5JaA0MZ/cXqlqzZXAO1P41nf4hB+tLk4dnl0PUBYLAoConrzmTy5sZfUHZFrAz
	 dIBPqyb+IZDHbvvixFKApNbFMzfPjeE8nRIiF/nLLG7IaeK9CIehDlxcTwRuoWeQBqUel
	 KM4Na80krQ21Pmj6BMOXezbANOC6SPb0Pj5z8U8pOcqio6jke8f6xB0M+t+cLYH5q3+Ps
	 7LcExo+g9Yq9cC3s0TzCV6cd3QdCyCruCClacyMfeJABuOJwnwXjafGr5WuQBIdc0IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gYaEuB6eFaNy74o2hl1uQqmVSujK7jtZvzzXSyAKYGA=;
	b=yx2twgt3kt8wzPk9RL8wU6qbGIywWMeINlJVs1zkqikDgD8jVKsqmIKnhcLI4xjFOjec
	 nxslkloH8a8twVOutEY8bi6YK3BBqH3Po2BcGmUylAtLa26O7XagJTkD/75mIy7+RajFz
	 /yNeZkxEqv8bhTKYgzhQ7tOHZPRjC3I+qtRbpFiEJrtzzSBfgfA6JrLiXCJ8Y23fsY9+I
	 x9dGcR6Z6rSPCXxxI9RC3Com0mHGkhd8YJJGwTcSCCJS0mqJrTMzKqKowEfXPHojqYT4o
	 XPkC/3/3hxxUWb5zU4HE/26AmLGTZSE/NtK8TWbUd3V5vx/el72ZaJU77ppNV20ZzEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPRx57mb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78014606A324
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPRx57mb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A7A1F000C6;
	Thu, 19 Nov 2026 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116492;
	bh=gYaEuB6eFaNy74o2hl1uQqmVSujK7jtZvzzXSyAKYGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPRx57mb2h/XIe7CqB6u29aqsjmUdSHRivSkGJvuiVZw2FYs4GYG++tJYIOwvQcCL
	 l0NFsyjBsMGj1K6rffV0sbQWh+thOeUr1t0eYAKJ8DjDsWTf5GveZn3MWHlm1kGXL5
	 QTa7Xccc3z+qohHZvx8EWCkhCU3W3hpZWz0ZSGRbhZ/ncJudX+rJHEJeeOZmttThsM
	 Ipff0LAvOL9GdDCG2ReZG+HmoIdWdyJ15U1Qjhq9eSYiNsWM1p9tZOT1RMaLLEovLY
	 rSBFZTl9N0iJC7gWjvEjaNMm7hhVPXU+i2YzWtEhb14SLxXfJbRWF2dOimCx8qafEf
	 +IpyKAcDuPFfQ==
Message-ID: <sashiko-outbox-223882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119-vfct-regression-v8-v8-2-12463194e457@amd.com>
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
 <20261119-vfct-regression-v8-v8-2-12463194e457@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:28:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present.
>=20
> Compare against the secondary bus number of the upstream bridge at
> FW/OS handoff, which the PCI core caches before any renumbering. Fall
> back to the current bus number for devices on a root bus, which is
> never renumbered.
>=20
> While here, return a bool from amdgpu_acpi_vfct_match() so callers
> read naturally.
>=20
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikza=
dch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft=
 filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-vfct-regre=
ssion-v8-v8-0-12463194e457@amd.com?part=3D2

