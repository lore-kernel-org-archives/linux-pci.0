Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91344E66F
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910004; cv=none; b=Umhs2d23BLkbNI2HJp0jjwsEanLDcpzCOXNleNwoCQ4pb8X/DVgOelFzPFrhcP7e1k2mAdtO4Kv/AGKpp6IQ/0+U4oud/Mxot/4ANIxFE9poFafAtXOP6lIPcBHvm/pxJ/spS2D/eWlyU+dqz3SECjX5X1FM1CFDeHiel8R68AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910004; c=relaxed/simple;
	bh=PVkxeZrlcLuKI+eTLfIdx7/a5MxfNBdL8Fox68Cbb68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K8wX/Lz0bYg05ixZW00jtPaHtHfnr70qU7biY848Owxj5AWJ3aQajt8lbQpWVVMwqsXFwzv4yJkdVWowyvSTXLuja7RKEv3/nj5MUOnuNC8rARdmcu4PqV7Dk5QBU5I1Gd33uHSDlk84Xxp6USqtc+t+XKYYsQPiQOb0ZlulSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCRCiGU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCRCiGU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5F11F000E9;
	Fri, 24 Jul 2026 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784909991;
	bh=PVkxeZrlcLuKI+eTLfIdx7/a5MxfNBdL8Fox68Cbb68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PCRCiGU0nU/7PKchaTn6i2/A5X4YrEPrhP2wchgWm5ACS60OODkXfrKPGk9N0CF2e
	 d2bT5+s3u5GBx1NHMg3Wa31wA4JKCEgQvZCQE62XA609wC+veQ7bRpbbztX2fxm7hk
	 GFxnDx7lsiIxjwPBbvjcqOI8ihBnlQfHl9YsGi5MeVNl7tjounhibF/swYJed9QHjd
	 fa1ZvwNK5Q5BE1fmOoiJLMc2m69LX9Wjsem+PBg+ygXazsb1HpGYRkFbO6vRv054Y7
	 IEURVnLOphP6dWHDb/xjJlT4nk33feJQVnrf6LG18wFFc6dCijU1PFLksGHfixBPTE
	 DDyo/ncoJ3rRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] PCI/AER: Log agent & layer for each individual
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <d983b813043c518d098e2919161e816b91f15862.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <d983b813043c518d098e2919161e816b91f15862.1784905909.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:19:51 +0000
Message-Id: <20260724161951.BD5F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The AER driver maps detected errors to the corresponding agent and layer
> per PCIe r7.0 sec 6.2.7 and logs both.
>=20
> If multiple errors were detected, their agent and layer may differ.
> However the AER driver only logs one agent and one layer for all of them,
> which seems nonsensical.
>=20
> Log the agent and layer for each individual error instead.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784905909.gi=
t.lukas@wunner.de?part=3D2

