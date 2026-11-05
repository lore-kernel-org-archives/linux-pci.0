Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894559;
	b=Kd25FqxYdkgqKL1KGRMiBmQY125B/veu+AkzXyiSFncQhZgk8MbeXBV4P6SUr2rLhtKH
	 T91aLT3JYFi1wJaJN8uryNW7g2Ol1c8Dw/e1ruA9JyBZbr4B0SF5daALeQ0B+G+JJxXNw
	 2cvhMzUizor3nnpoBh0munnCIJAnAkImOJfRFDmtBrySJUlFm6q1XDBhPolHcyGdhqC68
	 199tMzGBhgzGE9DA0wuLTqlYjG7AkTNUSPsYxbsNWjT36eiyko0Yh7hytlD2xpm6RPcJ9
	 L6iZc3ytnVh5ep5fj2ognvNKwTn7u7mpe1zsF/yBWkNMyMzuxZ1/LpAkqYa/R/hC+NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vr07sYPb8iJkLENcRmO1jonPK9qd+P/JenPSd0vC3+8=;
	b=SGd8p1B0ZZD2bz5mqMISRYMs6ZGgdhI0VWYhT5NweGijEQaKRzbQYnHT1ehw6Z88hu3B
	 B8saPtIat7sBgmCT3CKgb+QTqrt3c1x+PpNpvZSTsWHXlkwAUsGnQAmfcc1+sWsGqVILz
	 15YX9L9VaUWdnU5Jr6uPsK8VGqKh3KRdzt+XY+OiHyG/3gZQWS1/6EggIlmZvmVUAVvlv
	 9vFmLlKWgz0xLBgkc6fPYGsS3kNYkzd3tYcbIwVJK0O2uEE0bJvMIKTfnsG7zqz3tKMjx
	 XqTHjFZ/4uPXGFJ+ZAM3cSO3tQT3lARkaqqiS/ugBHtgIkgRkgD5eZFyvmTsFhsEz7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G047nEFN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B16082BC7
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G047nEFN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53E21F000C1;
	Thu,  5 Nov 2026 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894559;
	bh=vr07sYPb8iJkLENcRmO1jonPK9qd+P/JenPSd0vC3+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G047nEFNJUhijD8IUIo7aPm0f5y0Hu4y8X8R15nQ5b5aK4bRsAQqT4vlgctcgsuLd
	 B5JJ+OYtErBB6OBT+C0V6XRgSFA3DbRCSXuUgdSQgbJM0mpJlmxvdfzRPyq2OJGPwy
	 GVwEFu2rJdvaaiHqMnEn8ylVh7eFpkWm7+boIFrvV3SKbpseErWby0d9leTThjo/38
	 UFgc3AlroQu0auqc7UfR/UwERjm1XlBmg41iNMUWlJK3ntrQWjuR/tiw6Tc0LNTjVp
	 0qxkp/plATg/7b9T+cRRd8MVTaElgHHeKO4PkFcIxUWYgiXAY400F/ji9YukuuV7xv
	 I1PKqh+avPz9w==
Message-ID: <sashiko-outbox-199399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/10] PCI: of: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-7-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:02:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D6

