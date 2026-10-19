Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B5483BFA
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392898; cv=none; b=o0Kb/Ln2oAunFQxI7NlxdelsPbZBGLv44pAlJlVfxMNhG2Fcy8xbBHNhX5XLOqNeHSu6ofCunMXrOFmE+j2EJOGVnkRYiP6453SfnzKZNiTel7SL0sUDNPaBNBRs3Nd5lyTgeUX5qGvWgPy99TUPGmYviO46cRSfx0x9iIO+0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392898; c=relaxed/simple;
	bh=2L0xWiiK/g7DAk4BmUlZQ7rhRtQMhkZH8SS5HIbFkfU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Obx0gW663iWPvB5CbCVZwPYyW5sIGOZTFO8x3bB/b1gZQpLZB/l/q1KP2kbOpQGhFMC+CLXsaWaMiSt5sjJRuBfUx0j2wOD4IYeEMkL0lmN2oFn+AftkXyibK6IaRpTe+6fiIman2VFEZ4NyHAl5IMYug+TVW49A7VlthU2oOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijNy3UgB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijNy3UgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B99C1F000C5;
	Mon, 19 Oct 2026 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392897;
	bh=2L0xWiiK/g7DAk4BmUlZQ7rhRtQMhkZH8SS5HIbFkfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijNy3UgBBNYAiA9vmGxMCVuhlFyVJmU42t4JC3rM48sJe2trAQEgjbLcsgkf0Rnly
	 ebjxYn93HpgTSen0+KXIeETGMIwQC6QOQf62XUUWs2Gln4C5CGFO0RsZoR5pNVPo9O
	 5pSvwF9BtEnX4nIJGzZDfGrxZmR104/OK/PKO6xFuTz70/RT4wtRuPWBDctmipCxUa
	 5ZQrQZ6j4HVQmkSCRO701wAR0KLvPErQHwlyLtfd3V1ZIMMa/xMXD7F/UBCOpifgjg
	 gmaK764jtFmkJM6bbAhNF2At4oaySynM89q64zL52AElqyvnRlUQA0pJBWDW/dUHd1
	 IfwPg+ChJbBvQ==
Message-ID: <sashiko-outbox-176712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xincheng Ji" <jixincheng@ultrarisc.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019-dw-pci-fix-v1-1-9b7860f919b9@ultrarisc.com>
References: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
 <20261019-dw-pci-fix-v1-1-9b7860f919b9@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:54:56 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> No outbound iATU translation is required when the parent-bus address
> matches the PCI address. This is a DesignWare controller property, not
> an UltraRISC-specific behavior.
>=20
> Compare the addresses directly and skip MEM outbound iATU setup when
> they match. Remove bypass_ob_mem_iatu and the UltraRISC-specific setting.
> CFG and I/O accesses, as well as non-identity-mapped MEM ranges, still
> use outbound iATU windows.
>=20
> Fixes: 17b478b29cf1 ("PCI: dwc: Allow drivers to skip MEM outbound iATU s=
etup")
> Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-dw-pci-fix=
-v1-0-9b7860f919b9@ultrarisc.com?part=3D1

