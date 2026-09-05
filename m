Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F035838A;
	Sat,  5 Sep 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613895; cv=none; b=otQQrWCDhw8qmQwzfFtzHrnp4WNRm3xQ0j3LQ+SH68K2Y1a78XRtu9JQzN5qaU9hs/O69jIy7Q7gQkUoRW6SR6rtTwmLp3dqG1jaZPpYcE+WV10A0CjjhkUEaP68mVPmEn83lBlgnGu3XOiR0U9i9dGZ+jSfyjZtOiq1hWAEds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613895; c=relaxed/simple;
	bh=eOiYWMjhAt4YddFWL2ltrKDasyNwJF4gIfC9skw9Vk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9FpY9X5oTGs/58JjAMLcmCvjwwc7HPNKaZ91mGRzQtkp1yxMVIFzq155itXdf2dFOWxPEXqzj2f1R71629X0R6QeKUgnOkg1ZURgjminNxM9sKDf6hQazZS4klRGi/00+cdJrdxYM77eUgdQgAQbAIIDqnFcdCfl+i9O7zNXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm4VytMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm4VytMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C9D1F00A3E;
	Sat,  5 Sep 2026 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788613894;
	bh=eOiYWMjhAt4YddFWL2ltrKDasyNwJF4gIfC9skw9Vk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bm4VytMnoBwjmyzWMzOV/Gkj/pCLplObOS+ucb+mnjidqwlirLmUgePgzoeQ1ODXZ
	 10nihVSpXRosU7YdlNpafIRCuGdYZ6V5qXkYMIt5Vx4tttvQfvphli1O2UjHKfl69n
	 jQcMzPOeMl6coBoXQaZ1dFpQvN5zaDnm8Luj94yJZ0fPDg56gekkxLI3/uDwj8P8ke
	 0I6FPvWQ6sH1wkW/WXUc7wdN1NwZ8oVcJTkPan/XKxX96j0zhZFE/Hzvv++KxGv6nb
	 Awp5NsjXssTDRxzuElYn8IvdgP16SdbqhpESyhbR1FKFre9Ii++0039s4LsCRfIQE0
	 4NQxAquSZDOwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] interconnect: mediatek: fix Makefile typo for
 mt8196
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com, media-ci@linuxtv.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260905130925.7115-1-breno3011alves@gmail.com>
References: <20260905130925.7115-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:11:33 +0000
Message-Id: <20260905131134.24C9D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Correct a copy-paste typo in the MediaTek interconnect Makefile that
> mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905130925.7115=
-1-breno3011alves@gmail.com?part=3D1

