Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878787;
	b=ZOsiZMarH/grGlghOYG4UWywY2M1z1g/Sl2FiA8SKHnC0UJsgHF2QjJitIcVd0x4FOAn
	 4YhuAhFOySNK8Gm9JCEs2aEwitCpSPPHHeosj7loIVPwa4DN5uDHhtLqf/OAwx1ZsTXzz
	 OUoq3+Nw5J1r0C0Z4PBVNG8snqcE4eXGyTuem6LoWtrzxkCTt1V+iEItEkU2TWwmBTPyw
	 XJ4gMB7xvszWqWXtHXd4TXHzzaB9Djj/YUdNaJtrrO0QqlxeFK5BxJQO3VGvD9oLRCt5E
	 9kteC3TjlXqvgNwYQ7jzWiwAHwBDvTp31iROReTzAD7VurGZsbUNnAweQZ6iMdEu3NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qBNgh5D8ZKPF+CU7E+mK17jgI7hGAMiEpc6sI8TScGk=;
	b=Elna99jbOOqcApZk8O/C4u9NHAdWsXMfNzGeDvhAX+wwm2AF7+sTsH2vlhQJ4ylP7J4l
	 JqDhs0sg4RFzalLjEVBw03F8XDS+U6YgAmp42ervjkfk5uvjSlvuUf7nWjhoVgdLaStrV
	 WVtzdxOPM4y7O0qPBPnchzFrYFGFqDBYOEXvyrvRnxxGXfjlwW47UxrrQ3ni1gtltMyLV
	 Wg57lztMfDx4bD7ZBxF2VEotDgMa0vq0GMrZjj/V6S+NSxtPJoQN6DXMCBjb7iV99LGnX
	 75XYAneZ/s6W4ysdl+Pzpye8fN1iiBC0Ha0BrFYqbhvrtFe4mk9yrs2U6MO0qae2QTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fc2FGLbL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE6606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fc2FGLbL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0941F000C1;
	Thu,  5 Nov 2026 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878786;
	bh=qBNgh5D8ZKPF+CU7E+mK17jgI7hGAMiEpc6sI8TScGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fc2FGLbLX8443S6sfkAPBzjoTt2zswakOJ6Rfp4HmUdAi1nlZi8VDeFgvSx8ypn+4
	 fRkIHf9J9+mQdVkAO1tNauPbq5ket7IRIizdd3ga4mkxJvNdJGHGELOKxGQTdqP4ds
	 Dld2twlBdUh8m9CNi1Xc/u4AnWwEHLYLNS4nswFEvIhraSLiKQ9BFyfmAV1Q4o6KZI
	 HhGXCoOSajSlJrBfqRjAgUYDCHsPXzxHNGdFSTjj4goabCgCj4mKNG9uhnyvZe3hjH
	 Tz2HOCq5i7M7tAtAnhI9HYlV9n+AwoVa2FQjS1XOmMe0V9hQ4uyKvvXUImE63vX8GQ
	 IjCKR1CZZfpMw==
Message-ID: <sashiko-outbox-198963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: pci: apple,pcie: Add compatibles for
 M3 SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-apple-m3-pcie-v1-2-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
 <20261105-apple-m3-pcie-v1-2-e00a72a604f8@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:39:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCIe controller on Apple M3, M3 Pro, Max and Ultra SoCs are
> compatible with the one on M2 Pro and Max. Add their per SoC compatibles
> "apple,t8122-pcie" (M3), "apple,t6030-pcie" (M3 Pro) and
> "apple,t6031-pcie" (M3 Max/Ultra) to the bindings.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-apple-m3-p=
cie-v1-0-e00a72a604f8@jannau.net?part=3D2

