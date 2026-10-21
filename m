Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556858;
	b=l3pbp+laiVx5/y2Pk5Ikor3lGbFkE7rF4qZ1vmYdWswy/OF4pT7ZbiAyTsWQCdhSAN6F
	 x12jwMpdtd9ajEUes+PS4inRhbVUFtF7cnRI7EUzlIdB/i7mW+T5o8/AbvzBYU6hsU3Sg
	 IKdVQrmKU9Vr2asw8lEKIFD6qucMkv2au8B79CGUOC/RBrV4Eo8oiXroBltozKy9ZHCBr
	 iWoUKfR455OscezKBH9+UHlGwhjQxSmSYL57JvkTP/mEXc7E2mLeOZlcxelhiuEAv+sFo
	 8EFjpY/nI4siliImPlVTrBIKZ29ftKnXyK/C8SnMQxhKOn7KyS/yw2g5a2OxzIVL9SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uKOy2bzgwW5q/8u1RfFIHTjuWAoGBzqeKHYMhq49qvc=;
	b=B8RLyZACcwfqhhCMueqwKPNbHY4yS8nHKckvJbE1UCm9lpRB6EyLtDhNpepNs9NuPw4m
	 wXgAvwM0RysQE1lfX57ejUIroEZtDCMSgKrTk4cm4jOPdLlOviDwT574qECGbmQ+48r8R
	 v9gpZsV8jAA+C4lwNzG4w3itx7rRfBi/hDizwtQAREctkQB+OFgwg9ZyPj3E9cVvMUtct
	 sp7QdDsiCRrGP99XYYerYyBP2eG1sgKeqb6w+ZpG0jCLZ1RXyb4JuL+dXcgybYvhkKMqM
	 lyQMhFvz0GE+HbBpCIrLQAbOjeO7HYJxe3MDKg513GgpypfpvqJYUtFxSfMcO+1lKQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7Bh0xJ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E3606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 04:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7Bh0xJ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EAB1F000C9;
	Wed, 21 Oct 2026 04:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792556857;
	bh=uKOy2bzgwW5q/8u1RfFIHTjuWAoGBzqeKHYMhq49qvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7Bh0xJ+MkkxA6eDGVAYAL+Ko/dgsPqSLbSORxa6qP9tWw8xrTuX8JHbTAHedmFVr
	 eReQsthIiQwhGGdVWDH2ddzHG9BYTZIuyVwf7VBEuX+BkDbKcQtWFZm+pVK+FrRbv2
	 J1RcpKAOiZqn+bmqwzufjEpDvW79Dl5cX5djdE5fkwWx1cC1UL6Ru7d6Ie1kbJonWG
	 jsdNc1tjEqXbwdydowl5UaAQBsG1FKoORavpUlrugfkH/e/i2zE4QNRuor/prmFU+Q
	 ftdJaqYdvCqogaQRP1xWT3NhAQwN2tiC/XtYoAn17aLcDRD4O50Uwv7X6Ar8+FRjBe
	 v2U6GDQ8NKN3w==
Message-ID: <sashiko-outbox-179781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021042229.2280937-2-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:27:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>=20
> Add DMA control and descriptor-memory resource types. The control
> resource carries the register layout and channel counts. Each descriptor
> region is associated with the static channel ID assigned by the local
> DMA driver.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D1

