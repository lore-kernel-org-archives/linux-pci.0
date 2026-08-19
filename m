Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8C2DA74C
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143843; cv=none; b=dMNkRuvhlS8WMupd9VMmVrNEKf9eu6U0ejYauC3/Y04iGAjKOEqpDbFBQ/6sbd09gcMVk3cJxG8b33WlbSVpSvxNC2DPpn2ED+0utqN5HE/cZoIsiyRGJYbXQQ5Bn+ydx01YMEqwpVlIB3ln2XG7OA9y1ob45FX+zLxB7kRf4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143843; c=relaxed/simple;
	bh=0DtGALXxKkuMGk5F8n/7QPrJS5lCbJ+dDIAVz9GCZ2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jl3OP6vM2xye08geVJsw2D04LIw1fmnvqaISOXReAksRhD5w/fTq8jwQF7R2gqPK+FjRknTVSzdTgenNUYTCo9MRies1c3tiDddASGVNmat+Tc/0+O7utU8W1O/a9UJ7WYccRwKEuNkJ9ft0rNAtgcn3uTbyBi5mv4AQUfZ8fxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZbkeL7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZbkeL7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA221F000E9;
	Wed, 19 Aug 2026 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787143842;
	bh=eN61wqybu3YXZlt5DdryvVNWSM4AiJDeNucaPYuPpBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZbkeL7iEsQxnGA4cD3PgVLrF2q9GHNI7mmQdH/9amLliykIRz5oPh+CiBw+rZ9xZ
	 OMxIoCY+4SzpRvy+teAXi6Z94rMnhf27uVeHSnRpscYKEQsCncqez8WWz1hARvmBYp
	 4K9xZzViJFEy4dfWDTahfBU5QaSep5LncIjvDB+pk5Hp5Zg54MvoN9aWP6tRP+QPRN
	 UZksf35tmCBmUfGEQ7UeBAMdqrkRP5iCw2SDnkUi6Y8rTZ2jH9kagoQnWRfCouojip
	 endWbJ3yybxTke4ZTfnuZ3qNzuZZGLyA1y9kmjFa46dpt8JMVbcDb9JBIIQnkjemKS
	 DCx+sVAzfwdnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] genirq: Add flags for software interrupt
 moderation.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luigi Rizzo" <lrizzo@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819124341.4185621-2-lrizzo@google.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <20260819124341.4185621-2-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:50:41 +0000
Message-Id: <20260819125041.CFA221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add two flags to support software interrupt moderation:
>=20
> - IRQ_MODERATABLE is an irqdesc flag indicating that an interrupt supports
>   moderation. This is a capability that can be set for eligible sources.
>=20
> - IRQD_MODERATED is an internal irqdata flag indicating that the
>   interrupt is currently being moderated. This is a state flag.
>=20
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819124341.4185=
621-1-lrizzo@google.com?part=3D1

