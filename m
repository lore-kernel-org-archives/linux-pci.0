Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116579;
	b=moovRX0BBnIvLtDK8fSdI71HgolSZimn4yL94yPenPFQatRIRBz+CItsWMKeEqwF4Ef2
	 MRDwZKrMPQT8ZDF1fkDmMiinF4d2DbP/6IFmG9Yz01TCZDYOQWjjVnmjOil5ZFiHOB44i
	 8KhMhZ1r6Z+1nHAQw40PlrecSo/aLfbpVHiEnpbzEb6DLdzZCrneNVnwGauBJ7KwLeZ2V
	 c/BabX/Ml5VQ2W0jkZtEHNFjxy/BH1SENsZlBRvRfqk2UWboMi7B9PZ8kwVJtNnWqxu8A
	 CFugh4AlK8O8hWqrsORkB7JeTpV8ShykALdYB3V4VJ0Ty7BZ9eGkAHa0yZYHvvPk+fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116579;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jG2pCbJYBG1q63h3JKh5Rwzx2NZplJto2rmgOHYEC3E=;
	b=i643QXPq9IMLxGJ8etGkmTcudQbY8ZFst9GZPPylotH55bK4vzJw16Smd0/cig+TQo6+
	 531m5+dupS8/1aPXFaVnAguRm3Kodz4AsxFR9ANN8UED+vZPPITEG2eZqLTiekJebhRg2
	 FfuqegDR4sQPvc6vjNFpy5ilJtlpn6A5zdzY0FRFLP/pLbZXDhZZx7AiYiHp7h2c7eWdV
	 1FqJU0oSn/QhvOmevjAhFaUmxhxWLbQfOshw1T1k1A8uoyR4aGgPOz2RMmavn6DEjFmew
	 oXXGdLzbkBADzMz/+TTyn5W044Wcxfgodl22Zfjg/V+XsJeOTx/WKlevGy3j2XmnamA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiSwRFw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4660A2620;
	Thu, 19 Nov 2026 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiSwRFw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBC21F000C6;
	Thu, 19 Nov 2026 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116579;
	bh=jG2pCbJYBG1q63h3JKh5Rwzx2NZplJto2rmgOHYEC3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QiSwRFw4fFllsIgO631gg4njhZn00FV0UvBJh+261qtd0dw1/w6ir0gce8G61ToOA
	 iAI3Hml/MOQi0Rj5IHaTL4hPORUwNiURYC/xzsI4TNEeakYlWXPwXzognO6LjFzHEJ
	 ODy52Fnr4QZm0o/CJWX+FV2vmh5qQojFGo91fqg3LRntEy/yEyp6JolMETcdqjTAqI
	 Aa0FlLcE7OO74K0SlO0gTqhRusgkNccrpQngAVr8NjwutKNYekfKMlQE5aEHCusNZb
	 CKVbzFzynU4YXig7wsWiej5iywgtpNpMZ+JW2hRICXcfz1o9kjiIe6JDpz2D3cCOfa
	 cK4kzLOG1Zttg==
Message-ID: <sashiko-outbox-223907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/31] driver core: Accept device trust policy on the
 kernel command line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-21-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-21-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Blocking devices until initrd attestation also blocks the hardware needed
> to reach the initrd and perform that attestation. A global policy alone
> cannot allow those dependencies while keeping other devices blocked.
>=20
> Allow boot policy exceptions for specific bus devices before probing,
> including devices discovered later. Keep unmatched devices blocked unless
> the administrator explicitly chooses another default. This makes the
> exceptions usable with built-in drivers and avoids depending on userspace
> winning a race against early probing.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D21

