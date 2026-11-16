Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822699;
	b=mJpSc+o3e8moZByvetStqRQiiXmUnd7JZ8jqtRfhqDVXzkV57qfD7QJFa+GHAA2vFJOt
	 5j375mIet2rOiWULikhXRmvzhR+lvy4WyLNAa2n5AqvBAPs5F/KeLP6gmzD3mbJC4M+VR
	 GS0hW+2dntu35pfAhjUsYXZ+XbUXhrO6I5kzbqBAfWbUx3Wy2O6sv1KC2gezjwI6t/oT8
	 UvubQvmi8hstDENy2CSFQcplFq8ufs/BAzKI8D84K/IN5yB5VNgk9LEQYZJQwpkJqCxB0
	 8d69kjGi007BgoLvrp8yNnwIij2wTC45BKgJe/IQxPKGVeJe9QBBqSLjWIQj0yKnk2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zyQLA0ivwt50Z+yhIGZFGh+r15F67rApvNImvnBM+O0=;
	b=Ttv+H320yzYL04w0x6Dp696WvHiM1Enng0ZTK1XDUawtcny0Q0yVWQiaTyjdYVg7PrrV
	 1e8lZWQzAuNCc6u2TfoyzlyhJarlrNp8rtoh+LaetTHztQkwn+GK+DLl/HG3h/HxvZ08w
	 G8RZtgVcA4ykuaB6ftT+YtfLOWddTpuqyKIHivt0hlL3oYitZpB0P/+cTnS5SL2VHgNpz
	 K6TTciTfRXdGo7KCKWPlz8uFazJb6p5LZ4RrIsQZ1x5nGwNjnnr5TIuxjw536Vlss/we2
	 gR4JoZHXgLpogBSzq5nEkbx0bQX1YT0I8ZOu996W3ctT857LNnmXDwefwbDqujJqkqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiPAqu+f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A9606A32F
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiPAqu+f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9A51F000C4;
	Mon, 16 Nov 2026 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822698;
	bh=zyQLA0ivwt50Z+yhIGZFGh+r15F67rApvNImvnBM+O0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JiPAqu+fGAhL9JaQTmFTL1a5dryPNoBZh0aGPUMOaAOhBGzFOdMr+9Hkj3urdy+eO
	 apgtifUOOcz/9KsmjePrbt+ZlSujbmcg3ZsrRjdsWXocf8z0/XGZRxefQ0iyX1/wBx
	 Qi1lTZywrY8lMSWW0OxOiRa8Y17ho4wG7geB8owEyQ3XU/dDfadgp0RwQZNspcQx2a
	 eBJl186Weo7PEkZTFzQ5MpV7vKWqyferyIwmQFMIOCb3WtywNwb6iu3KZOhmKVee6y
	 ptn+KgeI5aO1O24h8T29d9T3sf9Y8jWmNUkuw2zN95JyrqsCdLeLDBHjKeoh2WVAq6
	 n5aYG6Pm7fDGg==
Message-ID: <sashiko-outbox-216653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 5/6] PCI: rockchip-host: Defer retraining during
 initial link training
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116-rfc-b4-v3-5-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
 <20261116-rfc-b4-v3-5-0bf052b68f2a@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:51:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Matt Thompson <matt@boondocker.io>
>=20
> Clearing Link Disable starts initial training. A retrain request can
> arrive while the PHY is still in Detect, when it cannot recover a data
> link that later stalls in initialization. On RockPro64 the link could
> reach L0 while the data link remained unable to pass configuration
> traffic.
>=20
> Remember an early request and give initialization 50 ms to finish.
> If a later downstream access finds the PHY ready with data link
> initialization still pending, issue the saved request once and leave
> configuration access blocked until the data link becomes ready.
>=20
> Signed-off-by: Matt Thompson <matt@boondocker.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rfc-b4-v3-=
0-0bf052b68f2a@boondocker.io?part=3D5

