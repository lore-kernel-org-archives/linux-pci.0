Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117671;
	b=TohtLn5iO8luo75xx7mESIk3Lw4lzdTOwD/O1m37knJsu7eibgD8OqgVMZktrwPfG8t2
	 YQL1BRQpz/OJgIWOx1j2/IodzcDds9FZcgohhkGXvxTj5wxvkdaQYzZM4VuyAyvMC8yvU
	 R0DSUSXVBS34UTu2VUXWAIB6zLnEQ8UKAiyOIsh5e2cTlqdmckAdEKfbE7JWRjTCaMb/E
	 7j+tVPT8bDKfykFgjpPIPy765LLHhDAax+6p3QaiifNA3dHNLU2LY4p4CCVt1sow9X3wk
	 dRIsU4uYtVvZhaK3kOXflIsD6UhTcDlOotO6xrpiU8w2raqu8gglab7h09PYtPraz0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117671;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1R+wqpuCpHE/NZWhuoW0PE/NrqhCJqiCbk7bTSBaCmU=;
	b=LmbNwcwDC2AjtcLi0eMdmirlV61CvWyzEvCfPKzoIjggORX/0CdTSMMvQQYI7TQXZ5Rp
	 mn+tKXX1KoSZbgWhNJlrBGUS0CH5cPKXl8Dm56iFLguF+OAF/KGStnZZcCIic3tDaW20q
	 ptwULcTrjla/Zye2VWQH1wLjZIC2M4V7jkUsUhNgvsBTdtp7A9pR++N9hbBLOFqi0JbHC
	 UESumI6QdfD+UpYG5eWt4Vebts/HXSBgqw3uXO7PMBiFwdW7+fklqiVRYUWrOqKBlakqu
	 rs/0EL2JtGG3SrGgF+8jAgjW1nS9O/KQ62QGb5QlivoK84rxBT3/QW6XuuPhq4fWlAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rc3GYBD6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BE606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rc3GYBD6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FC21F01825;
	Tue, 27 Oct 2026 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117670;
	bh=1R+wqpuCpHE/NZWhuoW0PE/NrqhCJqiCbk7bTSBaCmU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Rc3GYBD6S905k4ylrS7BPRXV16w4dfyc3zQz32mRZtQtyHRB2i9y+fe5MvG2G2LiY
	 oBOg4PdXnzP9v66rWpDxbf14hIsSxcU3QQu60Grui2qx8R8Qz58o8vX9au9YAWneKN
	 XqT8GZNVFhtUrcSx/q4J6mp2CIDKbFdWcs2qaUsIWaMe/058GIQ9FIgTGLzFsCnnbI
	 zadr/iYJsbzSM+dhdjhXbMFIzK8K5VCxpV1dbh+SDQaJE9VmaPAfpQofKLtu19a5W8
	 AHn0rM1crjbQYXzmrjwGwNSb2zBAY8Wrt1OUIC9+zwogp+KdxCR0UTGp55dxhbAkp6
	 CzKsag4P9g1FQ==
Message-ID: <sashiko-outbox-186887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] ionic: Lock VFs around
 pci_reset_function_locked()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-6-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-6-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:14:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_reset_function_locked() now requires PF callers to hold the device
> locks for all enabled VFs as well. Lock VFs around the reset in
> ionic_pci_error_resume().
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D5

