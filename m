Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673052;
	b=RBY9TmpSrKyEToEiCJ4o2/ynmq7peQIgZPi1PgIETt8iGqCrFxP5HdhAVd452HVPJg6T
	 LwHKEihpCu3rDDgFTgROZt9fOYV2fu5qBWbYgPEDOlQE1tqOr+csAqD/wAqKvQ37EWFr2
	 O8j2aGFvwhft5S1IpMvjc5EUDt/SFh4wWPbkS16doXc7xJ/FFui+cI9PdgTEcyMqSGYZU
	 LPYVYHg5wnB3uwWtYipvMHKiiq5Eak2OsnVOXbEgQY8xdIQWDCjKJVyOILxm/ul+qhY+a
	 X13TCf7T4z1ldVJ43IsNWXHufJR9nUfRPnK7XPMbVitRNpu4uO3MpcChLAiiF5JF2lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aj4isWh84npBGWhNo6+W4Ts/JR3DUsPLpF4piou4PLU=;
	b=V1lDgf/gAU4z3f83pv3hzYpVFi/TZCtBkDW1PTfenJuHqaOmi+PND0zni/mc6OEUyCxQ
	 3ssxgbDT7GQdYfBSCtNOQgvzbhn5mGAOVZA2U/7IVM9AX/dPdeJLNwmQMMzo5xTmK2ULs
	 RPnF0h5gxfrR0gPID1FnbiXUAsS7qdPUaNuhPiwNafSuQ0GN/zxia5ALTRU82mw6sWsXZ
	 X9r94F6Zyklx23qrqeBMiu9lYbma5fOJj+Mdu3AZCL2xNSWm6+EC5J/pfoHx5nzADNB8S
	 QttCSeGsb8ErPlsx18U7nxICScJITydjCV5L+SKatZXSWaBYqSnFnK/D6s5FJXXGyOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxcdnuvQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CF606A327
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxcdnuvQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F8F1F000C4;
	Sat, 14 Nov 2026 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673052;
	bh=aj4isWh84npBGWhNo6+W4Ts/JR3DUsPLpF4piou4PLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxcdnuvQxXja4PJGg795OY05LyqaB6OkBTrVkeJf6ltSGSKax3n7sPLjhGRSvILIN
	 9nNaxJs7S3fXPKCX4fy7ABSJZmjLxPOO/jdb4h9Xf8cytS2cBahrB5U/JNz/cQVAqR
	 k/a/a98b9kbEXavPBOHKdbZYuqFDNuHBzjiKtK4V9YJWXK6Pq+GqP3XewjBSBqVq4s
	 s7Uw4YFOAscAneBe2soF3JZ684e8mXLz8NdVzGk1OT7sag9TPYPsEegcpnoBv2VErj
	 vEM7gyI6SlpwhLw6cBFUV2ME+G4yQ0OyZnnXxkjL46uEyIJ8kRF0ntaJUH/5MD3Y/4
	 I0Zl3Vy/Wi1Zw==
Message-ID: <sashiko-outbox-214739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/12] platform/apple-gmux: Add check to detect FSS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261114160731.3756-7-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-7-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:17:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On MMIO macs, there is feature called FSS, we assume its
> a display syncing technology between internal links
> (for example 5K iMacs).
>=20
> We detect it and then warn the user about it, if its broken/unavailable.
>=20
> Tested-by: Sebastian Zygadlo <szgit@icloud.com>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D6

