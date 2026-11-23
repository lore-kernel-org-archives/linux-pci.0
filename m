Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461073;
	b=VQag5tZRNOl6/EMuqx8sFgw2KANxlqVdxc9grUfJWQYelY5BwlS1hUeQko16zaTBadbq
	 duEH1w2+XR2G1DfACH09Kl7dj4efjri8qk6S16/KgiKmawyGZe2WOVxRdRO9VkDhhHR0Z
	 c4MlRxnPfXEgYA/z5fZuksJgRdMvJkplom/9FfG46sjboSZ/PNg4gCbqT3xSmptuI0Z2m
	 oIilX2nrSrBIt0yALRjIjAcqez1uWX+AqJmERsZzANioL8Kt8ptLlnaqGlB9S5BVfwjUA
	 7kEo1avH8DCSnnkxt+26wwslz7QPWt1t/lfdWVwn+bKGTjPZEjWSXwlXIDrLz1P5N9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461073;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z7G6kPFxJpBrdvgM3QzZkyye3E1kSlCp8A6Dvejbtaw=;
	b=FA0UITQnjPB24QZgtruu1FDIwttz+mA2D4wLt+NUeNIj5dp5TlAkDzxRyIFv0Mtj4+va
	 dDkc2mXsP1kCOrV35Q7ZjHJ4mR8b4WthSgUx59LmLkKm93wppB1m3ybYv4KIC4AjlOwRE
	 T8P/sErmSiPOaKr2eU6sfmsWKsF/mnI1NA1TWlshbv4mucKCsK26lyq2FSQmkIsoS0z0W
	 nRr4Vw/osFJ4s4oY8QCc35sezeaSMIR9abOV653O8KFUHZS4FQjQKL8DcvYmfVdYHbgT4
	 O418CczT3aMYGqW0GyeOAW7NJknmfPueO0mHCudEz2fg5dqPOJfEPPS+Qz13ZqtiHdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM199hcW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4D606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM199hcW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDB91F000D3;
	Mon, 23 Nov 2026 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461072;
	bh=z7G6kPFxJpBrdvgM3QzZkyye3E1kSlCp8A6Dvejbtaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AM199hcWk3wN96EMsfeCyfb910psHq66D/q06MoJonxMxADRa2YePYCCHxBRENlyR
	 A4MQL1hJJmZ5Fnu7nH9mkD/VukP6plJbzeoxZ9y79KOTPQBie7h39oUYJ1obiHQ87l
	 nYcvYYQteBtcAaCIue2M7wxuxh9mTvwIwNy4alqyw+P9gv6XXlwXNqGzm5u9Tg8jg+
	 u9izWJN9ElWEElwZiiTV8B4N7xvOAmE9ZsuJq0HTUN3jXy/Rk31zPTB/syNhubMW0R
	 ZkB3VGTufIJi7rQ2Uj92Y9GfFo1HGldZyyo9b5M2uZA1vVpQNSbqu6Ts7qLbk6SSHr
	 GFFbdaGhK2eVw==
Message-ID: <sashiko-outbox-229915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/8] soc: cortina: Add CS7542 PCIe control, SerDes and
 host support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:11:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 8-patch series:

- Patches 3-5: no issues found.
- Patch 1 ("PCI: dwc: Export the multiplexed MSI interrupt handler"): 1
  related pre-existing bug noted
- Patch 2 ("dt-bindings: clock: Describe CS7542 PCIe gates and r..."): 1
  potential issue (1 Medium)
- Patch 6 ("dt-bindings: PCI: Describe the CS7542 host controller"): 1
  potential issue (1 Low)
- Patch 7 ("PCI: cs7542: Add CS7542 PCIe host support"): 4 potential
  issues (2 High, 2 Medium)
- Patch 8: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 1, 2, 6,
and 7.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
pcie-v1-0-4cde5201d404@gmail.com
