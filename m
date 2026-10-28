Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157444;
	b=z1R0bfcoNPa167RtEjSe/hE40prAMiVuUT9E5QjFahlCU84NARFyqAHYu7MNhy9yj/V5
	 cx+QXEEzvw8RtCZ7fsPSTNfA9+h3yMkkFv2SWp4cKN6GeSdqP544LDja0ktpe2Vfs68c1
	 XSn5L/9kYY38kiEI5vdC9MVKs48G1+cQYD0lh7pvFeetzHvdOVIwaUEUHYfTDYTJMmmN0
	 y+H7v8JCOihBtOj6tcDuYVtNdSxMO4BIJHDL7C88Bu5V7Jo4RwXsG7NB6bLmuA8azk3eu
	 PjlO+dpGgI3bYKUWhuHGjmjdMU8vF46JvMKGWIDrJZfb/xLECidwBb5mqWwHlzx46wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157444;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+fcOXmbPR9EeKWNLUpD/cl4BvhA2ZrqERZTWtUrcZRQ=;
	b=mnG+YgcegaSq4DT43iZPnbkFJXYv8QtunytEq7JzgSom0PZtz5dIz9ntT+h8A8awORXO
	 FaF9vmQVCZtNNNSrTTSQIaCqPTy+cvh4cdpMCD/NngEHYBe2EdmKyJ6OKvnNdL+0U+rBl
	 sygeTOVp5iVE7AdB5RHJwAIBKeZss3KocLXAIka61ss+wmDQOt29/LQMCGaGqJIA31g+i
	 7GA6gWEwUQnkMSD6mtZALP85v2pGwq+AJ+AcG89XeUJ5bbwzRmUtoqhLLkyjB6fMWTc0+
	 wBKPaet1tQiypg0yHi5UM0uxY4RUkTD96MD3+N4hkBXH7WV49/lSHs/5SJ8Y++3DhwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYetPVIB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38050606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYetPVIB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE82D1F01828;
	Wed, 28 Oct 2026 03:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157443;
	bh=+fcOXmbPR9EeKWNLUpD/cl4BvhA2ZrqERZTWtUrcZRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYetPVIBR9BQP8zo8PxfYUOA2FgbTS8fr5Fl+I0ITQ0SYpHmGLle103yre3Zl4TtF
	 VMRoLJfxON0u80+ezFs3ahszwoO1T5bACPoM5W5gV2aVgghrTi2608MLQ0jHQZ2Ltf
	 9idvEi6Jqg1DY188x1BYhGYkXzxQvOf6oK+uWHUp5wwjB7MMawL2b7o5DcNmUmAZdN
	 18ox5UA7imD7s7Ko7P4dOFXS2JxjNqy6eiP0Ta9yCG1UCTCb5oI0Jz12Or0Tm1T2Ns
	 S2y9iLQlnw3lNroyjfn7zjgMuqLjeD3JMEl2KRSHiUE/p9Ds9a4Y67MOUPNooA7y4G
	 3llF+Ads7VHsA==
Message-ID: <sashiko-outbox-187409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/16] PCI: dwc: spacemit-k1: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-14-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-14-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:17:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> k1_pcie_disable_aspm_l1() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap().
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D13

