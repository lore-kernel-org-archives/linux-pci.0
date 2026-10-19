Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997233939C
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392871; cv=none; b=noPtn3g3sK7QNE3a5YtCy0JkFky7nBt2NuiTHnSV7QNfQEcwrUAfzrxybmdVwZTACMu5JjkvXdWUcYRXdzVJyLFx4RDeL6nidwqicsqPE4tw//S4KrSk3eXxnGwTAWADTW6TZxuPHVt4sW7aLW3ekjk76J6qypwHBoEPJ78M5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392871; c=relaxed/simple;
	bh=KBxHneO7sr3HNX4DEw8GV5b4obTlQQCALu6b5eO49+w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZXDIO8JbcNEv0DgK7L4r82W/M2C1DJOhBiGrkg2SgbdnxWBB1Ap+CxfCNTY2gWDLnnpnxn1CwC8TIoR8cJfyVvjIGoZqhW7Zq+X8z+t6r3T27p1XHW1HgJCSDJ4F6c7N+aIqwUkswQkIlOiNQrv7EwSrcXsxcIliqYt+Kmx4CiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ4mCej9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ4mCej9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2601F000C4;
	Mon, 19 Oct 2026 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392870;
	bh=KBxHneO7sr3HNX4DEw8GV5b4obTlQQCALu6b5eO49+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJ4mCej9VVWF0Km05ufmKNHViH+Y0QbHlsx3d68pfd17DPCDAC+gYvKskKUUPOcum
	 viAb/opiCyocrKx+E/JKKLL7ByF9jIVMDF/Mwp6MeBCReopGRB+fd1p9DCnxI6YkAQ
	 Vl7X9JJMmQSAu8tbt2FRcUUK96qPdYZkMYWHVpX0O1/LKfw4/6fQPcN2SLwA6f9WNJ
	 Cm6GXYBpyTNzHPb3eOTQck7kM6xR08yz1HDvV0mBGpXoDxumOTev9iwF+Eh8CaOzO5
	 0/Bg9a/YC1dwAv8NTkZ0F2HpmhAxxTpE+/rDgUJ9ZAne8CeSIB0PuRpY6SoUISogFe
	 QzzORVx/rCYoQ==
Message-ID: <sashiko-outbox-176708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/14] PCI: rzg3s-host: Use cached MSI address in
 .irq_compose_msi_msg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-8-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-8-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:54:29 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The MSI window address is already cached in msi->window_base when the
> MSI window is configured. Use it to fill msg->address_lo and
> msg->address_hi in .irq_compose_msi_msg() instead of reading it back
> from the controller registers.
>=20
> This avoids unnecessary register accesses.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D7

