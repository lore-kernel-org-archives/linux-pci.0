Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813082;
	b=buX6bug8hv05FsoYseY58gvv4nGDtQRYvIOnYHE+RAje3YGWG28gWXVxao8JFbsHt762
	 Z6A0W+w+Cl6xfZAgj6oCe9PYiUCPMF4yS+v5whQUASrAJiVLtg3aW4nwiLAMLqXAO5gl/
	 j1xEyKfmvikxTSG1lAUVh9Ww9HSi/Fl9IUqKnIFMkXPo6YHbwJtP8VCAyVKEvABTfHZRI
	 XOYgh6/Rma6BoYu0iMge8ogutf7T1/06GolaE1ozHxcGq527c623uoABHpLzcNY0ZEl2m
	 FGUsGjbjIIybcwKTz7rAJDH5yzUOGWxVpPK27vooTHx8cJ18HyOPWnD//iixO81883A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813082;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kl2rLWbji/nVhm9r5/b+CgT9jHrZIV8SLbA6nFzQ4CI=;
	b=pd8XG4GPRzRx1RVccgs/MF2kQMt7qrqeZ9LSSeqDHHebcdxgmCHsu7jgtAoF9bvePUak
	 tVKirbzVjit3H9fDl1ssObflwifcRAUOcWz8yLE4xHYdmmnLbq/21xdCaq7ZFzLpkBdEg
	 TqqL6/NrwOhq8qJQgm5fM5N6w6aaN4vffC8DRVHAmg523WyD2AXdzakV3Qvf3+o0PXQIR
	 BEu3E3SNnape6qioDbe8MNpiM/wIRyGIjcRrRyKhelY600EJJHyt1XVCKVzSVCeRqxitw
	 diGd3Z6ka0smBO/PYK4ylTBBWDxyZf/dqI/mskjdow55Q9RrSuxXX5gLuJ62DqdyWPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njtZer3G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F56606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njtZer3G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E2C1F000C8;
	Mon, 16 Nov 2026 07:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794813081;
	bh=Kl2rLWbji/nVhm9r5/b+CgT9jHrZIV8SLbA6nFzQ4CI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=njtZer3GUp0xcJzJ5EFBGa2cz6Dy7QfA3P/4YSY3NNQnaPl6BPQnT5hsxU0FhzDL/
	 +v9DneYN3DaWzdJKnd8+WdCWL/q9Sh/87EPESutouY/mSE+3UWJeKaw2Zm/ALPmvwU
	 HLfZ/GnrRDV+C3YBDPcA0l/yFM+LxvXNz5sGUYC3uqWQlh+QuJ9KdGCCKz3G6rnp2E
	 kJk2hQYjgFe0Sc8Vkf25KhvcTy1JzRzG+HvKWqqqqh+GssXuLQjSja0uUWWhhHffQZ
	 qGNDqVpJg5kama/AM6ZhvA3tRN7l50NN7UPlfWCCoMV8L7DXrRJ10CZeaw6WnUq9PR
	 RHI/5EsTdSQUA==
Message-ID: <sashiko-outbox-216392@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rockchip-host: Retry link bring-up on repeated
 Recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116-rockchip-pcie-resume-v2-1-a633e279be97@iav.lv>
References: <20261116-rockchip-pcie-resume-v2-1-a633e279be97@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:11:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> On Kobol Helios64 (RK3399 with a JMB585 at x2) about 3% of link
> bring-ups go bad. The LTSSM reaches L0 and then re-enters Recovery about
> every 200 us; the RC sees DLLPs about 300 times as often as on a good
> link, with no DLLP or CRC errors. The first config read behind the port
> gets no completion and aborts the CPU, or link training times out. The
> state survives Recovery, and a new bring-up of the port clears it.
>=20
> After the link comes up, poll the LTSSM for 5 ms and treat more than two
> entries into Recovery as a bad bring-up. The RC runs at 2.5 GT/s only,
> so no speed change goes through Recovery, and good bring-ups on the
> boards we tested showed no Recovery entries after L0. Bring the port up
> again, up to five tries in all with 500 ms between them, for this and
> for a training timeout. An empty slot stays in Detect, so a timeout
> there fails on the first try. If no try gives a usable link, probe and
> resume fail as they do on a training timeout today.
>=20
> Every link bring-up takes 5 ms longer. A link that stays bad delays the
> failure by 3 to 5 s.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rockchip-p=
cie-resume-v2-1-a633e279be97@iav.lv?part=3D1

