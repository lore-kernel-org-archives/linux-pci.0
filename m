Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556721;
	b=lC97PMxvWm9VphOxLSPY73wf1R8rvWJHCq705vQwG0eaAQ3VmjsdpUfRaYQw+je4EPfl
	 1fyJyajuxWK5L6o3ktECLLnKEK8PvUj3jhTOQnHKrwDOaud0yE6DGBhXkHjD9OaHAi/03
	 HzF1ptmpQy8ngrbX2omlA8R3jqgVYgGda1lvGC44cE2fv0QhgrPJ9GJ20twlnZxpjuqHV
	 K2J/3TMQHlNzSBOhZCo182QFVRplRzy5UdWpA8wIOvxFUhxZG1aWMdMKjx8Vwm+ztFtRL
	 2iicnr/nKA0L2+gQSNVU9OnJYXVBwjPEx91NfvFR9tjQlDygKhdwKZ6loidgtzwZrzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CnGil7lFHnx9gtnUFJdSVj+woPUz9u2gU/ZfDC9zoZQ=;
	b=qOvhuYOJnt9dS59DS88E5KKV1Esez7QNZkrzVDfS1WKr2OHzuKaWHvOO1Hx5KgtnLmwn
	 W5xuVRsoCrBihnPZT0ffdXtvlrNPTFXm+1I4Su73CFGMPYowToXTkvN0rmILndcL1xMha
	 nJz0gnETtgA+M41vwi8dpoElfp8iPLGaDahZwKqmhbKoSKDt1t5JUe0Ke610plv/lRSpR
	 ZDJ7kV1n1KcHgz0BGB19OodQ1tC5SdNLFTET8UfvO0TGOoMhT1xgnnaDGD525ficJH5lW
	 0JvB++e4YJvVVjxYL7aSJ8O+fKIPj+Li6mmLzikLqB5R69eBAkrTSWyshmqOYF9PJzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2TIdQZ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB2606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2TIdQZ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBAD1F000C9;
	Wed, 21 Oct 2026 04:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792556720;
	bh=CnGil7lFHnx9gtnUFJdSVj+woPUz9u2gU/ZfDC9zoZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m2TIdQZ+OWH6WaxZxfPzJ08gPl20JSgyVOeSb7Cs5H+HNOxamWv4gLuIdjsfR0TEQ
	 iLh3TV1b+1LiAqqgPda3IT6Nm8YztN4fX5tzmbCvD6VlnzHH1bdtLIWp09Po8zcdcr
	 fPCyWawGMQDi/+Mok6y+SH5x7XVTprYhMd4Zto7QB4Q3cwff+zV0d7Os4Tjoypp7/X
	 cKl7XPjq1cidHEzuCVDqjUXSWCBcQXPWRnys+Ws5/YiaWqiUu9p3Y7SAw343WDYL9B
	 HxdRJOSNK+HtyFhtcB11o4B4anm41HWApTMLXUuiO95gJ/sh4yUP+PI4KqfLpT5INk
	 ddgJtEb1HJ0XA==
Message-ID: <sashiko-outbox-179778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] Documentation: PCI: endpoint: Document vNTB
 DMA export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021042229.2280937-8-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:25:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Document the dma_bar attribute and the requirements for exporting
> endpoint DMA channels. Also document how the selected BAR may be shared
> with an MW.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D7

