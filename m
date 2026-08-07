Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C8279DCC
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115223; cv=none; b=lomendJuKnChRJcEo6pjHlmTIeq7LCYb+mC3huV6a8YkHXBHuxQiBqfDy3xc7EmZn91C3LOfSWx2q0EhV492NsK6HmQz2Ii8zob3FlvLhNKu6+IzmP4jC1NXpBlNC1MRNUk2OfEYS2sygq/+JTIHTELjg4IjF1SPbakOTL7rh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115223; c=relaxed/simple;
	bh=Gsj3f4htSMxsUpNJokrCntOtdN81UPL50mwONzONcBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uCXMcvWM7Ifa00LsgmY85Y6PoKmrwXg9gCGI4RF8dXrGhUFDe08fl062zRrnP1GoYLQ1H/82mDaDa8DjDeo9InAcoEIc6hMChmre9Zighog8t/AEcBvNidjLkgj1T84dEubRttBOVyjsNtX8tEmTaBKEfG/dO2JT9ANICYXDh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaJAEMpO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaJAEMpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3191F00A3A;
	Fri,  7 Aug 2026 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115222;
	bh=6NNVVf3IV7XR6Fa9Y4h+izUYX9TB3VKqM1geJljLYcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaJAEMpObkH0HzrqqyoTCirPTUuBQPCCgUTSqr1o4HVT3+i1H63RI93f8mXwVr4Jt
	 cZsXmahPtYIE8Vmgmlij5RbyZM7Xmo3BjNE+FEzUNb5KuDnsxaKGQI5VliZf77Z6TZ
	 SxftBrUXP1AQn0p8SIajy70rQsrjUPrnqj5gJtEe5p1zUECVzz4CYbHSOpFoV5ynZ3
	 6Xq2KpcnSZ1WVnkv4EZWZJ84aEpB5VitG6gsWFTWYsdQDNq7v0cpu6JPF6prOi6YQq
	 JJNUDm9HZpGkRux8Tc0omCROmIZfMPHajzy7Bt6sd1PPO2I+TKR8t5X9qnVNlVp8wg
	 iRcBtAfyKgayQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 03/14] i3c: master: Do not treat master device as a
 duplicate target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260807145638.168865-4-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:07:00 +0000
Message-Id: <20260807150701.DD3191F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
> device with the same PID as the reference device.  The search can match
> master->this, causing the controller itself to be returned as a
> duplicate.
>=20
> Since the controller is not a target device, it cannot be a duplicate of
> one.  Exclude master->this from matching so that the function only
> returns real duplicate target devices.
>=20
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D3

