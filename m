Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5722433049
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023212; cv=none; b=VhtF+kvSFdenD2z0vNESnj1qIJecOhTmpTk/nEU0cxLqiZ5wG9dTySnNKxHRKPaS82ZSeaMPiSgA0mq6mG6OjnlRlTCdjvzW76AC4QBBk7Cys8U6MI6QrtT0uJlynhheEGo//9lgF5g2pNDsDIYireIJkvLlQIj+B5Fd70iLqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023212; c=relaxed/simple;
	bh=gmE7NUbzrPhlUhNv5YqOAyklkahEgyMBQ6ECxP9TTpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bh8U4qnVaE/8n/7BG9+7dzDkrAjzzzpzvaw02G8SYGznzw2UUleiMgnNQfCpPselA2+RAair8knAsQHkTUcbHwj2Bn9UgZUnQsbKVXYuHhBTDXn8XhAOjP68B5GIo9/ORW5y4YFm8P0271pm7qEN99CGvYqBvquAeahqTwz5ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2kh+ru4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2kh+ru4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721571F000FF;
	Mon, 21 Sep 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023210;
	bh=gmE7NUbzrPhlUhNv5YqOAyklkahEgyMBQ6ECxP9TTpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m2kh+ru48wwASJPx9/ac3gn98DtmcEN2FHLGQCXXbD5E/re/jspbrOSenxmmMQtw3
	 9psbpCl4RLMWoMmsz7fVbI+dWfncyGpxam3nO6P79F84ODP3whC0IyfT9+MWk/VCt1
	 7rQccsSp9sWhGwhVWF/FUlatAyWNJ0addio7ZjlW15FBvHclfni5v7loGmadfTEtt8
	 Ej7iU4Wx4V8I/JrRUqkDmaJNaTCr5qN34jDdrs8nqfvfb28MlPwHLaRWme12a79+G1
	 7K70RvNiStV7rGlq0tp3oinFLSZJUDYYBIgwkMvkh3yKtU66q2tpfRtk+TPARezq+8
	 1VNxSt9gKzLXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Drop how to obtain platform firmware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260921203716.73663-1-marek.vasut+renesas@mailbox.org>
References: <20260921203716.73663-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:40:10 +0000
Message-Id: <20260921204010.721571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> specific firmware downloading. The firmware is now available via
> linux-firmware.git repository, drop the documentation about how
> to obtain the firmware.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921203716.7366=
3-1-marek.vasut+renesas@mailbox.org?part=3D1

