Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442064;
	b=F3K/iCyL7ixNv6aqxmPW8qKVXjuoFGRGY1rSrADcs8ysVSkz3UHVZ06kwN3YOKLJ8kaj
	 qENQJzkmPA4qvHsEcgCuzjGTT2+/w61zPHYSJtKTSkxeWCKuiNCq2GTlz2VKtxT7S9Qib
	 jb6jBLait1F8qR7Rk5VzAFPiYI3vbJCugtsj+H3r0l/YslLfW0HXrprMwyByIdToQx553
	 6n1CzThe6WqsIJqvv/n/WA9gIkaoBn/IsrGsQJ1O/zlA2KbLHay35F3P3BfPexiIowdZe
	 COXGZOOC9uH2MoWu5VWtkgRU54j6s8pMIeaHrDuB80WEDJilVu8iPPiq5/9nt4nRH1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442064;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q9uaaDrImUartlJv7+m4fK1U/1jAInbZFs0WMnzAh10=;
	b=CwK/ZHG1vjqM7FevcYymObl3WpP2FK8TFEjaeh7kAzJQkfj06jcSKK3gEJtoNU72J//J
	 JKm/I3yULTHnoSMJRQFG1PApbyS48TcSLSl9eXZKsoc9S5sE1RFUN1tXC1hso7V0G6Ghs
	 O9dnHWcbkHYGLouFNNiKSB8EQt38bhbn0jIhn4WnVZZhBOMDHWqRf6xHZwQUW7sKzsWYK
	 kdBbqWEm9b47GIsUhx3vomCEfiJb7nKqT0FPyEzUEmxXSetw2cEwjM4rBdBQ+9OhJ2MtH
	 RvVvNp5keSneR+Yu9jTdTvnyLdUKr8iLG5E4HIKrYE1swo0rc0O89RJQdHlQj+2sfDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZD6rQZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFC606A31C;
	Mon, 19 Oct 2026 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZD6rQZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D3C1F000C4;
	Mon, 19 Oct 2026 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442063;
	bh=q9uaaDrImUartlJv7+m4fK1U/1jAInbZFs0WMnzAh10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZD6rQZQg7s9Ai1KhnNSNrH7B3Rq1jL6PeBxlN8lKEwh43YjV8yXYVHe9xB91efBT
	 YKBMG5o7lSFpqGIB9YHX7M1Wx5pRvVu0d4MQw0FATIoSjM3EtaWxb1MdE2lahb0LEa
	 lxEfj+7XPI75IgEUM4AiLawIu9A/zoZ0ePxwFsXyeifZi48KWLF5YDzPXdvWWcHrKq
	 pYoxa71qz4w0YNDTeXJtEQEWBBU4o/62DlTEhQgkASok6J7HLF6qdiJlmhKtnlgh6h
	 A3pWMv1XhSWEy1DYmLs4sJGXNkwcrlCEg4F5f65WfCCll44l8Xgly346aEK4hiAt77
	 EwbOx8/kgVfjQ==
Message-ID: <sashiko-outbox-178178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI/PM: Keep the saved config space of an
 inaccessible device
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>, linux-pci@vger.kernel.org
Cc: linux-usb@vger.kernel.org
In-Reply-To: <20261019202445.38259-2-fbeltranmillalen@gmail.com>
References: <20261019202445.38259-1-fbeltranmillalen@gmail.com>
 <20261019202445.38259-2-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:34:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_save_state() saves the standard header without checking whether the
> device responded.  For an inaccessible device, each read returns all
> ones, overwriting the previous snapshot, which pci_restore_state()
> writes back after resume.  On a bridge, that sets every writable bit of
> the Bridge Control register, Secondary Bus Reset included, and sets the
> primary, secondary and subordinate bus numbers to 0xff, which cuts off
> everything below it.  This was seen on a MacBookPro14,3, where a bridge
> that stopped responding during system suspend came back after resume
> with bus numbers ff/ff/ff.
>=20
> Commit e18d1abc3bff ("PCI: Avoid saving config space state if
> inaccessible") added pci_dev_config_accessible() and checks it before a
> reset.  Check it in pci_save_state() itself, so that system suspend is
> covered as well.
>=20
> If it is not accessible, keep the previous snapshot, mark the state as
> saved and return 0.  This avoids changing callers or making the PM core
> warn about a low-power device without saved state.  pci_bus_add_device()
> saves the state when the device is added, so normally a snapshot exists.
> That snapshot can be older than the last values the device had, for
> example if its driver changed the Command register after the last
> successful save.
>=20
> Assisted-by: LLM
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019202445.3825=
9-1-fbeltranmillalen@gmail.com?part=3D1

