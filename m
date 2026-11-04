Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810208;
	b=Y9qVEyWUNBzh12ZcT4I62TZeGyT99DRrIQCbhk4tuGG4zcIzbFnpgCVro3//gwYSlTyA
	 DncNTEv7agVaPHwRDGnSyaDhWJXkn1sZ2yxEdBW2u4mNSrMCzXEQtvUJOegXbk4zzcTuh
	 lXUyIwssjZDsmI8AcjjhC/rJG21M+2dkUjy95Y2jB6mGmDJ2GL/Ro+mBaSRvZVpTGrHA2
	 +Rok8Y8wJA+xe9KOpZuDUoq9IPqRbBiOnvKLZLQ1wNzjLb91Vgj4PXsUYmMk/QgGATbSj
	 KAzRQor7ehYDEbjvsxaA4DTyL7Tn7vFN7BtsqzBbszJOKVmeM2vfDYZ4qFk7lhW6VpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eNSkHu8eBHjB07mSt+AF0S9aFgQ+6VEUlajOU+D3AgA=;
	b=jhuDMX43KQ9XQukeujtSllZNqMbbAKJfQTSEcNJZ3MyZLRMuvsJSVume9INAYsO4YROk
	 hRHLu2ENskAAGJ/gSLa343iKvEj3RUBASI2c4ylwAGZDxl5Rf+Kltu1MtfDGNDlBBnd3k
	 9tTb+brhgJVnUWfbVYc+139JoKeanpnJCT42GiqdzN8HyRNc3w4m5wxYqpvTWVcj0mLAu
	 ZjuHD81b4tD+Dm7xZwe9nUycW8Q5m4Y30KEVlmizoUjpJNAguwqMHY2LKXt6wAmznKuC7
	 xJ3wz4+KvK0heRPXbOM0KnZUzYpmzWjyBll8s9s7JiTXJUnlpVuifTJkrRRPYuuUHzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtzGwbF+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D059606D805
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtzGwbF+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFB81F00919;
	Wed,  4 Nov 2026 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810207;
	bh=eNSkHu8eBHjB07mSt+AF0S9aFgQ+6VEUlajOU+D3AgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PtzGwbF+ygIWEE46QPe8Y0VwjanwD4db8Qh7TEaxQPDnE9KDnleTBRXmWT/W86c6B
	 TrsORpb1X80JiBzeXlzaO/hP33SaRL+vcwszSfIaOa/RmlkFZ2ixtsQTMH+vBvHx+h
	 efTcwLV18ZwU/WulIT4Dfcb8Vf7YuSLClcLDD4KwU4+LNGEZXmlXRZ0wRf8XL0CP5z
	 S4vuWm6ojirmEEk+se5o8OJoQw1odUyP411LAE4WoN3+8x6uNJiZN+g0MV8d7is2Ga
	 ehOFJi2jvyYV3csUWtYrITCaGUpb+3OzCyC5OgdOV9o9fcz8116bynyFokTXtWSRaQ
	 pK0NO03onYUmg==
Message-ID: <sashiko-outbox-197628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] dmaengine: dw-edma: Avoid resetting an LL on
 stale stopped status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161227.1742005-3-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:36:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> CS can still report STOPPED briefly after a doorbell write, before the
> DMA engine starts consuming the published LL entries. Finishing
> termination relying solely on that value can reset the ring while a
> transfer is about to start, leaving hardware and software ring positions
> out of sync and stalling subsequent transfers.
>=20
> Require LLP to reach the published tail, on top of the standard criteria
> (ie. CS=3DSTOPPED and zero transfer size) before
> dw_edma_finish_termination(). Non-LL mode behavior is unchanged.
>=20
> Cc: stable@vger.kernel.org
> Fixes: db79c4e264ef ("dmaengine: dw-edma: Make DMA link list work as a ci=
rcular buffer")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161227.1742=
005-1-den@valinux.co.jp?part=3D2

