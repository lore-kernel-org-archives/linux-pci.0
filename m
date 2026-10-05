Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D048CD56
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207011; cv=none; b=jrPuMy/Qg/HoA8DlavpORacvBC7nM6KJ/Av8sUXQdnxlROSAcQwIFptk5NLifXwnAw9wVC2m0scCTJraICS39TU/76rFrPKEtHTL15u9Ag1OB17DdfCfrWwP91hu4MiawpV/3caUMjLmMYYatGu93ftOia4AIM4/2MBG8H4ZLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207011; c=relaxed/simple;
	bh=FTqKMAylXjfF2fqshVeCzYRnhDrYq84Jr96C5D2yQyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aNPPZ/mPyP5osH2oOGpEDZ/7+ISNWRL4+NJw2zkjZzEo4yZS9iDEtPYwqgS72VdxY1NTVZFac/2uzwffU4DGstl03yCkyfAC0Y9KpQO4l3Imi6AQNoSHCJyIz85XxqPH+Wbrn+5TzmcmGtXG2XTm5jMJb1moxShhUovZPPzI23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZybI73w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZybI73w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EEE1F00893;
	Mon,  5 Oct 2026 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207005;
	bh=zeSsoEe6T4xqqSAEswEgqsuIkBiBtbReZN3xc5IQV3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZybI73wjnS7mZnQ1lFzo8Rx/wgktU3MdkYgRL54Feu2jJBkHIyGyZLOoTiaizvSn
	 UzGNOqjZet1OiBDeXZexQmRrmiES+kcb/Wr7dN16i+fBRMAiMMwfqTTkfhqJYbOoqo
	 cjoS6deZfR6y5bLoEV7NrqwreyVo5+H6o8rJy9bAXx3osdyG4VGtGR9T3qo5wst8A8
	 P6gYh3rQDpsrFWxO4y1Hc5Ed1BdN33qaQacVpiZ1Z1DLPtNo9k6m5X5GrxZOCwdGiJ
	 t3BNzoGBV8ip7imITYMcOfNBSzsX0Xmv1Blvq8UmXZMB/7h0Y2QNscBULUoBF3aVsF
	 ydFPMD5jn+1Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel Haswell client host bridge to the
 whitelist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Scott Lee" <dsix123@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261005132651.18368-1-dsix123@gmail.com>
References: <20261005132651.18368-1-dsix123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:30:05 +0000
Message-Id: <20261005133005.A2EEE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> P2P DMA between two devices that do not share an upstream bridge is only
> permitted when the traffic goes through a host bridge that is listed in
> pci_p2pdma_whitelist[] with REQ_SAME_HOST_BRIDGE.
>=20
> The Haswell client host bridge (8086:0c08, e.g. H97/H87/B85) is not in th=
at
> list, and cpu_supports_p2pdma() returns false on Intel, so
> calc_map_type_and_dist() refuses P2P for any pair of devices behind
> different root ports of the same host bridge, even though that root compl=
ex
> handles the traffic correctly.
>=20
> Measured on an ASUS H97-PRO with a Xeon E3-1231 v3 (Haswell, 8086:0c08 at
> 00:00.0) and two GPUs on separate root ports of that host bridge
> (00:01.0 and 00:1c.4):
>=20
>   - pci_p2pdma_distance() < 0 before the change; peer access granted after
> [ ... ]
> pci_p2pdma_distance() all still apply. Tested on one board only, so the
> usual caveat applies - broad testing on other Haswell boards would be
> needed before this can be considered generally safe.
>=20
> Signed-off-by: Scott Lee <dsix123@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005132651.1836=
8-1-dsix123@gmail.com?part=3D1

