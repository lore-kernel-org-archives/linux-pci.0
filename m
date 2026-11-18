Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991390;
	b=p2beSJmHtK58UhjEZzjxtC6zPPJ5uL8GpeLb7KxcHxsp7CHKTZ3onavC1M4/uzWPQz9Y
	 Un8lE1MVoQUQLiWulvBEKsDETw8mwgSpbXm2hkLgJUtbeo0IC7P8VQ0a3BaHyNKAuu9i/
	 rB1F6KAM1LfGUAel9O7zEUb7BnJoeCPUZ0hWok4Dwi7Q2CvHxrqWGG1dMXw/gpJqKtVGP
	 +L8l+xrnyuufZkRFWoNMHz9CTwL+nkGcLEBiI0UWXWYDtS0Uo4sBgNJuN7OpItxBbVRPW
	 vF4wNp4cLbF/jHUqmJawZRrsHPZDheYrIbiR10gfhIebhZgt0I08e21W1P2X5P0mehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KkFKP/oqrdWN7WeUaIfjXhR5Swx1aIlKIansJk4mgWk=;
	b=jT0/6jAlmOEl5mGbu/sP5OzrjzHXFDrLlKahzvKe+phZHZfqoYnq5zg+O0z9l+gqjjiC
	 tjOr+pwv8kYKfMs8NomLA1SYmqqC4Yf6hQ5vNTRJTM6c7+LxxY06Lkdazo9TWKGJoHZfU
	 Z1Aqxbx2fZMVczApt6vH1vMRgT0SRLrrLKCpo3K5p9ugsXajmt/TwmMmxscURsOpFdoIw
	 tW7t8U6DUH+i+td+XieLl4BrfBpyPsJlOxpjnSJK5qtXAZEBks48v188PbuwdhF+xHvtL
	 Vrs9oY7DhYTvRKL5hyteMEyUWBD9l/gYAqsZkit1a7rrCML0gSNMS4cC/ETHf/uqiTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mam22wqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC5606A337
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mam22wqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274141F000C4;
	Wed, 18 Nov 2026 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991390;
	bh=KkFKP/oqrdWN7WeUaIfjXhR5Swx1aIlKIansJk4mgWk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mam22wqWPppZL/WNAocK++R8nPhcfXclncNw6+y1yR+XePsRg2K00lMRJHNBnUQK6
	 h9gPRRPeKWI0BFdEskSqr31GkSzfC2HtVkHr+VfI1bwaRPlaHYkzkCMdWYXjpot32T
	 Jp+ipaZb558lRbVVpb9i8BER5ICh7Rw/ObZRr8dMcyqC2vYgH83feZ8rLUFHY0pzGj
	 xVSfCIcmKjGG+XCJqZuXF32uTGpIPBxrnoUJZRZSf23ZU7LOtJdHoCNNbmzvzrQzko
	 f/939ZSmtii/aKl/Y1bpZH8OHb7WvggMmIkyhYf+ErBvYFgz1c1srCjhFv1q4IA2kS
	 pL5hW7q0BWUPw==
Message-ID: <sashiko-outbox-220479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH pci] PCI: Extend ACS quirk for Wangxun FF6XXX
 NICs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mengyuan Lou" <mengyuanlou@net-swift.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261118083222.45366-1-mengyuanlou@net-swift.com>
References: <20261118083222.45366-1-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:43:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The new Wangxun NICs do not advertise an ACS capability, but the
> hardware isolates functions on multi-function devices by directing
> peer-to-peer traffic upstream, providing behavior equivalent to
> PCI_ACS_RR and PCI_ACS_CR.
>=20
> Add the FF6xxx device IDs to pci_quirk_wangxun_nic_acs() so the
> functions can be placed in independent IOMMU groups.
>=20
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118083222.4536=
6-1-mengyuanlou@net-swift.com?part=3D1

