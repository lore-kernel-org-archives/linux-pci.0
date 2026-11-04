Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833872;
	b=kCuRNXOM25v7ttBVC2/9XJIHWZ+DLUsrOkL23xVEa9Q5sTyqSaS0qQkJSV+R050AX9/7
	 JxX7df39YZkhJqrjTstdGIeOb8WfF8Gx7kxntpbQt6Htioeq34ZvtKWPLy+y6xD7CPPd7
	 +4QCCOTqN8RshiIzXNeV6x1YXC4sDsCBR2EUT8K9ZGFhs6nZWHwMHcI1icVCP+E1oBwCB
	 AZbhLu+LL6mtAhz+EPX4pgbERBfMisvtE6wGEdpm8C5KG4DEf7UcyyvpGCTIUO5APZe5M
	 ZkXlsWakw1N7wHil1S65MNZ5F0zLBThuj6xQub4Izepzbl3E9FhgubCNX8xwJuU8O+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BbCrcbUUaZ1nV2LYDI96ypvdX5x0h8sjRw0iFclTzaA=;
	b=YPWaQxK9rWBLUPURlBTp/f033Tzpat6nyuLnQ6R/Ogc//16KgWKKGYRe6F714QLaZHWX
	 9xPSiYg11KTXkbFquBilOZtXU0u+1aNblCLw31L2FHQGLjLHqwcAT0QCnXcHkMqj8uZff
	 sGk2UjPlmgnNPfxFn3WmrTBZvtLVkFR+LPNMG4bx+KUiHWwfkPDlY9tstwZHCLx3yYyhz
	 CSq5QlpUbw73ViunlzZZWTIVyPNyoGk/7oT5bgoDu1D9nSMcwDWvhiZiFQ46aNnBtra98
	 /IqoPtg4qxJiLVP3MBBeUlklhdq4acDeVXAzIzVQ+ZY2rufpzShR/pZ2nGYWxPWpybw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVJYoMup;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79954606A32D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVJYoMup
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0651F000C1;
	Wed,  4 Nov 2026 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833872;
	bh=BbCrcbUUaZ1nV2LYDI96ypvdX5x0h8sjRw0iFclTzaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVJYoMuptopVJpMJpbA+VUhhH3pIFR2HCTpJY0f+7ryGXqFOdxFt2wu4wbzzKqst9
	 sXDmR++I59Dkl2GApfqb5RmOlt0kJserxdp+WV+lrLfKNUSDC279rW6hCM6TcUPE2V
	 9owV1w4AeanzTmUZ5Zfr0HJ9FUh8GF/D1Nn8n1Db6rQbV+cBPWe1f1TIhFPT1gNf8S
	 lP1d62DlWmO7iVjIAsuB/Y3cyZXbEdM5jIA/jHvbjJs5Dm6iiPklmK1z/8EKL2olZW
	 4HXw+GIyUt1VAP8DbkW7W6KsnNwGHnoMp9Lm1uiBT9W5xLR/xSyVaDjHr8U68yvkkN
	 3z9ePFV7CRS0Q==
Message-ID: <sashiko-outbox-198272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] rust: completion: add complete()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-6-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-6-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:11:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The initial completion abstraction only added `complete_all()` and
> `wait_for_completion()`. `complete_all()` marks the completion permanently
> done, which makes a single `Completion` unsuitable for signalling the same
> event repeatedly: once `complete_all()` has run, every subsequent
> `wait_for_completion()` returns immediately without waiting.
>=20
> Add `complete()`, which wakes a single waiter and increments the internal
> counter by one. Paired one-to-one with `wait_for_completion()`, it allows
> the same completion to be reused across multiple cycles, e.g. to wait for
> consecutive DMA transfers to finish.
>=20
> Acked-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D6

