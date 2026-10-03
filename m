Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9437F339
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991233; cv=none; b=oqbHMwbRF8IG1dFVBYKHqbJbhrgPNH4K/LvRf/xf2143OdPvrzGIefNVuMHrAcDmm3K4nBRYzJiBlfJwzAp9ux87fhEQAjfYDJ8VfHiqBmPQt+7zPrbGI80NB9gtSriElQPPw6Y/zWvaSMQ78/c9lgmw2SNLUjRiYH30rJmAKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991233; c=relaxed/simple;
	bh=wXnKL+UDwnJRbnC7leHSOKKN3Zt2B2ofzp+E0UyxRF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+ElwAsIM3YhyAS4U6evD7BMVV6I0lvvFmyQlIvoBeiermZNgSc0cz3s6zyayBA4IXSocMcqdxFhr7BN4VuuI8B/jawsXYcdJErFJp4jbXVzJ7L2SZuV+H08wRRJ+3KKTYsXwSGVwN05JblSl5RRJ6RfFW0VrezJ6PFVn+BN4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV0YB934; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV0YB934"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076F01F00899;
	Sat,  3 Oct 2026 01:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991232;
	bh=Da3BEO9KsLueBBN2DERziDzqaJN0hVnaQ1xo5nUnQig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MV0YB934SKLxEodjutXJXQkniZE1wEHeRBhPWI7Cs+bWsdwzv3lFzk5tHj3WFXNI1
	 9U3GVGKYoFMVya4ycUHg37MTjZFYBo4FwM0KiOe5EP8dGYScTeo7eqgvhkjKAvbCLf
	 qMcjHw1kfePsfGVhJnX0jnmSt1T1jj0opagzB6IInEKKR51rSR90prqVMT+T8KKskc
	 h+o3wPlV/kY12jCOA6dGn5vyFx5XWKZpmL5Zzkm0kMNS+87tG99dK3S7weNLcTXWjs
	 e2Dqocwrw/8pO3v2JYvYFYvS3wqQ6+fW0LN7NyzScl0QrYnVDK64Ll/AHmCLLAsVL6
	 sSRjrA6KWabEA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] PCI: Add pci=hpreserve= to reserve memory
 windows for a hotplug bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Grochowski" <maciej.grochowski@sony.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002193111.51637-2-maciej.grochowski@sony.com>
References: <20261002193111.51637-1-maciej.grochowski@sony.com>
 <20261002193111.51637-2-maciej.grochowski@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:51 +0000
Message-Id: <20261003013352.076F01F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A hotplug bridge is sized for the devices that are present when its
> windows are sized, plus the optional hpmmiosize/hpmmioprefsize space.
> Some topologies have devices that are known to appear later.  After a
> reset of a two-level PCIe switch hierarchy, for example, pciehp
> re-enumerates the upstream switch before the link to the nested switch
> is back up, so the downstream port leading to the nested switch is
> sized with nothing below it.  When the nested switch appears, its BARs
> do not fit.
>=20
> On a two-level Microchip PM50052 (Switchtec PFX) hierarchy whose nested
> switch has an NTB function with a 1 GiB prefetchable BAR, a hard reset
> of the top-level switch on v7.3-rc2 leaves downstream port 82:03.0
> with a 206 MiB prefetchable window, an equal share of its
> parent's window.  The nested switch returns about 0.6 s later and
> fails:
> [ ... ]
>=20
> Without the parameter nothing changes.
>=20
> Tested-by: Maciej Grochowski <maciej.grochowski@sony.com>
> Signed-off-by: Maciej Grochowski <maciej.grochowski@sony.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002193111.5163=
7-1-maciej.grochowski@sony.com?part=3D1

