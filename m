Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808953;
	b=OEqgtjdn+kiMHZ3cvie4L5VHfai5Y6Crh4tTxEpDNTeYW5WCTUB5yj8KY3dM1xsmccNn
	 v7r5L9oqC2sCg3mTEjbgoi7i4CDCHxCdGTo2deiqZGSJOgehj31Pzdcnw9OvK0Fhp7dAk
	 jIautqMI85lu7cgYXbjYfN4RVBMqIxgFQwYZK5mc+s5ionXSTXpX4gMglGHMYK3B1MNv7
	 q0r7ZkDR/bGMXwcpUystUaMqfg/JkbPFuAsfU4INHEOYZ9sdWRdvKUKR4FWZcq+K5jHmX
	 RgM+XttRdpt7pXAxnpwgd3l/fCnOnm+yTxZXsccX93pbGaejgy1lzJ+Nv/1Xnvo0qBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v/8qpfthCPhhQVBwem8+eUjXdUSTu+bPw9ys6juwxto=;
	b=Yjsu3Im7MZ7lo/MRFYUcZUMC9PYs2+CDdHnCNK/Jpu4zmV8sdSLTRyeVQACEG080hZ99
	 sa70oRybo5RPzMB8EGpo6eDaGQ46JExivS7zCKr/Z4Dmv4Wr7LW/qCCwngYzFVSt3090Z
	 ATkq3Nwaffn1KxavTx3wYkGbsjTecrhpPdrc11RL+Lv58NWCk3O2mHYv1vmX+PrQNUo8F
	 sv2XVmKYWwdvHwRgO7ocG51srrdPs049Lt3m01tUd47h2+ecxfN7heegwTM/T4pM51TA8
	 EvXr3sWJm7G5xW4HCst3902SfYUUXxKlSb2MveINfF2JtQvAzsL+px5s+WsqQ2ayrVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdAUerDg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF8606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdAUerDg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7281F00A16;
	Wed,  4 Nov 2026 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793808952;
	bh=v/8qpfthCPhhQVBwem8+eUjXdUSTu+bPw9ys6juwxto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WdAUerDg2B3w7Ahjp5bcZd3MwuoFuMBKFNkoEDT7aoRyh7LSRUBnLcUkk26p+0CBw
	 T/IY8U+FPVfAuR9oDXuY9N7d929EEjqRglfUIuZo54dCY+LOBo7QYTFLJQhjXNVFWO
	 hKrYwpd1M0EYdnmc8lPyfai+7/NjTy08fX0I5WZpmemmACAckpdeGkcTUHc3lJHUNT
	 2K8mtVjqVsgecwNrVY8isz9N3LtA/Dt5sR8eeGzzQupqfHi8LZfCUMeqtP6vhH7fph
	 k6w3KnSy2lEq7qAv5OLLOLqKgV9UiB/Sruu101KtZamjTeZc23xQOLP78ADJERgvGJ
	 TaTySXWzxrxCQ==
Message-ID: <sashiko-outbox-197591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/7] dmaengine: dw-edma: Factor out descriptor
 completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161227.1742005-4-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:15:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Completing a descriptor takes three steps: record the callback result,
> unlink it from the issued list and hand it to virt-dma.
>=20
> Factor them into dw_edma_complete_vdesc() to avoid sprinkling
> vchan_cookie_complete() calls throughout the driver.
>=20
> No functional change.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161227.1742=
005-1-den@valinux.co.jp?part=3D3

