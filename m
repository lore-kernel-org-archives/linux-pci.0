Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603614;
	b=AdRtLxzzrlE+GvjKU2iau2fSMqms9/VZn5FlBXM9nAMb0aLdu++j3p5X/WmCXcKcC2kb
	 003EgcdB4WWqbhZJTtC0V5zyTPowlpPXD7zcXl10AZ//8KnyO5A4UMnXlIptNqO4K5545
	 lukifmAGHsUxBTrJ7q2nLTOD6Ap8j+Zd6GG658dL7t0TuCUZxJpeohM9HYIoqI9tsCt1A
	 cvzOtzmgckPmXBC1lqFb5dzhuFuzElA+vI3vsAnRJSqBM9gAqoKp72c7+z3CE+UQGINVb
	 wnuRXfRjvD3dQaAtuaViK7OrgbvZbZQ5vhJXPNRz8wVotdZ7eExkjBvYpn5JeWjoPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n6PENFw8lQPoCBWgpJStF0jU1pmnnWUHjUb028ncuLo=;
	b=Xc7pJUhH5YCBPJtgzBjLJr9w9oi0/QRJy0W4UD+WfcrnWq+nF0k2TzkDhEkTxlrS/Ixd
	 zGR67FdPZhxRe2j/Q0vfeDtB1zitp6DTjyeYGMIGh6ujPd7mm60ySGi0i/u7pjZlB2gMk
	 I4EhjGd+ra3F/hP7LurAI5Vp4Ed2gYdBgPz4FfUUAEMUCU7zM03tSFEjB37tfn7rZOkqM
	 kvYDNpFD08TR/C9sRHnmYuTfGp/nk2BV4yghdWlunRaSg8Y6uwo4KtVX4ELoy9VgWiAKl
	 PuEeBc0o5a0Y2rMD4N+zr6F3tQFrIfW1jDAGbs58EfDd0z0cNzAu6efhN3JaKMjpI3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LymTZPOo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19501606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LymTZPOo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB4A1F000C1;
	Wed, 21 Oct 2026 17:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603613;
	bh=n6PENFw8lQPoCBWgpJStF0jU1pmnnWUHjUb028ncuLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LymTZPOoGC4FFreXCZ3aGYLMX7Ghx+op1vCuW5H3kkbIJm4FmJ0OZPWTn9J9gVIxO
	 +JFlNNNVIHVgI6A16sNqAz+sT/cGnGvTWJL8rF4XRK59KhwrOeBKnaqRhUTe2+k4ba
	 aEO0RMRjH9Ms6FUjBYwM/MrzRK/zpmDTDQSjFE+AeIyvIfxXLHAfBGxTRglix5OO7P
	 aTphCjC00EECKk9E/hrDctU6Wfuh7nP6o0grNcGx36QBe+ZJSr2zJqs8FTVS5Z7E6y
	 g+5wbP/LaQB2B9HbIto7CHpBujGB29pqpSVwwKeXtYfmU39X/KLIOWEijfc+xU2toF
	 O9xGBgxhLrL4Q==
Message-ID: <sashiko-outbox-180523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <aditya.garg@linux.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021172238.10004-1-aditya.garg@linux.dev>
References: <20261021172238.10004-1-aditya.garg@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:26:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Jason Perlow <jperlow@gmail.com>
>=20
> Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
> packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE. The
> BCM4364 firmware also reads posted RX buffers, so with VT-d
> translation enabled every such read faults ("PTE Read access is not
> set") and the firmware crashes and resets in a loop.
>=20
> Map the RX pool DMA_BIDIRECTIONAL again, as before that commit. TX
> keeps DMA_TO_DEVICE.
>=20
> Fixes: f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf packet=
 IDs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Perlow <jperlow@gmail.com>
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021172238.1000=
4-1-aditya.garg@linux.dev?part=3D1

