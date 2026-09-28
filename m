Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371934E80CA;
	Mon, 28 Sep 2026 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614937; cv=none; b=HL4N6qxo/AWW4pKI4Qmmz9fjJuiS8M7DEOiunynMMzHNfgysfQGX4a8vFMmp5lcBqX4eWkLvzrV/ukkdVwNqezw0oyG5yQUdlh0fzR8yOy/x3VsXhbhwayxHZS+8sjJ7OWgfEz1BBJjMUy3HvtnP7mNsbxWNiauewkPmqo66rTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614937; c=relaxed/simple;
	bh=Js3wrTb2wPXOTZ7jTypBvYmg6OFPEfAHce9mJQYdtpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srZrRtQjyRldHRV51+VO3RB74CJEmGyRhD0CQFwq9UMcNGWT8YNheuM07IwCyW++rrJDX9SuC++fHVV7JYm3dgKDLYTIEuG4SaEv7WSSlwWwA4Ww/biV3XRskWoGpGq7bWs2VW9sU6GdMbfSL8TJ/BhauuNLMOKKte4G/FDoZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg4j05hq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg4j05hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBE81F000FF;
	Mon, 28 Sep 2026 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614936;
	bh=Js3wrTb2wPXOTZ7jTypBvYmg6OFPEfAHce9mJQYdtpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fg4j05hqutQB3jJwq8hNelTQWWErQPncA3FhVHBMCZvX3lBRDKLXOQfqspREjnzT1
	 KIhS7obtIcGblioJHEAyUnpozoUaaDTWvaPShRnUpbZlTHXyEhQ4o9a1a2ocxXywoP
	 YI5LHYg0B5ubutFHtoG+yHpul0mfB8Bh670A2kmnnG1OPVXiCVeB7hbltCDEc4KLMB
	 RdnkTLIuYAE6oJeBHlZSgBihBhkVX48uDly8YAi9Q9d9d04T/AiNRTjpMTfUCSHz2j
	 9o/8Qo44kdveTdIguI1LOHwmL7wX1xk4QH1xawv5XVzfau7KxTITZT8Czr4vfWba7I
	 dCsHbLWjAIOHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] PCI: rcar-gen4: Add a controller
 reinitialization callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260928165230.3397664-9-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:02:15 +0000
Message-Id: <20260928170215.ADBE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Root Port recovery needs to reset and restore the controller while
> keeping the clocks enabled and the Gen5 PHY initialized. Reusing .init()
> would acquire these resources again, while calling .deinit() first would
> make the APP registers inaccessible to interrupt handling.
>=20
> Add a per-SoC .reinit() callback that repeats the power reset and register
> setup without acquiring or releasing resources. Use the same reset and
> register setup helpers as .init().
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D8

