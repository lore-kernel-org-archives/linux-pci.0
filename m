Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265070;
	b=BFOTuN06S80kxeZXSNGqH27y041e+y8u1kbewCZRlkq5C3HbpzYo9lUkBIZujEgxaxol
	 Qgf4Lw1HmqT5ohXfQoTtp50yRawEK3AS7POZvyNqLkELSYHY2Yzswm37Jp7Kl0kQyR8L3
	 SUq3AqV2jNgHEopnz4+bM38IPUD0L5xFnI+6QN63BYrqX34hoHgjdSqD7GBgPMSenOGqE
	 rcHQQfLiGdFvCg9Sv0zq2G7CncBeSgZxE32pfJiXfIMqZHHWKiWqz9PKTLDgv0MBNjr8i
	 Q4qhCtaLGZpALfTkPzsIjrx0iP4bb1fLDbD1LvAXhTsUv/E7UlBNZmWkqd+bogOU+bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=amezYADWefBLj+C1vO8uZk3vxthZdxGSpk8EsE56ltk=;
	b=dmsLNfx4TQxoSYx23mjMCEPNw5J6jns9R0EaxhYrH/uqDP0/D36+eCzxdaL9IrBgraAG
	 6kqmngTX1JLT2qjYFMWG2ksthNDNG57Dz6N38kv6nqSCUTyO1FZ/nKDmSVemWsqQDfLNd
	 85gAvLB5UBKaRGqfsaufsJWaSlgWWkOHBuR65z1aCPbxqsRNNxlG5csLcQa4wTQPrCW5T
	 0WwVEd8iyfd9mrUL9qCytT1ij8pNk6ZXBlrByq0uNfvrMPPZDeum4HmD4A9d+jUTr0DK9
	 MDyBI7UbLl1Xs1mgrd0IE5OmCE0BWqq2zWQsF4lLP6d9gJim5rkCqUOy1BndLN43pjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJNcLlbo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA51606A31D;
	Thu, 29 Oct 2026 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJNcLlbo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4361F01828;
	Thu, 29 Oct 2026 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265069;
	bh=amezYADWefBLj+C1vO8uZk3vxthZdxGSpk8EsE56ltk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJNcLlbox/sNlG36R77Nmb4CngtcUXOy7rg8u0NsclS1j4RO7/samf6cBotG8Jstx
	 +kOopp4m8dvqllJaJHRCM6DX2lmtam30UVaCRQOo08AXPQU5JNTTwUFI/u0LIw+LiV
	 02letW7OY8Ck7PbzAvWpplXZN4KCGZbGGULHbkMJ7ZIdtDw55D5y+P7Z3NA0vPMCVe
	 BRUR++iwVAurvLt0I+AR5FJ3L0+48qPfVzuSMYVAaBsohw6H03EBYASejlU8UTtVmW
	 og20ePVdSa63z1it3qpBKQrTDJcRvoyEM8D11BK3YpuazlytXYbrBeiz73lnq4lhHv
	 WeQn3rv2DprmA==
Message-ID: <sashiko-outbox-189004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/14] treewide: Add a flag to detect the Apple T2
 chip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, mfd@lists.linux.dev, linux-rtc@vger.kernel.org, linux-security-module@vger.kernel.org, lee@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261029085504.3547-9-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-9-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:11:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add a flag to detect Apple T2 chips on Intel Macs.
> Cache the result to avoid repeated checks. That will
> be used in upcoming patches.
>=20
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D8

