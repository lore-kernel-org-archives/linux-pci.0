Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618148;
	b=jjRelhLMriKJaiwBDBoQJC+WPt10J7XsbIKE3iOfZQifr5yNYN48GIlxDxovsdG627UR
	 Qz6wXNw8BXNIpbAeMpj6jBVJcdWszjB7Om9W/Bk8atKXB1nZxki6e2HWbfs9s3lh8VVSS
	 KY+IF9JFJZfb+47+HpL19xj+o+ypTB004fIa0KxUMyuFJ9tSeVP7kAfa8UnKUB+ZGGzj8
	 sF4jtX2Cnww1cbRumvfWFgim/LphspwlZVv8rPfGuKaPfapN92UP8EkCeiPlqpV++uXRN
	 YH6NzdHqbEbw0nKJgp4jKYx/+vUaNoNG7N/FBPdDv93bBUSyGzuf8GQQ9HVXvu7XgMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uo84sI5aiwYIf2cL886kiGk0zL+qJ/eBlG171Klmp8M=;
	b=VB4Lqnlyfk2xE/62nm99tOml4/kMzjhhu59GdD3Fz/s0wnbBc/eKs4r1BnsiVyS5sf8B
	 0R3Ed+d8gA9SzjRcDJvw6+xuKQAFPbDUN7tbwfNyiczf5eK9U6eh/njlf+XiVMMxAAx8e
	 3if1iQ0z5p3f8OGNu8ztxFlQlGivdhwdZIR93QLDsox3qwyc5bnWwY3h9DJhPMByH4VpK
	 SFdV8fzfPa+krfJi9K9jwaaeLJMNEZc/6g/9pF9dsHfK9ClSKSVQg4BSm26Jh/AVUA8WM
	 NC4W/5tkOYmlWN96KkoVOvFlNWllU2xf2vioOAhfvxBlfKMIxZogCW1MFFPWoBTY9iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmvBfOZK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE652606A33F
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmvBfOZK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF661F000C4;
	Sat, 14 Nov 2026 01:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618148;
	bh=uo84sI5aiwYIf2cL886kiGk0zL+qJ/eBlG171Klmp8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmvBfOZKvr3Jfi3ZIcQ3wGAeHQsy4LkKUqbIhK4B+BTURjC51BvlPpnZCjJj8Kawp
	 XZSMHIevXtoa4mGJk7B6WOlaFoZSpSzfJHmGjpWmhB778u+99+4h3EYL/xitNrmnUP
	 +u/Jd16d/82dF21FHvi2Sc5bAKPxSTiS1FCqj186xmH3TCYCqWrAvWdVNX/VsPduVu
	 NCRVxAlD9cSpLmFEpP+ulgX7Nah8Zx9FyDTEczeFNPpYjO2G3THQ/5pCpnEAxWtuLR
	 jlFwnaMyM8iEkLZVWZIY6fvHygVg4yKUUKcsZQmqCLZuMioQqN0t0XhA4Qxw72QA5Z
	 syQF79y+vVCJw==
Message-ID: <sashiko-outbox-213974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 2/3] arm64: Allow synchronous abort fixups for
 guarded MMIO reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113-rfc-b4-v2-2-d6b14f95c1d6@boondocker.io>
References: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
 <20261113-rfc-b4-v2-2-d6b14f95c1d6@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:02:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Matt Thompson <matt@boondocker.io>
>=20
> An RK3399 PCI configuration read can raise a synchronous external data
> abort if it does not get a usable response. Allow an explicitly annotated
> MMIO load to return an error in this case.
>=20
> Match only a current-EL synchronous external abort on a read instruction
> with the new exception table type. Keep existing handling for other
> faults, including asynchronous SError and translation table walk aborts.
>=20
> Signed-off-by: Matt Thompson <matt@boondocker.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rfc-b4-v2-=
0-d6b14f95c1d6@boondocker.io?part=3D2

