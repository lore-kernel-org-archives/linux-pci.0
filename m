Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016558;
	b=5NCE6KKUObU9rqq9xytA76tJXOpG8mvhVchsueBCs3lMCabDI7a7ReU2FfWtgcn9D74O
	 B7/MD+o/h9r6MBM+IEK+VWhHm0NG5NYBNgdZyxWdVUz3BELW+KP5iFs0DJ6/MpThfWmPe
	 kxrL+K22LqROMLp6VEpYfoRYmcbwf98lf9BsfwBw29IkbchD1Y4Km0ot85N7M/BzEcd3I
	 t4QU4aLTPoTQGdGUBv3AiXBNPseeU3CEPrz6bAFiac10RwXq1uOrWbr2G3/aCeKx39EAo
	 aVFn6FSujUOXe8+ITC+FIHis3yftioffxkPONpl+avhv+bbjfaWiI9DpHn8iFgfqdng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f79mBIKCIGkQ6VqD8hTposvFcba5Ya0v0WtcLBl3HiY=;
	b=1LmZPBO5IGQX9xAZByj/LI8xyvEJX/25RLeQ7sbnGYSNF+EAFGgrzfZYlf5+pcKvWHJn
	 UP+AHyE/08ojiGSBJ07uqvMiOj4hz4BNK8u/mE+WDWq4eKYizbSYEyoA6sHkH0plfEFmF
	 v/gi8Vsv4bb/giy8JDUK4ux3MVIVjjAN1OjiWQN7/vBu8uYBh3fsvCtPnE/UIXHym3+mr
	 XzUll3iCkgpcaYfWpmPHvRiqNaS+sLiL+aeigcc4ejVZfrJLma7ZztJfH0/xm2/8uKyQx
	 JxoFaoLj1/68L/6JuN/a0EAdrchG5xdbE6eiW3aFnoPh+ii9e1MWjg4g1SNWc2KhMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyLbGTP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699E606A32C
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyLbGTP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32101F0089F;
	Sat,  7 Nov 2026 01:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794016557;
	bh=f79mBIKCIGkQ6VqD8hTposvFcba5Ya0v0WtcLBl3HiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyLbGTP4G8S6VpiN8zDIlICNRCsSeG+BLM+J6d2yG/fgscjbUrGQHGV27ae3HXK4f
	 iFtfNR/VmwM9L5OERnBhsTx0JuPg0VQUrmFbXhAtSgRLX/85B4n1HHoXZJMeAF9esu
	 e+G5cyWmUI1KHVinAHArpzOBJuDc4/YiV9OXOveo0sFc4OoaDS6eGEsCPS2kVI8Z//
	 pXOkFZsu9Jo3qjbG3tHEzqF6bNQMAdCM5fGzC5fm/e2lX3yXEArJhc/xkig8by4cpR
	 wkAkXGpdxuG07eu9y13hQPUa3MYGEdqpXmtqy1cbmTv/BLw/tAZPBy6aImB8AiiecX
	 vIhVBMcVqe8zQ==
Message-ID: <sashiko-outbox-202468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107-shutdown-v8-2-bf607c6429b0@oss.qualcomm.com>
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
 <20261107-shutdown-v8-2-bf607c6429b0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 01:55:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
> to check whether every downstream endpoint can be put into D3cold before
> bothering to move the link to L2. If no endpoint supports it, the
> function returns early and leaves the link up.
>=20
> Querying D3cold support during shutdown is actively harmful, not just
> slow: pci_host_common_d3cold_possible() requires every active endpoint
> to already be in PCI_D3hot, and returns false otherwise. If any endpoint
> is still in D0 -- which is common, since endpoint drivers aren't
> guaranteed to have suspended by the time the host's shutdown path runs
> the check fails and dw_pcie_suspend_noirq() returns early without ever
> moving the link to L2, leaving it up right up to the point where the
> system cuts power/clocks to the controller.
>=20
> Add a force parameter to dw_pcie_suspend_noirq() that callers set
> explicitly to force this behavior, still call
> pci_host_common_d3cold_possible() unconditionally, since it's also how
> pme_capable gets set, but ignore its return value and force L2 entry
> regardless when force is set.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-shutdown-v=
8-0-bf607c6429b0@oss.qualcomm.com?part=3D2

