Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577422;
	b=e/mPMKI1lKK06RD9/iGK91hRj+JSBVPl5i4AjHZZal3PZvDqbm7LKsnz5ZcugCO5vOBE
	 LV0G8EO7Z2lbg1sMJhAqvYr5i6D4nzZfeD6paBdwGy6bTGPfxn4y9ayZ16VrEq0k6AEUd
	 34tqeModAPJT/zMe6adtCwVCddA9GQvdx08woBcz0vfVd+RkevsUIsywQ4Uvku55JljBF
	 dC5Az7bOAcj5qm83fFVKZlm+mk5f6S5cCOzsIs0xeGyqgzpCeOZ/ZX/KOJfGE+mT+StRo
	 ZLEX1VWozkv4/E/YDg91r+IRRiRotY0HRUDwW1tNnt9fYgDMMRstyBUFzhpkrZtt+Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577422;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L6pO6SBOqFAdnUpt/aL9ZXMDGX3QcZXEs7+hKuKiUAQ=;
	b=pR0HCJLvgMPDBsVxdrH4Bfrqg5dD5Wshrkh2T7/rZ+H1h7/CEI/tvcQYyQLOO0UKlkHG
	 cOQnQRPm9WhNOQlHX7KcI2seSX/NXLA/fO+pDyrrv8v5CT/YYT9I+k23mJGe30TnceeSN
	 +mWdFD8rgOe89HWFLhufVyqp0c0uMrwmqiN2Wzo72gvOkESj4H4L0i/a+ulQLlczfNjMe
	 lcyO+2fhyO1WxFHgWl0CWzuf8RES+VaSGpexacNH9CoRUWPO958VYcJ9nD41owtgVgSFQ
	 Unuj8Kq7IYj1lU8K9C+jsMGdUQ/hfZfXjDa4Hoywg+piztabsTAIkDPF674GhcYB9YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwKCMgoG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7C606A323;
	Fri, 13 Nov 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwKCMgoG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ED31F000C8;
	Fri, 13 Nov 2026 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577422;
	bh=L6pO6SBOqFAdnUpt/aL9ZXMDGX3QcZXEs7+hKuKiUAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwKCMgoGsnIeS1fY737/EyDq0pujlcxfmVYIYweowYPdy2muj8ZjN0G8+fOhjJUNT
	 9T2fRVaekJNHlBEVmZ6Y54J1F0RjDCl0fT63Qh5fb6YDzV6VEBxM3CAKjoicHPlWoM
	 /h6hucGig9yliE8/4tgSMShd8YzHkdYua94ps/divZjKo2M2jirmS656wRyBJh9m7D
	 ePaAPRZGaZUrXm61t5stXQ/EbyyHcOeWAvEWWakz9LBhvCakSPW1cGYEn1v2WkYKtC
	 iRUNSgG/oF0uFuCULV7PUsCfFoh8I9UdKQIQqok6wFJQKx6DMLbt4rOBGwCb5DLxov
	 lunxCUvX5aiqQ==
Message-ID: <sashiko-outbox-212917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 2/4] rust: leds: Add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261113-rust_leds-v28-2-b8cf2f74fa57@posteo.de>
References: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>
 <20261113-rust_leds-v28-2-b8cf2f74fa57@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:43:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the `led::Mode` trait to allow for other types of led class devices
> in `led::LedOps`.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rust_leds-=
v28-0-b8cf2f74fa57@posteo.de?part=3D2

