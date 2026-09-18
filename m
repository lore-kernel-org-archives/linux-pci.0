Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBD381AE4;
	Fri, 18 Sep 2026 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701904; cv=none; b=leF+NWXi7kZhV9Jy5O61XCx7raqy9KtxOexUFrairFaFwuU5TJXlrsSfxjWRI+AU4OgDpaK9oprwKcpCmL8YiYACU6CFp/5dAC3UhXKVW++rBU2/RBYRU29D2n3JGDutLK60yRyaKg/201YbtXr+EF6ZpKxGetRqiM0GRjUOVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701904; c=relaxed/simple;
	bh=/Odmw38jh0xLg8ObKoVrX3O5EXoNBG4R4cam5HeFfCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nh7J1XnoeeguOcb1AeaNag7VmHbzLSjpS8OpTMTOrYPo4P4YnI3O/wxByyvyjswwKIKVdpvcj8pudnJ/6zxXn18PHdzx4MN2xQfqz0DSpoJU+PTikZbJ/lHhaL7s3hqrQTi8dIQN9EdDsNguW2ev1pBUhd9qvrJFAfTTngsIbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9Head9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9Head9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639251F000FF;
	Fri, 18 Sep 2026 03:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789701902;
	bh=/Odmw38jh0xLg8ObKoVrX3O5EXoNBG4R4cam5HeFfCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9Head9SoxyJcqaKj9GdJffKokIVRpWekhp8wk6WSKZpfInSU0mZJqsaFFCeQfpCC
	 W76Npvw/BXoQZaoJ8toU68osbmGnQWJKfoee5TXxCczuI17WCpATyBTEJXpWbzqRAH
	 mFNnynGss80UVyPaam99WllShLFh8quxUcNP104I7t0xrD0/866xloJ26pCYk2W3e6
	 2dg4FuA+DY1i6ZMkZAelOoISYiL6rjo/Nv2+0Vp3OFBGIzRDSfF6lVcQeM1oMNzMa0
	 gTJimIIaDVbxQRIA+9rZKKIlBQnvRzTPmesvuSsR1K1G7+09vV1aTFRGu4J0228t5e
	 eACleojwnmm5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260918032038.2216471-4-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:25:01 +0000
Message-Id: <20260918032502.639251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
>=20
> Keep the fifth interrupt optional so existing device trees remain
> valid. Extend the example accordingly.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D3

