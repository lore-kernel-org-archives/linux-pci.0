Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003853;
	b=yAjP87hjKv7eoOeEb9uityfvnjSDtcvFUTSZ7BYr9D1Wp3JlEspTRXRdgmwkUm9U35tV
	 9bSL+8gf+RprVYaPezZ3GRMDCe2JXTU8nvxuTqTuQxli1NPmV3GrT62mN6VIJmuuEwUkD
	 lGAMRYdmTUWuk6iP8RRpbjbHyiStzr+44GAsGToV43TQ6BLbt4cjqPG1Hxr9uUuTRIVrg
	 iuKrk+MyglJZaFVMTFOecjLlQ/qwIqpvMiktCFfMV2PwlKusNfbEp3ibwag4mstT/K3h9
	 neVKowqymLKtjPQ0JEjyvYLx7E6dBaqttnhpRzLtDP+OKLIzfZq2fo0trio8SBgpm5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003853;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9tCRTy6ugxUwDr99UjFmOVZJVrNpeCzWD2vp0xDhWVg=;
	b=A3MlksUCHL+cCDcbn6jz/OVsSVjIEOsEMT/kjQ+4C1yoHX25XTeKVWOx+m6kvmdStFH0
	 /VhkZHKnUJiJ8Gbzh/5tyU+bqHpyIQxPK7rrBYp8xklDleQ4xxh8QmSZV0LWlZ0Na2t/r
	 NoRWP8NURxUggl9hdavArXFhwlITWbGI1IfcHmHWILXiQ6KPbWM1jU/dsDQDe3E70G0hW
	 /hA56pF3sRRZ1fegD7v2zGe0FXRvtMB4jZ2GbUPoWT1ORAGzOAQrbIwUSZ4+2l2rprmGv
	 OFqq8UXIE5NWajlh78l5yB7fQy9aPduFmT3XfwN+2hXlOSivfiCrhPfjBvFqwTBvOhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwKjbaVe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CA606A32C
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwKjbaVe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07C41F0089F;
	Fri,  6 Nov 2026 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794003852;
	bh=9tCRTy6ugxUwDr99UjFmOVZJVrNpeCzWD2vp0xDhWVg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AwKjbaVeuuk3E/Kwi31nh949sq4jW9prrOuOVXt1/Xk5MwFHLL/iX1HiVDXqmFJay
	 l3lq2tuYCZXktsh9LemnQRIeJI7Ye61oO9ATTVDn3DGm53hnYXDVb19oOUx146xAJk
	 iRK2X8Cjmy/KK9UulIUd5sNiJd3z3PI7g1ewca303F1kLglTzNVWtZR7OzwMAXXsoQ
	 w+Mwy0HpsH4rm/DuLuy4gdqQrypnC3v4p+mblcuyr00AbfNqdTXPLMCEyG4Bnqt5a3
	 6b8P5Uphj9Qbeeq2BNy51F5BThwHLEtYPh3bt88FWOGPx1Hdo5kAerGpAUtEtvA00S
	 nhzLPByx+BfBQ==
Message-ID: <sashiko-outbox-202329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: epf-test: Use dmaengine_has_cap() instead of
 dma_has_cap()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlBDSSBFTkRQT0lOVCBTVUJT?=
 =?utf-8?b?WVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261106222142.86087-1-Frank.Li@oss.nxp.com>
References: <20261106222142.86087-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 22:24:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> dmaengine_has_cap() takes a dma_chan pointer and avoids direct access
> to the cap_mask field inside struct dma_device, which is a step toward
> making struct dma_device internals private.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106222142.8608=
7-1-Frank.Li@oss.nxp.com?part=3D1

