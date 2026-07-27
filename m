Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1C233944
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139967; cv=none; b=aB8i91gdAtQxpSNkKh5WjP1p8jV6D+JZDEE1nnZNbAiMXm8C55lO6S0bveOqB+wd/sFIqJMz77y2oKl3qhCMw0bAuViI6oBh/TFFUDHMG7aFjgZmNWh9J2ohA5RdyjDds4CLNd4LdTydSxjn4rmFW+pwqo+bgoyyDUnPeqWKGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139967; c=relaxed/simple;
	bh=jxspOycBRqa7QM4FyQK9yY2GO/SfKata0YfkxIz/2kQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D1dvtMrYqt7T95R7Eo1xZT/IHqt0rncRW+1/hTqFlpOsxevLfMwmJq5C2CVDwOxHYn79MAzAFQCMnPPKLgSNlwVKKvprr6KKnjclX33Bvto1fM1Hye/SDuEg46/w3s9CQOzHdVg5/hRpM0f1dS1qz8zB9qQR89QzkFy7a4xTlNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMgIKzza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMgIKzza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232CC1F000E9;
	Mon, 27 Jul 2026 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785139966;
	bh=jxspOycBRqa7QM4FyQK9yY2GO/SfKata0YfkxIz/2kQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMgIKzzaSOQg1oikkTNzEMtXeF8uX47+yp4IAw/LOAni4h9hZdJNuemfDUBEh6Ta3
	 xFUh7lk1CCA7XtcmtRGzFaCHmiEWbNZs7rW8bX6RMHEwAjeNoc6ISjBZZNAar1qubl
	 6jVtAp6jQHuuWMv8p4yyoDSq+VEDkNPVgyCATHnAZKn+AUsmhEpGH1vuVb12i7wAJ0
	 cuJB9BcGJKc3D1Bk9K3IIwAxOZHmAuGi4FC/f6huLfgnQZZBHBYBzWvzOynxcPY9Db
	 2/XhLTN8JyHPW2ScCBTxG1+2LbyLnLme8ActUI7h7dO9AwIGor7OyiqRMefduISDPb
	 EQrmGs9QZ5piQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix unmasked value in pci_generic_config_write32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727080643.4949-1-raizudeen.kerneldev@gmail.com>
References: <20260727080643.4949-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 08:12:45 +0000
Message-Id: <20260727081246.232CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When writing less than 4 bytes, pci_generic_config_write32() uses a
> read-modify-write sequence to protect adjacent bytes. The code comment
> states the goal is to "merge in the <size> bits we intend to write".
>=20
> However the code does not mask the incoming 'val' before shifting it.
> Since the function 'pci_generic_config_write32()' accepts a 'u32', a
> caller could pass a value with extra bits set outside the intended write
> size, those extra bits will shift into the adjacent bytes and corrupt the=
m.
>=20
> Fix this my masking 'val' before the shift so only the target bytes are
> written. This makes the code do what the comment says and matches the
> read function, pci_generic_config_read32().
>=20
> Fixes: 1f94a94f67e10 ("PCI: Add generic config accessors")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727080643.4949=
-1-raizudeen.kerneldev@gmail.com?part=3D1

