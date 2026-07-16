Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A682DF717
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243311; cv=none; b=HFR4MIMwSknYaDf0x28piG9vrnujX9+UZck1GZyK6A/DvQv9K9Ae2TOescQIbVChQxd/vkODyfyiCYIj8xQ5Az7Mn55+6bYqgH670/sN9BXafwC5qv7i98kCeeUmkiU0XOQpj7Hkzp5mZOrJ1Bq6a/PKnWx++WEriac7ZPume+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243311; c=relaxed/simple;
	bh=QyJfGg3D2mhQyA9QFheg+SyCsUe5Av9wfE1abLK5E0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ce7rpnwga7gxglfovfxgUsXZ7ObtLl2yvgSdZAebRSKlaLQEoBTQVJl6iiNKuasEcInLsChs6w3F5UXI0HvskMUR4i32iGoq3sAaLMNVAbxJ2GdvZEIaDx4wIluJ1afUEE5kTvX0C9qOmpTsy5moObuFOfii2ubCz5dyWH3NL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmba5QFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmba5QFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB3A1F000E9;
	Thu, 16 Jul 2026 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784243309;
	bh=QyJfGg3D2mhQyA9QFheg+SyCsUe5Av9wfE1abLK5E0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bmba5QFBChAWyCPbeY/XC7Yc3EJvg/co7q1bLlsv3zi4nTezU8KtmkEasrO1GZ5sa
	 7dFg2dyKMq02dc1RUhiFmbwYmta+WrYAT55pH8/YZRLc3OW4tGvFPgvUVksx40WcFr
	 86BYz3YabrlSAlfmlZLitIDbvgB7eZCgLpozCRId3eMwVsgi47xL/EwTUbYqA5Cudd
	 Lf6M1XtubOyP4kOjolbGJ3YkEc4myFJIlE7jEMBaOPEq5SGAstQTu28ZW/XQmWLDmk
	 CoRgSkU77C+EbWtYz/JgGET4wWFt31zYiLFJT4/r0LwmC82jsmT41jTTNPA9z1FExV
	 kqbHzSimukaqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Move Spacemit vendor and device IDs to
 linux/pci_ids.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260716-rtw89-spacemit-k3-v2-1-392b577ebf75@oss.tenstorrent.com>
References: <20260716-rtw89-spacemit-k3-v2-0-392b577ebf75@oss.tenstorrent.com>
 <20260716-rtw89-spacemit-k3-v2-1-392b577ebf75@oss.tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 23:08:28 +0000
Message-Id: <20260716230829.2FB3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the vendor and device ID for the existing Spacemit K1 PCIe Root
> Complex to include/linux/pci_ids.h. Also add K3's Root Complex device ID
> to this header. This is done so that these values can be referenced in
> the rtw89 driver to enable 36-bit DMA ability in it for WiFi to function
> on the K3 Pico ITX board.
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-rtw89-spac=
emit-k3-v2-0-392b577ebf75@oss.tenstorrent.com?part=3D1

