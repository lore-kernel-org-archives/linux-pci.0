Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577873;
	b=kTBITZ0c2Yc9+2nSPPOmhwy9utsQn1xqbUL7k1+H43lOJdJwxC0+pdE3Wer6Afgad9OG
	 TkCtjRsy1aIdcUcOOWD5Pgcy0AkKudVJ9OjvpDlxysmiWdfweM6Pe4sXWx+VW8LUgMdby
	 sDj0prA3TIQM5HLQDvz6LMpQKFl1wPw3inH3fsQ8JjLXW8zT+tJUMyyzL9gB6SoGshD/n
	 w58WLBCbHfCxUXmr8mV3T8fx6v2YQTrwqeGl+Uj44OhbYBjjU+lkL/IuWlbUExCpRQz8M
	 SEJY0H6lh4u0A6Ih6pD5u0wSRUuB4zod5as79/B64+4mfxk+MdmcX4ZH5oMwrUf/HqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rD+VjwxFzBy2TUqQBiwNSj3iuJMVU9sSI4F+/IKFoB8=;
	b=AAGxO6GMhWyNa76JnBsu2kK9Wv1BUF9FkWcjRnjaaYc7hznAoosdW1G00OAkSfOekdVk
	 M2mq2dVz10FurxBJSSYIfJI5yFExO/jeqYWLEktT4XyteCOBsoP/5KBGJ7/2p79Ro8fq3
	 TwSiu+tml3QM1zuUnVjH8tw1E+fXaR6wcUPFHpJVIhvDcnQHVHQ9eCeDyraoZajgLR+cq
	 p1QnzmK25ZHWRKjf1YtWEZ++mKDOBbtQz4pT17Jefvs6ORhPFdNx2WWJBS2KLbBb8SIqI
	 hPGIJwdcl42obB4SBMvlkYuRO+f1IwCg1PZVpksC3SuQbOasQntS3y9eO6xx0Qxxs7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0y19LOA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703A606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0y19LOA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB061F000C9;
	Wed, 21 Oct 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577872;
	bh=rD+VjwxFzBy2TUqQBiwNSj3iuJMVU9sSI4F+/IKFoB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T0y19LOA1JwdkOv4n23cMr91yVuVVHHKGvV/Nm3tCIu38gUxuXpS+oCT/Wi8yV8A4
	 j3K3wct4K4VKGxRwHUb8KVvBVxJPRmSNp920t8HRtUKyUbq/62SSFCDJohvZ9+u4d1
	 Dsk1VHE+vVi2Czv+lBkNwkof0gBm9FuzFCrPlLrRj6rrmphSqKJ9R7EDRJmrPUj2vA
	 WleuLxknCJ1ZHglytQwSN4PLPjrGHM3N9HYe6Fcvox2iAil6ma9u5L8aXryp3GbzgQ
	 Hj6hPCzVWcx4cacGLqQGdgPp5HRRiUdp5D0OQZA8vYBYIauNIecZ8Z07r1J1Dw6ZgJ
	 1qGXPMkUZrKHA==
Message-ID: <sashiko-outbox-180090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diederik de Haas" <diederik@cknow-tech.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021101533.609118-1-diederik@cknow-tech.com>
References: <20261021101533.609118-1-diederik@cknow-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 10:17:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The devm_request_threaded_irq() function already automatically logs
> detailed error messages on failure since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
> So remove the now-redundant driver-specific dev_err() calls.
>=20
> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021101533.6091=
18-1-diederik@cknow-tech.com?part=3D1

