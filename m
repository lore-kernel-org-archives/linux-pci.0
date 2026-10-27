Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104389;
	b=h7whVyQiX7Y+vgbaBxuCjwAiperjpwl9M/6uTXOtle38nV6EW7Yd3F1ZC/eyjClRxGbb
	 MjQW6LiBEAO7Wwf2lgN2am7zTjz87yMPYzen7IcGfYoIM4Oas656c7E80GIqYmhVC4Wih
	 O1KF2Cd8LQ4WCt0ifmXkgY83K2Zl/XMipFQn7AR9pUdZ2J0mW4wGXTEuDXO3ubvXj0D18
	 4OwsGtSCf8WP/c8p2wO311qRPTjPQDcUNUm2EHk9DgJ4eiXqAtEZ+igghaE3x3KpWQ42U
	 oneTIiTrssiB260KlAblNzlW1bZOrKTtrOwdjIGUaQsH3oY7IYYUiKLR8KlESbaT5tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104389;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yu9zJibdiVo5HyfI8K5squt+oeLsrUm1UL7ID1I+3Ho=;
	b=4CcPUlFA66/3CoZXXb7nAVXDQq4AGPaoC5g7rTLrqMZyc80SpaakKXGIRnpZXUJNqOwA
	 R9P+wsZggUJF40Foi+Q2kGKkm41Rn1kwyNbimfo7P4HRulB9eMLsh06cO+sPW4QI/9G94
	 RUAEECTC96MCGW4BBRivZ0AQ4okoCA6P+J5kktIULNB+ZhUPg+18YqSJ80fdnGGjXYmLT
	 xEFWirI8DSTi+tkPz711U+ULaKjg1HqfmxTG6B9OPEtj8m4mADMnMCCUD/DtLv8gXUdrh
	 6HuMeCKuy70ljbtXSp7xT0SA/55jD+c8qk6WYmJn8Q80VLng23+kbIGR1u/jR15WUgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmWATbaR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD09606A321
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmWATbaR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132631F01825;
	Tue, 27 Oct 2026 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104389;
	bh=Yu9zJibdiVo5HyfI8K5squt+oeLsrUm1UL7ID1I+3Ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NmWATbaRct/BnfJplM8VrV03COdlvx10nlQK1OxTdyKpf2yRUAcd1a1oTitjhH/hQ
	 wwmZjwO4r9Wrb7fyUdQ5uM4yjEl86jfPxG/8pjrVBgOcFrsn3dp0omVKGutqaw6ETc
	 BRsIZRfOraL96iOzfP/JoISr6OFNgNepkWggucysxQ+rRJJut/P86rwn+npKSM6o/B
	 5unB6l6mp3fIyXfPYgqsQ/tUDi1TAHDvqBGyJ3Tj3LkSdj+B76GnDD09rNHExeNU46
	 mz/qtHIbSaUT5I5tpEAfWfYdPKrDSClUoaJxLXiTvEOAgS4Ox2ILLiNaYFmqHLRIMf
	 1oip85gIP3DhQ==
Message-ID: <sashiko-outbox-186559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/16] PCI: dwc: ultrarisc: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-17-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-17-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:33:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> ultrarisc_pcie_host_init() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap(). Since the lookup is performed lazily at the
> point of use, the driver no longer depends on any earlier caching step
> and the offset is always valid here.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D16

